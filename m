Return-Path: <bpf+bounces-36198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF27943ECA
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 03:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209191F22913
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 01:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1131DAC53;
	Thu,  1 Aug 2024 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e9AJ31Pi"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352AC1DA588
	for <bpf@vger.kernel.org>; Thu,  1 Aug 2024 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472489; cv=none; b=J8NkJ6sa2tpnXIPMzbFMJuzocbRw6eABm4DmvReWifpbSI/nj+hdb1DQWMbN3Nip1jYEBss1q/BjWetHa0X794loTYUPLZyoH3Z9IHQ+1TCScX+vlkcQk3l+MuPml6oJ1xnlAjdI5A/g45ZOaGtYqF4szn9TH+VBcdccB07GiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472489; c=relaxed/simple;
	bh=TqjH+T7N0eK/rWK6vlUoU3yzzETcvMrG7ZDozrgNbKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUlFARxqRQCZ43uk/u6oyi7TW+3g/oW7k+G/dJfzvYKXcx0hJ7pKM3T2eY+dasHhG8Wd8NuTXNfSw57jGQddAEBWznfdY5AMxd4Uu3SkEaAfLcUCYwijdZExFVOomKNlhP/iS1m/HCgs4u1zWQHRHz9efsdzPOAap7kCrlsji/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e9AJ31Pi; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <40851e4c-3a20-4a3d-a992-d00337f5d29f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722472485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8eOXb2I7KsrqxiRA0W79GmCoczHgC3DODavN63DVpTg=;
	b=e9AJ31PikuhtMpzBZaWLEMSiCAEdhWqBYf+TY309T8M46Eg0+5DrBrZkvS6pR9DviJlfoA
	BZ79kewzIi0Z9Zt6Ru0BjAQuctvefRmJ+RBTOaklWQ9DO+AZumUDPstQswlKJPJ6I4B+I2
	8BAnwkUwAzIsggatCFHybg/fNijpPw8=
Date: Wed, 31 Jul 2024 17:34:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V2 bpf-next] bpf: export btf_find_by_name_kind and
 bpf_base_func_proto
To: Ming Lei <ming.lei@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, andrii@kernel.org,
 drosen@google.com, kuifeng@meta.com, sinquersw@gmail.com,
 thinker.li@gmail.com, Yonghong Song <yonghong.song@linux.dev>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
References: <20240726125958.2853508-1-ming.lei@redhat.com>
 <d08f9080-3818-4869-8b5f-9292d772963f@linux.dev>
 <CAFj5m9KvXQa8VOJ_K2ZF0V2J2-wiwaJb4Df7dzE3ZC3jAGOg8g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAFj5m9KvXQa8VOJ_K2ZF0V2J2-wiwaJb4Df7dzE3ZC3jAGOg8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/31/24 1:18 AM, Ming Lei wrote:
> On Tue, Jul 30, 2024 at 5:07 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 7/26/24 5:59 AM, Ming Lei wrote:
>>> Almost all existed struct_ops users(hid, sched_ext, ...) need the two APIs.
>>>
>>> In-tree hid-bpf code(drivers/hid/bpf/hid_bpf_struct_ops.c) can't be built
>>> as module because the two APIs aren't exported.
>>
>> The patch looks fine. I don't see "config HID_BPF" can be built as a module now
>> though that could expose this issue. Did I miss something?
> 
> Yeah, this patch doesn't try to change HID_BPF yet, and it can be thought
> as one struct_ops module prep patch.
> 
> The issue itself is observed when I write ublk-bpf since ublk is one module
> and struct_ops is allowed to be registered in the module.

Good to hear struct_ops find another potential use case. The ublk-bpf 
development cannot continue without building as kmod?

Instead of exporting it now and pending without a user, I will wait till the 
first in-tree kmod use case comes up first.


