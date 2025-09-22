Return-Path: <bpf+bounces-69223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE97B91CBF
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB5C2A2A1E
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09823280CFA;
	Mon, 22 Sep 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L4KCWzk3"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC6191F66
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552618; cv=none; b=umWMUpi8Z+GZUWmzworlmm1CjRiMg75K4XF16AKOda+SHE+OLvyzEsymnVg6rEZkgFXHyZgfXPNbqJ9vTRThi3B98IFfu1f7e7H+ST2LxMvHD7LbSPJQpJ+1w85SsbaTnwvJ3iQelP/055QJR0l83MNMuY2sckp82J20B8jfrQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552618; c=relaxed/simple;
	bh=hJx/5qfIKrlKct7U1J2LJb6gd3tK/RpMxw+jcI6ZdoI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Stkp34WyOmHPPhIXrVzGxeiEP6TxzIqBoH/QLBHa5rXzRnZxWTYv1MriNVMQq2hghBXDPwAySXIQ08YAfyfoKlhyC/BdNnfI6/VEySTuf+j0WpgJIAoJYob8ZvuqIrcjZ09fHk/gczzki3q0qhKjEHe2mkaZkCXPh1CXYpuVukA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L4KCWzk3; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758552612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2mHY0QNh7qt/9ATNJlaLdWB6mWfrYXbbHXfCv+pNiQ=;
	b=L4KCWzk3A0YnH6XsfuNNK9cG3Yse6O44oEMEG9M/toS4wf9tTQYbtfb5jwiqPyB7HNrprC
	gI4HYShJbCZB4EVUKfqCEjbxxD+PzTC7HCfyQyYZ/soNewkwzpnel26MSudmlVyvWYuQ/B
	3AkhZqqNco4C4Lj03lTeBmDoMIFOXNc=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Sep 2025 22:50:02 +0800
Message-Id: <DCZEVCZLG1IW.2MPQVMF4L3D91@linux.dev>
Subject: Re: [PATCH bpf-next v7 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <jolsa@kernel.org>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
References: <20250910162733.82534-1-leon.hwang@linux.dev>
 <20250910162733.82534-5-leon.hwang@linux.dev>
 <CAEf4BzZJ3fEd6EaBV5M8QX=bTtL7bx0OM1E3o5HAgCemfuFQEQ@mail.gmail.com>
 <40840553-6c0a-494d-8429-863c4a6608f9@linux.dev>
 <CAEf4BzYTse1=pAYcM6y_vKbm74ZDtSu2Daj3sLewvKz16WF9NA@mail.gmail.com>
In-Reply-To: <CAEf4BzYTse1=pAYcM6y_vKbm74ZDtSu2Daj3sLewvKz16WF9NA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat Sep 20, 2025 at 6:31 AM +08, Andrii Nakryiko wrote:
> On Thu, Sep 18, 2025 at 10:25=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev=
> wrote:
>>
>>
>>
>> >> @@ -1724,7 +1742,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_m=
ap *map,
>> >>         value_size =3D htab->map.value_size;
>> >>         size =3D round_up(value_size, 8);
>> >>         if (is_percpu)
>> >> -               value_size =3D size * num_possible_cpus();
>> >> +               value_size =3D (elem_map_flags & BPF_F_CPU) ? size : =
size * num_possible_cpus();
>> >
>> > if (is_percpu && !(elem_map_flags & BPF_F_CPU))
>> >     value_size =3D size * num_possible_cpus();
>> >
>> > ?
>> >
>>
>> After looking at it again, I=E2=80=99d like to keep my approach.
>>
>> When 'elem_map_flags & BPF_F_CPU' is set, 'value_size' has to be
>> assigned to 'size' ('round_up(value_size, 8)') instead of keeping
>> 'htab->map.value_size'.
>>
>
> isn't that what will happen here as well? There is
>
> size =3D round_up(value_size, 8);
>
> right before that if
>

As for percpu maps, both 'size' and 'value_size' need to be 8-byte
aligned here, because 'map.value_size' itself is not guarenteed to be
aligned.

In 'htab_map_alloc_check()', there is no alignment check for percpu
maps.

So 'map.value_size' can be unaligned.

Let's look at how 'value_size' is used:

values =3D kvmalloc_array(value_size, bucket_size, GFP_USER | __GFP_NOWARN)=
;
dst_val =3D values;
hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
        if (is_percpu) {
                if (elem_map_flags & BPF_F_CPU) {
                        copy_map_value_long(&htab->map, dst_val, per_cpu_pt=
r(pptr, cpu));
                }
        }
        dst_val +=3D value_size;
}
copy_to_user(uvalues + total * value_size, values,
             value_size * bucket_cnt)

Here, 'value_size' determines how values are laid out and copied.

As a result, when 'is_percpu && (elem_map_flags & BPF_F_CPU)',
'value_size' must be assigned to 'size' in order to make sure it's
8-byte aligned.

Thanks,
Leon

