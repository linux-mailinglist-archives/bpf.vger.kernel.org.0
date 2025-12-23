Return-Path: <bpf+bounces-77376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3A9CDA4ED
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 20:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D079302BAB0
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 19:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B348734A3B4;
	Tue, 23 Dec 2025 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NvrUKCsQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D047296BD8
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766516771; cv=none; b=MEdV2fQjBhTzYYMHuCi5d/uCuS3+kOnlq2BuJXnj6prns8SaQHhTDSrg0QlU/AQyFy3/Ah+if9iIP6tV5ATC81TdFZmRV1+W6cRG2RdcfvVA86UdRoLxZXF8dbIDQlGI6KeQp84ZjPALDIWEw7b8vl6mlNya5nAhsPftYPE735g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766516771; c=relaxed/simple;
	bh=bTDYtgXMYW59TC+JJk/YSo7iq4QmPVGzqzgv8IsmvmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKF5GLEIwB/E1RkIjVtJjdBXl8ATdH/fCtRYBJbroQ/VTcYW9PZ8+Ej156I3vKo2Ez9GPdaPuGqVowd4g2V+7rYL1KOvNEg/2aEqaAMoZsuQu0jCdZfx3cjFOalKhEVsbRUwbjCguT4ViYMLbcBXjw9/UF3ngSUZwlfSzWl2x5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NvrUKCsQ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 23 Dec 2025 11:05:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766516755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oKQvOLeVaT9BKfwpnIheZydHIFneoIUokoSJuJNEolc=;
	b=NvrUKCsQaArRH2T3fj5+mz8mAs/PzwhW45FqJst2746f/lYlhQPq6jrMFYh2TAj8r2BMHV
	vbSVV0+PByKuvLAwF4RimfErr/cu8n8YTx1Lf7gwRICVk06uo6E0vWYzJmKYwDfGLnOipw
	Pu9Jw4IsNloqjEX3eZIySu95tFB4pWI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Song Liu <song@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com
Subject: Re: [PATCH] buildid: validate page-backed file before parsing build
 ID
Message-ID: <gkguoyowtzk2mtr264pgzh7xescgwhczjg4f6piuppnpebcgjb@atkroomgpyyk>
References: <20251223103214.2412446-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223103214.2412446-1-wangjinchao600@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Jinchao,

On Tue, Dec 23, 2025 at 06:32:07PM +0800, Jinchao Wang wrote:
> __build_id_parse() only works on page-backed storage.  Its helper paths
> eventually call mapping->a_ops->read_folio(), so explicitly reject VMAs
> that do not map a regular file or lack valid address_space operations.
> 
> Reported-by: syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Check the previous discussion on this at
https://lore.kernel.org/all/20251114193729.251892-1-ssranevjti@gmail.com/

The preferred solution was to use kernel_read() call instead of adding
more such checks. Please check and test the patch at
https://lore.kernel.org/20251222205859.3968077-1-shakeel.butt@linux.dev/


