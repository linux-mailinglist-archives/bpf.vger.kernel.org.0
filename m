Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1765758D403
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 08:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiHIGuM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 02:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHIGuL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 02:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E61F2C4;
        Mon,  8 Aug 2022 23:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 425A261218;
        Tue,  9 Aug 2022 06:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ECEC433C1;
        Tue,  9 Aug 2022 06:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660027809;
        bh=ynJyKQ66METpJqPUjWfrzqF4JjlT26+ei9p1vjSEDTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iIr5JmbCbVbcJ6eGv8iS/D+qITb4OE5u3y5124+JdEU0NdfQMGYYx93fRc8U9dEw7
         vKPsO0mHX7pWGitYMqbgeHi1IaWXkc1J4I4zpMUJYZg1T8IWq4QJbmiJwylmIY5RUY
         frxbvpxxZzliB8m1wrr7FffbnjhnfWlCrhOtQKgyN+rfWRYrF8HNJ6CH5eWbo0iLVd
         kfSJoS4jPAdy4GMv/0OXlUZQNF+Eedk1DOagWNqqtObYNqFUf+5KwyS1x7cd7jJmUC
         JrLHhd5GZDka1CbOUaMbgFDrjsVkN3ML+OWDyEXqwUDeAQIKSKGdP/H9wKc/ej/+wa
         N7WFOY/dS2+lw==
Date:   Tue, 9 Aug 2022 07:50:02 +0100
From:   Lee Jones <lee@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] bpf: Drop unprotected find_vpid() in favour of
 find_get_pid()
Message-ID: <YvIDmku4us2SSBKu@google.com>
References: <20220803134821.425334-1-lee@kernel.org>
 <CAADnVQ+X_B4LC6CtYM1PXPA4BBprWLj5Qip--Eeu32Zti==Ydw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+X_B4LC6CtYM1PXPA4BBprWLj5Qip--Eeu32Zti==Ydw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 04 Aug 2022, Alexei Starovoitov wrote:

> On Wed, Aug 3, 2022 at 6:48 AM Lee Jones <lee@kernel.org> wrote:
> >
> > The documentation for find_pid() clearly states:
> >
> >   "Must be called with the tasklist_lock or rcu_read_lock() held."
> >
> > Presently we do neither.
> >
> > Let's use find_get_pid() which searches for the vpid, then takes a
> > reference to it preventing early free, all within the safety of
> > rcu_read_lock().  Once we have our reference we can safely make use of
> > it up until the point it is put.
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
> >
> > v1 => v2:
> >   * Commit log update - no code differences
> >
> >  kernel/bpf/syscall.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 83c7136c5788d..c20cff30581c4 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -4385,6 +4385,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
> >         const struct perf_event *event;
> >         struct task_struct *task;
> >         struct file *file;
> > +       struct pid *ppid;
> >         int err;
> >
> >         if (CHECK_ATTR(BPF_TASK_FD_QUERY))
> > @@ -4396,7 +4397,9 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
> >         if (attr->task_fd_query.flags != 0)
> >                 return -EINVAL;
> >
> > -       task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
> > +       ppid = find_get_pid(pid);
> > +       task = get_pid_task(ppid, PIDTYPE_PID);
> > +       put_pid(ppid);
> 
> rcu_read_lock/unlock around this line
> would be a cheaper and faster alternative than pid's
> refcount inc/dec.

This was already discussed here:

https://lore.kernel.org/all/YtsFT1yFtb7UW2Xu@krava/

-- 
Lee Jones [李琼斯]
