Return-Path: <bpf+bounces-59234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284EAAC75F6
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 04:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70DD1BC27D5
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 02:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47955245006;
	Thu, 29 May 2025 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ma0EEGl0"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D638FB0
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 02:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748487386; cv=none; b=E3zA9QPisq7U5QPNx9haSjgXTlGvfoG7ye+FhnlqZtQFpD8RurCENswMpT15gqyJEDSmQHbIo3hbk5Tp/PtVVIZA/XKGFB8rHT5bfPSAwAkOCkBoj7oM1MCROZd+L4feaVh6QX3iEJ9PbQFU41jb2J6GS6+gSQXxqApT7p+0rBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748487386; c=relaxed/simple;
	bh=tABwj7XTL9D30FlF7LTl3X4ANifdw3HDSnKTtPHUILU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwtdS7jLYo/pptK9WxxKmtYG5efhpo6Vlg+Enf1R1NEfSdHvvjEg0n89i9OQsyUF7VykjlobCCQLStHk++bLlXs+/OZYPHLHUmVHHQQQ3Z6QwucluDlfbjUNKFi92+F+JwUQCfQD/zGfrHx7v0xQXpPjeM1ZQ5ec8o5MzfDISSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ma0EEGl0; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d94fcd1-9ddd-49c4-86b6-720b3636ad24@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748487382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARYEvAnGmT2qiORHfYdbej6cqW8A/bbSTFutcuynHgs=;
	b=ma0EEGl0ixA3NNLViMS6sSLYRoZ9Rsv9mvHGxTiZymqujwmKB6EuvZB7bIaMMznfJwObVg
	q3N8FZimeRUcMY24Lu6cHCdbCDVPhPEoyyakxu1RrLY+++pZQDVlyq1ZKsu0/NEwl556SW
	slP7oYxsEg8H4GDIL4wmvRdGQcA3nzo=
Date: Thu, 29 May 2025 10:56:14 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzY9KeVeo2+6Ht1v3rL6UdwNxABZCSK1OZ_sD8qhpYZaeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 28/5/25 06:31, Andrii Nakryiko wrote:
> Adding libbpf-rs maintainer, Daniel, for awareness, as Rust skeleton
> will have to add support for this, once this patch set lands upstream.
> 
> 

[...]

>> +
>> +       if (map_cnt) {
>> +               bpf_object__for_each_map(map, obj) {
>> +                       if (bpf_map__is_internal_percpu(map) &&
>> +                           get_map_ident(map, ident, sizeof(ident)))
>> +                               printf("\tobj->%s = NULL;\n", ident);
>> +               }
>> +       }
> 
> hm... maybe we can avoid this by making libbpf re-mmap() this
> initialization image to be read-only during bpf_object load? Then the
> pointer can stay in the skeleton and be available for querying of
> "initialization values" (if anyone cares), and we won't have any extra
> post-processing steps in code generated skeleton code?
> 
> And Rust skeleton will be able to expose this as a non-mutable
> reference with no extra magic behind it?
> 
> 
We can re-mmap() it as read-only.

However, in the case of the Rust skeleton, users could still use unsafe
code to cast immutable variables to mutable ones.

That said, it's better to guide users toward treating them as immutable.

Thanks,
Leon


