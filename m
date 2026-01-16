Return-Path: <bpf+bounces-79184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E9AD2BA77
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 05:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 578AB30369B8
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 04:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD28734C808;
	Fri, 16 Jan 2026 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sigRHe0e"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD1E348479
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 04:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539312; cv=none; b=qNwZUqGupaoEEpVZEAcvoJ/RO/HJXF23J2HT4TnWVkYOxdkgfEdALxN7APm63CXx6dsd+c4o+mB9nh62gpxYJzh3w7S54uZcYLrlxlZBSVEMLw78KrSCmzcQgH6AoyU6g18xFnplr+P8NsD721H4zDG8NKMukLQWQbxPtZvrkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539312; c=relaxed/simple;
	bh=FqJBeBvoyk/lSCHR3Fw97wJlPzeo8o2EnecifK7TkEg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=ua7RD71iYB6e9omlhoblXtTjE0ZeMoOviboKku8EvcGplTJNWgHA7evU9L3ZIgOYJ9DJNIUWr9ezR57SFbge7Rnb4LxOMJmMLXs7/FmaHLWXOR4df6uFGBoI7jhrLMORLrucUQd1sz6FMxOABXoH65oe5QByFxPXe5W4hA57Fns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sigRHe0e; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768539297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=XJV7F0Vf9FRcfbT3YZDVfwabwMD7M3LlCncxmdhNLU8=;
	b=sigRHe0eN3Q361vdHW+7ak9iHY37DDJSNvZalLR8j13klEVjLLjGSEGDTJIxPi2kznTiLh
	DR7Pk2LRyN+Qca3q6z7HEVVH44YWdaK0Ddo1baKKFiSV9bC0B62EjoDl2LXCQRVnf6c7PS
	zuj2Q3jtXdr02BrImINXM4Xctmq29tA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	 Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	 Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	 KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Subject: [PATCH bpf-next 2/3] bpf: drop KF_ACQUIRE flag on BPF
 kfunc bpf_get_root_mem_cgroup()
In-Reply-To: Message-ID: <20260113083949.2502978-2-mattbobrowski@google.com>
Date: Thu, 15 Jan 2026 20:54:42 -0800
Message-ID: <87y0lyxilp.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT


> With the BPF verifier now treating pointers to struct types returned
> from BPF kfuncs as implicitly trusted by default, there is no need for
> bpf_get_root_mem_cgroup() to be annotated with the KF_ACQUIRE flag.

> bpf_get_root_mem_cgroup() does not acquire any references, but rather
> simply returns a NULL pointer or a pointer to a struct mem_cgroup
> object that is valid for the entire lifetime of the kernel.

> This simplifies BPF programs using this kfunc by removing the
> requirement to pair the call with bpf_put_mem_cgroup().

It's actually the opposite: having the get semantics (which is also
suggested by the name) allows to treat the root memory cgroup exactly
as any other. And it makes the code much simpler, otherwise you
need to have these ugly checks across the codebase:
	if (memcg != root_mem_cgroup)
		css_put(&memcg->css);

This is why __all__ memcg && cgroup code follows this principle and the
hides the special handling of the root memory cgroup within
css_get()/css_put().

I wasn't cc'ed on this series, otherwise I'd nack this patch.
If the overhead of an extra kfunc call is a concern here (which I
doubt), we can introduce a non-acquire bpf_root_mem_cgroup()
version.

And I strongly suggest to revert this change.

Thanks

