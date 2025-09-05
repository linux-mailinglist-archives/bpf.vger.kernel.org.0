Return-Path: <bpf+bounces-67604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE166B46379
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68771170CC5
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A599022C32D;
	Fri,  5 Sep 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2QHZtAs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44751DE89A
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099992; cv=none; b=YHPbGAc8Ylo+/nW1vBSA298TdNaa9QyHI0rL+9qItJDZuNjANLscipxD6bSEZWPV0VckybPueCFhkDp/KmwfRpy0N4XRR+CHVdLOA9F+okZ4IV/rb9MAemYxGi8fi5cqp+9AtcaLfH7QZ46sfRuOHNQ/oCDjNk3nQqrizseBSp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099992; c=relaxed/simple;
	bh=qzwi0R5aSeuw2Z09gJ2+uP2rPrHyinhKVNMacBr9ucI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rrHsQsgMHzaCWW7lfoRVBgHf7NcAkwua3ucHO6LhEgaakB8PQmEpMUOlYH5zHQ+tIaSCyfJTV5Com+wufC/gvrJ3Jzo01MgkBJzfSquCYmpm7mMLDFLq3vHYrmMCMWWj0oCPDUjKL6yykfOZzSBwRT6UrwL1cq8zdwG2YnZObDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2QHZtAs; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so2558249a12.0
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099990; x=1757704790; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+yuWxMeqjHJbbVr9SMPKWdjQnFa/HUAx9EM2VBuU4lA=;
        b=C2QHZtAsaCbM2Q3nlvwnkTauKGgtFKmTQNoT1E+R1FmNYyn7lTj+JGP//rDGTiNlbp
         3iukrGW2xrgpDu6wqHueGrFvArKuWoy8TzNTV2VQN3+6cEY3oTHehGNLdn4Md2xi+DPb
         uFpNcF4l+eN/BsqyZvyrCeQuvSLMMJrXbJbZ1sszwUKVIB+DPW3ksp3k5p6G/jyvhWv3
         qDEVt/ecfLhP6oenZNJDkiYDXxXsXV4jLC9DSJ6mn01V0sFEl8F7r/kJWHIFTY/OqiGp
         qvRXgBiDARYnpNaEOj6uJtNjW0Grxwsnsa4xJXbaqN4JKeGFTiw9EiGPeLJ+SwKtNNLb
         uzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099990; x=1757704790;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yuWxMeqjHJbbVr9SMPKWdjQnFa/HUAx9EM2VBuU4lA=;
        b=A2W7NNNmAvpW4Vd7m1GM1v0EulT9BcK5EXmNoQ2a4H6YGn9DdvScYAJ+oOA4TPf7q8
         9wchSSfVZ8wWdXdCuZhKskfgSgaTGsAyzUlhY01P1/Sdb7sLBHNezi0PpURFc4Q9+2bz
         V+61H928RIycc7pu9y7j/Z1wH7Uxy45pTXqnE9pr2anbakwVXHQ3Not7fcWD2yP2OCqN
         GMRDPXpuHRwcR3pysGqfE3v0+QKP8Mp8xIDLzRqnizNH9RwLBxXKeXLH/EX1fUurZW5G
         4HxEtsRcXljQn3vO7f0S9xyuyNb28s8g21L9T4qDb3Rfo14gRWbDaXf0suOTW1SJIG0q
         KJbA==
X-Forwarded-Encrypted: i=1; AJvYcCVO/QZPJoj69lkQA5OL9peM9bv9shFmbIRaqxV82d9NjqJS/REHa0PFqMWyavZIiy66ooQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTyO4oeHZul7+K3xn1/HKikALd61sxT41MC4o4S/v35x0WcHWe
	pw7S3xcU6Dlexd+8f7fCKcKElii89XoihlcSf4sJ3WDAHfQrVe1xVLgS
X-Gm-Gg: ASbGncsVbKEXPbDqBrDnHXxoQcKUP3csGX24N4zuWbtzVxDka3WyI9t709w1WZAn9b5
	Jtg3Xs97vE9396M0F7xtj8lDkOqDIl2WOk6VFM+zjHkbjmkSLXmLJEoVxZy6ASvNZ35PLwowsBe
	BxauZl4ihPrWsrn2aBceep6YXlPPSZpiyhQLkkRCcyGZScQERA+BFC633gcQr7SmjZXAVPWfRkn
	JlaP8C4PeV8okmZ0IdTozBfhlz2ZVZYmFynGmdA5tghtSLqsj/BsTI4oVQPUIEdWW1fSprsBerE
	KxSDuXnD45TAD5muCEBJz8hslPV6qAWYwr0j018LQ1gJ4r9nnf1K6ToyTQI+uLuKZtd9sx8lav0
	DDzQTBvsYR2UAkKuPsZaAoFyKrCuY
X-Google-Smtp-Source: AGHT+IH6Nlmmb+vqsCiuc7966K/YBI5XW9TUdzhcYcH0VbDl1hxwvg2aMvf0bh/u/lloWTGqMCHGlA==
X-Received: by 2002:a17:902:e851:b0:248:aa0d:bb30 with SMTP id d9443c01a7336-24cedc6f3e6mr56225945ad.2.1757099989865;
        Fri, 05 Sep 2025 12:19:49 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced7ea5ccsm29693325ad.111.2025.09.05.12.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:19:49 -0700 (PDT)
Message-ID: <d38c391c806ed34e9b669e64be4e1c85afdfd6e3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7] selftests/bpf: add BPF program dump in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 05 Sep 2025 12:19:45 -0700
In-Reply-To: <CAEf4BzbZg-BqMQV5vKHSDPabZQbpHFbdZhQ4NXCRiAZvh0yc=A@mail.gmail.com>
References: <20250905140835.1416179-1-mykyta.yatsenko5@gmail.com>
	 <ac6e70c96097c677d5689d86dd2bc0dea603a5d1.camel@gmail.com>
	 <CAEf4BzbZg-BqMQV5vKHSDPabZQbpHFbdZhQ4NXCRiAZvh0yc=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 12:14 -0700, Andrii Nakryiko wrote:
> On Fri, Sep 5, 2025 at 12:00=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Fri, 2025-09-05 at 15:08 +0100, Mykyta Yatsenko wrote:
> > > From: Mykyta Yatsenko <yatsenko@meta.com>
> > >=20
> > > Add the ability to dump BPF program instructions directly from verist=
at.
> > > Previously, inspecting a program required separate bpftool invocation=
s:
> > > one to load and another to dump it, which meant running multiple
> > > commands.
> > > During active development, it's common for developers to use veristat
> > > for testing verification. Integrating instruction dumping into verist=
at
> > > reduces the need to switch tools and simplifies the workflow.
> > > By making this information more readily accessible, this change aims
> > > to streamline the BPF development cycle and improve usability for
> > > developers.
> > > This implementation leverages bpftool, by running it directly via pop=
en
> > > to avoid any code duplication and keep veristat simple.
> > >=20
> > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > ---
> >=20
> > Lgtm with a small nit.
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
> > > @@ -1554,6 +1573,35 @@ static int parse_rvalue(const char *val, struc=
t rvalue *rvalue)
> > >       return 0;
> > >  }
> > >=20
> > > +static void dump(__u32 prog_id, enum dump_mode mode, const char *fil=
e_name, const char *prog_name)
> > > +{
> > > +     char command[64], buf[4096];
> > > +     FILE *fp;
> > > +     int status;
> > > +
> > > +     status =3D system("which bpftool > /dev/null 2>&1");
> >=20
> > Fun fact: if you do a minimal Fedora install (dnf group install core)
> >           "which" is not installed by default o.O
> >           (not suggesting any changes).
>=20
> I switched to `command -v bpftool` for now, is there any gotcha with
> that one as well?

Should be fine, I guess:

  $ rpm -qf /usr/sbin/command
  bash-5.2.37-1.fc42.x86_64

> >=20
> > > +     if (status !=3D 0) {
> > > +             fprintf(stderr, "bpftool is not available, can't print =
program dump\n");
> > > +             return;
> > > +     }
> >=20
> > [...]
> >=20
> > > @@ -1630,8 +1678,13 @@ static int process_prog(const char *filename, =
struct bpf_object *obj, struct bpf
> > >=20
> > >       memset(&info, 0, info_len);
> > >       fd =3D bpf_program__fd(prog);
> > > -     if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0)
> > > +     if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0) {
> > >               stats->stats[JITED_SIZE] =3D info.jited_prog_len;
> > > +             if (env.dump_mode & DUMP_JITED)
> > > +                     dump(info.id, DUMP_JITED, base_filename, prog_n=
ame);
> > > +             if (env.dump_mode & DUMP_XLATED)
> > > +                     dump(info.id, DUMP_XLATED, base_filename, prog_=
name);
> >=20
> > Nit: if you do `./veristat --dump=3Djited iters.bpf.o` there would be a=
n empty line
> >      after dump for each program, but not for --dump=3Dxlated.
> >=20
>=20
> Yeah, bpftool's output isn't consistent. I just added an extra empty
> line, that makes dump a bit more clean (and I didn't mind two empty
> lines, whatever).

+1

>=20
> I was also finding it hard to notice where the dump for a given
> program starts, so I reformatted header a bit. Overall, applied the
> following changes and pushed to bpf-next, thanks for a useful feature!

Yeap, nice little feature.
I was doing bogus __xlated("foo") before in tests,
just to see how assembly looks like.

