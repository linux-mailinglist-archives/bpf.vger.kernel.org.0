Return-Path: <bpf+bounces-78275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2274D06E3C
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 03:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E29A300E8D3
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 02:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6F831A05E;
	Fri,  9 Jan 2026 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckPsTtlW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540272E764D
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767927249; cv=none; b=nAMOYssljhLZmYLzOh6EzJ25LD39yE8KK8pMsDc7lxHfoIgRDTGN7qLH6NvToxY0n9BbWbBLtt77sR2hftE2zNgtS9ew4RBwI01Krd0BgtLm2tWg6K8VlR/XbsKz6b6579hmtLZyafDU4Szt0et47FnDTGTlk36jMw2gDXZmk4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767927249; c=relaxed/simple;
	bh=hH7wgjaWxa0FYw0kb/Gbii9Xh3dhVydAUVtTyjGUrG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxPBFTYFwevc/UxcghPz9z+IHRq3Cw+hJyIz5bV2VuiYc+8unmjzQEphBOVECyRdjf2Dci4qlzJSI5bkP4TMHkPeKtcFwntRi6KfKwug866yz0eNlRebK+WLR0b7gwPi9oiJIGw154WsQIcdJKnGenAbpzCtEraScEY1R5hQKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckPsTtlW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d28870ddso690003f8f.3
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 18:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767927246; x=1768532046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbU2Pp5Em5DwHirgnQ62/oWwr5tj1iPwm211miSamZM=;
        b=ckPsTtlW/lsOJCYoMF6AgVWVcE8VEF7qpRM8Pw7M51uAQXjeagN4B7En3xZfz4Deg4
         k4f2Cq5iU284U0V1olSls9gRoxZMC13EaHhK2OeVfakrr6Ag8ez8hVdk0GH0+Dr5Pcug
         4B5wQZIp3VOMaq+v/NGW2rnClZYjF0F76O6rsJhUhlA67SUHgE8NvNwrrx2DKYC84VBp
         E2xmfmT9m4mSMKU7iKj0LP4AGtrysHz2OvGoHcjyf3Q44nxhFp9IDIVpMcAn9PAx8nQ9
         /yoUaTErMaIOkl6LYneXEIj6g3X2rhGhueENlTQOV00D/EatVjjek7Br93sTBJpO1hA+
         N6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767927246; x=1768532046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zbU2Pp5Em5DwHirgnQ62/oWwr5tj1iPwm211miSamZM=;
        b=rn2sCSuNQfb7w8XZeJwujUaxb8acvJjKbSn0HrwsWiFfwetfDP6pmAYh3Ezl2ZOXzi
         BOA+rLd1/3V3KWx75BptYZfPxE9+vlqND5ruuNKvYCZSkQYbFe5Ir5RWjVDftP9nvZHR
         t8suDgMl1W+2c/QXfvxlzZ3nt6244/mzSg6xCppCctu7FotVn8ew0qgMadMv1oDwboJY
         fY0bHGVR0ielXbHqyJfMvXiVluXbaz0yMkZuxfORalCKKdNbro431Kb3M8lJ5GxvoS5C
         Y35pCxN/+J06NDMZ1b0tKVqeTl9dZmW57/017KluAFxGcqvQHAggEpglIRa6XrwM9LyC
         x9qw==
X-Forwarded-Encrypted: i=1; AJvYcCVDHy9R1f5XhaU6gM4kCZp1reEBuFdcS/jNuDdNC4P/jGadW6UoMs4hNEq1+l+8UaSVOjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuRpLbPl2AE4EDlX9lOVA7VHoghr9afoTpvzib3mlLd6AZ0j/D
	ACs6n6iMwLsSsQkwZib+A6jCgjHCPxDiSy00+inMXPlnkADvLLYboOyQ/WwMgbGoE3ls4pjGMgc
	woJVtxLQYxP8tGT8SiG4d1HgJLnjzARc=
X-Gm-Gg: AY/fxX63hz2C+1pah0RVFZsNvFNy57fqRvZYx+wLqJvPkArl+yX5IeXd8lQ54nBER6O
	f1bH72yfc8HIMzuscVsNb0smGCGzxz4DRf3iIakf/H6ZJgnRWsfZHtuh0u3cdQ26EIxsMKZIh2j
	gAggMGUxbjUUdePakHNS0XBAlgvm52FoMlc/GW42+FEXPdLQLP2Fs5rCC/5qzVZXBqbmzfQ5ntE
	OVjMun6f2jclr9HgLsZ9N6pGPx4xCe/ZRekQgF+kYc57EXsiIothnAGXIB8wpyWS4+VQhKczyNa
	foC4AWf1MAWuvnA5m3mKmY6o1Wyp
X-Google-Smtp-Source: AGHT+IHwT0tLewsay21AhJ68o5l+UwA+efLA2bBvJ2oPagdv7QxMG9nivdVqAMeOeOWu0/Jv4bWlPfsjJzE0XA62jWk=
X-Received: by 2002:a05:6000:1843:b0:432:b951:e9ff with SMTP id
 ffacd0b85a97d-432c376158amr11309112f8f.53.1767927246333; Thu, 08 Jan 2026
 18:54:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103022310.935686-1-puranjay@kernel.org> <20260103022310.935686-2-puranjay@kernel.org>
 <CAEf4BzYeF2sUqEzfT6aLuBVuh1W8fkxHoFjBf-e5nvJW9UgQLw@mail.gmail.com>
 <CANk7y0j_BW_t7Y6rPm-UaCsamJ6G3S9i5_0cYLWZ56xp1Dehkw@mail.gmail.com>
 <cf707af183cd296c33576e478c5ba5f561350b43.camel@gmail.com>
 <CAADnVQ+wK8qYt=Gm=Q26Kh_enOHGOk7_t8FX70J08WUMu5y_Nw@mail.gmail.com> <b0c80439d8da0faddde08260d6e796629d55e9d6.camel@gmail.com>
In-Reply-To: <b0c80439d8da0faddde08260d6e796629d55e9d6.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Jan 2026 18:53:55 -0800
X-Gm-Features: AZwV_Qjs8KqWSlu4dtQLpcYImt2X9h4g-TCQRQ-nelsIwyiFjOOOF7t0idZkNbw
Message-ID: <CAADnVQJnjZjRdJNgSOSzt8z8DfRN7z5Ksgfi5gkY-O4Dp1e-yA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Recognize special arithmetic shift
 in the verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 6:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2026-01-08 at 17:18 -0800, Alexei Starovoitov wrote:
> > On Thu, Jan 8, 2026 at 10:45=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Thu, 2026-01-08 at 18:28 +0000, Puranjay Mohan wrote:
> > >
> > > [...]
> > >
> > > > This is what you see when you compare this version (fork before and=
)
> > > > and previous (fork after arsh) on the selftests added in this set:
> > > >
> > > > ../../veristat/src/veristat -C -e file,prog,states,insns -f
> > > > "insns_pct>1" fork_after_arsh fork_before_and
> > > > File                   Program  States (A)  States (B)  States (DIF=
F)
> > > > Insns (A)  Insns (B)  Insns (DIFF)
> > > > ---------------------  -------  ----------  ----------  -----------=
--
> > > > ---------  ---------  ------------
> > > > verifier_subreg.bpf.o  arsh_31           1           1    +0 (+0.00=
%)
> > > >        12         11   -1 (-8.33%)
> > > > verifier_subreg.bpf.o  arsh_63           1           1    +0 (+0.00=
%)
> > > >        12         11   -1 (-8.33%)
> > >
> > > Given that difference is very small, I'd prefer forking after arsh.
> >
> > why?
> > I thought last time we discussed the conclusion was to fork it
> > before AND, since at the time of ARSH the range is still properly repre=
sented,
> > so reason to take chances and do it early.
> >
> > > Could you please take a cursory look at DAGCombiner implementation an=
d
> > > try to check if there are other patterns that use arsh or arsh+and is
> > > the only one?
> >
> > Well, it's in commit log:
> >
> >   // select_cc setlt X, 0, A, 0 -> and (sra X, size(X)-1), A
> >   // select_cc setgt X, 0, A, 0 -> and (not (sra X, size(X)-1)), A
> >
> > I suspect 2nd case should work with 'before AND' approach too,
> > since 'not' should be compiled into XOR which suppose to [-1,0] ->
> > into the same [-1, 0]
> > But better to double check, of course.
>
> Here another example from DAGCombiner.cpp:
>
>   i32 X > -1 ? C1 : -1 --> (X >>s 31) | C1
>
> The same trick, X>>s31 is in range [-1,0].
> But we can fork on OR as well, of-course.

Good catch. This one can also be done "before OR".
I doubt there will be more combinations that make
"after ARSH" argument stronger.
I guess I don't mind either option. Let's pick.

