Return-Path: <bpf+bounces-64390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824DAB12338
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 19:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D22AE3D09
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8022EFDB1;
	Fri, 25 Jul 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wDA5KYi9"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D12EFDA1
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465728; cv=none; b=dvHkrOnWAQcJFU/0gjCNwhE6INDTy0P5kMM4tEbLFBJ4Sfg1xChg5jfZNSm7XbCeNpRYxx+hpoKFIES4untJ+Nw0DwTlw8QoysLcgtk35Ysi8il1PJ2VN7pnF4+NakQSAStmWHx66Kg215DBc2gJ3JtEn0tRPDtzd9KdLY9ARy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465728; c=relaxed/simple;
	bh=xW/eRBf28FKWPcdt8VFjDq1uhVkuQiqBuifYuIeI5rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNFGlshuBlaROBnEnzAQQR58Eg1UZv8IYG8BX2wdkXbYUnrsz5EG7QGiBmr04Xmzr/4+nspxJMRttg+wbDC3GEro0mQJFscuG+GKZLrTxPH9AuAbP/GT6ekIYw3+/rUdxLPQLEp7aQxL5mVBNUMQNV2qwJyJxgPffVZ/AQzdaPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wDA5KYi9; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b88650d-e9dd-4c3b-b377-2017b5f982b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753465724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xW/eRBf28FKWPcdt8VFjDq1uhVkuQiqBuifYuIeI5rc=;
	b=wDA5KYi9iMY1zQ4xfOOYElml0bGlurX9QwTvC9slvjA9sLCABlLJYsh8U7cRvFqNh/lxKO
	cDQmOQ7VOK4nTDrEPsCoiU1jdzMrz4RqZmGs+j4QsLIQaE1Y5lTpd4wqbpD46ABQp55iFF
	zItWuKgKfmESPUDA00YII8fs6KjkvkE=
Date: Fri, 25 Jul 2025 10:48:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/4] Use correct destructor kfunc types
Content-Language: en-GB
To: Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250724223225.1481960-6-samitolvanen@google.com>
 <c7241cc9-2b20-4f32-8ae2-93f40d12fc85@linux.dev>
 <CABCJKud8u_AF6=gWvvYqMeP71kWG3k88jjozEBmXpW9r4YxGKQ@mail.gmail.com>
 <f82341df-bf2a-4913-a58c-e0acdfb245d2@linux.dev>
 <CABCJKueq=a6Y_2YmSDOa-VTCW9jwYPiXq94125EAMoZ5Y6-ypA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CABCJKueq=a6Y_2YmSDOa-VTCW9jwYPiXq94125EAMoZ5Y6-ypA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/25/25 10:20 AM, Sami Tolvanen wrote:
> On Fri, Jul 25, 2025 at 9:54 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> I just tried arm64 with your patch set. CFI crash still happened:
>>
>> CFI failure at tcp_ack+0xe74/0x13cc (target: bpf__tcp_congestion_ops_in_ack_event+0x0/0x78; expected type: 0x64424
>> 87a)
> This one should fixed by the other series I posted earlier:
>
> https://lore.kernel.org/bpf/20250722205357.3347626-5-samitolvanen@google.com/

Okay, I see. We can delay arm64 for now and focus on x86 side as I can
observe some issues with CONFIG_CFI_CLANG.

>
> Sami


