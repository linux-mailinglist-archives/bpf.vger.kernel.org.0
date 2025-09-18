Return-Path: <bpf+bounces-68804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BF0B85EA9
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53A61887933
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC72F8BF4;
	Thu, 18 Sep 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rVuPWbHh"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC95242D63
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211654; cv=none; b=D7OqejjihdmRqeib88g2MkB91mkrovfp1cz9eY19VsUhAXhKwvvdQVQWh9W3C88NZ0poDEdiYF+oXiHnK7EUY9w2H90sW2bAd0P7a0W0sRZceqQRATHhl1EWunUwfRWIkDPV8xvF0ezLClsgjPH2QtYFg/gMKrZg38B/+NWZ+DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211654; c=relaxed/simple;
	bh=poSCvz7V/2Gly1Qii/4R9pisGqAl32GlQy20PpjSY4Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Z7Xi4DG16r4iOB+fuAQB78IOdXrlzdZEnveiSaajAXcZxT/hYZFXV1Sc263tE5rUu1WmKNYWgcJ5F2mDzwh+iaEHKiZ9TM9ZasIfHn2xZKJCFuLH2LXkSW3I/AURhum4o9SJUUzGfEWW4fn1GjJRcL8C7ZvrahsV5L+XS/2vMvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rVuPWbHh; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758211649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SvXBFmd1/TGWKIQqFkaahXfopVvzLMGaUjWqh7S1br8=;
	b=rVuPWbHhBblOdC5UqZAjBTTepbTLLcSii+ApW8N5OlBEs/edwekdrnJGSNcA77AzaZpa0U
	hBrSCT2WA6BwBP7aQcJCrfe5zpqybZ0JSU4Ozuer1/JwYMHTdJS5+M1PgW6qhZhjC4teqj
	LyGe4hNMOx1TtS4sWkCObwsQuPWXE6g=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Sep 2025 00:07:20 +0800
Message-Id: <DCW20D1KYRVK.3F0XX08AWICGT@linux.dev>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <jolsa@kernel.org>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v7 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
References: <20250910162733.82534-1-leon.hwang@linux.dev>
 <20250910162733.82534-5-leon.hwang@linux.dev>
 <CAEf4BzZJ3fEd6EaBV5M8QX=bTtL7bx0OM1E3o5HAgCemfuFQEQ@mail.gmail.com>
 <DCV6E0U82WFC.2GU139G1W4KMA@linux.dev>
 <CAEf4BzZeVcae2rcTc0o7q8xFH5-gb1hLG8RAXSgi_Cf-u--Xpg@mail.gmail.com>
In-Reply-To: <CAEf4BzZeVcae2rcTc0o7q8xFH5-gb1hLG8RAXSgi_Cf-u--Xpg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

>> >> @@ -1698,9 +1709,16 @@ __htab_map_lookup_and_delete_batch(struct bpf_=
map *map,
>> >>         int ret =3D 0;
>> >>
>> >>         elem_map_flags =3D attr->batch.elem_flags;
>> >> -       if ((elem_map_flags & ~BPF_F_LOCK) ||
>> >> -           ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field(m=
ap->record, BPF_SPIN_LOCK)))
>> >> -               return -EINVAL;
>> >> +       if (!do_delete && is_percpu) {
>> >> +               ret =3D bpf_map_check_op_flags(map, elem_map_flags, B=
PF_F_LOCK | BPF_F_CPU);
>> >> +               if (ret)
>> >> +                       return ret;
>> >> +       } else {
>> >> +               if ((elem_map_flags & ~BPF_F_LOCK) ||
>> >> +                   ((elem_map_flags & BPF_F_LOCK) &&
>> >> +                    !btf_record_has_field(map->record, BPF_SPIN_LOCK=
)))
>> >> +                       return -EINVAL;
>> >> +       }
>> >
>> > partially open-coded bpf_map_check_op_flags() if `do_delete ||
>> > !is_percpu`, right? Have you considered
>> >
>> > u32 allowed_flags =3D 0;
>> >
>> > ...
>> >
>> > allowed_flags =3D BPF_F_LOCK | BPF_F_CPU;
>> > if (do_delete || !is_percpu)
>> >     allowed_flags ~=3D BPF_F_CPU;
>> > err =3D bpf_map_check_op_flags(map, elem_map_flags, allowed_flags);
>> >
>> >
>> > This reads way more natural (in my head...), and no open-coding the
>> > helper you just so painstakingly extracted and extended to check all
>> > these conditions.
>> >
>>
>> My intention was to call bpf_map_check_op_flags() only for lookup_batch
>> on *percpu* hash maps, while excluding lookup_batch on non-percpu hash
>> maps and the lookup_and_delete_batch API.
>>
>> I don=E2=80=99t think we should be checking op flags for non-percpu hash=
 maps or
>> for lookup_and_delete_batch cases.
>
> Can you elaborate on why?
>

I=E2=80=99ve reconsidered your suggestion, and I agree.

With your approach, CPU flags and the CPU number won=E2=80=99t be checked w=
hen
'(do_delete || !is_percpu)', which makes sense.

I=E2=80=99d like to update the code as follows:

allowed_flags =3D BPF_F_LOCK;
if (!do_delete && is_percpu)
    allowed_flags |=3D BPF_F_CPU;
err =3D bpf_map_check_op_flags(map, elem_map_flags, allowed_flags);

This way, CPU flags and the CPU number are only validated for the
lookup_batch API on percpu hash maps.

Thanks,
Leon

