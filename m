Return-Path: <bpf+bounces-66408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0D1B34822
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C870D3B3CAF
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2312302CC2;
	Mon, 25 Aug 2025 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZUra9uhh"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C873019D7
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141214; cv=none; b=ipWGkZsLhrsbFqMvhGExxxgTc6GdlAcr2uC/X/IjksYhEL1/Q5IXRHWypmUraf4j5n1oNFzqEc/DjV0nsBaXY+B5v2MCEwiSXOjD7kVLvZAw1ruYV/L+0A0DZuWqyCep1NwYscsdAHMnqjmWPiI7Hm36sXX60QUVt89hNB3LG0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141214; c=relaxed/simple;
	bh=ggWL8GPworOcyT85eNMo8lBrOLG6QsXHTYPtaF7L9O0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YQU3ghQ2Utt4spnF65HWgmZYo1+lEAHhV5UpQjnDUjEOHQa0iC0deGidzNyQj8PjUtwi8y2N8gyKELFR3w/JWiEiWI2F0qxL1EU+66smmvtVLig93Ow0+/AxUPlUD/70h1xBJX4OXk88qvAjREkSR1+ViSjSFDZXO38EvtDLxQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZUra9uhh; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756141210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6uJo9FbTXrzowr8bEe61nZYQy1ZZH3tikDVmsKo+eZ0=;
	b=ZUra9uhhuroF/AWQrMpTXqdJomo2gUtw+oC8PyZGUMqGcCITfRywK7cZOklUHO1xq4J1h7
	hXSNz+75AFa0o+inHBTr9VWOSw85k4C++U7huvSKbrcCyrmD0qkCwVh3Ow/Wx6VjYnW+UI
	7ASd9pZu8gDLNMnaGJN1d6iVB4yLXr8=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,  linux-mm@kvack.org,
  bpf@vger.kernel.org,  Suren Baghdasaryan <surenb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David
 Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
In-Reply-To: <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev> (Martin KaFai
	Lau's message of "Fri, 22 Aug 2025 12:27:48 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-2-roman.gushchin@linux.dev>
	<CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
	<87ms7tldwo.fsf@linux.dev>
	<1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
Date: Mon, 25 Aug 2025 10:00:02 -0700
Message-ID: <87wm6rwd4d.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 8/20/25 5:24 PM, Roman Gushchin wrote:
>>> How is it decided who gets to run before the other? Is it based on
>>> order of attachment (which can be non-deterministic)?
>> Yeah, now it's the order of attachment.
>> 
>>> There was a lot of discussion on something similar for tc progs, and
>>> we went with specific flags that capture partial ordering constraints
>>> (instead of priorities that may collide).
>>> https://lore.kernel.org/all/20230719140858.13224-2-daniel@iogearbox.net
>>> It would be nice if we can find a way of making this consistent.
>
> +1
>
> The cgroup bpf prog has recently added the mprog api support also. If
> the simple order of attachment is not enough and needs to have
> specific ordering, we should make the bpf struct_ops support the same
> mprog api instead of asking each subsystem creating its own.
>
> fyi, another need for struct_ops ordering is to upgrade the
> BPF_PROG_TYPE_SOCK_OPS api to struct_ops for easier extension in the
> future. Slide 13 in
> https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/view

Does it mean it's better now to keep it simple in the context of oom
patches with the plan to later reuse the generic struct_ops
infrastructure?

Honestly, I believe that the simple order of attachment should be
good enough for quite a while, so I'd not over-complicate this,
unless it's not fixable later.

Thanks!

