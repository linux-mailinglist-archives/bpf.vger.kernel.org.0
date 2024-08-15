Return-Path: <bpf+bounces-37303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4257A953C62
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB53A1F21D56
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E273E149E15;
	Thu, 15 Aug 2024 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIykPFIK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25019BA53
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756276; cv=none; b=OSgs3InpeGA7h6strGKbZxNNb/yhmwsZ8X4yl4HmDZgxDtkLg7gkAg+ItkdxRsChvU/m7Tku8HGYQG3dPTRGxh+mKHWZWn4gg8409OREgJEk+RcRO9+YIkUbKLpPgQyHP92iNo9KqsGS7Pt2RsUmL5dBfMx8AxdcywXhb99Af6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756276; c=relaxed/simple;
	bh=BxxyiNErKsIQPxqrjQdYYxNs9gwC7RWDTWv77jndrA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeAo8yrL7WuUnQ7oOQDiWOFOr2zINCZwEFagNnE5kprWqhbT+pAyUFLCLqiCCg1eUPNy1z6fPpQIF8Lx1kavn56DPOT3C966FLdNBCLECHklYymPBfP1052pAmxAmmchAkqegya+WWVBpq6+pQrx9N8YjB7k0m61A7qTeWZm7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIykPFIK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3da054f7cso470118a91.1
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723756274; x=1724361074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wmRWJYAl/VYJSwfoOvqmPuKdDxIRp2NroqlkLFgupU=;
        b=kIykPFIK1fQ2kBgqQSz8bslQ10dbrK2e79R0ebJmw+J7msa0wt8YvL0zXi24IGkGZL
         w5KGX1dfJC62RaeLiMnspZBi6xBNDLG9WCV4acleyBc+8U4pB7z9b9Mk3Y5UQKd8Crlb
         vrU3VMNL44IFUM4NoAZjQGRNogs3NRAHRnYhtTBIx8WdFtJbWv6llOaEfWMVI06XbDPJ
         FRj7NEbNi9dSBznnRVc7joWdjAAMpPCxOzt3t87nemldD//kq4LqZ9VvZ6h+e8l7TFu1
         +kTSVJrr8vjDhubrDkZBGsogvKyHgQu/4eMFU7uNrdC1FLwYk4BKzqR5fFoVz278JKQt
         E3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723756274; x=1724361074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wmRWJYAl/VYJSwfoOvqmPuKdDxIRp2NroqlkLFgupU=;
        b=IScEdbl22BbTGWn7vP735bpNecWvSlV82EeUaYdcI6q9a5y0A/z9TvKdBVFfAx2qXt
         mgOiT0tM9N2QHd/2jpya1QOAIgtIP6oNy5VXiCBKozO9V4tboy6iUXokpsnJJdz0NAAX
         L1t8qtV94QpVWvGEn8BpcwbNrg2EwUE3HXz+rlk7i1U2VwhLdquHcUeEqk5F24QuT2MO
         aCn7XpI1MCdSeC/vmA5gMqhicWuTVZpVLWwE09fZS+3hudQnbJILvEaSVJSABQUdH7Uv
         GsFwVzCobTivzW48zqgJdzaxBExrI6+WOkol7XchtYB1PJWfYBCm6Mujk+jZpPUeUepG
         0uRA==
X-Gm-Message-State: AOJu0YwEeAZEWOqt8P3X/SOMHuW61dZYlSNBQ/rMBp++UUByFRFrETUH
	n+J7dorxP3P2VM/ymrPpXU7jCWNIVL1D6p4OnYXlwg56LsrU9NvMFbWhWPb6V8paGDeHQdFth5W
	JaHY76fac3mJkFyM6WO6yfvlDO6tToQ==
X-Google-Smtp-Source: AGHT+IFtQyTeUQqcqh5DjTRqQgLwp2E6pdavd38tKtG4R/BuFWD2bVqQfK1hA0EROAGFBNaSDW5YjvdPyXVQV+QiE8s=
X-Received: by 2002:a17:90a:c098:b0:2cf:c9ab:e740 with SMTP id
 98e67ed59e1d1-2d3dfc6a112mr980129a91.11.1723756274395; Thu, 15 Aug 2024
 14:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809010518.1137758-1-eddyz87@gmail.com> <20240809010518.1137758-4-eddyz87@gmail.com>
In-Reply-To: <20240809010518.1137758-4-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 14:11:02 -0700
Message-ID: <CAEf4BzbWE-Zijtfa-ePSdcaQqYboXfQ5CTLA25DbWGeq8Vq8DA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: __jited_x86 test tag to check
 x86 assembly after jit
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, hffilwlqm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Allow to verify jit behaviour by writing tests as below:
>
>     SEC("tp")
>     __jit_x86("endbr64")
>     __jit_x86("movabs $0x.*,%r9")
>     __jit_x86("add    %gs:0x.*,%r9")
>     __jit_x86("mov    $0x1,%edi")
>     __jit_x86("mov    %rdi,-0x8(%r9)")
>     __jit_x86("mov    -0x8(%r9),%rdi")
>     __jit_x86("xor    %eax,%eax")
>     __jit_x86("lock xchg %rax,-0x8(%r9)")
>     __jit_x86("lock xadd %rax,-0x8(%r9)")
>     __naked void stack_access_insns(void)
>     {
>         asm volatile (... ::: __clobber_all);
>     }
>
> Use regular expressions by default, use basic regular expressions
> class in order to avoid escaping symbols like $(), often used in AT&T
> disassembly syntax.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h |   2 +
>  tools/testing/selftests/bpf/test_loader.c    | 156 +++++++++++++------
>  2 files changed, 112 insertions(+), 46 deletions(-)
>

[...]

> @@ -817,6 +866,21 @@ void run_subtest(struct test_loader *tester,
>                 validate_msgs(tester->log_buf, &subspec->expect_xlated, e=
mit_xlated);
>         }
>
> +       if (arch > 0 && subspec->jited[arch].cnt) {
> +               err =3D get_jited_program_text(bpf_program__fd(tprog),
> +                                            tester->log_buf, tester->log=
_buf_sz);
> +               if (err =3D=3D -ENOTSUP) {

nit: let's use EOPNOTSUPP, ENOTSUP is internal Linux error

> +                       printf("%s:SKIP: jited programs disassembly is no=
t supported,\n", __func__);
> +                       printf("%s:SKIP: tests are built w/o LLVM develop=
ment libs\n", __func__);
> +                       test__skip();
> +                       goto tobj_cleanup;
> +               }
> +               if (!ASSERT_EQ(err, 0, "get_jited_program_text"))
> +                       goto tobj_cleanup;
> +               emit_jited(tester->log_buf, false /*force*/);
> +               validate_msgs(tester->log_buf, &subspec->jited[arch], emi=
t_jited);
> +       }
> +
>         if (should_do_test_run(spec, subspec)) {
>                 /* For some reason test_verifier executes programs
>                  * with all capabilities restored. Do the same here.
> --
> 2.45.2
>

