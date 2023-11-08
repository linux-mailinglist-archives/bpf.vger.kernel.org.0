Return-Path: <bpf+bounces-14454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CBD7E4ECF
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 03:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819491C20B14
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 02:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B91812;
	Wed,  8 Nov 2023 02:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRyjn/0D"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F57EF
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 02:13:55 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A210F5
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 18:13:55 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso10711561a12.3
        for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 18:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699409633; x=1700014433; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QLVB0xnddyCgGQ7oS0htmwM0voMSI3TVj6Bs6EpimJY=;
        b=WRyjn/0DEWLgJONurMBolMwDy3y6pZe5xAUUB0l2LELpqOwDTUtT8OP2hxKjeYigdG
         23KIUJ3/h7hKsWRzIi9Vinecv94hsZgFxftGlfxmw0OOkyvoKPJxrw9OXqn9RQ/4y2KQ
         OL9fiw9tfrJC2Ycr0vZZS8xQb02s26FopIYbrdUilMA3iGWyPRFSmOAZ0PbNNRM0Ilru
         1JG/UiWi0FMUsRdDGRH41iTeACziw2wz4IRJT9QPsB1nNxSrrqPOAolBEFFC0wbFTURg
         NbrZhWb1fEahjN3mLVALdFnnSs1mPGpZKjMjHu9yT+za5h1MAcfknHsR8fW6gdb31L78
         HrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699409633; x=1700014433;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLVB0xnddyCgGQ7oS0htmwM0voMSI3TVj6Bs6EpimJY=;
        b=jDyv1AR0cvOKJ4XyP4sx3Qdyh7VTob4eoN6HmfIEZtrBoJtg1k4v30Kg2AE6H6BEwQ
         mmNCVk13jj7R5UZdSnrGceCvMGHX5qcA23KV5EURVToS9Y4Inoof8sFl2zgDgR1rkW5/
         JatWIpUZZBgcq0sB7HzerqTcE2TJ7vVMDDa9FT0YEcalCtGrfDHu3xYcnFegYj2fitmM
         18NLZSiXpzSz1y2AcawaCkXmakVXc648Nw+xEaMQEEIV/O4CxzaBOvg/8U8oP2sDWDSP
         1Wzf4/3HWLRXwgmW5r0X2dBfmftH24zwsT8JHrlpftPvL1CMsAxgMdOI3jSMY5tXxNvQ
         H2bA==
X-Gm-Message-State: AOJu0Yx/d3hGXG7BQmPVvfpkZ/+0Dd3Q2+nTIfP/87lfliJMLth4EIC1
	CS5Sx66eMenqRk/R4YKRjXYGC28xdqk=
X-Google-Smtp-Source: AGHT+IGdpqezflstMcchv91OtkNTZJ8I914A9BT33lJEBFlrlT+L16zuHAgW3L2ebqi77FinYU6sdw==
X-Received: by 2002:a17:906:4796:b0:9bf:10f3:e435 with SMTP id cw22-20020a170906479600b009bf10f3e435mr348016ejc.1.1699409633105;
        Tue, 07 Nov 2023 18:13:53 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i17-20020a1709061cd100b00992e14af9c3sm274297ejh.143.2023.11.07.18.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:13:52 -0800 (PST)
Message-ID: <ba9076bfb983ef96ca78d584ca751b1fef3a06b9.camel@gmail.com>
Subject: Re: bpf selftest pyperf180.c compilation failure with latest last
 llvm18 (in development)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@kernel.org>, bpf
 <bpf@vger.kernel.org>
Date: Wed, 08 Nov 2023 04:13:50 +0200
In-Reply-To: <3e3a8a30-dde0-43a1-981e-2274962780ef@linux.dev>
References: <3e3a8a30-dde0-43a1-981e-2274962780ef@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-30 at 20:58 -0700, Yonghong Song wrote:
> With latest llvm18 (main branch of llvm-project repo), when building bpf =
selftests,
>     [~/work/bpf-next (master)]$ make -C tools/testing/selftests/bpf LLVM=
=3D1 -j
>=20
> The following compilation error happens:
>     fatal error: error in backend: Branch target out of insn range
>     PLEASE submit a bug report to https://github.com/llvm/llvm-project/is=
sues/ and include the crash backtrace, preprocessed source, and associated =
run script.
>     Stack dump:
>     0.      Program arguments: clang -g -Wall -Werror -D__TARGET_ARCH_x86=
 -mlittle-endian -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tool=
s/include -I/home/yhs
>     /work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/work/bpf-next/=
tools/include/uapi -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/in=
clude -idirafter /hom
>     e/yhs/work/llvm-project/llvm/build.18/install/lib/clang/18/include -i=
dirafter /usr/local/include -idirafter /usr/include -Wno-compare-distinct-p=
ointer-types -DENABLE
>     _ATOMICS_TESTS -O2 --target=3Dbpf -c progs/pyperf180.c -mcpu=3Dv3 -o =
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/pyperf180.bpf.o
>     1.      <eof> parser at end of file
>     2.      Code generation
>     .....
>=20
> The compilation failure only happens to cpu=3Dv2 and cpu=3Dv3. cpu=3Dv4 i=
s okay
> since cpu=3Dv4 supports 32-bit branch target offset.
>=20
> The above failure is due to upstream llvm patch
>     https://reviews.llvm.org/D143624
> where some inlining ordering are changed in the compiler.

Hi Yonghong, Alexei,

This is a followup for the off-list discussion. I think I have a
relatively simple two pass algorithm that allows to replace jumps
longer than 2**16 by series of shorter jumps using "trampoline"
goto instructions.

The basic idea of the algorithm is to:
- Visit basic blocks sequentially from first to last (after LLVM is
  done with figuring BB ordering), effectively splitting basic blocks
  in two parts: "processed" and "unexplored".
- Insert "trampoline" jumps only at "unexplored" side, thus
  guaranteeing that distances between basic blocks on "processed" side
  never change.
- Maintain the list of "pending jumps":
  - Whenever a basic block is picked from "unexplored" side
    information about edges coming to and from this basic block is
    added as pending jumps:
    - backward edges are added before basic block is processed;
    - forward edges are added after basic block is processed.
  - Pending jump is a tuple (off,src,dst,backedge):
    - 'src', 'dst' - basic blocks (swapped for backedges);
    - 'off' - current distance from 'src'.
- When a basic block is picked from "unexplored" side:
  - discard all pending jumps that have this basic block as 'dst';
  - peek a pending jump for which jmp.off + bb.size > MAX_JUMP_DISTANCE;
  - if such jump is present:
    - split basic block;
    - insert trampoline instruction;
    - discard pending jump and schedule new pending jump with
      trampoline src, original dst, and off=3D0;
  - if such jump is not present move basic block from "unexplored" to
    "processed";
  - when basic block is moved from "unexplored" side to "processed",
    bump 'off' field of each pending jump by the size of the basic
    block.

So, the main part is to keep 'off' fields of pending jumps smaller
than MAX_JUMP_DISTANCE by inserting trampoline jumps.

I have a Python model for this algorithm at [0]. It passes a few
hand-coded tests but I still need to do some property-based testing.
I think I need another day to finish with testing, after that it
should be possible to translate this code to LLVM/C++ in a couple of days.

Please let me know if this is interesting.

Thanks,
Eduard

[0] https://gist.github.com/eddyz87/7e8d162b2bb2071769a9b3d960898405

[...]

