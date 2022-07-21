Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2970057CA23
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 13:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiGUL7W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 07:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGUL7V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 07:59:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202963340B;
        Thu, 21 Jul 2022 04:59:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBC97B82443;
        Thu, 21 Jul 2022 11:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806D0C3411E;
        Thu, 21 Jul 2022 11:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658404757;
        bh=ggHG6nD7013O5l8BLxi1J8dB0HMzHRPWFaAq8WtsKf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k0VzyS05s/qO/GLUCmqIQcQ620cwKH/qf1ycY0IbyfQgiucVn/Hz30Epfdg1TfTWC
         JfqKANjEkZt09LBApojiFDRMWD4s3kgce7EBKKZrErkyI0RPpZshbQwHdV1pNon8yF
         9YIUeH15Qv2QGquouDjOCVT65dVFa9FIFYK8AsDZ5/GMSZy5nY5ZDuHSqZvt3NxVqt
         loMecXcx5znRYvXg7hCRoYYPHrmyq+Sjeq9oK+lDhq26hEa36aiIhjWrNx/HAwMyp9
         bpnyJ8BaC5tCb1JcDmZDuGTFxR/Zu39/0bifRl/gRTUCa0Da5kMhXi8QyHsBrbPK4Z
         fE/Mkn4Lvvymw==
Date:   Thu, 21 Jul 2022 12:59:09 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/1] bpf: Drop unprotected find_vpid() in favour of
 find_get_pid()
Message-ID: <Ytk/jT+zyNZpafgn@google.com>
References: <20220721111430.416305-1-lee@kernel.org>
 <Ytk+/npvvDGg9pBP@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ytk+/npvvDGg9pBP@krava>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 21 Jul 2022, Jiri Olsa wrote:

> On Thu, Jul 21, 2022 at 12:14:30PM +0100, Lee Jones wrote:
> > The documentation for find_pid() clearly states:
> > 
> >   "Must be called with the tasklist_lock or rcu_read_lock() held."
> > 
> > Presently we do neither.
> > 
> > In an ideal world we would wrap the in-lined call to find_vpid() along
> > with get_pid_task() in the suggested rcu_read_lock() and have done.
> > However, looking at get_pid_task()'s internals, it already does that
> > independently, so this would lead to deadlock.
> 
> hm, we can have nested rcu_read_lock calls, right?

I assumed not, but that might be an oversight on my part.

Would that be your preference?

> > Instead, we'll use find_get_pid() which searches for the vpid, then
> > takes a reference to it preventing early free, all within the safety
> > of rcu_read_lock().  Once we have our reference we can safely make use
> > of it up until the point it is put.
> > 
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: bpf@vger.kernel.org
> > Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  kernel/bpf/syscall.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 83c7136c5788d..c20cff30581c4 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -4385,6 +4385,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
> >  	const struct perf_event *event;
> >  	struct task_struct *task;
> >  	struct file *file;
> > +	struct pid *ppid;
> >  	int err;
> >  
> >  	if (CHECK_ATTR(BPF_TASK_FD_QUERY))
> > @@ -4396,7 +4397,9 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
> >  	if (attr->task_fd_query.flags != 0)
> >  		return -EINVAL;
> >  
> > -	task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
> > +	ppid = find_get_pid(pid);
> > +	task = get_pid_task(ppid, PIDTYPE_PID);
> > +	put_pid(ppid);
> >  	if (!task)
> >  		return -ENOENT;
> >  

-- 
Lee Jones [李琼斯]
