Return-Path: <bpf+bounces-67995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772C3B50F26
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 09:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CAA4E77CB
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 07:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F563081CD;
	Wed, 10 Sep 2025 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R1JsHXZK"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092421A4E70
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488916; cv=none; b=HbOrpuGyQXatrGBdHivlsLIBBllJTRJV0STOSmmmswrZRhyha7ym1VnJguXolWjKiJ776m3R6spUX/ujo2Nxi30FXsYDxiJH/RcxOIt1mtORChzrdR6ymSYRnNXhO8MSgSB4Zb4tBqzUwaVHc21Tb3vMyLFktxgI+vEQsIdDaXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488916; c=relaxed/simple;
	bh=geJ0UJM3b7SPADl/tSeh7XgnStA+R2HOh7EaVM0Q1AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBrqSsHkAVph4kyKg1tdPwxyCVnJIZIGJCJLQgHLqJcgfagWX5jTPIwKk3im4d1HF9eXzvMYN9fZg7tE+B0ygJGonek8IvVO9q+t5gB+ZJcbsMpNCtJ9QI4BLCjGYzkq3IZx4SF0k+6uX2jzdDVhGBxkvYAQBvwyX35UGa5FxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R1JsHXZK; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f3c790ce-c324-41c2-8c24-0785076ed642@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757488901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAv5/wmgEhBxyGGZDq9dVoGWNpR4NISRNE5iBQbxwr0=;
	b=R1JsHXZKAHoopuh+8xShMw+SCrTjEhON3EEyKfiPutR/YewjydNo7iet+AGgETh5L8cOdV
	CTPIgJj9fQOUYNO3NJF33I0UgFNMGet3CwULZHpxHeAwq1kNqNk3CFfpPOKoptodNjwyad
	2dN15XdyCZggvLJMdKDfVpniXg2NprI=
Date: Wed, 10 Sep 2025 15:21:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 mm-new 01/10] mm: thp: remove disabled task from
 khugepaged_mm_slot
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 Lance Yang <ioworker0@gmail.com>, shakeel.butt@linux.dev,
 rientjes@google.com, ast@kernel.org, gutierrez.asier@huawei-partners.com,
 21cnbao@gmail.com, daniel@iogearbox.net, ameryhung@gmail.com,
 corbet@lwn.net, andrii@kernel.org, willy@infradead.org,
 usamaarif642@gmail.com, hannes@cmpxchg.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 david@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 npache@redhat.com, akpm@linux-foundation.org
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-2-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250910024447.64788-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/10 10:44, Yafang Shao wrote:
> Since a task with MMF_DISABLE_THP_COMPLETELY cannot use THP, remove it from
> the khugepaged_mm_slot to stop khugepaged from processing it.
> 
> After this change, the following semantic relationship always holds:
> 
>    MMF_VM_HUGEPAGE is set     == task is in khugepaged mm_slot
>    MMF_VM_HUGEPAGE is not set == task is not in khugepaged mm_slot
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Lance Yang <lance.yang@linux.dev>

Cheers,
Lance


