Return-Path: <bpf+bounces-49882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2925CA1DCD8
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 20:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7BB1886504
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 19:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31EE1953BD;
	Mon, 27 Jan 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzDObP0Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6213192D66;
	Mon, 27 Jan 2025 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006799; cv=none; b=mZpeP8GG0crVgon6nOSeINJtmMLdrJQwH5Iff6oLbQKnz8o2Oc089CzcGcNViqjboTvfvbERbkRt4zVuqLSIBU7CGPjO+/a1EliWYJYDvk7ModoUfynIRq12nrxropPEFc2vx4fLcyAXMpfjBMaUZDgm76OQrCKfjRzqopECo3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006799; c=relaxed/simple;
	bh=+o1uCCMg1L2egruBz9kFH7Le73ma1y1cW1ZnO8vaNIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCXSh0yLmu9O587KQ+9baj/WYyocjwLCgz25MUCupD6FvauSpWRvfPxoJVUjD5w4xLxWDhtxd/q6SlSnuiMswlYrMVi2odIZB5QP+spvuIjdsl6v098IJ1GZhQZnCmiBKvPc/sN+WZwES2yfRkhuoAm6g87Z2O/KznuHG1e8jwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzDObP0Y; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29fc424237bso3460915fac.0;
        Mon, 27 Jan 2025 11:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738006797; x=1738611597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2GEcA+mH1ofmJouM1eKAusjVizAgetXhy76FIkhutc=;
        b=JzDObP0Yd1zlUFeCb5s0cJ1vo139MWR+Bp399q48sX/wFwkD3Q0aO/8j5YlkBbe7aB
         nTYcUa635Lv9YfAmn0Jrha6MCp2Jw4LCU1jMca7CQeHEFRAt/+cq553S+FKjOVKMddhP
         +FeMj0r+X13BrnAf8rBQ0d+hfNYYIiK6+Nss5UFN59JjhAsiqTGBTIeoWV6AVjmj0pss
         OgIpnyfm3dxDi8b0Io4i5ezYE3vEX+wIuhrvwQVbMeWsZuZ0KfdxDL8NBQuF8RU1vCju
         eJjwfby3sCPpnjvYGLaVb22j3soFlT8rspABYiolwnX2hIbW3G+2vcBGnX6yYIWZzSKB
         oI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738006797; x=1738611597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2GEcA+mH1ofmJouM1eKAusjVizAgetXhy76FIkhutc=;
        b=oLe6x6YF11dYKzDjsGrrs1sm3xO9hv6tAs5sxhaioVpvw8mBOc4Zz3UNhUodgFv32U
         yso+QVbj3hc/BqVWfK9MjtKSqj7wyGbOeaH0zv8zq1rT3cqJ+nYXQLggfyWuuzIN/6l8
         OkUikITNrnanaSouP1RvbYESp1AxYhk/xiyxdUo8GBFfnr4exCs1i4yODAvds712hsIx
         fR5OhrSc9jTDQemVMZpo2dH8XFgabjczTWxl/ihviIrYfDFl0+Aex4mpksTdO0NQNeYm
         kFk1MvEmCCpYbeBIn1BRfVq8HKu57qre8d+BUHLwYUSrzAdjjvxoqiKyWvLjmOrKc5lr
         gVLw==
X-Forwarded-Encrypted: i=1; AJvYcCUZnE6pA3tImHdgs8NDVAkJXH1T6uFmaVRuu6/deM7vteAnQC8bH0ZeMWm4jKDcoXuMr5q8vwfF6+LavsmBDG26fl9j@vger.kernel.org, AJvYcCUunp1xw75KlKd7CHMVhjDDAHkDHBU+PWIh6SLnT6qc7Tp9NRyUiDEgG/7+QTE8tdYZfI5PdEdO7bbCmof5@vger.kernel.org, AJvYcCXC036jSLRSfkkh5AEg9mGrC7RLTsWYrq/eaJZlfVaV3X/6e99rZ/5rGPigLlPLFeCAvBZGr92iPplM@vger.kernel.org, AJvYcCXKG2Q4nPROMZ69L45z2cnqaDGunModvLDIGhkmJOWJ0wRRT+HPQNGbTo/H39emRzx6l8rWqxRX@vger.kernel.org, AJvYcCXRnVKVwLpnZiq8W3l8/nl3PqSkKglvj3wQpToUlryQdS6OnpG+wc+W8QjJVohhTgdNF08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdystWdaH1eRNLk7kL7HhwqWcYOVuXTN32kfN+tiCSS38noFth
	khVNPIPJwQh4u9uZU8STEKi5UCg/Z0ycmmcyXbA40b0D4iM1AElEVkD+BrKFXPWW9g/hO1NkyRc
	OSGX/gsp9syFwFHafy6W0jkwy4GI=
X-Gm-Gg: ASbGnctapKN0roi0zanWLMejaxtV2i+2MxB/3kNpNMFJsgaTqdR1Nc4drbSa33uuu3z
	aBOwZgvacGEFHvdnjalNAcv1YD2nrIO2BGBtPmRO+AdpK+dPBubmaCliIYbG8JQ==
X-Google-Smtp-Source: AGHT+IGT6BGhF4L+xY3ymTQsTPdO+Tl5M4pKoXH973rLKuCY1GkLR0OiLVbetHM3n2OpMyw0QY+dSdairnjd3KW0848=
X-Received: by 2002:a05:6871:a594:b0:270:1884:9db1 with SMTP id
 586e51a60fabf-2b1c099c320mr21991596fac.7.1738006796982; Mon, 27 Jan 2025
 11:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook> <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org> <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
 <202501201334.604217B7@keescook> <CAHsH6Gt4EqSz6TrQa+JKG98y8CUTtOM8=dfCVy0fZ8pwXJr1pw@mail.gmail.com>
 <202501271131.7B5C22D@keescook>
In-Reply-To: <202501271131.7B5C22D@keescook>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Mon, 27 Jan 2025 11:39:44 -0800
X-Gm-Features: AWEUYZntcjRk3aPq5EXTyZb1INQIq1gcs7Hmh6OkmYgNREhN9tfyee3gFOU9PF0
Message-ID: <CAHsH6GtPBt329FeN7K4X4Hqc_uZ=a8uofDN15mqqC4obQ-RK5g@mail.gmail.com>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
To: Kees Cook <kees@kernel.org>
Cc: luto@amacapital.net, wad@chromium.org, oleg@redhat.com, ldv@strace.io, 
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 11:33=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Jan 27, 2025 at 11:24:02AM -0800, Eyal Birger wrote:
> > Hi Kees,
> >
> > On Mon, Jan 20, 2025 at 1:34=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:
> > >
> > > On Sat, Jan 18, 2025 at 07:39:25PM -0800, Eyal Birger wrote:
> > > > Alternatively, maybe this syscall implementation should be reverted=
?
> > >
> > > Honestly, that seems the best choice. I don't think any thought was
> > > given to how it would interact with syscall interposers (including
> > > ptrace, strict mode seccomp, etc).
> >
> > I don't know if you noticed Andrii's and others' comments on this [1].
> >
> > Given that:
> > - this issue requires immediate remediation
> > - there seems to be pushback for reverting the syscall implementation
> > - filtering uretprobe is not within the capabilities of seccomp without=
 this
> >   syscall (so reverting the syscall is equivalent to just passing it th=
rough
> >   seccomp)
> >
> > is it possible to consider applying this current fix, with the possibil=
ity of
> > extending seccomp in the future to support filtering uretprobe if deeme=
d
> > necessary (for example by allowing userspace to define a stricter polic=
y)?
>
> I still think this is a Docker problem, but I agree that uretprobe
> without syscall is just as unfilterable as seccomp ignoring the syscall.
>
> Can you please update the patch to use the existing action_cache bitmaps
> instead of adding an open-coded check? We can consider adding
> syscall_restart to this as well in the future...

I can. The main difference as far as I can tell is that it would not
apply to strict mode. Is that OK? it means that existing binaries using
strict mode would still crash if uretprobe is attached to them.

Eyal.

