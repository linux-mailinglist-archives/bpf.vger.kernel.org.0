Return-Path: <bpf+bounces-30084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4095F8CA61E
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 04:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519CEB219E1
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 02:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19753D51E;
	Tue, 21 May 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FXERWRCD"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D044C15B
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258031; cv=none; b=RNTCNhHyRxfYTeZY9MTp6sIAXPhmojDvmJxx6jqyNuieLvrLaGp9vlMgx619CqL9IxjU2L2i+BvUJSdNYQz60Dzz06ZZhqtxaALes3DSnbMz5VgFjlU3Yzgthwa8SHDD7jPYm/9S6YlAM+OT7a9hsVYPQXo1F78yBpE1fiyR2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258031; c=relaxed/simple;
	bh=IfDpDl1wMdJJ6d7nOOuaBXPYvBfJ2aHMYt1CcXwdbTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PL3OT3ix0V13WTbctRH3wpBp96gWROqDJ3S4f8FXaIX72VyMdKH3VCnBgv2K3nou4CQfLReIJVGigYvAn7yGnYG8JBSFbfUtbaNmhfDlMjQkHIlwoK8VVTFgMqU7dZhp4fPmH7IqJPnx+ZFjgZdK6xRs4fklDNJ+SaoG6pR/xIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FXERWRCD; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dthaler1968@googlemail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716258027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfDpDl1wMdJJ6d7nOOuaBXPYvBfJ2aHMYt1CcXwdbTA=;
	b=FXERWRCDBahryJFKbcE+ZvI+AfYISFjtb0VobE97eGWkY9i3yozT40WFdAHfKbyDxymdWE
	NslOIJPfzfPAck32MwYdTgdIbs/k7mLqwbDAbQowP9/XS6P4pq3X4Q9iI0WuXvOOa5DztB
	+PPx0PmK9FPWNjsSsiOlhWw1fRZ3BsU=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: bpf@ietf.org
X-Envelope-To: dthaler1968@gmail.com
Message-ID: <c51d8c26-6b87-406d-a4a7-bedab6d0c9b0@linux.dev>
Date: Mon, 20 May 2024 19:20:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf, docs: clarify sign extension of 64-bit
 use of 32-bit imm
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
References: <20240520215255.10595-1-dthaler1968@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240520215255.10595-1-dthaler1968@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/20/24 3:52 PM, Dave Thaler wrote:
> imm is defined as a 32-bit signed integer.
>
> {MOV, K, ALU64} says it does "dst = src" (where src is 'imm') and it
> does do dst = (s64)imm, which in that sense does sign extend imm. The MOVSX
> instruction is explained as sign extending, so added the example of
> {MOV, K, ALU64} to make this more clear.
>
> {JLE, K, JMP} says it does "PC += offset if dst <= src" (where src is 'imm',
> and the comparison is unsigned). This was apparently ambiguous to some
> readers as to whether the comparison was "dst <= (u64)(u32)imm" or
> "dst <= (u64)(s64)imm" so added an example to make this more clear.
>
> v1 -> v2: Address comments from Yonghong
>
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


