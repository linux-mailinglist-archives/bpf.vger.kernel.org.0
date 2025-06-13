Return-Path: <bpf+bounces-60619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9455FAD9384
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 19:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1401E4C97
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7363D221FBE;
	Fri, 13 Jun 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF5iBmNo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B402E11B3
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834613; cv=none; b=JprE+XXyworI5169EWYT8GRwiuk2PEO+WWiE5VlC8q4i8xlF5yY2sP5pNpZJQBTQcpVHROtFeIfwBqzt/7PuIZbKIC8lxXhfGlNKf9Kw6asKFRaRMV+YyMoyQx63czgier17/p0E1baKnRHjc1EDjaw7hu0M+mGggAH34Wv6rYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834613; c=relaxed/simple;
	bh=2ap8nAW5nPCbSTlJ9Ftpgxti7ZmSgf6J2FR575U+qfk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g8Cslhn0NhbzgO2H329Fjvtx1tS2xh2aYn25A0wKWHb/34iQo7hEK/BKmfluWjC3N4RcOLk8ef9Az2u9JMKskyzhgJOPzBTrP+g0xMhDQis+OkbHct+urBVovjbdDeSSiOBJsY58DOamxtiGFrAsNsRuZjqvL1XwHGHsyryNU9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF5iBmNo; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso1945827a12.2
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749834611; x=1750439411; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qy1EXMiUqlQMb7Jp2CvgkokiOXVK9+e77NrGmyNCxMA=;
        b=LF5iBmNoXOvuQlM4Le3blk4zwJScy2JYo8wFyJIVyI6bSVSoE5DIEAyp9hWEI3kiVq
         r6xmUXANVxD6gegny4PNY+EHt4HnWcxhLd23A+CHyoJLXdxKc3mO2gvTvLdxXejOcT+6
         CKlQGiTJe+Cunek0FOvJ3HeJ4u9hviXF3DRSZ3CCRCrEBN/ustEb3kMJRKEIzHW+iW1x
         czkkmTelwbJuozgielj69aTq79lTDWQlXFK9boWdvA2ZMsXn1YSotG2xBuTFLgC1zT/k
         rNscdWJOjDFo/Dfb2ZG1ToD0QDDfHjpG5KfVSHEAVm/ZDiGOg/s/qOMTUmWrWx2km0zJ
         tssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749834611; x=1750439411;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qy1EXMiUqlQMb7Jp2CvgkokiOXVK9+e77NrGmyNCxMA=;
        b=C8FhoafDcbHh6lc857PtcucqsAYovy6zHPBPyWo4WUiKmiFopJLE/f+UdzK8Zl0hjX
         AkhsPfrMlfEv5Ji0F7nUZk/menDvXicWMdS2S83MAWkB8p0iu877cmvOIAcgmqT4I1Kn
         IY0xklHH4MdBF8XrO4K+jGoZnWpmJ/8lTr+VLUE+gHyTt2BKWSD4zW1kX1atDtCBe5Af
         tUSPDdKAE9/Yi/jdmyiK0ra6hlp/zCHHvF6ZAIhAir463OZXjyn+5DX0Y6OIgyIoqBa0
         MawZn16QMDOqpdyr9SoT/XNSx/GnLKoDaJmab68N2NwPOE8kH3O8Q6vgv1rRMoy6i20E
         Rcaw==
X-Forwarded-Encrypted: i=1; AJvYcCW1zqqQ9jw6/ps/nQbfgM2nBrGmnetIyS1086juhy41ZHTA8jHV+px0oc/k5e/OssCLVBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzr3gpYg2MEffZqY0ZcaaONqQVrvDutam95OgEiVZxDGvpLgOj
	Wy2SDjgfHn5NE/e+eLAv/jzarCAzjtnCaCFWzM7cJBgU6l4/M+TTfpITa6gY9lnr4sU=
X-Gm-Gg: ASbGncvAM1TcSKXd5Ehjz/KiLPnUKBfGccXG/M5pvREq4qsbGC3/V5/JfLgL53VD2xv
	L4ZxCq736/tx5gcHAu6hPAdpQFrBTKGnvWehe1xh2i5fK+oUYbDnHPnqPIDd+xAkBZ/VE5ZZOAr
	A9XaScQUTAM7JFsUkzSFbKP2x4ZzabGClYqX8MGCWiwntIDwFrGZ9WUs2GI+glpFrjtCax/KjqM
	h1egQZKEu7D8ABlLEGaeYfthzobuwolOcheDTQ/e0R4usmP1WUE3eKZl0Ql45URP1KYbm9aDcob
	UFif2e8FEHvqeNjFZd825bv2lCTa2I5iVRxOXwT9Rp672ENM2cwPZ7uwr5E=
X-Google-Smtp-Source: AGHT+IFCLdkvsE31m7t8yD/6jqUG4uFt3i1KRw7QWyfZ/XoKsM8OV/p9H7+0x6GvFDE6MJKZsFDc+g==
X-Received: by 2002:a05:6a21:329e:b0:215:f656:6632 with SMTP id adf61e73a8af0-21fbd588616mr155465637.29.1749834610746;
        Fri, 13 Jun 2025 10:10:10 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7489008317csm1923000b3a.95.2025.06.13.10.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 10:10:10 -0700 (PDT)
Message-ID: <bd1458d3166ecac6bb88e15bf2fd69a3e47f18ea.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: support array presets in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 13 Jun 2025 10:10:08 -0700
In-Reply-To: <CAEf4BzYLGcKvFWTP1sOOSsJwyP54F2oFq0COKUaKeSg1zZb0+w@mail.gmail.com>
References: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
	 <20250610190840.1758122-3-mykyta.yatsenko5@gmail.com>
	 <4ff2fafb99131f599901580eac96dca34ca20cc0.camel@gmail.com>
	 <c1cb9bd3-c99d-4af3-bbcc-2ff3c2250ca1@gmail.com>
	 <8134154a25af0153411c263df923acd350253c25.camel@gmail.com>
	 <CAEf4BzahEMFWhFX_1AzYeKHY5FkVQiD5J8x69PrRUGhqNHyu6A@mail.gmail.com>
	 <cb96c155c563cd8998fb8c8683a4b53497b373cf.camel@gmail.com>
	 <CAEf4BzYLGcKvFWTP1sOOSsJwyP54F2oFq0COKUaKeSg1zZb0+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-13 at 09:59 -0700, Andrii Nakryiko wrote:
> On Fri, Jun 13, 2025 at 9:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Fri, 2025-06-13 at 09:34 -0700, Andrii Nakryiko wrote:
> > > On Wed, Jun 11, 2025 at 5:21=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >=20
> > > > What do you think about a more recursive representation for presets=
?
> > > > E.g. as follows:
> > > >=20
> > > >   struct rvalue {
> > > >     long long i; /* use find_enum_value() at parse time to avoid un=
ion */
> > > >   };
> > > >=20
> > > >   struct lvalue {
> > > >     enum { VAR, FIELD, ARRAY } type;
> > > >     union {
> > > >       struct {
> > > >         char *name;
> > > >       } var;
> > > >       struct {
> > > >         struct lvalue *base;
> > > >         char *name;
> > > >       } field;
> > > >       struct {
> > > >         struct lvalue *base;
> > > >         struct rvalue index;
> > > >       } array;
> > > >     };
> > > >   };
> > > >=20
> > > >   struct preset {
> > > >     struct lvalue *lv;
> > > >     struct rvalue rv;
> > > >   };
> > > >=20
> > > > It can handle matrices ("a[2][3]") and offset/type computation woul=
d
> > > > be a simple recursive function.
> > > >=20
> > >=20
> > > Why do we need recursion, though? All we should need is an array spec=
s
> > > of one of the following types:
> > >=20
> > >   a) field access by name
> > >     a.1) we might want to distinguish array field vs non-array field
> > > to better catch unintended user errors
> > >   b) indexing by immediate integer
> > >   c) indexing by symbolic enum name (or we can combine b and c,
> > > whatever works better).
> > >=20
> > > And that's all. And it will support multi-dimensional arrays.
> > >=20
> > > We then process this array one at a time. Each *step* itself might be
> > > recursive: finding a field by name in C struct is necessarily
> > > recursive due to anonymous embedded struct/union fields. But other
> > > than that, it's a simple sequential operation.
> > >=20
> > > So unless I'm missing something, let's not add data recursion if it's
> > > not needed.
> >=20
> > Recursive representation I simpler in a sense that you need only one
> > data type. W/o recursion you need to distinguish between container
> > data type that links to each constituent.
>=20
> So you have this tagged union of three different types some of which
> are self-referential (struct lvalue *). Is that what is simpler than
> an array of a similarly tagged union, but with no `struct lvalue *`
> recursive data pointers? How so?

The following:

  struct rvalue {
    long long i;
    const char *enum;
  };

  struct field_access {
    enum { FIELD, ARRAY } type;
    union {
      struct {
        char *name;
      } field;
      struct {
        struct rvalue index;
      } array;
    };
  };

  struct preset {
    struct field_access *atoms;
    int atoms_cnt;
    const char *var;
    struct rvalue rv;
  };

Is logically more complex data structure, because it has two levels
for expression computation: to compute single offset and to drive a
loop for offset accumulation.

> > Plus in a computation function you need to distinguish first step from
> > all others.  Recursive organization simplifies both data types and
> > computation function.
>=20
> Not sure I follow. You have two situations, and it doesn't matter
> whether it's a first or not first element. It's either lookup by field
> name or indexing using integer or enum. In the latter case we should
> have an active "current type" of array kind we are working with (so
> yes, we need error checking, but just like with a recursive approach).
>=20
> Maybe I'm slow, but I don't see how recursivity is making anything
> simpler, sorry.

