Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24507424CF6
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 07:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhJGGBJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 02:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240206AbhJGGBH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 02:01:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59CF361248
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 05:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633586354;
        bh=FsAjCNJQSMrqczS+hb6ReAb/lLJbQEpMBKERvMDSb5g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ix3IReO3HkTa3E/nGwpsK44ivG1X8V7c6t9G0zp8V6DxuM5WkMqEmaGKnv7CenwtW
         TZX1s+QImR2qMeBLyIpjR3bSeTp5EMiYai4BopGwQG5CCEG5HrMRoBDYbviiU4vdvX
         zwyhtZ3EdOWINtmV5gYjCSN6idQY8/VzjsCzpJ++GJOPMtnqaYcdljgQoSENlqjq4w
         Zcn5L6oUc1HW9uLCaK997X8r1/r4vB/RSbN1ev2fHNOjc0w3OyIM4vtRw3JaxcIxzw
         F1rXAsFPeFfST5lck3Qv8VjnlTBLWumeTmk3c5yVHv5qYRae3CkNxpRUQ734SL1/sS
         lEN0ZHewdNVuQ==
Received: by mail-lf1-f49.google.com with SMTP id u18so19800204lfd.12
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 22:59:14 -0700 (PDT)
X-Gm-Message-State: AOAM531zWoYLUtbka1dAbH6xxNkJkwM/mCsP97YiMpxdk7JltVcfehLy
        Y3v3+aIGPFJkLHs4C+rK9Wx0FSAW/lc9j9ss7ng=
X-Google-Smtp-Source: ABdhPJwDeNxoBnWz9yDiwlOj9Y05rj4qC9mqa0FE58pVN/ew+CM+HvO/qmUKtVADHU7rHtIWyL3zFD+976DUF72ThyA=
X-Received: by 2002:ac2:5582:: with SMTP id v2mr2421381lfg.143.1633586352708;
 Wed, 06 Oct 2021 22:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
 <CAPhsuW4UaidSZXj4-L9t4Ez9TjzoXR6yQvwn_7LC87hYmJbtFw@mail.gmail.com>
In-Reply-To: <CAPhsuW4UaidSZXj4-L9t4Ez9TjzoXR6yQvwn_7LC87hYmJbtFw@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 6 Oct 2021 22:59:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5aAq9wA+PsunL0hGKiZc_BTLWjOPpOjYUyADc0+BZCAg@mail.gmail.com>
Message-ID: <CAPhsuW5aAq9wA+PsunL0hGKiZc_BTLWjOPpOjYUyADc0+BZCAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add cgroup helper bpf_export_errno to
 get/set exported errno value
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 5:41 PM Song Liu <song@kernel.org> wrote:
>
> On Wed, Oct 6, 2021 at 9:04 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> >
> > From: YiFei Zhu <zhuyifei@google.com>
> >
> > When passed in a positive errno, it sets the errno and returns 0.
> > When passed in 0, it gets the previously set errno. When passed in
> > an out of bound number, it returns -EINVAL. This is unambiguous:
> > negative return values are error in invoking the helper itself,
> > and positive return values are errnos being exported. Errnos once
> > set cannot be unset, but can be overridden.
> >
> > The errno value is stored inside bpf_cg_run_ctx for ease of access
> > different prog types with different context structs layouts. The
> > helper implementation can simply perform a container_of from
> > current->bpf_ctx to retrieve bpf_cg_run_ctx.
> >
> > For backward compatibility, if a program rejects without calling
> > the helper, and the errno has not been set by any prior progs, the
> > BPF_PROG_RUN_ARRAY_CG family macros automatically set the errno to
> > EPERM. If a prog sets an errno but returns 1 (allow), the outcome
> > is considered implementation-defined. This patch treat it the same
> > way as if 0 (reject) is returned.
> >
> > For BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY, the prior behavior is
> > that, if the return value is NET_XMIT_DROP, the packet is silently
> > dropped. We preserve this behavior for backward compatibility
> > reasons, so even if an errno is set, the errno does not return to
> > caller.
> >
> > For getsockopt hooks, they are different in that bpf progs runs
> > after kernel processes the getsockopt syscall instead of before.
> > There is also a retval in its context struct in which bpf progs
> > can unset the retval, and can force an -EPERM by returning 0.
> > We preseve the same semantics. Even though there is retval,
> > that value can only be unset, while progs can set (and not unset)
> > additional errno by using the helper, and that will override
> > whatever is in retval.
> >
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > Reviewed-by: Stanislav Fomichev <sdf@google.com>
>
> This is pretty complicated, but the logic looks all correct. Thus,
>
> Acked-by: Song Liu <songliubraving@fb.com>
>
> One question, if the program want to retrieve existing errno_val, and
> set a different one, it needs to call the helper twice, right? I guess it
> is possible to do that in one call with a "swap" logic. Would this work?

Actually, how about we split this into two helpers:bpf_set_errno() and
bpf_get_errno(). This should avoid some confusion in long term.

Thanks,
Song
