Return-Path: <bpf+bounces-68802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DE5B85B55
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 17:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB7583926
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D6313E31;
	Thu, 18 Sep 2025 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hg0CQx3B"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFC2313E16
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209906; cv=none; b=tC+rr0m9icCB0NZ+WW7k8z+tVywE87hkaqdk7L2uP4Xw9ndqx+50A/0GyFblaE3DrdZ8cCFAuEGp1R7fEE6KeqmIA6ILkR7WzYSyzRH7nKeLj0KZf4AuQoN4SgQdofIt8z3QG6U2D8SrSEOm1ULvRPjvdrEV43/eT4JyO0FG7ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209906; c=relaxed/simple;
	bh=QxbNlar7fm1Yy9OxNxskgOfzkarK1UdyObICuS2M3zg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=onQvWBK4ydUDPF6P9N0uqF5+pfscUdWogc6eH17o76wGSphNo33Pog+kIpfUN232RxtDrbRXdLtLSX9gJDebvE11gOfCgZH6ejr+x9HTJBrqlgxsKGstJwaVKMpJIBxSAz8AxWV1o9QSvMBicY3ebzSYKzgIh3DSjv+Agf3uRhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hg0CQx3B; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758209901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHVjPe0bsRPHEcmpUvli3nZUAnkCPxHuWoXX/AW5fbs=;
	b=Hg0CQx3BiVE78dcSvKzcQzBc3Qacu7gB1JP+HQdxVniF+Y8PRIcXyLEKnpo5HwMqVMaJ1x
	QqqtPIBCfNhPHNnCSAEMM2CEoQfx0uKBRHFsB1mVgAPkyuQv0ZXum6SES86stFjl0DbeOW
	Ql4Zi+WI+0C+BoHNcTAhJGcYI56PNTA=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Sep 2025 23:38:02 +0800
Message-Id: <DCW1DXJPQF4W.1SJVD456I2LT1@linux.dev>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <jolsa@kernel.org>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v7 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_cgroup_storage maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
References: <20250910162733.82534-1-leon.hwang@linux.dev>
 <20250910162733.82534-6-leon.hwang@linux.dev>
 <CAEf4BzaknkgAFfxA5WorX-2kZa=MHCB=MNXBvf6tDvQOb36o0A@mail.gmail.com>
 <DCV64CLD2WRC.VLHMKT6BLL7G@linux.dev>
 <CAEf4BzZvmwExwaWFAj2b1BpUQM2G_KK9EF9GjGK7A11wO5JRKQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZvmwExwaWFAj2b1BpUQM2G_KK9EF9GjGK7A11wO5JRKQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

>> >> @@ -216,7 +222,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_m=
ap *_map, void *key,
>> >>         int cpu, off =3D 0;
>> >>         u32 size;
>> >>
>> >> -       if (map_flags !=3D BPF_ANY && map_flags !=3D BPF_EXIST)
>> >> +       if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_=
F_ALL_CPUS))
>> >>                 return -EINVAL;
>> >
>> > shouldn't bpf_map_check_op_flags() be used here to validate cpu number
>> > and BPF_F_CPU and BPF_F_ALL_CPUS exclusivity?..
>> >
>>
>> bpf_map_check_op_flags() has been called in
>> syscall.c::map_update_elem().
>
> ah, I actually tried to double-check that by looking at earlier
> patches, but still missed that. Never mind then.
>

Sorry for the earlier unclear explanation.

Let me restate:

1. Patch #1 introduces bpf_map_check_op_flags().
2. Patch #1 also updates map_update_elem() to call
   bpf_map_check_op_flags().
3. Patch #2 extends bpf_map_check_op_flags() to validate the CPU flags
   and CPU number.

When updating elements of percpu cgroup_storage maps, map_update_elem()
calls bpf_map_check_op_flags() before
bpf_percpu_cgroup_storage_update() being invoked.

So, the CPU flags and CPU number are already validated in
map_update_elem(), and don=E2=80=99t need to be re-checked here.

Thanks,
Leon

