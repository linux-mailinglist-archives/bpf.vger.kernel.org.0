Return-Path: <bpf+bounces-28219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF238B66A2
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCED1C21EDC
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55836194C81;
	Mon, 29 Apr 2024 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sD050aYG"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF071194C6E
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434422; cv=none; b=NwTv5M9sYhKFGzn5+SDeBb9im9J8K++VYdZ5dkkq7QQY3+rGtqkkSmNaubmZUTLQF656MkMoY8bXSk+d1DHGdlNkxwrVZ2QcV2ZsuledLBJWoJUKtj8Hw5Mhx5HLYbUSF6+zFM8JuzDoCQLFYGZ68oG0cqJGuM2gMwCHiMWTXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434422; c=relaxed/simple;
	bh=5ANMfFNAg8yddWyYf2J/diPjQKIiQyabVZ32eoKoxq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esJ615BZjoLglrKHteTi6phBhly3Su+yhY23uAVcuIdP9jxS2RjssWPPoEepZUZLZDbTd+01C78DE2bzW41+gosJa48CKB6jgJPoz6fC91zrWvELaQ1ebDBGwnM44rPs5tojpEv+3b3zZ8g5OqTSm3z++hxbGr1Ey9/pCW1QqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sD050aYG; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0df9d83b-aaa4-45d8-abae-d20fee8a6213@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714434418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hivm/UmsS2FPLJMaLc68FabbDy8yDvY90AiwrLIOYH8=;
	b=sD050aYGQ4qGmU1KbFYiMDVajgylOBrBBpsolR3AztjuU7Z1+4Yr2EupTs70OpXha/c+6h
	HMZ245+3OYIx6DMY+EelnpiJH0riXPcKZc3vWPL/J/3LFHxgtYLw/hTtfmaShEMKmxf+XJ
	DC/wMYlb6ePwuolxblgXgWHCL0UcXEE=
Date: Mon, 29 Apr 2024 16:46:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: validate nulled-out
 struct_ops program is handled properly
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
References: <20240428030954.3918764-1-andrii@kernel.org>
 <20240428030954.3918764-2-andrii@kernel.org>
 <5b3e2db0-1582-4f35-9cee-069de799aa41@linux.dev>
 <CAEf4BzYo+wCE_dg1kx-dA9egvz7KE6tPS0fzFgeaCgx02+NrcQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAEf4BzYo+wCE_dg1kx-dA9egvz7KE6tPS0fzFgeaCgx02+NrcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/29/24 3:35 PM, Andrii Nakryiko wrote:
> On Mon, Apr 29, 2024 at 2:29 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 4/27/24 8:09 PM, Andrii Nakryiko wrote:
>>> Add a selftests validating that it's possible to have some struct_ops
>>> callback set declaratively, then disable it (by setting to NULL)
>>> programmatically. Libbpf should detect that such program should be
>>
>> such program should be /not/ loaded ?
> 
> yep, can you fix it up while applying or should I send a new revision?

I will take care of it. No need to respin.


