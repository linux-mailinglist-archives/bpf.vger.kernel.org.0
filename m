Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC4F3C1A7E
	for <lists+bpf@lfdr.de>; Thu,  8 Jul 2021 22:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhGHUXh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Jul 2021 16:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhGHUXh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Jul 2021 16:23:37 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B83AC061574
        for <bpf@vger.kernel.org>; Thu,  8 Jul 2021 13:20:55 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g5so10954419ybu.10
        for <bpf@vger.kernel.org>; Thu, 08 Jul 2021 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnhlmlSRLnPaMTK56lFS9UcseMDYyt/e2JSVZnLtYFE=;
        b=enocmBjXeEZHE4e0QX2GTY24zCLjwMWfm6jt7l0EJgKCgSLaSpzNTqi37L/JJ990we
         w8EdVUBoawaena8bxwkzA+P+TbZBlbq3EWrHTW8h+Xk7tu6TqjPRbi++kC8uXzHhLVan
         vIBnR70E7dj1S70wlsCX3xKtL9IEWgcYTXwC2E0ao6c8Cp1rRX/Aj/Q6JaLThU6w1P/f
         u/QtbPGfaP6CNTFL0gZ2yeHVOPABJ0a7n5YXnI0e8Q+4qD6F2eetTfeaUC8kERnwuZAb
         35G24U1PLLAqT0mVGMBEA2H7nDItPOterd9/KAUgK5bc06JrjwlslwqMsCZjqLMP4NJZ
         XH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnhlmlSRLnPaMTK56lFS9UcseMDYyt/e2JSVZnLtYFE=;
        b=ZW/nHF/WqQtXwKFBpVru/UVWn7SZNgMRm4AxZiiaRe8ukMsJNciq+DaWBF7j/12SEM
         5fXoDqNQeblGuWmTLwwCpvlKnBSDFwzm+7ihO3us9C6MBws7VUQV4fEdjZBDDNbM6Dbn
         /t7mxWP8a0GfnweOIqv1L2aDOnTtbLURIUXBzVxAfp7VlptQkhSRJTKAsQpBF/ZYDx4/
         WbCuL1+24/Z/8JjjkbZdo17vO/ERIIeY0aYWytbQIsFDz1epjImi73olOV0MRNfpy0Kw
         QxH1PCNa4vXK50Gsa0dyoOcFeTNor2UygpERQ2H+bfoj1KQa7b3RHiluN/WvCH89q05Q
         FMBA==
X-Gm-Message-State: AOAM530LtLCrOW1er62H9PJpKmIhr3RWyXSHGZjiZZlb7s5GW5vyCryY
        pZ7tq46/s6JvWwH31bMtGCFFipZIB6jZC24Sxg8=
X-Google-Smtp-Source: ABdhPJygc8lk3WOcyoypbQlB5uWqO7dPo3Do9yf5sAdFsxjDzldY0ejwf7jEoGhU2wDPgcSPdKm1tACqVn8KX8CBCoQ=
X-Received: by 2002:a25:9942:: with SMTP id n2mr42040781ybo.230.1625775654411;
 Thu, 08 Jul 2021 13:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210706172619.579001-1-m@lambda.lt> <CAEf4BzbCAO=hjA=hSh9QXN3C79xOmM0=Cc0H1gZnhm6LdDz9Sw@mail.gmail.com>
 <41795594-5d66-e17e-095c-cc4cdc84a017@lambda.lt>
In-Reply-To: <41795594-5d66-e17e-095c-cc4cdc84a017@lambda.lt>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 8 Jul 2021 13:20:43 -0700
Message-ID: <CAEf4BzYyxp7ATMHaTpgnZRPhPwOUR7r=kqT-ZY=KzC3dG-WcOQ@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: fix reuse of pinned map on older kernel
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 8, 2021 at 4:43 AM Martynas Pumputis <m@lambda.lt> wrote:
>
>
>
> On 7/8/21 12:58 AM, Andrii Nakryiko wrote:
> > On Tue, Jul 6, 2021 at 10:24 AM Martynas Pumputis <m@lambda.lt> wrote:
> >>
> >> When loading a BPF program with a pinned map, the loader checks whether
> >> the pinned map can be reused, i.e. their properties match. To derive
> >> such of the pinned map, the loader invokes BPF_OBJ_GET_INFO_BY_FD and
> >> then does the comparison.
> >>
> >> Unfortunately, on < 4.12 kernels the BPF_OBJ_GET_INFO_BY_FD is not
> >> available, so loading the program fails with the following error:
> >>
> >>          libbpf: failed to get map info for map FD 5: Invalid argument
> >>          libbpf: couldn't reuse pinned map at
> >>                  '/sys/fs/bpf/tc/globals/cilium_call_policy': parameter
> >>                  mismatch"
> >>          libbpf: map 'cilium_call_policy': error reusing pinned map
> >>          libbpf: map 'cilium_call_policy': failed to create:
> >>                  Invalid argument(-22)
> >>          libbpf: failed to load object 'bpf_overlay.o'
> >>
> >> To fix this, probe the kernel for BPF_OBJ_GET_INFO_BY_FD support. If it
> >> doesn't support, then fallback to derivation of the map properties via
> >> /proc/$PID/fdinfo/$MAP_FD.
> >>
> >> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> >> ---
> >>   tools/lib/bpf/libbpf.c | 103 +++++++++++++++++++++++++++++++++++++++++++++------
> >>   1 file changed, 92 insertions(+), 11 deletions(-)
> >>
> >
> > [...]
> >
> >> @@ -4406,10 +4478,19 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
> >>
> >>          map_info_len = sizeof(map_info);
> >>
> >> -       if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len)) {
> >> -               pr_warn("failed to get map info for map FD %d: %s\n",
> >> -                       map_fd, libbpf_strerror_r(errno, msg, sizeof(msg)));
> >> -               return false;
> >> +       if (kernel_supports(obj, FEAT_OBJ_GET_INFO_BY_FD)) {
> >
> > why not just try bpf_obj_get_info_by_fd() first, and if it fails
> > always fallback to bpf_get_map_info_from_fdinfo(). No need to do
> > feature detection. This will cut down on the amount of code without
> > any regression in behavior. More so, it will actually now be
> > consistent and good behavior in case of bpf_map__reuse_fd() where we
> > don't have obj. WDYT?
>
> I was thinking about it, but then decided to use the kernel probing
> instead. The reasoning was the following:
>
> 1) For programs with many pinned maps we would issue many failing
> BPF_OBJ_GET_INFO_BY_FD calls (instead of a single one) which might
> hinder the performance.

you can't have so many maps per BPF program to really notice
performance drop for doing an almost no-op bpf() syscall, so I find
this a weak argument

> 2) A canonical way in libbpf to detect features is via kernel_supports()
> and friends, so I didn't want to diverge there.

There are places where we just gracefully handle missing features.
E.g., when loading map with BTF and it fails, we'll retry without BTF.
Or in __perf_buffer__new we allow BPF_OBJ_GET_INFO_BY_FD to fail.

I'd start with a simple fallback and do explicit feature detection
later if it turns out to be problematic.

>
> Re bpf_map__reuse_fd(), if we are OK to break the API before libbpf
> v1.0, then we could extend bpf_map__reuse_fd() to accept the obj.
> However, this would break some consumers of the lib, e.g., iproute2 [1].

No, we are not ok to just arbitrarily break API. And especially that
passing obj to bpf_map API seems weird. We could solve this problem by
remembering the bpf_object pointer inside struct bpf_map, just like we
do for struct bpf_program, but again, I'm not sure it's worth it in
this case. But strategy doesn't help perf_buffer__new() case.

>
> Anyway, if you think that we can ignore 1) and 2), then I'm happy to
> change. Also, I'm going to submit to bpf-next.

I'd like bpf_map__reuse_fd() to have consistent behavior. And avoid
extra code if possible, so let's try a simple fallback for now?

>
> [1]:
> https://github.com/shemminger/iproute2/blob/v5.11.0/lib/bpf_libbpf.c#L98
>
> >
> >
> >> +               if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len)) {
> >> +                       pr_warn("failed to get map info for map FD %d: %s\n",
> >> +                               map_fd,
> >> +                               libbpf_strerror_r(errno, msg, sizeof(msg)));
> >> +                       return false;
> >> +               }
> >
> > [...]
> >
