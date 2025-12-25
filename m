Return-Path: <bpf+bounces-77432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F799CDD2C6
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 02:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90AE23018969
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 01:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE58716F0FE;
	Thu, 25 Dec 2025 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JmOcZEDZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF78834
	for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766625435; cv=none; b=QEqCTy0Dy62DMVoNjJ/CKqvT9cg8sV/1jpku+xR94vnT8riqYfWRWOAu6gq2nkUOJeqR8AtoH7l/kAcjdz3P+wtWRZCG8fqqybGb+Vn3CXvIuO5DBu3tb6fvVI3eLaUvKJF+DRUXMT8GEVCzv+/KnGNqOmqo2VK0dCVlh3EY0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766625435; c=relaxed/simple;
	bh=sX9PtPc4xL/CYh2SYTyc/emBz8y2Tnv1KscJeiPt0Gs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZLmtwYXj9Hb7ooomC5wJY6sk5pGjpswZuqG6EgPdgUm8/GUOGc2MC4WE87hHcObry9ePwFxfB6MJEj1dY5D+kmdKUPMRxEgYp6s6LK+tHUSc53yxOkGA7f8vF62Zoby4zCAGxTF03OTyMVCbygEg/4XuGe0OXNqW76e8J5BTT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JmOcZEDZ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766625429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sX9PtPc4xL/CYh2SYTyc/emBz8y2Tnv1KscJeiPt0Gs=;
	b=JmOcZEDZ8YezgFbsYJC+3/mj2M4nKIJInN27YuvCQmUB5YpCV5Z7vmUMNjxLTopf++M0oC
	0wtGPuKuVfFSdZNoB+y+iRezqHFw2MJ4Kz82lH4GJ1/SuuXcLsFj4YrIOTrRY6sKEzyKqN
	y+ZnCtw4Mvo6TPd+86At27TI8iUn2lA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  JP Kobryn <inwardvessel@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Michal Hocko <mhocko@kernel.org>,  Johannes
 Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v4 0/6] mm: bpf kfuncs to access memcg data
In-Reply-To: <CALOAHbAQQ59mSmh8aO47jnDjOu9S+FESxKw+YUp9g2Q2qvqedA@mail.gmail.com>
	(Yafang Shao's message of "Wed, 24 Dec 2025 11:01:18 +0800")
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
	<CALOAHbAQQ59mSmh8aO47jnDjOu9S+FESxKw+YUp9g2Q2qvqedA@mail.gmail.com>
Date: Wed, 24 Dec 2025 17:16:53 -0800
Message-ID: <87cy439x8a.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Yafang Shao <laoar.shao@gmail.com> writes:

> On Tue, Dec 23, 2025 at 12:43=E2=80=AFPM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
>>
>> Introduce kfuncs to simplify the access to the memcg data.
>> These kfuncs can be used to accelerate monitoring use cases and
>> for implementing custom OOM policies once BPF OOM is landed.
>>
>> This patchset was separated out from the BPF OOM patchset to simplify
>> the logistics and accelerate the landing of the part which is useful
>> by itself. No functional changes since BPF OOM v2.
>
> Hello Roman,
>
> Thanks for driving the BPF-MM upstreaming work=E2=80=94this is great prog=
ress.
>
> Would it be possible to upstream the bpf_st_ops and cgroups patch as a
> standalone series as well? [0]

Hello Yafang,

this is in my plan for next few weeks: I'll probably try to upstream
it altogether with bpfoom, but if there will be any delays with bpfoom,
we can split the patchset further.

Thanks!

