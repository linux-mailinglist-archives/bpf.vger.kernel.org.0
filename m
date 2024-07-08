Return-Path: <bpf+bounces-34121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74692A8BB
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 20:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84191F22244
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF651474A8;
	Mon,  8 Jul 2024 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TFbvhZko"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61D1EF01
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462197; cv=none; b=HUMk9N1rc6dX3xZm6Xt61Z10Cpk7D+LRM8QKLUwe8UO+K7xNHUb/zOs1ZpsXVb57YgFB8IS4ikDJM5m4+hUXz5DNDQLDZMuG1WRCRe1HDy9rHcgFgpcfKpTDvYmRIU5yoSOhuwsa/kKGTr+c1V1zB0Zf53Ot1bcsgH/o7XjqAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462197; c=relaxed/simple;
	bh=RJkhTkACkhm4Pj40gctGMknd1gsOHhYPaerXrDdctc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vs5p0Vctko7fWMTOtV6NHIaFu9RZgzWq+UkpWTsouiVsrMVZrJ+/1BzZpxdnd9zQfICzLJDRENJz2C5Wwd/tdZveJdv6Q3tOZcit1ns01UhgF0kWWMpyvBRBn/KzzY5eRnGmmm089hCWe0xW36XmYg/hIN2LawFrNl8Fc4QoCG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TFbvhZko; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: pgovind2@uci.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720462192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tx4OYMmVi4oMtXzIBo487muTfiNA/QNUXlDo1GB/RVk=;
	b=TFbvhZkoHRBgn0b78PxSpJ3RYzaLUzYFm5kSLPN69OhmqFfbfPa4RhNGAm6c6mb/oS2qYA
	dF75r5Dgakwp6ZNl0IEgVBIruV2untXv3ZZ3XOHPc5gcP4BSucoA+Bbzz+RZ5hieGxK6GY
	rjwxYaavfpkJrXEq9JenXHwI+kzCv/Q=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: hsinweih@uci.edu
X-Envelope-To: ardalan@uci.edu
Message-ID: <6719482a-4135-40e1-8fb9-4f6e593fc71b@linux.dev>
Date: Mon, 8 Jul 2024 11:09:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Potential deadlock in bpf_htab_percpu_lru
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Hsin-Wei Hung <hsinweih@uci.edu>, Ardalan Amiri Sani <ardalan@uci.edu>
References: <CAPPBnEYv7kmVnFurrtgBzTzcpA8MiGFdWVSfD-ZAx2SK_667XQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAPPBnEYv7kmVnFurrtgBzTzcpA8MiGFdWVSfD-ZAx2SK_667XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/8/24 9:21 AM, Priya Bala Govindasamy wrote:
> Hello,
> 
> We are developing a tool to perform static analysis on the bpf
> subsystem to detect locking violations. Our tool reported the
> raw_spin_lock_irqsave() in bpf_percpu_lru_pop_free(). This function is
> used by htab_percpu_lru_map_update_elem() which can be called from an
> NMI. A deadlock can happen if a bpf program holding the lock is
> interrupted by the same program in NMI. The report was generated for

Thanks for the report.

Similar issue (and its solution) has already been discussed before for other 
maps. Please help to post an official fix with the test. Thanks.

Here is some reference,

Hsin-Wei Hung had reported similar case for the queue/stack map: 
https://lore.kernel.org/bpf/CABcoxUbYwuZUL-xm1+5juO42nJMgpQX7cNyQELYz+g2XkZi9TQ@mail.gmail.com/

The solution should be similar here, use in_nmi() and trylock() like commit 
a34a9f1a19af ("bpf: Avoid deadlock when using queue and stack maps from NMI").


