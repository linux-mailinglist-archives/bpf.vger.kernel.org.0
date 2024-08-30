Return-Path: <bpf+bounces-38597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573F2966A95
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C8B284C3E
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBB21BF33D;
	Fri, 30 Aug 2024 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0wCGwTp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D649166F0D
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050095; cv=none; b=ZXipMR0sR9JMQSrrXT0bha/Dv/mhZbou3E+7F9SMh81Sr5qwIbhvhseeTaZlWcIltIN+qhXYzvSPtVBFjJ42U9NTpbroBUaDWuQWzDZMptdHWQRBvkdvW0EO0tWqbHlphdLWboEyHSYRmFXIewHLtRiLsR9/Mu/JicjLP26bcFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050095; c=relaxed/simple;
	bh=qdkEg5rR5SAlJJlV3aTjayo88rii8mJXllGI8zsIwAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONyZw/nh5mUg+unm+3AIZ8LUSsQLf0F2x8Z/WjEmBy0qJVc1awbVeQM3vEpKQJPap7y9Jr7uqS8gvRY7CA7PZCbgFUjldFdqYhG+g4EysNM+CgpUfrJgYGSp8txiXAVWOFut9geS4YJUyhnw4Nyu1KGTonJk7D3pLyf26KIRtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0wCGwTp; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso1666918a12.2
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725050093; x=1725654893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7E6ZRWBIOZTX9+c1grXCImWy2eoCm0Y0VRFR1bFZQEs=;
        b=O0wCGwTp2NbkpalPj2k6CCN5R63iuzDwhE/EobbI+gZF62yOEAxtKrWJlXJTPx486D
         GlU/uiXvg3zOIvLJ8SeMhX62/4qUWQw7MRkuYQDIFkwVcCLLnbh6BCFBi3HWGgNuaqUr
         g8dgM4I4ar9Lcylut4ItnT2PVb0fQsfO6kudgGG/afoYLu2TeBwAWx+GAHhj+PsN7AE9
         jixJ2evEQvHQQNU6bMLkVkfxjS/EUwzHl96Av5/9bckq4gydsF8pKiJShaEn/f/o3PzY
         r2rU3UUoHOk0iA+CF4fLWhV5aXXH8yEpHeM2+sD3Xc/El3Kd2/qYsCoCPZrp+eYb7dUd
         RewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725050093; x=1725654893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7E6ZRWBIOZTX9+c1grXCImWy2eoCm0Y0VRFR1bFZQEs=;
        b=gNP0Hx6TZb8Z9tY3CPo03wsSM8yS8iw4WCpwtPlvpxQJGzW4L60BMi4T1mxotabF4I
         nENs9h42Okhg2BwCVghcYo7nGcvhRoGCx4d8kFRGCd68vDZh7dvcoEuAI3svNeaFR+t8
         truboh3Yjya88f/F9mmiocqh1hda74ISMbFxsGriVv+m9uYFXjSifsYyr8viNnh4EaNz
         x0ly4gnWvd/YsmnSmO+Qf3gxbVF80jZSd4Yso0RktpvbSOG83mlCxAGcR4Bk4HWi2ij2
         K0Wky8GlX47uWQfdmMy/bAxBfI3eiAG4A4Jk4mkeamjiti7D3BwfvUWY97neZMrdmAtP
         /Zqw==
X-Forwarded-Encrypted: i=1; AJvYcCWLckp6Czsg334Ifa9HAuzRH7HXpIdb9AW3vMS3ytpI8+FDBu5DrtQBwrPfsCUwzhs4aeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbo7VzD1LJPBXe1SkbteawTePFuc7CvdZEwRfS/Wk40qtyasq
	ds11cEIgZmCxbv70gKlQdZsMp9oGRPDi1QJaPo56Cx3UW9P+pMmzB1aL8KfcmxRZUuRQza3W3xN
	rDgmVFeCjI5qzV+n2V7oJR99AUus=
X-Google-Smtp-Source: AGHT+IGrf+cvwHDGc+y/XYrn8V1hv05gjK/hZo7/XcAc1k85CzgeLg2BpoDAuvHCf5BJ8/znOQIl4JxAHy31AawyVjM=
X-Received: by 2002:a17:90b:198d:b0:2d8:8695:353 with SMTP id
 98e67ed59e1d1-2d88e6f5a0fmr991043a91.41.1725050092645; Fri, 30 Aug 2024
 13:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828174608.377204-1-ihor.solodrai@pm.me> <20240828174608.377204-2-ihor.solodrai@pm.me>
 <b48f348c76dd5b724384aef7c7c067877b28ee5b.camel@gmail.com>
In-Reply-To: <b48f348c76dd5b724384aef7c7c067877b28ee5b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 13:34:40 -0700
Message-ID: <CAEf4BzaBMhb4a2Y-2_mcLmYjJ2UWQuwNF-2sPVJXo39+0ziqzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: do not update vmlinux.h unnecessarily
To: Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-08-28 at 17:46 +0000, Ihor Solodrai wrote:
> > %.bpf.o objects depend on vmlinux.h, which makes them transitively
> > dependent on unnecessary libbpf headers. However vmlinux.h doesn't
> > actually change as often.
> >
> > When generating vmlinux.h, compare it to a previous version and update
> > it only if there are changes.
> >
> > Example of build time improvement (after first clean build):
> >   $ touch ../../../lib/bpf/bpf.h
> >   $ time make -j8
> > Before: real  1m37.592s
> > After:  real  0m27.310s
> >
> > Notice that %.bpf.o gen step is skipped if vmlinux.h hasn't changed.
> >
> > Link: https://lore.kernel.org/bpf/CAEf4BzY1z5cC7BKye8=3DA8aTVxpsCzD=3Dp=
1jdTfKC7i0XVuYoHUQ@mail.gmail.com
> >
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> > ---
>
> Unfortunately, I think that this is a half-measure.
> E.g. the following command forces tests rebuild for me:
>
>   touch ../../../../kernel/bpf/verifier.c; \
>   make -j22 -C ../../../../; \
>   time make test_progs
>
> To workaround this we need to enable reproducible_build option:
>
>     diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>     index b75f09f3f424..8cd648f3e32b 100644
>     --- a/scripts/Makefile.btf
>     +++ b/scripts/Makefile.btf
>     @@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)   =
   +=3D --skip_encoding_btf_inconsis
>      else
>
>      # Switch to using --btf_features for v1.26 and later.
>     -pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j --btf_featu=
res=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consis=
tent_func,decl_tag_kfuncs
>     +pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j --btf_featu=
res=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consis=
tent_func,decl_tag_kfuncs,reproducible_build
>
>      ifneq ($(KBUILD_EXTMOD),)
>      module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=3D --btf_f=
eatures=3Ddistilled_base
>
> Question to the mailing list: do we want this?

Alan, can you please give us a summary of what are the consequences of
the reproducible_build pahole option? In terms of performance and
otherwise.

I've applied patches as is, despite them not solving the issue
completely, as they are moving us in the right direction anyways. I do
get slightly different BTF every single time I rebuild my kernel, so
the change in patch #2 doesn't yet help me.

For libbpf headers, Ihor, can you please follow up with adding
bpf_helper_defs.h as a dependency?

I have some ideas on how to make BTF regeneration in vmlinux.h itself
unnecessary, that might help with this issue. Separately (depending on
what are the negatives of the reproducible_build option) we can look
into making pahole have more consistent internal BTF type ordering
without negatively affecting the overall BTF dedup performance in
pahole. Hopefully I can work with Ihor on this as follow ups.

P.S. I also spent more time than I'm willing to admit trying to
improve bpftool's BTF sorting to minimize the chance of vmlinux.h
contents being different, and I think I removed a bunch of cases where
we had unnecessary differences, but still, it's fundamentally
non-deterministic to do everything based on type and field names,
unfortunately.

Anyways, Mykyta (cc'ed), what do you think about the changes below?
Note that I'm also fixing the incorrect handling of enum64 (would be
nice to prepare a proper patch and send it upstream, if you get a
chance).

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 6789c7a4d5ca..e8a244b09d56 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -50,6 +50,7 @@ struct sort_datum {
        int type_rank;
        const char *sort_name;
        const char *own_name;
+       __u64 disambig_hash;
 };

 static const char *btf_int_enc_str(__u8 encoding)
@@ -552,35 +553,92 @@ static int btf_type_rank(const struct btf *btf,
__u32 index, bool has_name)
        }
 }

-static const char *btf_type_sort_name(const struct btf *btf, __u32
index, bool from_ref)
+static const char *btf_type_sort_name(const struct btf *btf, __u32
index, bool from_ref, const char *typedef_name)
 {
        const struct btf_type *t =3D btf__type_by_id(btf, index);
+       int name_off;

        switch (btf_kind(t)) {
        case BTF_KIND_ENUM:
-       case BTF_KIND_ENUM64: {
-               int name_off =3D t->name_off;
-
                /* Use name of the first element for anonymous enums
if allowed */
                if (!from_ref && !t->name_off && btf_vlen(t))
                        name_off =3D btf_enum(t)->name_off;
+               else
+                       name_off =3D t->name_off;
+
+               return btf__name_by_offset(btf, name_off);
+       case BTF_KIND_ENUM64:
+               /* Use name of the first element for anonymous enums
if allowed */
+               if (!from_ref && !t->name_off && btf_vlen(t))
+                       name_off =3D btf_enum64(t)->name_off;
+               else
+                       name_off =3D t->name_off;

                return btf__name_by_offset(btf, name_off);
-       }
        case BTF_KIND_ARRAY:
-               return btf_type_sort_name(btf, btf_array(t)->type, true);
+               return btf_type_sort_name(btf, btf_array(t)->type,
true, typedef_name);
+       case BTF_KIND_STRUCT:
+       case BTF_KIND_UNION:
+               if (t->name_off =3D=3D 0)
+                       return typedef_name;
+               return btf__name_by_offset(btf, t->name_off);
+       case BTF_KIND_TYPEDEF:
+               return btf_type_sort_name(btf, t->type, true,
+                                         btf__name_by_offset(btf,
t->name_off));
        case BTF_KIND_TYPE_TAG:
        case BTF_KIND_CONST:
        case BTF_KIND_PTR:
        case BTF_KIND_VOLATILE:
        case BTF_KIND_RESTRICT:
-       case BTF_KIND_TYPEDEF:
        case BTF_KIND_DECL_TAG:
-               return btf_type_sort_name(btf, t->type, true);
+               return btf_type_sort_name(btf, t->type, true, typedef_name)=
;
        default:
                return btf__name_by_offset(btf, t->name_off);
        }
-       return NULL;
+}
+
+static __u64 hasher(__u64 hash, __u64 val)
+{
+       return hash * 31 + val;
+}
+
+static __u64 btf_type_disambig_hash(const struct btf *btf, __u32 index)
+{
+       const struct btf_type *t =3D btf__type_by_id(btf, index);
+       int i;
+       size_t hash =3D 0;
+
+       switch (btf_kind(t)) {
+       case BTF_KIND_ENUM:
+               hash =3D hasher(hash, t->size);
+               for (i =3D 0; i < btf_vlen(t); i++)
+                       hash =3D hasher(hash, btf_enum(t)[i].name_off);
+               break;
+       case BTF_KIND_ENUM64:
+               hash =3D hasher(hash, t->size);
+               for (i =3D 0; i < btf_vlen(t); i++)
+                       hash =3D hasher(hash, btf_enum64(t)[i].name_off);
+               break;
+       case BTF_KIND_STRUCT:
+       case BTF_KIND_UNION: {
+               const struct btf_member *m;
+               const char *ftname;
+
+               hash =3D hasher(hash, t->size);
+               for (i =3D 0; i < btf_vlen(t); i++) {
+                       m =3D btf_members(t) + i;
+                       hash =3D hasher(hash, m->name_off);
+
+                       /* resolve field type's name and hash it as well */
+                       ftname =3D btf_type_sort_name(btf, m->type, false, =
"");
+                       hash =3D hasher(hash, str_hash(ftname));
+               }
+               break;
+       }
+       default:
+               break;
+       }
+       return hash;
 }

 static int btf_type_compare(const void *left, const void *right)
@@ -596,7 +654,14 @@ static int btf_type_compare(const void *left,
const void *right)
        if (r)
                return r;

-       return strcmp(d1->own_name, d2->own_name);
+       r =3D strcmp(d1->own_name, d2->own_name);
+       if (r)
+               return r;
+
+       if (d1->disambig_hash !=3D d2->disambig_hash)
+               return d1->disambig_hash < d2->disambig_hash ? -1 : 1;
+
+       return d1->index < d2->index ? -1 : 1;
 }

 static struct sort_datum *sort_btf_c(const struct btf *btf)
@@ -615,8 +680,9 @@ static struct sort_datum *sort_btf_c(const struct btf *=
btf)

                d->index =3D i;
                d->type_rank =3D btf_type_rank(btf, i, false);
-               d->sort_name =3D btf_type_sort_name(btf, i, false);
+               d->sort_name =3D btf_type_sort_name(btf, i, false, "");
                d->own_name =3D btf__name_by_offset(btf, t->name_off);
+               d->disambig_hash =3D btf_type_disambig_hash(btf, i);
        }

        qsort(datums, n, sizeof(struct sort_datum), btf_type_compare);


>
> [...]
>

