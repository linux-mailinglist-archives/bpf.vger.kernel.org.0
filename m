Return-Path: <bpf+bounces-58741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A3AC1165
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 18:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E06A7A5A8E
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A20299A8E;
	Thu, 22 May 2025 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq3uBwrr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839528B503;
	Thu, 22 May 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932576; cv=none; b=r61k8Vu8PfiKP4IEws2FCelKGhffurruAiqITfduFNKx4T7W84z2FFHD52Q5tnPEFsd19424y/R9edFuLTGBLfI18RPiZG+jYFSpQxdLQ8L6yRyDDdHFikUjOH2P8HUHp4rGjJ0cl6mJOrvE/uXNVXbibr7H9UiRSDIYR4H5ZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932576; c=relaxed/simple;
	bh=M5FyV7l+s1kn4lezW6gAevcX06k/08kXZmL+KiT0sVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dulHXeKKs1lLpOLUfH4SoU0cOiAWyaFqif5dwg8a3j5tamWtxnneBevyde3A/jarW9A33PmTIcCrdkg1EDFRLAFncGgH8CtWCojuarPBGu6jQfYeQZ9fF5S5wKpCU2sKQ8oZ/z8gCTAZMaNVOXT37krI5R1kbW9B6B8Mrd8CPsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lq3uBwrr; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7b3410e122so7763134276.2;
        Thu, 22 May 2025 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747932574; x=1748537374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KizRQ40LYUpWNzlWIpAiXdtkcRkPrDvSwiFqCvAOjnc=;
        b=Lq3uBwrryNdYPCr3TW2AGlqczk6XyBOThxeoHpQThMbUZ8WYp+kKGzPHzuLe6cCU0+
         gph3dUUtk3tHwHL7A2TYmyfpSKeO5kSYh+/6naAoS9qeiEFWanjPh80ktBYdeAZ84WIL
         Ji7KmSc2LRR34a8Btj/gsHA3dBJzphGC5xUR877ZOInOA5gqpOehp701vn1IYO8iu07S
         6RtXua5sZlsVZ49nI6a3J8paJERLwGoOP/wR2ieWkVtN9a32UIvlZw1YMPWgAUPqUf1i
         9CZb/I475eSp8wOvvFUsQSItlZsBZHS7ihRdeQywUu81okM/rJf9J3yTKJ3zEerF0h3J
         rqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747932574; x=1748537374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KizRQ40LYUpWNzlWIpAiXdtkcRkPrDvSwiFqCvAOjnc=;
        b=l7Jvl+O9eIuIDRwU7kTB4xCJIOTIySF3d9/Z8jv9ZeeDGVVqfKI57q9Q1e2R7KMpkd
         fFxKjx4mX4YTpbq3q8/qSxKB8GAUj700Oi03e2WtgBzPMlv8pqz79qdCake4hEwxHny6
         I4+X0w+HjhJd1frAhmZ9bEL8fTcdBGFbC8wwUxYUv829TQ5Jp5l1PzxzT/AR28E5lbA7
         MzjHqE1V4u3bo/BdKyFQ7jWkVQXLEHxvvkka+K9yr22hndehaZoFYRNYogojwMVzQUvX
         IX6qrFs2+nsYTIhwXHM5ge1m1h1ei9JQbvglXEy3+fzSXEjqhx/AeOPlFtGqGmT8u2LF
         dvpg==
X-Forwarded-Encrypted: i=1; AJvYcCVPYUVHvgrUiWQATxV+sabszalvpi9XgnTU55IboMMrDEvdOoOAmED/TgQCAOC81z25ygblNu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBMIoiH+KmoKIQItMqNeW4oqRFPaif2qTahjnqUx1JL7JzPQ2V
	6JQzccTQXQK7Za+4bMGD4WD276mzhCcvFX93FasLCFlktK4QvxsXEYd2BlJrvmH5K7idXPH7VOA
	js/Xg1KU50KDrA3JXnb5HsnOixjmEUN9o0FN9hJU=
X-Gm-Gg: ASbGncugz0VM2nXaF+JHTBnQ1eJdRYSmzlJaSCEZzj0UnJsJbuIHRVQNQBo9oVlFopt
	M8IFccn1/wYOd5JcLLIlpxnDeMLbp5VVGmvXN3+S9vwwgucuB9U5WMqzd4Ty38w/DI1AyXtCuPr
	i52cFlrGAc5Be6jDOcR3TpKziKM/2kW9sAtOpSAyE/eiSBLqk=
X-Google-Smtp-Source: AGHT+IGhOP+GsCTfypQm5gGwj9NCcUvv6OG+PBaB3UN3B6ANsZJFNjVHxTRyISXShQBWoptKffotcVK2wIobhLb6jk0=
X-Received: by 2002:a05:6902:488a:b0:e79:e65:9169 with SMTP id
 3f1490d57ef6-e7b6a08c1aamr35046500276.20.1747932574093; Thu, 22 May 2025
 09:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515211606.2697271-1-ameryhung@gmail.com> <20250515211606.2697271-2-ameryhung@gmail.com>
 <aC7iCGNsG7YuF297@kodidev-ubuntu>
In-Reply-To: <aC7iCGNsG7YuF297@kodidev-ubuntu>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 22 May 2025 09:49:23 -0700
X-Gm-Features: AX0GCFvE5gQbD7-hibula4lrWJ8LI6VN5nxVDIWZlqU-O12Zs_52j2Pu_pxOjAU
Message-ID: <CAMB2axO1K3-=oAxfOd4bBopiC6NR_BFf28_jx1y=d9bpenAAgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce task local data
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 1:36=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> Hi Amery,
>
> I'm trying out your series in an arm32 JIT testing env I'm working on.
>
>
> On Thu, May 15, 2025 at 02:16:00PM -0700, Amery Hung wrote:
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/=
tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> > new file mode 100644
> > index 000000000000..5f48e408a5e5
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> > @@ -0,0 +1,220 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __TASK_LOCAL_DATA_BPF_H
> > +#define __TASK_LOCAL_DATA_BPF_H
> > +
> > +/*
> > + * Task local data is a library that facilitates sharing per-task data
> > + * between user space and bpf programs.
> > + *
> > + *
> > + * PREREQUISITE
> > + *
> > + * A TLD, an entry of data in task local data, first needs to be creat=
ed by the
> > + * user space. This is done by calling user space API, tld_create_key(=
), with
> > + * the name of the TLD and the size.
> > + *
> > + *     tld_key_t prio, in_cs;
> > + *
> > + *     prio =3D tld_create_key("priority", sizeof(int));
> > + *     in_cs =3D tld_create_key("in_critical_section", sizeof(bool));
> > + *
> > + * A key associated with the TLD, which has an opaque type tld_key_t, =
will be
> > + * returned. It can be used to get a pointer to the TLD in the user sp=
ace by
> > + * calling tld_get_data().
> > + *
> > + *
> > + * USAGE
> > + *
> > + * Similar to user space, bpf programs locate a TLD using the same key=
.
> > + * tld_fetch_key() allows bpf programs to retrieve a key created in th=
e user
> > + * space by name, which is specified in the second argument of tld_cre=
ate_key().
> > + * tld_fetch_key() additionally will cache the key in a task local sto=
rage map,
> > + * tld_key_map, to avoid performing costly string comparisons every ti=
me when
> > + * accessing a TLD. This requires the developer to define the map valu=
e type of
> > + * tld_key_map, struct tld_keys. It only needs to contain keys used by=
 bpf
> > + * programs in the compilation unit.
> > + *
> > + * struct tld_keys {
> > + *     tld_key_t prio;
> > + *     tld_key_t in_cs;
> > + * };
> > + *
> > + * Then, for every new task, a bpf program will fetch and cache keys o=
nce and
> > + * for all. This should be done ideally in a non-critical path (e.g., =
in
> > + * sched_ext_ops::init_task).
> > + *
> > + *     struct tld_object tld_obj;
> > + *
> > + *     err =3D tld_object_init(task, &tld);
> > + *     if (err)
> > + *         return 0;
> > + *
> > + *     tld_fetch_key(&tld_obj, "priority", prio);
> > + *     tld_fetch_key(&tld_obj, "in_critical_section", in_cs);
> > + *
> > + * Note that, the first argument of tld_fetch_key() is a pointer to tl=
d_object.
> > + * It should be declared as a stack variable and initialized via tld_o=
bject_init().
> > + *
> > + * Finally, just like user space programs, bpf programs can get a poin=
ter to a
> > + * TLD by calling tld_get_data(), with cached keys.
> > + *
> > + *     int *p;
> > + *
> > + *     p =3D tld_get_data(&tld_obj, prio, sizeof(int));
> > + *     if (p)
> > + *         // do something depending on *p
> > + */
> > +#include <errno.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +#define TLD_DATA_SIZE __PAGE_SIZE
> > +#define TLD_DATA_CNT 63
> > +#define TLD_NAME_LEN 62
> > +
> > +typedef struct {
> > +     __s16 off;
> > +} tld_key_t;
> > +
> > +struct u_tld_data *dummy_data;
> > +struct u_tld_metadata *dummy_metadata;
>
> I suspect I've overlooked something, but what are these 2 "dummy" globals
> used for? The code builds OK without them, although I do see test errors
> as noted below.
>

Hi, sorry for the confusion. The forward declaration is to prevent
dummy_data/metadata tld_map_value to be fwd_kind. I will explain this
in the comment.

The BTF should look like this:

[9] STRUCT 'tld_map_value' size=3D16 vlen=3D2
        'data' type_id=3D10 bits_offset=3D0
        'metadata' type_id=3D11 bits_offset=3D64
[10] PTR '(anon)' type_id=3D74
[11] PTR '(anon)' type_id=3D73
[57] STRUCT 'u_tld_data' size=3D4096 vlen=3D1
        'data' type_id=3D58 bits_offset=3D0
[61] STRUCT 'u_tld_metadata' size=3D4096 vlen=3D3
        'cnt' type_id=3D62 bits_offset=3D0
        'padding' type_id=3D64 bits_offset=3D8
        'metadata' type_id=3D67 bits_offset=3D512
[73] TYPE_TAG 'uptr' type_id=3D61
[74] TYPE_TAG 'uptr' type_id=3D57

Without the forward declaration, the BTF will look like this:

[9] STRUCT 'tld_map_value' size=3D16 vlen=3D2
        'data' type_id=3D10 bits_offset=3D0
        'metadata' type_id=3D11 bits_offset=3D64
[10] PTR '(anon)' type_id=3D63
[11] PTR '(anon)' type_id=3D61
[60] FWD 'u_tld_metadata' fwd_kind=3Dstruct
[61] TYPE_TAG 'uptr' type_id=3D60
[62] FWD 'u_tld_data' fwd_kind=3Dstruct
[63] TYPE_TAG 'uptr' type_id=3D62

> I'll also mention the only reason I noticed these is that "bpftool gen
> skeleton" automatically maps these to user space, but results in an
> ASSERT() failure during build on 32-bit targets due to lack of support,
> so dropping them avoids that.

Can you provide more details of the error?

>
>
> 24: (85) call pc+25
> caller:
>  R6_w=3Dmap_value(map=3Dtld_key_map,ks=3D4,vs=3D6) R7=3D1 R10=3Dfp0 fp-8_=
w=3Dmap_value(map=3Dtld_key_map,ks=3D4,vs=3D6) fp-16=3Dmap_value(map=3Dtld_=
data_map,ks=3D4,vs=3D16)
> callee:
>  frame1: R1_w=3Dfp[0]-16 R2_w=3Dmap_value(map=3D.rodata.str1.1,ks=3D4,vs=
=3D30) R10=3Dfp0
> 50: frame1: R1_w=3Dfp[0]-16 R2_w=3Dmap_value(map=3D.rodata.str1.1,ks=3D4,=
vs=3D30) R10=3Dfp0
> ; static u16 __tld_fetch_key(struct tld_object *tld_obj, const char *name=
) @ task_local_data.bpf.h:163
> 50: (7b) *(u64 *)(r10 -16) =3D r2       ; frame1: R2_w=3Dmap_value(map=3D=
.rodata.str1.1,ks=3D4,vs=3D30) R10=3Dfp0 fp-16_w=3Dmap_value(map=3D.rodata.=
str1.1,ks=3D4,vs=3D30)
> 51: (b4) w7 =3D 0                       ; frame1: R7_w=3D0
> ; if (!tld_obj->data_map || !tld_obj->data_map->metadata) @ task_local_da=
ta.bpf.h:169
> 52: (79) r1 =3D *(u64 *)(r1 +0)         ; frame1: R1=3Dmap_value(map=3Dtl=
d_data_map,ks=3D4,vs=3D16) fp-16=3Dmap_value(map=3D.rodata.str1.1,ks=3D4,vs=
=3D30)
> 53: (15) if r1 =3D=3D 0x0 goto pc+36      ; frame1: R1=3Dmap_value(map=3D=
tld_data_map,ks=3D4,vs=3D16)
> 54: (79) r6 =3D *(u64 *)(r1 +8)         ; frame1: R1=3Dmap_value(map=3Dtl=
d_data_map,ks=3D4,vs=3D16) R6_w=3Dscalar()
> 55: (15) if r6 =3D=3D 0x0 goto pc+34      ; frame1: R6_w=3Dscalar(umin=3D=
1)
> ; cnt =3D tld_obj->data_map->metadata->cnt; @ task_local_data.bpf.h:172
> 56: (71) r8 =3D *(u8 *)(r6 +0)
> R6 invalid mem access 'scalar'
> processed 29 insns (limit 1000000) max_states_per_insn 0 total_states 3 p=
eak_states 3 mark_read 1
> -- END PROG LOAD LOG --
> libbpf: prog 'task_init': failed to load: -EACCES
> libbpf: failed to load object 'test_task_local_data'
> libbpf: failed to load BPF skeleton 'test_task_local_data': -EACCES
> test_task_local_data_basic:FAIL:skel_open_and_load unexpected error: -13
> #409/1   task_local_data/task_local_data_basic:FAIL
>
>
> I'm unsure if this verifier error is related to the dummy pointers, but
> it does seem there's a pointer issue...
>

The error is exactly caused by removing the dummy_xxx.

> Further thoughts or suggestions (from anyone) would be most welcome.
>
> Thanks,
> Tony
>
> > +
> > +struct tld_metadata {
> > +     char name[TLD_NAME_LEN];
> > +     __u16 size;
> > +};
> > +
> > +struct u_tld_metadata {
> > +     __u8 cnt;
> > +     __u8 padding[63];
> > +     struct tld_metadata metadata[TLD_DATA_CNT];
> > +};
> > +
> > +struct u_tld_data {
> > +     char data[TLD_DATA_SIZE];
> > +};
> > +
> > +struct tld_map_value {
> > +     struct u_tld_data __uptr *data;
> > +     struct u_tld_metadata __uptr *metadata;
> > +};
> > +
> > +struct tld_object {
> > +     struct tld_map_value *data_map;
> > +     struct tld_keys *key_map;
> > +};
> > +
>
> [...]

