Return-Path: <bpf+bounces-61105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0280AE0BFB
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 19:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F45166E75
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A168328D854;
	Thu, 19 Jun 2025 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iL5Squtq"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999E241690
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750354420; cv=none; b=RX2GfO01qTPCmDlK3W8fn37LytvDcXw6A+LvSe8qBOI8nOjf6UJKOpmSLbVAS1hmECNLa6oLl3KCoQs67fl+ejGb/t30sYhSa2ixqs1IMvMjZpuFZiGkPpX88T6tQel1x3wDzxS5Y40SxRdv8N0FRmKWfuzw3GsZMA9n0xs9g9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750354420; c=relaxed/simple;
	bh=KpRmXDn2/tdiDLLz0BWVZSR1KvJW0t9Gq59Y1w9/wr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLZR7eN7qRO8G0eHQvY0hQA0gfZmX28eZScQSWHBikqrQgC7p7o4DKOiPp3pqsbjCvd6/zuQDaVu7daXXI31d1ZbtHRB0LZLZJ9DizLr656Iaud/0YhvsdbblN0IdPrkBOXe08I1FsvknZMzZBfCMhaVAk8PqceDVSDZw/Nq1UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iL5Squtq; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a5103421-a5e4-46d8-b4b6-feed77ebf114@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750354415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpRmXDn2/tdiDLLz0BWVZSR1KvJW0t9Gq59Y1w9/wr8=;
	b=iL5SqutqcBRHPSRBx31ZeeIE9Q7SIx6kE/v09cwMKzLp8hjSE7LIW5Zdpts4Uoh+L942V5
	zW53xD/X5NNm9Pd4yJAJ/yy4F/V3LeODg7W9DOfDijer3CBgq+8fijdADYByJTdCwTXKtH
	YrvpJHCb4bVY4EC07DhVfh6K/DeaV9Q=
Date: Thu, 19 Jun 2025 10:33:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] selftests/bpf: Convert test_sysctl to prog_tests
Content-Language: en-GB
To: Jerome Marchand <jmarchan@redhat.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20250619140603.148942-1-jmarchan@redhat.com>
 <20250619140603.148942-3-jmarchan@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250619140603.148942-3-jmarchan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/19/25 7:06 AM, Jerome Marchand wrote:
> Convert test_sysctl test to prog_tests with minimal change to the
> tests themselves.
>
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


