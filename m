Return-Path: <bpf+bounces-50302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C16A24EED
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 17:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D621163F48
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E9C1F9F73;
	Sun,  2 Feb 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGnLMTLE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20E184F;
	Sun,  2 Feb 2025 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738513709; cv=none; b=Pwkhe+IXPt2sx9hlao887xqEt6gSxDZ3rxuEZkyzHpUcSzZ2uiZLChFuSA4s2T2O8VIjOwHtupvn0e3rxw5QSQsJ3bJ8sDTQm8h0NO+s7Zdgu+fAm+5uhc4hJxLAH5Uqc9fXYbiwSV7CxD77a7MbpjFw4awj0L+/ZbJK6d7OkKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738513709; c=relaxed/simple;
	bh=hH2gKDZYF6YPY3Z9ig5KvL2NDIZAV2UUO3sWjlNVON0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kbw2HR6MoM2vDkhlbylnSVIyurOhtNz/3lGtwtKK2S6WRilbU+rAv4EDGp/Vki3HQrnX72Uv4f4uCnNf6sZPDSM1Q2lsyEIWdTPrf9jPo8aG/gTk7lglkHOTWUiz3M9HFWppzy3OC08s/mM6xcI0FyQu8rsyELSQyhZKR4fKK58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGnLMTLE; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2b33aabfe46so1469186fac.2;
        Sun, 02 Feb 2025 08:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738513707; x=1739118507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJYEruVdd2EoiEw8T89XbXeVscX7L5Viq0hbZjRla7c=;
        b=GGnLMTLEHevTzQZFQvpKC3UgxuPHxCHhfduaBg1tKzoR9DCKzgLg4d5gPi5dxELucw
         YLgP9ISXDI6xQmqM6IfGnbAyXj1feE6C+hDqX/ST2FfioM1klHgsIzeHKKNtCuTmOWju
         EnLoJfDFOfjpvDfeowHg+zh0qEw5d6z/5PbU0dazycCSrYej6NgoT44cqx/ipr1PtNZw
         +l0jgbYj8AUzwwO67BKFNMK36rtKvLTqOeXjXrqlWUCdZe1Wl1ZDbBOuJZXZK4oU342y
         AO3IRMrYwj6G4tn0pOLv7W59WsBUfTI4wo4hc74qrEPe3AyejjbstXUUHstgs4+8a5Kn
         VisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738513707; x=1739118507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJYEruVdd2EoiEw8T89XbXeVscX7L5Viq0hbZjRla7c=;
        b=lI0G67p8rwYlhRmuDKyqgxy/piNWg+jfsKn86kaXaTJHCC0NIz+ur8yULlPGLn6rTe
         E9zB/7tNI1GgY0OJuZ4weKVFiBz7PMXK3Cs4zKIKjo/hFeh30qIdYUfeeUn8a9clZq1g
         rt2QFbCnBF4W8kAdeISy2beMduO8ApG7Qr5+qD3X4fZdJYips/Ttdszpb6vIGLpCCiL7
         wJ9sKbBoaEGQU+0ujSu3nsvRiMO7wtwXmXUiWM9EQX9q9ZQMswbohlGsLfVfA3yv9Loc
         zoUE/Vd9Pz5tyD0N3TpD4GwflcJsFk2ZCof6Pn2V4rs6RWUT8ZzHhNsuOvis0UiwqTHj
         FSWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgmbT5RvIn+DvksGO0FwkxzWufXKj6IXlcy90lEdzo2kUqoBW0xnf9MtmR2Vpkg7mHUTw=@vger.kernel.org, AJvYcCUltg15YQRGYMyWeUP8s0VwZsi4y8hTSJBQHbbEJgWUYKwxfm+dcw4iUhNHQ3p78hE0AoSql+jjo7T9vHAw2C4qngbq@vger.kernel.org, AJvYcCV0JDsL5E5PBdSLhEiP0Hh6eSKVyf4IvYU3KjyEK+9O37JFq/rtdnnILgup3EmU8s7KJAPtlYOCgT6Xzf1o@vger.kernel.org, AJvYcCX4ltwr+C70c/gljm9m29cLF2oHrmmzNZBdaGVGBHBv31jqQd1VCBz4g1KyqPhWXHUuM2yV5Tta@vger.kernel.org, AJvYcCXDVdVmy2j/M+nWxby9bqFYuNCwLYDTsaEzcnPKEw81Nc0RP930sPsPqx8Zi5Lpi2RiMcriX5UHNn1S@vger.kernel.org
X-Gm-Message-State: AOJu0YyOerkJ73DiCzFyslj65i7sAyoJKc3m1pixdEK+aSvmaQTBU2DK
	XHBS3PDAg80K9XhSOVHlC9KSeGT/PqmTW5VUkSQ9WS+7sFUu5vvHCOU00p4DQ71ZqVjF7+jmQ3a
	yOHX1kPKWNGDjE4hrRSsztO48P6Y=
X-Gm-Gg: ASbGnct8tg5uvgeewzHJP2Em6Ma8NsgP4jcA0Z7xK49U0BWVWeV+Y0hzP2p6WmwiqNG
	mLyyHCe+ZC+7od0uxCk+YjsnJDqWCcM39e6XApf3EVUD+3vwpSm4CU21LehrPTNIDzMBLOn82
X-Google-Smtp-Source: AGHT+IGn741Xj/QS7AnO2C9c6a8XJriGTvjUbqpJ0SdHpzK+NuuemcpGOuLv52rxaMxzanXnyZjEAo3aPc8sgy8j5DI=
X-Received: by 2002:a05:6870:6f08:b0:296:ee2e:a23c with SMTP id
 586e51a60fabf-2b32ef5a57bmr11882258fac.5.1738513706923; Sun, 02 Feb 2025
 08:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
 <202501281634.7F398CEA87@keescook> <CAHsH6Gsv3DB0O5oiEDsf2+Go4O1+tnKm-Ab0QPyohKSaroSxxA@mail.gmail.com>
 <Z5s3S5X8FYJDAHfR@krava> <CAHsH6GvsGbZ4a=-oSpD1j8jx11T=Y4SysAtkzAu+H4_Gh7v3Qg@mail.gmail.com>
 <Z5v063xNVJfXCnKV@krava> <Z59SHdsme3qlx8UZ@krava>
In-Reply-To: <Z59SHdsme3qlx8UZ@krava>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Sun, 2 Feb 2025 08:28:15 -0800
X-Gm-Features: AWEUYZmMInCQfdYmLdKeYH2Tuq4c9g6GekGouyqDF0PSlt3y3Nz6pLbxBwLR_FA
Message-ID: <CAHsH6Gv17_wo4hESUqEvNGvVc8UNAJYYSp96K8LGj1BjuvrV1A@mail.gmail.com>
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without filtering
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Kees Cook <kees@kernel.org>, luto@amacapital.net, wad@chromium.org, oleg@redhat.com, 
	mhiramat@kernel.org, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	cyphar@cyphar.com, songliubraving@fb.com, yhs@fb.com, 
	john.fastabend@gmail.com, peterz@infradead.org, tglx@linutronix.de, 
	bp@alien8.de, daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com, 
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com, 
	bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 3:08=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, Jan 30, 2025 at 10:53:47PM +0100, Jiri Olsa wrote:
>
> SNIP
>
> > > > > I think this would mean that this test suite would need to run as
> > > > > privileged. Is that Ok? or maybe it'd be better to have a new sui=
te?
> > > > >
> > > > > > With at least these cases combinations below. Check each of:
> > > > > >
> > > > > >         - not using uretprobe passes
> > > > > >         - using uretprobe passes (and validates that uretprobe =
did work)
> > > > > >
> > > > > > in each of the following conditions:
> > > > > >
> > > > > >         - default-allow filter
> > > > > >         - default-block filter
> > > > > >         - filter explicitly blocking __NR_uretprobe and nothing=
 else
> > > > > >         - filter explicitly allowing __NR_uretprobe (and only o=
ther
> > > > > >           required syscalls)
> > > > >
> > > > > Ok.
> > > >
> > > > please let me know if I can help in any way with tests
> > >
> > > Thanks! Is there a way to partition this work? I'd appreciate the hel=
p
> > > if we can find some way of doing so.
> >
> > sure, I'll check the seccomp selftests and let you know
>
> hi,
> if it's any help, feel free to use the code below that creates uretprobe,
> it could be bit simpler if we use libbpf, but I think that's not an optio=
n

Thank you very much!
Eyal.

