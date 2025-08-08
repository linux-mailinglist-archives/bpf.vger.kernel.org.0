Return-Path: <bpf+bounces-65272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB102B1ECD9
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 18:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6561A1C248FA
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76269286413;
	Fri,  8 Aug 2025 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ssNWRbNb"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3ED283137
	for <bpf@vger.kernel.org>; Fri,  8 Aug 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754669503; cv=none; b=btd0khCFCus421a5uQhl1s7ItZCRB3K09JEFock++sgWl5FAt36R5UzOLLrg26zJX4M55s5Y4Uoo+cruYLyeLgGQbfv/Xtr5X8rnMhDfz1C/4cONh+Ymg8pTqJEoyi8G8KxRjOO/4vYVGMtk3Eu/RL53UVb5y1l/VrnkhQ04Nkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754669503; c=relaxed/simple;
	bh=A6CdJ4G923TLpBUO0DqUp3Q7cYiCbye8qJjgZeyxyZE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eFUkmeqOuaheejei1+YjN8F1G/98dWc+qeKCrW2DqBUzepTG8NYTFTcELEkG3nS3ha8dKrjWIXHNtwsvlZwtR+QEq51QungC3H/dBPKt8oAS67tXdZ7jp3KT5uJBY0qpaBvCus5bdp0nQZH2iPRevf+mHziG6S44GDnDlj4fohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ssNWRbNb; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754669498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GP4ZYhn6PkAT4MdyoXcvFK1IDONbBlow8hjY42Begis=;
	b=ssNWRbNbJ6kRyl+S1hXmCsZkIHy1qF1VCf0jPQrqyybVDlvSRHyys1fI2nnAncQy/7ceF/
	uq1cPFIpgLDhWqxGo3gahx/x+2y/e+gVLsUiv6Qjf5GGeqOwhWowl28aw7/C2OXZ3WBS2o
	k8FDoqjduV+1Qkfrr7q/8xilGIkh2Ek=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 09 Aug 2025 00:11:24 +0800
Message-Id: <DBX6F51OAZSO.3OKUPR14AGTSI@linux.dev>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Yonghong Song" <yonghong.song@linux.dev>, "Song
 Liu" <song@kernel.org>, "Eduard" <eddyz87@gmail.com>, "Daniel Xu"
 <dxu@dxuuu.xyz>, =?utf-8?q?Daniel_M=C3=BCller?= <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
References: <20250805163017.17015-1-leon.hwang@linux.dev>
 <20250805163017.17015-2-leon.hwang@linux.dev>
 <CAADnVQ+Mkmy+9WnepShLsQtMWceFUpfsV-Tw=dMaXP-B15R2yQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+Mkmy+9WnepShLsQtMWceFUpfsV-Tw=dMaXP-B15R2yQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri Aug 8, 2025 at 1:20 AM +08, Alexei Starovoitov wrote:
> On Tue, Aug 5, 2025 at 9:30=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>>
>> Introduce support for the BPF_F_CPU flag in percpu_array maps to allow
>> updating values for specified CPU or for all CPUs with a single value.
>>
>> This enhancement enables:
>>
>> * Efficient update of all CPUs using a single value when cpu =3D=3D (u32=
)~0.
>> * Targeted update or lookup for a specified CPU otherwise.
>>
>> The flag is passed via:
>>
>> * map_flags in bpf_percpu_array_update() along with embedded cpu field.
>> * elem_flags in generic_map_update_batch() along with embedded cpu field=
.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h            |  3 +-
>>  include/uapi/linux/bpf.h       |  6 +++
>>  kernel/bpf/arraymap.c          | 54 ++++++++++++++++++------
>>  kernel/bpf/syscall.c           | 77 +++++++++++++++++++++-------------
>>  tools/include/uapi/linux/bpf.h |  6 +++
>>  5 files changed, 103 insertions(+), 43 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index cc700925b802f..c17c45f797ed9 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2691,7 +2691,8 @@ int map_set_for_each_callback_args(struct bpf_veri=
fier_env *env,
>>                                    struct bpf_func_state *callee);
>>
>>  int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
>> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
>> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
>> +                         u64 flags);
>>  int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
>>                            u64 flags);
>>  int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value=
,
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 233de8677382e..67bc35e4d6a8d 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1372,6 +1372,12 @@ enum {
>>         BPF_NOEXIST     =3D 1, /* create new element if it didn't exist =
*/
>>         BPF_EXIST       =3D 2, /* update existing element */
>>         BPF_F_LOCK      =3D 4, /* spin_lock-ed map_lookup/map_update */
>> +       BPF_F_CPU       =3D 8, /* map_update for percpu_array */
>
> only percpu_array?!
> Aren't you doing it for percpu_hash too?
>

Only percpu_array in this patchset.

I have no need to do it for percpu_hash.

> The comment should also say that upper 32-bit of flags is a cpu number.
>
>> +};
>> +
>> +enum {
>> +       /* indicate updating value across all CPUs for percpu maps. */
>> +       BPF_ALL_CPUS    =3D (__u32)~0,
>>  };
>
> The name is inconsistent with BPF_F_ that was adopted long ago.
>
> Also looking at the implementation that ~0 looks too magical.
> imo it's cleaner to add another BPF_F_ALL_CPUS flag.
> BPF_F_CPU =3D 8 and upper 32-bit select a cpu.
> BPF_F_ALL_CPUS =3D 16 -> all cpus.

Sure, let us add these two flags:

       BPF_F_CPU       =3D 8, /* cpu flag for percpu maps, upper 32-bit of =
flags is a cpu number */
       BPF_F_ALL_CPUS  =3D 16, /* update value across all CPUs for percpu m=
aps */

Thanks,
Leon

