Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4D42564C
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 17:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbhJGPM6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242261AbhJGPM5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 11:12:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F61C061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 08:11:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f8-20020a2585480000b02905937897e3daso8356161ybn.2
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pHLQmAq7fCw+0u+/ZiE+FfE77mwXqc0ikxj4VYw4th8=;
        b=EuXzaOwK6zZ3Ka8XBtia0ZDEKWP/1ML0C/HtIZWpsODUz/FDBXnHQyyc71L6H1CdWX
         /md1Z7Qx3kGdXsgxRgZmNq+J8CIpi935UtkCkX/e3KtXIkNhm2lCZpc+lMSwx2PTOykr
         SzoUshNiDXm3OLpeetYIaIU7ma3igxgLqSzjNubzwbxfx3OEhnE3Ni8NldtEgL7qKtnk
         DaBqG8iCATJJ2lQTExK4SmQsWk3Mt75MR7GTE7xL5Bllwv+HFX4jBrMvAuLlzgPU8QJH
         uHLX9zqlbIn5UUaweh8wUENi3aHfnLZY6Lqq9TtXJGuYWvo0VzDg5mY6r5fA/U8+/5O/
         fT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pHLQmAq7fCw+0u+/ZiE+FfE77mwXqc0ikxj4VYw4th8=;
        b=eBHqiQrAxzGFDwRqgM2xw2t5as/KHtZjr6NqRqTFvxrxkGWgoz5tVIJSIM9EXPtzF+
         CWWjuzFNlWQv4nYNMOJqoKg7mG/FScZv8RrFQGHbN3n7mcur5dPFDf7V1wead0Mn+d1F
         WmuQzSn05Hxekk0O076XG4s+ppPCiWJlm4NW6/X0cuoUTkf+Al5GXRHBp3+z0oAdyiw+
         Zt+3+emyN+5sFpmG5uV+4e/P1WhuzLKLUz4vLH/fXVdcVq8ZA5SKfPvrC8qG2AZS1vE8
         vM6FxY32U+L/bCCjpOU2IiYw5I3EqB0lfWv8HGw7WeH5d6NjeIVfSavzD89oZAZri27t
         uYow==
X-Gm-Message-State: AOAM532mUOS8Ztas7D2b+kqC3OnVmiqRBMxE6YyHrtWCL+6JlaLgNxJF
        fkHnbdHl8gxYeREPoJc0yaTD6lc=
X-Google-Smtp-Source: ABdhPJwq87nYvJLanZWd7afKJdIizkyitKHBKo4o4jJzX4hcX58LTVVjct+nYckcJRegfsDbkxHppFY=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:4eb5:6701:ac67:2ca1])
 (user=sdf job=sendgmr) by 2002:a25:b7c6:: with SMTP id u6mr5084277ybj.16.1633619463315;
 Thu, 07 Oct 2021 08:11:03 -0700 (PDT)
Date:   Thu, 7 Oct 2021 08:11:00 -0700
In-Reply-To: <CAPhsuW5aAq9wA+PsunL0hGKiZc_BTLWjOPpOjYUyADc0+BZCAg@mail.gmail.com>
Message-Id: <YV8OBHd4/gdZ6tu3@google.com>
Mime-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
 <CAPhsuW4UaidSZXj4-L9t4Ez9TjzoXR6yQvwn_7LC87hYmJbtFw@mail.gmail.com> <CAPhsuW5aAq9wA+PsunL0hGKiZc_BTLWjOPpOjYUyADc0+BZCAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add cgroup helper bpf_export_errno to
 get/set exported errno value
From:   sdf@google.com
To:     Song Liu <song@kernel.org>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/06, Song Liu wrote:
> On Wed, Oct 6, 2021 at 5:41 PM Song Liu <song@kernel.org> wrote:
> >
> > On Wed, Oct 6, 2021 at 9:04 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > >
> > > From: YiFei Zhu <zhuyifei@google.com>
> > >
> > > When passed in a positive errno, it sets the errno and returns 0.
> > > When passed in 0, it gets the previously set errno. When passed in
> > > an out of bound number, it returns -EINVAL. This is unambiguous:
> > > negative return values are error in invoking the helper itself,
> > > and positive return values are errnos being exported. Errnos once
> > > set cannot be unset, but can be overridden.
> > >
> > > The errno value is stored inside bpf_cg_run_ctx for ease of access
> > > different prog types with different context structs layouts. The
> > > helper implementation can simply perform a container_of from
> > > current->bpf_ctx to retrieve bpf_cg_run_ctx.
> > >
> > > For backward compatibility, if a program rejects without calling
> > > the helper, and the errno has not been set by any prior progs, the
> > > BPF_PROG_RUN_ARRAY_CG family macros automatically set the errno to
> > > EPERM. If a prog sets an errno but returns 1 (allow), the outcome
> > > is considered implementation-defined. This patch treat it the same
> > > way as if 0 (reject) is returned.
> > >
> > > For BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY, the prior behavior is
> > > that, if the return value is NET_XMIT_DROP, the packet is silently
> > > dropped. We preserve this behavior for backward compatibility
> > > reasons, so even if an errno is set, the errno does not return to
> > > caller.
> > >
> > > For getsockopt hooks, they are different in that bpf progs runs
> > > after kernel processes the getsockopt syscall instead of before.
> > > There is also a retval in its context struct in which bpf progs
> > > can unset the retval, and can force an -EPERM by returning 0.
> > > We preseve the same semantics. Even though there is retval,
> > > that value can only be unset, while progs can set (and not unset)
> > > additional errno by using the helper, and that will override
> > > whatever is in retval.
> > >
> > > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > > Reviewed-by: Stanislav Fomichev <sdf@google.com>
> >
> > This is pretty complicated, but the logic looks all correct. Thus,
> >
> > Acked-by: Song Liu <songliubraving@fb.com>
> >
> > One question, if the program want to retrieve existing errno_val, and
> > set a different one, it needs to call the helper twice, right? I guess  
> it
> > is possible to do that in one call with a "swap" logic. Would this work?

> Actually, how about we split this into two helpers:bpf_set_errno() and
> bpf_get_errno(). This should avoid some confusion in long term.

We've agreed on the single helper during bpf office hours (about 2 weeks
ago), but we can do two, I don't think it matters that much.
