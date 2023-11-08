Return-Path: <bpf+bounces-14523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8058C7E5EED
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 21:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861991C20B8D
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B9D37166;
	Wed,  8 Nov 2023 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK9BevCq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D732C67
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 20:05:20 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B029211B
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 12:05:19 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4083f613275so143785e9.2
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 12:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699473918; x=1700078718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7SEpcf1Pb1tiRuUSIyU6UDGCzl70LByBofqTy8eqAI=;
        b=YK9BevCq6FthTXdh/G3X59aZa0/Gn2A5FXFGPs3ZnGzmg0YyhbyYVx1Q90TDy+iMop
         J+utzlKwYVzGOjs6mZYRDI75++meiFkLoz3ySNZgBLfWNLR6VZFGFmXF/177v0yGg/C4
         c+DJwM4eo/I0bCx9/J4Cv+OsjGHdBGDS88fu2Mf2Lihot6M7Z3Z79gv+lu3EbkIwt5Ao
         W0Zt7bnSJsRFGghie2hPy1WSZhYQA5CAn+ZQHeAQIQ13wImGKBmM9kj/7R04+Y4VA2ZU
         GXAK02NUa+NElRf72g/jHInVSmsuamunmUDzhA7V6L5IU/t44r603l+Gqkja9vLX/m2y
         QACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699473918; x=1700078718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7SEpcf1Pb1tiRuUSIyU6UDGCzl70LByBofqTy8eqAI=;
        b=c78p7RWknxEayENUthKrUxDk0Qo80B6jnWTxK8PkyGJ7dlWDFPje1re50zp14YOMtK
         pgzaN42Zw16Xf0bt2O5AU3ekp8hVDmR90Pkf5gHKu5C7Xh/NSS4AlgyZioojDFj9l8Jz
         dkI3hWArCOn6l7Zdd9+lsJzN1AcCcHvi5egaAVitmiGfTtoY3o416xoUgLtBl37rFIjU
         5xxgxZtDSqaaTnVWZiVKBA8wS7r9ASFb3t4qVxYO85rIQpyKSoV3yQsXI5ytk0lHIxuZ
         z8jl48wg/hKwxrcz/X5UY8354MUJtqHUNEeAFSFGdqS2+Sty/bZZczbegFFwSWdjGQYU
         LTfQ==
X-Gm-Message-State: AOJu0YwQehOHe966mvpoGGTLSTY0FM87VJiW8QsbwSGiXg5BTbXK1kz4
	6hRnQF54zlvQSYb5/YoSIMknfBghnuDkwE5pKa1TASo44OU=
X-Google-Smtp-Source: AGHT+IFGu8aKMK4acTo3yOd5x99KccgTAfwODFD4tUWQneqReZVm2v3GuWrMJVFOdpkTJ2lnWKb6TzYMmrzU/M50tOo=
X-Received: by 2002:a05:600c:46ca:b0:408:2f50:f228 with SMTP id
 q10-20020a05600c46ca00b004082f50f228mr2645555wmo.41.1699473917580; Wed, 08
 Nov 2023 12:05:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3e3a8a30-dde0-43a1-981e-2274962780ef@linux.dev> <ba9076bfb983ef96ca78d584ca751b1fef3a06b9.camel@gmail.com>
In-Reply-To: <ba9076bfb983ef96ca78d584ca751b1fef3a06b9.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Nov 2023 12:05:06 -0800
Message-ID: <CAADnVQKvKbLi0rfhEr5jWwaR=wQJZFfassuWa2=w4H56CToeUg@mail.gmail.com>
Subject: Re: bpf selftest pyperf180.c compilation failure with latest last
 llvm18 (in development)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 6:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-10-30 at 20:58 -0700, Yonghong Song wrote:
> > With latest llvm18 (main branch of llvm-project repo), when building bp=
f selftests,
> >     [~/work/bpf-next (master)]$ make -C tools/testing/selftests/bpf LLV=
M=3D1 -j
> >
> > The following compilation error happens:
> >     fatal error: error in backend: Branch target out of insn range
> >     PLEASE submit a bug report to https://github.com/llvm/llvm-project/=
issues/ and include the crash backtrace, preprocessed source, and associate=
d run script.
> >     Stack dump:
> >     0.      Program arguments: clang -g -Wall -Werror -D__TARGET_ARCH_x=
86 -mlittle-endian -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/to=
ols/include -I/home/yhs
> >     /work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/work/bpf-nex=
t/tools/include/uapi -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/=
include -idirafter /hom
> >     e/yhs/work/llvm-project/llvm/build.18/install/lib/clang/18/include =
-idirafter /usr/local/include -idirafter /usr/include -Wno-compare-distinct=
-pointer-types -DENABLE
> >     _ATOMICS_TESTS -O2 --target=3Dbpf -c progs/pyperf180.c -mcpu=3Dv3 -=
o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/pyperf180.bpf.o
> >     1.      <eof> parser at end of file
> >     2.      Code generation
> >     .....
> >
> > The compilation failure only happens to cpu=3Dv2 and cpu=3Dv3. cpu=3Dv4=
 is okay
> > since cpu=3Dv4 supports 32-bit branch target offset.
> >
> > The above failure is due to upstream llvm patch
> >     https://reviews.llvm.org/D143624
> > where some inlining ordering are changed in the compiler.
>
> Hi Yonghong, Alexei,
>
> This is a followup for the off-list discussion. I think I have a
> relatively simple two pass algorithm that allows to replace jumps
> longer than 2**16 by series of shorter jumps using "trampoline"
> goto instructions.
>
> The basic idea of the algorithm is to:
> - Visit basic blocks sequentially from first to last (after LLVM is
>   done with figuring BB ordering), effectively splitting basic blocks
>   in two parts: "processed" and "unexplored".
> - Insert "trampoline" jumps only at "unexplored" side, thus
>   guaranteeing that distances between basic blocks on "processed" side
>   never change.
> - Maintain the list of "pending jumps":
>   - Whenever a basic block is picked from "unexplored" side
>     information about edges coming to and from this basic block is
>     added as pending jumps:
>     - backward edges are added before basic block is processed;
>     - forward edges are added after basic block is processed.
>   - Pending jump is a tuple (off,src,dst,backedge):
>     - 'src', 'dst' - basic blocks (swapped for backedges);
>     - 'off' - current distance from 'src'.
> - When a basic block is picked from "unexplored" side:
>   - discard all pending jumps that have this basic block as 'dst';
>   - peek a pending jump for which jmp.off + bb.size > MAX_JUMP_DISTANCE;
>   - if such jump is present:
>     - split basic block;
>     - insert trampoline instruction;
>     - discard pending jump and schedule new pending jump with
>       trampoline src, original dst, and off=3D0;
>   - if such jump is not present move basic block from "unexplored" to
>     "processed";
>   - when basic block is moved from "unexplored" side to "processed",
>     bump 'off' field of each pending jump by the size of the basic
>     block.
>
> So, the main part is to keep 'off' fields of pending jumps smaller
> than MAX_JUMP_DISTANCE by inserting trampoline jumps.
>
> I have a Python model for this algorithm at [0]. It passes a few
> hand-coded tests but I still need to do some property-based testing.
> I think I need another day to finish with testing, after that it
> should be possible to translate this code to LLVM/C++ in a couple of days=
.

The algorithm doesn't look simple.
Even if we change llvm to do this, it's not clear whether
the verifier will be able to consume such code.
imo it's too much effort to address a non-issue.
I'd just adjust the pyperf180.c test.

