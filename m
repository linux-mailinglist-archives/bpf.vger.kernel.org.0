Return-Path: <bpf+bounces-44156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232C09BF812
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 21:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6166283B56
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1CC20C479;
	Wed,  6 Nov 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Isthz4l2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0520C471
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925492; cv=none; b=i1cU9rAYnwpAu2CtuK8hpAq/EnxRtFJy13RAQqS7+BZwX+r6qMLiEAHcLG4esUMJVrCNcds0CGP/KY2Yo2HgLqABxuMjEG1T56Cl303aRcNUV5lyn+oA/z+0T1ZE7x94/EBuBFhHeVudxWuGBnjKjiQmXlyawkzbcHLfBDIWYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925492; c=relaxed/simple;
	bh=+uFdKe6e2bYI8MmWJd6Y95fOEALsiYAiENw+jAmaPmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBmxLj29wujbgr59P0oH0JV6+CpNiUcl5tqFgjx4gwjVyj/edlalIB3975/U5mDKkuP5x7MGdiJmpP3PTHjmpbPDgzO6Aa7LaQcFjowMDRmVrudFG74bVZflUffPsiVUEVkQcOVjMQ70ZE3gV7O40/pysOQsct4KkSE6Ve8n3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Isthz4l2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2c6bc4840so189888a91.2
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2024 12:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730925490; x=1731530290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYYG/DhDZSIA17TJ3HnoKG9ZURGx6HC1WNl+hdA47OQ=;
        b=Isthz4l2mzfiRTRcaAONg7AqFex8S7XMMMIAstBlVAD14fLaHyPtB2kdK0FNL568kw
         lg8D6RGoa3qy4rzCI29VU2/ZAKYEDmrAgwWXpx3NIuL6C2zz30erKJzw5dh5ZWL2xl1S
         nXO0cmDJapcrCbLtAXJ4h5MOoRZ2DePcRqDUzdo/kZMikNPQ+1F+R2DPphZnBLhZFeqn
         r79Kz1ukk2HnQrWIzp8wvyaiOBD6kXaD1PWrLC/OSIJG20QPCwM6NKdgTvYTgif2Vmw5
         rwI11W0FojQUMTWqwUffmEFe59ctzv7G2VIwyYRW7qzyaG4skYECW9EQbo6BJRe3XgVi
         XsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730925490; x=1731530290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYYG/DhDZSIA17TJ3HnoKG9ZURGx6HC1WNl+hdA47OQ=;
        b=jp5Lj+RVy2gSUzT9INiWPLiJsDdQdvWuKorijsCPH2jNjV26RGHi1EOtq1+/sa559h
         zsYuUVnlEf07w2iU7VICd+qfZlnlFOUn4NtQjzShwtWDRzpw3uHbiCQO9UjEDkH/QYq+
         K+B3xmBhNmzYZcES58d1jNcaJQFd1Bwz2KtIgr9t3W1q4QjVZIuosMsSQswzHvRetSlx
         wTzvrlMQ1vOY7hdIEUTLshp7KpSjuUcPrY5Xpcz0gC1CKhfSvXewJMleEwbWMcrr2VfL
         k0+zIkxVRgKTmFSNGhfE6n1pVd8j0yffTW8ZqLI9P/B3tuIlahWjvZgeV3rJpbGLrg13
         UT8w==
X-Forwarded-Encrypted: i=1; AJvYcCXypfbHg2FFbpgpRuqM6Ic7lMOcev2jEeAQz7vjt6TFoGKIND8twMUkWXoiSzscySmDKp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPkigzuPPLR+meWFgQObRCCrq5ZsnWwsuILdibK23911S6IJp
	DAvCmtAedQ73VJs7aoYtfHmYY6x4rLuR/i3I84gvOEo0d+DEUMaCr+Eba4zcwRllJJpmm1eIvK2
	hMQF9gkxoR4zQ0ixofaAZwj1sX74=
X-Google-Smtp-Source: AGHT+IEk7rNBaUpFzaGVka1MO8WIJDFljhbyRYV9dIoC1hCfGHbAja58tPEEdm7Ul0T5J4reJJ/bP9sAP6j8rEV5/Cc=
X-Received: by 2002:a17:90b:1c85:b0:2e2:9e64:c481 with SMTP id
 98e67ed59e1d1-2e94c2e2caamr30228292a91.22.1730925490406; Wed, 06 Nov 2024
 12:38:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730449390.git.vmalik@redhat.com> <6cb7d34d0ff257deaf5bb818ac4bce3c95994d29.1730449390.git.vmalik@redhat.com>
 <CAEf4BzZ_kB3YaeA5c2cB7dyiaJna4nGBtww9n0fS_b1d-ZtMGQ@mail.gmail.com> <87a5ef9ks3.fsf@toke.dk>
In-Reply-To: <87a5ef9ks3.fsf@toke.dk>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 12:37:58 -0800
Message-ID: <CAEf4BzYiTS76Rz+PpSNt82Azp1kH9rvXhDOi1Fm9C6tefon_rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] selftests/bpf: Allow building with extra flags
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 5:43=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Nov 1, 2024 at 1:29=E2=80=AFAM Viktor Malik <vmalik@redhat.com>=
 wrote:
> >>
> >> In order to specify extra compilation or linking flags to BPF selftest=
s,
> >> it is possible to set EXTRA_CFLAGS and EXTRA_LDFLAGS from the command
> >> line. The problem is that they are not propagated to sub-make calls
> >> (runqslower, bpftool, libbpf) and in the better case are not applied, =
in
> >> the worse case cause the entire build fail.
> >>
> >> Propagate EXTRA_CFLAGS and EXTRA_LDFLAGS to the sub-makes.
> >>
> >> This, for instance, allows to build selftests as PIE with
> >>
> >>     $ make EXTRA_CFLAGS=3D'-fPIE' EXTRA_LDFLAGS=3D'-pie'
> >>
> >> Without this change, the command would fail because libbpf.a would not
> >> be built with -fPIE and other PIE binaries would not link against it.
> >>
> >> The only problem is that we have to explicitly provide empty
> >> EXTRA_CFLAGS=3D'' and EXTRA_LDFLAGS=3D'' to the builds of kernel modul=
es as
> >> we don't want to build modules with flags used for userspace (the abov=
e
> >> example would fail as kernel doesn't support PIE).
> >>
> >> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> >> ---
> >>  tools/testing/selftests/bpf/Makefile | 34 +++++++++++++++++++--------=
-
> >>  1 file changed, 23 insertions(+), 11 deletions(-)
> >>
> >
> > Ok, so this will conflict with Toke's [0]. Who should go first? :)
>
> I'm OK with rebasing on top of Viktor's patch :)

Ok, then. Thanks for the review! I've applied this patch to
bpf-next/master as well. Please rebase and resend your change.

> >
> > And given you guys touch these more obscure parts of BPF selftests
> > Makefile, I'd really appreciate it if you can help reviewing them for
> > each other :)
>
> Sure, can do!
>
> -Toke
>

