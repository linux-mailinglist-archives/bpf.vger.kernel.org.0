Return-Path: <bpf+bounces-60612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2EFAD9324
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 18:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51D11E0E14
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221B20A5E1;
	Fri, 13 Jun 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHiGqhIZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772715A87C
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833323; cv=none; b=KIaHsbma0+WUdhuj7Jsg1njw4cLkGSh6Tejxa/WxPMTP37O94HcL0d6nDgcRHHWAqOKW6rZR68PoF6RmS0AlanYvrb4ykVPbGG7vQaU7UL1QhqgZvRC3bhYmR0Qq+9UOb26LXlOq3siSSgry4BQ/F1ljhLzavx7IU2NXjWE/LjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833323; c=relaxed/simple;
	bh=nNh0g5oy2bnWjZ9Me3PfYDBA3GtkRHqnIg2mz/I3M+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XPVWk6f2qsghpM6rJT6vPvNYIHOuZrq95Tl/zvi4X4KSLYfFz/8r2R69dVSH7+zuLyAao5M9GPC/GOyhwG+SRjW2XwX3zSy67lEHVTSMC/iBI8m5ojFdpLkk1Fgqq1Vf/LGd/UTpCmQqva4iHES8NlRw2QNhgsOVAl5zbMcFdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHiGqhIZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74865da80c4so1534850b3a.3
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749833322; x=1750438122; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tpypLYpcEzcpnVMEM1AYmSJeFc8WLfb/txVDOZx43To=;
        b=VHiGqhIZvzCu8UHYRUbtthIV8FmFyME1BvDtQexfn3C2iB9e4ORZdZbx24ZpMKlqEI
         dqZwXGuhInyF5+8ct/JK/CbgZ9yU6l+cL9TqRZaAcS0UtJx3h1pNwcwlggZUAGbvca0Q
         Xl+es1i4UCyfxBYeQ4fAUPrZdjKNthAQ+8I4sNa+x/c4vBJZ7fJX1VWsUgxZ1LNVuEWD
         JFnw+vyN8LoNpI18fW8XLrmHN6H1Mfr77X8SQ6H46uG+NjbPAwUqT96TWfwgo0Sto07a
         JYwavhD0LPLT7oXPRH8ScDGNhAHM8OiktOcxLkdWhLZxZDYZ0UZntXBSqyJS3NZAVgfi
         E8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749833322; x=1750438122;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpypLYpcEzcpnVMEM1AYmSJeFc8WLfb/txVDOZx43To=;
        b=F32WpvYnQlNXxTw9gIUpylo1TLTSQ0j4m/gDgKcY8MqIVXhgrdQ0BmygTkEPxgRc2w
         tv4u/A1lJCSv9o0VCFeG44Exyt90mutl1A3ekf3f0xHP1zpfJPqMkyfHUWvuNWMOt5te
         DbDhNeW0zwJ9kU3TcfRhO/JOWn3BnUX65/1/0i6M01K6/2ma43Bntif7bLSyaI1ZMs9w
         BW7dHWWOtnsl31sSltqhSKu30tbPvJ2hb4iwfnIuwTmm9mcyXq/PJCbzIo/KtSOmb43f
         UBbruRwDlghq9yHsSEU4pWwYD2BGsgTpK/TOfVtEeC5jHql8H1O2QWsS9W2QznBoVkiQ
         JVrg==
X-Forwarded-Encrypted: i=1; AJvYcCW5JBhPjPDKm6O1dD0zrT5AST10EX8h9DtFkRmU8EDIq+afUA1mZeZZcfgvacNTIUyo/o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJk6iSXErLn3cJl3xXh0esVdxxuKeE4DFW93SPBiL/OrU0Rj9
	M//2kVKlH3r1svptwe6O6c5s1eoMrzLnW3eCbuGKOMRIhRy9noQB/u4U
X-Gm-Gg: ASbGncvybhmM4ljbSZeL5EYrkdcmSxDYib4stFmW9fYL81vm76ogSOl3sPPBh0++grr
	CuKinKaJdDrrRwphQ+YXu3lPMZOsiglchq301dfDn0a9tFQkpr7BptyPz4Txp/fhxwy/l7qDDLT
	TkUyKDqCn81o3BKRKQ0nbUbeq0+QH6SLS6/iNr7ewWBVLTYhNuzKhnScWxFnsChEqqdwYzSXbqn
	+aD2gGBpbQlQTv104ZPiq94DD7PTbcSo2a1MBIBj3mIhZ6LPk2nuctUmOrzefpueI7/48J0J2pF
	e4RBtPuXz3k+qIcLF1G1UIckCidfr5GjLCxbxV3lfdyQydBZMPcKiuiyask=
X-Google-Smtp-Source: AGHT+IFgJ1PAFlxrsdPCYXkOx9VQJr0J/6sCuVq5aKDbthORq6MSo0kr0Rj7ZEfrqXRc887Z4Yx9qg==
X-Received: by 2002:a05:6a00:b95:b0:740:9abe:4d94 with SMTP id d2e1a72fcca58-7489d00473bmr105491b3a.21.1749833321564;
        Fri, 13 Jun 2025 09:48:41 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b2c0esm1883469b3a.131.2025.06.13.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 09:48:41 -0700 (PDT)
Message-ID: <cb96c155c563cd8998fb8c8683a4b53497b373cf.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: support array presets in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 13 Jun 2025 09:48:38 -0700
In-Reply-To: <CAEf4BzahEMFWhFX_1AzYeKHY5FkVQiD5J8x69PrRUGhqNHyu6A@mail.gmail.com>
References: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
	 <20250610190840.1758122-3-mykyta.yatsenko5@gmail.com>
	 <4ff2fafb99131f599901580eac96dca34ca20cc0.camel@gmail.com>
	 <c1cb9bd3-c99d-4af3-bbcc-2ff3c2250ca1@gmail.com>
	 <8134154a25af0153411c263df923acd350253c25.camel@gmail.com>
	 <CAEf4BzahEMFWhFX_1AzYeKHY5FkVQiD5J8x69PrRUGhqNHyu6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-13 at 09:34 -0700, Andrii Nakryiko wrote:
> On Wed, Jun 11, 2025 at 5:21=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > What do you think about a more recursive representation for presets?
> > E.g. as follows:
> >=20
> >   struct rvalue {
> >     long long i; /* use find_enum_value() at parse time to avoid union =
*/
> >   };
> >=20
> >   struct lvalue {
> >     enum { VAR, FIELD, ARRAY } type;
> >     union {
> >       struct {
> >         char *name;
> >       } var;
> >       struct {
> >         struct lvalue *base;
> >         char *name;
> >       } field;
> >       struct {
> >         struct lvalue *base;
> >         struct rvalue index;
> >       } array;
> >     };
> >   };
> >=20
> >   struct preset {
> >     struct lvalue *lv;
> >     struct rvalue rv;
> >   };
> >=20
> > It can handle matrices ("a[2][3]") and offset/type computation would
> > be a simple recursive function.
> >=20
>=20
> Why do we need recursion, though? All we should need is an array specs
> of one of the following types:
>=20
>   a) field access by name
>     a.1) we might want to distinguish array field vs non-array field
> to better catch unintended user errors
>   b) indexing by immediate integer
>   c) indexing by symbolic enum name (or we can combine b and c,
> whatever works better).
>=20
> And that's all. And it will support multi-dimensional arrays.
>=20
> We then process this array one at a time. Each *step* itself might be
> recursive: finding a field by name in C struct is necessarily
> recursive due to anonymous embedded struct/union fields. But other
> than that, it's a simple sequential operation.
>=20
> So unless I'm missing something, let's not add data recursion if it's
> not needed.

Recursive representation I simpler in a sense that you need only one
data type. W/o recursion you need to distinguish between container
data type that links to each constituent.
Plus in a computation function you need to distinguish first step from
all others.  Recursive organization simplifies both data types and
computation function.

