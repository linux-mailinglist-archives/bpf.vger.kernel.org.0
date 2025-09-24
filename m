Return-Path: <bpf+bounces-69640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE943B9CB5F
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 01:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8FF7ABD61
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C70280339;
	Wed, 24 Sep 2025 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5F3Idm2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF60611E
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757646; cv=none; b=LiWD5ID/uDwTjx4o0h5DcV2oDuz5nb4zFJJQB/tiZNA7J7o+Oqgo5jCAxBlyJ9XgXYgQB0stVbZDwozY3Pprv5W/EbPIebYCsvti/O+4cXkyCvjSkxLJOPxwn5p/c9lJar63okk1vo1Wn1BVcbEHcpC/OmhxsSZVoa3DoQFSdac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757646; c=relaxed/simple;
	bh=cfoUnd2M+2T9ElOvPsxUJZH8+vQVuyjSGb+BHYuvsBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWcqSBNNMcZ1eBEJ9ofm0ykc++HNHRv3GLOCwmODRneb5+kgBG45QPSUvysZZGIJDcGv2/LRESLAI4Yhx9wm3KssIXnAz97G7a/5ZyMLF5lTbplVtHiiYErqQ5MAXss0SICTlzD2aJi3w+/JIN/57vG2tywMDQHFn7G793TR6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5F3Idm2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-323266cdf64so391820a91.0
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 16:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758757644; x=1759362444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rIxgYFslFdTriOpon5q7I9jk53MQAFrPHSDtDrAiQQ=;
        b=e5F3Idm2xt3IlieBT4xPxUJQCXbMGM4bbrO1AuN3DigIR8UXtEH6neH2JMRp5UsQEM
         BFx8CocVucxeWD9PnWNeB83Ep3WpZ2T4hBIfaZbktKAXAtL2BD404ICO+wsWdjPXHrAS
         +tLKhzrkqgKPYM+9IB9yN+skry/q2H2UAWTO09yPWxZ9uourjnbUPbV6/wO4LIWmQjDs
         DnrAlOH0W8RGXBubzUw9Gi9/+XPQM7F1nYv06/bCGr6y0Psvbu+VkKmWWHaR1FS+Wm/r
         DZxOICo8Qn2j/k2hL5mvL3KQgUgALXagMHwuZtodzxbl9W3Nge5Xo7zrjfhNoGMIdrru
         7bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757644; x=1759362444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rIxgYFslFdTriOpon5q7I9jk53MQAFrPHSDtDrAiQQ=;
        b=ozzyDmoGahxwaOdbsoFS4B+dU0gLJZ+tOkm0wvpa9wdxLSSTQ1OQaYIN9vIjbMrd0a
         +whFsS5qL6u9lCboOcvLInijyJG3+4cw0aF3b9uLrjabzMnIS2Wxdqlpg4om9MkZDght
         qHFj6wcVNbhbppMoucdPI16I8LdcxqIjT0YsZYYoZL+pGV5wrhCRhbg5kwrqnqllBHhE
         b9cNKcQ83495iiQZn7YAInDg1Qp7N3cBWEm64ysdHOdnxqoMrJ8U3wubUEspzAP+s7p8
         ig4x+WRM2CywJ5t0QzODkZ91hkP54spJfBSuWofsniXVV//qePclAikcv+aJLO/L+ev/
         muSg==
X-Gm-Message-State: AOJu0YwwYhCDkKyou1sPxPUZoi8o5erw9NvTWO2tAVle9OZ0CeOf4wlb
	9s9RgAmD8qEiRflL9qUFJxHsWl/8IZ9euWeYUeOxZlxXakmG3/xwSR/IGZc1oJqTh2G+mMTZi9n
	GZIyEZjaNjPtIZ5pmdm/tiLhs2ec/hAc=
X-Gm-Gg: ASbGncuuWu24jh1g7HRPTJc3z+PA/rIErSf+uDNiouq3gGAX+kcpO+QfE6siIYh0QHS
	50TjGWLd9wwhxHnZ3mxKREDN3YhhI5i22C77rK6/BUQpVwEyXIbPt5GA4VnNIKdGQvfKJWVPXwz
	uZtJgSNVqEOSLIVY+ocsLInLNM0tssB74CaYfe7zVyv3Xw6oI4txvSArbOn5dmbIjcVBtQvh4Q9
	SYNFfllOg7pyc/ilM8zi8LDjNnmUcHkpA==
X-Google-Smtp-Source: AGHT+IH2puZzv8WCT8RZQnzg+yAGQBgLAPZtxf2xYI0qRwRH3ZIDoMVJWWs+JDzXzjcOYA4y5w9tP9pjnb9Wk9rOsKM=
X-Received: by 2002:a17:90b:1b4b:b0:32e:dd8c:dd18 with SMTP id
 98e67ed59e1d1-3342a2f9055mr1465378a91.17.1758757643534; Wed, 24 Sep 2025
 16:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910162733.82534-1-leon.hwang@linux.dev> <20250910162733.82534-5-leon.hwang@linux.dev>
 <CAEf4BzZJ3fEd6EaBV5M8QX=bTtL7bx0OM1E3o5HAgCemfuFQEQ@mail.gmail.com>
 <40840553-6c0a-494d-8429-863c4a6608f9@linux.dev> <CAEf4BzYTse1=pAYcM6y_vKbm74ZDtSu2Daj3sLewvKz16WF9NA@mail.gmail.com>
 <DCZEVCZLG1IW.2MPQVMF4L3D91@linux.dev> <CAEf4BzY8zPBbmjP6ooihyeqeJGdfgdh9KiW3XQGqv1qYWcefXg@mail.gmail.com>
 <1229077e-ad10-4e38-8312-936bf8bc5222@linux.dev>
In-Reply-To: <1229077e-ad10-4e38-8312-936bf8bc5222@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Sep 2025 16:47:09 -0700
X-Gm-Features: AS18NWAQ0wcOiByLx_6Irttgf6bSx1KhybEGH2UePnpZ49fpnqeuzC-EGcXNCnw
Message-ID: <CAEf4BzY8JB5n=OQUMisBRWeqTTWWnGuo8AtbxzyZdqA2D72T0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:45=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 23/9/25 00:13, Andrii Nakryiko wrote:
> > On Mon, Sep 22, 2025 at 7:50=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> On Sat Sep 20, 2025 at 6:31 AM +08, Andrii Nakryiko wrote:
> >>> On Thu, Sep 18, 2025 at 10:25=E2=80=AFPM Leon Hwang <leon.hwang@linux=
.dev> wrote:
> >>>>
> >>>>
> >>>>
> >>>>>> @@ -1724,7 +1742,7 @@ __htab_map_lookup_and_delete_batch(struct bp=
f_map *map,
> >>>>>>         value_size =3D htab->map.value_size;
> >>>>>>         size =3D round_up(value_size, 8);
> >>>>>>         if (is_percpu)
> >>>>>> -               value_size =3D size * num_possible_cpus();
> >>>>>> +               value_size =3D (elem_map_flags & BPF_F_CPU) ? size=
 : size * num_possible_cpus();
> >>>>>
> >>>>> if (is_percpu && !(elem_map_flags & BPF_F_CPU))
> >>>>>     value_size =3D size * num_possible_cpus();
> >>>>>
> >>>>> ?
> >>>>>
> >>>>
> >>>> After looking at it again, I=E2=80=99d like to keep my approach.
> >>>>
> >>>> When 'elem_map_flags & BPF_F_CPU' is set, 'value_size' has to be
> >>>> assigned to 'size' ('round_up(value_size, 8)') instead of keeping
> >>>> 'htab->map.value_size'.
> >>>>
> >>>
> >>> isn't that what will happen here as well? There is
> >>>
> >>> size =3D round_up(value_size, 8);
> >>>
> >>> right before that if
> >>>
> >>
> >> As for percpu maps, both 'size' and 'value_size' need to be 8-byte
> >> aligned here, because 'map.value_size' itself is not guarenteed to be
> >> aligned.
> >>
> >> In 'htab_map_alloc_check()', there is no alignment check for percpu
> >> maps.
> >>
> >> So 'map.value_size' can be unaligned.
> >>
> >> Let's look at how 'value_size' is used:
> >>
> >> values =3D kvmalloc_array(value_size, bucket_size, GFP_USER | __GFP_NO=
WARN);
> >> dst_val =3D values;
> >> hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
> >>         if (is_percpu) {
> >>                 if (elem_map_flags & BPF_F_CPU) {
> >>                         copy_map_value_long(&htab->map, dst_val, per_c=
pu_ptr(pptr, cpu));
> >>                 }
> >>         }
> >>         dst_val +=3D value_size;
> >> }
> >> copy_to_user(uvalues + total * value_size, values,
> >>              value_size * bucket_cnt)
> >>
> >> Here, 'value_size' determines how values are laid out and copied.
> >>
> >
> > So in my mind (and maybe it's wrong, tell me), BPF_F_CPU turns a
> > per-CPU map lookup into an effectively non-per-cpu one. So I'm not
> > sure we need to do 8 byte alignment of value/key sizes when BPF_F_CPU
> > is specified.
> >
> > But if people would like to keep 8 byte alignment anyways for
> > BPF_F_CPU, that's fine too, I guess.
> >
>
> 'value_size' should be 8-byte aligned here.
>
> For example, if 'value_size' is *1* when BPF_F_CPU is specified:
>
> values =3D kvmalloc_array();  /* 5 bytes (value_size * bucket_size) memor=
y */
> copy_map_value_long();      /* copies 8 bytes, writing past the
>                                allocated 5 bytes of memory */
>
> To stay consistent with 'copy_map_value_long()', 'value_size' itself
> needs to be 8-byte aligned.
>
> That leaves us with two options:
>
> 1. Keep 'value_size' unaligned, switch 'copy_map_value_long()' to
>    'copy_map_value()'.

Yes, this. As I said, I think BPF_F_CPU makes lookup effectively
non-per-CPU, so we should handle that consistently with no-per-CPU map
lookups.

> 2. Require 'value_size' to be 8-byte aligned.
>
> WDYT?
>
> Thanks,
> Leon

