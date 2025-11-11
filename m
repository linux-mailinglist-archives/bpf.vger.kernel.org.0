Return-Path: <bpf+bounces-74256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB0C4F926
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 20:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A403A792B
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 19:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B00261B8D;
	Tue, 11 Nov 2025 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kT23GwCJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0632571BE
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888684; cv=none; b=arrEL0F7/SoVLxrV4X46/Sl0RVUHAxcmTiFBQqr/8zY2TEX92+l5zHSPovmiBmycAocXr12o0WsgXP8T3BElX+gKW2BA6+Z7ZmpEYynd2k7+isIufyQH+2ktnVI3qSAdicfIwFBHyiyj4pzhjcG+FzzZGEnh+97t/sUzgMU7Zhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888684; c=relaxed/simple;
	bh=qFnKHaytVNV0OfjfOFrWCarKwTG+bMnNvrU4GEFWYBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oiL/iBzuTEUgV0kfs1W2JmYFN/SfCJl9SRJ/ZLzRwg5RhDdxqa3fXTEztiLYJM6LdX650K9pNxNLbHvAT0qcli22VaNxu/KE7wrgzpfST0vIc6izuXUZUi4emHFaI8XStSHyssRFQe96WfZcTXmP8Beme0xs58uspd952BMNbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kT23GwCJ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762888681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qFnKHaytVNV0OfjfOFrWCarKwTG+bMnNvrU4GEFWYBk=;
	b=kT23GwCJTLtrgw+qw/LIT9f52tM66JsOOW1Xkg2v5t3ySioBIioZdiYVLTj8+aJfRHcm2Z
	2DCDxwlfjfLs2W8TxB7i+dgf1S2QeNBp5CtJlXPMqP+rgLszGmOnZtV7N0h2bDPsGvUG/s
	knjm/jRQNK6WJUyutK/XnFRE4BctAjQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Johannes Weiner <hannes@cmpxchg.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,  bpf@vger.kernel.org,
  Martin KaFai Lau <martin.lau@kernel.org>,  Song Liu <song@kernel.org>,
  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 14/23] mm: allow specifying custom oom constraint for
 BPF triggers
In-Reply-To: <aRGw6sSyoJiyXb8i@tiehlicka> (Michal Hocko's message of "Mon, 10
	Nov 2025 10:31:22 +0100")
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
	<20251027232206.473085-4-roman.gushchin@linux.dev>
	<aRGw6sSyoJiyXb8i@tiehlicka>
Date: Tue, 11 Nov 2025 11:17:48 -0800
Message-ID: <871pm4peeb.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Michal Hocko <mhocko@suse.com> writes:

> On Mon 27-10-25 16:21:57, Roman Gushchin wrote:
>> Currently there is a hard-coded list of possible oom constraints:
>> NONE, CPUSET, MEMORY_POLICY & MEMCG. Add a new one: CONSTRAINT_BPF.
>> Also, add an ability to specify a custom constraint name
>> when calling bpf_out_of_memory(). If an empty string is passed
>> as an argument, CONSTRAINT_BPF is displayed.
>
> Constrain is meant to define the scope of the oom handler but to me it
> seems like you want to specify the oom handler and (ab)using scope for
> that. In other words it still makes sense to distinguesh memcg, global,
> mempolicy wide OOMs with global vs. bpf handler, right?

I use the word "constraint" as the "reason" why an OOM was declared (in
other words which constraint was violated). And memcg vs global define
the scope. Right now the only way to trigger a memcg oom is to exceed
the memory.max limit. But with bpf oom there will others, e.g. exceed a
certain PSI threshold. So you can have different constraints violated
within the same scope.

