Return-Path: <bpf+bounces-70367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDBCBB880F
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 04:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC88A19C72AA
	for <lists+bpf@lfdr.de>; Sat,  4 Oct 2025 02:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CF9278772;
	Sat,  4 Oct 2025 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xw4hpKXq"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5640A2777F2
	for <bpf@vger.kernel.org>; Sat,  4 Oct 2025 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543251; cv=none; b=n8RRXxeQEXvynK6ZKD3MDCjnLC6pDcVA4sW3a+Fzp4KXd/ecsQjRB5ugdH5UH/FhBc7vU7k19Ki5k0FWHW9FMHPlmIao/bFiJ/bDaiMcnSA/kpt3P8S0ZYlrsL/3ub0csmd8x2h6Vvf+IFEsXolfj8T2pfTsXHs63dpsJmOousU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543251; c=relaxed/simple;
	bh=jrJAE+yo+55T40YTks85z53PnQfp5DevLHkYvHmgTnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jmu4GLQzgfoVbWsublryzaLZBTd4ootR9kcDFMpsCo1rgYgBA0hCKp/fwrYgqxam1PMXzlNYo0SJCENubKC5Z0ZvUa+akmfrHt47hf31lmUpSlK0MzUtcyBuJar5t/5a7hWM9A8/K8qshiQpr+hmlRQhaIsWKP8MM3KjjJ31ixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xw4hpKXq; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759543246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jrJAE+yo+55T40YTks85z53PnQfp5DevLHkYvHmgTnQ=;
	b=Xw4hpKXqFzlpYALq1quqLQ0CrgqfXLsoU+klxVxSFx/6BeI0RA/lStu0wl6FV1/Cac66YU
	Z+tDA84oMUHOtigtgnpGL/AZK9FnTEflgh80gTwvNeYCAhyQ4P6Rm5sduIEaax3qyekls8
	37UbTTk9UN02+a8ofiCmGlIuwdVJMUM=
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
Date: Fri, 03 Oct 2025 19:00:38 -0700
Message-ID: <877bxb77eh.fsf@linux.dev>
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
>
>> callback? Or there is something better?
>
> There is a link_create.target_fd in the "union bpf_attr". The
> cgroup_bpf_link_attach() is using it as cgroup fd. May be it can be
> used here also. This will limit it to link attach only. Meaning the
> SEC(".struct_ops.link") is supported but not the older
> SEC(".struct_ops"). I think this should be fine.

I thought a bit more about it (sorry for the delay):
if we want to be able to attach a single struct ops to multiple cgroups
(and potentially other objects, e.g. sockets), we can't really
use the existing struct ops's bpf_link.

So I guess we need to add a new .attach() function beside .reg()
which will take the existing link and struct bpf_attr as arguments and
return a new bpf_link. And in libbpf we need a corresponding new
bpf_link__attach_cgroup().

Does it sound right?

