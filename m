Return-Path: <bpf+bounces-70574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545DCBC3574
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 06:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D3B19E14D7
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 04:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79B12BEC52;
	Wed,  8 Oct 2025 04:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w6L2OfQz"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04D34BA3C
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 04:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898893; cv=none; b=GPjFa0QK2bdtMC28nGt7qA3fknoYZDCjtdjNZmSoGLkoSEipJjJCTxHZQM7ebcUXa2Tk27i3oz8p5myLog2YD3/i5hn7trh6/7XI1bQZ1q/beARsZql3+D6yoPp8JhbWbh3iDEM6BL3xrFDnaWiPhDQP3PVoC4mn+Yu4HM2jTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898893; c=relaxed/simple;
	bh=lOEgX5EVlJWqWfcM2XlvfMcIJe/BK0TAYDU3pqVhhZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crIdtOw0h2IZgdyZAbIY491MzaodFDD77yMMbSlx9CyonGY86ekO44p3xOUQlDBoTdr4G6qy2JZcU9FnhKlAZxaQMMihqnkEtbSNLte2jd+ntfnvVkHNwBPuiHR6oihr/yFljtEuKIZDhWyWgyJRKFArXJ/vHpkl/+8KbHJ/Z5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w6L2OfQz; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f87450f9-f748-428f-8d5e-842cd96303c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759898888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uu3tPvcu0fLDFC55uGQjHpCc5gZqECjA4L5tuUbxaxU=;
	b=w6L2OfQzg8Rs/l+Hvg8UnzTf24dMrNSValnGLDgegRS+pxpv9xjgTqJxEGa4Oh/nshJzFV
	++N5AVJuO6d3MvULwOurmvXwvDQCpLIhNsqw60h/EYlhMwLkOSs9sauEBF61OgbKMx3wut
	67UBvrRAUU9Tm0M/+n74/dgPPJvCNE8=
Date: Wed, 8 Oct 2025 12:48:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net,
 kernel-patches-bot@fb.com
References: <20250930153942.41781-1-leon.hwang@linux.dev>
 <20250930153942.41781-5-leon.hwang@linux.dev>
 <CAEf4Bzb5Md09meboYPvdBUPZP3V2ET0AafbQFi89U8Wa3zVfGw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bzb5Md09meboYPvdBUPZP3V2ET0AafbQFi89U8Wa3zVfGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/10/25 06:29, Andrii Nakryiko wrote:
> On Tue, Sep 30, 2025 at 8:40 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Introduce BPF_F_ALL_CPUS flag support for percpu_hash and lru_percpu_hash
>> maps to allow updating values for all CPUs with a single value for both
>> update_elem and update_batch APIs.
>>
>> Introduce BPF_F_CPU flag support for percpu_hash and lru_percpu_hash
>> maps to allow:
>>
>> * update value for specified CPU for both update_elem and update_batch
>> APIs.
>> * lookup value for specified CPU for both lookup_elem and lookup_batch
>> APIs.
>>
>> The BPF_F_CPU flag is passed via:
>>
>> * map_flags along with embedded cpu info.
>> * elem_flags along with embedded cpu info.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---

[...]

>>
>>                 for_each_possible_cpu(cpu) {
>> -                       copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value + off);
>> -                       off += size;
>> +                       ptr = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
>> +                       memcpy(per_cpu_ptr(pptr, cpu), ptr, size);
>
> ok, so you fixed the value_size problem and at the same time
> introduced blind memcpy() problem?.. Per-CPU maps are allowed to have
> some special fields (see BPF_REFCOUNT and BPF_KPTR_* checks in
> map_check_btf()), which have to be handled specially inside
> copy_map_value[_long](), we cannot just memcpy() blindly
>
> all the other places use copy_map_value[_long](), why did you decide
> to switch to memcpy here?
>

You’re right — using memcpy() here is incorrect. I should be using
copy_map_value() instead.

When comparing this path with bpf_percpu_array_update(), I noticed that
bpf_obj_free_fields() is missing here. That was why I initially switched
to memcpy().

To clarify:

1. If those special fields (like BPF_REFCOUNT or BPF_KPTR_*) are
   *not* supported here, memcpy() behaves the same as
   copy_map_value().

static inline void bpf_obj_memcpy(struct btf_record *rec,
                                  void *dst, void *src, u32 size,
                                  bool long_memcpy)
{
        u32 curr_off = 0;
        int i;

        if (IS_ERR_OR_NULL(rec)) {
                if (long_memcpy)
                        bpf_long_memcpy(dst, src, round_up(size, 8));
                else
                        memcpy(dst, src, size);
                return;
        }

        ...
}

static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
{
        bpf_obj_memcpy(map->record, dst, src, map->value_size, false);
}

2. However, if those special fields *are* supported here, then missing
   bpf_obj_free_fields() seems like a real issue.
   In that case, I’d like to send a separate patch set to add
   bpf_obj_free_fields() properly.
   Does that sound reasonable?

Thanks,
Leon

[...]

