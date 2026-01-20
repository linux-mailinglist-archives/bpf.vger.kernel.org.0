Return-Path: <bpf+bounces-79564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2061D3C0B2
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7189D504921
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8FC349AF3;
	Tue, 20 Jan 2026 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQuKCGG9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C328E3933F1
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893696; cv=none; b=YI1oqjaHUAcyQ1LDJazL49q2Nr+1xc2rhVmSAl8XZa+j6AV6MVqndCELlU5N0qIZT83u5sJ5jBMhcLVSS81eRJn2ZrAF7jR+/qeAxChVr+WMT6GkGmCk8VkfYX/0MZuIPfSZwo1e+PvNWvNz9KYXG7kVwoz9fO0PMikmb61A0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893696; c=relaxed/simple;
	bh=IiKKHrjAyXzBuRChdERfkPIO04skMHckjGG2V96xVWk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=X1O/8ckhEA+/Hm2fMvJtch4hy2gUAey7u4cfVf5KwRCdubYwKOVRxf9KLTRHIEM1TS8TWMNxx77DGS8CeSztDZVMwWXh8Vtf8F7nzggcG+iM5K1/01Pd+OiOAJe9V8utuL+4351SOippObyIsdByARugbD00anr1uUoRgVCFZ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQuKCGG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D927C19423;
	Tue, 20 Jan 2026 07:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768893695;
	bh=IiKKHrjAyXzBuRChdERfkPIO04skMHckjGG2V96xVWk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NQuKCGG96/E2EdYw0fgrEA01j2cL5T1BOsTiZLxbHQWlcWb7bVXmUDMrnciflFWez
	 v0M/32GXh1K1F406KxI1ScOS22Fl8tjYIBATjnudaz2IXF5epfEvlBd+otK8zEShLh
	 i0wLlqriw3nJRI1IJHHevHPLg59XC7Gkv2YcLnZJM92p66AqQl0JS+4wr2hcN+Ztl/
	 oaK/Kl+dxaNVeGJ59886KbLXC6eqts2OJpEa8X10Cj21RgIWhx3gdQg8fg1BSmhUll
	 VcHHIGA8lnToZYnWGvGj9HzfibB3o3NaOR2HXon1uRSMZUY5zcPYLP4R4c6lDkt2wT
	 fYBh7XsS4GceA==
Content-Type: multipart/mixed; boundary="===============3841356428339370441=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cd994531bcbe33858623d135448bd0540c36bb739b894af5a99d009b617e08fb@mail.kernel.org>
In-Reply-To: <20260120070336.188850-2-ishiyama@hpc.is.uec.ac.jp>
References: <20260120070336.188850-2-ishiyama@hpc.is.uec.ac.jp>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strncasecmp kfunc
From: bot+bpf-ci@kernel.org
To: ishiyama@hpc.is.uec.ac.jp,bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com,vmalik@redhat.com,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,ishiyama@hpc.is.uec.ac.jp,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 20 Jan 2026 07:21:34 +0000 (UTC)

--===============3841356428339370441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9eaa4185e0a7..753753f039ff 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
>  {
>  	char c1, c2;
> -	int i;
> +	int i, max_sz;
>
>  	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
>  	    !copy_from_kernel_nofault_allowed(s2, 1)) {
>  		return -ERANGE;
>  	}
>
> +	max_sz = min_t(int, len, XATTR_SIZE_MAX);
                   ^^^

Can this truncation cause incorrect results when len > INT_MAX? The len
parameter is size_t, but min_t(int, ...) casts it to signed int before the
comparison. When len is larger than INT_MAX, the cast produces a negative
value, and min_t returns that negative value instead of XATTR_SIZE_MAX.

For example, if a BPF program calls bpf_strncasecmp(s1, s2, SIZE_MAX):
- min_t(int, SIZE_MAX, 65536) evaluates to min_t(int, -1, 65536) = -1
- max_sz becomes -1
- The loop condition (i < max_sz) is (0 < -1), which is false
- The loop never executes, and the function returns 0 without comparing

This would make bpf_strncasecmp("foo", "bar", SIZE_MAX) return 0 (equal)
when the strings are clearly different.

Would using min_t(size_t, len, XATTR_SIZE_MAX) avoid this issue?

> +
>  	guard(pagefault)();
> -	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +	for (i = 0; i < max_sz; i++) {

[ ... ]

> +__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__ign, size_t len)
> +{
> +	return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
>  }

The BPF verifier does not validate ranges for scalar kfunc parameters, so
BPF programs can pass arbitrary size_t values to len, triggering the
truncation issue described above.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21162711653

--===============3841356428339370441==--

