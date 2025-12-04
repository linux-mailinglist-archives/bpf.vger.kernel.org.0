Return-Path: <bpf+bounces-76089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CCACA51CE
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 20:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD34530791E3
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59312F12DD;
	Thu,  4 Dec 2025 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lvE0ynI1"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A72DF6EA
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764876201; cv=none; b=ol59fUmWs/ibprmhVisHaB7bRCUQRspzWY4gCHfOgkjCWSkwku+TcYZcadNiVQ8uP/6VZRn3Sk9gYvPHOxop5HW3bidtOJG7iyVdm+/HwmABHtwmS+P38qPiB/2kVy6RzjHInIKxclug3k9zIf80LCUUN+xZKfa3jkktkku2ceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764876201; c=relaxed/simple;
	bh=7pSiqUQ0aE25Owr8KVxqEw2Nc2UA5jkORFfpWUV9dkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l73r+jYQtRR0a4AHS8tDsIfp+aOP8UbV/kAk5CYUoDhZhqoxAT7xh0MWSHB25kIorRbZ5/cGbz98wYo/ivLnJErO/PIglzU1EKupAG3ZJ8hIz5QtWbnXmN0YeDkSrqgvVFJu/3ld/m6rxS/MKiU4Gno7iYi+bRySKdlUkZahKQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lvE0ynI1; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2eca9f77-72bf-4808-a1b6-d87be2777537@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764876187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2cstCg4WIhJrfUo/YjWBi9Zxe5Xadh9nAuh/A5TZU4=;
	b=lvE0ynI1DrBNWOQVofMU6NpHj3103DKcPdx6v/mQC6Eh33On7oc06JfWDI1hKbyTfxBwBv
	Gvy9ctnHbvxF+SxA7ogESCeQWmkwFaY7hBW07qNaQy6pXSriqMUaG52Dgyxr+ytM3TrH8H
	cEIZQQjC3P6D5LMQ1e1iSie7L4LIblw=
Date: Thu, 4 Dec 2025 11:22:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: avoid warning for unused register_bpf_struct_ops()
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Arnd Bergmann <arnd@arndb.de>, Kui-Feng Lee <thinker.li@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>, Tao Chen <chen.dylane@linux.dev>,
 Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251204094312.1029643-1-arnd@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251204094312.1029643-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/4/25 1:42 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The macro originally introduced in commit f6be98d19985 ("bpf, net:
> switch to dynamic registration") causes a warning in the new smc code
> because of the way it evaluates the arguments:
> 
> In file included from include/linux/bpf_verifier.h:7,
>                   from net/smc/smc_hs_bpf.c:13:
> net/smc/smc_hs_bpf.c: In function 'bpf_smc_hs_ctrl_init':
> include/linux/bpf.h:2076:50: error: statement with no effect [-Werror=unused-value]
>   2076 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
>        |                                                  ^~~~~~~~~~~~~~~~
> net/smc/smc_hs_bpf.c:139:16: note: in expansion of macro 'register_bpf_struct_ops'
>    139 |         return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);
>        |                ^~~~~~~~~~~~~~~~~~~~~~~
> 
> Work around this using an inline function that takes the argument,
> the same way as the normal implementation. Since the second argument to
> register_bpf_struct_ops() is a type rather than an object, this still
> has to be a macro, but it can call a new inline helper internally like
> the normal one does.

Thanks for the patch. This has been fixed in 
"https://lore.kernel.org/bpf/988c61e5fea280872d81b3640f1f34d0619cfbbf.1764843951.git.geert@linux-m68k.org/" 
to completely remove its usage from smc. The smc usage without 
CONFIG_BPF_JIT was an overlook. This empty register_bpf_struct_ops 
should be removed from the bpf-next tree as a cleanup.


