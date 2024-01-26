Return-Path: <bpf+bounces-20437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F305383E639
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 00:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA428286A22
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 23:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA915644F;
	Fri, 26 Jan 2024 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxy5nmzr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D355677D
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 23:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310483; cv=none; b=X3DHcUHFK8S90R0wSZP7iwE2GouCS//aVn12ceBWbG+qweYPjLmyl+nmACCyS++GjCfXYM8gGbfwHMIoUMTOt4J3lF71ds4KbrRbfLhjsX3CwAc2u4Pe31+9EosW29k7phxjJI1P1EMz+GqsHG2nG3zTFId40ndnxYm2oSpOdOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310483; c=relaxed/simple;
	bh=zX4VnoNKI7QmCZJi9ifTlGIMmqma57pjfiZEa8mn1jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLdfXmSJsbWVeDBw2Wa8RgFXssWFNE7tRAv5/G3vIrOqkGF1z7mFh0CcO7+GHNeWfPTkFgsbmU1W8Yg+CNhKYUcFWLz0pDIY6LNAMz1XqblKwAKcyCj1qese5OpsaGfvTYzX9eFmQaTNdaNHLvhWCo+bgcL90RVLBLKxwMSv4MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxy5nmzr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6daa89a6452so673568b3a.2
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 15:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706310481; x=1706915281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kXsIl/ntjeZtlmlRNby6PNNZhaBG8Pe6V2sz7N9GgY=;
        b=Yxy5nmzrEP7r4JvPT3m+weDY/VD5iROx3clLU3a1pOVBR6coKPDRV4VlSfcUIxaXs0
         KnPC2+BNNDNc5Vew3SmLVMHVOTclpIlG64gLdlNt4BJv0/BcQYiszylDpjhwXF//pj32
         bN5puXxilUp7F6n5h7sizfnZ/RRmDy7dU55j76+vCsOgYYBaEBX7A1j+INZtGuJxS3y1
         QY7z6aO8u/Jjmfk1VyxcXBLu90mDrwxZgZy68anb5hBInGDpF/oVIxCzNxL4hKJb3iKK
         WIob/TEcoV7G1KVAaVpzeP6/TcH6XGc2Zkf06D/iLqNtK1SEdJxz+gh8svChcam7YNL4
         UC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310481; x=1706915281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kXsIl/ntjeZtlmlRNby6PNNZhaBG8Pe6V2sz7N9GgY=;
        b=ELzoBqaQtYthLWuMWkn/CX1V/gEMxhIa7b2GcFajcofrsf4Atumnwrqo+cH8djX8QP
         9JbexwWpahEpr14tuCNR/BkQSyY/mywVcgGTJ1H07HJaIB2UzhlWMaj9SST5/pe6nMie
         yr9cLHZEYTlNwvg7aPSK2aN39ZuMhcyfuwf0wQ8i6c6NVaotXXfeXWy41qlFyKrwz+t4
         qSOXtFexbIi6QfZvLvZ/htz7rL8T/TvPuUTl2rJgA2k/M1FE1fIVCfMs6RG4lh3Ix2Sv
         VrrM4FF6dYZSOX54o9QMtIwHg4KJAEqOh2eTiJk2Q0ny1oo25nmOPs1ItBUk3/PbUdwK
         KKMQ==
X-Gm-Message-State: AOJu0YxLKOxcfrA6Rh8ggQano+vTJ6GhUb9BZlvXspFkeQQY4fO7hlNU
	KQhqTvYnVnlR/UYgpo/QXkgPemRKA66SmQGCyq4r181NfZtcpgOM2qECTNDLopsx7EBeEQIyS45
	Sdsi3l27JWTqNUZ6GN1NfylRY/fw=
X-Google-Smtp-Source: AGHT+IEFuAN1P+5cl5et3eADJ3tIVsZen8AQb4Y40aDI3QTUWVN0abg5QC56wQy7f5kl+9slYxcR70GnxXMeueW33VM=
X-Received: by 2002:a05:6a00:23d2:b0:6da:c8b6:29ac with SMTP id
 g18-20020a056a0023d200b006dac8b629acmr557343pfc.16.1706310481168; Fri, 26 Jan
 2024 15:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126185059.4376-1-jose.marchesi@oracle.com>
In-Reply-To: <20240126185059.4376-1-jose.marchesi@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jan 2024 15:07:49 -0800
Message-ID: <CAEf4BzbOqLaFaDdYcfH=TTqnB0doaHz55FxKwBuHyB2oRyxk5A@mail.gmail.com>
Subject: Re: [PATCH] bpf: use -Wno-error in certain tests when building with GCC
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	david.faust@oracle.com, cupertino.miranda@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 10:51=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
> Certain BPF selftests contain code that, albeit being legal C, trigger
> warnings in GCC that cannot be disabled.  This is the case for example
> for the tests
>
>   progs/btf_dump_test_case_bitfields.c
>   progs/btf_dump_test_case_namespacing.c
>   progs/btf_dump_test_case_packing.c
>   progs/btf_dump_test_case_padding.c
>   progs/btf_dump_test_case_syntax.c
>
> which contain struct type declarations inside function parameter
> lists.  This is problematic, because:
>
> - The BPF selftests are built with -Werror.
>
> - The Clang and GCC compilers sometimes differ when it comes to handle
>   warnings.  in the handling of warnings.  One compiler may emit
>   warnings for code that the other compiles compiles silently, and one
>   compiler may offer the possibility to disable certain warnings, while
>   the other doesn't.
>
> In order to overcome this problem, this patch modifies the
> tools/testing/selftests/bpf/Makefile in order to:
>
> 1. Enable the possibility of specifing per-source-file extra CFLAGS.
>    This is done by defining a make variable like:
>
>    <source-filename>-CFLAGS :=3D <whateverflags>
>
>    And then modifying the proper Make rule in order to use these flags
>    when compiling <source-filename>.
>
> 2. Use the mechanism above to add -Wno-error to CFLAGS for the
>    following selftests:
>
>    progs/btf_dump_test_case_bitfields.c
>    progs/btf_dump_test_case_namespacing.c
>    progs/btf_dump_test_case_packing.c
>    progs/btf_dump_test_case_padding.c
>    progs/btf_dump_test_case_syntax.c
>
>    Note the corresponding -CFLAGS variables for these files are
>    defined only if the selftests are being built with GCC.
>
> Note that, while compiler pragmas can generally be used to disable
> particular warnings per file, this 1) is only possible for warning
> that actually can be disabled in the command line, i.e. that have
> -Wno-FOO options, and 2) doesn't apply to -Wno-error.
>
> Tested in bpf-next master branch.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Yonghong Song <yhs@meta.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> ---
>  tools/testing/selftests/bpf/Makefile | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index fd15017ed3b1..8c4282766976 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -64,6 +64,15 @@ TEST_INST_SUBDIRS :=3D no_alu32
>  ifneq ($(BPF_GCC),)
>  TEST_GEN_PROGS +=3D test_progs-bpf_gcc
>  TEST_INST_SUBDIRS +=3D bpf_gcc
> +
> +# The following tests contain C code that, although technically legal,
> +# triggers GCC warnings that cannot be disabled: declaration of
> +# anonymous struct types in function parameter lists.
> +progs/btf_dump_test_case_bitfields.c-CFLAGS :=3D -Wno-error
> +progs/btf_dump_test_case_namespacing.c-CFLAGS :=3D -Wno-error
> +progs/btf_dump_test_case_packing.c-CFLAGS :=3D -Wno-error
> +progs/btf_dump_test_case_padding.c-CFLAGS :=3D -Wno-error
> +progs/btf_dump_test_case_syntax.c-CFLAGS :=3D -Wno-error
>  endif
>
>  ifneq ($(CLANG_CPUV4),)
> @@ -504,7 +513,8 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:      =
                       \
>                      $(wildcard $(BPFDIR)/*.bpf.h)                      \
>                      | $(TRUNNER_OUTPUT) $$(BPFOBJ)
>         $$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,                      \
> -                                         $(TRUNNER_BPF_CFLAGS))
> +                                         $(TRUNNER_BPF_CFLAGS)         \
> +                                         $$(if $$($$<-CFLAGS),$$($$<-CFL=
AGS)))

minor nit, but do you even need the $$(if)? why not just
unconditionally use $$($$<-CFLAGS) which should result in an empty
string, right? Or is there some make weirdness that I'm forgetting?

>
>  $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
>         $$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
> --
> 2.30.2
>

