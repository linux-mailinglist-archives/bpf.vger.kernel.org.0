Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A613DAE2C
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 23:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhG2VV6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 17:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhG2VV6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 17:21:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179AC0613C1
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:21:54 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id g76so12488490ybf.4
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVEUoIeXmIQWOzUJGGX4tSb3gJiqrMaFOO2m6Pc5kvA=;
        b=AkIy2EM0oNkY12EMt/xwD5M2hIcWt3jNji03EE/cogOgyc4SsDUqKz5e5Xn6jh1yqh
         SGeiAFzQ00MhordY46Hk0rCbWbUP8Qz8tQV+dVBvD10aMEZ8h6EpKXMke6p8ARrRuT89
         2vA9cTQRrySJ9PRYFQxi/d/IzXN05XUBpk4+zeMwlBZE9XyzdcoNbBYWUaZ/r5OS56bX
         HaeDmPqID0LEmNFkCmJykq6ZubGWzKmJ9UNWvSx44K+gRDaKXIK+Uj+IuCqOcOzt0Jxp
         I9TpEwQTUvp4lOIjoDDmMMkGldqVB47FxaQQmoz/WdXalUXI7xFtOijBstbwy9Hup8lS
         nbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVEUoIeXmIQWOzUJGGX4tSb3gJiqrMaFOO2m6Pc5kvA=;
        b=Rb+Q6WRJghTXdi1PVssqc6AzePrb2LK4Gem8G3LOJ3Da/mnUgsnDC8q1I9T5n90vzB
         d19wLHuwuGuBEap4q0xa4GOSnMYTydJ2YKwuOey3rer9R5SxHtEx+uEg0tt4QdprIopW
         YdCD67UlzD7XjoChjoGiO0qd5mZsSd7r8yVv3esciptW4sAWTVayDviApevVcROgxLVi
         MbxjXHY241hy2wfzLof/GWQaqrJ621HO6V2kxBUy9CmK2n4FPaS1iDRxLyLSXruNPdXN
         AietsnmeGo0W4VcmAg+z3mNT3xSXcixLKWUidLJC+Wq96VC5kBSgVfs9umXmk0nZgdJV
         XDmw==
X-Gm-Message-State: AOAM533XRtwZybLtXIfnR4oxMB9CAlC44DyLlp3n5owBnyNRbCgvPU35
        +NBjvw0JSUehMK9ts1WWSGYLPG9Pnbv7hQLBP864HA==
X-Google-Smtp-Source: ABdhPJwCMBfWJ1aZm/KOEvRIjOmo+J+kQglOzLy5W/OF9TNRuwn5MaCMCsB5ahVbKQn/WVdYdaVFT2UWFZfkdqN5R+k=
X-Received: by 2002:a25:ac18:: with SMTP id w24mr9861016ybi.289.1627593714088;
 Thu, 29 Jul 2021 14:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
 <20210728170502.351010-8-johan.almbladh@anyfinetworks.com> <cbff35ec-07ce-9c7d-4c29-66f2f780daa4@fb.com>
In-Reply-To: <cbff35ec-07ce-9c7d-4c29-66f2f780daa4@fb.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Thu, 29 Jul 2021 23:21:43 +0200
Message-ID: <CAM1=_QQ6rUjANEKTPUadzMfP5zcxWimL8+YRjy=3eS0SZrwbpQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] bpf/tests: Add more ALU64 BPF_MUL tests
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tony Ambardar <Tony.Ambardar@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 29, 2021 at 1:32 AM Yonghong Song <yhs@fb.com> wrote:
> > @@ -3051,6 +3051,31 @@ static struct bpf_test tests[] = {
> >               { },
> >               { { 0, 2147483647 } },
> >       },
> > +     {
> > +             "ALU64_MUL_X: 64x64 multiply, low word",
> > +             .u.insns_int = {
> > +                     BPF_LD_IMM64(R0, 0x0fedcba987654321LL),
> > +                     BPF_LD_IMM64(R1, 0x123456789abcdef0LL),
> > +                     BPF_ALU64_REG(BPF_MUL, R0, R1),
> > +                     BPF_EXIT_INSN(),
> > +             },
> > +             INTERNAL,
> > +             { },
> > +             { { 0, 0xe5618cf0 } }
>
> Same here. Maybe capture the true 64-bit R0 value?

Same as the LSH/RSH/ARSH tests. Uses 32-bit shift to test high and low
words in two runs.
