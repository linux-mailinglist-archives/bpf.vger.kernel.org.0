Return-Path: <bpf+bounces-72483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2C7C12A77
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 03:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE02E4E3ADF
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 02:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998B523B63F;
	Tue, 28 Oct 2025 02:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVsAlLWR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED6E21C9FD
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761618209; cv=none; b=cakpyvrQNPod9mIoIuiH6OvNLwvBWSTy85+GFoA4VdXi0EcWR+XrXWcRw0k8oqXWzlGpeSxtKHJQ9vVGykCE6dPy86JFdLRgRD+jiOPXGkupgADOPJpzNp1HGe8fYQCG3QREhiZB/LWrcl/JJpmQ8ipeWEHoWLBDjqk3KRcGnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761618209; c=relaxed/simple;
	bh=ogmWN+Yo+WRWxz5JuQoVPgWFsyBHQ3lh7oxomEtc85U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+lJmhj68V4kcWrED3F6E6ubCgCdkkWmnQb69MZUXbFTw0V/btuMjyVvOx32jUDiAQJKXXgB+q9lpHhqlPxvlaTxRb8/0qysX+qPKrjyDCAiKtJ4RYNISNmimokg4ZlFE3XscZFAZ7z6dM52WWjgtZM0c/ttoKRf+kxFpdiKniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVsAlLWR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b6d345d7ff7so1010663366b.1
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 19:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761618206; x=1762223006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pARiCYSdg5o5Qzd+a3J2boA62921F59y94mkVra958=;
        b=dVsAlLWR4mH2rYlXM6Tekn7quPzK7F0XaiaLoCZCCAvquJ+hTNa35Y1NSYaWlKx/l3
         bDT2q+ESWNgSucNjgUZqyNDagBgVzQ6Yl8O1wUbu8Y1exg33G6Bwgh6ZXarHuMDhijNS
         MqucpEn59iyWZyI5r+Hyxq6PUmHhWUeH1lqn26pCrAEPjYbn2RWL7Ii37BJvok84sDJL
         ++5C4l4fs7j+Da7OFCw6eQFs3QyqL09C0qAxsE+DrMAVb2WbMosTkYshD4IzXdNWAy3K
         YSbZ0YYKbAZ4BgIQGd1W+fyB8ntYVo9H1poS71nWvAUesxzmJ7BF2XpzGOrHz01D0Jpj
         d5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761618206; x=1762223006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pARiCYSdg5o5Qzd+a3J2boA62921F59y94mkVra958=;
        b=DQC7P5vZ92V3nEzQoIAhwrMJyDKysOxT7Uq18k63FGAjaqTzOIclIBCXqCMkjNLuq+
         HJFdhGG2KuhIQs7KT5wklHdmcUC4j5BMx37RUQkFLLq/ZfuGU7GLaZ8LOvNyM6GzKAis
         gp1pupg0iPjGQ858W4xZWPQuD6AZh250h5ocQ3rqNJZSxhleMjoMQiLDJftzVtaIUJ67
         Loe1eBTm7Kf2iaUG7g63NVq9JHzUKtiu5OXV4y76WqCJiVn5tuFrofXZXzErcEH7BXbg
         FDIR/MZ9clAcOxqHnuCxmtgBesl76O0jCQP+XIQyUjC4WDA7M3y3aZBWu4sOHd3Cfo6m
         b8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWJuy40ANCBP0/FrXSLIMSWVnHI/LJu76yD4Q2O69aY4F+DGkxkWxZa2JErJHttyRQYKxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLcQUUTQT3t1lda046XMdWeCiGUBheJ18eaVsjIJQKtYzVmWU
	pOQgWPWtWX/KABg+MbQx3glCUqZFxtodGCV7/jbAr2Vs4pnCVmvDu5FooevASLyFVmG1rpUL5K6
	IgzIqbBZCW9CUvnuiT3WjUXaww6aMVzvLria8
X-Gm-Gg: ASbGncssenCebFyAcCFJZm2jkqVgZxaADBh5gUyvScNm/kTnaB84LASk+lZetrcIi+c
	m6vLG9wugVLEo6PUwqKiH7zVTG/h8EI6nGMbZeRkYdVKn5CxJ79SX8HZNQxiKx/6WrlEzD3J/qt
	SNborJ9nfZR3Mrnp5rJgiO/FnTmGTUinzOprBVq+cxWrWx2KF6YxrEC5M0xqnyW8gJM+AaoeIr2
	SJ0v959f0l3377S26R9MzCP9pMDSxRcgA++oX2ahlMDuWcLRsZ4tActuSqnhg==
X-Google-Smtp-Source: AGHT+IED1Suapf4STarzlNw2dnysa1HHPOi/OyYQwOfNavNzIXMoj95He+RT9XOiL1TpXC2wyiFcWQSE8Tf44MMQ7ek=
X-Received: by 2002:a17:907:944d:b0:b3e:c99b:c77f with SMTP id
 a640c23a62f3a-b6dbbff3129mr172637566b.24.1761618205576; Mon, 27 Oct 2025
 19:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
 <20251027135423.3098490-3-dolinux.peng@gmail.com> <c3f1b8ce39335ea0061a8b75a943f12638da6a9c.camel@gmail.com>
In-Reply-To: <c3f1b8ce39335ea0061a8b75a943f12638da6a9c.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 28 Oct 2025 10:23:13 +0800
X-Gm-Features: AWmQ_bkWvgu9D8t2u62ZdOQLvnE8Z5Kz5pGXMlEeLui3DqiFNGdUm7WchEjrFXY
Message-ID: <CAErzpmtu0=_j23ipTh9CGYKXRwxH4nqGptZX7Pd55PFvWLq4rw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/3] selftests/bpf: add tests for BTF type permutation
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 2:53=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-10-27 at 21:54 +0800, Donglin Peng wrote:
> > Verify that BTF type permutation functionality works correctly.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
>
> Do we need a test case for split btf?
> We probably do, as there is index arithmetic etc.

Thanks, I will add a test case for split btf.

>
> [...]
>
> > @@ -8022,6 +8026,72 @@ static struct btf_dedup_test dedup_tests[] =3D {
> >               BTF_STR_SEC("\0foo\0x\0y\0foo_ptr"),
> >       },
> >  },
> > +{
> > +     .descr =3D "permute: func/func_param/struct/struct_member tags",
> > +     .input =3D {
> > +             .raw_types =3D {
> > +                     /* int */
> > +                     BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [1] */
> > +                     /* void f(int a1, int a2) */
> > +                     BTF_FUNC_PROTO_ENC(0, 2),                       /=
* [2] */
> > +                             BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 1),
> > +                             BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
> > +                     BTF_FUNC_ENC(NAME_NTH(3), 2),                   /=
* [3] */
> > +                     /* struct t {int m1; int m2;} */
> > +                     BTF_STRUCT_ENC(NAME_NTH(4), 2, 8),              /=
* [4] */
> > +                             BTF_MEMBER_ENC(NAME_NTH(5), 1, 0),
> > +                             BTF_MEMBER_ENC(NAME_NTH(6), 1, 32),
> > +                     /* tag -> f: tag1, tag2, tag3 */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(7), 3, -1),           /=
* [5] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(8), 3, -1),           /=
* [6] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(9), 3, -1),           /=
* [7] */
> > +                     /* tag -> f/a2: tag1, tag2, tag3 */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(7), 3, 1),            /=
* [8] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(8), 3, 1),            /=
* [9] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(9), 3, 1),            /=
* [10] */
> > +                     /* tag -> t: tag1, tag2, tag3 */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(7), 4, -1),           /=
* [11] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(8), 4, -1),           /=
* [12] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(9), 4, -1),           /=
* [13] */
> > +                     /* tag -> t/m2: tag1, tag3 */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(7), 4, 1),            /=
* [14] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(8), 4, 1),            /=
* [15] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(9), 4, 1),            /=
* [16] */
> > +                     BTF_END_RAW,
> > +             },
> > +             BTF_STR_SEC("\0a1\0a2\0f\0t\0m1\0m2\0tag1\0tag2\0tag3"),
> > +     },
>
> Nit: I think that this test is a bit too large.
>      Having fewer decl_tags would still test what we want to test.

Thanks, I agree, I will clean it up.

>
> > +     .expect =3D {
> > +             .raw_types =3D {
> > +                     BTF_FUNC_ENC(NAME_NTH(3), 16),                  /=
* [1] */
> > +                     BTF_STRUCT_ENC(NAME_NTH(4), 2, 8),              /=
* [2] */
> > +                             BTF_MEMBER_ENC(NAME_NTH(5), 15, 0),
> > +                             BTF_MEMBER_ENC(NAME_NTH(6), 15, 32),
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(7), 1, -1),           /=
* [3] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(7), 1,  1),           /=
* [4] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(7), 2, -1),           /=
* [5] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(7), 2,  1),           /=
* [6] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(8), 1, -1),           /=
* [7] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(8), 1,  1),           /=
* [8] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(8), 2, -1),           /=
* [9] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(8), 2,  1),           /=
* [10] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(9), 1, -1),           /=
* [11] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(9), 1,  1),           /=
* [12] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(9), 2, -1),           /=
* [13] */
> > +                     BTF_DECL_TAG_ENC(NAME_NTH(9), 2,  1),           /=
* [14] */
> > +                     BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [15] */
> > +                     BTF_FUNC_PROTO_ENC(0, 2),                       /=
* [16] */
> > +                             BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 15),
> > +                             BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 15),
> > +                     BTF_END_RAW,
> > +             },
> > +             BTF_STR_SEC("\0a1\0a2\0f\0t\0m1\0m2\0tag1\0tag2\0tag3"),
> > +     },
> > +     .permute =3D true,
> > +     .permute_opts =3D {
> > +             .ids =3D permute_ids_sort_by_kind_name,
> > +     },
> > +},
> >  };
>
> [...]

