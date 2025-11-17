Return-Path: <bpf+bounces-74816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B8C66960
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B09D4EBA08
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 23:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CFF2FBE1C;
	Mon, 17 Nov 2025 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fJErVpZR"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A552139C9
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423222; cv=none; b=g/U0OFI4v+GYvZiQVYwL5zhcYKC/VnZj4sGEBSFIJafu+nXHZiZtdGGn9PX8RE3BsijrmcNSjPoaLrUxjhvHIYK3zNd6v4+Sl5u07YrakCE70QBpjcHfmpK+1FwGVrNFQFYD0aReGlyd7QVLJip9DB0zuYkB7TldCFxTBiXM32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423222; c=relaxed/simple;
	bh=qHbQWa8oDveacpXLroAVyPiK+q4rhR02EvggKBZ4N/4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=upooeidjw3ZSRh3KTNCKRXr5Hpdl5T6c4WK6xf+cIDXb7Zx4hXMSUKUHhPNEE1YB4mWdRke6lvVP72vaddlgEzOtW+jF9nO/mvad7IGw5mRPZU6A0gGaXCbx025TSQe7Mvhh4jYB2GrYnE1JF8KvemFRc2meJHF1SAE6wX+2XUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fJErVpZR; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b0df39ab-fdee-4b48-8739-74192cf5a26c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763423216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5L3fmoWKUNAJOBUlqJ5Dno0qPktD8xRVoa8UchMFYCk=;
	b=fJErVpZRKABGxPpie+A08Vfho4Iaf6MQGGFqMVml5yEQ4p9k2kWSB3N+W0U9EGbiVgVsQL
	VvHOz/efoWVx2yrXPQtwZ/nnPbSaBQl7z8MMGbQdjt8cJEAGqekgp3OQ5rEn7BWDUxN2kz
	LM6dJ8vy9N9uTPXDyUgc/UygpOlW0cs=
Date: Mon, 17 Nov 2025 15:46:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Announcement: BPF CI is down
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf <bpf@vger.kernel.org>, netdev@vger.kernel.org
References: <938dbf1c-d2b5-42db-8ceb-0121e0cac698@linux.dev>
Content-Language: en-US
In-Reply-To: <938dbf1c-d2b5-42db-8ceb-0121e0cac698@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/17/25 8:26 AM, Ihor Solodrai wrote:
> Hello everyone,
> 
> BPF CI has been down since Friday, November 15, because GitHub appears
> to have disabled the "GitHub Actions" feature for the kernel-patches
> GitHub organization without any prior notice. We do not yet know the
> reason for this.
> 
> Currently, the dashboard [1] shows the following message:
> 
> "GitHub Actions is currently disabled for this repository. Please
> reach out to GitHub Support for assistance."
> 
> This means that no BPF CI jobs, including AI reviews, will run for an
> unknown period of time.
> 
> In the meantime, please be patient with patch reviews, as maintainers
> will need to run the selftests manually.
> 
> [1] https://github.com/kernel-patches/bpf/actions

GitHub support re-enabled access to GitHub actions for kernel-patches
after a manual review of the account.

The workflows are able to launch now.

However please note that BPF CI did not automatically run for patch series
submitted between approximately Nov 15 @ 1am PST and Nov 17 @ 3pm PST.

