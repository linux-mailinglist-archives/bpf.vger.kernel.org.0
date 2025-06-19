Return-Path: <bpf+bounces-61104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34606AE0BF7
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 19:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FAB16B928
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6528D8CE;
	Thu, 19 Jun 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gCzK4Jtq"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB021E0AF
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750354367; cv=none; b=FMx5Q3qWiRWvmWuKyMZY+xp1XlwiFUEd8MyF6NSGXMWL9pVtMEKx/teWHjKoeQjitHKqXvEwIUiTW9z311PbCEWJ/21B8SYcUCVjEwlenMxToulrkIMppQHEf/acdUCM3Ddd2kmdyzyddfq4qvaMp2Jz3ckYrJqDan4pBPb04Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750354367; c=relaxed/simple;
	bh=WHFA3dt+gXVNZyOzMwYU23xWVhQTSPBOMqpAAE95nE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1CDmRZfBp6ajH9fgsui8MJSBlkb6cGNhJT51I6Pm0hFvo8CtnxCXBI2rBFloLW3gJ+MvkL2dHCuSB+5JKjCuIfGfwuazyHOu1ftAyg8dWB1idkWK4ZYZ+d04Oxm0dTz8E9Y07BI7aA79UIeiz960kupY7HHn1TRmv04cAgKT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gCzK4Jtq; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <38415904-6af7-41ef-9963-fe60cc6560ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750354362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHFA3dt+gXVNZyOzMwYU23xWVhQTSPBOMqpAAE95nE8=;
	b=gCzK4JtqUv5MIyP+ZDj2ON8lIxmOCbpEvKPCXR72qskW84oCy5cMRGmvu/92FIbvzzPdI+
	yOHz6OmDG6qSII8OBnwCqfEImiIflh9WcRFN+Dtxk7BzURMpFVJ8ntZBSh3hjC2NGbelLT
	/OLy+CCYxsU10mki62CaOvLrxiVkd5I=
Date: Thu, 19 Jun 2025 10:32:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] bpf: Specify access type of bpf_sysctl_get_name
 args
Content-Language: en-GB
To: Jerome Marchand <jmarchan@redhat.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20250619140603.148942-1-jmarchan@redhat.com>
 <20250619140603.148942-2-jmarchan@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250619140603.148942-2-jmarchan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/19/25 7:06 AM, Jerome Marchand wrote:
> The second argument of bpf_sysctl_get_name() helper is a pointer to a
> buffer that is being written to. However that isn't specify in the
> prototype.
>
> Until commit 37cce22dbd51a ("bpf: verifier: Refactor helper access
> type tracking"), all helper accesses were considered as a possible
> write access by the verifier, so no big harm was done. However, since
> then, the verifier might make wrong asssumption about the content of
> that address which might lead it to make faulty optimizations (such as
> removing code that was wrongly labeled dead). This is what happens in
> test_sysctl selftest to the tests related to sysctl_get_name.
>
> Add MEM_WRITE flag the second argument of bpf_sysctl_get_name().
>
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>

You can carry previous ACK if there is no big change. Ack again here.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


