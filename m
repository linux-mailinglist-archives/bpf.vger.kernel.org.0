Return-Path: <bpf+bounces-67296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20BDB42399
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938773BFA96
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F031730F52B;
	Wed,  3 Sep 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SNQWitay"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38FD3093D8
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909628; cv=none; b=sHMVD0YIDiFcCyT26MvzgTyKDY0w7uPVck/8i/15+2jm41uRtG5UQThnWI5NjYSyZmytRtX6CuecjYrggULi2K3TY3iHefjG25efxbeYYldDBNiIWuRH4MhIarOjpCPe2XQb6dskLeiH95LXoVkk0KfjsTAlUsnoO62P7QmnOFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909628; c=relaxed/simple;
	bh=iRKDzidtD3Mu7HQb+/+yUEprpVYXjsCFSFCPhno/w2Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r37M8x46s3dVXTPC1yGbA6AleomNB8IAmz7PPrl+ybTGlCLDoTfNb0tA1D+he0qwFhD/7m16+yWGq/wP2trsHqKwROkMoAEVl1nEUShQWhvLvU7gASecqAWdjnRnNW6FH58CDD+YVYi/O5DxZMOywcwbMShCafGjcBlRZsGj4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SNQWitay; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756909622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+EoDzwsyIb08XfsFf9hmQiBRP7mdhGNGyxHz6j44FI=;
	b=SNQWitay0F3UxQxCn+9zQigo45Vc3NbEkkuv+JrCQkAZLTynEEq0DtnfRJbo9jzl60rUzc
	6fy4EK5k0wWJE+rxkQoYPXJLTdBHc5lcEc9XXZ6DbXLvjijK4LtVdEbOtgKjcoPmQUifnj
	HzFJZt+IkIbW5K2TqylZn+4QRGYghCQ=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Sep 2025 22:26:51 +0800
Message-Id: <DCJ8H98X6UL4.3O75SJOM2WWRG@linux.dev>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <jolsa@kernel.org>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v4 2/7] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
References: <20250827164509.7401-1-leon.hwang@linux.dev>
 <20250827164509.7401-3-leon.hwang@linux.dev>
 <CAEf4BzaUw868nNG3ngMci4fLPDGsaffQ-O3YrPOEo7N5QEkM_w@mail.gmail.com>
In-Reply-To: <CAEf4BzaUw868nNG3ngMci4fLPDGsaffQ-O3YrPOEo7N5QEkM_w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu Aug 28, 2025 at 7:18 AM +08, Andrii Nakryiko wrote:
> On Wed, Aug 27, 2025 at 9:45=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>

[...]

>>
>> +#ifdef CONFIG_BPF_SYSCALL
>> +static inline void bpf_percpu_copy_to_user(struct bpf_map *map, void __=
percpu *pptr, void *value,
>> +                                          u32 size, u64 flags)
>> +{
>> +       int current_cpu =3D raw_smp_processor_id();
>> +       int cpu, off =3D 0;
>> +
>> +       if (flags & BPF_F_CPU) {
>> +               cpu =3D flags >> 32;
>> +               copy_map_value_long(map, value, cpu !=3D current_cpu ? p=
er_cpu_ptr(pptr, cpu) :
>> +                                   this_cpu_ptr(pptr));
>> +               check_and_init_map_value(map, value);
>
> I'm not sure it's the question to you, but why would we
> "check_and_init_map_value" when copying data to user space?... this is
> so confusing...
>

After reading its code, I think it's to hide some kernel details from
user space, e.g. refcount, list nodes, rb nodes.

>> +       } else {
>> +               for_each_possible_cpu(cpu) {
>> +                       copy_map_value_long(map, value + off, per_cpu_pt=
r(pptr, cpu));
>> +                       check_and_init_map_value(map, value + off);
>> +                       off +=3D size;
>> +               }
>> +       }
>> +}
>> +
>> +void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
>> +
>> +static inline void bpf_percpu_copy_from_user(struct bpf_map *map, void =
__percpu *pptr, void *value,
>> +                                            u32 size, u64 flags)
>> +{

[...]

>> +}
>> +#endif
>
> hm... these helpers are just here with no way to validate that they
> generalize existing logic correctly... Do a separate patch where you
> introduce this helper before adding per-CPU flags *and* make use of
> them in existing code? Then we can check that you didn't introduce any
> subtle differences? Then in this patch you can adjust helpers to
> handle BPF_F_CPU and BPF_F_ALL_CPUS?
>

Get it.

I'll send a separate patch later.

Thanks,
Leon

