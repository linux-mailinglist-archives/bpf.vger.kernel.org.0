Return-Path: <bpf+bounces-19339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4444682A109
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 20:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618491C21DA2
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9794E1D3;
	Wed, 10 Jan 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G+XYTink"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8204EB24
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbf2b5556f9so824731276.2
        for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 11:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704914952; x=1705519752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2bUkBReQfwT0sc5eOtWAQzD2wRXCAw4oZctMGXmfqA=;
        b=G+XYTinkLzMcMauK1gKR4FV7TPeD7bVuzFl8MMHRGCwyHOmDwdcEMPmdM8CkTFPLP6
         ot/ms0tP7qAWiUNpFwTQYw37RWXBThOge3nFb6ghS8/DfAWxKoaPVfxxCCLWz4oI5ugb
         W8VKt+0HAsDJ+FvM8X8dZFSCGKQX+FVLjVE0UpedV56zh7lBbK2wk3PMfgQFeojW05LO
         uwH4qPZexSwGlwYQ5TYlzSTXY//Pib2TN9ngVhiN4yhDwYmw+ABGjWVFch6aAnRdbrLY
         kcl5kuAP5J+7BviFMMcz37MYmzxytit7aJp8oElqvb9dMlVQ/qZYhbn8cUD2ISFoogdf
         jAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704914952; x=1705519752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2bUkBReQfwT0sc5eOtWAQzD2wRXCAw4oZctMGXmfqA=;
        b=crQH3Og5miWab7jYeDsQy8hCjj/3YwPLJWAjGGvt7uEJ1/JvyB/ZrPcHctjAteDUQg
         N/q8m5XtE6GpbBmzjiX6JkjONHM7g56/VVbeVECcFTXr64P4sv2Iif6CriEgYFBN10Ie
         xFxgK63AH3DgJ5lpNrkc2Ah6aTl5ikP+2n2Up+n+mNb+41AmyYGtQgQRthRzgCcvegkB
         b4IdYl9xKDPkc7Jv++PebegzndaQF8NrYaL+lCLz5CF1u5Bhc+I9fBApdgALyZBXYd11
         5GIMeFoMjqGWOZzYayjuZ9PQSH/ofEXCw6wMqt0tGVrqaReT/b2euyInax/X83bw51pC
         QUIA==
X-Gm-Message-State: AOJu0YxcAEJ48guea/RUyQNwRRyHivMU64KhqL0ciej7CVLdm2l/nS3Q
	ZcYMaoMCaCaFzsWlYLH0qx7AUrjbFjYJFD/+AaBreFVZxeaN
X-Google-Smtp-Source: AGHT+IENkShTLrasuj44rt3GZfsru9Ag3PqXQaVV0uRZGTzjhLtSeGCrgh6CtzW8WZ+1gk6FgSd94t1Z7lGq3aTsqKc=
X-Received: by 2002:a25:b318:0:b0:db5:3b45:3776 with SMTP id
 l24-20020a25b318000000b00db53b453776mr133956ybj.36.1704914952383; Wed, 10 Jan
 2024 11:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
 <CAHC9VhQg7mYnQw-o1TYon_bdtk_CMzJaf6u5FTPosniG-UXK1w@mail.gmail.com> <CAEf4BzYMrvtTjkBUWOk1TKi8qiBbwv1xv=eJeF3j3QrY1M=h3g@mail.gmail.com>
In-Reply-To: <CAEf4BzYMrvtTjkBUWOk1TKi8qiBbwv1xv=eJeF3j3QrY1M=h3g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jan 2024 14:29:01 -0500
Message-ID: <CAHC9VhSwgY8cCX+eR7=+gb=-Q2pC9Z_jstf0xHD4kMA7vpiDOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 7:07=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Mon, Jan 8, 2024 at 8:45=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > On Fri, Jan 5, 2024 at 4:45=E2=80=AFPM Linus Torvalds
> > <torvalds@linuxfoundation.org> wrote:
> > > On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrot=
e:
> > > >
> > > > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > > +{
> > > > +       /* BPF token allows ns_capable() level of capabilities, but=
 only if
> > > > +        * token's userns is *exactly* the same as current user's u=
serns
> > > > +        */
> > > > +       if (token && current_user_ns() =3D=3D token->userns) {
> > > > +               if (ns_capable(token->userns, cap))
> > > > +                       return true;
> > > > +               if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->use=
rns, CAP_SYS_ADMIN))
> > > > +                       return true;
> > > > +       }
> > > > +       /* otherwise fallback to capable() checks */
> > > > +       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(C=
AP_SYS_ADMIN));
> > > > +}
> > >
> > > This *feels* like it should be written as
> > >
> > >     bool bpf_token_capable(const struct bpf_token *token, int cap)
> > >     {
> > >         struct user_namespace *ns =3D &init_ns;
> > >
> > >         /* BPF token allows ns_capable() level of capabilities, but o=
nly if
> > >          * token's userns is *exactly* the same as current user's use=
rns
> > >          */
> > >         if (token && current_user_ns() =3D=3D token->userns)
> > >                 ns =3D token->userns;
> > >         return ns_capable(ns, cap) ||
> > >                 (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> > >     }
> > >
> > > And yes, I realize that the function will end up later growing a
> > >
> > >         security_bpf_token_capable(token, cap)
> > >
> > > test inside that 'if (token ..)' statement, and this would change the
> > > order of that test so that the LSM hook would now be done before the
> > > capability checks are done, but that all still seems just more of an
> > > argument for the simplification.
> >
> > I have no problem with rewriting things, my only ask is that we stick
> > with the idea of doing the capability checks before the LSM hook.  The
> > DAC-before-MAC (capability-before-LSM) pattern is one we try to stick
> > to most everywhere in the kernel and deviating from it here could
> > potentially result in some odd/unexpected behavior from a user
> > perspective.
>
> Makes sense, Paul. With the suggested rewrite we'll get an LSM call
> before we get to ns_capable() (which we avoid doing in BPF code base,
> generally speaking, after someone called this out earlier). Hmm...
>
> I guess it will be better to keep this logic as is then, I believe it
> was more of a subjective stylistical nit from Linus, so it probably is
> ok to keep existing code.

I didn't read Linus' reply as a mandate, more as a
this-would-be-nice-to-have, and considering the access control
ordering I would just stick with what you have (ignoring Christian's
concerns, I'm only commenting on the LSM related stuff here).

If Linus is *really* upset with how the code is written I suspect
we'll hear from him on that.

--=20
paul-moore.com

