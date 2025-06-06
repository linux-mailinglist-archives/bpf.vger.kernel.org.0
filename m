Return-Path: <bpf+bounces-59952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F694AD09AD
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346FD17A50F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6D22376EC;
	Fri,  6 Jun 2025 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWls2zw1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83A51A9B3D;
	Fri,  6 Jun 2025 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246242; cv=none; b=utuWhKX/WT4R5m2vuUHsicT290LVFackt7aeK+BcKV56VUAiqWdShE8OmD+537Ez0+7udBqK1c8rSvR7cwETwEwyYHQU9dyPxWSAakpkHs3S4zi8dO4VizM0/Q9T2vVcjz32rcEARligksFmNgSJ8Ob0R9n4N6DV5vwyoP70cHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246242; c=relaxed/simple;
	bh=XhbqZjCFiAW+LxaPQRtxPdm7SGHp04ijULDSqIGPCak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmAnVwUkGRHGqDSyj72y0QxdMcu3be1ET6SZ26xdF0QK1YQ3JgZvQ+KYV0NGzqnRV5DUEYZcGhfzP04TWGDrcmOQAtr2DLOvOG5cIXOzqRgVXeU98YZJjmPwtG0GfXMmwmI0tzHAL9XqLRHWwutHDrca2Cfg5OR0aSFQzZeFwqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWls2zw1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3134c67a173so1166980a91.1;
        Fri, 06 Jun 2025 14:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749246240; x=1749851040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgAHkyYsop8vJ98M0EPBu0lyAkiZjwBJ0ZQ13BHKBQI=;
        b=XWls2zw1zQVhcO+D78GoOwr16pYgWSW5QaP6U1ZhiYmmmE5Ayl7iM+IG6fXFGrm6PU
         RK6hFKjiYhczmfubBE2vfwTBnrhdIkBmZ/uJ4yH9tf+YoEAMW7BgIbMd6u8UsNM7eq38
         zx/sLsOgukXlsXiBYGyi9Xvjf7QBqrXbpfsIuMldrJPxixo3h/sbwqYYRuOvl5YaViTH
         cYVrXpGEV5I1Sm9li5ZCzbMPBEetNm76JlediRSATDRcpUYy2/Np7tMN7bpOyi6sy+OF
         u2XOW4E3ESwCR3nbQaR03+m4XncIKimpuCedCXjOJnUadBvMN9sUubWZTkocBYRV613K
         JStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246240; x=1749851040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgAHkyYsop8vJ98M0EPBu0lyAkiZjwBJ0ZQ13BHKBQI=;
        b=LytX294CYWno2vo2sUA7JieTmdI1BETlnERnAEJcU1MVvi4Po3cIj3UvqEtw9qN2ZO
         8XY4SGBv/vXt8BGqwTc008gBW6W4Umv16tarwr8ER9y742cKc9n6DrxGzDdBjneoLiqs
         xclyde6+iePZYZEh+pRdqtjy5dITvlUxM5iaxnaGnNIzqApf2O542XQCceNAu4RVJAAX
         b6oDdNwXB2dvCO1jDhQ0Lc0kR2hqe/lOtahf1ZFfm7QoEoX2Ao11bo57a8Dm+87usNaZ
         wX4su9wSwEXEg5Cu6yzXVbt4DpOV7f1LIQlolTKCJoKks3j71bsi0+lLtW355CzPmi5+
         GFqw==
X-Forwarded-Encrypted: i=1; AJvYcCUHX3xX3PMrf1SjktkQxsVQML1uNAJRtPs2H/nEiBw81IS8NWOrmcgXiw2WaFmBv4GW/VtJ89oGnyYvj88E@vger.kernel.org, AJvYcCWoSoIV6MpQhsrEU57y+j54FY+OX8tpZujMpqHNFya8SW7sJUims8JY9XadOl0RvrvBU90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPrJ84ytNzg0I8a0o7bmxIVWU7SC7zsgtYV4C+COux3ShdJdZ1
	NWsSiLwb8x8wTo5oGD6E8FpRL9XGTxGw8oMGxHcJgcU0c4gk4LLBLLwny454kmXLLEiD6zZnKAe
	ssk/c4+T0vjDkk412n+Ewl5WYKoF9rgYsPg==
X-Gm-Gg: ASbGncu8IxL12XWnNU7ze5n+X7ePLPLtLgyQ50re/OuKwkP8vl3hK3IS/dKTQsZr8yt
	3gF1aEEGX0OHfQiz3snldQUMpO6EVykYyq6ERP1p2nK7cn1uUyRrf3H26uvl/pgxZmOBHxdbKK+
	zdzcv9rPU0pkEJ97fEi5Mm4ix3UjsYbr8=
X-Google-Smtp-Source: AGHT+IHEwS/PnA5cIuVSoSJzlzQbV9cjpXeVWr1oeLbCoxykZaVIaKVn+8fpqNOcyMMA9Ktn6KrSsiQlH8Gl58T9BP8=
X-Received: by 2002:a17:90b:1646:b0:311:f05b:869a with SMTP id
 98e67ed59e1d1-313472eb280mr7066590a91.8.1749246239799; Fri, 06 Jun 2025
 14:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605181426.2845741-1-andrii@kernel.org> <CANiq72n0WYLBdBQCZqg04EcdTFG8RvL3fFo4bSeWAWGD1HFG3A@mail.gmail.com>
In-Reply-To: <CANiq72n0WYLBdBQCZqg04EcdTFG8RvL3fFo4bSeWAWGD1HFG3A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Jun 2025 14:43:46 -0700
X-Gm-Features: AX0GCFvdQkIxWG9_JuWoW-KDys1zvdY4BDUL5nT5V6JLvgMOmoJf-mekJ2VcpFs
Message-ID: <CAEf4BzaeyCfpg_aqs-mEYZ+JMXdeeUUaCBrJFh2TyOfBQqmNmw@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: ignore compile_commands.json globally
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, masahiroy@kernel.org, 
	ojeda@kernel.org, nathan@kernel.org, bpf@vger.kernel.org, 
	kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 12:41=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jun 5, 2025 at 8:14=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> >  # Clang's compilation database file
> > -/compile_commands.json
> > +compile_commands.json
>
> Should it be removed from `tools/power/cpupower/.gitignore` then?

yep, can do that in the same patch

>
> Thanks!
>
> Cheers,
> Miguel

