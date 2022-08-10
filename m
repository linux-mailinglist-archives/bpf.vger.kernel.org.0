Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B9F58EAE3
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiHJLDo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 07:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiHJLDn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 07:03:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F606C129;
        Wed, 10 Aug 2022 04:03:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F07AFB818E4;
        Wed, 10 Aug 2022 11:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB177C433D6;
        Wed, 10 Aug 2022 11:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660129419;
        bh=gh8+q+3SCgVT0ty48TCgdbOn9Aa4aYJYb6QYSM/vEZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmOdiUHsBj7m5zUaHK8f0Hgghk3YeOujaPK0T3iTaOTio2UU4C9M4Y3pvcdwYf6Yq
         /t6R2iHFSM3BTNd6rRhxlwYI/tIyt/sAKeftu+9XwndUf0FB5QC7r6eMuuaKRTCI4w
         IVjxq9g6nWIjwivit0lr2f1xSAxDoB2KrNrEwGTFOFOuxXExjLzR7o0kEcfqlc0811
         FtuoeWUg/yWNMOhNC8cs0aA69a9C+ymhGRafeZGwjl0VG/Oe9XdNiejky08n3yXI2C
         i1zq8GJXkr4P7AIMi2zp+rECdATDELvU7CFmPE39WyeetZLcP8HnvAK+rqAs5GMuCD
         6xTqNA5HlSXdQ==
Date:   Wed, 10 Aug 2022 12:03:33 +0100
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
Message-ID: <YvOQhTUD1x6W0ozO@google.com>
References: <20220803134821.425334-1-lee@kernel.org>
 <CAADnVQ+X_B4LC6CtYM1PXPA4BBprWLj5Qip--Eeu32Zti==Ydw@mail.gmail.com>
 <YvIDmku4us2SSBKu@google.com>
 <CAADnVQ+5eq3qQTgHH6nDdVM-n1i4TWkZ35Ou8TDMi3MqGzm63w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+5eq3qQTgHH6nDdVM-n1i4TWkZ35Ou8TDMi3MqGzm63w@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 09 Aug 2022, Alexei Starovoitov wrote:

> On Mon, Aug 8, 2022 at 11:50 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Thu, 04 Aug 2022, Alexei Starovoitov wrote:
> >
> > > On Wed, Aug 3, 2022 at 6:48 AM Lee Jones <lee@kernel.org> wrote:
> > > >
> > > > The documentation for find_pid() clearly states:
> > > >
> > > >   "Must be called with the tasklist_lock or rcu_read_lock() held."
> > > >
> > > > Presently we do neither.
> > > >
> > > > Let's use find_get_pid() which searches for the vpid, then takes a
> > > > reference to it preventing early free, all within the safety of
> > > > rcu_read_lock().  Once we have our reference we can safely make use of
> > > > it up until the point it is put.
> > > >
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > > > Cc: Song Liu <song@kernel.org>
> > > > Cc: Yonghong Song <yhs@fb.com>
> > > > Cc: KP Singh <kpsingh@kernel.org>
> > > > Cc: Stanislav Fomichev <sdf@google.com>
> > > > Cc: Hao Luo <haoluo@google.com>
> > > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > > Cc: bpf@vger.kernel.org
> > > > Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > ---
> > > >
> > > > v1 => v2:
> > > >   * Commit log update - no code differences
> > > >
> > > >  kernel/bpf/syscall.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > index 83c7136c5788d..c20cff30581c4 100644
> > > > --- a/kernel/bpf/syscall.c
> > > > +++ b/kernel/bpf/syscall.c
> > > > @@ -4385,6 +4385,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
> > > >         const struct perf_event *event;
> > > >         struct task_struct *task;
> > > >         struct file *file;
> > > > +       struct pid *ppid;
> > > >         int err;
> > > >
> > > >         if (CHECK_ATTR(BPF_TASK_FD_QUERY))
> > > > @@ -4396,7 +4397,9 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
> > > >         if (attr->task_fd_query.flags != 0)
> > > >                 return -EINVAL;
> > > >
> > > > -       task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
> > > > +       ppid = find_get_pid(pid);
> > > > +       task = get_pid_task(ppid, PIDTYPE_PID);
> > > > +       put_pid(ppid);
> > >
> > > rcu_read_lock/unlock around this line
> > > would be a cheaper and faster alternative than pid's
> > > refcount inc/dec.
> >
> > This was already discussed here:
> >
> > https://lore.kernel.org/all/YtsFT1yFtb7UW2Xu@krava/
> 
> Since several people thought about rcu_read_lock instead of your
> approach it means that it's preferred.
> Sooner or later somebody will send a patch to optimize
> refcnt into rcu_read_lock.
> So let's avoid the churn and do it now.

I'm not wed to either approach.  Please discuss it with Yonghong and
Jiri and I'll do whatever is agreed upon.

-- 
Lee Jones [李琼斯]
