Return-Path: <bpf+bounces-60614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2F2AD9353
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 18:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3131722CE
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F75215179;
	Fri, 13 Jun 2025 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs9QcXjT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154822094
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833976; cv=none; b=SqcERVGlJIy0vfgorpZjdE0E4KyWHZp6RcOUNGxAcjE4UykrISevbXOJV4r9f8yGOYM48En9n3KtYlu2oWYSoVkKAPZunlW4lG/vOEuw2nCzNytpjcidtEmDFqNUpNmOer+zGeXs+R+SJh7Q9YULnXbiUtw39tmT3TOdIfaZHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833976; c=relaxed/simple;
	bh=/TE+723U9RAchilF9cQHtF9zfvGH07XkdfzxinWbXsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7Ra1D/gMSBwz1fclEwQtnTVaPSXmjxWhKPxYfmGXmbOeUOlcRm3anUoWajcOXDRg9EzB+/jlIpzz5ETLPGXMrgs+WJ/c73qYipee/EWi6aO0NCTfPHWOanVUIMDkaPA+DOzpmZJntA4V2v4sJfLU2OYKrd3XGsaA5bel9NiKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs9QcXjT; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74264d1832eso2548646b3a.0
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749833975; x=1750438775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+frXZbyskHr1l34Lwfh0kNYf+IbfubEyfvErvq3KCXM=;
        b=fs9QcXjTUad8XA/1j+3i1teX+HyCaRdKHWWDTpNiDMXdjP1zdA5dPmPhSvAKxUr+oW
         3YMKmAiZpT8/2bbgpherdGC0GiX58t9r3/XCdFN9nbD6c1aWYQ5v6ULJ8c6fl1hMxW66
         7i/vgm8wHgU6MrLxlrAxHwyoiwRE83PKf002FEaqq4aY2MGqqSjDJCk5JPUS4PcUinqg
         46O2CGjAxrCmG2NbnpUvuKw4DkL+y3u8y4xiBaIe0iftjQrJUd9c/8N7Zi7Zd8KzcIaK
         xglDjs58EmtSSoNkt9a55Y/4F3QWDPbffdJGB1X4Ebmp5kOff/pQG4Ra/Me3tPEg14+O
         i1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749833975; x=1750438775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+frXZbyskHr1l34Lwfh0kNYf+IbfubEyfvErvq3KCXM=;
        b=h0znvYTj04ttgQaXlCT2gIJ5fjooaja5CzCC92cQahyAhcGtxogOY7w9QxE5xouTcI
         FBD9f0Au9u+h0K0Wr1dCHILqz/HQmtiaBAraWuvrzhzLB/jUx5qtSLyZB1AupiJnDQ7i
         n+VvKXtMNeO9MtMwfE6xywQ8KSx8ZHj6BKHWyfwep9MAuQhxlIfB1c6zut8fLIA0Oxqh
         Y9wTwtSyMJ9S/mpg2WLBgNXMM8OYn9icZ2L+fWnk3NEqVS5pPbSO9TE4TnHvDsS38MrV
         +zris/xQ4weBtno0pFBX3S59eUgSH4zGAstO2ZLBXSsnztZjym+Ukx75UKFappl9+hss
         D+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWYXZLY7uBEHDz4A3XiGD8564lhSmQzkvGYC38xOc6/XpKu40V0NBPNKIddbf/co8ZfeSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzjUJVHwOmUZek470L3SU5hSybcAUrHtDxBSdlQ6RZpzJot/Zb
	UeNjMKxNiFOOuVXtaYFhTccEjJMXQ4PnzVTOG6tKCGAZH0esbeqTEwjDowPmPkfb0dsnu9euIyK
	bFpnSMB0hSEeUvOsJR0fpKqgST12Pc2g=
X-Gm-Gg: ASbGncvd2tkjd2vm0aNwxFFFsgpx9OJV/ce46hMILh7zs2RfUf23kp1mm11qGc36KvR
	HDSGvfywoWBIXMUW06Vlo9vqDO5xBrNKyPIWoaViYiBN3Idf5l1AMwwgTd6jo7zxLopBCzdkua0
	tDRlFC7mzQXnCMkZOnmyntFw1INRqE7lNNw5n03eh00tkE9EzDM19rVQpAP387xZXi2vxDdQ==
X-Google-Smtp-Source: AGHT+IENexR0wtc7+oY3xyYX7YuaRZuR1sSEU7NHwbOqhRqrNiTSJrJ1RyEu/sgPbrSWjx3VuTkZoyTgetyQqMvTxdM=
X-Received: by 2002:a05:6a21:9006:b0:215:efe1:a680 with SMTP id
 adf61e73a8af0-21fbd570eb4mr112263637.16.1749833974766; Fri, 13 Jun 2025
 09:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
 <20250610190840.1758122-3-mykyta.yatsenko5@gmail.com> <4ff2fafb99131f599901580eac96dca34ca20cc0.camel@gmail.com>
 <c1cb9bd3-c99d-4af3-bbcc-2ff3c2250ca1@gmail.com> <8134154a25af0153411c263df923acd350253c25.camel@gmail.com>
 <CAEf4BzahEMFWhFX_1AzYeKHY5FkVQiD5J8x69PrRUGhqNHyu6A@mail.gmail.com> <cb96c155c563cd8998fb8c8683a4b53497b373cf.camel@gmail.com>
In-Reply-To: <cb96c155c563cd8998fb8c8683a4b53497b373cf.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Jun 2025 09:59:22 -0700
X-Gm-Features: AX0GCFuKJY1HYa8TOGSxCLjfH_YSe8ntlNhVKZkPR-sWH4xIuA2Q9IZNr7NZz8Q
Message-ID: <CAEf4BzYLGcKvFWTP1sOOSsJwyP54F2oFq0COKUaKeSg1zZb0+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: support array presets in veristat
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 9:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-06-13 at 09:34 -0700, Andrii Nakryiko wrote:
> > On Wed, Jun 11, 2025 at 5:21=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > What do you think about a more recursive representation for presets?
> > > E.g. as follows:
> > >
> > >   struct rvalue {
> > >     long long i; /* use find_enum_value() at parse time to avoid unio=
n */
> > >   };
> > >
> > >   struct lvalue {
> > >     enum { VAR, FIELD, ARRAY } type;
> > >     union {
> > >       struct {
> > >         char *name;
> > >       } var;
> > >       struct {
> > >         struct lvalue *base;
> > >         char *name;
> > >       } field;
> > >       struct {
> > >         struct lvalue *base;
> > >         struct rvalue index;
> > >       } array;
> > >     };
> > >   };
> > >
> > >   struct preset {
> > >     struct lvalue *lv;
> > >     struct rvalue rv;
> > >   };
> > >
> > > It can handle matrices ("a[2][3]") and offset/type computation would
> > > be a simple recursive function.
> > >
> >
> > Why do we need recursion, though? All we should need is an array specs
> > of one of the following types:
> >
> >   a) field access by name
> >     a.1) we might want to distinguish array field vs non-array field
> > to better catch unintended user errors
> >   b) indexing by immediate integer
> >   c) indexing by symbolic enum name (or we can combine b and c,
> > whatever works better).
> >
> > And that's all. And it will support multi-dimensional arrays.
> >
> > We then process this array one at a time. Each *step* itself might be
> > recursive: finding a field by name in C struct is necessarily
> > recursive due to anonymous embedded struct/union fields. But other
> > than that, it's a simple sequential operation.
> >
> > So unless I'm missing something, let's not add data recursion if it's
> > not needed.
>
> Recursive representation I simpler in a sense that you need only one
> data type. W/o recursion you need to distinguish between container
> data type that links to each constituent.

So you have this tagged union of three different types some of which
are self-referential (struct lvalue *). Is that what is simpler than
an array of a similarly tagged union, but with no `struct lvalue *`
recursive data pointers? How so?

> Plus in a computation function you need to distinguish first step from
> all others.  Recursive organization simplifies both data types and
> computation function.

Not sure I follow. You have two situations, and it doesn't matter
whether it's a first or not first element. It's either lookup by field
name or indexing using integer or enum. In the latter case we should
have an active "current type" of array kind we are working with (so
yes, we need error checking, but just like with a recursive approach).

Maybe I'm slow, but I don't see how recursivity is making anything
simpler, sorry.

