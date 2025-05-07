Return-Path: <bpf+bounces-57606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B0FAAD308
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 04:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564907AFF85
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D96189B80;
	Wed,  7 May 2025 02:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="I+KLeADA"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F44B1E73;
	Wed,  7 May 2025 02:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583581; cv=none; b=IY1Gc5fvaOH3r1SDYt1pvFA8ieI+aeafwJkIT3SkL9uN9Tsz5M/x5vUA5Y8SyTH6rk9s8ykI4iIMIbJDcNaF8/N7fRCfz9Ujd4pnXNp9fOb35Cg9EUsX0QjFi4OCxX6QePanccxNlNhIpvMvLTzgdBtsP6yv7HxfcpCwbdgwZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583581; c=relaxed/simple;
	bh=1VsNcjYJF7cLmpBwnsKum+QPehsSemNHeONRj4/3MGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qd5bXcATOf56jnytxLitVY7nUhQP0DuikMNODo1t+lVTOtEQrG66OZWZztT/sisNCWVSoGGDHeY1aTpBQ3sONlo3EvlkFxcWOTk6B+ybJNoyIDiV4P/GEWTloPzLpVoC/pCs9Dm37R4ENOfE2I1a285818T/oBgLEDSLj1AJh3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=I+KLeADA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KJj1df+PsBvJxqQabjQE7P4OiseEZSfyi+NXcDGgpIA=; b=I+KLeADAz7ioOcZbEdbkJ0nuZC
	ythTI48td9drp5dBgjh+lIFNCIL8NSktFBJdwoLvZZzeidp1yOz2B0ToGIo6gHgeWjGqJ/7F9im/t
	xIlexLTCHRNUP/SC2z80LjPDIQ/O1CVZo5MvW4Vnb0m8ONPSh87J0pLagAwMzNc/sG3jOOeVcY+gA
	knxnx9bOGjfrvUrdNfOlfD/iAl/o+TD+9Mn1DImL610KqFAnwxsS35cblxvHpEsrjOK0qwRO5YliQ
	SkuvSKaKU9CJXmf5CGt1LmzGykosmmAL4/ecSFZeB103QF4wxAOQSSVJs07TXIaZDyACBxWHlqQbW
	HCga9FZg==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uCU6e-004Ubg-RP; Wed, 07 May 2025 04:05:43 +0200
Message-ID: <f46e0854-faad-4733-980f-11b9380b884f@igalia.com>
Date: Wed, 7 May 2025 11:05:32 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 0/2] sched_ext: rename var for slice refill
 event and add helper
To: Honglei Wang <jameshongleiwang@126.com>, tj@kernel.org,
 void@manifault.com, arighi@nvidia.com
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 joshdon@google.com, brho@google.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250507011637.77589-1-jameshongleiwang@126.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20250507011637.77589-1-jameshongleiwang@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Honglei,

Looks good to me.

Acked-by: Changwoo Min <changwoo@igalia.com>

On 5/7/25 10:16, Honglei Wang wrote:
> SCX_EV_ENQ_SLICE_DFL gives the impression that the event only occurs
> when the tasks were enqueued, which seems not accurate. So rename the
> variable to SCX_EV_REFILL_SLICE_DFL.
> 
> The slice refilling with default slice always come with event
> statistics together, add a helper routine to make it cleaner.
> 
> Changes in v2:
> Refine the comments base on Andrea's suggestion.
> 
> Honglei Wang (2):
>    sched_ext: change the variable name for slice refill event
>    sched_ext: add helper for refill task with default slice
> 
>   kernel/sched/ext.c             | 36 +++++++++++++++++-----------------
>   tools/sched_ext/scx_qmap.bpf.c |  4 ++--
>   2 files changed, 20 insertions(+), 20 deletions(-)
> 


