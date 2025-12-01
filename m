Return-Path: <bpf+bounces-75835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B414C99006
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 21:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9ECA9345B60
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 20:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1024886E;
	Mon,  1 Dec 2025 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rtjk5dBA"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6AB21A447
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764620553; cv=none; b=BhBkVIwFGws9IdZGm/gPvBTjGQg+S6KbDaikVYPWpwRwaj34jgyQndgzvPpZI7DHmfDbAjcdWgc2URJD3u8JyuT0ka0nZIPyItaQw9CY6FB7dTEZ5hh9ZLFmCTSmXxKHGqUCSv4L7m6auYnuTsiElaAJ0vnpnBYdK/E1Yp+hzbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764620553; c=relaxed/simple;
	bh=mTbQkFVj+nI0QJd3Oa1HZ65Qn5yr/GiBZC0yRclxHxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMtMmkuo8pG4lZjcQOZr9MGnG7aAqwnRtwc1GcnTG1HPWI5CC0TGRXDhNC5Lqtx2OB3DeP0/ZVODGNdgrd0vmcL9XKvtfEyRBns4UgnsV0gSgB0zAwY7K246mbGGEMkVqWwOU+DPBOnXorB/xXW6T/s7sAh0OqElHIfr26N3OHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rtjk5dBA; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd71a6ff-929d-4958-ac73-99b4852808e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764620548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7392S/03QT6Tj0P5YQ6SV7X4VozDZVvEOP2gEGZCW8=;
	b=rtjk5dBA+9Oti9FExT2JdCF87YXgP0d2vd9RBL0W2OGBtcmbnfMjMqopxpVKPghswk6Wm+
	J/AuAB2g/7/C+qIeoNsRI6L/DoPV5M1Rf1035cCvtPmZjsDo3Nyth1hg6ji/2uO8clNGy9
	mzni/KTYPMPga+zpR4jOFwoUCeYhMcE=
Date: Mon, 1 Dec 2025 12:21:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpf: Race condition in bpf_trampoline_unlink_cgroup_shim during
 concurrent cgroup LSM link release
To: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>,
 Stanislav Fomichev <sdf@fomichev.me>
Cc: daniel@iogearbox.net, hust-os-kernel-patches@googlegroups.com,
 dddddd@hust.edu.cn, dzm91@hust.edu.cn, ast@kernel.org, bpf@vger.kernel.org
References: <3c4ebb0b.46ff8.19abab8abe2.Coremail.kaiyanm@hust.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <3c4ebb0b.46ff8.19abab8abe2.Coremail.kaiyanm@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/25/25 3:14 AM, 梅开彦 wrote:
> Our fuzzer discovered a race condition vulnerability in the BPF subsystem, specifically in the release path for cgroup-attached LSM programs. When multiple BPF cgroup links attached to the same LSM hook are released concurrently, a race condition in `bpf_trampoline_unlink_cgroup_shim` can lead to state corruption, triggering a kernel warning (`ODEBUG bug in __init_work`) and a subsequent kernel panic.
> 
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> 
> ## Vulnerability Description
> 
> The vulnerability is triggered when multiple threads concurrently close file descriptors corresponding to `bpf_cgroup_link`s that share a common underlying `bpf_shim_tramp_link`. The `bpf_link_put` function, which is called during the release path, is not designed to handle concurrent calls on the same link instance when its reference count is low. This race leads to the re-initialization of an already-active `work_struct`, a memory state corruption that is detected by the kernel's debug objects feature.

I don't think concurrent bpf_link_put(same_link) is the issue. 
bpf_link_put uses an atomic link->refcnt to handle this situation.

The race should be between the bpf_link_put() in 
bpf_trampoline_unlink_cgroup_shim() and the cgroup_shim_find() in 
bpf_trampoline_link_cgroup_shim(). The cgroup_shim_find() in 
bpf_trampoline_link_cgroup_shim() gets a shim_link with a refcnt 0, then 
a UAF.

The changes in commit ab5d47bd41b1 ("bpf: Remove in_atomic() from 
bpf_link_put().") made this bug easier to manifest as in the reproducer 
because the bpf_trampoline_unlink_prog() is always delayed.

A potential fix is to check the link->refcnt in 
bpf_trampoline_unlink_cgroup_shim() and call 
bpf_trampoline_unlink_prog() when needed inside the 
mutex_lock(&tr->mutex). Cc: Stanislav


