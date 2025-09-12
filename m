Return-Path: <bpf+bounces-68205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A246AB54048
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 04:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FC93BE00F
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 02:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F11CAA6C;
	Fri, 12 Sep 2025 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t3YSVxm/"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177A1B9831
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757643623; cv=none; b=VU1BNu5tCdmA6fqw6eMoTrYWhaXV8OE86PyPJ8347hgsR6UgOViisxI1Tlb6GsAy9qZ7eRb2dQPQrjt54/4Lz9ssl+xo3KW29ZkfK6LwEgUQGfcbmZeKqRzLuRralnWrFEqUNc3qK3NObqfDwgI26aLjjI4PFWkt23kRFVW/Vcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757643623; c=relaxed/simple;
	bh=p+gxHO53waJQunVWU6cFWzvdXoFDgddiT35lud4RgGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8TdFZCsln9Aqh901LmxNCFylG3Z3QJRVFXs1EHIPJVNcHiQiPlfkU6dWCBhscXH1rIRsXlwL3R6Lcv9slSOA5BUlugfxTgCTbTqoWswiFZl7bMqbStn10MRZok7WSLi3wqrUbSt5vJral0tmD+QcUnP8NRqh5rF8YM+IgiJzWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t3YSVxm/; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <665f4b63-1296-430c-8979-77d5b7e60f2a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757643616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMhhaw5/O4AgHaGkwCJ3YhRvRCghWKGnqLN018HYmS0=;
	b=t3YSVxm/sBxS5fIvn2ELoCquZfzlgHYV7MG0gVftfUekMR6a3It9SRPBxFTlliPb3Wx03x
	hzY5WrLHtG7c0+FY9AdLRBo7gvVZUgArPQvV18/MbeTUZol5Xrq4ENg9zyUw7t7yAX7F+I
	xJ5JiuOo9GRKoMT2xNgboL0UKAqPxOs=
Date: Fri, 12 Sep 2025 10:20:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject bpf_timer for PREEMPT_RT
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Peilin Ye <yepeilin@google.com>, Eduard Zingerman <eddyz87@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Josh Don <joshdon@google.com>,
 Barret Rhoden <brho@google.com>
References: <20250908044025.77519-1-leon.hwang@linux.dev>
 <20250908044025.77519-2-leon.hwang@linux.dev>
 <b0505a919d39e8151d0e14d9e41950f19d3807e0.camel@gmail.com>
 <603b37f4ef1a3ccbb661eaf11f56da9144bdcb66.camel@gmail.com>
 <aL9bvqeEfDLBiv5U@google.com>
 <CAADnVQ+G4u1vM7OUUKaos+jyG6FF8-72t8rMKyqRoa7nuF8xFA@mail.gmail.com>
 <cad23151-7039-4a7f-b4ea-030ec161b2ba@linux.dev>
 <CAADnVQ+C+Zyzz4MHU1Qh9eVuKec8+F+gnOZy5ZDVUAXWP0O9YQ@mail.gmail.com>
 <CAADnVQ+SRASFFSyRJA=nDBbojMo8FMw4ihsEGzG78i5wYne-6w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+SRASFFSyRJA=nDBbojMo8FMw4ihsEGzG78i5wYne-6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 12/9/25 00:38, Alexei Starovoitov wrote:
> On Tue, Sep 9, 2025 at 7:06 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Sep 9, 2025 at 7:02 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>
>>>
>>> If I respin the patch for the bpf tree, I have to drop the part that
>>> skips the timer_interrupt test case. Should I?
>>
>> of course.
> 
> Leon,
> 
> the fix made it all the way to bpf-next.
> Please follow up to silence timer_interrupt test.
> 
> It shouldn't affect CI, since we don't test RT.

No problem.

Once the fix lands in bpf-next, I’ll test it against RT.

After it’s applied, I’ll follow up with a revert of the patch set in
order to silence the timer_interrupt test.

Thanks,
Leon

