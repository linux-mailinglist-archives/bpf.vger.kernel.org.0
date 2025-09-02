Return-Path: <bpf+bounces-67238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCD5B410DC
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 01:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9F6562346
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 23:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B303E284669;
	Tue,  2 Sep 2025 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d7+z3KRj"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13B280309
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856199; cv=none; b=skh6Tbr/d/32igbUIzxx6LtzNCrn9czpcXkbYcg0DxtaDwRIwN8yylmFJF+TUFv9MFUPQ1JbomD0D7NTP0U5RGZ81WBaP/utCHjyvTDJrXIXNTA1YGss0+M3Jyn+0YhdcaWYnTIJpr//YBF8x8inwQPXiK8/3iIgnUgOie9/nqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856199; c=relaxed/simple;
	bh=4VRotmPacgDSBhrhKHEwQvLwXAIZ2QzWSVjur4ooG6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NuWZslnpdbTHrpDP2ol14TW/cXU0OLoC3VbB81U9QImJZL1DliOCFu+5TrDzvbBONilZPrUcP71cy5H/Sf/N70FnvoexlBzY8TlJAAG3Szzvi7VXP8TKcqGZsD8LPtd9qXvfNcaUAdit2s34dfVVfwI3wxf8svGKFDwXkM319DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d7+z3KRj; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756856195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4VRotmPacgDSBhrhKHEwQvLwXAIZ2QzWSVjur4ooG6I=;
	b=d7+z3KRjKnYgIE8FVboMNcu7cNJ22o0DwNdthxu9cPcAnsobQBApJF/8cftXd51mtBvxBk
	oNje22SYw/0i4sNoY4RKXd8pZxN4Yo2xT3ys5FFmFFvr41PRc8X6zPCH6lHOGwVv0PBKtI
	CL58h7dU/uh1AGcCuCtqP1r4DrEqgQE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>,  linux-mm <linux-mm@kvack.org>,  bpf
 <bpf@vger.kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David
 Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
In-Reply-To: <a76ad1e9-07d5-4ba1-83e4-22fe36a32df0@linux.dev> (Martin KaFai
	Lau's message of "Tue, 2 Sep 2025 15:30:04 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-2-roman.gushchin@linux.dev>
	<CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
	<87ms7tldwo.fsf@linux.dev>
	<1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
	<87wm6rwd4d.fsf@linux.dev>
	<ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
	<CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
	<87iki0n4lm.fsf@linux.dev>
	<a76ad1e9-07d5-4ba1-83e4-22fe36a32df0@linux.dev>
Date: Tue, 02 Sep 2025 16:36:27 -0700
Message-ID: <87ms7c5sw4.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 9/2/25 10:31 AM, Roman Gushchin wrote:
>> Btw, what's the right way to attach struct ops to a cgroup, if there is
>> one? Add a cgroup_id field to the struct and use it in the .reg()
>
> Adding a cgroup id/fd field to the struct bpf_oom_ops will be hard to
> attach the same bpf_oom_ops to multiple cgroups.

Yeah, this is what I thought too, it doesn't look as an attractive path.

>
>> callback? Or there is something better?
>
> There is a link_create.target_fd in the "union bpf_attr". The
> cgroup_bpf_link_attach() is using it as cgroup fd. May be it can be
> used here also. This will limit it to link attach only. Meaning the
> SEC(".struct_ops.link") is supported but not the older
> SEC(".struct_ops"). I think this should be fine.

I'll take a look, thank you!

