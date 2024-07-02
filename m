Return-Path: <bpf+bounces-33577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFF891EBDE
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B40283589
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B5F6FCB;
	Tue,  2 Jul 2024 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4BRJ0uB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303223D7
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880901; cv=none; b=nhJoPbMxy7ZLOB7USbQT33aVe30DS2nncIjFqYj3flGreLoaSMHE7e5S59ECvQ9FEEWhbo55xZVJtFb5byUmM60Gfdc19oNn0p4wwB70Z0C0+pbTW8xWe35/rxhXD8sy3cDI2Ii7lWa1tDBa3kzQcolCPjrxPUQMhz87i5/jZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880901; c=relaxed/simple;
	bh=uEyEN+gy7bZ1+guxeDNK1qyNag0mf5Ph83NVfNde3w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPovP1T/W81ma+TGLpLc0n2F7k7Y3effmZlH+hZPn3l4v0gpDRDowgaLQpSLr7XmAFkDkgUqPe7oCystjdz9h1mUQCuJJT8nOhDqAIcR2+1Bzs3NLj9mXe4+O+rWWLDiMt3ORoDTTGH0RQ857r6bUWoxNkQ87ZDQzUR5Sl6bQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4BRJ0uB; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25d10a838f3so1602638fac.1
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 17:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719880899; x=1720485699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhetVVhEXGZHi9fMppc7aP2NUbZMzjmbUkVDPByEZUE=;
        b=L4BRJ0uBzAxzJpwUvpiOEEuZSvHSpJM6u8JQ4SN4nEXvxMFvWlggTS2WVhacwCLcHV
         YPpMAQ6zbKBpCmEPafbCFzu4usGYaNDtlIPeEkIqYf1aMftiwXij1CotvhrsJEHK6W92
         jARjw/6fy3EWptgMC0FR0kbeCi0Ox2N8cSKMtJhBHNKT3L0A6EQ8tq3VogC9YxnGVS5d
         FOiaxD2b944++JwzgvOFG8kheovinmkcTS9vbGJ7hvaL1yGNThUu8hC1pTBrw0MFKJaW
         0mbxfwGdZWiwx02b28jntAPpcI6fJG+MMKwLcFYqLn5c4mtOcFLojIx9sypk4bDctUX7
         Ry4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719880899; x=1720485699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhetVVhEXGZHi9fMppc7aP2NUbZMzjmbUkVDPByEZUE=;
        b=JfO8L/FeH/URN1r9AgMXILmikZyELtLHnL5pL13ksbh04mgnS3qPtTTNqUaw8d9fmH
         Ltm3mffM8dDctcuySsyi6bVw2KMLyGonFYSLNn/ZAc+4W4DfzJPZ5GBTn/ym/RqrGjni
         CAEGWZNgfr0bcLcwqDsBa/lnYfKsgO4IMvUsb8aUg1BJ4RrJAYIkpvYU/lEHKV6YMEUG
         1ictl5mPQhneWJGp4KYDWBJPl9QIXK89/9by4V/O8kjzXiP++SQz61p2iKDGTVqUqHR7
         vNMEavEHVcmHDiRTdIcBjwQq+f3WN8TgAfiYFFlupTgKrMUC2NZo7ovtqZ9Ny0goW0co
         kBWg==
X-Gm-Message-State: AOJu0YxcBjuPg858BaFU/CGv1/812X4yOrEmvyc46Ti//xZ7pOKO3I3a
	SXZNk9ZzxcbQR6wWzjHdhacNLbbsxj3cUJ0YuSmA1fv5zN0z7z4GOSmIiUqjiFsKlsJsMzk27FJ
	5nPOkfHobmPZxwdASKhjruF5HLlLxDg==
X-Google-Smtp-Source: AGHT+IGGnaIr2ja/No06AqaEtSsEoy91P9OIDWbN1hvu/KmKsuIqrDATCFCaNDACejSZFwEtuuMM6WAUr62bABSyJ+I=
X-Received: by 2002:a05:6870:e2ce:b0:254:7a82:cb28 with SMTP id
 586e51a60fabf-25db34dad65mr4845557fac.35.1719880899180; Mon, 01 Jul 2024
 17:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com>
In-Reply-To: <20240629094733.3863850-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 17:41:26 -0700
Message-ID: <CAEf4BzbkhAMYVxJYnv7FQ-fhEKpcN1d0YQ=dz8t+eASBCAxUzw@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 0/8] no_caller_saved_registers attribute for
 helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 2:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> This RFC seeks to allow using no_caller_saved_registers gcc/clang
> attribute with some BPF helper functions (and kfuncs in the future).
>
> As documented in [1], this attribute means that function scratches
> only some of the caller saved registers defined by ABI.
> For BPF the set of such registers could be defined as follows:
> - R0 is scratched only if function is non-void;
> - R1-R5 are scratched only if corresponding parameter type is defined
>   in the function prototype.
>
> The goal of the RFC is to implement no_caller_saved_registers
> (nocsr for short) in a backwards compatible manner:
> - for kernels that support the feature, gain some performance boost
>   from better register allocation;
> - for kernels that don't support the feature, allow programs execution
>   with minor performance losses.
>
> To achieve this, use a scheme suggested by Alexei Starovoitov:
> - for nocsr calls clang allocates registers as-if relevant r0-r5
>   registers are not scratched by the call;
> - as a post-processing step, clang visits each nocsr call and adds
>   spill/fill for every live r0-r5;
> - stack offsets used for spills/fills are allocated as minimal
>   stack offsets in whole function and are not used for any other
>   purposes;
> - when kernel loads a program, it looks for such patterns
>   (nocsr function surrounded by spills/fills) and checks if
>   spill/fill stack offsets are used exclusively in nocsr patterns;
> - if so, and if current JIT inlines the call to the nocsr function

JIT inlines or BPF verifier can inline as well?


>   (e.g. a helper call), kernel removes unnecessary spill/fill pairs;
> - when old kernel loads a program, presence of spill/fill pairs
>   keeps BPF program valid, albeit slightly less efficient.
>
> Corresponding clang/llvm changes are available in [2].
>
> The patch-set uses bpf_get_smp_processor_id() function as a canary,
> making it the first helper with nocsr attribute.
>
> For example, consider the following program:
>
>   #define __no_csr __attribute__((no_caller_saved_registers))
>   #define SEC(name) __attribute__((section(name), used))
>   #define bpf_printk(fmt, ...) bpf_trace_printk((fmt), sizeof(fmt), __VA_=
ARGS__)
>
>   typedef unsigned int __u32;
>
>   static long (* const bpf_trace_printk)(const char *fmt, __u32 fmt_size,=
 ...) =3D (void *) 6;
>   static __u32 (*const bpf_get_smp_processor_id)(void) __no_csr =3D (void=
 *)8;
>
>   SEC("raw_tp")
>   int test(void *ctx)
>   {
>           __u32 task =3D bpf_get_smp_processor_id();
>         bpf_printk("ctx=3D%p, smp=3D%d", ctx, task);
>         return 0;
>   }
>
>   char _license[] SEC("license") =3D "GPL";
>
> Compiled (using [2]) as follows:
>
>   $ clang --target=3Dbpf -O2 -g -c -o nocsr.bpf.o nocsr.bpf.c
>   $ llvm-objdump --no-show-raw-insn -Sd nocsr.bpf.o
>     ...
>   3rd parameter for printk call     removable spill/fill pair
>   .--- 0:       r3 =3D r1                             |
> ; |       __u32 task =3D bpf_get_smp_processor_id();  |
>   |    1:       *(u64 *)(r10 - 0x8) =3D r3 <----------|
>   |    2:       call 0x8                            |
>   |    3:       r3 =3D *(u64 *)(r10 - 0x8) <----------'
> ; |     bpf_printk("ctx=3D%p, smp=3D%d", ctx, task);
>   |    4:       r1 =3D 0x0 ll
>   |    6:       r2 =3D 0xf
>   |    7:       r4 =3D r0
>   '--> 8:       call 0x6
> ;       return 0;
>        9:       r0 =3D 0x0
>       10:       exit
>
> Here is how the program looks after verifier processing:
>
>   # bpftool prog load ./nocsr.bpf.o /sys/fs/bpf/nocsr-test
>   # bpftool prog dump xlated pinned /sys/fs/bpf/nocsr-test
>   int test(void * ctx):
>   ; int test(void *ctx)
>      0: (bf) r3 =3D r1               <--------- 3rd printk parameter
>   ; __u32 task =3D bpf_get_smp_processor_id();
>      1: (b4) w0 =3D 197132           <--------- inlined helper call,
>      2: (bf) r0 =3D r0               <--------- spill/fill pair removed
>      3: (61) r0 =3D *(u32 *)(r0 +0)  <---------
>   ; bpf_printk("ctx=3D%p, smp=3D%d", ctx, task);
>      4: (18) r1 =3D map[id:13][0]+0
>      6: (b7) r2 =3D 15
>      7: (bf) r4 =3D r0
>      8: (85) call bpf_trace_printk#-125920
>   ; return 0;
>      9: (b7) r0 =3D 0
>     10: (95) exit
>
> [1] https://clang.llvm.org/docs/AttributeReference.html#no-caller-saved-r=
egisters
> [2] https://github.com/eddyz87/llvm-project/tree/bpf-no-caller-saved-regi=
sters
>
> Eduard Zingerman (8):
>   bpf: add a get_helper_proto() utility function
>   bpf: no_caller_saved_registers attribute for helper calls
>   bpf, x86: no_caller_saved_registers for bpf_get_smp_processor_id()
>   selftests/bpf: extract utility function for BPF disassembly
>   selftests/bpf: no need to track next_match_pos in struct test_loader
>   selftests/bpf: extract test_loader->expect_msgs as a data structure
>   selftests/bpf: allow checking xlated programs in verifier_* tests
>   selftests/bpf: test no_caller_saved_registers spill/fill removal
>
>  include/linux/bpf.h                           |   6 +
>  include/linux/bpf_verifier.h                  |   9 +
>  kernel/bpf/helpers.c                          |   1 +
>  kernel/bpf/verifier.c                         | 346 +++++++++++++-
>  tools/testing/selftests/bpf/Makefile          |   1 +
>  tools/testing/selftests/bpf/disasm_helpers.c  |  50 ++
>  tools/testing/selftests/bpf/disasm_helpers.h  |  12 +
>  .../selftests/bpf/prog_tests/ctx_rewrite.c    |  71 +--
>  .../selftests/bpf/prog_tests/verifier.c       |   7 +
>  tools/testing/selftests/bpf/progs/bpf_misc.h  |   6 +
>  .../selftests/bpf/progs/verifier_nocsr.c      | 437 ++++++++++++++++++
>  tools/testing/selftests/bpf/test_loader.c     | 170 +++++--
>  tools/testing/selftests/bpf/test_progs.h      |   1 -
>  tools/testing/selftests/bpf/testing_helpers.c |   1 +
>  14 files changed, 986 insertions(+), 132 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/disasm_helpers.c
>  create mode 100644 tools/testing/selftests/bpf/disasm_helpers.h
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_nocsr.c
>
> --
> 2.45.2
>

