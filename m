Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3EE1741E6
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2020 23:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgB1WUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Feb 2020 17:20:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46958 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgB1WUX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Feb 2020 17:20:23 -0500
Received: by mail-io1-f65.google.com with SMTP id x21so661899iox.13
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2020 14:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oupcBBMzkVkZ/IoOMguzUGYed0hV634MFJNr2ddg34I=;
        b=ZepahZwIUeF3xf2pSgqJtC+C8FNfJcpunG9ymLMAOgpy/DumhVN1QFSRYjquUNkYPG
         VWiL/PQPCcKK/I5We1TfbQpN9B4IX1fTqUWAljn7CWQefOiGcSUpRct4y/FkjGsHtGoW
         B2OkpiVEi4Z69fyjPREGb2YNKfDXZePcAtPy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oupcBBMzkVkZ/IoOMguzUGYed0hV634MFJNr2ddg34I=;
        b=UHJIftrkNyQXpZ+Z8i1DqZLPPzEMDEti2mvUCEdpz7N6DoZl1X2AczJfhrzLn2veNn
         QY2yLW1HQmAqnwqCEK6Sllm29xUdLFTl+JeqkTBfVRHTQyoU4IMS4CBgjOnOimM5LVfb
         +SPxjs101g3sD3+lt1h98/m6wuBrHPGnDsEtxgRBGKJsRI/5oDObMP4oSQ5yzLPIeJtZ
         RDzRXgeivzhV+Jh7+WvabdO/PkUhTeNOaoVT9Mw13hyu/oM369ndyQ4z12A/6u7vD7go
         8V9CnHLamOiAyzthJOoqMtlkNXXPmjKVXTb44oOwp8i0SjrDb1xoU/O+NLivjXzhMdyv
         pGiA==
X-Gm-Message-State: APjAAAWn8ooTPx5Hi3Ytuw9miZeisd+VaXOC5NK2OMxqaYVbV1VmLxlx
        YmChUuJPP4s0R45ANSniUApKgifkjkLC5M7mHSGOzA==
X-Google-Smtp-Source: APXvYqzUA63UJ/ZftjR3xpzQk6KLVrxHNtqrOc2EL/UgVChIcEyqw1voIGCsw/vz/kUAbG6Uz78EKhPVsnvIyCSy6ko=
X-Received: by 2002:a6b:fb02:: with SMTP id h2mr5156666iog.126.1582928422602;
 Fri, 28 Feb 2020 14:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20200220041608.30289-1-lukenels@cs.washington.edu> <CAJ+HfNiOoLWpQAPhKL6cUVTZ0vTwuSabZzypzAmbRThD3ChGzA@mail.gmail.com>
In-Reply-To: <CAJ+HfNiOoLWpQAPhKL6cUVTZ0vTwuSabZzypzAmbRThD3ChGzA@mail.gmail.com>
From:   Luke Nelson <lukenels@cs.washington.edu>
Date:   Fri, 28 Feb 2020 14:20:11 -0800
Message-ID: <CADasFoAB8PNRTQifs6-dapGWY=0J2usYNCYqg5g--jYG37rybQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] RV32G eBPF JIT
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiong Wang <jiong.wang@netronome.com>,
        Xi Wang <xi.wang@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 28, 2020 at 6:25 AM Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.co=
m> wrote:
>
> Luke/Xi, apologies for the slow reponse. (All my RV work is done on
> non-payed time, so that's that. :-)) Very nice that you're still
> working on it!

No worries, thanks for reviewing!

> >
> > - ALU64 DIV/MOD: Requires loops to implement on 32-bit hardware.
>
> Even though it requires loops, JIT support would be nice. OTOH, arm
> doesn't support that either...

We could probably implement this by calling into a helper function
for BPF_ALU64 | BPF_DIV/BPF_MOD, but none of the other JITs (e.g.,
arm,x86) for 32-bit architectures do this. We could add support to
rv32 and other architectures in a future patch.

> > - BPF_XADD | BPF_DW: Requires either an 8-byte atomic instruction
> >   in the target (which doesn't exist in RV32), or acqusition of
> >   locks in generated code.
> >
>
> Any ideas how this could be addressed for RV32G?

I don't believe there is a simple way to correctly implement BPF_XADD
| BPF_DW without hardware support for 64-bit atomic operations,
like for other 32-bit JITs.

> In general I agree with Song; It would be good if the 64/32 bit
> variants would share more code. RISC-V 64/32 *are* very similar, and
> we should be able to benefit from that codewise.
>
> Pull out all functions are that common -- most of the emit_*, the
> parts of the registers, the branch relaxation, and context
> structs. Hopefully, the acutal RV32/64 specfic parts will be pretty
> small.

Thanks for the suggestion. I'll factor out the common functionality
into a header for the next revision.

> Finally; There are some checkpatch issues: run 'checkpatch.pl --strict'.
> [...]

I'll fix the rest of the issues you found in the next revision.

> Thanks for the hard work! I'll take it for a spin, with help from the
> guide above, this weekend!

Thanks again!
- Luke
