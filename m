Return-Path: <bpf+bounces-56961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74968AA109B
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CC74A2B8C
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 15:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1677221DA1;
	Tue, 29 Apr 2025 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXsNlQvd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7B122172C;
	Tue, 29 Apr 2025 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941043; cv=none; b=kaEiDcJ1vi2ZPx0KvhXrRqvnQmu//4QKkYnJHJLnwZhGaQehwMhynru6VAfTwFB4IG+s8hyTttCmjPF0sUaDmX+7BkImYP/eUSbXhUMJLxyuYwb454Tm8EdmyzM27LU1uFSsX9PJOmDFvnfjMx0uSttZeONGlvzS097plPGEtcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941043; c=relaxed/simple;
	bh=oXU4dAI3oI7rTg1c1T07P6i1YVzDPmhlHAX15vBKzhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0cupEEkAZblIXh0naKWuZs2vEfP6zxpHE6NVTdxgoI6a4xIpMe+T63lE2dmE6jGKtVkEewq99wdwp9LZX/K8ZMOREZjM69OUfB6nuIbu3sf/HZVVr5SyjQDDnDki7MfYOIrgzCcivKyOm1IJf5BwMUrzo0PQ848snF8KsMPxv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXsNlQvd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74019695377so1981969b3a.3;
        Tue, 29 Apr 2025 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745941041; x=1746545841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fjp8ADOAepJmyfR0bVw+dlfU1R3dP8Y3E9Rmk1dFVTM=;
        b=ZXsNlQvdStfg6FICjsA243kajYev1XrqAxo+WWdH410yVlZViCzDq879Zd+TPk9mZl
         4Xgn3TsG9pcHd4CpnIqIfIh0wj0unCbDkgb/x1OQhNiEDcZQ3+GpfzfnUl1olWmgIDL4
         Ay+IwDDoyT+/41jtvgT6KTRfuvH02M1giaITkPijO9QAgu9L8zyuFInEltP0Sklr0luK
         JRbbHqpzI5qPFAn7vNHfC3+CeR3hcufxL33XAFcN+iHk8hWlwbt5X8aQsaTd36wFfKMj
         KkYHFdrRuBwY+jusBxVcwpida2mLaZA4JCPJ0pQwcpPWVys1e5d6SutnhCIIiont/4At
         12NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745941041; x=1746545841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fjp8ADOAepJmyfR0bVw+dlfU1R3dP8Y3E9Rmk1dFVTM=;
        b=PANR14SJhLXoqm/AR4dwhhiynJNVysb53ek+qm467wnf9JXfeXZT6VUG2Q6xw+8xxJ
         rSu0WT9Sde/2DEYZtFLYa/zvPQugoCS0ViVbAifGu5XV6kjDE/mFBISdPmgizW9Z0cFW
         rFqTFoAb+wvd7g0Nk4tB7NTvq+1wRCtFF4v2A/cea36/SU1nLE6SvNWpgtzMXQXI0yny
         csYPQ3dvxJbNm13v7+fou512ebs9HFmcxmzZYLdDXvTN9BdX1Od2v9pEe+u3Yp2xPf5i
         oFkEyEip/8x7GKoPHp4Amu1X4K5VxwSmpmTGvXd+FePb2jxeWaqbdUGO2VONLUp5068i
         gXmA==
X-Forwarded-Encrypted: i=1; AJvYcCWn6m7UKDR+9rBxfplK9y2pJdatWUT8VTxMquMCl662uliTQf30v7CmLklBRvFrf/p3ZjukeFSb0w==@vger.kernel.org, AJvYcCXyFKlO5BQBwqn/fJQkAVQua0zRKvjA+JATrAHPQZhrMStpecA1tZAd4QYQlA5x3QNiWfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8hVUpkQCJuEb6TzAfvKNBTvUk12dqW9GeBUCRN6CSK2igZMoz
	vegVM5xS3kB3k/yRCdhAf1nUUJa4Ximc7mDDYYbhnsTzHS9XPWClJx0R5E0la0QYfmJENph5Qjk
	InEJqSuTMemzB7Ncsql1DAidRwko=
X-Gm-Gg: ASbGncutPxvuaRuXyjVFyQY9FVckVNTP3uWPxDFwJWuh+r2l7UoBQWpO+xv7Y/S7/wb
	vYmnQIPHOYv3GagBZZmjjNcM9NwTyDdGyDPFOvQaVdK4BoPyx1Gb/7u+5Cp4LZQzqykn11Hi5E+
	+eEnTNr2J3qtkaMVeW7xYMp/yZCqwNkVFBJ8lZYw==
X-Google-Smtp-Source: AGHT+IFu3vX9JUBer33ZUeDigmvEvdDd1VnLEYWZ8lOFIjy8i5Sac9nlI3plOSoMaghC226Dv2mOE4O/GveRCL/9iPA=
X-Received: by 2002:a05:6a20:cfa3:b0:1f5:7007:9eb7 with SMTP id
 adf61e73a8af0-2093ec162a5mr6155771637.37.1745941040819; Tue, 29 Apr 2025
 08:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com> <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
 <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com> <CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
 <c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com> <e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>
 <CAADnVQKi4DARfzQJguZyDQsfXHq7A=QM2FwRwpZe-LJzj+Ujrg@mail.gmail.com>
 <CAEf4BzYt2sUxRPAR5AbAAXVcOeC2UqgkR24WDEZAAd+kEz=g-w@mail.gmail.com> <CAEf4Bzays+8g7kj4fNS0rBLPTQWzYb_maFkyHyij4ky1xm_GAg@mail.gmail.com>
In-Reply-To: <CAEf4Bzays+8g7kj4fNS0rBLPTQWzYb_maFkyHyij4ky1xm_GAg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Apr 2025 08:37:07 -0700
X-Gm-Features: ATxdqUHF4UI4XkFQJ2tVpMLuj4ft5nCtlC74JI0snDUHNzhyXUFxwKyHjHykHRw
Message-ID: <CAEf4BzZgQMV+Gtiob_K-uuizyuqajyLjnGbKOJLyiGB=DxmY2Q@mail.gmail.com>
Subject: Re: pahole and gcc-14 issues
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 11:59=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Apr 28, 2025 at 5:33=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Apr 28, 2025 at 3:12=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Apr 28, 2025 at 8:21=E2=80=AFAM Alan Maguire <alan.maguire@or=
acle.com> wrote:
> > > >
> > > >  <1><4bd05>: Abbrev Number: 58 (DW_TAG_pointer_type)
> > > >     <4bd06>   DW_AT_byte_size   : 8
> > > >     <4bd07>   DW_AT_address_class: 2
> > > >     <4bd08>   DW_AT_type        : <0x301cd>
> > > >
> > > > ...which points at an int
> > > >
> > > >  <1><301cd>: Abbrev Number: 214 (DW_TAG_base_type)
> > > >     <301cf>   DW_AT_byte_size   : 4
> > > >     <301d0>   DW_AT_encoding    : 5     (signed)
> > > >     <301d1>   DW_AT_name        : int
> > > >     <301d5>   DW_AT_name        : int
> > > >
> > > > ...but note the the DW_AT_address_class attribute in the latter cas=
e and
> > > > the two DW_AT_name values. We don't use that address attribute in p=
ahole
> > > > as far as I can see, but it might be enough to cause problems.
> > >
> > > DW_AT_address_class is there because it's an actual address space
> > > qualifier in C. The dwarf is correct, but I thought pahole
> > > will ignore it while converting to BTF, so it shouldn't matter
> > > from dedup pov.
> > >
> > > And since dedup is working for vmlinux BTF, I doubt there are CUs
> > > where the same type is represented with different dwarf id-s.
> > > Otherwise dedup wouldn't have worked for vmlinux.
> > >
> > > DW_AT_name is concerning. Sounds like it's a gcc bug, but it
> > > shouldn't be causing dedup issues for modules.
> > >
> > > So what is the workaround?
> >
> > I'm thinking of generalizing Alan's proposed fix so that all our
> > existing special equality cases (arrays, identical structs, and now
> > pointers to identical types) are handled a bit more generically. I'll
> > try to get a patch out later tonight.
>
> So I ran out of time, but I'm thinking something like below. It
> results in identical bpf_testmod.ko compared to Alan's proposed fix,
> so perhaps we should just go with the simpler approach. But this one
> should stand the test of time a bit better.
>
> In any case, I'd like to be able to handle not just PTR -> TYPE chain,
> but also some PTR -> MODIFIER* -> TYPE chains at the very least.
> Because any const in the chain will throw off Alan's heuristic.
>

Ok, so sleeping on this a bit more, I'm hesitant to do this more
generic approach, as now we'll be running a risk of potentially
looping indefinitely (the max_depth check I added doesn't completely
prevent this).

So, Alan, do you mind sending your proposed patch for formal review
and BPF CI testing? Just please use btf_is_ptr() check instead of
explicit kind equality, thanks!

> I'll try to benchmark and polish the patch tomorrow and post it for
> proper review.
>
>
> diff --git a/src/btf.c b/src/btf.c
> index e9673c0ecbe7..e4a3e3183742 100644
> --- a/src/btf.c
> +++ b/src/btf.c
> @@ -4310,6 +4310,8 @@ static bool btf_dedup_identical_arrays(struct
> btf_dedup *d, __u32 id1, __u32 id2
>   return btf_equal_array(t1, t2);
>  }
>
> +static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1,
> __u32 id2);
> +
>  /* Check if given two types are identical STRUCT/UNION definitions */
>  static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32
> id1, __u32 id2)
>  {
> @@ -4329,14 +4331,93 @@ static bool btf_dedup_identical_structs(struct
> btf_dedup *d, __u32 id1, __u32 id
>   m1 =3D btf_members(t1);
>   m2 =3D btf_members(t2);
>   for (i =3D 0, n =3D btf_vlen(t1); i < n; i++, m1++, m2++) {
> - if (m1->type !=3D m2->type &&
> -     !btf_dedup_identical_arrays(d, m1->type, m2->type) &&
> -     !btf_dedup_identical_structs(d, m1->type, m2->type))
> + if (m1->type !=3D m2->type && !btf_dedup_identical_types(d, m1->type, m=
2->type))
> + return false;
> + }
> + return true;
> +}
> +
> +static bool btf_dedup_identical_fnprotos(struct btf_dedup *d, __u32
> id1, __u32 id2)
> +{
> + const struct btf_param *p1, *p2;
> + struct btf_type *t1, *t2;
> + int n, i;
> +
> + t1 =3D btf_type_by_id(d->btf, id1);
> + t2 =3D btf_type_by_id(d->btf, id2);
> +
> + if (!btf_is_func_proto(t1) || !btf_is_func_proto(t2))
> + return false;
> +
> + if (!btf_compat_fnproto(t1, t2))
> + return false;
> +
> + if (!btf_dedup_identical_types(d, t1->type, t2->type))
> + return false;
> +
> + p1 =3D btf_params(t1);
> + p2 =3D btf_params(t2);
> + for (i =3D 0, n =3D btf_vlen(t1); i < n; i++, p1++, p2++) {
> + if (p1->type !=3D p2->type && !btf_dedup_identical_types(d, p1->type, p=
2->type))
>   return false;
>   }
>   return true;
>  }
>
> +static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1,
> __u32 id2)
> +{
> + int max_depth =3D 32;
> +
> + while (max_depth-- > 0) {
> + struct btf_type *t1, *t2;
> + int k1, k2;
> +
> + t1 =3D btf_type_by_id(d->btf, id1);
> + t2 =3D btf_type_by_id(d->btf, id2);
> +
> + k1 =3D btf_kind(t1);
> + k2 =3D btf_kind(t2);
> + if (k1 !=3D k2)
> + return false;
> +
> + switch (k1) {
> + case BTF_KIND_UNKN: /* VOID */
> + return true;
> + case BTF_KIND_INT:
> + return btf_equal_int_tag(t1, t2);
> + case BTF_KIND_ENUM:
> + case BTF_KIND_ENUM64:
> + return btf_compat_enum(t1, t2);
> + case BTF_KIND_FWD:
> + case BTF_KIND_FLOAT:
> + return btf_equal_common(t1, t2);
> + case BTF_KIND_CONST:
> + case BTF_KIND_VOLATILE:
> + case BTF_KIND_RESTRICT:
> + case BTF_KIND_PTR:
> + case BTF_KIND_TYPEDEF:
> + case BTF_KIND_FUNC:
> + case BTF_KIND_TYPE_TAG:
> + if (t1->info !=3D t2->info)
> + return 0;
> + id1 =3D t1->type;
> + id2 =3D t2->type;
> + continue;
> + case BTF_KIND_ARRAY:
> + return btf_equal_array(t1, t2);
> + case BTF_KIND_STRUCT:
> + case BTF_KIND_UNION:
> + return btf_dedup_identical_structs(d, id1, id2);
> + case BTF_KIND_FUNC_PROTO:
> + return btf_dedup_identical_fnprotos(d, id1, id2);
> + default:
> + return false;
> + }
> + }
> + return false;
> +}
> +
> +
>  /*
>   * Check equivalence of BTF type graph formed by candidate struct/union =
(we'll
>   * call it "candidate graph" in this description for brevity) to a type =
graph
> @@ -4458,8 +4539,6 @@ static int btf_dedup_is_equiv(struct btf_dedup
> *d, __u32 cand_id,
>   * types within a single CU. So work around that by explicitly
>   * allowing identical array types here.
>   */
> - if (btf_dedup_identical_arrays(d, hypot_type_id, cand_id))
> - return 1;
>   /* It turns out that similar situation can happen with
>   * struct/union sometimes, sigh... Handle the case where
>   * structs/unions are exactly the same, down to the referenced
> @@ -4467,7 +4546,7 @@ static int btf_dedup_is_equiv(struct btf_dedup
> *d, __u32 cand_id,
>   * types are different, but equivalent) is *way more*
>   * complicated and requires a many-to-many equivalence mapping.
>   */
> - if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
> + if (btf_dedup_identical_types(d, hypot_type_id, cand_id))
>   return 1;
>   return 0;
>   }
>
> >
> > >
> > > We need to find it asap. Since at present we cannot build
> > > kernels with gcc-14, since modules won't dedup BTF.
> > > Hence a bunch of selftests/bpf are failing.
> > > We want to upgrade BPF CI to gcc-14 to catch nginx-like issues,
> > > but we cannot until this pahole/dedup issue is resolved.

