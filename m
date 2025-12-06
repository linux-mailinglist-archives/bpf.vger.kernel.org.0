Return-Path: <bpf+bounces-76209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB7DCAA27F
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 08:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D0AD30A4109
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 07:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE282E6CD2;
	Sat,  6 Dec 2025 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="tB2lCG1T"
X-Original-To: bpf@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D818A6CF;
	Sat,  6 Dec 2025 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765006277; cv=none; b=DngBEOig388OC+OYg/Nk4CFdKx0/YCBCwlMonr/kSNi/ffcO4g2tsTyMAE42ryfzxmF+QtmvL7oi1sCMQbI6sNJx7NVcULPSAIxv+YQ30zV1iUvOv+gq67+lexrkmO3s2SKZ5WfADkOCmIq/sArQDvtZDu/0y0FC1/41SRwV4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765006277; c=relaxed/simple;
	bh=yEEQNPmbE4hIEvZflfnGHSlHAkcbneRQGvPdQomAA8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFcdUMbU+EoOJ5Dmo8ByJ3apDrRzUJY84hAwhdFp8hdNzMtV8W2kSyNd/XW2c04Hx6ejk1fZZsfNHjnj+sZVqwawypmcJ0KyuHgpOGkB72lIyI6EHGpIxDQS0cskuWFIibicEkN2KnGYMAJwhvuBUnSfUzeLv0dMz0s32ETpxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tB2lCG1T; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765006275; x=1796542275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+EpXLBH8doU/Zwxn/2P0nK43qeXc2XBqOHR4O3UoEnA=;
  b=tB2lCG1Tu2itGqfZ/6CKeu1d0r0NbPOZjaJ91++v4I9QV+5GirlA3IDi
   5f2PaDsfuKNSy8BEp0PnXjD30tlTRTPuvCFpAFzPrkjhogfh0+zrLb+0c
   i9sJxbPwG7EdOw2oLaXCtJGB4sc58ZPoN/UzhHSh9KIs21s9G+zvCYkI4
   Kg7L3ALrI54TdItftsb7naFh7SOqW/V3w2INZpA3185OWJot4NZCjathb
   5ymnXmeQvoCK5KxL7SNxFaMZsNEcmkdYQr+nd/YE+Ze/mxxP/IjyiYAqq
   HzQG3D3pOx97twahYpQ/uT4Toop8BH99sqAzQdD1gQPmpiunYAIsG/S4W
   Q==;
X-CSE-ConnectionGUID: uhdIkWbATXKblSdcdFfdCA==
X-CSE-MsgGUID: LrzMbDumRieoWwS23YQtCw==
X-IronPort-AV: E=Sophos;i="6.20,254,1758585600"; 
   d="scan'208";a="8446662"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 07:30:03 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:30837]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.65:2525] with esmtp (Farcaster)
 id ab211861-4215-4cc1-bde1-9b31172db20f; Sat, 6 Dec 2025 07:30:03 +0000 (UTC)
X-Farcaster-Flow-ID: ab211861-4215-4cc1-bde1-9b31172db20f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 6 Dec 2025 07:29:58 +0000
Received: from b0be8375a521.amazon.com (10.37.245.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 6 Dec 2025 07:29:54 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <toke@kernel.org>
CC: <alexei.starovoitov@gmail.com>, <andrii@kernel.org>, <ast@kernel.org>,
	<bpf@vger.kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<eddyz87@gmail.com>, <enjuk@amazon.com>, <haoluo@google.com>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kernel-team@cloudflare.com>, <kohei.enju@gmail.com>, <kpsingh@kernel.org>,
	<kuba@kernel.org>, <lorenzo@kernel.org>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <sdf@fomichev.me>, <shuah@kernel.org>,
	<song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf v1 1/2] bpf: cpumap: propagate underlying error in cpu_map_update_elem()
Date: Sat, 6 Dec 2025 16:29:44 +0900
Message-ID: <20251206072946.22695-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <87jyz39272.fsf@toke.dk>
References: <87jyz39272.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, 03 Dec 2025 13:31:29 +0100, Toke Høiland-Jørgensen wrote:

>Jesper Dangaard Brouer <hawk@kernel.org> writes:
>
>> On 03/12/2025 11.40, Kohei Enju wrote:
>>> On Tue, 2 Dec 2025 17:08:32 -0800, Alexei Starovoitov wrote:
>>> 
>>>> On Fri, Nov 28, 2025 at 8:05 AM Kohei Enju <enjuk@amazon.com> wrote:
>>>>>
>>>>> After commit 9216477449f3 ("bpf: cpumap: Add the possibility to attach
>>>>> an eBPF program to cpumap"), __cpu_map_entry_alloc() may fail with
>>>>> errors other than -ENOMEM, such as -EBADF or -EINVAL.
>>>>>
>>>>> However, __cpu_map_entry_alloc() returns NULL on all failures, and
>>>>> cpu_map_update_elem() unconditionally converts this NULL into -ENOMEM.
>>>>> As a result, user space always receives -ENOMEM regardless of the actual
>>>>> underlying error.
>>>>>
>>>>> Examples of unexpected behavior:
>>>>>    - Nonexistent fd  : -ENOMEM (should be -EBADF)
>>>>>    - Non-BPF fd      : -ENOMEM (should be -EINVAL)
>>>>>    - Bad attach type : -ENOMEM (should be -EINVAL)
>>>>>
>>>>> Change __cpu_map_entry_alloc() to return ERR_PTR(err) instead of NULL
>>>>> and have cpu_map_update_elem() propagate this error.
>>>>>
>>>>> Fixes: 9216477449f3 ("bpf: cpumap: Add the possibility to attach an eBPF program to cpumap")
>>>>
>>>> The current behavior is what it is. It's not a bug and
>>>> this patch is not a fix. It's probably an ok improvement,
>>>> but since it changes user visible behavior we have to be careful.
>>> 
>>> Oops, got it.
>>> When I resend, I'll remove the tag and send to bpf-next, not to bpf.
>>> 
>>> Thank you for taking a look.
>>> 
>>>>
>>>> I'd like Jesper and/or other cpumap experts to confirm that it's ok.
>>>>
>>> 
>>> Sure, I'd like to wait for reactions from cpumap experts.
>>
>> Skimmed the code changes[1] and they look good to me :-)
>
>We have one example of a use of the cpumap programs in xdp-tools, and
>there we just report the error message to the user. I would guess other
>apps would follow the same pattern rather than react to a specific error
>code; especially since there's only one error code being used here.
>
>So I agree, this should be OK to change.
>
>-Toke

Thank you for the clarification, Toke and Jesper.
Since I see no objections so far, I'll work on v2 and resend next week.

