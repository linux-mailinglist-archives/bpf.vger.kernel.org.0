Return-Path: <bpf+bounces-28713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BAA8BD5ED
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57A728544F
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1A215ADB5;
	Mon,  6 May 2024 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ikpy1uEJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3754DDC7
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025377; cv=none; b=p0k/hA5u1CsPWmuiZqHiwqHQTrELcQQ6cq0veZOzopd+kGMt0o3qxauTFzS2Wyi9WY1BEgt5zwiupe76Md7aC+0w3J7y5HOMrr7ArPdoqBOTjeivuLYLE/IK2s1DeHe6wU6iNOm9hK00lQ/aJhERve3JzwYTqK56+6zjTJ78tN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025377; c=relaxed/simple;
	bh=GdLHlcA0WyOFWSkXNV0gxjUxbwPxSNs6nBCYAHaT8og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4xgZFrjHfD7jvQr0hafayHtybMLRKJgbp9uxhHnILWRORg+0z+lTm9MwCynkjXEiUHPy+ltXRTVDakadcFEocXeYz6R/7YAP0b6w5pw8mnF/HTQ4cMFbCPSkCTcdmhg1NIyk65eTYXsfgSiFYn/8Dfs7qbMhU5UpLwkdqiknRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ikpy1uEJ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <feadcc71-126c-48be-b2b6-a9e62a79da39@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715025374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TeFA7672QU9igXRXPwnFFe7xBNRlKTaRQuWiSp8rmDw=;
	b=Ikpy1uEJXfCWdyAxNgc3uVktWnIPQGE5pdwX5kIXdTqccX7OmZVo8wQaIRzy/eqAMNsVQ+
	GxDAkYuXAktiOOa//2Wz22J4UHY9oOBPEMrda1DLM0frbiYrTZjiTfnagpFHjKTmb5KIqz
	66eJnYmWZRi3QnyssvrygmlJ3Hb0QLE=
Date: Mon, 6 May 2024 12:56:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Add CFLAGS per source file
 and runner
Content-Language: en-GB
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>, David Faust <david.faust@oracle.com>,
 Jose Marchesi <jose.marchesi@oracle.com>,
 Elena Zannoni <elena.zannoni@oracle.com>
References: <20240506151829.186607-1-cupertino.miranda@oracle.com>
 <20240506151829.186607-2-cupertino.miranda@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240506151829.186607-2-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/6/24 8:18 AM, Cupertino Miranda wrote:
> This patch adds support to specify CFLAGS per source file and per test
> runner.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>

Ack with a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/testing/selftests/bpf/Makefile | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index ba28d42b74db..e506a5948cc2 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -81,11 +81,11 @@ TEST_INST_SUBDIRS += bpf_gcc
>   # The following tests contain C code that, although technically legal,
>   # triggers GCC warnings that cannot be disabled: declaration of
>   # anonymous struct types in function parameter lists.
> -progs/btf_dump_test_case_bitfields.c-CFLAGS := -Wno-error
> -progs/btf_dump_test_case_namespacing.c-CFLAGS := -Wno-error
> -progs/btf_dump_test_case_packing.c-CFLAGS := -Wno-error
> -progs/btf_dump_test_case_padding.c-CFLAGS := -Wno-error
> -progs/btf_dump_test_case_syntax.c-CFLAGS := -Wno-error
> +progs/btf_dump_test_case_bitfields.c-bpf_gcc-CFLAGS := -Wno-error
> +progs/btf_dump_test_case_namespacing.c-bpf_gcc-CFLAGS := -Wno-error
> +progs/btf_dump_test_case_packing.c-bpf_gcc-CFLAGS := -Wno-error
> +progs/btf_dump_test_case_padding.c-bpf_gcc-CFLAGS := -Wno-error
> +progs/btf_dump_test_case_syntax.c-bpf_gcc-CFLAGS := -Wno-error
>   endif
>   
>   ifneq ($(CLANG_CPUV4),)
> @@ -498,7 +498,7 @@ endef
>   # Using TRUNNER_XXX variables, provided by callers of DEFINE_TEST_RUNNER and
>   # set up by DEFINE_TEST_RUNNER itself, create test runner build rules with:
>   # $1 - test runner base binary name (e.g., test_progs)
> -# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, gcc-bpf, etc)
> +# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
>   define DEFINE_TEST_RUNNER_RULES

The gcc-bpf below also needs an update.

# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, gcc-bpf, etc)
define DEFINE_TEST_RUNNER

>   
>   ifeq ($($(TRUNNER_OUTPUT)-dir),)
> @@ -521,7 +521,8 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
>   		     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
>   	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
>   					  $(TRUNNER_BPF_CFLAGS)         \
> -					  $$($$<-CFLAGS))
> +					  $$($$<-CFLAGS)		\
> +					  $$($$<-$2-CFLAGS))
>   
>   $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
>   	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)

