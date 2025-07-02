Return-Path: <bpf+bounces-62165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04951AF5FB6
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67E54A3547
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1CC30112D;
	Wed,  2 Jul 2025 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlhiVUxv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB62FF493
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476453; cv=none; b=uDKOuHo2OP0HD7dPup9MLrLzfvYRl7T0WkEy4IqshvJ+e7TIJ/l3xBeGtmbp31c8PtsKTfgHy7fCNrFm2okzSlAGUhjDgQnqt/dE6FQQWC+8No4YLWLH2S4S2jms4jYqpz5cKl+dQhQNPUq8QDGUiC6mtqGJUAFjAi8f286Ya2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476453; c=relaxed/simple;
	bh=hT+kPis33wvPmy9SyPMkMap6EYjJAi/8HfhGdtor1OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkSN3DzD37obWaBXyDusZdrWAwHC+me4z4mCojE8eFCSbS2UGed3/IcPTa2TqV2BCC/eUZBIghimjk3LqFJcmCZOykLAEGTUZUf7TPpsZfMItXZt+tPyFg7pYdHcoXIksxWfE2y9G9go/u1NWaL+3Jj+BubDH6bFPRu0xfxdoj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlhiVUxv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so4999672a91.2
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476451; x=1752081251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wpQVuu0xNQK93kFomEeBEfgxzxf1xCzqsqzWnDyITI=;
        b=JlhiVUxvBLKvDl3munJK2bNFG6lI0nLJ2N5rpPv8nQYUw4janeJin6V8w/9tIzO3Yh
         64vb6sVvu5TrURIBW4w6eOK/Iinrwoiyu04/DBzbnN4xf+qsQLfWLXt50Q5FI/NF+7n1
         lAK9o257O9Qg6NrwrKK/3r3+OA8cUe5Yy7ZGfKS66RbMbGx4SairOkXKv8wetswU5kKm
         vVIID7mgMWr2NW76wv6uBZJx0Uvt9ci4gzveqKi40IIWCy90AhAdrjbs9WaqwomYkeCU
         X3vAydh25p13QycVx1B3yOzTxFh283WCGVzFN+roKjrLaSXHYMhJdx6fCGkebzRnSBtV
         cBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476451; x=1752081251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wpQVuu0xNQK93kFomEeBEfgxzxf1xCzqsqzWnDyITI=;
        b=sYIKQ3az+QqEA6CzojJqYgSHPBeHU4v049i47kiIDyoAVY/mwjFvd+ibiKO2onNeR/
         HGyakYxL9gZvKOfNbOk/xeZS5nNxNVUV+QLlaR5dQ3jIgYjdaREQxG3TchRuYkLF3C7v
         ohjIHtSIXlr7gPuA0MaeRRnDNBKW4S8rYugM0IM59jlZV91ABNPb0A3S1Ua3ocEwiFRh
         luJxr6rfiS6PEWqKIkCFMxgOMr/zTTx6IHjwjfe2TLUJMIe+Csk1C73h704HjEOuduFc
         4EzT3zYC6f5SOd5IbVHjo1LZ2owf159rBsPmLiaR3dXNy8bJafMr9llLS5KKlIYaBmZo
         A2KA==
X-Gm-Message-State: AOJu0Ywf5hzEWQqVWgUB9UzIOKADyqZ5x0MR3MklXcOTNVrCKysHvA1Z
	0Do5+RIugYDLYWCcqP1lXFVmd6ONTSmgZgSMWBojY8QDQGB4r7spydYza4UC8jdQy78Eko1IKEP
	LJfkV9BsDEQlz4FfOdGzXMPeBz7tKCNM=
X-Gm-Gg: ASbGncswdaKJTUaCXSlRRtQOZFQVN8LJSADG3AfTGfBgDQLOvkBiF19qjsRAh6k1/fT
	yxG+j+XypVr8SK5rBYi8RQDjcC1NZHFL7n1PBA2YbvFqx9YKaqwmbwVYm/4pTB60MDEcHGfTHRa
	nvG5EysP+vqworSONUFTNIjo7F2Wp499/MXkZpkY8BoSMfG07XrZnpBwB2DJk=
X-Google-Smtp-Source: AGHT+IGw5Yb67wcBtQkcBN/SQMrILSwoNL9/HMzxHY4cUrCcJyoGcGxRsHfBz9B4V+gfiuy+f6xmKL16rb2ltTsYZLw=
X-Received: by 2002:a17:90b:4cc3:b0:311:f684:d3cd with SMTP id
 98e67ed59e1d1-31a90b3aafdmr6672999a91.12.1751476450840; Wed, 02 Jul 2025
 10:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624165354.27184-1-leon.hwang@linux.dev> <20250624165354.27184-2-leon.hwang@linux.dev>
 <CAEf4BzYFjKEdpf9xHfeW8hs+zzmppvw2-RzJELrRc=QfKfga1A@mail.gmail.com> <4a808630-176b-424c-a5e3-24db1b70f5c2@linux.dev>
In-Reply-To: <4a808630-176b-424c-a5e3-24db1b70f5c2@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Jul 2025 10:13:58 -0700
X-Gm-Features: Ac12FXxGaLGWpdi-5BT98zV4uAfqSAVaoyBxbrfgX_W7rbS6n2eBu9nouF-De48
Message-ID: <CAEf4Bza0kx2Ak34VGcHYFDaqjxTX53_auvps=9Gm88eLB3r7yw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array map
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 10:02=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2025/7/2 04:22, Andrii Nakryiko wrote:
> > On Tue, Jun 24, 2025 at 9:54=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> This patch introduces support for the BPF_F_CPU flag in percpu_array m=
aps
> >> to allow updating or looking up values for specific CPUs or for all CP=
Us
> >> with a single value.
> >>
> >> This enhancement enables:
> >>
> >> * Efficient update of all CPUs using a single value when cpu =3D=3D 0x=
FFFFFFFF.
> >> * Targeted update or lookup for a specific CPU otherwise.
> >>
> >> The flag is passed via:
> >>
> >> * map_flags in bpf_percpu_array_update() along with the cpu field.
> >> * elem_flags in generic_map_update_batch() along with the cpu field.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  include/linux/bpf.h            |  5 +--
> >>  include/uapi/linux/bpf.h       |  6 ++++
> >>  kernel/bpf/arraymap.c          | 46 ++++++++++++++++++++++++----
> >>  kernel/bpf/syscall.c           | 56 ++++++++++++++++++++++-----------=
-
> >>  tools/include/uapi/linux/bpf.h |  6 ++++
> >>  5 files changed, 92 insertions(+), 27 deletions(-)
> >>
> >
> > [...]
> >
> >> #define BPF_ALL_CPU    0xFFFFFFFF
> >
> > at the very least we have to make it an enum, IMO. but I'm in general
> > unsure if we need it at all... and in any case, should it be named
> > "BPF_ALL_CPUS" (plural)?
> >
>
> To avoid using such special value, would it be better to update value
> across all CPUs when the cpu equals to num_possible_cpus()?

no, I'd keep special pattern (it's unnecessary complication to figure
out num_possible_cpus value), it's just the question whether to add an
enum for it in the UAPI or just document (u32)~0 as special case


[...]

> > [...]
> >
> >> @@ -1941,19 +1941,27 @@ int generic_map_update_batch(struct bpf_map *m=
ap, struct file *map_file,
> >>  {
> >>         void __user *values =3D u64_to_user_ptr(attr->batch.values);
> >>         void __user *keys =3D u64_to_user_ptr(attr->batch.keys);
> >> +       u64 elem_flags =3D attr->batch.elem_flags;
> >>         u32 value_size, cp, max_count;
> >>         void *key, *value;
> >>         int err =3D 0;
> >>
> >> -       if (attr->batch.elem_flags & ~BPF_F_LOCK)
> >> +       if (elem_flags & ~(BPF_F_LOCK | BPF_F_CPU))
> >>                 return -EINVAL;
> >>
> >> -       if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> >> +       if ((elem_flags & BPF_F_LOCK) &&
> >>             !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
> >>                 return -EINVAL;
> >>         }
> >>
> >> -       value_size =3D bpf_map_value_size(map);
> >> +       if (elem_flags & BPF_F_CPU) {
> >> +               if (map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> >> +                       return -EINVAL;
> >> +
> >> +               value_size =3D round_up(map->value_size, 8);
> >> +       } else {
> >> +               value_size =3D bpf_map_value_size(map);
> >> +       }
> >
> > why not roll this into bpf_map_value_size() helper? it's internal,
> > should be fine
> >
>
> It's to avoid updating value_size by pointer like
>
> err =3D bpf_map_value_size(map, elem_flags, &value_size);
>
> However, it's OK for me to do so.

if you need to communicate error, then return negative value_size? but
alternatively just do error checking before bpf_map_value_size

[...]

