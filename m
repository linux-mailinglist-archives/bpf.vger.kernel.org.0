Return-Path: <bpf+bounces-51394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0962A33C36
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 11:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE57118829BD
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 10:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10366212B32;
	Thu, 13 Feb 2025 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ls/dh3Zg"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB320B7FF;
	Thu, 13 Feb 2025 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441549; cv=none; b=PRP9/JvBSOMLtaa85icDun1x4fF/cfwbm0A94P3B7sxXHwBvvP9UhajUQVxHvxuhSc4hbsMflEfF2f/u/fs1n7vSSPMc+lqrBD5A9kScEBtS1U8CsiW86LFsY+rPQQreTwdtlVtPyySS08GEQ0c7XaayRaKGUqFyPx4LPkL937o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441549; c=relaxed/simple;
	bh=tqZpQK4xeMb6tw5FODUf9H7mRn5t/kDt5GIcHJeyn70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TToDRaf3IFCKWLp+dzHzB2j4ZyH/ho5mb1rv/5/diXvgsaQNIAUcdicrvkqJor9Q7YHNqMBUZ4wQdN1cKWsgtH/YQrKul81/VgeNwFbLtyS7Mnh8HD+wz7iMdj0mgnIX5Y4sVYN3MkgIElO1AC4cvXo6APIfbFj3p74BuoCGWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ls/dh3Zg; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8STFsjk7nOxsasLEFEuYQgNFVyCF5cAX4BptmfIOi4Q=; b=Ls/dh3ZgUKW/U/cAWuYSQT+DXG
	urVOzTXiTK7YnlFR1tT8//CNzHfPnSleW12WEJLxYFdyqTKHWVq9rrrwkw1HCMmVeYVi+WgjF47TI
	DIHhsi7Qnd+lQyijZmoNaCoxHYdsKElIt/GNcmiGoJg7H4xR7S6I/0Hs9LnlI6m9T0MMAdu/mP5qt
	DJDghDwFs2sX7RU3LBnvX1wCM0aI4JMq6i6QqBAxR4TYUmbeAEPy3SYPlTDmr4lmCpL8C3TaIGK2p
	OEGn3rlc3g1azbBM7xyD/EiXLYUQ6MtnLz7D7giP7EHcURxeLU0Em7aH1ad4gUMI4qvYYA1WVlZ0V
	eOY4VBEQ==;
Received: from [106.101.129.218] (helo=[192.168.202.21])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tiWCI-009uTh-Vz; Thu, 13 Feb 2025 11:12:01 +0100
Message-ID: <90eda54b-6898-40bb-adbb-409404ad185f@igalia.com>
Date: Thu, 13 Feb 2025 19:11:47 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Add a retry after refilling the free list
 when unit_alloc() fails
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
 arighi@nvidia.com, kernel-dev@igalia.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250212084851.150169-1-changwoo@igalia.com>
 <CAPhsuW44cRU6rfrpnkdd-+6MRm7fbQ2ucnhtueaD9wBKXYnn8Q@mail.gmail.com>
 <1a158ad7-f988-42bf-9a1e-b673ff9122c2@igalia.com>
 <CAP01T77mcUi4h_dT6QfEPg_xeUGhsegcV+NCqpQSY-VtxuLV4A@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <CAP01T77mcUi4h_dT6QfEPg_xeUGhsegcV+NCqpQSY-VtxuLV4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Kumar,

On 25. 2. 13. 18:05, Kumar Kartikeya Dwivedi wrote:
> On Thu, 13 Feb 2025 at 09:42, Changwoo Min <changwoo@igalia.com> wrote:
>>
>> Hello Song,
>>
>> Thank you for the review!
>>
>> On 25. 2. 13. 03:33, Song Liu wrote:
>>> On Wed, Feb 12, 2025 at 12:49 AM Changwoo Min <changwoo@igalia.com> wrote:
>>>>
>>>> When there is no entry in the free list (c->free_llist), unit_alloc()
>>>> fails even when there is available memory in the system, causing allocation
>>>> failure in various BPF calls -- such as bpf_mem_alloc() and
>>>> bpf_cpumask_create().
>>>>
>>>> Such allocation failure can happen, especially when a BPF program tries many
>>>> allocations -- more than a delta between high and low watermarks -- in an
>>>> IRQ-disabled context.
>>>
>>> Can we add a selftests for this scenario?
>>
>> It would be a bit tricky to create an IRQ-disabled case in a BPF
>> program. However, I think it will be possible to reproduce the
>> allocation failure issue when allocating sufficiently enough
>> small allocations.
> 
> You can also make use of recently introduced
> bpf_local_irq_{save,restore} in the selftest.

Thank you for the suggestion. I will try it out.

Regards,
Changwoo Min


