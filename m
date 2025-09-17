Return-Path: <bpf+bounces-68672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B5B805F5
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 17:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB99164ADD
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89583161A4;
	Wed, 17 Sep 2025 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aYTLk5sl"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885A21B19D
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121693; cv=none; b=PZESm3c5GtuvL64syGlGa8idpTFVpF+0D0D6O/1cI/e36QU1SOqLRcFFzG3URWXm3NSCY8akTSuQx5JFoDoRYPRRCHCvxdQ7LjeFL1/A4APrc4iTK5bxoz6hwZEgOKtusoyr5iIQAkScY/Xasi45qp0eTQfLaFygNxWHh1Hj2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121693; c=relaxed/simple;
	bh=PJri2abbyF8sk5Usinl2crdWhDeM4SJWYiN2OAblIac=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=YNGnqJep8SHQjGIVVvUyG8+X7eq5JVmRLYBi7SDMXcUSBh7GqYmmJMMEqA2OaVPGK6HE/wqygq7bvqwkthRSDnJeg325H+pGkF7NJajmGQCUYBSYnTh+B8GpJzk4kgwvNm/M/CJkvTLiA8gbBRO1JSjW5S/7bpWWG8tiz9mt82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aYTLk5sl; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758121688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdB9Qyczu+YVAaBNZwhR2xPSg1olBv8LVX+KZk08EMc=;
	b=aYTLk5slafLNpCV7uNbPFTL9skfpkTNd8qKm/snxQSO/BZdu9VAcmZADhUWL5qQwYcx2Ry
	ERCkk8id+vSy3Jykspzlvi2WWF85qkRDz6d55j1bCAEEAofq/sX2AFNQTTkYlzhzrtGWza
	9XUrP2XcHi3DYaa7NQOqt6EdGk82wEI=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Sep 2025 23:07:57 +0800
Message-Id: <DCV64CLD2WRC.VLHMKT6BLL7G@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <jolsa@kernel.org>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v7 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_cgroup_storage maps
References: <20250910162733.82534-1-leon.hwang@linux.dev>
 <20250910162733.82534-6-leon.hwang@linux.dev>
 <CAEf4BzaknkgAFfxA5WorX-2kZa=MHCB=MNXBvf6tDvQOb36o0A@mail.gmail.com>
In-Reply-To: <CAEf4BzaknkgAFfxA5WorX-2kZa=MHCB=MNXBvf6tDvQOb36o0A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed Sep 17, 2025 at 7:44 AM +08, Andrii Nakryiko wrote:
> On Wed, Sep 10, 2025 at 9:28=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>
>> Introduce BPF_F_ALL_CPUS flag support for percpu_cgroup_storage maps to
>> allow updating values for all CPUs with a single value for update_elem
>> API.
>>
>> Introduce BPF_F_CPU flag support for percpu_cgroup_storage maps to
>> allow:
>>
>> * update value for specified CPU for update_elem API.
>> * lookup value for specified CPU for lookup_elem API.
>>
>> The BPF_F_CPU flag is passed via map_flags along with embedded cpu info.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf-cgroup.h |  4 ++--
>>  include/linux/bpf.h        |  1 +
>>  kernel/bpf/local_storage.c | 22 +++++++++++++++++++---
>>  kernel/bpf/syscall.c       |  2 +-
>>  4 files changed, 23 insertions(+), 6 deletions(-)
>>
>
> [...]
>
>> @@ -216,7 +222,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map =
*_map, void *key,
>>         int cpu, off =3D 0;
>>         u32 size;
>>
>> -       if (map_flags !=3D BPF_ANY && map_flags !=3D BPF_EXIST)
>> +       if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F_A=
LL_CPUS))
>>                 return -EINVAL;
>
> shouldn't bpf_map_check_op_flags() be used here to validate cpu number
> and BPF_F_CPU and BPF_F_ALL_CPUS exclusivity?..
>

bpf_map_check_op_flags() has been called in
syscall.c::map_update_elem().

Thanks,
Leon

