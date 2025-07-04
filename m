Return-Path: <bpf+bounces-62442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FE3AF9BA5
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 22:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1937AB3B2
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4235E231CB0;
	Fri,  4 Jul 2025 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROGHUQGN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2691FE461
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660496; cv=none; b=CVsqwgxsbHtjU7xXaNL/ZYT6ecJK+T1kLQaJ5Fikp2SXGJPCwlxtO1auxfRQXK+yeHSUpbXgU1+yPD++1Q9fFELAeZbWkwbzUy9eU/cY7/FzgtWvDS25S1YbDWhnfKAr5pPRY0qtjuhQo1PdwmO34D11hiiAqdNxNBHRid04CUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660496; c=relaxed/simple;
	bh=05j8NHarcTWG5EIQe639Cf/fAYA2Oox5Hlgu02VMAC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcn6ubExA73XwFoY+jH/IJedCBACyJ2Ez5xR/rIQx1FO3apkSpEADsbKf3QF5QBS+06XWeEdGI/SURhYSX+mUfl4jYlFnw+fWXjKatrTq2HFoWrJFS8qMYPXdHIZBUcv1hUwguenKNuOEmA+By0dkTIbFVvZ8Ck5c3+FJScEVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROGHUQGN; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso213440166b.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751660493; x=1752265293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05j8NHarcTWG5EIQe639Cf/fAYA2Oox5Hlgu02VMAC4=;
        b=ROGHUQGNGVf/tRXO5jh75wqObA5V99hw9Wx1lsMZEHQEtJjYllAyNxBLpXVP0a//gp
         XI5Sm/jDQw5ByuCK8K2dWiFhM/CkMnShyRiwaKHqOAzd4OxEtlXJ0kUBXPDLWtGx0ud0
         nbA8gYcgU9PnmKseozuGjix3MpleSKhaoEL4Rgp8OH/1YeCWW1CarGC5Yyt6o4cEk4pX
         Hkvtwt3whsm2FquVpJUlTTIq3ASneWBQxE2r5sO1yqxpil9cz3WcNnPY5dwOnjN1aVbm
         jHd8G8XlqND6/3kFtGXJ3p1sJe2HAtJaD/vvkmQY5sufPhKVArFhGQb3vS2cr+e7n6YV
         JlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751660493; x=1752265293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05j8NHarcTWG5EIQe639Cf/fAYA2Oox5Hlgu02VMAC4=;
        b=vYWtyDOkNk02tBi0yT0vocYc0a/U2qRxJKPrAqp3jj/jfQOiE4Eih4be5pVA94qPZe
         dJ0UPPFyrFjc+6vAIQry1jaT682BCjL9uTDmbk0CYkpeexkbGEtIUUwvdmgGHaZYLoA+
         m3u7o4AcQuU8Utqa/8RJnnlhEf0YaIdklsacx/XahiJpLSCqVKcxHC9noVQiFemJF/wG
         bycJfGaxhxGpzq8A63ixdNrbYyB6wzGdqt7tVX9xqsz5g7sscD7BFD+ovnip22fNiICK
         Q0d1+uQL/A717G4sMFN1BfnyAhRj+NKu30YcJ1zNEAdntbbobNA7VZn2aRFSjlvPcCXV
         DHJw==
X-Forwarded-Encrypted: i=1; AJvYcCXx8KDtGFQyirYZFvsx+5M5Y9YB/GC7sxg0Oa7KDjh28O6sQdTKS05jOO7SLk/kENBgpXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMWXA8wExd36h/fQAYflFrcN8bFWKhJnzvdDj2CU7gtShgi8U
	7cOVHoX9yY5Nby33gOyEzSfSND0TJ75Wu98Oysow1836XTTSypPBwNwBG6cJch0XVsr9b1e4kdJ
	6Wv3ZhAnsPuntJYcWUAffoQiPRxAKg34=
X-Gm-Gg: ASbGncuyCNm3xq4KeU2o7SgX7RWJJp7eK1hqHESgi41XVx1GtmtizA9rC2V0JlAv0j6
	hmjU/UPH+vmlrmh2EAsbrWiZGbnacbWBxpKYRK/PW8j3dyzh4kjh6m1ss8hAfAbuWm2UAq+8KiY
	2QPukBatfwnNSV7I/4gnK64qd3izUim1KtuiO2wDKhpM+iFncICbTQRpO3CV5/pe1/bOaTH4fL5
	t4=
X-Google-Smtp-Source: AGHT+IG//CXMloF3QVSh/5Zka4ChSvO1dahyUYTuwmZIEoui1799nbUe5yW73XVO0tYnOarjWznTjUJCjUiFbbvNSzQ=
X-Received: by 2002:a17:906:b852:b0:ad8:a512:a9fc with SMTP id
 a640c23a62f3a-ae3fe5cb14fmr265529966b.42.1751660493200; Fri, 04 Jul 2025
 13:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-5-eddyz87@gmail.com>
 <CAP01T74AYNX5ARJ5YXryUyKvn5o0Dv0JBoq3CCKcD8rh==uKQA@mail.gmail.com>
 <fb5b8613584dbce72359e44ef3974e4cb7c8298e.camel@gmail.com>
 <de7f3a2c5bc521c1111b0ed1870291c0889e4757.camel@gmail.com>
 <CAP01T75+cXUv4Je+bYQNb-Us_MF1s1Zc9fL0wmowLExKUQ8KNg@mail.gmail.com>
 <a8f522a0e9eaf060727b7782d700f998efaa757c.camel@gmail.com>
 <CAP01T74_diwrEB0D=LOqVGQTGjiETm65cqh3zZEL5S5EkTYaZQ@mail.gmail.com>
 <e5acf74c70f6aa01ca7be4c0afce9dd6a20a910e.camel@gmail.com> <CAADnVQKh9pAaAcJp_bSFjz5=K-6XPgb_Jdo8yhv3VYQhb-6=xA@mail.gmail.com>
In-Reply-To: <CAADnVQKh9pAaAcJp_bSFjz5=K-6XPgb_Jdo8yhv3VYQhb-6=xA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 4 Jul 2025 22:20:56 +0200
X-Gm-Features: Ac12FXwt0fjGuTqbjz8xl2irRcF9x5cQ-6RyKsJLhyLeJdLan8W5D9NfCFLTnjE
Message-ID: <CAP01T76tXJVMk_Yy1USRNity5rA=DXe9BgS7OOa0G960UsVPcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for global
 function parameters
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Jul 2025 at 22:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 4, 2025 at 12:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Fri, 2025-07-04 at 21:15 +0200, Kumar Kartikeya Dwivedi wrote:
> >
> > [...]
> >
> > > Yeah, so if the user specifies a type and has co-re enabled, they're
> > > accessing a kernel struct.
> > > If they're doing it without co-re, it's broken today already, or they
> > > know the struct is fixed in layout somehow so it's ok.
> > > If not, they want to access things at fixed offsets. So we can just
> > > use the type they're using to model untrusted derefs.
> > >
> > > So always using prog BTF makes sense to me.
> >
> > Ok, I'm switching to always using prog BTF.
>
> Hold on. The concept of ptr_to_btf_id|untrusted that points to
> prog type doesn't exist today. We should be careful when introducing
> such things.
> I prefer to keep btf_get_ptr_to_btf_id() in this patch
> and think through untrusted|ptr_to prog type later,
> since the use case of untrusted local type doesn't quite resonate with me=
.

Yeah, we can add it separately from this set, but otherwise I don't
see the problem with the idea.
There is no reason to restrict ourselves to kernel types.
All accesses will be untrusted, it's like probe_read so it should be
well-formed for any type.
It's the same reason why pointers to non-struct makes sense. Ideally
any type should be allowed.

Otherwise to reconstruct a walk of untrusted pointer chains the user
will do it by hand.
Showing the structure types to the verifier allows it to be inserted
automatically.

> Currently we only have mem_alloc|ptr_to prog type which is
> read/write and came from obj_new, rbtree, link lists.
> Untrusted =3D=3D readonly for prog type is quite odd.

