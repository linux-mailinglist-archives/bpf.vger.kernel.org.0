Return-Path: <bpf+bounces-67297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C06AB423C5
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88698565AD4
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5381482E8;
	Wed,  3 Sep 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IlpEDoyC"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D81DE2C2
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909870; cv=none; b=SD/fl5+svLmJsFGslIBVSr14pwREKUBaFderm1MgEF9HSAwdDnYpWgGMbhIVlWuw8WUUfv3efj7+ZUjjCxYWcxH29EVxEdrXKFqFGQlWwqlrvl8LayffasYvbygZcTOmHPZOs8Mn6InFV+s2bSCV9aKA15L8tK8XORK2LZrhwhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909870; c=relaxed/simple;
	bh=3lHrqSZo98rJR5tNrSAbn2Qu0PVcxF/KKF92ISAhTtg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=qc/R5O2S6QL7EBD8luqa/qbqUSZt2mNtj7sq2BYrrpBYrFIAg+cGdRX406Kpycxgbp6VAGorlyn8SMedV5lp3UtLUsub753ODBlvs/TCtv51KGBUxdjL7ezNR6BNinN6i4edUQ1s8/zhBrb5Up+kFeeF0D4uKGXAkVd4bNsN8Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IlpEDoyC; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756909865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3tcwvlzVKQvsuXHR+WolzTJjwa5FV2l0pcqUfQF2Lc=;
	b=IlpEDoyC/EOpcSfOCl3b0qxqGwwD7DpgkgIyvmXrfj3+Ke3LzCVjMF1O6uIePOlmSWrHeq
	4xnrlFNVDLQtMSmwKog56o/WbbVASn2AUGs0bh6Np539+bNcE78kzcTLYqwgM8GxY/MajG
	fn1DadqpIG3wrlZYp90s21cMJ6urj0c=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Sep 2025 22:30:56 +0800
Message-Id: <DCJ8KDMJTD6G.2KKD198T5JU6S@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <jolsa@kernel.org>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v4 4/7] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags for percpu_hash and lru_percpu_hash maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
References: <20250827164509.7401-1-leon.hwang@linux.dev>
 <20250827164509.7401-5-leon.hwang@linux.dev>
 <CAEf4BzaheSfrpwVXyk_f2iTVyTdN-ck65Viz31-ygLByiCV4YQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaheSfrpwVXyk_f2iTVyTdN-ck65Viz31-ygLByiCV4YQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu Aug 28, 2025 at 7:18 AM +08, Andrii Nakryiko wrote:
> On Wed, Aug 27, 2025 at 9:45=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>

[...]

>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 71f9931ac64cd..031a74c1b7fd7 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -937,24 +937,39 @@ static void free_htab_elem(struct bpf_htab *htab, =
struct htab_elem *l)
>>  }
>>
>>  static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
>> -                           void *value, bool onallcpus)
>> +                           void *value, bool onallcpus, u64 map_flags)
>>  {
>> +       int cpu =3D map_flags & BPF_F_CPU ? map_flags >> 32 : 0;
>> +       int current_cpu =3D raw_smp_processor_id();
>> +
>>         if (!onallcpus) {
>>                 /* copy true value_size bytes */
>> -               copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
>> +               copy_map_value(&htab->map, (map_flags & BPF_F_CPU) && cp=
u !=3D current_cpu ?
>> +                              per_cpu_ptr(pptr, cpu) : this_cpu_ptr(ppt=
r), value);
>
> FWIW, I still feel like this_cpu_ptr() micro-optimization is
> unnecessary and is just a distraction. This code is called when
> user-space updates/looks up per-CPU value, it's not a hot path by any
> means where this_cpu_ptr() vs per_cpu_ptr() makes any measurable
> difference
>

OK.

I'll remove it in next revision.

>>         } else {
>>                 u32 size =3D round_up(htab->map.value_size, 8);
>> -               int off =3D 0, cpu;
>> +               int off =3D 0;
>> +
>> +               if (map_flags & BPF_F_CPU) {
>> +                       copy_map_value_long(&htab->map, cpu !=3D current=
_cpu ?
>> +                                           per_cpu_ptr(pptr, cpu) : thi=
s_cpu_ptr(pptr), value);
>> +                       return;
>> +               }
>>
>>                 for_each_possible_cpu(cpu) {
>>                         copy_map_value_long(&htab->map, per_cpu_ptr(pptr=
, cpu), value + off);
>> -                       off +=3D size;
>> +                       /* same user-provided value is used if
>> +                        * BPF_F_ALL_CPUS is specified, otherwise value =
is
>> +                        * an array of per-cpu values.
>> +                        */
>> +                       if (!(map_flags & BPF_F_ALL_CPUS))
>> +                               off +=3D size;
>>                 }
>>         }
>
> this couldn't have been replaced by bpf_percpu_copy_to_user?.. (and I
> just want to emphasize how hard did you make it to review all this by
> putting those bpf_percpu_copy_to_user and bpf_percpu_copy_from_user on
> its own in patch #2, instead of having a proper refactoring patch...)
>

Sorry about this.

I will use 'bpf_percpu_copy_from_user()' here in next revision.

Thanks,
Leon

