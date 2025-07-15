Return-Path: <bpf+bounces-63297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 830C5B0506F
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 06:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED9C4A7DBB
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 04:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2812D1916;
	Tue, 15 Jul 2025 04:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L4Bi6sck"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210DB7DA73
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 04:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752554522; cv=none; b=HVX2atLkwNUSO27/BzJORhFZXk8O/+m6DHQREf+YJUAv3s0pAM5zbW3kcX4YoVrvs2JA8HfInj1DVWq7bcclw/BRNWeA23mUD9JFqLp6+SNT0ma0x+qlBoHecIaHq2LKbn3TLi9ycc4TFzO3iVJ0LH+c7Zi8hgbzQ9RPUVcQEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752554522; c=relaxed/simple;
	bh=pHQ9P2dvkglzwB8lr2IDOoFpbdG3sa7i+KpcXFiW37w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOrQsR2w1qxYXwYDauWS5wVgP6u7l78HQ/z1sHfxDsVY0Hwg2aeY7YjsUuJqqtNanA6ziSVJGwhyOCUktER4/F3WMR7Xotwue7O2E9yu67Vuei2y4ItSqBTCskL0Q1M3swcytFHJr6a67oLP+2Pz1RAiHuneuuZjH+2S9mS+Ep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L4Bi6sck; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <22e15dd2-8564-4e71-ab77-8b436870850d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752554518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUYSUO3giFQLHh8Swep5anuUUJIkaXAbxJDBLSg5p5c=;
	b=L4Bi6sckgrAU/vXCr8x/Tg9CCy4LNwl7n/ec6rWQd/+sHtSoJv9jDHIowLZ7RT4C6VBD5g
	TWdSrdVHFKi2m9Aa1m87w4AH9b+QAj8DcRamNXY/ES1pBabKq/1n+n834Kt3+GiMLpm8Fu
	3Ju4IjuQ34E1fgA8ewO8HmRqNResbWM=
Date: Tue, 15 Jul 2025 12:40:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 14/18] libbpf: add btf type hash lookup
 support
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, jolsa@kernel.org,
 bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 linux-kernel@vger.kernel.org
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-15-dongml2@chinatelecom.cn>
 <CAEf4BzaoKNNf5pr4z8vEokj3AyLNZYyjYQUOoEMMZHN6ETUg4g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <menglong.dong@linux.dev>
In-Reply-To: <CAEf4BzaoKNNf5pr4z8vEokj3AyLNZYyjYQUOoEMMZHN6ETUg4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/15/25 06:07, Andrii Nakryiko wrote:
> On Thu, Jul 3, 2025 at 5:22 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>> For now, the libbpf find the btf type id by loop all the btf types and
>> compare its name, which is inefficient if we have many functions to
>> lookup.
>>
>> We add the "use_hash" to the function args of find_kernel_btf_id() to
>> indicate if we should lookup the btf type id by hash. The hash table will
>> be initialized if it has not yet.
> Or we could build hashtable-based index outside of struct btf for a
> specific use case, because there is no one perfect hashtable-based
> indexing that can be done generically (e.g., just by name, or
> name+kind, or kind+name, or some more complicated lookup key) and
> cover all potential use cases. I'd prefer not to get into a problem of
> defining and building indexes and leave it to callers (even if the
> caller is other part of libbpf itself).


I think that works. We can define a global hash table in libbpf.c,
and add all the btf type to it. I'll redesign this part, and make it
separate with the btf.

Thanks!
Menglong Dong

>> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>> ---
>>   tools/lib/bpf/btf.c      | 102 +++++++++++++++++++++++++++++++++++++++
>>   tools/lib/bpf/btf.h      |   6 +++
>>   tools/lib/bpf/libbpf.c   |  37 +++++++++++---
>>   tools/lib/bpf/libbpf.map |   3 ++
>>   4 files changed, 140 insertions(+), 8 deletions(-)
>>
> [...]
>

