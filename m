Return-Path: <bpf+bounces-72615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7A8C166AD
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 19:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3223B12B5
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474CE34FF51;
	Tue, 28 Oct 2025 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lQS9HNn2"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFD34BA52
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675168; cv=none; b=ihE1ysNxq2S22eCZfQRd7hUbSmafM5n07bMCQVGMv4z6R0VqfYXKdQhvCxLwX+nvQS4RIalGOK1A2KycdDLdwzMpCzhPGfsXWYY+sUEwyIzwfazP0xn5sLxXU9vECYkZi/M9PzArr8g9uWj0fZmnq+4Tna160fwbMIYIj3NzDis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675168; c=relaxed/simple;
	bh=pZiVIVBdUQJ8VQZlZ/1Fn3ZM0wQ+JL3yG6Un4Uz/z0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k401WOHwMSuy4m0+GFJnL44XTApqVl8zRHkwFtfA3zyE+2G0BA3PPNiOnUT2dca27r+s1M+irQ6+syaK/H7qNMLiQiFoHlgt+zgt6SdLEJYO2KhgWGRqIy1vH9rrXefLEuvT5It++6LOmENOH7VFb7x/Do7w4yIlLMKQ7LNQmsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lQS9HNn2; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761675164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mIcK7vCMiNf076l+LaWZKI497HGob3OxvsLoIs/FEg=;
	b=lQS9HNn2xXA7sE3Ntv4jDLBzYAliouwdGZ+N3LRU21VyhFQwa6LZ/qS98WN3YIK0dl7m/U
	IPp6lysrkH4QjjvO5HK/WAeejgtUQvlJMHCCSokVJGYZHi6pBnr5uI9D9SY/4jb4sywY3j
	/EM9m2P5QogpPrIXFP7YPVLZbXSyLmo=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko <andrii@kernel.org>,  JP
 Kobryn <inwardvessel@gmail.com>,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  bpf@vger.kernel.org,  Martin KaFai Lau
 <martin.lau@kernel.org>,  Song Liu <song@kernel.org>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 08/23] mm: introduce BPF kfuncs to deal with memcg
 pointers
In-Reply-To: <aQEAnB7Gjs4vew8x@slm.duckdns.org> (Tejun Heo's message of "Tue,
	28 Oct 2025 07:42:52 -1000")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-9-roman.gushchin@linux.dev>
	<aQEAnB7Gjs4vew8x@slm.duckdns.org>
Date: Tue, 28 Oct 2025 11:12:35 -0700
Message-ID: <87y0ouuc8c.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Tejun Heo <tj@kernel.org> writes:

> On Mon, Oct 27, 2025 at 04:17:11PM -0700, Roman Gushchin wrote:
>> +__bpf_kfunc struct mem_cgroup *
>> +bpf_get_mem_cgroup(struct cgroup_subsys_state *css)
>> +{
>> +	struct mem_cgroup *memcg = NULL;
>> +	bool rcu_unlock = false;
>> +
>> +	if (!root_mem_cgroup)
>> +		return NULL;
>> +
>> +	if (root_mem_cgroup->css.ss != css->ss) {
>> +		struct cgroup *cgroup = css->cgroup;
>> +		int ssid = root_mem_cgroup->css.ss->id;
>> +
>> +		rcu_read_lock();
>> +		rcu_unlock = true;
>> +		css = rcu_dereference_raw(cgroup->subsys[ssid]);
>
> Would it make more sense to use cgroup_e_css()?

Good call, will update in the next version.

Thank you!

