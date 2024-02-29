Return-Path: <bpf+bounces-22979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB40886BCF3
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403CD1F25000
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078DA168B7;
	Thu, 29 Feb 2024 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwFAn02S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE42D046
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167396; cv=none; b=L9C24sRVuhjv5p16FiPHmeoQ5A3UZ2YOI+bFZ1acEMqt5kSFExthNSiL27s/BLCmoDyJvD75I+NoO9GDLdqxljOFjTTy4O/NFr8sb/o6NW9T8tc5ufZDKBusgY3S2MPoZwC8IwAmZFgbJ6yWLTmOCRsWf0UKTzUpolKqm80npow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167396; c=relaxed/simple;
	bh=W6U61PTLWWRXeqv9Yrsj+RIkVtDlR1YyW/kVnFwhL/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFjkjGbP9QLk9087HFiMDL/oNplQ96xO+hwYRuqNmmCI3K/CIFqZUXWeoiDP3417e80o+Z698afgCwLI1bSqRU8YHphb1e26iCobuAqy7dIGbv+FD5AmBP911eigU1zeNo2VaWZZF9wIRMuVPlVYtNI7r2vkBY6/YbR0UtfJ348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwFAn02S; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so290750a12.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709167394; x=1709772194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODFFkEpIINipZBbRi3SuMLI4Q63P1AegHDgSaA5pSF0=;
        b=QwFAn02SOafL+I8OJLm7enAB2VVDbtQRF37ZCulGK/tCF1QthAVbOxCDVz6atNBKCZ
         aHB9ZENCGl8b+AeC5EAUSalqLj/OQFPHXTPy9tkjizJ9hvDPiR5Da2JG5cHVYApJL0Lf
         EwGPIrG4cXu459+CuB4nf0EUURr0k62842nvk3WWboPXAxqORGzt8R6g82nlxMkivs4U
         dM370u2WvYP046lYcNj0ZR9zahZNtYDUFz8u2gXgUc0ITyWGlfZ+mYRwyb9XpgA4D2RZ
         fPNePfpAz3uhnTjJ1zJMwiWWuFbhr6nRV526bhSWpbMLcgUlFZzSg10J0Wr7TxJpc23R
         Givw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167394; x=1709772194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODFFkEpIINipZBbRi3SuMLI4Q63P1AegHDgSaA5pSF0=;
        b=XX8wzUnm4syDtAb89uDwZ0npDw3fvyI9e6+xx5t4xZpyszpn0u32O5SBpuSkPYG0EC
         sC0+OHF6o4dnjbEpPOh6QgkyXBoNoep7NtXHjaAY76/Q7LHD7LQTOuWCgyQrp6oz0BlZ
         xR7sodKdGQJ1DbW84Yyuw2tR2okn9mOkGeZ5TA2PDLiZmNktTbAKU+PBq6InPjah7ct/
         olWAhk49fR6/3IEt4KW05uvYT6z0sDpa6hzJW8J3oe/0YzLjFP5tTivnpxo6rXJN/guV
         apkLbmf5rsOd1kC9GtlY71fo5Q40vuJWUNj1SZoP4bUJxnbSNlZay8agwnwKJ+CMU5Rq
         Zyyg==
X-Forwarded-Encrypted: i=1; AJvYcCXSIJzYOCaVLskshcwDNLH3Q8cMp3OabCxTMf07IQhBj84KBcz1oq9Yx7ekQPBDdVRL/aJD5N/8KiRO9F6j6Sz3Q+Zl
X-Gm-Message-State: AOJu0YyrsgeZoaGp+Vo3V2s7JVdcXw22RMiZ1LmXPk/jwLw/Tpa5nWqk
	KE1iA2EH3Z0lLt2Sr9CIv8cnPMCN0IRTI6QcUH5WMK5rqzwwlE4WSFLQv0AhpMP8HEHRPPyU1O5
	ZsDwSUjBiWSZJHq6W7vVpirh8aMs=
X-Google-Smtp-Source: AGHT+IGdr5inLwi6Kgk5vnmmRMrnVWFdk3yms3+EK3z9FPDiDS6i4s6Enaztwbj6Qc0LCVxBZZHLBKr4R9CgitmABY8=
X-Received: by 2002:a17:90b:3697:b0:29b:c09:cdc3 with SMTP id
 mj23-20020a17090b369700b0029b0c09cdc3mr255535pjb.19.1709167394333; Wed, 28
 Feb 2024 16:43:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207153550.856536-1-jolsa@kernel.org> <CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>
 <ZceWuIgsmiLYyCxQ@krava> <CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com>
 <ZctcEpz3fHK4RqUX@krava> <ZdhmKQ1_vpCJTS_U@krava>
In-Reply-To: <ZdhmKQ1_vpCJTS_U@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 16:43:02 -0800
Message-ID: <CAEf4BzYXDuPi9eqikn_mhH2Q30K6PHOSGrVn0BVzR4098FNWtg@mail.gmail.com>
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

On Fri, Feb 23, 2024 at 1:32=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Feb 13, 2024 at 01:09:54PM +0100, Jiri Olsa wrote:
> > On Mon, Feb 12, 2024 at 08:06:06PM -0800, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > > > > But the way you implement it with extra flag and extra fd paramet=
er
> > > > > makes it harder to have a nice high-level support in libbpf (and
> > > > > presumably other BPF loader libraries) for this.
> > > > >
> > > > > When I was thinking about doing something like this, I was consid=
ering
> > > > > adding a new program type, actually. That way it's possible to de=
fine
> > > > > this "let's skip return probe" protocol without backwards
> > > > > compatibility concerns. It's easier to use it declaratively in li=
bbpf.
> > > >
> > > > ok, that seems cleaner.. but we need to use current kprobe programs=
,
> > > > so not sure at the moment how would that fit in.. did you mean new
> > > > link type?
> > >
> > > It's kind of a less important detail, actually. New program type woul=
d
> > > allow us to have an entirely different context type, but I think we
> > > can make do with the existing kprobe program type. We can have a
> > > separate attach_type and link type, just like multi-kprobe and
> > > multi-uprobe are still kprobe programs.
> >
> > ok, having new attach type on top of kprobe_multi link makes sense
>
> hi,
> I have further question in here.. ;-)
>
> so I implemented the new behaviour on top of new attach_type, but I keep
> thinking that it's the 'same/similar logic' as if I added extra flag to
> attr.link_create.kprobe_multi.flags, which results in much simpler change
>
> is following logic breaking backward compatibility in any way?

Even if it doesn't break compatibility, isn't new attach_type better
to explicitly show that semantics is completely different (it's two
BPF program executions, before and after, for each specified kprobe),
isn't that different enough? We can also have a different set of
helpers for this kwrapper/uwrapper program type (probably could do it
through flags as well, but attach_type again seems a better fit
here..)?

What makes it harder if you are doing it as a new attach_type?

>
>   - having new flag in attr.link_create.kprobe_multi.flags
>   - that force the attach of the bpf program to entry/exit function probe=
s
>   - and the kprobe entry program return value now controls invocation
>     on the exit probe
>
> so the new flag changes the semantics of the entry program return value,
> which seems fine to me, because it depends on the new flag.. do I miss
> any other problem with that?
>
> thanks,
> jirka
>
> >
> > >
> > > >
> > > > > You just declare SEC("kprobe.wrap/...") (or whatever the name,
> > > > > something to designate that it's both entry and exit probe) as on=
e
> > > > > program and in the code there would be some way to determine whet=
her
> > > > > we are in entry mode or exit mode (helper or field in the custom
> > > > > context type, the latter being faster and more usable, but it's
> > > > > probably not critical).
> > > >
> > > > hum, so the single program would be for both entry and exit probe,
> > > > I'll need to check how bad it'd be for us, but it'd probably mean
> > > > just one extra tail call, so it's likely ok
> > >
> > > I guess, I don't know what you are doing there :) I'd recommend
> > > looking at utilizing BPF global subprogs instead of tail calls, if
> > > your kernel allows for that, as that's a saner way to scale BPF
> > > verification.
> >

[...]

