Return-Path: <bpf+bounces-51354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC9BA336F4
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 05:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5D13A7838
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 04:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375DF204688;
	Thu, 13 Feb 2025 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GOsnA2XV"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668661C32
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 04:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739421208; cv=none; b=XvdVFVKeEJ3bcuO2OMO8hyKiiA6n2Oq/Pu/CFPgxC9c4GgZXw7fjA+lTOK/EzusEJ/ZHKc8KdTPso4Npoky5+8QPfBwP/uJPY9CmBwUx4DEIFHFXU74yZwkx6oObqpBz66ekcYYG9J1UV4ms5QT+bgyWXT0gbSwrvPG0/mxE6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739421208; c=relaxed/simple;
	bh=o6Sc8AvwsyvAImr6Xp2aiKvtd6r6xs0/9cLzo0mG2ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFTM8E7BegKyP3YynDJJO25sWwpcboJY+sxQjgUuqvEbNtqPuS3/s00/DubTDjf31naSkAxQqyuXIzyfbGTbyWCZPssztotao/HTiZstH9YtTMNMek0Ws+5Gj+6JCqIcOqewkINzv1/IvpuIwpOkyMfNPuXC81h+/i35d38iR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GOsnA2XV; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <abcf022d-4e2b-46d5-8614-f0e3c28ca576@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739421196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuEvdpqgex5xqPS563rJFj6jPcpS3APgPsE6hQC11a4=;
	b=GOsnA2XVbNF/4Bo15au1JYc43a5pD9IypzTxHmagoOAdYHeKFFNVq4lGHGAk7feyTAz+Zb
	b3fxtCt15FBxD8ChtlSUkTrZLdWbBlGWCfmab77kFlyAsrMoo1y9iy1lA1fQg0MPcMpm6/
	mhNML+SP9e9wpzsu9LQ26N3ducEC028=
Date: Wed, 12 Feb 2025 20:33:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Allow pre-ordering for bpf cgroup
 progs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250213025849.1042428-1-yonghong.song@linux.dev>
 <CAADnVQJDNdskhEKCu7Uvy-Ch=xmabueWopdf+rD8tBP6d_2gkg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJDNdskhEKCu7Uvy-Ch=xmabueWopdf+rD8tBP6d_2gkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2/12/25 7:24 PM, Alexei Starovoitov wrote:
> On Wed, Feb 12, 2025 at 6:59 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> @@ -6019,7 +6020,10 @@ union bpf_attr {
>>          FN(user_ringbuf_drain, 209, ##ctx)              \
>>          FN(cgrp_storage_get, 210, ##ctx)                \
>>          FN(cgrp_storage_delete, 211, ##ctx)             \
>> -       /* */
>> +       /* This helper list is effectively frozen. If you are trying to \
> ohh. pls send it as a separate patch.

Okay. Will do.



