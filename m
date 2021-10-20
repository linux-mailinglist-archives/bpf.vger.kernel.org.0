Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D63F434EFE
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhJTP2q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhJTP2q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 11:28:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCE9C061749
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 08:26:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j21so16003618lfe.0
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFXjFBnxgfxDGLhFCTKSXBoyM9+OzYKaEZLzSUyNRo8=;
        b=nNru3vSVaxqhxIQNPKup5m3Z0pzFm1iaXXmrODPoT6J43UNVaCc85LmOgqsVL/M43l
         xxL6J0+trWpWzNVUVuN1MbWUzqSo88jGgghysp3jxJi6dNit+RHeJgtSB5/hvb/MU+Ri
         w1VIRnqcdSNUoNZ1GJEtC98TaOpputDU+NwsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFXjFBnxgfxDGLhFCTKSXBoyM9+OzYKaEZLzSUyNRo8=;
        b=gJvFWSD4nPwS7ya8NLa4ykBUTbdg2qYoJH/okQkpNh8nKA00s2SIiWX4h4Ivb5WwdG
         aPRoj670TojcAsS4qjeIzkyfW3ZZyOyvNso63wZGyDrqpHxc+Un8wpGIqeJBVPV/LQkM
         MnLRYnSNuItsHoEohy5J3F4QirKR/MtYNuNoWUURcX2BHoupOujVGqiqatEAzhLQc9R0
         ObuB+OFK7gy9jCejeO2v+t+juUt8ds17xPau+dYgbWZMlxzuFDcJV34MeiMg0RA7SGlB
         rCYu9TMWgqDzkdb69DN2BQN8oIQaNbDvJbUM1nyYgGIUAy4S3QZQ7AZfEV7dlSEg+i8Y
         OzFA==
X-Gm-Message-State: AOAM5308cBChfvdIDNFIlTLPXB3mAwXLKiAle5BjCPngMsXdrJJlyJu5
        Stgob5fm9ALKm8/udaPy8hAXEJBwjnhUmA80NKe/jQ==
X-Google-Smtp-Source: ABdhPJyINf19djKlwGrxw44Z7Qh2xkiExwbHVQODjclT7wDX8UNT5U8hcTVRVoquuvK7mdq+mDUhD6o/j4HEaGB5G7k=
X-Received: by 2002:ac2:5b05:: with SMTP id v5mr93678lfn.39.1634743589600;
 Wed, 20 Oct 2021 08:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211019144655.3483197-1-maximmi@nvidia.com> <20211019144655.3483197-5-maximmi@nvidia.com>
 <616f8cd0a0c6c_340c7208ae@john-XPS-13-9370.notmuch> <73133203-ccb7-f538-7b02-3c4bd991e54d@nvidia.com>
In-Reply-To: <73133203-ccb7-f538-7b02-3c4bd991e54d@nvidia.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 20 Oct 2021 16:26:18 +0100
Message-ID: <CACAyw99Yj=oQF__sgJxAxJ20cnRfUA1qjPmgEKS22nCm=8nP1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/10] bpf: Make errors of bpf_tcp_check_syncookie
 distinguishable
To:     Maxim Mikityanskiy <maximmi@nvidia.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@chromium.org>,
        Joe Stringer <joe@cilium.io>, Tariq Toukan <tariqt@nvidia.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 20 Oct 2021 at 14:16, Maxim Mikityanskiy <maximmi@nvidia.com> wrote:
>
> On 2021-10-20 06:28, John Fastabend wrote:
> > Maxim Mikityanskiy wrote:
> >> bpf_tcp_check_syncookie returns errors when SYN cookie generation is
> >> disabled (EINVAL) or when no cookies were recently generated (ENOENT).
> >> The same error codes are used for other kinds of errors: invalid
> >> parameters (EINVAL), invalid packet (EINVAL, ENOENT), bad cookie
> >> (ENOENT). Such an overlap makes it impossible for a BPF program to
> >> distinguish different cases that may require different handling.
> >
> > I'm not sure we can change these errors now. They are embedded in
> > the helper API. I think a BPF program could uncover the meaning
> > of the error anyways with some error path handling?
> >
> > Anyways even if we do change these most of us who run programs
> > on multiple kernel versions would not be able to rely on them
> > being one way or the other easily.
>
> The thing is, the error codes aren't really documented:
>
>   * 0 if *iph* and *th* are a valid SYN cookie ACK, or a negative
>   * error otherwise.

Yes, I kept this vague so that there is some wiggle room. FWIW your
proposed change would not break our BPF. Same for the examples
included in the kernel source itself. That is no guarantee of course.

Personally, I'm a bit on the fence regarding a backport of this.
Either this is a legitimate extension of the API and we don't
backport, or it's a bug (how?) and then we should backport.
-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
