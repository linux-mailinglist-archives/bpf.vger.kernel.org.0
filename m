Return-Path: <bpf+bounces-39335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F96397209E
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 19:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE7E1F21CCF
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26C71891A4;
	Mon,  9 Sep 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j563/eOW"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A9185B77
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902870; cv=none; b=S/59AEFPPlKhmuJ1NZ0UwbSEoK6QvN84FPkQ+FN/5ivh4aibSp6AjKFxtx9xydpNuBD1H3RsIbErYXwkfVf2aO1wIOvu6s4MiaUwzIhLEE1/ce/qjcrCT9J2d2nB04XrEhyL94kVCKocaSsg1sAKEETr+R4ABF7DO6LR20NdKqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902870; c=relaxed/simple;
	bh=f8preI61JbSEcl0vZnfyLiw1BCs4BbJNsu/i4MrS8bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ejGZOVId9fray5+OUDBZ60z1ZvI9w95lMeMZxrpcImLmKBlTd7x9Y9vXtO+S2sv41dlxpDo1IVCPp8au+Pw1h4wlhwzQyq6XODEdwCgVFr0Mw1Mu6+JBKZ4UyRvH6kCB456P1NDFspChgN8s5L0GidTd8cXP1dYmiXwK63m0GfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j563/eOW; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7856b29c-4db3-46bf-a679-5e63fc08a353@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725902866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8preI61JbSEcl0vZnfyLiw1BCs4BbJNsu/i4MrS8bk=;
	b=j563/eOWd9OzpFz0flNL/8fuK7Z+NF3Hh1FkyFx1Y8crh227h4jdIoDcJBMDWi4tTHJLdC
	YOg3RsgES4/AlE1VQ3OT6CS0Y9yD8kgicKubRNErIq4IytwcVGcS3rULP++zVdkMHQXDFP
	/tQLROtSChWdunrRW0jRDSN6QBJwQ6k=
Date: Mon, 9 Sep 2024 10:27:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Kernel oops caused by signed divide
Content-Language: en-GB
To: Zac Ecob <zacecob@protonmail.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 9/9/24 10:21 AM, Zac Ecob wrote:
> Hello,
>
> I recently received a kernel 'oops' about a divide error.
> After some research, it seems that the 'div64_s64' function used for the 'MOD'/'REM' instructions boils down to an 'idiv'.
>
> The 'dividend' is set to INT64_MIN, and the 'divisor' to -1, then because of two's complement, there is no corresponding positive value, causing the error (at least to my understanding).

Could you provide a reproducible test case for this? It will make it easy to debug the issue.


