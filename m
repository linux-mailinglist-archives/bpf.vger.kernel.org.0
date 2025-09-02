Return-Path: <bpf+bounces-67233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1890B41006
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 00:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E7B3ACCCE
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 22:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8D472618;
	Tue,  2 Sep 2025 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dFpU6ost"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631721E487
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756852221; cv=none; b=ZSaEC/cE40PmYD0x0U2bn+YlYRLr3FM6hTHJhgI/oBu9vt1WJrsj7jw5DXHt2zOModhURElDN6rXTeBtpkrVpzsJi0TXzmRHrvKBz3ohX12TK9MDXnFPBoOPDplf+qEmhM6LqqfL+czmO4wAcT6pXHlW5NphXc4/ufkjpzgKtJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756852221; c=relaxed/simple;
	bh=Zu2O/11sa03bmoU53AKoiAUYiDlGKbRK7En5wuIqf8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGe5q9cnPIT7PVE4D0ZxfX6UieZOY4VYysXEfZRIcpfRLYic5Hq6+6HfKen3I/QZuET+jRIgiA7i/NCi3VOc+K3ZmxISSPltomkIUSBqFO7K7DDqRmfSV0CJPCduGgfUEyUwaCUHVeUigzhwpub4Ka157kRFgThzluEqG2ETpjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dFpU6ost; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a76ad1e9-07d5-4ba1-83e4-22fe36a32df0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756852216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcMClNKqF89fyusNx4KAf+ldD0MkJVJrNd35mLcgadc=;
	b=dFpU6ostNV6afKRbkI0/nNZ1eh0g4spiTyWoAwtlLsAPG6maCYx9BakMeKrqvtwODdfMoG
	VYQQmhW5IsWl6KjdaRxwnX1U3SYA7577sVMqDFWS/RPsPxZtC4eqdoIpdKX1J77+IZaV2g
	6KbVL82VHMnNa3lv2S59vqH/3DiDG/0=
Date: Tue, 2 Sep 2025 15:30:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm <linux-mm@kvack.org>,
 bpf <bpf@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev>
 <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev> <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
 <87wm6rwd4d.fsf@linux.dev> <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
 <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
 <87iki0n4lm.fsf@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87iki0n4lm.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/2/25 10:31 AM, Roman Gushchin wrote:
> Btw, what's the right way to attach struct ops to a cgroup, if there is
> one? Add a cgroup_id field to the struct and use it in the .reg()

Adding a cgroup id/fd field to the struct bpf_oom_ops will be hard to attach the 
same bpf_oom_ops to multiple cgroups.

> callback? Or there is something better?

There is a link_create.target_fd in the "union bpf_attr". The 
cgroup_bpf_link_attach() is using it as cgroup fd. May be it can be used here 
also. This will limit it to link attach only. Meaning the 
SEC(".struct_ops.link") is supported but not the older SEC(".struct_ops"). I 
think this should be fine.


