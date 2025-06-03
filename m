Return-Path: <bpf+bounces-59477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397B1ACBE97
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 04:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED79D16F6F9
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 02:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759812CD96;
	Tue,  3 Jun 2025 02:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e+1LT30X"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6CC3FE4
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 02:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748918905; cv=none; b=YQhGMk+HG+65CR9mfSYuGc+7XnRDmCQTlLeNHTsKonzylBMoBnkhdqbifWrj8jJKOSv228ijSU1No2kq+cJKzvqfVdDQCeP1HLZ0D7LWUfJl+15nP4vaJy8LzHTNMo7c5uAy3Z9sEgsZozcrrQKSa3g0208A1RxlrP4+AZppSQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748918905; c=relaxed/simple;
	bh=bDbN/pUUCsasyHfTje7nyuNy7yM1UBPiW8nU2tT+CkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=So/3I5W6/K753Z+7G++zc2N5xlpxyTu6IBTV8Bl68Wf/WneE6/r3t9i8NC4CKWSP6IsIxRUQRqc8BSaUjSIrxEVXxNaOw+pWuvZyp/TGphI9agAjvayz10CSngqcNtz9n6wzR9VJ0BLjSFIMuT5Modmp/coXYNZQ6zHWVvA9Lq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e+1LT30X; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <53bf93fb-079c-4133-8f55-0aed72ec8a88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748918901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/j1puQZRDhJ0qoYMQOD1oTjw2gQglSLkgl/8bmDUL54=;
	b=e+1LT30Xmr0ff0wlWVpZZ00SXRjgF4d8ppglmQISmQYZesx6+pI3Bar05zbv3wDMMkzzVK
	GusBsp/pouiODVEgAAsozf2ZE6loBOmid7HlMdkJiUpEyBYNtY5hyeMOead/8debpua8uf
	qobk/weVtf3PV0ehNQQW4GjVmHD+L9c=
Date: Tue, 3 Jun 2025 10:47:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/4] bpf, bpftool: Generate skeleton for
 global percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com,
 =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
References: <20250526162146.24429-1-leon.hwang@linux.dev>
 <20250526162146.24429-4-leon.hwang@linux.dev>
 <CAEf4BzY9KeVeo2+6Ht1v3rL6UdwNxABZCSK1OZ_sD8qhpYZaeQ@mail.gmail.com>
 <2d94fcd1-9ddd-49c4-86b6-720b3636ad24@linux.dev>
 <CAEf4BzYzikQSvvJTm8j2X71ewBxZjVKLLFqxaVMCgziJMWC8mA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYzikQSvvJTm8j2X71ewBxZjVKLLFqxaVMCgziJMWC8mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/6/25 07:50, Andrii Nakryiko wrote:
> On Wed, May 28, 2025 at 7:56 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 28/5/25 06:31, Andrii Nakryiko wrote:
>>> Adding libbpf-rs maintainer, Daniel, for awareness, as Rust skeleton
>>> will have to add support for this, once this patch set lands upstream.
>>>
>>>
>>
>> [...]
>>
>>>> +
>>>> +       if (map_cnt) {
>>>> +               bpf_object__for_each_map(map, obj) {
>>>> +                       if (bpf_map__is_internal_percpu(map) &&
>>>> +                           get_map_ident(map, ident, sizeof(ident)))
>>>> +                               printf("\tobj->%s = NULL;\n", ident);
>>>> +               }
>>>> +       }
>>>
>>> hm... maybe we can avoid this by making libbpf re-mmap() this
>>> initialization image to be read-only during bpf_object load? Then the
>>> pointer can stay in the skeleton and be available for querying of
>>> "initialization values" (if anyone cares), and we won't have any extra
>>> post-processing steps in code generated skeleton code?
>>>
>>> And Rust skeleton will be able to expose this as a non-mutable
>>> reference with no extra magic behind it?
>>>
>>>
>> We can re-mmap() it as read-only.
>>
>> However, in the case of the Rust skeleton, users could still use unsafe
>> code to cast immutable variables to mutable ones.
> 
> you have to actively want to abuse the API to do this, so I wouldn't
> be too concerned about this
> 

Agreed.

It will be marked as read-only using mprotect().

Thanks,
Leon



