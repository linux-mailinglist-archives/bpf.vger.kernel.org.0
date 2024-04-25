Return-Path: <bpf+bounces-27771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110E48B182B
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 02:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5691B241EE
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3750BB65E;
	Thu, 25 Apr 2024 00:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj+Ep7Jo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492DDAD31
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 00:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714006102; cv=none; b=JVjQewzipYY8JUtgNk2lW6X1+AHUHVGNDHQLTRfWjOfBy5elg1SWHBL3SzoecgQ2TygBJUlDfUK1NzrbiDUcG1b0tK2raaBaY8JDdls6HiPEJyJS3rztujrY+SADK/2nZRWg8KSIxNR+VqC70kFrbQnn0nALiO1XL2mrjYDHSYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714006102; c=relaxed/simple;
	bh=j3c3ZAUSkDHmTO5lKp7eYf6SRxdBmCbYojs1w5ckVu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8TpGaajbH1qge1uuzjzQnOQY5skzHv+mVyloO8tEbwbAKZN0gCL0JMwi/vrTsk4D8qsATyQUvatTO9uF/8QGF5hsSbLz8TNI4y1rtmjkrcfPvyt98s0oYf4NzVOEbAScyXgoACuxA8gg40wfZJKaSveNKdBqXYvY1rsdB6b+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oj+Ep7Jo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e2c725e234so12564485ad.1
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 17:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714006100; x=1714610900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iTHt0zY+TmDiQzm6rQLk5/qQvAGSRjxvgUf4W59wK0=;
        b=Oj+Ep7JoOjQ0e2MgboNqIdWVkGuYJUB5kxWOvF2rGhQCLM12u444/GcPM2QyT3pDU/
         R80k7QONl0/jasbIJmgL4Mzk9tTPtWqJ8U17luZ27D5y7WtEK9ifZkHqcgiGxgCxFYXY
         P9qebvaPPZMrkGJ6VBBDAqsGCExe6Y2x0gpnW9sF/aNbbmebYdZ1vjeAp+kVfgJodSge
         bxgx8ZOdXGJ/RYYlyuFXESxSa3tSzRaw7zrgKzLmagFQ/3c1dqt4V5O9tw5z6ezDGP6F
         PWOhNphD+1aJc2W7vkpQQLNxAxJuWB6Nqs5j7VogfEROdpGqhO4XIyFNLltyHotcww5o
         cEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714006100; x=1714610900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iTHt0zY+TmDiQzm6rQLk5/qQvAGSRjxvgUf4W59wK0=;
        b=VFgjCOy7Typ3QXqL8JzOz2ZKTCGwMHcT0fCzWhNNVAOpm2u8IWFIBBMj0MoNDZ/MPG
         PU5zfjV3YgsWyBr1W2jujYXXeUkRkfjkkXd8v7ey7h6gFJR0qIxbv24RnZEod4RIKDJy
         V73XUv9ckitXZ/45/PE28rTqiS8A/I3qmY/Jb6jYwb59+oGAneDO3wD8s8/6xsELlhLa
         gEfI3+dRIxeEAG7tPG42x+P0kCOT8jSV4zpaT/cW88F8VpGVFJECtiPlIKngsKsbnIxp
         tdWVpk9z/X4d1TfnO8HVO9Cx4K9O/ihAbJw98/0z5W9dRvsQW7+1UWDoq65xVRUDUj+8
         HXvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqdiaQJZFJMniVFfrQoGKsRayyaZMliCanRaNlHrHJ2K9ndSFrv63JpB2UXcCFKNwlBFYSLDuGRSE5IawWJN8WF8Ji
X-Gm-Message-State: AOJu0YxoiIAHvbARpt0sNfs1Ykk6kC2dhXX38P1bUhLrC5POE7NelDOi
	bDTjRYSPixqNvRuXUM+onnwBADHsuspcbaMau9c4Zm9mmcoXWWCbMExV7SnJkoGfXyBNZIxN0B1
	B+1bGQL9ci6g+4gol9lFmBLQUbbk=
X-Google-Smtp-Source: AGHT+IHpjyJ1n1a+ihgUk9MJ0qsf3egPCxaiY4Ccr2EYwZKjxpAlW+OxKL15mcCi6Kosev6zTKlme4X0kwQT64OQmMc=
X-Received: by 2002:a17:90b:4017:b0:2a4:79ef:4973 with SMTP id
 ie23-20020a17090b401700b002a479ef4973mr1873584pjb.14.1714006100456; Wed, 24
 Apr 2024 17:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412210814.603377-1-thinker.li@gmail.com> <CAADnVQKP4HESABxxjKXqkyAEC4i_yP7_CT+L=+vzOhnMr5LiXg@mail.gmail.com>
 <1ce45df0-4471-4c0c-b37e-3e51b77fa5b5@gmail.com> <CAADnVQKjGFdiy4nYTsbfH5rm7T9gt_VhHd3R+0s4yS9eqTtSaA@mail.gmail.com>
 <6d25660d-103a-4541-977f-525bd2d38cd0@gmail.com> <CAADnVQ+hGv0oVx4_uPs2yr=vWC80OEEXLm_FcZLBfsthu0yFbA@mail.gmail.com>
 <57b4d1ca-a444-4e28-9c22-9b81c352b4cb@gmail.com> <90652139-f541-4a99-837e-e5857c901f61@gmail.com>
 <CAADnVQJFtRwwGm=zEa=CgskY57gXPsG240FA66xZFBONqPTYTg@mail.gmail.com>
In-Reply-To: <CAADnVQJFtRwwGm=zEa=CgskY57gXPsG240FA66xZFBONqPTYTg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Apr 2024 17:48:08 -0700
Message-ID: <CAEf4BzatWpnT6PM=7dz1S=G_kz1NP5S4nwD=Ka8aBXekBb-Beg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays
 of kptr, bpf_rb_root, and bpf_list_head.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 1:09=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 22, 2024 at 7:54=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com=
> wrote:
> >
> >
> >
> > On 4/22/24 19:45, Kui-Feng Lee wrote:
> > >
> > >
> > > On 4/18/24 07:53, Alexei Starovoitov wrote:
> > >> On Wed, Apr 17, 2024 at 11:07=E2=80=AFPM Kui-Feng Lee <sinquersw@gma=
il.com>
> > >> wrote:
> > >>>
> > >>>
> > >>>
> > >>> On 4/17/24 22:11, Alexei Starovoitov wrote:
> > >>>> On Wed, Apr 17, 2024 at 9:31=E2=80=AFPM Kui-Feng Lee <sinquersw@gm=
ail.com>
> > >>>> wrote:
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>> On 4/17/24 20:30, Alexei Starovoitov wrote:
> > >>>>>> On Fri, Apr 12, 2024 at 2:08=E2=80=AFPM Kui-Feng Lee
> > >>>>>> <thinker.li@gmail.com> wrote:
> > >>>>>>>
> > >>>>>>> The arrays of kptr, bpf_rb_root, and bpf_list_head didn't work =
as
> > >>>>>>> global variables. This was due to these types being initialized=
 and
> > >>>>>>> verified in a special manner in the kernel. This patchset allow=
s BPF
> > >>>>>>> programs to declare arrays of kptr, bpf_rb_root, and
> > >>>>>>> bpf_list_head in
> > >>>>>>> the global namespace.
> > >>>>>>>
> > >>>>>>> The main change is to add "nelems" to btf_fields. The value of
> > >>>>>>> "nelems" represents the number of elements in the array if a
> > >>>>>>> btf_field
> > >>>>>>> represents an array. Otherwise, "nelem" will be 1. The verifier
> > >>>>>>> verifies these types based on the information provided by the
> > >>>>>>> btf_field.
> > >>>>>>>
> > >>>>>>> The value of "size" will be the size of the entire array if a
> > >>>>>>> btf_field represents an array. Dividing "size" by "nelems" give=
s the
> > >>>>>>> size of an element. The value of "offset" will be the offset of=
 the
> > >>>>>>> beginning for an array. By putting this together, we can
> > >>>>>>> determine the
> > >>>>>>> offset of each element in an array. For example,
> > >>>>>>>
> > >>>>>>>        struct bpf_cpumask __kptr * global_mask_array[2];
> > >>>>>>
> > >>>>>> Looks like this patch set enables arrays only.
> > >>>>>> Meaning the following is supported already:
> > >>>>>>
> > >>>>>> +private(C) struct bpf_spin_lock glock_c;
> > >>>>>> +private(C) struct bpf_list_head ghead_array1 __contains(foo, no=
de2);
> > >>>>>> +private(C) struct bpf_list_head ghead_array2 __contains(foo, no=
de2);
> > >>>>>>
> > >>>>>> while this support is added:
> > >>>>>>
> > >>>>>> +private(C) struct bpf_spin_lock glock_c;
> > >>>>>> +private(C) struct bpf_list_head ghead_array1[3] __contains(foo,
> > >>>>>> node2);
> > >>>>>> +private(C) struct bpf_list_head ghead_array2[2] __contains(foo,
> > >>>>>> node2);
> > >>>>>>
> > >>>>>> Am I right?
> > >>>>>>
> > >>>>>> What about the case when bpf_list_head is wrapped in a struct?
> > >>>>>> private(C) struct foo {
> > >>>>>>      struct bpf_list_head ghead;
> > >>>>>> } ghead;
> > >>>>>>
> > >>>>>> that's not enabled in this patch. I think.
> > >>>>>>
> > >>>>>> And the following:
> > >>>>>> private(C) struct foo {
> > >>>>>>      struct bpf_list_head ghead;
> > >>>>>> } ghead[2];
> > >>>>>>
> > >>>>>>
> > >>>>>> or
> > >>>>>>
> > >>>>>> private(C) struct foo {
> > >>>>>>      struct bpf_list_head ghead[2];
> > >>>>>> } ghead;
> > >>>>>>
> > >>>>>> Won't work either.
> > >>>>>
> > >>>>> No, they don't work.
> > >>>>> We had a discussion about this in the other day.
> > >>>>> I proposed to have another patch set to work on struct types.
> > >>>>> Do you prefer to handle it in this patch set?
> > >>>>>
> > >>>>>>
> > >>>>>> I think eventually we want to support all such combinations and
> > >>>>>> the approach proposed in this patch with 'nelems'
> > >>>>>> won't work for wrapper structs.
> > >>>>>>
> > >>>>>> I think it's better to unroll/flatten all structs and arrays
> > >>>>>> and represent them as individual elements in the flattened
> > >>>>>> structure. Then there will be no need to special case array with
> > >>>>>> 'nelems'.
> > >>>>>> All special BTF types will be individual elements with unique of=
fset.
> > >>>>>>
> > >>>>>> Does this make sense?
> > >>>>>
> > >>>>> That means it will creates 10 btf_field(s) for an array having 10
> > >>>>> elements. The purpose of adding "nelems" is to avoid the
> > >>>>> repetition. Do
> > >>>>> you prefer to expand them?
> > >>>>
> > >>>> It's not just expansion, but a common way to handle nested structs=
 too.
> > >>>>
> > >>>> I suspect by delaying nested into another patchset this approach
> > >>>> will become useless.
> > >>>>
> > >>>> So try adding nested structs in all combinations as a follow up an=
d
> > >>>> I suspect you're realize that "nelems" approach doesn't really hel=
p.
> > >>>> You'd need to flatten them all.
> > >>>> And once you do there is no need for "nelems".
> > >>>
> > >>> For me, "nelems" is more like a choice of avoiding repetition of
> > >>> information, not a necessary. Before adding "nelems", I had conside=
red
> > >>> to expand them as well. But, eventually, I chose to add "nelems".
> > >>>
> > >>> Since you think this repetition is not a problem, I will expand arr=
ay as
> > >>> individual elements.
> > >>
> > >> You don't sound convinced :)
> > >> Please add support for nested structs on top of your "nelems" approa=
ch
> > >> and prototype the same without "nelems" and let's compare the two.
> > >
> > >
> > > The following is the prototype that flatten arrays and struct types.
> > > This approach is definitely simpler than "nelems" one.  However,
> > > it will repeat same information as many times as the size of an array=
.
> > > For now, we have a limitation on the number of btf_fields (<=3D 10).
>
> I understand the concern and desire to minimize duplication,
> but I don't see how this BPF_REPEAT_FIELDS approach is going to work.
> From btf_parse_fields() pov it becomes one giant opaque field
> that sort_r() processes as a blob.
>
> How
> btf_record_find(reg->map_ptr->record,
>                 off + reg->var_off.value, BPF_KPTR);
>
> is going to find anything in there?
> Are you making a restriction that arrays and nested structs
> will only have kptrs in there ?
> So BPF_REPEAT_FIELDS can only wrap kptrs ?
> But even then these kptrs might have different btf_ids.
> So
> struct map_value {
>    struct {
>       struct task __kptr *p1;
>       struct thread __kptr *p2;
>    } arr[10];
> };
>
> won't be able to be represented as BPF_REPEAT_FIELDS?
>
> I think that simple flattening without repeat/nelems optimization
> is much easier to reason about.

+100 to this, BPF_REPEAT_FIELDS just will add an extra layer of
cognitive overload. Even if it can handle all conceivable situations,
let's just have a list of all "unique fields". We already do dynamic
memory allocation for struct btf_record, one more or less doesn't
matter all that much. We seem to be doing this once per map, not per
instruction or per state.

Let's keep it simple.

> BTF_FIELDS_MAX is just a constant.
> Just don't do struct btf_field_info info_arr[BTF_FIELDS_MAX]; on stack.

