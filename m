Return-Path: <bpf+bounces-27722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E48B1425
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578861C20EBB
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 20:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D618413C3C2;
	Wed, 24 Apr 2024 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkH8aYni"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBD134A8
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989386; cv=none; b=UjDUbCan164EtUaJv1AcUgljbpv7UyXXLREO+jq8pnxCo2tkaB2qBm1JgYDWyOiXQdK8+vIpEnefPuwcsIE1V9lOc9Koux3WEU48fH++Lbs+uTe4Tz+1afAMqzIMp5/ZXXAgvDCgUYkQlx/0jEO3JUa76nlIiGc3Ppz5MNz4g1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989386; c=relaxed/simple;
	bh=tf3m2MUBADCSMd73670L5geP5cOBK78wpFyKQR03ERY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTvqX9PESZxpC1eBA1f5vlljHsosgABKaeMqOrYfCU/C7Bc6R6dubTqO20BuIaXJhW9vSo+KVq1RV5hR3ICGiF9IeoyYPoaNOwnbV8zifkL3gK97x2c+LE/34L7dCXW7LrEPFKCWdXqJjs8uhVMTlSH3jIqugsXthT3XpiDlQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkH8aYni; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3455ff1339dso163812f8f.0
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713989383; x=1714594183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvhsqRLccIb/kIMM9TxJ3t8zNVPNXAHAWhY+IaF++OQ=;
        b=DkH8aYniLzhes2E8LFvy6b4l4Ws4xTIu1aioYa5LVwpeE9uWL28NrPMcXisdv6gFZL
         cpCsz3I6vZMt8stYgbwZ32C/mYDMBq3kL4KIh6Sw6P4afieYssoANJBcT2gXcUpEQPZu
         7SIHaguhiB65uGyCMpKyh6k4hvvWH7k8Jmi25tmcYcA8aTz1IbgxOMX0XUw/z7EoJx/T
         vE+QxFnu+83yuMQDOV2xtpiESpINkEZlIpGd4hCRoCPqOCM0JoTbY+9KdQ8eed6IFdvg
         5/yWQpqnKRCfPFM48o/1GRyojpH4DGFSw+MdSPde+sDC9G1QOOJ9NiN37pvGq4Ipg4IA
         Lsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713989383; x=1714594183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvhsqRLccIb/kIMM9TxJ3t8zNVPNXAHAWhY+IaF++OQ=;
        b=cOpmdccAOYIfkJiWX1b/zEvbg+Zh9wQGrBQgalLTfli7B/f1sBU2B/2LyqBQCsRAJO
         BSxRQbMPHG18w903XwBpt/B/exlfy3junAs0e7D0sYym6XC3DapnnFkdbvqqO0GXmyTx
         DM9/mlPX9tx18kPZJWUO/RryK6hv9R0y8rtRq5bWQqwC1mqaRuLk7q7Kq9GKvMm8XhTz
         YqZyhFS00fXqMQnRaYt5wls5tMFbzEJP44lKX/SRYYncZpkNbTk56KkzBPlAzfTxtiyn
         RhE9XHEjjFaPcNgAyxHQkdT70RgrpshlsNGqF4L+Md6iJA1S1hvjYBg08KhVOhYMCJdR
         OuaA==
X-Forwarded-Encrypted: i=1; AJvYcCVRhI/zG7E63mN6SJSS2HtYn55lP/zU6WHwPysNaN5OK3QJIUNTNvqaTHsHGFdSoibUzjjuFA6GLB0v1C60JNz66go0
X-Gm-Message-State: AOJu0YyIRY04ONrvrgdQBvjkXu8UjUzyVB1QkKc0MRl8GkpxFS3up9iK
	nwJyvCHsorMaTYtlZUoX8Xtgk5Jgm48M7uvUcDN/LBiZCaEWES2FDr/+8HVc1lwBt+vxQZCx3/X
	T6YI8Cl9y+0mZl5vz8Ae4OCQ/pm0=
X-Google-Smtp-Source: AGHT+IG1kt3pxsiyFefww9GwvgRDNu5t/kG+yWHgmvtHhq4kJIktnR/6BJDP5RZg5bBrzWvFhwvBLWr7yYX1E5gIVZE=
X-Received: by 2002:a05:6000:50d:b0:346:ef6f:562b with SMTP id
 a13-20020a056000050d00b00346ef6f562bmr2844126wrf.53.1713989382849; Wed, 24
 Apr 2024 13:09:42 -0700 (PDT)
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
In-Reply-To: <90652139-f541-4a99-837e-e5857c901f61@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Apr 2024 13:09:31 -0700
Message-ID: <CAADnVQJFtRwwGm=zEa=CgskY57gXPsG240FA66xZFBONqPTYTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays
 of kptr, bpf_rb_root, and bpf_list_head.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 7:54=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 4/22/24 19:45, Kui-Feng Lee wrote:
> >
> >
> > On 4/18/24 07:53, Alexei Starovoitov wrote:
> >> On Wed, Apr 17, 2024 at 11:07=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail=
.com>
> >> wrote:
> >>>
> >>>
> >>>
> >>> On 4/17/24 22:11, Alexei Starovoitov wrote:
> >>>> On Wed, Apr 17, 2024 at 9:31=E2=80=AFPM Kui-Feng Lee <sinquersw@gmai=
l.com>
> >>>> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 4/17/24 20:30, Alexei Starovoitov wrote:
> >>>>>> On Fri, Apr 12, 2024 at 2:08=E2=80=AFPM Kui-Feng Lee
> >>>>>> <thinker.li@gmail.com> wrote:
> >>>>>>>
> >>>>>>> The arrays of kptr, bpf_rb_root, and bpf_list_head didn't work as
> >>>>>>> global variables. This was due to these types being initialized a=
nd
> >>>>>>> verified in a special manner in the kernel. This patchset allows =
BPF
> >>>>>>> programs to declare arrays of kptr, bpf_rb_root, and
> >>>>>>> bpf_list_head in
> >>>>>>> the global namespace.
> >>>>>>>
> >>>>>>> The main change is to add "nelems" to btf_fields. The value of
> >>>>>>> "nelems" represents the number of elements in the array if a
> >>>>>>> btf_field
> >>>>>>> represents an array. Otherwise, "nelem" will be 1. The verifier
> >>>>>>> verifies these types based on the information provided by the
> >>>>>>> btf_field.
> >>>>>>>
> >>>>>>> The value of "size" will be the size of the entire array if a
> >>>>>>> btf_field represents an array. Dividing "size" by "nelems" gives =
the
> >>>>>>> size of an element. The value of "offset" will be the offset of t=
he
> >>>>>>> beginning for an array. By putting this together, we can
> >>>>>>> determine the
> >>>>>>> offset of each element in an array. For example,
> >>>>>>>
> >>>>>>>        struct bpf_cpumask __kptr * global_mask_array[2];
> >>>>>>
> >>>>>> Looks like this patch set enables arrays only.
> >>>>>> Meaning the following is supported already:
> >>>>>>
> >>>>>> +private(C) struct bpf_spin_lock glock_c;
> >>>>>> +private(C) struct bpf_list_head ghead_array1 __contains(foo, node=
2);
> >>>>>> +private(C) struct bpf_list_head ghead_array2 __contains(foo, node=
2);
> >>>>>>
> >>>>>> while this support is added:
> >>>>>>
> >>>>>> +private(C) struct bpf_spin_lock glock_c;
> >>>>>> +private(C) struct bpf_list_head ghead_array1[3] __contains(foo,
> >>>>>> node2);
> >>>>>> +private(C) struct bpf_list_head ghead_array2[2] __contains(foo,
> >>>>>> node2);
> >>>>>>
> >>>>>> Am I right?
> >>>>>>
> >>>>>> What about the case when bpf_list_head is wrapped in a struct?
> >>>>>> private(C) struct foo {
> >>>>>>      struct bpf_list_head ghead;
> >>>>>> } ghead;
> >>>>>>
> >>>>>> that's not enabled in this patch. I think.
> >>>>>>
> >>>>>> And the following:
> >>>>>> private(C) struct foo {
> >>>>>>      struct bpf_list_head ghead;
> >>>>>> } ghead[2];
> >>>>>>
> >>>>>>
> >>>>>> or
> >>>>>>
> >>>>>> private(C) struct foo {
> >>>>>>      struct bpf_list_head ghead[2];
> >>>>>> } ghead;
> >>>>>>
> >>>>>> Won't work either.
> >>>>>
> >>>>> No, they don't work.
> >>>>> We had a discussion about this in the other day.
> >>>>> I proposed to have another patch set to work on struct types.
> >>>>> Do you prefer to handle it in this patch set?
> >>>>>
> >>>>>>
> >>>>>> I think eventually we want to support all such combinations and
> >>>>>> the approach proposed in this patch with 'nelems'
> >>>>>> won't work for wrapper structs.
> >>>>>>
> >>>>>> I think it's better to unroll/flatten all structs and arrays
> >>>>>> and represent them as individual elements in the flattened
> >>>>>> structure. Then there will be no need to special case array with
> >>>>>> 'nelems'.
> >>>>>> All special BTF types will be individual elements with unique offs=
et.
> >>>>>>
> >>>>>> Does this make sense?
> >>>>>
> >>>>> That means it will creates 10 btf_field(s) for an array having 10
> >>>>> elements. The purpose of adding "nelems" is to avoid the
> >>>>> repetition. Do
> >>>>> you prefer to expand them?
> >>>>
> >>>> It's not just expansion, but a common way to handle nested structs t=
oo.
> >>>>
> >>>> I suspect by delaying nested into another patchset this approach
> >>>> will become useless.
> >>>>
> >>>> So try adding nested structs in all combinations as a follow up and
> >>>> I suspect you're realize that "nelems" approach doesn't really help.
> >>>> You'd need to flatten them all.
> >>>> And once you do there is no need for "nelems".
> >>>
> >>> For me, "nelems" is more like a choice of avoiding repetition of
> >>> information, not a necessary. Before adding "nelems", I had considere=
d
> >>> to expand them as well. But, eventually, I chose to add "nelems".
> >>>
> >>> Since you think this repetition is not a problem, I will expand array=
 as
> >>> individual elements.
> >>
> >> You don't sound convinced :)
> >> Please add support for nested structs on top of your "nelems" approach
> >> and prototype the same without "nelems" and let's compare the two.
> >
> >
> > The following is the prototype that flatten arrays and struct types.
> > This approach is definitely simpler than "nelems" one.  However,
> > it will repeat same information as many times as the size of an array.
> > For now, we have a limitation on the number of btf_fields (<=3D 10).

I understand the concern and desire to minimize duplication,
but I don't see how this BPF_REPEAT_FIELDS approach is going to work.
From btf_parse_fields() pov it becomes one giant opaque field
that sort_r() processes as a blob.

How
btf_record_find(reg->map_ptr->record,
                off + reg->var_off.value, BPF_KPTR);

is going to find anything in there?
Are you making a restriction that arrays and nested structs
will only have kptrs in there ?
So BPF_REPEAT_FIELDS can only wrap kptrs ?
But even then these kptrs might have different btf_ids.
So
struct map_value {
   struct {
      struct task __kptr *p1;
      struct thread __kptr *p2;
   } arr[10];
};

won't be able to be represented as BPF_REPEAT_FIELDS?

I think that simple flattening without repeat/nelems optimization
is much easier to reason about.
BTF_FIELDS_MAX is just a constant.
Just don't do struct btf_field_info info_arr[BTF_FIELDS_MAX]; on stack.

