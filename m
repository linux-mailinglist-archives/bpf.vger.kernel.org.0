Return-Path: <bpf+bounces-67298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355D7B423D2
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20D4581E64
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEF21F91C7;
	Wed,  3 Sep 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ulyFPqqw"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BEA1F3BA9
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910050; cv=none; b=Jthyx4jFBzIzLVf9KYdBnAzN6cIxt/snQcTGONO9qKpate8MarDRlSBH1X3qb5uRyGeXAQ3AFXhODMPhAhTT0MQXIYyOZ9hDqnhyDEz3Xb8OqtxSZ3ZmTrvLBJ3DJ7IThgKA/s1NXvx6ZMLPJhw7oOHTtnXYqM3Um4uRFwbxlYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910050; c=relaxed/simple;
	bh=GbGlLa4mfxnAPtgW1Ywxq+dsJv5oPmb8tTTlGIKZRrk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=IMBsas/wIZsPJmp0GQJLQ+XuV8TpqjfUuBKsrMrx15EUWMSvN+ZkXKbe8lXqAKkcwtT86zcQW7Y2TpUWyL5Vqrwb1/Lw66eSj4VwXBvogQbNcb4/D3ja5JmoureQcoW/acvvKexDlVzdbnw7KIjfwEa7fd5+WgaUClbfRA8DeXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ulyFPqqw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756910044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxZW2dSiGpzXWqc8XlkHm065OPHsLqv2OHfaqz6I22o=;
	b=ulyFPqqwIHsMjIWnQdC+le9cIT48ewtZ3WF4DKQb0+4Cwikf0CQWqShVfeaUz9uU+Ty+4t
	2n5B7sU2emFzZ54SoVmdW6VBAsrrQn7ot3ZY+Zn36I+DTLWl8G+la3bKXKVB/I8bpb4/Ha
	KtoDFCiOy91S3S591gxKpymtfskZdIo=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Sep 2025 22:33:57 +0800
Message-Id: <DCJ8MOSL8J1K.30PYFD0VW5U9@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <jolsa@kernel.org>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v4 6/7] libbpf: Support BPF_F_CPU and
 BPF_F_ALL_CPUS flags for percpu maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
References: <20250827164509.7401-1-leon.hwang@linux.dev>
 <20250827164509.7401-7-leon.hwang@linux.dev>
 <CAEf4BzaLiFhd5RiSEzA-mk7bGZC-5YANBciQfhk+yxnN_inuXA@mail.gmail.com>
In-Reply-To: <CAEf4BzaLiFhd5RiSEzA-mk7bGZC-5YANBciQfhk+yxnN_inuXA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu Aug 28, 2025 at 7:18 AM +08, Andrii Nakryiko wrote:
> On Wed, Aug 27, 2025 at 9:46=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>
>> Add libbpf support for the BPF_F_CPU flag for percpu maps by embedding t=
he
>> cpu info into the high 32 bits of:
>>
>> 1. **flags**: bpf_map_lookup_elem_flags(), bpf_map__lookup_elem(),
>>    bpf_map_update_elem() and bpf_map__update_elem()
>> 2. **opts->elem_flags**: bpf_map_lookup_batch() and
>>    bpf_map_update_batch()
>>
>> And the flag can be BPF_F_ALL_CPUS, but cannot be
>> 'BPF_F_CPU | BPF_F_ALL_CPUS'.
>>
>> Behavior:
>>
>> * If the flag is BPF_F_ALL_CPUS, the update is applied across all CPUs.
>> * If the flag is BPF_F_CPU, it updates value only to the specified CPU.
>> * If the flag is BPF_F_CPU, lookup value only from the specified CPU.
>> * lookup does not support BPF_F_ALL_CPUS.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/lib/bpf/bpf.h    |  8 ++++++++
>>  tools/lib/bpf/libbpf.c | 33 +++++++++++++++++++++++++++------
>>  tools/lib/bpf/libbpf.h | 21 ++++++++-------------
>>  3 files changed, 43 insertions(+), 19 deletions(-)
>>
>
> [...]
>
>> @@ -10629,6 +10629,27 @@ static int validate_map_op(const struct bpf_map=
 *map, size_t key_sz,
>>         case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE: {
>>                 int num_cpu =3D libbpf_num_possible_cpus();
>>                 size_t elem_sz =3D roundup(map->def.value_size, 8);
>> +               __u32 cpu;
>> +
>> +               if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
>> +                       if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CP=
US)) {
>> +                               pr_warn("map '%s': can't use BPF_F_CPU a=
nd BPF_F_ALL_CPUS at the same time\n",
>> +                                       map->name);
>> +                               return -EINVAL;
>> +                       }
>> +                       cpu =3D flags >> 32;
>> +                       if (cpu >=3D num_cpu) {
>
> only check this if BPF_F_CPU is set
>
>> +                               pr_warn("map '%s': cpu %u in flags canno=
t be GE num cpus %d\n",
>
> "GE"? maybe "CPU #%d is not valid"... (or don't even check cpu value
> itself, it's unlikely user using BPF_F_CPU will get it so wrong)
>

Let's remove it instead.

Thanks,
Leon

