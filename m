Return-Path: <bpf+bounces-59777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EEDACF4E2
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 19:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33B53ADD08
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA29272E66;
	Thu,  5 Jun 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZnD7PcK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4E1DFF8
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142869; cv=none; b=LgbVabzAy25SG7gNTx1zVtwumvLczAfoLrscCHLzvN+gjIeC8L5HsK5CpKZoRaJIrMtBHLnd9fUCsIrr6GNtMgVI8k7KQfEp3x9H65hnKITDi9WROMuoKO6YbzquFu6mAtghmQls0rw4Rd4XWlPmb5s7paGyZ/SlX5pAywvspmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142869; c=relaxed/simple;
	bh=bhSpjtDvofa69iO3muV9Sqz919U6IVhOAOVU89DBysU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IF4ZHCW5FOlBFa0DLQRYCtljI/5VKNkamRY/xRS/44Z/0BBwleqzWeUmE4N+O3eBUfQ5C5N3ZenX9yJGnAEhmVinyFaV03gWVVIt1XtOOEd01a9J/eFi6gZXFL8vZ8V7ShmyrO1pAU/hWVdgHATZrQYk9rFRnb4573ALq9j8kDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZnD7PcK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so1536827f8f.0
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749142866; x=1749747666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rm1IDjMG2a/nDPiZIGnxLY/VKng+14MmejeNrOg0/sY=;
        b=OZnD7PcK8ZC50UlPcjlO8Ct6uUzFfVUD5OBBO80fuQaA9N+I/WAnDUs2H114PCPYAn
         GdYF0bVeGHQ8AdNdKH9Nd4qe83blTePtPPSUgpV56LY8XCO48z10qkB5XcSj0XItIdxA
         oHKBEofuSCG13hDBnzbRj/5A9LS1yaEFyMYxkTCeS7yxH+umy4sBb/PP8aNrneWOU+/E
         kDrt3Z8L2hrD+lj1hqxVJNVUKqk8gyZ64OZVn7N3jAfRoXTecfGZ7nPmzuUR6c9s8FId
         lmRGwdsWVobbGw4xWDo1R8rhVxhYWH0NNnqSjrwkLTFmMIQGN3XKy8RwiPDYA2l5+pnZ
         H2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142866; x=1749747666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rm1IDjMG2a/nDPiZIGnxLY/VKng+14MmejeNrOg0/sY=;
        b=lf1WMpDPE0KRAkL0RWFKMAhKoJEk//Wr5HiDdw/qaqjyoxJ1y52aB0qabPdJZPjrxh
         D5cqU1ZP0KRcBbq/U4+/1yVDaujrVL4pliAIEXwY6V442JENzan+GwCZG4XtgkXuiYov
         qr31FnnmLiPjx4Ohci969axjICxM8ce5CC7OlNMBolfUPiwdenLYdnYLf2UqPjQFkFPk
         dbd2SC4Wmxcl8JJw7veZYnb6xs2FZrCK5641m2kROlN53Yq54j06nh6PvjyIJFo9mMjT
         PAbzENsfQQg4txFe7JAoMCywc6dqE6xP7DGbC/fukHO1qKs8YfjXzL6bGgXUDoraME9g
         jwJg==
X-Forwarded-Encrypted: i=1; AJvYcCUMSJvIwg1R5j7XYaYiVOlM+fLEgB8DUCu7XoU+686RMtp93sAenikVmgnTm2iS2zvTKfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5AZVWtGt0XcxC/5H0wyFF8bp072kiL5zrJfq7vzGAS4m8GTgz
	lptDHklnuPC83x1zQFZ6T4AgFGe4RFSjmVL703o0C3A5T179oaMUQTAajIr5Tcc4eWfI1QBkGMl
	+Lfi/207pINNSmnKTfUbRYI6AVOohd4mnIvZR
X-Gm-Gg: ASbGncu04rlSrWDG/e/WxZluxBzwwQ61I/Iog1GG3RqVqLo7h7KVIEeZnJkZPjDYS5O
	ld+yKYn0HOcBrMDchyLRyHVZBgndfXOvRUEFfTFNedbtw4k29hoNG1nxmugrlx2g+MeHIMw7THi
	MNLEQesmWS+JRYVynzgAJfvAqwQq0gLN1DmzqUzprsc+W1H1Oa
X-Google-Smtp-Source: AGHT+IHd9Am/Y/3DdM1P647Bz2MDs5EGZjMrtTtQRmMF4F9J3TRbMDAOjjly/6wqZsunDv6qclP4r4AsYypCWylz8nE=
X-Received: by 2002:a05:6000:1882:b0:3a4:f7dd:6fad with SMTP id
 ffacd0b85a97d-3a526df416bmr4645826f8f.14.1749142865482; Thu, 05 Jun 2025
 10:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604222729.3351946-1-isolodrai@meta.com> <20250604222729.3351946-3-isolodrai@meta.com>
 <CAEf4Bzae53DDPQYUwOC2w=LO1yxPMU2=vDoS7=rCSv1BkcsJ5A@mail.gmail.com> <8df5f5d4-cafe-477b-b0cf-7c86117f21cd@linux.dev>
In-Reply-To: <8df5f5d4-cafe-477b-b0cf-7c86117f21cd@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Jun 2025 10:00:53 -0700
X-Gm-Features: AX0GCFsoY3clEk7VnBV3gv3136p3f_6Kytm-BsMlPAbrz8NCtjUFtGIu8vOebYU
Message-ID: <CAADnVQJ-sxOEdzy7OktZrTUDxk7Rw7H3zCt_u+iM987zTTDksw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: add test cases with
 CONST_PTR_TO_MAP null checks
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 9:42=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 6/5/25 9:24 AM, Andrii Nakryiko wrote:
> > On Wed, Jun 4, 2025 at 3:28=E2=80=AFPM Ihor Solodrai <isolodrai@meta.co=
m> wrote:
> >>
> >> A test requires the following to happen:
> >>    * CONST_PTR_TO_MAP value is put on the stack
> >>    * then this value is checked for null
> >>    * the code in the null branch fails verification
> >>
> >> I was able to achieve this by using a stack allocated array of maps,
> >> populated with values from a global map. This is the first test case:
> >> map_ptr_is_never_null.
> >>
> >> The second test case (map_ptr_is_never_null_rb) involves an array of
> >> ringbufs and attempts to recreate a common coding pattern [1].
> >>
> >> [1] https://lore.kernel.org/bpf/CAEf4BzZNU0gX_sQ8k8JaLe1e+Veth3Rk=3D4x=
7MDhv=3DhQxvO8EDw@mail.gmail.com/
> >>
> >> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> >> ---
> >>   .../selftests/bpf/progs/verifier_map_in_map.c | 77 +++++++++++++++++=
++
> >>   1 file changed, 77 insertions(+)
> >>
> >
> > LGTM overall
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> >> diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b=
/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
> >> index 7d088ba99ea5..1dd5c6902c53 100644
> >> --- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
> >> +++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
> >> @@ -139,4 +139,81 @@ __naked void on_the_inner_map_pointer(void)
> >>          : __clobber_all);
> >>   }
> >>
> >> +SEC("socket")
> >> +int map_ptr_is_never_null(void *ctx)
> >> +{
> >> +       struct bpf_map *maps[2] =3D { 0 };
> >> +       struct bpf_map *map =3D NULL;
> >> +       int __attribute__((aligned(8))) key =3D 0;
> >
> > aligned(8) makes any difference?
>
> Yes. If not aligned (explicitly or by accident), verification fails
> with "math between fp pointer and register with unbounded min value is
> not allowed" at maps[key]. See the log below.

It's not clear to me why "aligned" changes code gen,
but let's not rely on it.
Try 'unsigned int key' instead.
Also note that &key part pessimizes the code.
Do for (...; i < 2; i++) {u32 key =3D i; &key }
instead.

