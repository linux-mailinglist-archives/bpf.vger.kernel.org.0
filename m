Return-Path: <bpf+bounces-56222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF702A93103
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 05:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239A54A09CA
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 03:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACBC267F46;
	Fri, 18 Apr 2025 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gPBNj/H6"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC28E1A0730;
	Fri, 18 Apr 2025 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744948602; cv=none; b=lzrV0o4fPZ12Wzk0pg/yxtqZMByTaZe6KcXJDyMyCdGpOyAtAvKyHftic/GdxGyoTL9l2jqpAPjAtAEHVUBntNWPonbpUkBRuB1TiueEVEQmnoowPMFRYhU3Tmu1/mRUt4HTPrp86xMvsJrt6J3SJNTgBYtbRmEOZkG3fFqWmj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744948602; c=relaxed/simple;
	bh=rSCFtyIoo+yGZPfCzeeZlGzoaG2HnxCjwjcmuKWUeQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tbj7gywmEagNGLHMOnzF47WvP0zfKGfcBOGru6vPjYl7j4LzLpTW+aRM/tTPv/wK73jvc/6DV1aj33NFCA5oe+PIkldXy8K7Uam47A5SpDZM999I9nFga0WeLZn0isuME/fPLt8bPVQ7vXLKuAnGrcwZSiU0INQD9a8cCJ27p/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gPBNj/H6; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=13DlzqRxA276iwX7TtSbw9BaBD4R+vNgPyUOWwUuqOI=; b=gPBNj/H6010BA/5PZZM4i3aBFK
	hCjooCqOTfIapT133Yyx1/p6VJCG8xEIGx7A6NcHgklK2ptgKC9AvyS0XC/bJzk1Ilu8U8p1Fdxcf
	S9gjs0v7zmuJIm52kquO2/+gztqqN0L2XLdFRPVuggvOjCisHw4gLZFXx/6+4bf1sL/rXluGtGJiC
	IRaq2xFdoYl1VqKYDvn0F2BG9IRbAGl/qEk6fGyJGAj02UznRpF66LT+7XECEU2uadrn1IFgoDFls
	0lSuFVmxIDkQedmbvaZr4mB3+aeViCwMxjj1jMiXHx8bw4PmOs1cdLmGFsfGOiWC8YoDDOLesyS2A
	2eNF5UoA==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u5cpe-00167c-2T; Fri, 18 Apr 2025 05:56:02 +0200
Message-ID: <01d5eb3b-f312-46a1-b8d2-22be8bcfa5f9@igalia.com>
Date: Fri, 18 Apr 2025 12:55:51 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] rename var for slice refill event and add helper
To: Honglei Wang <jameshongleiwang@126.com>, tj@kernel.org,
 void@manifault.com, arighi@nvidia.com
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 joshdon@google.com, brho@google.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250418032603.61803-1-jameshongleiwang@126.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20250418032603.61803-1-jameshongleiwang@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Honglei,

Thanks for the contribution. The change looks good to me.

Acked-by: Changwoo Min <changwoo@igalia.com>

On 4/18/25 12:26, Honglei Wang wrote:
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


