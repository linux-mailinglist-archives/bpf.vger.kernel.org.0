Return-Path: <bpf+bounces-56910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D949AA0402
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 09:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E366E7A6575
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 07:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B22777E1;
	Tue, 29 Apr 2025 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSfMvgyH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5AD27056F;
	Tue, 29 Apr 2025 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909993; cv=none; b=eh7dhTj4FRjISlgRhk88FIdTIaDrFzFrz5/kJ0m2hujmhC9qFJye4w4GMudwe4AIQyMfx56bIsUjmdDxvq0eiYqZo2CVnNMqBGKdZzzIFqu2tJ1vThqIizPRnheot79+MnBoKxw2J+Flaq1XbASDeM0bLcATPpD0vntM3DiK6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909993; c=relaxed/simple;
	bh=qMcpIe9/+uvG8wZk7oEnry7XO6gd0nM8alCIiLEjWrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZO/f8QeAZO89TG5kohsiLHSZNNqu168+GI8NoVTnQGulNQBUh2V+1ygpT5mdWx+pOZmeKVwThBrfVJHHUw6tym+WJii5dfKRANs0L4yMOHp8kiS85dN+yADQ7Q95sXzQe8w57aFobLkz0ndQAiAKOul8YzSNdF7ai11i21Bryco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSfMvgyH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-309d2e8c20cso6888276a91.0;
        Mon, 28 Apr 2025 23:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745909991; x=1746514791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyEB6B1l/sKYAtuNuwZbDvNPwmjtlEht/bIhxatRuiY=;
        b=MSfMvgyHIX2pKJ8eJv7mSNtjy1Pw3m0W6Kx40zGwFnVPWU6PUII4GxvgHxGcFVmogA
         Kus+XxYF3tvWXR9G74QKQvCzmVqNasweWQl1kchFEs5LbPffGBfBemKKEQ2kCZ8UdFIK
         Dj2PEUghTRkKDfJ9mNPiLW60/b5q+cHxD8yu8zfz4VcPgsI8eaQ2DhW5yQhwRoxvwdZG
         /zuJqb2ATTIXZ/yWWsNauymWfVJZOI1QB4S9UXl5I/qNIKdxYW3cA7Q4rTQlOcTumqP9
         7UJCh3CxZzSPPHA++XiQQ59y3XB5qXWm3zhEiMjpkHmY/ysW1F6kxpMjdDsPM6xB5bir
         Qprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745909991; x=1746514791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyEB6B1l/sKYAtuNuwZbDvNPwmjtlEht/bIhxatRuiY=;
        b=Yd2cGmak2nbSFzZdesq4aTlcId3N6x7ybx4tf6tbvLs1LWJVAv872P2H2Z/AvAkicf
         lWkp5Ggy4niSo/XBKoqzpvYHhEjms9qT2EMtmJ8UIN3OOF/r4BUIkUhh1QmJTu4Dtzqk
         VZBdfEIxW/wlX7x+TiyPrEDzsmaZDYTmB+w6dTFr2Pf0nGo5ULLfsmQ9CFPO3YrMW4uQ
         thlr1MDlUFIE+3cx5Rg+JMjYKBSmL3s+ri2caHrnQxNo5RnH+/j5W6wq8PA1nxZoBrHG
         ipuYbDSGvXr1skGhY3PTpqAIiBZ6BHS3FNN456H4pN8hBT+JoEpzUSbszYwqsu0lPglH
         Txmw==
X-Forwarded-Encrypted: i=1; AJvYcCVIYHhWn621Sv+WAytP2zxFji7XRL8dji+tpYNG+ubWLkKxvUz+4scFKWyYrYQXCjAwZEo=@vger.kernel.org, AJvYcCW3KLHAb25bt5Y2fabHdqaVDPhdTv/DaKLobsWew9gj1ichFmDVXVo083luH5nNl3r0I7HLi2s1lA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVp2TxV7zD8fymHp/wFQUUaeX0NYac5KPhylBu4vvg51NdhmX/
	vbApK3CnECgi13G0HwJGtG/7Yo6u30GbZeAKHxZmwEq42/UhDl8r6V8JkMOmbvxtCrN27tfKwR8
	ozvsaI/TY6Y5DGBDh5Ho1b4UBVS/TF7GXbp8=
X-Gm-Gg: ASbGnctWtfggkzkD2QLoEs+ur0EV/d1J8FQgYWvHoshVtY1ayW3fDtQx+fpRN0EODlM
	GdG0h+S17giU0Sc6bIsr2+w1ZuB22JCEpB0aSbwAzCZZFN//DuxXwxvjBO2U92OOQ5R8frZ5bv4
	tzfXH42Ntdfz7wd3NDn2VWjUOtIRsqddkJEhgWDg==
X-Google-Smtp-Source: AGHT+IGmQjf+xrci/Sta1GyW01+e0lOUmW1h+NJcb+T/rgF6itettKyRq0HFKIjiQc5fXXF4EjPxCNSmmmZzDULaW+w=
X-Received: by 2002:a17:90a:c2c7:b0:309:e351:2e3d with SMTP id
 98e67ed59e1d1-30a23dd992dmr2920951a91.12.1745909990914; Mon, 28 Apr 2025
 23:59:50 -0700 (PDT)
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
 <CAADnVQKi4DARfzQJguZyDQsfXHq7A=QM2FwRwpZe-LJzj+Ujrg@mail.gmail.com> <CAEf4BzYt2sUxRPAR5AbAAXVcOeC2UqgkR24WDEZAAd+kEz=g-w@mail.gmail.com>
In-Reply-To: <CAEf4BzYt2sUxRPAR5AbAAXVcOeC2UqgkR24WDEZAAd+kEz=g-w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 28 Apr 2025 23:59:38 -0700
X-Gm-Features: ATxdqUHdws-IMdqSF5wNqejRNLPh-8P_WRJQCFD_wSGkSUzkgqdBPIQrImmfgJg
Message-ID: <CAEf4Bzays+8g7kj4fNS0rBLPTQWzYb_maFkyHyij4ky1xm_GAg@mail.gmail.com>
Subject: Re: pahole and gcc-14 issues
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 5:33=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Apr 28, 2025 at 3:12=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 28, 2025 at 8:21=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> > >
> > >  <1><4bd05>: Abbrev Number: 58 (DW_TAG_pointer_type)
> > >     <4bd06>   DW_AT_byte_size   : 8
> > >     <4bd07>   DW_AT_address_class: 2
> > >     <4bd08>   DW_AT_type        : <0x301cd>
> > >
> > > ...which points at an int
> > >
> > >  <1><301cd>: Abbrev Number: 214 (DW_TAG_base_type)
> > >     <301cf>   DW_AT_byte_size   : 4
> > >     <301d0>   DW_AT_encoding    : 5     (signed)
> > >     <301d1>   DW_AT_name        : int
> > >     <301d5>   DW_AT_name        : int
> > >
> > > ...but note the the DW_AT_address_class attribute in the latter case =
and
> > > the two DW_AT_name values. We don't use that address attribute in pah=
ole
> > > as far as I can see, but it might be enough to cause problems.
> >
> > DW_AT_address_class is there because it's an actual address space
> > qualifier in C. The dwarf is correct, but I thought pahole
> > will ignore it while converting to BTF, so it shouldn't matter
> > from dedup pov.
> >
> > And since dedup is working for vmlinux BTF, I doubt there are CUs
> > where the same type is represented with different dwarf id-s.
> > Otherwise dedup wouldn't have worked for vmlinux.
> >
> > DW_AT_name is concerning. Sounds like it's a gcc bug, but it
> > shouldn't be causing dedup issues for modules.
> >
> > So what is the workaround?
>
> I'm thinking of generalizing Alan's proposed fix so that all our
> existing special equality cases (arrays, identical structs, and now
> pointers to identical types) are handled a bit more generically. I'll
> try to get a patch out later tonight.

So I ran out of time, but I'm thinking something like below. It
results in identical bpf_testmod.ko compared to Alan's proposed fix,
so perhaps we should just go with the simpler approach. But this one
should stand the test of time a bit better.

In any case, I'd like to be able to handle not just PTR -> TYPE chain,
but also some PTR -> MODIFIER* -> TYPE chains at the very least.
Because any const in the chain will throw off Alan's heuristic.

I'll try to benchmark and polish the patch tomorrow and post it for
proper review.


diff --git a/src/btf.c b/src/btf.c
index e9673c0ecbe7..e4a3e3183742 100644
--- a/src/btf.c
+++ b/src/btf.c
@@ -4310,6 +4310,8 @@ static bool btf_dedup_identical_arrays(struct
btf_dedup *d, __u32 id1, __u32 id2
  return btf_equal_array(t1, t2);
 }

+static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1,
__u32 id2);
+
 /* Check if given two types are identical STRUCT/UNION definitions */
 static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32
id1, __u32 id2)
 {
@@ -4329,14 +4331,93 @@ static bool btf_dedup_identical_structs(struct
btf_dedup *d, __u32 id1, __u32 id
  m1 =3D btf_members(t1);
  m2 =3D btf_members(t2);
  for (i =3D 0, n =3D btf_vlen(t1); i < n; i++, m1++, m2++) {
- if (m1->type !=3D m2->type &&
-     !btf_dedup_identical_arrays(d, m1->type, m2->type) &&
-     !btf_dedup_identical_structs(d, m1->type, m2->type))
+ if (m1->type !=3D m2->type && !btf_dedup_identical_types(d, m1->type, m2-=
>type))
+ return false;
+ }
+ return true;
+}
+
+static bool btf_dedup_identical_fnprotos(struct btf_dedup *d, __u32
id1, __u32 id2)
+{
+ const struct btf_param *p1, *p2;
+ struct btf_type *t1, *t2;
+ int n, i;
+
+ t1 =3D btf_type_by_id(d->btf, id1);
+ t2 =3D btf_type_by_id(d->btf, id2);
+
+ if (!btf_is_func_proto(t1) || !btf_is_func_proto(t2))
+ return false;
+
+ if (!btf_compat_fnproto(t1, t2))
+ return false;
+
+ if (!btf_dedup_identical_types(d, t1->type, t2->type))
+ return false;
+
+ p1 =3D btf_params(t1);
+ p2 =3D btf_params(t2);
+ for (i =3D 0, n =3D btf_vlen(t1); i < n; i++, p1++, p2++) {
+ if (p1->type !=3D p2->type && !btf_dedup_identical_types(d, p1->type, p2-=
>type))
  return false;
  }
  return true;
 }

+static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1,
__u32 id2)
+{
+ int max_depth =3D 32;
+
+ while (max_depth-- > 0) {
+ struct btf_type *t1, *t2;
+ int k1, k2;
+
+ t1 =3D btf_type_by_id(d->btf, id1);
+ t2 =3D btf_type_by_id(d->btf, id2);
+
+ k1 =3D btf_kind(t1);
+ k2 =3D btf_kind(t2);
+ if (k1 !=3D k2)
+ return false;
+
+ switch (k1) {
+ case BTF_KIND_UNKN: /* VOID */
+ return true;
+ case BTF_KIND_INT:
+ return btf_equal_int_tag(t1, t2);
+ case BTF_KIND_ENUM:
+ case BTF_KIND_ENUM64:
+ return btf_compat_enum(t1, t2);
+ case BTF_KIND_FWD:
+ case BTF_KIND_FLOAT:
+ return btf_equal_common(t1, t2);
+ case BTF_KIND_CONST:
+ case BTF_KIND_VOLATILE:
+ case BTF_KIND_RESTRICT:
+ case BTF_KIND_PTR:
+ case BTF_KIND_TYPEDEF:
+ case BTF_KIND_FUNC:
+ case BTF_KIND_TYPE_TAG:
+ if (t1->info !=3D t2->info)
+ return 0;
+ id1 =3D t1->type;
+ id2 =3D t2->type;
+ continue;
+ case BTF_KIND_ARRAY:
+ return btf_equal_array(t1, t2);
+ case BTF_KIND_STRUCT:
+ case BTF_KIND_UNION:
+ return btf_dedup_identical_structs(d, id1, id2);
+ case BTF_KIND_FUNC_PROTO:
+ return btf_dedup_identical_fnprotos(d, id1, id2);
+ default:
+ return false;
+ }
+ }
+ return false;
+}
+
+
 /*
  * Check equivalence of BTF type graph formed by candidate struct/union (w=
e'll
  * call it "candidate graph" in this description for brevity) to a type gr=
aph
@@ -4458,8 +4539,6 @@ static int btf_dedup_is_equiv(struct btf_dedup
*d, __u32 cand_id,
  * types within a single CU. So work around that by explicitly
  * allowing identical array types here.
  */
- if (btf_dedup_identical_arrays(d, hypot_type_id, cand_id))
- return 1;
  /* It turns out that similar situation can happen with
  * struct/union sometimes, sigh... Handle the case where
  * structs/unions are exactly the same, down to the referenced
@@ -4467,7 +4546,7 @@ static int btf_dedup_is_equiv(struct btf_dedup
*d, __u32 cand_id,
  * types are different, but equivalent) is *way more*
  * complicated and requires a many-to-many equivalence mapping.
  */
- if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
+ if (btf_dedup_identical_types(d, hypot_type_id, cand_id))
  return 1;
  return 0;
  }

>
> >
> > We need to find it asap. Since at present we cannot build
> > kernels with gcc-14, since modules won't dedup BTF.
> > Hence a bunch of selftests/bpf are failing.
> > We want to upgrade BPF CI to gcc-14 to catch nginx-like issues,
> > but we cannot until this pahole/dedup issue is resolved.

