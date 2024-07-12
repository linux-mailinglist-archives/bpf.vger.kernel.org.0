Return-Path: <bpf+bounces-34657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C556392FD86
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 17:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1F21F2440A
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2372017335C;
	Fri, 12 Jul 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GttT44Lu"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4017107F
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797989; cv=none; b=rVixSm/SaSRH/NWoyv3QCGVxFP2/yuzXO8vjDKd4UqnsiiDBO7xSBDYu8Bnmh8SV6vcLz2/Xq7YpypgpkFYQR4w9o+R0WjDhSltfmrjYEu9h1BIB2/gPZARKvFIV+kLS3lR0y3MSrLQNQ7gcQjGs7VhKTk4gF2dDwNd0aQOio/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797989; c=relaxed/simple;
	bh=a8awJnW1JoiaVPDnCWtFA0HaSnb2c6HrP0PgQ38fN1Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jJ3TgdlmvTWQ97R9LjxFABJJQvhQb3GWGF00fS8Ec9+jZoM6TYqywYbEygbLeJXRWJPQj+v84C3doO6J3MBF441gwJ6TSVK2bB5SC/ywa/WbDp+fxDf5LLVTy0xACLpl3IWi7YbEFASFqd5sXPEE1gic3qcu5RjfHXVlIr2021s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GttT44Lu; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=goqfKM0Jd9ltOnZHJhyFQyHi6GTJf1Wy0j4hXQC1GbA=; b=GttT44Lu1XNQiyOXkKWBuiYhTl
	otXvKUHV5QxeKglB1ifNPxqA8XArX7bjmANsq1ZoxFLR1Z2Vs7eg9rdnw3qlL0QWz11kcfbJAO75f
	4Dq22fwgfhQNmt7eUH9WlTiVFtxyhOXNcXhqYUEZHKYt4y69IHG8rbHXt2Nd8EmFkpGepK37ihiJf
	bPZ0fUrTRB6SVGNhLWq4QFd4M+lfVctnLYOyZSXfWhKuVIpAj1cZeZ8mzuWo6ncVyIsIEAF6zilGm
	zxJkhOy7vfloU4amNrKINfgqpfY1o+c/QJ3jIU/fh4tlW3APXDp9jW0uPlP/NORG5t/jO62FdtyHL
	+eDxPdag==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sSIAB-000Eps-Df; Fri, 12 Jul 2024 17:26:23 +0200
Received: from [178.197.248.35] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sSIAB-0003sN-02;
	Fri, 12 Jul 2024 17:26:23 +0200
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for test
 objects
To: Ihor Solodrai <ihor.solodrai@pm.me>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc: "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org"
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 "mykolal@fb.com" <mykolal@fb.com>
References: <gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net>
Date: Fri, 12 Jul 2024 17:26:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27334/Fri Jul 12 10:35:53 2024)

On 7/12/24 6:36 AM, Ihor Solodrai wrote:
> Make use of -M compiler options when building .test.o objects to
> generate .d files and avoid re-building all tests every time.
> 
> Previously, if a single test bpf program under selftests/bpf/progs/*.c
> has changed, make would rebuild all the *.bpf.o, *.skel.h and *.test.o
> objects, which is a lot of unnecessary work.
> 
> A typical dependency chain is:
> progs/x.c -> x.bpf.o -> x.skel.h -> x.test.o -> trunner_binary
> 
> However for many tests it's not a 1:1 mapping by name, and so far
> %.test.o have been simply dependent on all %.skel.h files, and
> %.skel.h files on all %.bpf.o objects.
> 
> Avoid full rebuilds by instructing the compiler (via -MMD) to
> produce *.d files with real dependencies, and appropriately including
> them. Exploit make feature that rebuilds included makefiles if they
> were changed by setting %.test.d as prerequisite for %.test.o files.
> 
> A couple of examples of compilation time speedup (after the first
> clean build):
> 
> $ touch progs/verifier_and.c && time make -j8
> Before: real	0m16.651s
> After:  real	0m2.245s
> $ touch progs/read_vsyscall.c && time make -j8
> Before: real	0m15.743s
> After:  real	0m1.575s
> 
> A drawback of this change is that now there is an overhead due to make
> processing lots of .d files, which potentially may slow down unrelated
> targets. However a time to make all from scratch hasn't changed
> significantly:
> 
> $ make clean && time make -j8
> Before: real	1m31.148s
> After:  real	1m30.309s
> 
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> 
> ---
> v1 -> v2: Make %.test.d prerequisite order only

Looks like BPF CI trips over this and various tests are failing :

https://github.com/kernel-patches/bpf/actions/runs/9902529566/job/27356664649

[...]
Tests exit status: 1
Notice: Success: 538/3821, Skipped: 62, Failed: 5
Error: #66 core_reloc
Error: #66/4 core_reloc/flavors
   Error: #66/4 core_reloc/flavors
   run_core_reloc_tests:FAIL:btf_src_file unexpected error: -1 (errno 2)
Error: #66/5 core_reloc/flavors__err_wrong_name
   Error: #66/5 core_reloc/flavors__err_wrong_name
   run_core_reloc_tests:FAIL:btf_src_file unexpected error: -1 (errno 2)
Error: #66/6 core_reloc/nesting
   Error: #66/6 core_reloc/nesting
   run_core_reloc_tests:FAIL:btf_src_file unexpected error: -1 (errno 2)
Error: #66/7 core_reloc/nesting___anon_embed
Error: #66/8 core_reloc/nesting___struct_union_mixup
Error: #66/9 core_reloc/nesting___extra_nesting
[...]

