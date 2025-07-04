Return-Path: <bpf+bounces-62430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD963AF9AC6
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D9648844A
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B31C1F4624;
	Fri,  4 Jul 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToBXx00I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6521F6A8D2
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751654009; cv=none; b=DUqfSl9oM4Ufs9H6FY/td/KDOW3BcuJtxTdSxgyZUDPWVp59dRLPFBLN77UVJcY/HI4u6oBIqcpUv8/KOwclUhfk/kJodW/ZgZYjgi7R+c1UCjQtgF4jyxM9CVGVKbebiuPaPSEHgJMkor5F4/fHas8L++XNMoCrEyPMb2IbQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751654009; c=relaxed/simple;
	bh=+WirPDzunrAUOnBkVyLv8ohCnrADIm1n1T9lGoC0Zh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WC3TBoC/7n6LxZNOUMGIuS0SV3i9Ce8fih353CSh8g2FT/ytT5uH1qkiYhjDjIdlzwQ2OStWWyPeM9eqtCKaFNKPoj5MtGLSH5Bq/+cakb4ct0icQy2nXxo0H33NPdZFgY0u6t0torOHro3JBVXXEUnnulL2kBzDwnOrJ8i7OsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToBXx00I; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2363616a1a6so10851265ad.3
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751654008; x=1752258808; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yB5knpxsoERCE5qq1ldFnvEX/4yrmyhbqGGQXlabg3Y=;
        b=ToBXx00IXQUnWlFsF5mjDDEctSzOvvIJd8MsHM8dh/OtmiSFUz61uPBf8bbW5LbIEb
         gWRjRva3crUv1rqQywVrNW7BaQc7rWz28vj8j31iLvTGx1NYiVILsprgJ4vnVV4iDwCX
         bY3qIxe6uJjgRdsQfR6rhfimHHfyXEw9/9RRWUVLn6RvKswB2SVEuvC2FidKibnxbgIT
         mhSRco1KHfdFJM6XnrqSdTyq/ctqNcKXBZ7f4LXsYsHHKRmhzO+3vP+kvNv4b64f+cwy
         0x7Izm80i9iDHg9nwQEkoYPwRGmjT+A5d85Xtx1IukVtEOf4oH+IHDkqkpgLP1qIJhNN
         M+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751654008; x=1752258808;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yB5knpxsoERCE5qq1ldFnvEX/4yrmyhbqGGQXlabg3Y=;
        b=AIKiZImzdM7pzspWUFiST7vNtpArLocH/I1Si8Jeufmb6XuFozMI35kjZcWawXikjY
         T+2t5lf1aD+zWU2ap1ItGLNx8FmsqNUpMCDBDMXf4vnyNHAo50K7WOf+c3OXMyPjX0x0
         YBmI2SBVGOfwjMGksKOnJRpo0DnaQV7HDE0jU1kKgEcpkBXD36sPuHuUUU7dAKLjwBA/
         9T14Sd8eTpvu6IY14NOuaTLu5ca+ub6FJ0tOxPfdqO0+4V3jMUGvSTHchYAaYmsiK6aM
         p7cW+XOsrkWOk3X1uGFy18YeT0MWypNWEutBmz+bLisIByUxs2LicMzGsqZcqfe0iwsX
         N33w==
X-Gm-Message-State: AOJu0YxEW/1emXJbKnHmcx4cCPMih9oGOEGKyMN/7eaZYTqo4XOR/Bzh
	zcKOf1nLZ7t8BqZCy+C4CWFoj1EQavjfF2oiLOcBnsa/uOOCgw927Ut+
X-Gm-Gg: ASbGncvPKHqgut6I5oFbbR3plb2u55wcPCD1PJ+Y4zlD/RTkbEREIbtdhQbSLpnal00
	KkfPbp7IuF1oUnDZ1UXYEQP6kt4iyEpYWBNK5RiqnypZH8f8GzAF6j0m97dYnNVezKlzvKEgm6p
	Pb3I/Gx5P2704xG9ABT260OHp4e2nKpnofsoVFEBNakJEDEeSwZt+ZYzff7WlOXHfMZpMlwQHHR
	Kg+kmFRerTCZCl/fTDS2IClEt9MoYUcILKOMrPdq5c5S7auYlpZBCXQTH9UOMevie5QZp5akFM+
	7FE0z81ob8y66bZDdf68zwEQhunVpebe8LLJIYl1Kjly/fE7pMsEX/xHNQ==
X-Google-Smtp-Source: AGHT+IFsfo193SlTFoPtLKuNqM+CkuxkdqFDL5hCwsUFviYwygwTH4a8Fbn/D0IgdoDCE749wouDWg==
X-Received: by 2002:a17:90b:2ed0:b0:311:f30b:c21 with SMTP id 98e67ed59e1d1-31aadd9fd46mr3792223a91.26.1751654007580;
        Fri, 04 Jul 2025 11:33:27 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845bce1csm23908785ad.239.2025.07.04.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 11:33:27 -0700 (PDT)
Message-ID: <de7f3a2c5bc521c1111b0ed1870291c0889e4757.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for
 global function parameters
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 04 Jul 2025 11:33:25 -0700
In-Reply-To: <fb5b8613584dbce72359e44ef3974e4cb7c8298e.camel@gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
		 <20250702224209.3300396-5-eddyz87@gmail.com>
		 <CAP01T74AYNX5ARJ5YXryUyKvn5o0Dv0JBoq3CCKcD8rh==uKQA@mail.gmail.com>
	 <fb5b8613584dbce72359e44ef3974e4cb7c8298e.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-04 at 11:28 -0700, Eduard Zingerman wrote:
> On Fri, 2025-07-04 at 20:03 +0200, Kumar Kartikeya Dwivedi wrote:
>=20
> [...]
>=20
> > > @@ -7818,6 +7821,22 @@ int btf_prepare_func_args(struct bpf_verifier_=
env *env, int subprog)
> > >                         sub->args[i].btf_id =3D kern_type_id;
> > >                         continue;
> > >                 }
> > > +               if (tags & ARG_TAG_UNTRUSTED) {
> > > +                       int kern_type_id;
> > > +
> > > +                       if (tags & ~ARG_TAG_UNTRUSTED) {
> > > +                               bpf_log(log, "arg#%d untrusted cannot=
 be combined with any other tags\n", i);
> > > +                               return -EINVAL;
> > > +                       }
> > > +
> > > +                       kern_type_id =3D btf_get_ptr_to_btf_id(log, i=
, btf, t);
> >=20
> > So while this makes sense for trusted, I think for untrusted, we
> > should allow types in program BTF as well.
> > This is one of the things I think lacks in bpf_rdonly_cast as well, to
> > be able to cast to types in program BTF.
> > Say you want to reinterpret some kernel memory into your own type and
> > access it using a struct in the program which is a different type.
> > I think it makes sense to make this work.
>=20
> Hi Kumar,
>=20
> Thank you for the review.
> Allowing local program BTF makes sense to me.
> I assume we should first search in kernel BTF and fallback to program
> BTF if nothing found. This way verifier might catch a program
> accessing kernel data structure but having wrong assumptions about
> field offsets (not using CO-RE). On the other hand, this might get
> confusing if there is an accidental conflict between kernel data
> structure name and program local data structure name.

Maybe just add __arg_untrusted_local and avoid ambiguity?

[...]

