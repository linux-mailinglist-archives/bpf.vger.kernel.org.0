Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAD42576C
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 20:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfEUSSh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 May 2019 14:18:37 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:42571 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfEUSSh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 May 2019 14:18:37 -0400
Received: by mail-lf1-f48.google.com with SMTP id y13so13813092lfh.9
        for <bpf@vger.kernel.org>; Tue, 21 May 2019 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5nwiXHqb4zuyCMkCvFe8kZ5hG6nTWTWZgi05GgDKgY8=;
        b=ChJEWeroaTKfckAw5lORdZymyYgwESBZ3jnl3rZfjL9fysJVUcPpXc1nTpS4Yay/28
         hh50/j46yZd+XazoQK85CvaYZqTVQwFUQEXfteDux1oa2g0pVEuZcC10x139Y5+8tInu
         8/n0ZSbyNnMnqcByrbjJOfiRyIhhCS5N2wRlwv5ebu3m7M5b6eohU36S5KkcbW1Vj9tI
         17RfBykT13lDp/DAb/FebwqEFHp9DtAlhZ8JLD/XPczpuHjSVPBU/qKzC5NHL4aLurmi
         rvC01M71pUPh+1bTuTZGn3DTjLUut+00nqaQvX+MQze8WXk0oFRiNSwJJyJKUyW8A/SX
         79Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5nwiXHqb4zuyCMkCvFe8kZ5hG6nTWTWZgi05GgDKgY8=;
        b=cJWmR6cxGA6NnuNsnpeneddZbH53LLiTAHoWUIKKMuPUNQ3NH8ov8lhGcIJZOcA4YR
         HHsKWQ/ObWmzKaQZ0dh+dScKe9Czcm00dkXXo+45ohZxRQiww+AI0X2r0nSEcOV9Otn8
         a2mvK9WZUn+EqZv2+P8F9va48vhSBRPsf+35pAlXtUTH1tLE/rV0XawVShYaLUsMTSjP
         pTxWxEkpm55ncz4kvf8+n29gfIL+Si1oe6xLyQWieubQ9N51VP6X289BIah+FNLOxpJ5
         nYoyXXDgf5EUg1+UPZMswASKF3D7FCg02RQHorgX0IEJWUrrdGGDfqZ2/oUYhhovvfiJ
         Gk0g==
X-Gm-Message-State: APjAAAXWtbkCM6Nx2KJWIk6wZBW9PNCusiIfMjxQ4NzyQ1pFPTYYDucV
        ThoTj5HBefuKv8VKVQR5tP84yZ1b5aLWrSiPyaw=
X-Google-Smtp-Source: APXvYqykwBrfZkH2lQN5OIhm8vVJ1ixsdt78GmgBjG17Os2xYkxeUsb1r9gNLUjV754bdXqdf3U7ifZWAFa03fnZcMw=
X-Received: by 2002:a05:6512:309:: with SMTP id t9mr40057888lfp.103.1558462715335;
 Tue, 21 May 2019 11:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
In-Reply-To: <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 May 2019 11:18:23 -0700
Message-ID: <CAADnVQJcfnEh4_ok1o9oWNiaBAdd-2XHiguu1FvPZdnAuXuWBg@mail.gmail.com>
Subject: Re: [PATCH 0/9] eBPF support for GNU binutils
To:     Jiong Wang <jiong.wang@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Edward Cree <ecree@solarflare.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     jose.marchesi@oracle.com, binutils@sourceware.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 21, 2019 at 8:41 AM Jiong Wang <jiong.wang@netronome.com> wrote=
:
> >
> > Despite using a different syntax for the assembler (the llvm assembler
> > uses a C-ish expression-based syntax while the GNU assembler opts for
> > a more classic assembly-language syntax) this implementation tries to
> > provide inter-operability with clang/llvm generated objects.
>
> I also noticed your implementation doesn=E2=80=99t seem to use the same s=
ub-register
> syntax as what LLVM assembler is doing.
>
>   x register for 64-bit, and w register for 32-bit sub-register.
>
> So:
>   add r0, r1, r2 means BPF_ALU64 | BPF_ADD | BFF_X
>   add w0, w1, w1 means BPF_ALU | BPF_ADD | BPF_X
>
> ASAICT, different register prefix for different register width is also ad=
opted
> by quite a few other GNU assembler targets like AArch64, X86_64.

there is also Ed's assembler:
https://github.com/solarflarecom/ebpf_asm
It uses 2 ops style.
I think 3 ops style "add r0,r1,r2" is not a good fit for bpf isa.

I think we need to converge on one asm syntax for gas/bfd.
At this point we cannot change llvm's asm output,
so my preference would be to make gas accept it.
But I understand the implementation difficulties to fit it into bfd infra.
So I'm ok with more traditional asm the way Dave implemented it few
years back.
One asm syntax for gas and another asm syntax for clang is, imo, acceptable=
.

Jose, can you combine Dave's patches with yours?

I think Ed had an idea on how to specify BTF in asm syntax.
BTF has to be supported by the assembler as well
along with .btf.ext, lineinfo, etc
Currently llvm emits btf as '.byte 0x...', but that's far from ideal.
