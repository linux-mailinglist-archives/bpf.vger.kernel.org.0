Return-Path: <bpf+bounces-45812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 164819DB236
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 05:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64AF166821
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8613B139566;
	Thu, 28 Nov 2024 04:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dd6Dsno/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4313322B
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 04:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732768625; cv=none; b=H/X9NZd54snCfH0nndQtz2RtXWSwwX0AwdFs05tZjqntE+CHgMv1y68t8F9F1o8tHTOX0Kmamk716eIaowL7JEYn9NTGaubdzuKawbsRRgHkEexgCUB3KvQ7UTvPeaddo9atWn1nEQyBR/U/vWUKcMwHaUXOzF0Xg3lFyv7jQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732768625; c=relaxed/simple;
	bh=rgGuABirzAojH45Nh5L/KO5Ru/1MaW/EYghcJUopYpE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pdhllN/6sx4MRzmLrylLZBYf/C5lEAoiC9ei/UIbvrZE5cssayOF4MfKzEfPOmehgyGT9NixFLubKitTfzeNm0B5+f4yxpnyJPMSGN1L3bLEOQ/vEERjfI9FFEd7xQld90H5PbXZXOtlzP7OEcIMfuHDlPFvfe6xLr1VEBNKrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dd6Dsno/; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ea47651a10so249502b6e.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 20:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732768622; x=1733373422; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VCcbrUMuFu/IiRYM3gDJJjmJHWHp8vPpOVGLKarqlG8=;
        b=Dd6Dsno/ZzG+x71DtfOt7gO9PbJHWMpIdVkn2n4wiYEb2Cy767nM/CBgPbEgyBwWXF
         aGOYzfG8YKaebOVUaR8i5KMc/g+nH0InrtXuVlutcGb7tCfyxmXols6A0AaXsdmooLNW
         OIFOz5RKo9RaZQgmHYeICMtEUSclN/cC0SE/tlYCcSeuWohLLfUTV8fmulQBIfsulZJl
         b78Ga5Wfkhqcr2l3eOGh5UIgIPiZvdYizUAERLF1DEwAaClmqvPD6wAiilM/znEd7Snc
         rA6sMNLxyh0uk2OzX5z1OCMy1LnsGc1VB3Y5jdqo0NLCOg4MvqDz8x5I7G7xvLmYDOCb
         PP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732768622; x=1733373422;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCcbrUMuFu/IiRYM3gDJJjmJHWHp8vPpOVGLKarqlG8=;
        b=RZ95Xoo2tksjzCZivpyQJIBXt4zDdoCA7wl+FBDuAhjSMYbfSZhhqQfavE1Lihye8B
         7hRh297PivWq8RB9yfy8/+unMM7rshOMQPigtorw7/xZopC7gv42i18xR3x8cksSK0E3
         Za5FtHgBPm574WCruF59as5fwFRyT55s06tjr9CjMpVPE/GHNSpeSOXPW6isC/QJdkJC
         nEb7lO57rdwD/jlL+Gwi2cR1RfX5ndVzgd9BrnigGRvGxxSUgkp5BbrGpcJKozPZPSw8
         USzQzp7aMCHwt++VSSEw7JffHhaAcBq+5E2NZbSZt8va8rQSB8y0Ql0ic5w0+eO48Kht
         nK3Q==
X-Gm-Message-State: AOJu0YyU0Nq/GVNowRZHDLAq3aiTU69KO29olUC7R5vCexfIlVlfG1+T
	SrkYjvHiP/7Od8yq4iuUo70QxaVsOj5o9+9tTp+29uW9jH9MV2Wy
X-Gm-Gg: ASbGncuYXb0gjWLdXCEFugeqRZqOPGP7HCc7Kqa0xBLzrGUrIGqQ9ZJ2U3VU+hlMaMa
	Fk+xUyAGkPLgCTIW0rONQsrXOYe5k7hLBOhpNi7iq3Ih8gMEb0REx0nIJTZKXbGEnxgo3edGJFZ
	AEmoOAdAVDgn+LidtBowTXFx1CGj7GZEz+kYBn5mp70sPOXoVlSZ+HzxiN4z82+lzxW5qh8tOSy
	MQ5dbxRjCmz4Wp5yo0Yp6k4btlYqSmUkD/n+qywaEJtlMY=
X-Google-Smtp-Source: AGHT+IFdriVSUl3X30dTW9mypGuzEmAizPRXjrDjNYvTy76882wTPMq+hKGP1oS+J++5Ag00hIk0Lg==
X-Received: by 2002:a05:6808:6414:b0:3ea:5ef1:c95 with SMTP id 5614622812f47-3ea6dc2c5e9mr5782361b6e.25.1732768622539;
        Wed, 27 Nov 2024 20:37:02 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254181479dsm457052b3a.159.2024.11.27.20.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 20:37:02 -0800 (PST)
Message-ID: <21df66492832c16c7456dc0e458b3af68649f233.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: Refactor
 {acquire,release}_reference_state
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>,
 kernel-team@fb.com
Date: Wed, 27 Nov 2024 20:36:57 -0800
In-Reply-To: <CAP01T779EKX=GCPYUyihey=1Sw+1ht4f6C07PnzVEko+JgYk5g@mail.gmail.com>
References: <20241127165846.2001009-1-memxor@gmail.com>
	 <20241127165846.2001009-3-memxor@gmail.com>
	 <0b2e84f96227c62ef4da7eda44ee31d42800fccd.camel@gmail.com>
	 <CAP01T779EKX=GCPYUyihey=1Sw+1ht4f6C07PnzVEko+JgYk5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 05:30 +0100, Kumar Kartikeya Dwivedi wrote:
> On Thu, 28 Nov 2024 at 05:13, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > On Wed, 2024-11-27 at 08:58 -0800, Kumar Kartikeya Dwivedi wrote:
> >=20
> > Overall looks good, but please take a look at a few notes below.
> >=20
> > [...]
> >=20
> > > @@ -1349,77 +1350,69 @@ static int grow_stack_state(struct bpf_verifi=
er_env *env, struct bpf_func_state
> > >   * On success, returns a valid pointer id to associate with the regi=
ster
> > >   * On failure, returns a negative errno.
> > >   */
> > > -static int acquire_reference_state(struct bpf_verifier_env *env, int=
 insn_idx)
> > > +static struct bpf_reference_state *acquire_reference_state(struct bp=
f_verifier_env *env, int insn_idx, bool gen_id)
> > >  {
> > >       struct bpf_verifier_state *state =3D env->cur_state;
> > >       int new_ofs =3D state->acquired_refs;
> > > -     int id, err;
> > > +     int err;
> > >=20
> > >       err =3D resize_reference_state(state, state->acquired_refs + 1)=
;
> > >       if (err)
> > > -             return err;
> > > -     id =3D ++env->id_gen;
> > > -     state->refs[new_ofs].type =3D REF_TYPE_PTR;
> > > -     state->refs[new_ofs].id =3D id;
> > > +             return NULL;
> > > +     if (gen_id)
> > > +             state->refs[new_ofs].id =3D ++env->id_gen;
> >=20
> > Nit: state->refs[new_ods].id might end up with garbage value if 'gen_id=
' is false.
> >      The resize_reference_state() uses realloc_array(),
> >      which allocates memory with GFP_KERNEL, but without __GFP_ZERO fla=
g.
> >      This is not a problem with current patch, as you always check
> >      reference type before checking id, but most of the data strucures
> >      in verifier are zero initialized just in case.
>=20
> We end up assigning to s->id if gen_id is false, e.g.
> acquire_lock_state, so I think we'll be fine without __GFP_ZERO.

Oh, I see, thank you for explaining.

[...]


