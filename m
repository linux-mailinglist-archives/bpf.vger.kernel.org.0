Return-Path: <bpf+bounces-77217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 861B8CD263A
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D5B3019B5A
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 03:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDE4279798;
	Sat, 20 Dec 2025 03:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y/Gz9/vE"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C91723E350
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766201807; cv=none; b=YrxPvcfr5PwCNbwI/0X84arBVe/umKVkapzVgUBRr+78pZ+UTHGs/MXrtLEaNoOL4nZ48v64vGtWtl6BCw4Zq8id8XsPXKAieaTMrGEDcaGRcNYq3SuEBNZBpgIx0oF2NRdwEvqWVDVUVGakFx79JT8287y5z6XI3Yl5kko5oLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766201807; c=relaxed/simple;
	bh=zXM0c0nE0bZ5HYbBkj9h9nu5nGEEfjdhLIvjUC0UjhY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnWYWW2ekOkqT4xkaBOJ+OwO+wMftISbgEbqGnFmdALV2tHD/OTg6g4V+7IF/MArQfSAntXKbQAcUJN+K2NTrfasaAkQ7zZuxuuHop9RUHBqVc5o0t/zpLmw1Un2R5tlghOtbQM4punbDhsSycopMfZnVhshRT3YXWMrMw1mt6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y/Gz9/vE; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766201798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zXM0c0nE0bZ5HYbBkj9h9nu5nGEEfjdhLIvjUC0UjhY=;
	b=Y/Gz9/vEzRygOHnFp/pTTsXDfp/D+miesLdyrwdKhBMGWegviQrdHTIG4/aOtjYZWgATAX
	8HnuxMEHH+Qf7f72+GkH7f8t1G2txUeKTHrJcetNdnoLkVTWHaTepu84B8Ewdy4cvS25DI
	1tX1Q9XKthlCa0QgXk071Q62fW62teA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Andrew Morton
 <akpm@linux-foundation.org>,  Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 0/6] mm: bpf kfuncs to access memcg data
In-Reply-To: <CAADnVQK26E47RF6TWKAXZizn1QQL1GBMx5MF9pqAA4+5ev1xWw@mail.gmail.com>
	(Alexei Starovoitov's message of "Fri, 19 Dec 2025 19:25:10 -0800")
References: <20251219015750.23732-1-roman.gushchin@linux.dev>
	<87ike29s5r.fsf@linux.dev>
	<CAADnVQK26E47RF6TWKAXZizn1QQL1GBMx5MF9pqAA4+5ev1xWw@mail.gmail.com>
Date: Fri, 19 Dec 2025 19:36:06 -0800
Message-ID: <87ms3desex.fsf@linux.dev>
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

> On Fri, Dec 19, 2025 at 9:40=E2=80=AFAM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
>>
>> Roman Gushchin <roman.gushchin@linux.dev> writes:
>>
>> I believe it can go through the bpf tree or the mm tree.
>>
>> I'd slightly prefer the mm tree, simple because follow up bpf oom
>> patches have more changes on the mm side.
>>
>> If Alexei, Daniel and Andrii is fine with it, Andrew, can you, please,
>> pick them up?
>
> mm tree has no CI and no ability to test bpf things,
> so in mm tree it will dead weight while in bpf tree
> it will be continuously tested.
> So I don't really like the idea of anything bpf related
> to being in some random trees.

Ok, no problems. I've sent v1 with bpf-next prefix so it already got
covered. I'll do the same with v2 and will rely on bpf maintainers
to pick it up.

Thanks!

