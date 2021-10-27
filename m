Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517DC43D095
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 20:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbhJ0SXb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 14:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbhJ0SXa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 14:23:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D592C061570
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 11:21:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g184so3739501pgc.6
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bZgO7RbOdEjf+eMXdThKKQ+y5s74MXY0OV/42JB04+8=;
        b=dFUDF+BkzyJse4kzTJyWmvkZ4vfsvfuMtZ7EVsMqH9FQj0OI+sfgibnsrGVunhnKe2
         woi9xg8TvK60wJY0gTejQp8gpfkmAUo4XTbJlwmyN/e79sEATV4e8A2XBgrtUmtNTaz/
         d83njRNN6iqn3umVGoPTWpHnHFkZslwWK4x1iloCy+HY8X5LBCuEHrInSGqpL9i61IpB
         hk4pGQOEEKi5lEKACcboQ0nyQVDz7bx+ezcBbX0Ttt1Jl3J3OsVpyyC0N/vcWTaf2aIw
         hJDNhluNUal3TRc8FNHdq1SXI6e1YuuAFbFLT/nnPAU1nenwwZ+wkz7aPu9nzta4Tw56
         1QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bZgO7RbOdEjf+eMXdThKKQ+y5s74MXY0OV/42JB04+8=;
        b=tXu3/oYKApcvAnLPc/IWZcLYzcxdJS5GP1313z5ify4CU2+wl9XUuhcUUSbox65nO1
         IBBnAGfGU595k0j+JL/GDca6vZDCm3+Vrk0T2GeW45iy+PhXAC1Wd6Ktok0GIm2hhYm4
         Y5qScXRipRc20pAxpbEv+hMwgfMbKryqi2Bt91NbRHCgsL+/70CohshoHI1TFWtX03Ig
         N1qLVnpVYbAwOoaqph4URYuicGLWQy6KS0FE2gb5GIVSR0PHo22QCMx8F+ZFZcKWuLCK
         mgWXFP6R5TKgdsvJZp2IMEj1q+xBRcc6uQfzt0r3XwufFpQeV8WUuRMCsvisploV5SIR
         DCSQ==
X-Gm-Message-State: AOAM533KwVU97VNGLkKmGZRgqxWBNe7LUtJli/JJ9jYyNDz7IqME3Uv4
        7Yum19/P0uSL6PtMvh1ET4WZY5aPTNsm41dwE50=
X-Google-Smtp-Source: ABdhPJy6J+O7Pf5Q1pTQsLyoO9Y3h1IUpTPEIBSEAcjFz7tZUt/phPeyTkMBmNuD8NYFqHUE0p+c2f75YQvIYFB+osI=
X-Received: by 2002:aa7:8b56:0:b0:44c:10a:4ee9 with SMTP id
 i22-20020aa78b56000000b0044c010a4ee9mr34597691pfd.46.1635358864793; Wed, 27
 Oct 2021 11:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211014143436.54470-1-lmb@cloudflare.com> <20211014143436.54470-10-lmb@cloudflare.com>
 <20211020171542.7vn3lsrqmq2h7q2v@ast-mbp.dhcp.thefacebook.com> <CACAyw9_z=dya3S00wEjS_sVtFp5PVOX2OU6eDw0JHTQ91dRRHA@mail.gmail.com>
In-Reply-To: <CACAyw9_z=dya3S00wEjS_sVtFp5PVOX2OU6eDw0JHTQ91dRRHA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 27 Oct 2021 11:20:53 -0700
Message-ID: <CAADnVQJXmVFj_6O9eEAs_4FfdyZMhTab57v_=syR8RJWrdPLHA@mail.gmail.com>
Subject: Re: [RFC 7/9] bpf: split get_id and fd_by_id in bpf_attr
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 8:59 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Wed, 20 Oct 2021 at 18:15, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > > +     struct { /* used by BPF_PROG_GET_FD_BY_ID command */
> > > +             __u32 id;
> > > +     } prog_get_fd_by_id;
> > > +
> > > +     struct { /* used by BPF_MAP_GET_FD_BY_ID command */
> > > +             __u32 id;
> > > +             __u32 ingnored;
> > > +             __u32 open_flags;
> > > +     } map_get_fd_by_id;
> > > +
>
> > > +     struct { /* used by BPF_PROG_GET_NEXT_ID command */
> > > +             __u32 start_id;
> > > +             __u32 next_id;
> > > +     } prog_get_next_id;
> > > +
>
> > This one looks like churn though.
>
> Yes, but it's still better than what we have now. There are three
> distinct syscall signatures that a user needs to understand, which is
> impossible right now without looking at the source. map_get_fd_by_id
> is arguably dodgy with one field completely ignored. Having one struct
> for each bpf_cmd makes code generation easier as well.
>
> I could reduce this to just the three different variants, it opens us
> up to another map_get_fd_by_id.

yes, but even with all of them there is still a risk of repeating
map_get_fd_by_id mistake.
To make progress maybe let's land the bits that we agree on
and keep brainstorming on the rest?
Or that's too little to be useful for automatic golang conversion?
If the whole thing is needed then golang converting script
should probably be part of the series otherwise things will bit rot.
