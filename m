Return-Path: <bpf+bounces-47962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7C4A028DD
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 16:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2524118854D9
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6579F13775E;
	Mon,  6 Jan 2025 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ie82BHIr"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50B286352
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176497; cv=none; b=X4F5yHR5E7kcsMpasYQ0yuyTmgmFKWQbYTl8i9NJq29j4wtsWvmrLMwZwMmT4zwaMWQFQqxL6gugCZWH1bUe97Gl8oNYLKvdfLIo6inMzxnFgJE0aBb/a+IyHTSZAjNzDJZrjQ1vLHssU2iZ2lPDZn9W8nt4V0KOX/uBExZIoUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176497; c=relaxed/simple;
	bh=cpzbqhh3mA0rOaY+WY9ebE296loNdJMp0REVc1ZkjCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPozm4uO+7ViWLleUoi2ycLIXx08TVo9ygPRxBgi3UOQWpBE1/g+DO1PvLzdgra8Dv1z1036/lLKRjSIWFYi07Z5VilGkZ2w1WPHOFh6sba3zU3lZV9qytHlyLcRsUn+tK9RJ6Q7RLUTCB936XK7+H4d3b3PXqxlgob6bRTU5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ie82BHIr; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sNlE5TgJeFUH2kGL+Ndx1G5F6UB91J/4Otd3aS7qpGo=; b=ie82BHIrvoXB9fyijgjxGjnQoB
	plfzqUcXX5HP5tVxhTFPjo/8KBxSk/e7bjfoc3FMWN8qyPMVgnjOBU0Z/3tC/11g/CuMBv2mRFU80
	oq/kva5myjlEypNepMC1d3TAAgebivqICM6tMSNtDpl5S0jzkgqG5m39b/wL8ATyv64tdKS9Slpez
	M0HcFpUceOiZ5UUtZm06ZI4FTk7KtsF9hiiukr3WUZJDDyY14NOvyHRi0Uc04VokxzO24cP15fSVm
	k7ZWnF5+QUFldAk1qkdwr2SxvifAQK0tjkK3RY5Jsm9cfJet9QHZHPZvIq2i+T4drAf55kQ0EyAXq
	d91Ih8JA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tUofa-0000TZ-S6; Mon, 06 Jan 2025 16:05:30 +0100
Received: from [178.197.248.26] (helo=[192.168.1.114])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1tUofa-0004p5-0a;
	Mon, 06 Jan 2025 16:05:30 +0100
Message-ID: <ac06c94d-34a9-4606-a2d6-196575d3877e@iogearbox.net>
Date: Mon, 6 Jan 2025 16:05:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: workarounds for GCC BPF build
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 jose.marchesi@oracle.com
References: <20250104001751.1869849-1-ihor.solodrai@pm.me>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250104001751.1869849-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27510/Mon Jan  6 10:45:39 2025)

On 1/4/25 1:17 AM, Ihor Solodrai wrote:
> Various compilation errors happen when BPF programs in selftests/bpf
> are built with GCC BPF. For more details see the discussion at [1].

Thanks for the patch!

> The changes only affect test_progs-bpf_gcc, which is built only if
> BPF_GCC is set:
>    * Pass -std=gnu17 when  to avoid errors on bool
>      types declarations in vmlinux.h
>    * Pass -nostdinc for tests that trigger int64_t declaration
>      collision due to a difference between gcc and clang stdint.h
>    * Pass -Wno-error for tests that trigger uninitialized variable
>      warning pm BPF_RAW_INSNS
> 
> [1] https://lore.kernel.org/bpf/EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2qi6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=@pm.me/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

[ pls also add Jose to Cc (done here) ]

> ---
>   tools/testing/selftests/bpf/Makefile | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 9e870e519c30..2e1fe53efa83 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -103,6 +103,15 @@ progs/btf_dump_test_case_packing.c-bpf_gcc-CFLAGS := -Wno-error
>   progs/btf_dump_test_case_padding.c-bpf_gcc-CFLAGS := -Wno-error
>   progs/btf_dump_test_case_syntax.c-bpf_gcc-CFLAGS := -Wno-error
>   
> +# Uninitialized variable warning on BPF_RAW_INSN
> +progs/verifier_bpf_fastcall.c-CFLAGS := -Wno-error
> +progs/verifier_search_pruning.c-CFLAGS := -Wno-error

See previous feedback from Jose:

   Ignoring the warning doesn't cure the resulting undefined behavior.
   These selftests seems to be violating strict aliasing rules, so it is
   better to either change the testcase to work well with anti-aliasing
   rules or to disable strict aliasing, like it is done for many other
   tests already:

   progs/verifier_bpf_fastcall.c-CFLAGS := -fno-strict-aliasing
   progs/verifier_search_pruning.c-CFLAGS := -fno-strict-aliasing

> +# int64_t declaration collision
> +progs/test_cls_redirect.c-CFLAGS := -nostdinc
> +progs/test_cls_redirect_dynptr.c-CFLAGS := -nostdinc
> +progs/test_cls_redirect_subprogs.c-CFLAGS := -nostdinc

iiuc, this hunk is not needed given [1] got merged which addresses the
collision issue already?

   [0] https://lore.kernel.org/bpf/87pll3c8bt.fsf@oracle.com/
   [1] https://gcc.gnu.org/pipermail/gcc-patches/2025-January/672508.html

>   # The following tests do type-punning, via the __imm_insn macro, from
>   # `struct bpf_insn' to long and then uses the value.  This triggers an
>   # "is used uninitialized" warning in GCC due to strict-aliasing
> @@ -507,7 +516,7 @@ endef
>   # Build BPF object using GCC
>   define GCC_BPF_BUILD_RULE
>   	$(call msg,GCC-BPF,$4,$2)
> -	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2
> +	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -std=gnu17 -c $1 -o $2
>   endef
>   
>   SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c


