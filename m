Return-Path: <bpf+bounces-66309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D55B32346
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 21:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EE4567470
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 19:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072F82D6619;
	Fri, 22 Aug 2025 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ODGNrnMN"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D9298CA2
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892650; cv=none; b=RLo63yZoM2jhsCm+tNRnb5JK81GKdjL17nzLImY0+0ScTNxqVCuzL+CBSS83tQ4KN02WyfXB97f8brRmhYgTDccXTMF2JVP8TH65/mqoQnqcdsigXRTmAfx7IvOmwS7U4KCmS5G7h32HFz4c9zFcQWbGRtldopL7/EWLWLmnu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892650; c=relaxed/simple;
	bh=bYfEkI/HXvYSciaE3inVn2cClJS+fuZzLwI2uIIFsEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=devSQtbshnAH6XR4a3FL9ZY5wEE7p0rudW9y63HGG0jrs3Ti4jZj0DfB3WlbSmkAoJh3uRmmoJqYfhpy3URWy1ZHMUKtLKWfrpuqE4268YyLlKOQTUbWC7Nhl8DrQ6himYjf5Iar0PVeafDcIg0yndATJgoh95zs8Z7XcL5cRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ODGNrnMN; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c1b71664-91c0-439c-9cae-7407fa5b0358@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755892646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgGQNbQpaeQ098wkm4u8zP/FPMO3eRXDhj7ceqGRxdw=;
	b=ODGNrnMNHi2fujrx4+KsmthVVSn9u3cTP6nkLxG0DlNYp+LN3E/HrXxHfWYO2BT+CZD9Nc
	jaZvG8zngg+a56REPHlpd6ksHZV60H2jnm6PZ/7//7JEIiNMSwAZUrbNUKJI6VYu0IyGlR
	MDJSRYPVSI5eZbQnVtoTEGn4UhgGcjE=
Date: Fri, 22 Aug 2025 12:57:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 13/14] sched: psi: implement bpf_psi_create_trigger()
 kfunc
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, linux-mm@kvack.org,
 bpf@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-14-roman.gushchin@linux.dev>
 <CAEf4BzaSLWB1xpCjX35oxg2ySvvgRvEmQ01PtXv+xEz-Zkz07w@mail.gmail.com>
 <87ect5lde2.fsf@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87ect5lde2.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/20/25 5:36 PM, Roman Gushchin wrote:
> It will. Idk how big of a problem it is, given that the caller needs
> a trusted reference to bpf_psi. Also, is there a simple way to constrain
> it? Wdyt?

The bpf qdisc has the kfunc filtering. Take a look at the bpf_qdisc_kfunc_filter 
in bpf_qdisc.c.

