Return-Path: <bpf+bounces-46043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 199BC9E311A
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 03:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9FDB25423
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 02:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F791A296;
	Wed,  4 Dec 2024 02:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsYW2yYy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFFEEB5;
	Wed,  4 Dec 2024 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278000; cv=none; b=N21UosNnLJQDGYZRBTLop1tSlOgwvFHyeKJYeJuTUK36y95qeMylhkzAoPcPLxG6pIcNd9PIOa9xtk3rsxXQZ9CGlWnDhHdqSDDvMzn4wsMAfsFtz3X6m/h+SCxWfdO2IRW2NsYDUl15aJ0rdr3uMPjVfw0fTnVOj/eFaN8/8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278000; c=relaxed/simple;
	bh=gD2jR3gXRirsqS/R6OmNKsgKA+ejRcqc/CQiI+0Vy5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIUpzXVLQx+gPchTSYFY/FyVkNuWHlmxnurB7p1Gku/8TTi1TRL50iSHpJb5q7nT9DxIzb8wrJAWs2tYJoqaisJCrTey+NNS0Gb2QsZGAa4u2GT/57cxSR4WKGAVV56Q33Qm7oneIlSfmHFtPvgeeHP+8XzcojgGdJK2e4GWytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsYW2yYy; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee51c5f000so3470953a91.0;
        Tue, 03 Dec 2024 18:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733277998; x=1733882798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNCW5mumtIow08xaMZzjbFZ1Q4xmmpxfquO0jRDWfzQ=;
        b=EsYW2yYyJzrvZF9NM8Capt1aTbBsHxzyVjrCXEHVrH3wARGPwVijlSpgg3DMSR8vHk
         1IazqgHWCZxo13xO8hbIo7ic3WAEGaDYdG7hiY/HSoFUl0pFmEj4ITOCtE61K2BF0iMw
         KVFkc4TqRSQ6DyJuNGJeBoRi1KIh+UupTZYBB/4VhSn+wtkjnKV2N1XCNwIA7B7lL0ct
         1hO/GraqsySnxVD2mT42md8Qywl521izk8w6kBzHJu3hfQs3K/1QWqPOKaoJCy1gDWt1
         6G+BsPTkIOmahj5PwgWcWFpIRMhSh2EKzOtcBj41WzUljYbgQ0W1LZsyKndzbrJauIN5
         wCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733277998; x=1733882798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNCW5mumtIow08xaMZzjbFZ1Q4xmmpxfquO0jRDWfzQ=;
        b=Umn4CI7xK8ElTkRIc9I24a3oUI5m13PFDecUL0G82auAAQSM3RRVHEIsX9FbqKaTLQ
         Rmgtgrbac5h5y0GKmia0qZSFVM8voGf2hbIzX0AOyLUaelofBD9pUDK/+W5To7dn17DU
         skuPfZY9eSIlhjlq+D54qprg9KZeaMTyxphFUKsuJIps/WE0Lb/Qr4ZNo6swhR79EC5g
         JBVyB9xrQP7RoPWf8eLzpIDEaMARNxvoXIqNiT8wORWmDJakRjEf0QGaECkVkyMAGrPp
         HDNZoGTfaf8+AyI2QtrZOvSsiJ5sdEIe1JKO/twkbe6UrM3TPEAH7p+0Ib3Lgi1USjlT
         1FBA==
X-Forwarded-Encrypted: i=1; AJvYcCVe8iXLFtEJK7g92h1SCOPHANYUF87MHpq3joqyMSk9aKAYbUx9exF9ewhm/+d9ImOHY01am1jO5Qp7knF0@vger.kernel.org, AJvYcCWTqBnxmG4JprjfKq/P1WDcesn6is+O4SD++rxBHwHV5+NSYbGXP+EkE6+yH0fxWNjCSfjOeWTx1EcRI0Tr@vger.kernel.org, AJvYcCWYV3q0q4lDzKgapFBbQfdDRR0j3GHOwc+boxx0XS9KXPb1HoHB36R1Vo4IZeXryTEvSRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDREwQZP+dna/97Sdo0tL2rmmNNu+zJGV29f366XXVD9dCTsH
	J44Kxa+J7MiCicABEHrP7JtybeGxQVnvFEzm5xx2lHhYWKQstzWJrZYEJiMpxIr0ny3GJo1MUNZ
	jXmLxRAGuF210PDBQE6qYQZslGBg=
X-Gm-Gg: ASbGncvQwUdhNIXF0n6xA3DpQIf3R7mqjOxmNHoUah/GkUEGRou+i7HJMqPdkG2yyJe
	5mgK70+iA7Pol0BLimfpXT2GgM3V0yP5ay6Bu3HpHLEjSn7Q=
X-Google-Smtp-Source: AGHT+IH2RY4OtNaizvVDGMW2S6a5vJRlmNNDi0za4gLjjCEup5LAwkD/Uszkr76IGY9+R8uVdlGu5VDpGwem4ZkrUvQ=
X-Received: by 2002:a17:90a:fc4b:b0:2ee:e961:3052 with SMTP id
 98e67ed59e1d1-2ef1ce834e4mr3668779a91.14.1733277998018; Tue, 03 Dec 2024
 18:06:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-resolve_btfids-v2-0-288c37cb89ee@weissschuh.net>
 <20241126-resolve_btfids-v2-1-288c37cb89ee@weissschuh.net>
 <CAEf4BzahMQWVH0Gaub-tWjH9GweG8Kt7OBU-f+PBhmmRDCKfrA@mail.gmail.com> <9a11cf2f-ddca-4a50-817f-74183d31dcaf@t-8ch.de>
In-Reply-To: <9a11cf2f-ddca-4a50-817f-74183d31dcaf@t-8ch.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Dec 2024 18:06:26 -0800
Message-ID: <CAEf4BzZqeo00C5a9QO6Ah3i-doWRbg7v_2y=y9Kfg3=JyrA=zQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools/resolve_btfids: Add --fatal-warnings option
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:09=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> On 2024-12-03 14:31:01-0800, Andrii Nakryiko wrote:
> > On Tue, Nov 26, 2024 at 1:17=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@we=
issschuh.net> wrote:
> > >
> > > Currently warnings emitted by resolve_btfids are buried in the build =
log
> > > and are slipping into mainline frequently.
> > > Add an option to elevate warnings to hard errors so the CI bots can
> > > catch any new warnings.
> > >
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/bpf/resolve_btfids/main.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfi=
ds/main.c
> > > index bd9f960bce3d5b74dc34159b35af1e0b33524d2d..571d29d2da97fea75e5f9=
c544a95b9ac65f9e579 100644
> > > --- a/tools/bpf/resolve_btfids/main.c
> > > +++ b/tools/bpf/resolve_btfids/main.c
> > > @@ -141,6 +141,7 @@ struct object {
> > >  };
> > >
> > >  static int verbose;
> > > +static int warnings;
> > >
> > >  static int eprintf(int level, int var, const char *fmt, ...)
> > >  {
> > > @@ -604,6 +605,7 @@ static int symbols_resolve(struct object *obj)
> > >                         if (id->id) {
> > >                                 pr_info("WARN: multiple IDs found for=
 '%s': %d, %d - using %d\n",
> > >                                         str, id->id, type_id, id->id)=
;
> > > +                               warnings++;
> > >                         } else {
> > >                                 id->id =3D type_id;
> > >                                 (*nr)--;
> > > @@ -625,8 +627,10 @@ static int id_patch(struct object *obj, struct b=
tf_id *id)
> > >         int i;
> > >
> > >         /* For set, set8, id->id may be 0 */
> > > -       if (!id->id && !id->is_set && !id->is_set8)
> > > +       if (!id->id && !id->is_set && !id->is_set8) {
> > >                 pr_err("WARN: resolve_btfids: unresolved symbol %s\n"=
, id->name);
> > > +               warnings++;
> > > +       }
> > >
> > >         for (i =3D 0; i < id->addr_cnt; i++) {
> > >                 unsigned long addr =3D id->addr[i];
> > > @@ -782,6 +786,7 @@ int main(int argc, const char **argv)
> > >                 .funcs    =3D RB_ROOT,
> > >                 .sets     =3D RB_ROOT,
> > >         };
> > > +       bool fatal_warnings =3D false;
> > >         struct option btfid_options[] =3D {
> > >                 OPT_INCR('v', "verbose", &verbose,
> > >                          "be more verbose (show errors, etc)"),
> > > @@ -789,6 +794,8 @@ int main(int argc, const char **argv)
> > >                            "BTF data"),
> > >                 OPT_STRING('b', "btf_base", &obj.base_btf_path, "file=
",
> > >                            "path of file providing base BTF"),
> > > +               OPT_BOOLEAN(0, "fatal-warnings", &fatal_warnings,
> > > +                           "turn warnings into errors"),
> >
> > We are mixing naming styles here: we have "btf_base" with underscore
> > separator, and you are adding "fatal-warnings" with dash separator. I
> > personally like dashes, but whichever way we should stay consistent.
> > So let's fix it, otherwise it looks a bit sloppy.
>
> Ack.
>
> >
> > Please also use [PATCH bpf-next v3] subject prefix to make it explicit
> > that this should go through bpf-next tree.
>
> Ack.
>
> >
> > pw-bot: cr
> >
> > >                 OPT_END()
> > >         };
> > >         int err =3D -1;
> > > @@ -823,7 +830,8 @@ int main(int argc, const char **argv)
> > >         if (symbols_patch(&obj))
> > >                 goto out;
> > >
> > > -       err =3D 0;
> > > +       if (!(fatal_warnings && warnings))
> > > +               err =3D 0;
> >
> > nit: just
> >
> > if (!fatal_warnings)
> >     err =3D 0;
> >
> > ?
>
> This seems wrong. Now the actual warning counter is never evaluated.
> And --fatal_warnings will always lead to an error exit code.

Ah, I missed that you are using default -1 value here. I wonder if we
should make it a bit more explicit?

if (fatal_warnings)
    err =3D warnings ? -1 : 0;
else
    err =3D 0;

Something like that?

>
> > >  out:
> > >         if (obj.efile.elf) {
> > >                 elf_end(obj.efile.elf);
> > >
> > > --
> > > 2.47.1
> > >

