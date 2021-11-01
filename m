Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3894422E3
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 22:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhKAVqs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 17:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhKAVqr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 17:46:47 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A33C061714
        for <bpf@vger.kernel.org>; Mon,  1 Nov 2021 14:44:13 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id s3so14700325ybs.9
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 14:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGAMWtq7FT/xOpFGWpO9PC84l9xKylH+Tsd62pEGCWk=;
        b=Ii8/JAAF+C+GKhYxXmSUZowch53PAczgR6BJjxIwYG1Y37UZVQ99+8JXHKFYXptyxO
         Xy83zZoizlU/ZTeA4ttjR60/ecSrquP96In0x2o1r+sA30b0Iq304PJwjARGBonbmaFO
         w33t6cxavLeHQg/BVl5i+29ALqAOUVJ5cUCUtWL1rmJKTktbeRXIavdowIMhwiY8i/QY
         DXUfhGf/TnXlfmzqXppx2PzUXe2H4O+hNArVszolWdd2//kHW7N/X8B9pt5Aizc6OVQw
         qTdAdpyQwetjRV6gWByRF61KbKNHNHqHcTmnJjkWERk5q3jYwwaKBOKdGbR1TjPQUk2D
         Cb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGAMWtq7FT/xOpFGWpO9PC84l9xKylH+Tsd62pEGCWk=;
        b=gm6fWXHgkMsO8vSCH0rltssFXbD0wLn+smHnwy4hqGVfKhbHlJA5bgemA4repTIwi1
         dKGL6A8UIAWPxS62klJI7IhVpUl5TsMg3RK7vgw9ROfkdbVsSK6qJveho01oLZfTn+UU
         +Tvc9aKo3f1Y0I2f85bcnrJ89+3ho2X6iuIRdkdl6F3hdkHLtfFdaQYtsUxSsKsV5Qhc
         CNjyZY7zJ2a8fOhD+AJKHnd2Xxu2+ZsdA7UHdW6tcujrowMUphh4nUfXoyx2LoaTWHsD
         jp0Z5hlI0j5EG/xQ/Qb1FFlOsXvt2lmDeEyKD4CzxfQhN577FoxtjTiGnxuUHHquJGd2
         mEDQ==
X-Gm-Message-State: AOAM530SWtkIL6IXPnQb0E+tT9OaEaPoU/szD40LSkrOixVd/52LOxAR
        DkRWFOY951isq4nWgvTqZ8ZJJhBMpoi3Kj10fQY=
X-Google-Smtp-Source: ABdhPJzpbo6KaV33n3Y2uyCJmeJePGJm2t3rmG+dZXOSsvpAH2uO/dLU1umSsCEmFFgP2JI6dlIoe1DTUM4hSIYrs88=
X-Received: by 2002:a25:d187:: with SMTP id i129mr23418904ybg.2.1635803053259;
 Mon, 01 Nov 2021 14:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211030045941.3514948-1-andrii@kernel.org> <20211030045941.3514948-2-andrii@kernel.org>
 <ac73a76c-e571-5b27-f711-1cfd9d5ac725@gmail.com>
In-Reply-To: <ac73a76c-e571-5b27-f711-1cfd9d5ac725@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Nov 2021 14:44:02 -0700
Message-ID: <CAEf4BzY4X1cDR0oU4vRp0QwwytpSbCgh+H1nLiPGhO3t19HQPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/14] bpftool: fix unistd.h include
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 1, 2021 at 7:12 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Hi,
>
> On 2021/10/30 12:59 PM, Andrii Nakryiko wrote:
> > cgroup.c in bpftool source code is defining _XOPEN_SOURCE 500, which,
> > apparently, makes syscall() unavailable. Which is a problem now that
> > libbpf exposes syscal()-usign bpf() API in bpf.h.
> >
>
> typo:
>   syscal -> syscall
>   usign -> using ?
>

Thanks, will fix.

> > Fix by defining _GNU_SOURCE instead, which enables syscall() wrapper.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/bpf/bpftool/cgroup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> > index 3571a281c43f..4876364e753d 100644
> > --- a/tools/bpf/bpftool/cgroup.c
> > +++ b/tools/bpf/bpftool/cgroup.c
> > @@ -2,7 +2,7 @@
> >  // Copyright (C) 2017 Facebook
> >  // Author: Roman Gushchin <guro@fb.com>
> >
> > -#define _XOPEN_SOURCE 500
> > +#define _GNU_SOURCE
>
>
> >  #include <errno.h>
> >  #include <fcntl.h>
> >  #include <ftw.h>
> >
>
> According to the man page ([0]), defining _GNU_SOURCE also implicitly defines
> _XOPEN_SOURCE with the value 700 (600 in glibc versions before 2.10; 500 in glibc
> versions before 2.2), so this change should not break anything.

Cool, thanks for checking.

>
>   [0]: https://man7.org/linux/man-pages/man7/feature_test_macros.7.html
>
> --Hengqi
