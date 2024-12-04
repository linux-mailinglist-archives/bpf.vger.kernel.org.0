Return-Path: <bpf+bounces-46112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B59E4612
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 21:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7EF169D0B
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 20:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C83518FC92;
	Wed,  4 Dec 2024 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtpEh4aq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2854517335C
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733345351; cv=none; b=rTIYfkcCUFc7bZ47L2+V6ysBvp0y673S+FGVvZmQ3rcn+Wy2x3sTRbDqSbOon5U68glkfp9jUOiuwat2OUjdlzYQfstYszdYk5BI97pypNpJWywsB3GE+lam0nWsGQEMsX1AxcL6kwFsL51K4+gFLYjrktWGOUyx0b9oa+vSu10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733345351; c=relaxed/simple;
	bh=t422z662QJ2cB2ZRw93mdlTV4D+nRLCmEN7e5AehpYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7IkwNCGqNLBZ31F8QH9SjmK/UXVfFNy76nJl0NfW/uE6XfoKyVqtTHHU2uIMjvtuv8jxuU0IND0g66xbXbxYgpXCulQylBkSQx06trv/FgsAz8UoeD6ETSOOUSyyITm+p+CUL3QPwTSdbXg25RpuoRWcZ7O5T51CgW4HDSJ64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtpEh4aq; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so152908a12.1
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 12:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733345348; x=1733950148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQYPX1beXj3cLnKIDe4psoN5XJnvZKKESGjb1gE9+68=;
        b=XtpEh4aqze7I4YGp8ODsFbU3zbDCGCayeAp2dRdcprR2ngPkZqD6xpn3cDrBXVP4ag
         oIlpiYKIaiDvLNsGw3pOcHwPrSkmdrkYlRKztC/AmCsH0uaGfxjktkdXdvAfXmqNJuet
         QWcx5ktcrk9i0bAjY5z/fdw/+LkC9cHT9wja84/UAK/yuY0SUVPsFOLyuiY0MUWsL3cq
         bJ6LRH/V2Cu9AMJ2i7Q1UfNYZakcUsk92Ny8UUtSbq12Mr70rnwgGQJ9XC9izMswR4yT
         b7kj88mw4yDOj/JywrNnKGC8g+Nn1/o2AOEXuDvNsjq/k/X8ZeeDpxPInyol4Q5TzNXk
         ywRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733345348; x=1733950148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQYPX1beXj3cLnKIDe4psoN5XJnvZKKESGjb1gE9+68=;
        b=fUOlabDjZoKhF5atE7OKiPgOntWwDf54QJON7CY6zMA54Y0nPuM2q3h0NP0eXTmvLD
         b4fkgG2BYEOnm//n0DCZjL6GF8XbbywtJOTo6XUQw5YnILyVNCjnTwL6qxvQ/jaaZmKA
         62lwnAWSz47L2Zy/8YkelBUa5wfXAQRKy3FfkVL/nySKkjfI9sZIT9PkOmtknsJ2jsbi
         C7sT7mU/Urq9Dl9e8rxTMpTJlVfd759pS0Zy5vv69o4P6GmimKdVU9cHnQtyFO+W9XH1
         HOfKnguP9ziJeIvEI+Xpo1ZEhPXl/R7UYbAFWKj2afNsgOGatU+v1FyQt8UzvbHJdOPG
         Q4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUJRjKcHabaso1Z6bLXOdhBk6Q4LexZV5d+J7epjGBQ8DO8je7+uhaKs/zDyE5y6mU39sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPRpKA1MdWNW8NvbssjQuHl2lelnA9OM+lmYOTEktjW1dPt2wW
	neUlvj5mXOpMAQnJanJ9VA2jvCmsDu2J37G+iFALSHKDeRb5FImW309Nvbo5sis2cepYXeEQLIx
	4J4zIRvgoR7B46dwV8k+XokPq+VM=
X-Gm-Gg: ASbGncunBS2SKMw5rMsUFDvshOu8AoHGOJh4vGRyDStB4e1h52A+Qlv4gaaK/jWyUEr
	8h/xELdNBSr/RM5i0k3VfapF1x9aoauV2WqDLW+tLcGSak/ZKXWNP9mJdl8Mv+XS6
X-Google-Smtp-Source: AGHT+IGTmFDov8OviZkeD8YqLVLsD+nCaBy3Hg1plrlAFUdwiDFH8kXeQ+WS9O5hvblzV4Hu3zZaXLBc4ohI1WgTfH0=
X-Received: by 2002:a05:6402:42c3:b0:5d0:cd85:a0fe with SMTP id
 4fb4d7f45d1cf-5d10cb8268bmr7136566a12.25.1733345348412; Wed, 04 Dec 2024
 12:49:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204024154.21386-1-memxor@gmail.com> <20241204024154.21386-3-memxor@gmail.com>
 <f844604cb8f85688c9faf4bf0c6d5566eba5dcdb.camel@gmail.com>
 <CAP01T77v3ctFfT37iOfMm0XOqOD_bzfYuLcjnvT=JeokCZ=2BQ@mail.gmail.com>
 <CAP01T770rUveB4Toj_gU7Fy-SyyTr0EvaCBDTxdkGBz2bBBAzw@mail.gmail.com> <CAADnVQLa7ArR0ZSi_zERZxWCCvi6u6TdmOpfkveuRo_EwGqsQA@mail.gmail.com>
In-Reply-To: <CAADnVQLa7ArR0ZSi_zERZxWCCvi6u6TdmOpfkveuRo_EwGqsQA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 4 Dec 2024 21:48:32 +0100
Message-ID: <CAP01T77F4yoJYJ3CZ-zypGUSCCApsS2iGQ-EZiO2Pk0sw2e0Mg@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add raw_tp tests for
 PTR_MAYBE_NULL marking
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Manu Bretelle <chantra@meta.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Dec 2024 at 21:40, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 4, 2024 at 12:22=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Wed, 4 Dec 2024 at 21:19, Kumar Kartikeya Dwivedi <memxor@gmail.com>=
 wrote:
> > >
> > > On Wed, 4 Dec 2024 at 21:12, Eduard Zingerman <eddyz87@gmail.com> wro=
te:
> > > >
> > > > On Tue, 2024-12-03 at 18:41 -0800, Kumar Kartikeya Dwivedi wrote:
> > > >
> > > > [...]
> > > >
> > > > > +/* r2 with offset is checked, which marks r1 with off=3D0 as non=
-NULL */
> > > > > +SEC("tp_btf/bpf_testmod_test_raw_tp_null")
> > > > > +__failure
> > > > > +__msg("3: (07) r2 +=3D 8                       ; R2_w=3Dtrusted_=
ptr_or_null_sk_buff(id=3D1,off=3D8)")
> > > > > +__msg("4: (15) if r2 =3D=3D 0x0 goto pc+2        ; R2_w=3Dtruste=
d_ptr_or_null_sk_buff(id=3D2,off=3D8)")
> > > > > +__msg("5: (bf) r1 =3D r1                       ; R1_w=3Dtrusted_=
ptr_sk_buff()")
> > > >
> > > > This looks like a bug.
> > > > 'r1 !=3D 0' does not follow from 'r2 =3D=3D r1 + 8 and r2 !=3D 0'.
> > > >
> > >
> > > Hmm, yes, it's broken.
> > > I am realizing where we do it now will walk r1 first and we'll not se=
e
> > > r2 off !=3D 0 until after we mark it already.
> > > I guess we need to do the check sooner outside this function in
> > > mark_ptr_or_null_regs.
> > > There we have the register being operated on, so if off !=3D 0 we don=
't
> > > walk all regs in state.
> >
> > What this will do in both cases::
> > First, avoid walking states when off !=3D 0, and reset id.
> > If off =3D=3D 0, go inside mark_ptr_or_null_reg and walk all regs, and
> > remove marks for those with off !=3D 0.
>
> That's getting intrusive.
> How about we reset id=3D0 in adjust_ptr_min_max_vals()
> right after we suppressed "null-check it first" message for raw_tp-s.
>
> That will address the issue as well, right?

Yes (minor detail, it needs to be reset to a new id, otherwise we have
warn on maybe_null set but !reg->id, but the idea is the same).
Let's see what Eduard thinks and then I can give it a go.

