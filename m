Return-Path: <bpf+bounces-60205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFA4AD3F3A
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 18:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE47F17CCFA
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C74F241670;
	Tue, 10 Jun 2025 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i52dOCwc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3DA24167A
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573689; cv=none; b=QErpC4A74pAuro6hbbPFqPG1bgU5dB+foM4jJSMy534A47wmVAlN89Y6tkvSSb6yF1P80vBMWtdtyGmHca9Z4sDZb0sL0MOgHxJQMCeSJL8GePghVz9omnF2GQtmBwuASCmaPkNCzDVykCNl4hXafu7/EG+nBcWlNUQO5pklSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573689; c=relaxed/simple;
	bh=Ndj7Cmt0Hfs1qIWmdZK1yj1YoJR5hCdlgudEcXuasHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ih8eIBKCXqPXWxrTC+Dn9gjXDvNZgu3L8CEf8/yeBwqzVU5gkT1tpmDDyS38bphd2Mp7zdfH2rdwot0R6Rz8824VyS7l5n+QnqPUTY3/A0KLjpx0I0bGwcllnvrCd6WhqXrFUS4Yt4SYaisZ9C08BcHtxsK4n9xqZNoRsuRi7e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i52dOCwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94202C4CEF1
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 16:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749573688;
	bh=Ndj7Cmt0Hfs1qIWmdZK1yj1YoJR5hCdlgudEcXuasHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i52dOCwcJpvJ/b0VBmhvIWYyYNtaKvu7LPn2eFnlUpLGTiZQNPRe6kWM6KTSYvaTe
	 PE1AhUlB+osbIb8QDGmZnUVxtCMgN3ulKgJJpj094y7lQKio66eYv7/Yh9w7FwGXx+
	 JNKODVTXu+Y7Td5eHnj3/hs/pVkMcN967XvoW9u9en93e7fC9ZnPuAovAvCwqkqRMA
	 6prDb9VERZJTMAM4iBOiW0/0r7OZa04KFkZ4flHURS0RTQkJRQ33nYY1rjDyI1Umff
	 Pui8gCimVRN/8ESUUqSMVPN6w/cFxG6wDQrlBwxvH4LkdCQhjiViQf5FW+gvpOoIBy
	 R2QNvaozznZ/Q==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso7532262a12.3
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 09:41:28 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzxiob2KgXcCc3wPMlBK85wuNvs+Elxj4NeiaiCy+tZXZ3geA0J
	+lW2eCfeHa/AEE1KE8419Gw+/XNCMjLyWA5yIZShI1HBdJ4vstebMugXj92BTbS/wRpbmnR5OxU
	c6J4AaYYws2ZQLvtQsqs4a/vBgIYFkcMbDnB0Tvt/
X-Google-Smtp-Source: AGHT+IFAf9dmAjYR/e9BsxpHhCv6SB/MCiE0hWKjf8SPA3vamNz5B67k0oQMencrquVP9O8KtceyLNozl9opiWVGCJo=
X-Received: by 2002:a05:6402:34d6:b0:608:44cd:f91f with SMTP id
 4fb4d7f45d1cf-60844cdf9a3mr94239a12.32.1749573687058; Tue, 10 Jun 2025
 09:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-12-kpsingh@kernel.org>
 <b2a0c3d722c78de38ffa2664f71654a422d77121.camel@HansenPartnership.com>
 <CACYkzJ7Mh=VV0FDsfWZbWBcdC6qLdVp4RDbnoMM_Fb4LW7t4=Q@mail.gmail.com> <7d0bdd9f40d1e4e1c9ff5605e5e875b1b9f5654a.camel@HansenPartnership.com>
In-Reply-To: <7d0bdd9f40d1e4e1c9ff5605e5e875b1b9f5654a.camel@HansenPartnership.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 10 Jun 2025 18:41:16 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6k1cAVi_g9ryhMie4OXAVaO9baTc8SP=dtVE5XPVbJvA@mail.gmail.com>
X-Gm-Features: AX0GCFtuNesKscYdp1Kq0RRXmysLkUGGNb5czU6UXuyDb-uIpAlaPxCxw_vaHBM
Message-ID: <CACYkzJ6k1cAVi_g9ryhMie4OXAVaO9baTc8SP=dtVE5XPVbJvA@mail.gmail.com>
Subject: Re: [PATCH 11/12] bpftool: Add support for signing BPF programs
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 5:56=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2025-06-10 at 10:50 +0200, KP Singh wrote:
> > On Sun, Jun 8, 2025 at 4:03=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > [+keyrings]
> > > On Sat, 2025-06-07 at 01:29 +0200, KP Singh wrote:
> > > [...]
> > > > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > > > index f010295350be..e1dbbca91e34 100644
> > > > --- a/tools/bpf/bpftool/prog.c
> > > > +++ b/tools/bpf/bpftool/prog.c
> > > > @@ -23,6 +23,7 @@
> > > >  #include <linux/err.h>
> > > >  #include <linux/perf_event.h>
> > > >  #include <linux/sizes.h>
> > > > +#include <linux/keyctl.h>
> > > >
> > > >  #include <bpf/bpf.h>
> > > >  #include <bpf/btf.h>
> > > > @@ -1875,6 +1876,8 @@ static int try_loader(struct
> > > > gen_loader_opts
> > > > *gen)
> > > >  {
> > > >       struct bpf_load_and_run_opts opts =3D {};
> > > >       struct bpf_loader_ctx *ctx;
> > > > +     char sig_buf[MAX_SIG_SIZE];
> > > > +     __u8 prog_sha[SHA256_DIGEST_LENGTH];
> > > >       int ctx_sz =3D sizeof(*ctx) + 64 * max(sizeof(struct
> > > > bpf_map_desc),
> > > >                                            sizeof(struct
> > > > bpf_prog_desc));
> > > >       int log_buf_sz =3D (1u << 24) - 1;
> > > > @@ -1898,6 +1901,24 @@ static int try_loader(struct
> > > > gen_loader_opts
> > > > *gen)
> > > >       opts.insns =3D gen->insns;
> > > >       opts.insns_sz =3D gen->insns_sz;
> > > >       fds_before =3D count_open_fds();
> > > > +
> > > > +     if (sign_progs) {
> > > > +             opts.excl_prog_hash =3D prog_sha;
> > > > +             opts.excl_prog_hash_sz =3D sizeof(prog_sha);
> > > > +             opts.signature =3D sig_buf;
> > > > +             opts.signature_sz =3D MAX_SIG_SIZE;
> > > > +             opts.keyring_id =3D KEY_SPEC_SESSION_KEYRING;
> > > > +
> > >
> > > This looks wrong on a couple of levels.  Firstly, if you want
> > > system level integrity you can't search the session keyring because
> > > any process can join (subject to keyring permissions) and the
> > > owner, who is presumably the one inserting the bpf program, can add
> > > any key they like.
> > >
> >
> > Wanting system level integrity is a security policy question, so this
> > is something that needs to be implemented at the security layer, the
> > LSM can deny the keys / keyring IDs they don't trust.  Session
> > keyrings are for sure useful for delegated signing of BPF programs
> > when dynamically generated.
>
> The problem is you're hard coding it at light skeleton creation time.
> Plus there doesn't seem to be any ability to use the system keyrings
> anyway as the kernel code only looks up the user keyrings.  Since
> actual key ids are volatile handles which change from boot to boot (so
> can't be stored in anything durable) this can only be used for keyring
> specifiers, so it would also make sense to check this is actually a
> specifier (system keyring specifiers are positive and user specifiers
> negative, so it's easy to check for the range).
>
> > > The other problem with this scheme is that the keyring_id itself
> > > has no checked integrity, which means that even if a script was
> > > marked as
> >
> > If an attacker can modify a binary that has permissions to load BPF
> > programs and update the keyring ID then we have other issues.
>
> It's a classic supply chain attack (someone modifies the light skeleton
> between the creator and the consumer), even Google is claiming SLSA
> guarantees, so you can't just wave it away as "other issues".
>
> >  So, this does not work in independence, signed BPF programs do not
> > really make sense without trusted execution).
>
> The other patch set provided this ability using signed hash chains, so
> absolutely there are signed bpf programmes that can work absent a
> trusted user execution environment.  It may not be what you want for
> your use case (which is why the other patch set allowed for both), but
> there are lots of integrity use cases out there wanting precisely this.
>
> > > system keyring only anyone can binary edit the user space program
> > > to change it to their preferred keyring and it will still work.  If
> > > you want variable keyrings, they should surely be part of the
> > > validated policy.
> >
> > The policy is what I expect to be implemented in the LSM layer. A
> > variable keyring ID is a critical part of the UAPI to create
> > different "rings of trust" e.g. LSM can enforce that network programs
> > can be loaded with a derived key, and have a different keyring for
> > unprivileged BPF programs.
>
> You can't really have it both ways: either the keyring is part of the
> LSM supplied policy in which case it doesn't make much sense to have it
> in the durable attributes (and the LSM would have to set it before the
> signature is verified) or it's part of the durable attribute embedded
> security information and should be integrity protected.
>
> I suppose we could compromise and say it should not be part of the
> light skeleton durable attributes but should be set (or supplied by
> policy) at BPF_PROG_LOAD time.

Sure, this is expected, I added a default value there but this can be remov=
ed.

>
> I should also note that when other systems use derived keys in
> different keyrings, they usually have a specific named trusted keyring
> (like _ima and .ima) which has policy enforced rules for adding keys.

We can potentially add a bpf keyring but in general we don't want
every binary on the machine to use this derived key, but the binary
that's trusted to either load unsigned programs or use a derived key
for which the session keyring is more apt.

- KP

>
> Regards,
>
> James
>
>
> > This patch implements the signing support, not the security policy
> > for it.
> >
> > - KP
>

