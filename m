Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9454496629
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 21:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiAUUHZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 15:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiAUUHY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 15:07:24 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C11C06173D
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 12:07:24 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i1so2545092ils.5
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 12:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cn0ivGwNdXd6i0Ws9/SfUIAhEOJW6kf3CMOx7g7/BIs=;
        b=b3+5gfyZcFKYNeDFnzoQGCCikvQFeRCpSGHD/egBJ0nZ7u6JBl7hvvQXyZvlC9CQLv
         YAZDkSZDiWuSWME5MnRIhYf+Xp7iHoJ3McgrvPnHSME6z9UFi8goGk2UmAxhkXj7mRtK
         Xcptd1UtoD7+95Y1SpmVAc7Y+nrB5LwxkcYNEHV+G9isoEIo+XPcq5yE2gtG3oBfl7mX
         ru9ZMKQas/2Yc2JIwRagt+ZFBLxa+1oZSmwncfCuFh/A5B92zGidKLrtuePArxdKh+Wu
         gN8bSB1W8l3RpU9xEVULp4eKVK31t6J71Gn7AaeK29zIWI/WfzmCMk3hfD/Z00IowiIh
         7JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cn0ivGwNdXd6i0Ws9/SfUIAhEOJW6kf3CMOx7g7/BIs=;
        b=riI6kgddvp+QbShpv9hZa94g8jdszqd+5VDxLRXnZs/ff9/roAbREp/c3Gb+NTiiSH
         4K/x0TSiakHzWmZfDUEB2pvl/OKA9dpehsRwiNZeOKteYbNcJVxx9szXF/zv4FRk9b/c
         4YtfwFEDNypbbOvQC3V6I2CH9jSWhpbGvy82+tqI+Sg1voWycnycR84rz9hdFdjGIQKN
         6sTTVmsNhrkWQM6SXQ+s2sHXEjFgerOdAFv91vbpvqjrl6hCcLR57N0b/MrEzgo/BcwR
         EwMpKqzHz3b1cKYkmibuam4/yhky2Lum6fs2nYMCJEIXaWafaGhWCUezR4N9BSJV7/Qc
         RZwQ==
X-Gm-Message-State: AOAM532ZdII8ARZY6uOwSH1Xj/kzH9i/2jBd62HmlD828DmW5SMrUZ/2
        XT5cde921g/GAgWuiy38Y+/cUKmzs3P/PfQ/z4M=
X-Google-Smtp-Source: ABdhPJzIBdn74Tbtw4ELrU8mTiZBhxAoDPM+sV3apojZF0/yea8zumU/z06knFZBbcnmUfOIcVaKefiR9gwYnQ+GjOU=
X-Received: by 2002:a92:db0b:: with SMTP id b11mr3110285iln.98.1642795643753;
 Fri, 21 Jan 2022 12:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220121193047.3225019-1-kennyyu@fb.com>
 <20220121193047.3225019-2-kennyyu@fb.com> <CAEf4BzYfQ4EbSa+c1-G0x_Zh4L6=TbutmH3qndTmv7wb2dAf1w@mail.gmail.com>
 <c8c18806-69ce-02f7-bb60-e2b2be30a809@fb.com>
In-Reply-To: <c8c18806-69ce-02f7-bb60-e2b2be30a809@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Jan 2022 12:07:12 -0800
Message-ID: <CAEf4BzbqP1os=mB-WjQNareKumQrGUeqVEw8f+WZwKxN3Kq77A@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/3] bpf: Add bpf_copy_from_user_task() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     Kenny Yu <kennyyu@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Gabriele <phoenix1987@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 12:04 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/21/22 11:53 AM, Andrii Nakryiko wrote:
> > On Fri, Jan 21, 2022 at 11:31 AM Kenny Yu <kennyyu@fb.com> wrote:
> >>
> >> This adds a helper for bpf programs to read the memory of other
> >> tasks. This also adds the ability for bpf iterator programs to
> >> be sleepable.
> >>
> >> This changes `bpf_iter_run_prog` to use the appropriate synchronization for
> >> sleepable bpf programs. With sleepable bpf iterator programs, we can no
> >> longer use `rcu_read_lock()` and must use `rcu_read_lock_trace()` instead
> >> to protect the bpf program.
> >>
> >> As an example use case at Meta, we are using a bpf task iterator program
> >> and this new helper to print C++ async stack traces for all threads of
> >> a given process.
> >>
> >> Signed-off-by: Kenny Yu <kennyyu@fb.com>
> >> ---
> >>   include/linux/bpf.h            |  1 +
> >>   include/uapi/linux/bpf.h       | 10 ++++++++++
> >>   kernel/bpf/bpf_iter.c          | 20 ++++++++++++++-----
> >>   kernel/bpf/helpers.c           | 35 ++++++++++++++++++++++++++++++++++
> >>   kernel/trace/bpf_trace.c       |  2 ++
> >>   tools/include/uapi/linux/bpf.h | 10 ++++++++++
> >>   6 files changed, 73 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index 80e3387ea3af..5917883e528b 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -2229,6 +2229,7 @@ extern const struct bpf_func_proto bpf_kallsyms_lookup_name_proto;
> >>   extern const struct bpf_func_proto bpf_find_vma_proto;
> >>   extern const struct bpf_func_proto bpf_loop_proto;
> >>   extern const struct bpf_func_proto bpf_strncmp_proto;
> >> +extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
> >>
> >>   const struct bpf_func_proto *tracing_prog_func_proto(
> >>     enum bpf_func_id func_id, const struct bpf_prog *prog);
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index fe2272defcd9..d82d9423874d 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -5049,6 +5049,15 @@ union bpf_attr {
> >>    *             This helper is currently supported by cgroup programs only.
> >>    *     Return
> >>    *             0 on success, or a negative error in case of failure.
> >> + *
> >> + * long bpf_copy_from_user_task(void *dst, u32 size, const void *user_ptr, struct task_struct *tsk, u64 flags)
> >> + *     Description
> >> + *             Read *size* bytes from user space address *user_ptr* in *tsk*'s
> >> + *             address space, and stores the data in *dst*. *flags* is not
> >> + *             used yet and is provided for future extensibility. This helper
> >> + *             can only be used by sleepable programs.
> >
> > "On error dst buffer is zeroed out."? This is an explicit guarantee.
> >
> >> + *     Return
> >> + *             0 on success, or a negative error in case of failure.
> >>    */
> >>   #define __BPF_FUNC_MAPPER(FN)          \
> >>          FN(unspec),                     \
> >> @@ -5239,6 +5248,7 @@ union bpf_attr {
> >>          FN(get_func_arg_cnt),           \
> >>          FN(get_retval),                 \
> >>          FN(set_retval),                 \
> >> +       FN(copy_from_user_task),        \
> >>          /* */
> >>
> >>   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> >> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> >> index b7aef5b3416d..110029ede71e 100644
> >> --- a/kernel/bpf/bpf_iter.c
> >> +++ b/kernel/bpf/bpf_iter.c
> >> @@ -5,6 +5,7 @@
> >>   #include <linux/anon_inodes.h>
> >>   #include <linux/filter.h>
> >>   #include <linux/bpf.h>
> >> +#include <linux/rcupdate_trace.h>
> >>
> >>   struct bpf_iter_target_info {
> >>          struct list_head list;
> >> @@ -684,11 +685,20 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
> >>   {
> >>          int ret;
> >>
> >> -       rcu_read_lock();
> >> -       migrate_disable();
> >> -       ret = bpf_prog_run(prog, ctx);
> >> -       migrate_enable();
> >> -       rcu_read_unlock();
> >> +       if (prog->aux->sleepable) {
> >> +               rcu_read_lock_trace();
> >> +               migrate_disable();
> >> +               might_fault();
> >> +               ret = bpf_prog_run(prog, ctx);
> >> +               migrate_enable();
> >> +               rcu_read_unlock_trace();
> >> +       } else {
> >> +               rcu_read_lock();
> >> +               migrate_disable();
> >> +               ret = bpf_prog_run(prog, ctx);
> >> +               migrate_enable();
> >> +               rcu_read_unlock();
> >> +       }
> >>
> >
> > I think this sleepable bpf_iter change deserves its own patch. It has
> > nothing to do with bpf_copy_from_user_task() helper.
>
> Without the above change, using bpf_copy_from_user_task() will trigger
> rcu warning and may produce incorrect result. One option is to put
> the above in a preparation patch before introducing
> bpf_copy_from_user_task() so we won't have bisecting issues.

Sure, patch #1 for sleepable bpf_iter, patch #2 for the helper? I
mean, it's not a big deal, but both seem to deserve their own focused
patches.

>
> >
> >>          /* bpf program can only return 0 or 1:
> >>           *  0 : okay
> [...]
