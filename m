Return-Path: <bpf+bounces-77046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A21EACCDB3B
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DEA730102B5
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 21:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0620C2BDC16;
	Thu, 18 Dec 2025 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sczlcd+o"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16892D0600
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766093638; cv=none; b=TKqlhtr8tXJ42UawgBQDtbMW43ZomW98uyfmtAWXiDPmY3jCwwqbGl3m3kCEGnycV1gwcjhgk11L2ifAKd6HDH+Cq+A5XmJAeKW1jCzrwa45WKhoCY0otrAyo4MtZV+uwhNyLNn7SStIdOqw0UWCPEz4za4ykSTtom2kUL7DHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766093638; c=relaxed/simple;
	bh=nYZswDKyjjC5+c0/UPan8aJWVj96EADwWyqqyvzcic0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHq0ukBC3o7iWVB+0qax1i9hZdPFfVJGSaa2m8ngCKVFU/4ELBivWJent2CBSseXMGYvZxw3KmYlvqFuPVKaAEYSizaJuxR+deyYv/R4dybOGuoQeTLneF/8MeAfRWpJI9+6XYldVGlvjaSdepTUycHw5XiJiUe9//HOrv6fB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sczlcd+o; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9640d2f5-7e6e-4526-a9ab-831bd826f01d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766093623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ouj1OpOD4K/IS1ICDkXQ7vK2eG5wMXCTAmpt1p7VQsE=;
	b=Sczlcd+o0by017x47kGyU6GdcUx922Z5Dh3i/+jJGvXIH9rrBNmPPk8PAcycIEkSQ4g8zE
	Zl4ISesnNNH54sqvt7GWlQy8sWoVtyhS3d4BwmcM/DJ71dOZpsb1cwFshwlK+xTmR1Jviq
	c0FUF3blSOHyMI+fXNDwYhGzRx8XSrU=
Date: Thu, 18 Dec 2025 13:33:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 5/8] kbuild: Sync kconfig when PAHOLE_VERSION
 changes
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrea Righi <arighi@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Bill Wendling <morbo@google.com>,
 Changwoo Min <changwoo@igalia.com>, Daniel Borkmann <daniel@iogearbox.net>,
 David Vernet <void@manifault.com>, Donglin Peng <dolinux.peng@gmail.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Justin Stitt <justinstitt@google.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Nicolas Schier <nsc@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Tejun Heo <tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
 <20251218003314.260269-6-ihor.solodrai@linux.dev>
 <8be2cafa00b759220e73a6ce837ac9a3ff52da1f.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <8be2cafa00b759220e73a6ce837ac9a3ff52da1f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/18/25 11:21 AM, Eduard Zingerman wrote:
> On Wed, 2025-12-17 at 16:33 -0800, Ihor Solodrai wrote:
>> This patch implements kconfig re-sync when the pahole version changes
>> between builds, similar to how it happens for compiler version change
>> via CC_VERSION_TEXT.
>>
>> Define PAHOLE_VERSION in the top-level Makefile and export it for
>> config builds. Set CONFIG_PAHOLE_VERSION default to the exported
>> variable.
>>
>> Kconfig records the PAHOLE_VERSION value in
>> include/config/auto.conf.cmd [1].
>>
>> The Makefile includes auto.conf.cmd, so if PAHOLE_VERSION changes
>> between builds, make detects a dependency change and triggers
>> syncconfig to update the kconfig [2].
>>
>> For external module builds, add a warning message in the prepare
>> target, similar to the existing compiler version mismatch warning.
>>
>> Note that if pahole is not installed or available, PAHOLE_VERSION is
>> set to 0 by pahole-version.sh, so the (un)installation of pahole is
>> treated as a version change.
>>
>> See previous discussions for context [3].
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/kconfig/preprocess.c?h=v6.18#n91
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile?h=v6.18#n815
>> [3] https://lore.kernel.org/bpf/8f946abf-dd88-4fac-8bb4-84fcd8d81cf0@oracle.com/
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
> 
> When building BPF selftest modules the pahole version change was
> detected, but it seems that BTF rebuild was not triggered:
> 
>   $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
>   make[1]: Entering directory '/home/ezingerman/bpf-next'
>   make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/selftests/bpf/test_kmods'
>     CC [M]  bpf_testmod.o
>     CC [M]  bpf_test_no_cfi.o
>     CC [M]  bpf_test_modorder_x.o
>     CC [M]  bpf_test_modorder_y.o
>     CC [M]  bpf_test_rqspinlock.o
>     MODPOST Module.symvers
>     CC [M]  bpf_testmod.mod.o
>     CC [M]  .module-common.o
>     CC [M]  bpf_test_no_cfi.mod.o
>     CC [M]  bpf_test_modorder_x.mod.o
>     CC [M]  bpf_test_modorder_y.mod.o
>     CC [M]  bpf_test_rqspinlock.mod.o
>     LD [M]  bpf_test_modorder_x.ko
>     LD [M]  bpf_testmod.ko
>     LD [M]  bpf_test_modorder_y.ko
>     LD [M]  bpf_test_no_cfi.ko
>     BTF [M] bpf_test_modorder_x.ko
>     LD [M]  bpf_test_rqspinlock.ko
>     BTF     bpf_test_modorder_x.ko
>     BTF [M] bpf_test_no_cfi.ko
>     BTF [M] bpf_test_modorder_y.ko
>     BTF [M] bpf_testmod.ko
>     BTF     bpf_test_no_cfi.ko
>     BTF     bpf_test_modorder_y.ko
>     BTF [M] bpf_test_rqspinlock.ko
>     BTF     bpf_testmod.ko
>     BTF     bpf_test_rqspinlock.ko
>     BTFIDS  bpf_test_modorder_x.ko
>     BTFIDS  bpf_test_modorder_y.ko
>     BTFIDS  bpf_test_no_cfi.ko
>     BTFIDS  bpf_testmod.ko
>     OBJCOPY bpf_test_modorder_x.ko.BTF
>     BTFIDS  bpf_test_rqspinlock.ko
>     OBJCOPY bpf_test_no_cfi.ko.BTF
>     OBJCOPY bpf_test_modorder_y.ko.BTF
>     OBJCOPY bpf_testmod.ko.BTF
>     OBJCOPY bpf_test_rqspinlock.ko.BTF
>   make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/selftests/bpf/test_kmods'
>   make[1]: Leaving directory '/home/ezingerman/bpf-next'
>   [~/bpf-next]
>   $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
>   make[1]: Entering directory '/home/ezingerman/bpf-next'
>   make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/selftests/bpf/test_kmods'
>   make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/selftests/bpf/test_kmods'
>   make[1]: Leaving directory '/home/ezingerman/bpf-next'
> 
> ... update pahole from version 131 to 132 ...
> 
>   [~/bpf-next]
>   $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
>   make[1]: Entering directory '/home/ezingerman/bpf-next'
>   make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/selftests/bpf/test_kmods'
>   warning: pahole version differs from the one used to build the kernel
>     The kernel was built with: 131
>     You are using:             132
>   make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/selftests/bpf/test_kmods'
>   make[1]: Leaving directory '/home/ezingerman/bpf-next'
> 
> Is this an expected behavior?

Yes, it's expected.

I simply repeated the logic used for compiler version change: for
external modules only the warning is printed.

See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile?h=v6.18#n1857



