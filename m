Return-Path: <bpf+bounces-47857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C254A01129
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 00:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 898907A1CA9
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 23:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC561C303A;
	Fri,  3 Jan 2025 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYJJlzkz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BE7180A80
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 23:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735948612; cv=none; b=PDvJ8iBwir/m6Xd5t/8CgJqD2HFV07iZGx/vL2oTGKZbvdb3LkzEsNLvf7/iBbv6qJviFM0EzR1/19U+rzrZsAerg48d9LekyDEuN3ruJ0/M6s93r/QAW2z9HiKxkEem5FJVCDSiS4CqKq3dm4IQO9OZhnb+b5zedpkKZqWHBpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735948612; c=relaxed/simple;
	bh=IKC1i38za1h7iPZypGhQ3X8S9EikjCXfyf9HnUZ4dnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4mls4FTWEsIpYry554ZQ2BQNy7n94aAxfmd804CY6AqV2kXj8hc4n5xWv7YcM53hOb8fODVefcHapE0+zFnNK+cl00rmymnCyLwjGmYKZjUIaudfIshQLsNEz08Cq6Qoi1GYCNKnyNSH/P6pKZm3aEnRlw+Qx/6sMjmhgxdc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYJJlzkz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so14415477a91.3
        for <bpf@vger.kernel.org>; Fri, 03 Jan 2025 15:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735948610; x=1736553410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj+7SZZFezGg0Q16gxuL+Z5MkYcNLSZGECvQnYpb5tc=;
        b=gYJJlzkzmlMM3tjKj8OWY0zgm7jeqefM4rzUw6ubfgRQ1iCoOWWz1TfRv3XUqZvZ85
         eJ4JSUFshPwhgr9PnfM6S2VbkcZwlsWzKw5MM3HFjqUAB5luWlS9asinfz2Id0tD3HfY
         TZw5cucYjMUe+GUvWy6xgF588UZQfrlpWiD6CmLNdmAxBLsLWYSqFLlvT6r/VXjhsMiy
         ktS+tq1qHI1BaN5jjFnQwOvEr690AxbT87kFG3kb/V0SP7XRno8X9l2I0DzUQ5XNGh1v
         0r/eYh/awxf3SVlRAZPAIXjNZFIvRlKg6z1I8h7+TqsBnFIajz3GpXrFn973xASaFiAg
         rEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735948610; x=1736553410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cj+7SZZFezGg0Q16gxuL+Z5MkYcNLSZGECvQnYpb5tc=;
        b=gY9Mpp/avK/v27nTwOdsFjbNxrTZTD6iqDq4nWaWBZH9Ss+NJ80SUy19r3G7cLab0i
         NogX7S9ggQ3OfkU8RbjEyoI/tYZDNDKeDiQun7U5eDfdtD1SOzv1/2XRiAu27qOdDXJa
         7LWvz0TRUkt16VJmjbm33GEWnlF8iK3m52EBuAu+boD3HDOAHC0IP2gz8du8W/ed1z28
         jozw/+yAVgAnKkhio8NyJaPAqqlrTwu7DEVy9HaHkX6Q8fESD3wMO46KGs6nMGq4bmyp
         OJFSuwiFRYTkwe3oN5IofRwJnPsDdBVcufq1yPbz2dxywAMyW2pO2cwcrlx+ABiagix4
         erJQ==
X-Gm-Message-State: AOJu0YxA+yXvJUhwDXRWKHFeqgsKYrHTXjVmAh4BQj3ziucFpEH4BHb1
	k92t1PaMrRAndYV7g/2tN8GCgc9IPkbqN1Oxn/wmohxEXoV6hiMVRSr1JhibML3Xxosg9K1JY9k
	yBgMLSRCqzDw3ugNgVzQjr5S8IAQ=
X-Gm-Gg: ASbGncvQwb/un/rW+HrE6fCi3pWrd4Rz/vl7qeZSnYI6ZvlO+gTEqmjmEH4BD0dGmpR
	FeWJh0IZm2ylIvTb+PQ7APKlHu9wIDyCBylo=
X-Google-Smtp-Source: AGHT+IEY52r06Wb43ApQrsWHoZUEYk19uroxmv1YWk1bq0zUChC4+PahpF9hmzVUPm1a33P79H8+jdW0PdaxUrvntss=
X-Received: by 2002:a17:90b:3d45:b0:2eb:140d:f6df with SMTP id
 98e67ed59e1d1-2f452dfcd01mr73286051a91.1.1735948609717; Fri, 03 Jan 2025
 15:56:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
 <EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2qi6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=@pm.me>
In-Reply-To: <EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2qi6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=@pm.me>
From: Andrew Pinski <pinskia@gmail.com>
Date: Fri, 3 Jan 2025 15:56:38 -0800
Message-ID: <CA+=Sn1ncCUyMM=2wY_O3BJKa7wfJHBahp_Zsm75gapqoK8ggAQ@mail.gmail.com>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf <bpf@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>, David Faust <david.faust@oracle.com>, 
	Elena Zannoni <elena.zannoni@oracle.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Manu Bretelle <chantra@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Sam James <sam@gentoo.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 3:48=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me> =
wrote:
>
> Hi everyone.
>
> I built and ran selftests/bpf with GCC 15-20241229, and would like to
> share my findings.
>
> Building required small adjustments in the Makefile, besides -std=3Dgnu17
>
> With the following change we can mitigate int64_t issue:
>
> +progs/test_cls_redirect.c-CFLAGS :=3D -nostdinc
> +progs/test_cls_redirect_dynptr.c-CFLAGS :=3D -nostdinc
> +progs/test_cls_redirect_subprogs.c-CFLAGS :=3D -nostdinc
>
> Then, the compiler complains about an uninitialized variable in
> progs/verifier_bpf_fastcall.c and progs/verifier_search_pruning.c
> (full log at [1]):
>
>     In file included from progs/verifier_bpf_fastcall.c:7:
>     progs/verifier_bpf_fastcall.c: In function =E2=80=98may_goto_interact=
ion=E2=80=99:
>     progs/bpf_misc.h:153:42: error: =E2=80=98<Uc098>=E2=80=99 is used uni=
nitialized [-Werror=3Duninitialized]
>       153 | #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
>           |                                          ^~~~~~~~~~~~~~~~
>     progs/verifier_bpf_fastcall.c:652:11: note: in expansion of macro =E2=
=80=98__imm_insn=E2=80=99
>       652 |           __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCO=
ND, 0, 0, +1 /* offset */, 0))
>           |           ^~~~~~~~~~
>     /ci/workspace/tools/testing/selftests/bpf/../../../include/linux/filt=
er.h:299:28: note: =E2=80=98({anonymous})=E2=80=99 declared here
>       299 |         ((struct bpf_insn) {                                 =
   \
>           |                            ^
>     progs/bpf_misc.h:153:53: note: in definition of macro =E2=80=98__imm_=
insn=E2=80=99
>       153 | #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
>           |                                                     ^~~~
>     progs/verifier_bpf_fastcall.c:652:32: note: in expansion of macro =E2=
=80=98BPF_RAW_INSN=E2=80=99
>       652 |           __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCO=
ND, 0, 0, +1 /* offset */, 0))
>
> BPF_RAW_INSN expands into struct init expr (include/linux/filter.h):
>
>     #define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM)                      \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D CODE,                                  \
>                 .dst_reg =3D DST,                                 \
>                 .src_reg =3D SRC,                                 \
>                 .off   =3D OFF,                                   \
>                 .imm   =3D IMM })

That: `*(long *)&(expr)` is 100% undefined behavior there since it is
an alias violation.
I suspect you should use an union instead,

something like:
#define __imm_insn(name, expr) [name]"i"(((union { struct bpf_insn
insn_s; long insn; }){.insn_s =3D (expr)}).insn)

Should fix the issue.

Thanks,
Andrew



>
> This can be silenced with:
>
> +progs/verifier_bpf_fastcall.c-CFLAGS :=3D -Wno-error
> +progs/verifier_search_pruning.c-CFLAGS :=3D -Wno-error
>
> Then the selftests/bpf build completes successfully, although libbpf
> prints a lot of warnings like these on GEN-SKEL:
>
>     [...]
>     libbpf: elf: skipping section(3) .data (size 0)
>     libbpf: elf: skipping section(4) .data (size 0)
>     libbpf: elf: skipping unrecognized data section(13) .comment
>     libbpf: elf: skipping unrecognized data section(9) .comment
>     libbpf: elf: skipping unrecognized data section(12) .comment
>     libbpf: elf: skipping unrecognized data section(7) .comment
>     [...]
>
> Test .bpf.o files are compiled regardless. Full log at [2].
>
> Running all tests at once, as is usually done on CI, produces a too
> cluttered log. I wrote a script to run each test individually in a
> separate qemu instance and collect the logs.
>
> 187/581 of toplevel tests fail on current bpf-next [3]. Many tests
> have subtests: toplevel test passes if all of its subtests pass.
>
> You can find the archive with per-test logs at [4].
>
> [1] https://gist.github.com/theihor/10b2425e6780fcfebb80aeceafba7678
> [2] https://gist.github.com/theihor/9e96643ca730365cf79cea8445e40aeb
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/comm=
it/?id=3D96ea081ed52bf077cad6d00153b6fba68e510767
> [4] https://github.com/kernel-patches/bpf/blob/8f2e62702ee17675464ab00d97=
d89d599922de20/tools/testing/selftests/bpf/gcc-bpf-selftests-logs.tgz
>

