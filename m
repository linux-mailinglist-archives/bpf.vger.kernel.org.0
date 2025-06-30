Return-Path: <bpf+bounces-61855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDB4AEE2C7
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF5E3BB5C9
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7882128F92F;
	Mon, 30 Jun 2025 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HfBV3yGZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC528C854
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297895; cv=none; b=ZoTVQVuSa7d4N48Atp7KXa+7Bjldl/DOMHeoZccWhF7rRm5VKW7BQ/UFbn1vbxuptZNP3o7pCvVfnJsbsxHqK9a31i/BBFCGia+zf6eFNjL3CineE6uL17nbadP/BHuvS6bRVyrwHxcd9vs9uWbUnUb3AS1RV7Nn/6vpRM0fnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297895; c=relaxed/simple;
	bh=t92sfRXLT3/kpXFGadDfJ8HN48lRM6RT08qAkxrtBiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBLrmpc043f+HG5VlH8BQB2d+/LxxmlRwqFFos5SuUBqDdNM8uD/GaEMyVcIdxSJwk4o0XXDJ4/ZrRgr5TiR5/PKOxZ/tItJ7uOIsXdRKvsECvDRYPWfYelxuj0xj2hwhPIMBqQQkBG4I/ieEJXEMD17UreB5UWrZUykXBiB/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HfBV3yGZ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e8f0970-07db-427d-b87b-eeadb2602616@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751297891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t92sfRXLT3/kpXFGadDfJ8HN48lRM6RT08qAkxrtBiw=;
	b=HfBV3yGZDZhHQweF+rUUqGRXr2SX+cJrjPrZFcB8afEjcSp047MP/k1T1zZvuj78wqaTHq
	4s+OQXjVWC3RWpEq59tQaTnnU/vz1DfP3qp40KpJ37oA+ePIMx+JwhEIaFAiJvoyZvfQAf
	mg95VAnY2XX2nSH+zMou3pAslb6FAvo=
Date: Mon, 30 Jun 2025 08:38:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: enable
 dynptr/test_probe_read_user_str_dynptr
Content-Language: en-GB
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250630133515.1108325-1-mykyta.yatsenko5@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250630133515.1108325-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/30/25 6:35 AM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Enable previously disabled dynptr/test_probe_read_user_str_dynptr test,
> after the fix it depended on was merged into bpf-next.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


