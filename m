Return-Path: <bpf+bounces-73086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBB7C22B52
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 00:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCA03BB94B
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 23:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD8933BBD2;
	Thu, 30 Oct 2025 23:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mfyFjY+x"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09433BBBD
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761866676; cv=none; b=XCem2wkE277RK++AIY+qX0PmmGUrxxjZJCZBtBAYRc29Q/TyD1NZloX7wIGw7EbcwwMmVf+DSNkytzmc9sUV13ojSfcZZJefk/zF6MNkQAC2UrsEhVeirBcil2M672cUD+Qlgq297y2kUecnoS7O5HZmlazc71TktXcE5SD/mRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761866676; c=relaxed/simple;
	bh=U5mVOjOKselIrEKZtoh+wWmjWaAqnt6aq/qkVMVT11c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g49z6MMJQPEfiONeyFbKKx0NUVddsOut20TtcxLQWui2jyrZ/EQVLzcmKBxEDa2wFKRbk7w/TIB9iMzuEMNUvIsrFFZBcZex+/SPLtPkAiGWdA3j+OpRY+cT3Qw/XEGISZKTSNAUOWmRa0bgNxbXuolWVgrF0fLJqa6WI+zcYVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mfyFjY+x; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761866662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFcFfa21Y8J0EvYjz5FYEa4biOxuGL1h90UpSLZ/vN0=;
	b=mfyFjY+xuK5o/5m3QmAXgABGIwfeRaMj8f5cMWUmw2pAzfQT8LIKXkkjjjHK/fKnYyBZ7k
	81yKYEXTIfVNFD686cdiGUOIO4/FODITODwT1oQm33mRZNioDP2jq5kO1hi2ljt7DmY/+x
	d+7pG1L9EuwIC5HQqNbCGpdPnpfZspg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,  Song Liu <song@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  LKML <linux-kernel@vger.kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Suren Baghdasaryan
 <surenb@google.com>,  Michal Hocko <mhocko@kernel.org>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Johannes Weiner <hannes@cmpxchg.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-mm <linux-mm@kvack.org>,  "open list:CONTROL GROUP (CGROUP)"
 <cgroups@vger.kernel.org>,  bpf <bpf@vger.kernel.org>,  Martin KaFai Lau
 <martin.lau@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,
  Tejun Heo <tj@kernel.org>
Subject: Re: bpf_st_ops and cgroups. Was: [PATCH v2 02/23] bpf: initial
 support for attaching struct ops to cgroups
In-Reply-To: <CAADnVQJGiH_yF=AoFSRy4zh20uneJgBfqGshubLM6aVq069Fhg@mail.gmail.com>
	(Alexei Starovoitov's message of "Thu, 30 Oct 2025 15:19:11 -0700")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-3-roman.gushchin@linux.dev>
	<CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
	<87zf98xq20.fsf@linux.dev>
	<CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
	<CAMB2axMkYS1j=KeECZQ9rnupP8kw7dn1LnGV4udxMp=f=qoEQA@mail.gmail.com>
	<877bwcus3h.fsf@linux.dev>
	<CAADnVQJGiH_yF=AoFSRy4zh20uneJgBfqGshubLM6aVq069Fhg@mail.gmail.com>
Date: Thu, 30 Oct 2025 16:24:15 -0700
Message-ID: <87bjloht28.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Oct 30, 2025 at 12:06=E2=80=AFPM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
>>
>> Ok, let me summarize the options we discussed here:
>>
>> 1) Make the attachment details (e.g. cgroup_id) the part of struct ops
>> itself. The attachment is happening at the reg() time.
>>
>>   +: It's convenient for complex stateful struct ops'es, because a
>>       single entity represents a combination of code and data.
>>   -: No way to attach a single struct ops to multiple entities.
>>
>> This approach is used by Tejun for per-cgroup sched_ext prototype.
>
> It's wrong. It should adopt bpf_struct_ops_link_create() approach
> and use attr->link_create.cgroup.relative_fd to attach.

This is basically what I have in v2, but Andrii and Song suggested that
I should use attr->link_create.target_fd instead.

I have a slight preference towards attr->link_create.cgroup.relative_fd
because it makes it clear that fd is a cgroup fd and potentially opens
a possibility to e.g. attach struct_ops to individual tasks and
cgroups, but I'm fine with both options.

Also, as Song pointed out, fd=3D=3D0 is in theory a valid target, so instea=
d of
using the "if (fd) {...}" check we might need a new flag. Idk if it
really makes sense to complicate the code for it.

Can we, please, decide on what's best here?

