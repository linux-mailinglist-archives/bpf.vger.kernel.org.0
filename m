Return-Path: <bpf+bounces-22990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5184D86BE38
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 02:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E241F2486C
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8FF2D046;
	Thu, 29 Feb 2024 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR+5Xjty"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B229CEF
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709169919; cv=none; b=eLPUHg8bUYU+XVqTt+lRp3qNIp6xaLnpNSkCmO0p1C+BhhVSSKRNujL+qNERob2t2uSBW2Imc/3xT9WdTlz3PED9P8TFUIRWshwpp5MCHcbg3bUPgkd4wdnwckoR5IqYPnrMpo+uY8vSxpMhSIFI8foScNSByoILTdBOdhp4PvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709169919; c=relaxed/simple;
	bh=av+h9pG/g1/vG1gmxtnDDCMLr8Q+3woISBlYOMPfIx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcSdTVIRM8HjpLYvtTEMu4U2VJvBFTAwV7BJGonRzkcelDhnNieSI0DTmc6lVSYhyOlaNTwEPbPP1moCEO+VFO2tLpruf0eOU1aETb/y3ubLoRADUaL+8vm2COR8056Y35Y1vzTSszyHAsRBcwFxaFngf13xBp/z9x/PbIecvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR+5Xjty; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dba177c596so2824175ad.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709169918; x=1709774718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7ktcIFREdgHgSgjRN6hEYBtA4ZTkOoctqP6rT6gcgc=;
        b=dR+5XjtyKG3nJNu4ojwUjYpzf5CqTO4EPzAV3Inyqg/Ht9iIHCJksI+BFsTTYCI6If
         oIj2KYnBCaLFnGVGVu2rzAltVut0b0aEeTQCDdQOlBQ9MLsJ/4aRaWrMGR15hynh6IRl
         IgVB9TaV8q/VfkO72r1tSbgJxYAEvcMnJN7c+25nchbIGjecC6Ln1Lh3zp2TEtzePFul
         pX0zi0DiR7KiSiXJaqGzC9Llnd4jYPLxJWzOiOheoLoyp5T6Rr2j+olWpAJELtfmn8lH
         1cQzrnDJfWiRwJvOm7a7YzcFV5RobhwYQr3g4pS4zajTggb+RkhofvR3CGzSWzpVf7cS
         cL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709169918; x=1709774718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7ktcIFREdgHgSgjRN6hEYBtA4ZTkOoctqP6rT6gcgc=;
        b=Fo23iSHblLAgh8IxyxR2oIvA9sH1otpSOFJbyfPUx0CrcGj/U+NN3YbDUUTP4gPUai
         Drto3aLp4zlm0ms5bjOEu/xZg6rtxs7OLld92Gswfus3G63xNg647bfMtRPvWB/3jYNF
         K4l4g8CkuTOEbzvjKPGmtxhomK/ml9M0ueWzyOgVmyVupGTuhK1+YjyuCsIqWHjfGblV
         lZgIBNMBS0lPymrHL1a3qY+Cfl3T/moUmSfTDTJinuNEQiUiHAWeSnoLo559xPzMEvOJ
         r1kHjaXfBcRUqnfUUO/MzgT5wzyI6HODfvEZelD1D8AtZukMOKhcOHmmHfc0MA/POc5W
         tE+w==
X-Forwarded-Encrypted: i=1; AJvYcCWKUKUYwEJPua4ZgKopGJr6MDbLeLVP1XjMp4j87hrWz+1DKht0fnQBfrEJnrqAB3lfeM/FWivWbRGPQqlHwuhQQ9FA
X-Gm-Message-State: AOJu0YxAiWDoVdL3RlJBvaU8qKZw7GXdVn8LWAMe0AsFYewpAd1peh+Q
	+NMUNudGFFBoy84lcupwrI497GMTBKSJG4OBCSVPT1jgNSQIz/wbF5hNGYhU5miIWyfl+PjIp5i
	XD47wUARLsL0pIMyJ5uoClXrZ2cY=
X-Google-Smtp-Source: AGHT+IGXw9ctNd3CFBqmUDFJOeaygeNnZryiOD9dAQ5KlPjajTlq6xUgIbjj74FW2Rw0NkLMl/9vzW/xyF8NOiwCUvI=
X-Received: by 2002:a17:902:cecf:b0:1dc:ca39:11f9 with SMTP id
 d15-20020a170902cecf00b001dcca3911f9mr683496plg.17.1709169917668; Wed, 28 Feb
 2024 17:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207153550.856536-1-jolsa@kernel.org> <CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>
 <ZceWuIgsmiLYyCxQ@krava> <CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com>
 <ZctcEpz3fHK4RqUX@krava> <ZdhmKQ1_vpCJTS_U@krava> <CAEf4BzYXDuPi9eqikn_mhH2Q30K6PHOSGrVn0BVzR4098FNWtg@mail.gmail.com>
In-Reply-To: <CAEf4BzYXDuPi9eqikn_mhH2Q30K6PHOSGrVn0BVzR4098FNWtg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 17:25:05 -0800
Message-ID: <CAEf4BzacHniEApUFjO8af77oGL2fm+05oTxhKJK44so5QWW4Yg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: Add support to attach return prog
 in kprobe multi
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:43=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Feb 23, 2024 at 1:32=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Tue, Feb 13, 2024 at 01:09:54PM +0100, Jiri Olsa wrote:
> > > On Mon, Feb 12, 2024 at 08:06:06PM -0800, Andrii Nakryiko wrote:
> > >
> > > SNIP
> > >
> > > > > > But the way you implement it with extra flag and extra fd param=
eter
> > > > > > makes it harder to have a nice high-level support in libbpf (an=
d
> > > > > > presumably other BPF loader libraries) for this.
> > > > > >
> > > > > > When I was thinking about doing something like this, I was cons=
idering
> > > > > > adding a new program type, actually. That way it's possible to =
define
> > > > > > this "let's skip return probe" protocol without backwards
> > > > > > compatibility concerns. It's easier to use it declaratively in =
libbpf.
> > > > >
> > > > > ok, that seems cleaner.. but we need to use current kprobe progra=
ms,
> > > > > so not sure at the moment how would that fit in.. did you mean ne=
w
> > > > > link type?
> > > >
> > > > It's kind of a less important detail, actually. New program type wo=
uld
> > > > allow us to have an entirely different context type, but I think we
> > > > can make do with the existing kprobe program type. We can have a
> > > > separate attach_type and link type, just like multi-kprobe and
> > > > multi-uprobe are still kprobe programs.
> > >
> > > ok, having new attach type on top of kprobe_multi link makes sense
> >
> > hi,
> > I have further question in here.. ;-)
> >
> > so I implemented the new behaviour on top of new attach_type, but I kee=
p
> > thinking that it's the 'same/similar logic' as if I added extra flag to
> > attr.link_create.kprobe_multi.flags, which results in much simpler chan=
ge
> >
> > is following logic breaking backward compatibility in any way?
>
> Even if it doesn't break compatibility, isn't new attach_type better
> to explicitly show that semantics is completely different (it's two
> BPF program executions, before and after, for each specified kprobe),
> isn't that different enough? We can also have a different set of
> helpers for this kwrapper/uwrapper program type (probably could do it
> through flags as well, but attach_type again seems a better fit
> here..)?
>
> What makes it harder if you are doing it as a new attach_type?

I just looked at the RFC patches you sent, and I guess it looks fine
to me with the flag as well, given kretprobe.multi is also specified
through flags.

>
> >
> >   - having new flag in attr.link_create.kprobe_multi.flags
> >   - that force the attach of the bpf program to entry/exit function pro=
bes
> >   - and the kprobe entry program return value now controls invocation
> >     on the exit probe
> >
> > so the new flag changes the semantics of the entry program return value=
,
> > which seems fine to me, because it depends on the new flag.. do I miss
> > any other problem with that?
> >
> > thanks,
> > jirka
> >
> > >
> > > >
> > > > >
> > > > > > You just declare SEC("kprobe.wrap/...") (or whatever the name,
> > > > > > something to designate that it's both entry and exit probe) as =
one
> > > > > > program and in the code there would be some way to determine wh=
ether
> > > > > > we are in entry mode or exit mode (helper or field in the custo=
m
> > > > > > context type, the latter being faster and more usable, but it's
> > > > > > probably not critical).
> > > > >
> > > > > hum, so the single program would be for both entry and exit probe=
,
> > > > > I'll need to check how bad it'd be for us, but it'd probably mean
> > > > > just one extra tail call, so it's likely ok
> > > >
> > > > I guess, I don't know what you are doing there :) I'd recommend
> > > > looking at utilizing BPF global subprogs instead of tail calls, if
> > > > your kernel allows for that, as that's a saner way to scale BPF
> > > > verification.
> > >
>
> [...]

