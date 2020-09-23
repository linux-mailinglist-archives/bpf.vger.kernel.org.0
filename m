Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFB0275D0C
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 18:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIWQOs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 12:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWQOs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 12:14:48 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57529C0613CE
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 09:14:48 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id x14so406449oic.9
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ETrRbQM50w2hV5x7zdtjMnXI+MhI3dOXm7u8racano=;
        b=hSfsHdvofm6JZGUfx1b7UMYmwt4rTCLdbw5pI1bLf9o21pjYiKQehdjkeyjjVvee50
         NTvdx3n/P/Sb3unlcxEA6KOENaCZnFTI2vaXwHS2f9maE01mepiUEXMSrjTlvZnOGsv8
         f5wti8uoU3Xt2IRd8C5580IE8bGS78RdWIn/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ETrRbQM50w2hV5x7zdtjMnXI+MhI3dOXm7u8racano=;
        b=CynWhiBeCxNCaDmCYucdEqZdC7SPG2mEOZLRDVIakh107GA8mK+H9w4CUn0OzqFz9M
         L4s7SfppZfd4h7EuWFpqO77YsKFZJ/CkTS1kYB34XL15ProOLiIJ5lbmNxGTwKqkBQlt
         rKh2+OJ4tzLCyPZ+XMtSgSlqw1FyMJGj/1Jdj8GL2krmul77mBfpfh0GmV8ttUchtXrj
         gCt2fZguoBA5gciZfzvSi0h+MyvgMw85KaTHyHzO8L4BWd+/2MWAq00eYH7PXrObN+Ra
         0g4yP/0MvdOKdVblsb195rEzJ7jNPKvajC/5sh6NVnDvHT6l7r0irUhf4vLofXut/kbR
         w8QA==
X-Gm-Message-State: AOAM533Dh/KsKxtAsXntyftbcMorJi71OapNLqvLBgVlYIhwBGhGYtld
        02UTMMY9wVBm8/ebVydJfuclf174qUbvG20nadPHcQ==
X-Google-Smtp-Source: ABdhPJx2UCxJUQewIhU+/qsja/MStQD1dXOj4CnZngQ9x4vHmhfWKgQZhqIpFNzKiZDHiQdZcaVbWUXmIw/cZa7OjYs=
X-Received: by 2002:aca:3087:: with SMTP id w129mr167587oiw.102.1600877687613;
 Wed, 23 Sep 2020 09:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <80d19887-5b77-a442-5207-a2685cdd1f83@fb.com>
In-Reply-To: <80d19887-5b77-a442-5207-a2685cdd1f83@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 23 Sep 2020 17:14:36 +0100
Message-ID: <CACAyw9-zry08xTRGUHCh8VSp0eF9cFQjGiur0jDnA-YMaZ=Niw@mail.gmail.com>
Subject: Re: Help testing llvm patch to generate verifier friendly code
To:     Yonghong Song <yhs@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 23 Sep 2020 at 08:17, Yonghong Song <yhs@fb.com> wrote:
>
> Hi,
>
> I have spent some time to add additional logic in llvm BPF backend
> in order to generate verifier friendly code.
>
> The first patch is:
>    https://reviews.llvm.org/D87153
> which moves CORE relocation builtin handling from in late IR
> optimization (after inlining and major optimizations)
> to in early IR optimization (before inlining and any optimizations).
> The reason is to prevent harmful CSEs.
>
> But this change may change how compiler do optimizations.
> The patch can pass bpf selftests in latest bpf-next.
> Andrii helped it can also pass bcc/libbpf-tools.
>
> If your code uses COREs, esp. having a lot of subroutines
> and/or loops, it would be good to give a try with new patch
> to see whether there are any issues or not. In my case,
> for one of our internal applications with lots of subroutines
> and loops, inlining all subroutines and unrolling all loops
> will cause register spills which cannot be handled by
> the verifier, while existing llvm won't have issue.

Hi Yonghong,

We currently don't use CORE (outside of bcc, etc.), so there isn't
much I can test I guess? Please let me know if there is something I
can do for your follow up patches.

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
