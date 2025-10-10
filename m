Return-Path: <bpf+bounces-70771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B3ABCE68F
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 21:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A0519E079E
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 19:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BC130149F;
	Fri, 10 Oct 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fvH+mQlM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5F289E36
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760125212; cv=none; b=Z4CPOEDDQk5Z4JPEwbGVWDiXGrP67auzhPH5gUcbSKUDXTzzZ1zIlHdUr5rVT/6rtOjzAaVdaSgJC/sEhLvDEUVv/dFyMTNSZRx5iWx2c2Ugko6TAmHw/vKGR2NZMbBoHnhF4YpIlQKrGQdUmR3dIey3mwi9C6WsUyVRJQxCXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760125212; c=relaxed/simple;
	bh=hrUSn+ceAo+GDbSa1VXTf4EuSMfDG3/UBPjYHHpRlXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNrd3E9SbxBzL9REsM29zW2aUzqqqein61anoFBrXqjFX2hZQmW1UF+fDPre44ray3r5tIzR+pYdKIE0eecbhN5pNpYA4L9+8J7j33w/PQyC9pvuhuo9CBprTp2h4oYRkrQ4iTyrOnIuj6lJSdlNHTCZr041Y6ckmiw+3df7sYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fvH+mQlM; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2084866a12.3
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760125210; x=1760730010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1spZuaYn2ibXuyFhDGwY3YmGssLxNzwFenv1C1bnCyw=;
        b=fvH+mQlMyodIhAHG0OiGgWTJreP4jDvCHhbQtIzqdrV/uRidTE3H4b7LH005Ce6aLo
         PgWbPj/ejx04/0HcU7cEuwMJ1qOGNK8psjTjdoQ2gKdQlJGFd7hQlCXRHKvGrn1OBING
         lE/qDIr/dqzBifMqcXS48eAfaU2DABLcYCoh8vmVjQSpOt9+mdZYTGthXuuwpKvFNXIu
         D13Q72ge/T0BKNhV6wv2+2RcBg0PGawDf/y2ZxiCXWpDqGRm0gHS/EplPE6y09ouGntE
         Kx5ziGAONnxZeKV56F6dm6cZtXydwjA3ET0f+pP+3DdW6BZs0MrfCEa9ejtPzvnCPcZl
         LmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760125210; x=1760730010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1spZuaYn2ibXuyFhDGwY3YmGssLxNzwFenv1C1bnCyw=;
        b=YrLWhemfAXkwGiIEdi1t6NhLmlorTS67uOlKI2W/ORqOAcgGGGzMmc/qpfXsTDzquS
         vh7JNFmOMLnPXIK5aVIEiChvZCIOqitJFBtUGbGrlAXOFrNrreY8GOPSw9NbIKZuSIXp
         bOPqOZzLHyvAEl9bqDgPxBw8uMU5fdBqAHcOFtJl9JDR1QqxyDJ6c3YjXsxF/XsSuKnh
         b+jRPNPS0ipxJS4u9M6RadmSDjj+3eHzFKnRK3ikVH9ZY7SnicIq/ZG05IMqf3o8GUjB
         cqjV9v1bVKAiEKFEE2FipII3kAJX5gHt8VPkoLR/0QH768BTlbr3XTDpp4DFBt0yiHAy
         rKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWafvOm83/5doTi3u/OXb5QfHdRrUHbz6Gap+/+JzjvE3ca1OdORHSwyLA62nORYTSxqfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIx3gWwfPBSUylUcjeHMxX09MR7+k3FjDhOAv944lWv4kE1pa+
	8Cd9AH6m3Z6PGHSqpbsc+0ZlFt6KyWhfrD6NN5drjUW14weGXneigaRCmNTXOTgv630L7EAGNEw
	R5s1h+OW1Ye5rMQInLfgEMTC6IuXQJZjqvLRlvK+w
X-Gm-Gg: ASbGncsiuxW/C9IEs6RFmKUUH9e1LAfqpsvKNhNyHnx46AbtgFtxiathPSD/FuYAW3H
	CvrkTQR6ZiXA30Ol2C1XN1HRcWrIT88yMdN3JjVOvVkw+gcYgBjZ3eh7lKfuBRBLyGZxJSkVDb0
	YKnp8LwNDIE8T8BUUY29xxOmN8AFl6xiDm7oAdT38RNJEIJMO0VwbmAVJb6tycmBzZle9fofbQ1
	yP9AwGkhqQY1X+5c/k00ntOiTHtd99Lzm85
X-Google-Smtp-Source: AGHT+IH1v4yTYh9hFY+GZYHVajE4mnFPafvC6wr8o3AHmTWAx1ZS9PvQ3QIG9cYTfrwrKhnmpqBf4NbUq72+A7lGSng=
X-Received: by 2002:a17:903:198b:b0:280:fe18:847b with SMTP id
 d9443c01a7336-290273ef0c1mr155175175ad.33.1760125210321; Fri, 10 Oct 2025
 12:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
 <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
 <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com>
 <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
 <CAHC9VhRyG9ooMz6wVA17WKA9xkDy=UEPVkD4zOJf5mqrANMR9g@mail.gmail.com>
 <CAADnVQLfyh=qby02AFe+MfJYr2sPExEU0YGCLV9jJk=cLoZoaA@mail.gmail.com> <88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com>
In-Reply-To: <88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Oct 2025 15:39:58 -0400
X-Gm-Features: AS18NWDiHVbVvupnRrZkUxOiLJEK77lzoTL3P5996ZGup2QQARPuOxF1njKIzL8
Message-ID: <CAHC9VhTY=K6oQPgAHuj3rRm2+9sBwLvDjdZtM+cUfSeuiW8jMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 11:53=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Thu, 2025-10-09 at 18:00 -0700, Alexei Starovoitov wrote:
> [...]
> > James's concern is valid though:
> >
> > > However, the rub for LSM is that the verification of the program
> > > map by the loader happens *after* the security_bpf_prog_load() hook
> > > has been called.
> >
> > I understand the discomfort, but that's what the kernel module
> > loading process is doing as well, so you should be concerned with
> > both. Since both are doing pretty much the same work.
>
> OK, so let me push on this one point because I don't agree with what
> you say here.  The way kernel modules and eBPF load is not equivalent.
> The kernel module signatures go over a relocateable elf binary which is
> subsequently relocated after signature verification in the kernel by
> the ELF loader.  You can regard the ELF loader as being equivalent to
> the eBPF loader in terms of function, absolutely.  However for security
> purposes the ELF loader is a trusted part of the kernel security
> envelope and its integrity is part of the kernel integrity and we have
> a this single trusted loader for every module.  In security terms
> verification of the ELF object signature is sufficient to guarantee
> integrity of the module because the integrity of the ELF loader is
> already checked.
>
> The eBPF loader, by contrast, because it contains all the relocations,
> is different for every eBPF light skeleton.  This means it's not a
> trusted part of the kernel and has to be integrity checked as well.
> Thus for eBPF, the integrity check must be over both the loader and the
> program; integrity checking is not complete until the integrity of both
> has been verified.  If you sign only the loader and embed the hash  of
> the program into the loader that is a different way of doing things,
> but the integrity check is not complete until the loader does the hash
> verification which, as has been stated many times before, is *after*
> the load LSM hook has run.
>
> There are two potential solutions to this: complete the integrity check
> before running the load hook (Blaise's patch) or add a LSM hook to
> collect the integrity information from the run of the loader.  Neither
> of these is present in the scheme you put upstream.

As a bit of background for those who weren't following the related
threads earlier this year, the idea of an additional hook was
discussed this spring and it was rejected by Alexei.

https://lore.kernel.org/linux-security-module/CAADnVQ+wE5cGhy6tgmWgUwkNutue=
Esrhh6UR8N2fzrZjt-vb4g@mail.gmail.com/

--=20
paul-moore.com

