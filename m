Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070CC4257D8
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbhJGQZq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 12:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbhJGQZp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 12:25:45 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C19C061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 09:23:51 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id 66so7332301vsd.11
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OVziCYjV+ACZEgZS0PyhXtwWc70XzVOp5ypqiMJ9qA8=;
        b=szvPcELxRaJbX6og0z0g6GjYzvhQqqfgKSrZWGh1dCiGivm0lK90wmB32VgodJfYdy
         fFY73dyTlRKmC+tL/t6uNoKN77t2norimMvp8dTDQ91/rOGRoO9FfDY5KcKiwOR1o4gc
         0GeVARBIQN+FGdDxj4NWpqtr6A/p4kkVx1jdT5HWU+lrX3eW3qiP5+W6KqYuis7x2GpA
         glWzoMwL8Pb62ezpV2n2zZX14K+4mSnVxZXQL0F/kTDtb23b+w9fKFEHpDSatOrzGadI
         jBKpgAz77BtoK8YMfjjyMKq4QWPyMPOI2mJTgr74QvU5dFPfRShRj5OxGmC5gIh6aH/3
         Hwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVziCYjV+ACZEgZS0PyhXtwWc70XzVOp5ypqiMJ9qA8=;
        b=4gS83jSxcLUpEr0xEvknGmmpwCsgU0yl/8biMKZdvzzr3nC0b84wkST0/RjgNZrQnO
         g8fx7Wx6g0qneZo663PDVKWIl052k7RnRR+LmAG8SDe8/8cmo3swEwzTLQqtKPz7/2Et
         CmzgqewssRCpuUP5AeL49Gg/ONp3igiHAYC7pihZFFTFLMVb9Xi7OrvdGO4EWODvhd1O
         HKtKcAtUDWiAIAv/UHAnym32wZthcUdEaimVcn4R0byuIJtdaLimv8fSxLnPLsFO5k4h
         8Qhys8R55tyK7uU3WNvpvJNtFylQMFAMrY2aHV054cPSlcLtRe5YD+UIe3/etOLwmbGt
         F/ug==
X-Gm-Message-State: AOAM531psxQydcDbJtgzTDhRUsywuqBgPBUftazwP+R6ZT01fY+ldZfy
        01FYhE6yjYJvTLpOajYUZtkHhamCVfz0DzvcLlrCEQ==
X-Google-Smtp-Source: ABdhPJw3QXKy1YhObFEvPo+3vdmxbL3X5Xj5g3GH2u5O5zTgQSIwhzmtazjPC7zsHzwgWR2j2AHkfAKQDZEqAIE3mTA=
X-Received: by 2002:a67:e159:: with SMTP id o25mr5470611vsl.44.1633623830760;
 Thu, 07 Oct 2021 09:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
 <CAPhsuW4UaidSZXj4-L9t4Ez9TjzoXR6yQvwn_7LC87hYmJbtFw@mail.gmail.com>
 <CAPhsuW5aAq9wA+PsunL0hGKiZc_BTLWjOPpOjYUyADc0+BZCAg@mail.gmail.com> <YV8OBHd4/gdZ6tu3@google.com>
In-Reply-To: <YV8OBHd4/gdZ6tu3@google.com>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Thu, 7 Oct 2021 09:23:40 -0700
Message-ID: <CAA-VZPkSGJC0akTFrfUduAn0zd0sjq8+bMHkyOsuiH5zXo5TeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add cgroup helper bpf_export_errno to
 get/set exported errno value
To:     sdf@google.com
Cc:     Song Liu <song@kernel.org>, YiFei Zhu <zhuyifei1999@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yeah it felt like we only needed one helper for the parameters and
return values to be unambiguous. But if two better avoid confusion for
users, we can do that.

YiFei Zhu

On Thu, Oct 7, 2021 at 8:11 AM <sdf@google.com> wrote:
>
> On 10/06, Song Liu wrote:
> > On Wed, Oct 6, 2021 at 5:41 PM Song Liu <song@kernel.org> wrote:
> > >
> > > On Wed, Oct 6, 2021 at 9:04 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > > >
> > > > From: YiFei Zhu <zhuyifei@google.com>
> > > >
> > > > When passed in a positive errno, it sets the errno and returns 0.
> > > > When passed in 0, it gets the previously set errno. When passed in
> > > > an out of bound number, it returns -EINVAL. This is unambiguous:
> > > > negative return values are error in invoking the helper itself,
> > > > and positive return values are errnos being exported. Errnos once
> > > > set cannot be unset, but can be overridden.
> > > >
> > > > The errno value is stored inside bpf_cg_run_ctx for ease of access
> > > > different prog types with different context structs layouts. The
> > > > helper implementation can simply perform a container_of from
> > > > current->bpf_ctx to retrieve bpf_cg_run_ctx.
> > > >
> > > > For backward compatibility, if a program rejects without calling
> > > > the helper, and the errno has not been set by any prior progs, the
> > > > BPF_PROG_RUN_ARRAY_CG family macros automatically set the errno to
> > > > EPERM. If a prog sets an errno but returns 1 (allow), the outcome
> > > > is considered implementation-defined. This patch treat it the same
> > > > way as if 0 (reject) is returned.
> > > >
> > > > For BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY, the prior behavior is
> > > > that, if the return value is NET_XMIT_DROP, the packet is silently
> > > > dropped. We preserve this behavior for backward compatibility
> > > > reasons, so even if an errno is set, the errno does not return to
> > > > caller.
> > > >
> > > > For getsockopt hooks, they are different in that bpf progs runs
> > > > after kernel processes the getsockopt syscall instead of before.
> > > > There is also a retval in its context struct in which bpf progs
> > > > can unset the retval, and can force an -EPERM by returning 0.
> > > > We preseve the same semantics. Even though there is retval,
> > > > that value can only be unset, while progs can set (and not unset)
> > > > additional errno by using the helper, and that will override
> > > > whatever is in retval.
> > > >
> > > > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > > > Reviewed-by: Stanislav Fomichev <sdf@google.com>
> > >
> > > This is pretty complicated, but the logic looks all correct. Thus,
> > >
> > > Acked-by: Song Liu <songliubraving@fb.com>
> > >
> > > One question, if the program want to retrieve existing errno_val, and
> > > set a different one, it needs to call the helper twice, right? I guess
> > it
> > > is possible to do that in one call with a "swap" logic. Would this work?
>
> > Actually, how about we split this into two helpers:bpf_set_errno() and
> > bpf_get_errno(). This should avoid some confusion in long term.
>
> We've agreed on the single helper during bpf office hours (about 2 weeks
> ago), but we can do two, I don't think it matters that much.
