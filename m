Return-Path: <bpf+bounces-77200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D999ACD1AA5
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 20:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DDC3302B10D
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995682E0B71;
	Fri, 19 Dec 2025 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="msZk4G0h"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA57C2D0C8F
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766173248; cv=none; b=UhoWm8n/6CwGHuJB0iU/TxrVj7wopWaLUXbsUkS9hrM5pabv+lKUK2IgkCw2KS29tzXD/UyQiem3xjnXGAQaK0KhuwazlRZ6HTTUmCeHV4hiTPdUOylPIQOrq2ZT0qRdIS21/xbokD3Sh2t1/huUor197z4jjPyo5ZvAXJogiIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766173248; c=relaxed/simple;
	bh=3J+k5ulL+wKMRKv2wyOi0QxBQ/vRu5e9l3c/QmnpLes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IuM7fRR/mbTOrsuT363dZ3sFlE8un5CAYICoXmarBMiOskOh5VsBERU0n/CEt1mKU6vhWif4RSCRtaqwzY4xhjh8WJJKafopQeuilsDQozzBRuPmdaXPnvA1nd97STomrvdfQXmnIjlwLy4mluqgjCNRdYjuCkQYdovT0vLhCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=msZk4G0h; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766173240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mdbAOBt/loxVf2NN10ZjF4o9zxSPylcTW4qKOS/YL2s=;
	b=msZk4G0hJYjVwmlB+pY86o4uPWwwSULZGznK7EuFZDPDg8e1CVlccI2VJQrnxBL8Ofd5Jf
	XZKKUMvYIjjcsQ83vshhzi+bgPO9xKIKZLcZvx//kb8tIGjkMEixYlKt82Ny7K/18hEMBf
	L4V16I8wKQLHGMoRDUFeBsEhYrEzcJI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrew Morton <akpm@linux-foundation.org>, Andrii
 Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 0/6] mm: bpf kfuncs to access memcg data
In-Reply-To: <20251219015750.23732-1-roman.gushchin@linux.dev> (Roman
	Gushchin's message of "Thu, 18 Dec 2025 17:57:44 -0800")
References: <20251219015750.23732-1-roman.gushchin@linux.dev>
Date: Fri, 19 Dec 2025 11:40:32 -0800
Message-ID: <87ike29s5r.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Roman Gushchin <roman.gushchin@linux.dev> writes:

I believe it can go through the bpf tree or the mm tree.

I'd slightly prefer the mm tree, simple because follow up bpf oom
patches have more changes on the mm side.

If Alexei, Daniel and Andrii is fine with it, Andrew, can you, please,
pick them up?

(bpf oom patches will follow likely next week)

Thank you!

> Introduce kfuncs to simplify the access to the memcg data.
> These kfuncs can be used to accelerate monitoring use cases and
> for implementing custom OOM policies once BPF OOM is landed.
>
> This patchset was separated out from the BPF OOM patchset to simplify
> the logistics and accelerate the landing of the part which is useful
> by itself. No functional changes since BPF OOM v2.
>
>
> JP Kobryn (2):
>   mm: introduce BPF kfunc to access memory events
>   bpf: selftests: selftests for memcg stat kfuncs
>
> Roman Gushchin (4):
>   mm: declare memcg_page_state_output() in memcontrol.h
>   mm: introduce BPF kfuncs to deal with memcg pointers
>   mm: introduce bpf_get_root_mem_cgroup() BPF kfunc
>   mm: introduce BPF kfuncs to access memcg statistics and events
>
>  include/linux/memcontrol.h                    |   3 +
>  mm/Makefile                                   |   3 +
>  mm/bpf_memcontrol.c                           | 175 ++++++++++++++
>  mm/memcontrol-v1.h                            |   1 -
>  .../testing/selftests/bpf/cgroup_iter_memcg.h |  18 ++
>  .../bpf/prog_tests/cgroup_iter_memcg.c        | 223 ++++++++++++++++++
>  .../selftests/bpf/progs/cgroup_iter_memcg.c   |  42 ++++
>  7 files changed, 464 insertions(+), 1 deletion(-)
>  create mode 100644 mm/bpf_memcontrol.c
>  create mode 100644 tools/testing/selftests/bpf/cgroup_iter_memcg.h
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c

