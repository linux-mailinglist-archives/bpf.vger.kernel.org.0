Return-Path: <bpf+bounces-77259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D8ECD35B8
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 19:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2809030102BA
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 18:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8658B311C27;
	Sat, 20 Dec 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UC4f3Ss4"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A253101C7
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766256942; cv=none; b=aF4EY2V0P6TM0oMk7CYtH4tylxBl+p5FU6B5Ypxn7Vf0yjQQ2EXNl7H/0UZU6tr/Ng7VW2rEfWPb649LPTJbnj+Iikomn8E/IjWV9qwH9iM1970CERP7SeEpYX1VdxbYZQCEceFmhJKC8aEgOmeiNxrzb9VD+Xl8TZMZgJVwWio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766256942; c=relaxed/simple;
	bh=PL4wqyWGvUC3rLlHWxZTYECbhtGlmM5d2Mpowq3sOYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDgYUT8SiVTOD5nW1m8MynO+zz09AUdDEkWbwBxMxnxkgcgQZs+xvnnz2Ljx1hnYWBcQc6xjHZHXlPRtgCMCguv6HgsYfts+gzaj+E1ZHHWD+7wlMe07lk9XN45BzhfpTma0yvW7Wyv0xfDMWS13PJD3PqkMMllI1ZOEoN4RsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UC4f3Ss4; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <47165c76-d856-4c5d-bf2d-6d5a7fe08d43@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766256937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZE0O0LWGwCoQunsy4CgAz5O5+3MKWy0nxMHrqSp7VR4=;
	b=UC4f3Ss4UMw1MG2eD2iCJA7iqiIxlga2tVxSO0CJ5lhARi9+SC2wJQ7LMRFBoHmxgfSMMc
	l1Ffa2hOWU3aNzAvjjSQ9LWhIBnS23q3ZhQ3f+b2Voc/Af8LFch1NAw58H8tRTM5V1n029
	uPHkAAMuHzXD5HCiEvUiZpASzEP7gEk=
Date: Sat, 20 Dec 2025 18:55:32 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: crypto: replace -EEXIST with -EBUSY
To: Daniel Gomez <da.gomez@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Lucas De Marchi <demarchi@kernel.org>, bpf@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Gomez <da.gomez@samsung.com>
References: <20251220-dev-module-init-eexists-bpf-v1-1-7f186663dbe7@samsung.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251220-dev-module-init-eexists-bpf-v1-1-7f186663dbe7@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/12/2025 03:48, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> The -EEXIST error code is reserved by the module loading infrastructure
> to indicate that a module is already loaded. When a module's init
> function returns -EEXIST, userspace tools like kmod interpret this as
> "module already loaded" and treat the operation as successful, returning
> 0 to the user even though the module initialization actually failed.
> 
> This follows the precedent set by commit 54416fd76770 ("netfilter:
> conntrack: helper: Replace -EEXIST by -EBUSY") which fixed the same
> issue in nf_conntrack_helper_register().
> 
> This affects bpf_crypto_skcipher module. While the configuration
> required to build it as a module is unlikely in practice, it is
> technically possible, so fix it for correctness.
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
> The error code -EEXIST is reserved by the kernel module loader to
> indicate that a module with the same name is already loaded. When a
> module's init function returns -EEXIST, kmod interprets this as "module
> already loaded" and reports success instead of failure [1].
> 
> The kernel module loader will include a safety net that provides -EEXIST
> to -EBUSY with a warning [2], and a documentation patch has been sent to
> prevent future occurrences [3].
> 
> These affected code paths were identified using a static analysis tool
> [4] that traces -EEXIST returns to module_init(). The tool was developed
> with AI assistance and all findings were manually validated.
> 
> Link: https://lore.kernel.org/all/aKEVQhJpRdiZSliu@orbyte.nwl.cc/ [1]
> Link: https://lore.kernel.org/all/20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com/ [2]
> Link: https://lore.kernel.org/all/20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com/ [3]
> Link: https://gitlab.com/-/snippets/4913469 [4]

Even though I'm not quite sure that we should care once the core
module loader can adjust the error, the change looks ok to me:

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

