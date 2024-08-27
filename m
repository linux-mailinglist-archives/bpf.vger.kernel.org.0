Return-Path: <bpf+bounces-38208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5CD9618A5
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 22:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE78284FFD
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF1F1BF329;
	Tue, 27 Aug 2024 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MyoNKZvl"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9412148FE5
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791346; cv=none; b=Gw0/VCq4+a/AaB2ekI5eSSeZYtR67Xx+7NuoEP8Ine2yOwZxHW3C3vWwIV0ADL3XdkYEjnP4W/TcZU9B0AyCS50lkbZ8xuVpd/VdIr2sveYQBaGTWNDyUfLDWjX7NtciFZpY9YjLIE6gbFirPA0+akuN0u+KSRGWFrPTAY9bceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791346; c=relaxed/simple;
	bh=g6oOSpcc3lGOCdgntt9Yhoskz2DR3Px04fD8gRqS3gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUq0SSjwtF0Az9KSQprjG71PlwuBITKrwUxdTUxWJzflTyAyrVbTc124AstaH+ETD7Tn2cEj9HVrHG9OjhzPmNROkF6MUqjqtHnV8edvIrdwCXVgHvCFgHZi+k4BkJ5J5tAKgrnl+jIgjXt+buxQmceYKY/wgiRWPL9znGXfddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MyoNKZvl; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <74e5c393-ad97-4704-8915-cdc17f6a9ba1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724791342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6oOSpcc3lGOCdgntt9Yhoskz2DR3Px04fD8gRqS3gA=;
	b=MyoNKZvlEGq5W7Qgj766m0Xz1oEZQ7N39qwTNE3uHxQp8OpLCouXQN4gPpb3IfQCMgzLxo
	OF3u2htPiPcUsobrEYIPEQATGcBEZmqKcSWCwEMJQyGzgijq4zGAkCVkPO2xK59jcN2sBO
	OsA2D21JpYRuCPbDeT/QIY5PyeZ5hcY=
Date: Tue, 27 Aug 2024 13:42:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH -next] bpf/btf: Use kvmemdup to simplify the code
Content-Language: en-GB
To: Hongbo Li <lihongbo22@huawei.com>, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20240827112904.4017810-1-lihongbo22@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240827112904.4017810-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/27/24 4:29 AM, Hongbo Li wrote:
> Use kvmemdup instead of kvmalloc() + memcpy() to simplify the
> code.
>
> No functional change intended.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

For subject, please use [PATH bpf-next] instead of [PATH -next].
Other than this, LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


