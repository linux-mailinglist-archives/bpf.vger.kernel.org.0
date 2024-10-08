Return-Path: <bpf+bounces-41171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9137993C56
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615DB1F249B9
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 01:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B521C695;
	Tue,  8 Oct 2024 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TWIrOZoe"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E914A91
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728351639; cv=none; b=C401nANG4PhaPGnE1DUCMmDuM50EEFeYPfed06BouJ5fg/YH9/S/tae0BZ9w7OCOFdHZAL9fBOHl1e9ffSXLWqCv2irm69eqUtU1ZapqNHXvVofLjkgz1D2ybfGhqN+PPlqlrKaRim1L455TD77wpjkegJrX5eIR2UJiPHHQ4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728351639; c=relaxed/simple;
	bh=eKjkEiK0M8zCM/i2nDpciKQNkUtvOXU3e7KU34edvtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5QkhDkB65ro3ch1f/EmCjf/5iItrslQMSUeTSD7Er/bL53nfrzlD+MHTesUop807jioeCLKdJ1cixLazuI3xnlwZUSEMiurFyYgRqD9BlOJ/4+N/LRzHSjzkDH4IGwx/1DHKBqj/RcNJi24b5kJcX9qFgbjrv51PhfpVPyuroA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TWIrOZoe; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dcf2d5e8-2c10-411e-8a19-d019696a0fbd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728351634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kT40hZD4JeJdpTAirLiYVovjWzYchmhEqCnIfHIpZo=;
	b=TWIrOZoedTiJwPnN13yAhdLo/x0/uj4W+pZG2RBXU9mQQv1+o0nF2SfpPetO3WGfoBHNWh
	6OjJHB1wS9GUug18nACXshxKulXd/ARs8aH/bkvXJNws+zdhtxjHe7I9r+zDwpi+flTiuj
	bIlnz3p5xLDjlPussRkZaC20UZOuwrM=
Date: Tue, 8 Oct 2024 09:40:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Prevent tailcall infinite loop
 caused by freplace
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 xukuohai@huaweicloud.com, eddyz87@gmail.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com
References: <20241006130130.77125-2-leon.hwang@linux.dev>
 <202410080455.vy5GT8Vz-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <202410080455.vy5GT8Vz-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/10/24 04:32, kernel test robot wrote:
> Hi Leon,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-Prevent-tailcall-infinite-loop-caused-by-freplace/20241006-210309
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20241006130130.77125-2-leon.hwang%40linux.dev
> patch subject: [PATCH bpf-next v5 1/3] bpf: Prevent tailcall infinite loop caused by freplace
> config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20241008/202410080455.vy5GT8Vz-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410080455.vy5GT8Vz-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410080455.vy5GT8Vz-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from kernel/fork.c:53:
>    In file included from include/linux/security.h:35:
>>> include/linux/bpf.h:1392:5: warning: no previous prototype for function 'bpf_extension_link_prog' [-Wmissing-prototypes]
>     1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
>          |     ^
>    include/linux/bpf.h:1392:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     1392 | int bpf_extension_link_prog(struct bpf_tramp_link *link,
>          | ^
>          | static 
>>> include/linux/bpf.h:1398:5: warning: no previous prototype for function 'bpf_extension_unlink_prog' [-Wmissing-prototypes]
>     1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
>          |     ^
>    include/linux/bpf.h:1398:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     1398 | int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
>          | ^
>          | static 
>    2 warnings generated.

Ack.

I'll add 'static' in patch v6.

Thanks,
Leon

[...]


