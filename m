Return-Path: <bpf+bounces-34314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F3292C6C4
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 01:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065751C21E01
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D1D189F30;
	Tue,  9 Jul 2024 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW3ydagg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7031474BE
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720569017; cv=none; b=Mb5VUZ59jvDOYqclXd1OUhSuNgMYCMWInHWgcqwX1RK7FjRERAQS90iw/MBOsk3qbnMUeigYeZMF+TIBYDrfNZZUwWziyk4omGM3/bqK9UuQ04s0+VLloO8NJTVNyh7kdaEoJP+7vLEhsu8GlLsovPz+zAubqxzi5jyejzGQtP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720569017; c=relaxed/simple;
	bh=VB6sZf2NsxD4UEzO92ll/6XixU28bfhsdIQGo8K8UyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eh0bh755D2xuAb31Tm9NhZ35VpeK2IHdd6ByjV53WR6f6SHIv0F/jyGEld9rzbWFNx5d0PlDh2CcWduPqdkCxOrLehpP9w69Dc34X3xdWJ1UcMVtR1FjTkxJRaceJhsO6E2NbfCleOt/YJNAc7LCWzOPmVnELW3FAmczwZepbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW3ydagg; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70af4868d3dso3659043b3a.3
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 16:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720569015; x=1721173815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOsnjFd53hNKgMOl48PFIZ5UuBZdMNJAhk8wnKNJzo8=;
        b=eW3ydaggupMyMccL9ZITbaNhi0QOzqThwz3ncsyiOhJ8tVtE0/jSTSwm6TPm7aKZn9
         rlZz8C8LeCaqD52dEns3avPe3dpK+tnUx/3xZtb7uBJyv5buZ2oiqek+ta2YUTOThamv
         ciLDdgtxHYYrxM03hbof5+FsWb2ySObDFXYuaCX+2n5lM0zX8nyoVGyorQTjQ4G0YB0A
         vk8Fcf6+zg21lq7g2IrowOi0rK9yBjlwqvkH2Nm4SjBtw8Lvru89Q7u0fUVd1hEdQWm0
         j+AbARUw2JOWkJhQ50bzyG24sTU3q4CXtMwcKPxpM+Eo0vcu/kMQAMds5f//ykfoMhrV
         M4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720569015; x=1721173815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOsnjFd53hNKgMOl48PFIZ5UuBZdMNJAhk8wnKNJzo8=;
        b=vCPCriay+t1bgkd7QkbAx9gaW620WXAtMLy/LjZ04A0LuQImhjkaveb85gVpU3bGew
         vg+YaB0mEnKGyM7bwKAaWlM4yLCBwYbF4LetpzRVL3GGnU3TeZVi8NaS1S/UVAdM1Xd6
         E+oPfEcKdlwi27xkNrlYUCOygeGd+6/JOcWjKkq/1OUIAAdTXhYMW15rA+ld0/PT9Dqo
         qdHP80e7m1UEPK3AH1xHuja7ZPPcW3w9L0b+Z2PP3WD08fsfS1okFnFl9jF6ORsIiqUP
         SOUCNk2iTyGMNgpN1js56BrEb8pLrxbA5CV3gtyGa5+bIUmHaNEjhZoqhC4GjZ/67uw/
         Ot7g==
X-Gm-Message-State: AOJu0Yzk3N4zB1KkWZ+hTH0VGGfcngmDN+L0Y3JR7tZ7Ikzq/pNDXSzD
	gxTv2njPFhKeNbLg396rlg/ELj4XF7Dqa8f94ZlUIXfN33xLsXuyZLtKTa+/BVlHpsJQtP5t6hk
	HWYI2tnZ2DKst3VeRrCDjltFDzkk=
X-Google-Smtp-Source: AGHT+IFlHqhS4Z9zEprUQYnhrEWguhDSgXFjoYjioQ/pca2L2+mCpurcV/YfuXx9GMD5ttZ7zBEX95iNx8beYwSLGPE=
X-Received: by 2002:a05:6a00:2d1a:b0:704:2b6e:f10b with SMTP id
 d2e1a72fcca58-70b4357099emr4814386b3a.15.1720569014760; Tue, 09 Jul 2024
 16:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102402.1644916-1-eddyz87@gmail.com> <20240704102402.1644916-9-eddyz87@gmail.com>
In-Reply-To: <20240704102402.1644916-9-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 16:50:03 -0700
Message-ID: <CAEf4BzZWq9=zi=+7MKZEvDvoEsG+DwBY+R_EjQpTe5iBZN9iKw@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 8/9] selftests/bpf: __arch_* macro to limit test
 cases to specific archs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, puranjay@kernel.org, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 3:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Add annotations __arch_x86_64, __arch_arm64, __arch_riscv64
> to specify on which architecture the test case should be tested.
> Several __arch_* annotations could be specified at once.
> When test case is not run on current arch it is marked as skipped.
>
> For example, the following would be tested only on arm64 and riscv64:
>
>   SEC("raw_tp")
>   __arch_arm64
>   __arch_riscv64
>   __xlated("1: *(u64 *)(r10 - 16) =3D r1")
>   __xlated("2: call")
>   __xlated("3: r1 =3D *(u64 *)(r10 - 16);")
>   __success
>   __naked void canary_arm64_riscv64(void)
>   {
>         asm volatile (
>         "r1 =3D 1;"
>         "*(u64 *)(r10 - 16) =3D r1;"
>         "call %[bpf_get_smp_processor_id];"
>         "r1 =3D *(u64 *)(r10 - 16);"
>         "exit;"
>         :
>         : __imm(bpf_get_smp_processor_id)
>         : __clobber_all);
>   }
>
> On x86 it would be skipped:
>
>   #467/2   verifier_nocsr/canary_arm64_riscv64:SKIP
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h |  8 ++++
>  tools/testing/selftests/bpf/test_loader.c    | 43 ++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>

LGTM, just being pedantic below, because why not? ;)

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

> +       spec->arch_mask =3D arch_mask;
> +
>         if (spec->mode_mask =3D=3D 0)
>                 spec->mode_mask =3D PRIV;
>
> @@ -677,6 +701,20 @@ static int get_xlated_program_text(int prog_fd, char=
 *text, size_t text_sz)
>         return err;
>  }
>
> +static bool run_on_current_arch(int arch_mask)
> +{
> +       if (arch_mask =3D=3D 0)
> +               return true;
> +#if defined(__x86_64__)
> +       return !!(arch_mask & ARCH_X86_64);

nit: !! is needed if you assign the result to integer and you want
either 0 or 1 (and not whatever the bit mask value is). In this case
it's well defined that a non-zero value will be implicitly converted
to true for function result, so just `return arch_mask & ARCH_X86_64;`
is totally fine and cleaner.

> +#elif defined(__aarch64__)
> +       return !!(arch_mask & ARCH_ARM64);
> +#elif defined(__riscv) && __riscv_xlen =3D=3D 64
> +       return !!(arch_mask & ARCH_RISCV64);
> +#endif
> +       return false;
> +}
> +
>  /* this function is forced noinline and has short generic name to look b=
etter
>   * in test_progs output (in case of a failure)
>   */
> @@ -701,6 +739,11 @@ void run_subtest(struct test_loader *tester,
>         if (!test__start_subtest(subspec->name))
>                 return;
>
> +       if (!run_on_current_arch(spec->arch_mask)) {
> +               test__skip();
> +               return;
> +       }
> +
>         if (unpriv) {
>                 if (!can_execute_unpriv(tester, spec)) {
>                         test__skip();
> --
> 2.45.2
>

