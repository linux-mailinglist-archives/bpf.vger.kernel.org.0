Return-Path: <bpf+bounces-71043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3AEBE054A
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 21:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C803B19A7684
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 19:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334DE303A0E;
	Wed, 15 Oct 2025 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXGfhY+y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199E9325480
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555638; cv=none; b=DDHEp/BTbgmA6EDiXmvsxyaBbxwUMVaRJkg5sE3b24q9C6jIjLVeNFDD2v6zWy1HP2QLIL5zaAcIZmN5bXI0EK3vcPdnNEcjLar0HBEG2Bj3EYx3DNcK/sP50eoAvxXUUpOanOlFZsmuHx34vRgmgTO5XBy8HXmtlncy05DLzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555638; c=relaxed/simple;
	bh=t+8Y1405ukY8Wtl22Z+nyM7LsSDFRvNQCBGFFWUgSsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QT+qstEKIcQPQ+J3JXDoaPeYnK5PHNcNKJYB9kJgfJ8Q5FbWPMfXtCQJ8b9NWOXHMzcLN9jdcWWf4R3qfABrLImiJfb0jcqfF3WPAGBK9+eKC+i9bz7ks0s1HBfpR7zrgQ0maVLBfI41oa+1x/7TcqDPB05TtXC+vfGCDL6gKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXGfhY+y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso1306542f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 12:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760555635; x=1761160435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CChnfcf6zcfndAmXqX34LWiDtV69k6Cn6eK9Wq7kglo=;
        b=IXGfhY+yga44+RjeExcbJS70lPxOahIh7n0WbanHHm4FjRkntpOQAEm6Vy0ppz+jkW
         TxQS/62o4iP66Q8Znu1eC89CDG+WagXmotWqdiGTlpBNwiz6no0BgoR0e5OD39SZivFK
         zU+n4JhZvLN92/5A7eIgBHWjaH2AKDCDfoQjR1kd6nRTmmYszZuJPGLdi2UXhwyeFCD4
         Xrqsc1wtaT3tY3eGk5B52k/Vuq0yi39IHGIuKsrYJWhJ6VPZ3TZ7GHOWx9nNaskIaWjH
         1j3od9COwrg9uAQt7bCb2XAsxQB3bqrMZmC3GosOWTsMmniTdB4gprV1MiveTMZPaa7C
         /oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760555635; x=1761160435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CChnfcf6zcfndAmXqX34LWiDtV69k6Cn6eK9Wq7kglo=;
        b=oVGCEECC2h6HTMcuQxhC6NChTqewXmuK5CvAC6oeOGFzmhD4k69ZHbQU1+iDKpfU3J
         VqvBLVg2EJmG4xkoXc0esP25aP7HJvRcOfhR9co7VuI2gLdWcNpKYNcViA4PBGUoJmX0
         LYzgJmI70nN8dakgvHziXyenpYQbu3Kuk3Wr1ozCkXzZFtSZMzmuUEAxNjUkMv8ssskQ
         jrFoFJaZ909MoOosHvugGXoqwGglchJm/5v+W+S8Apn15F8eUTwNoJaNptgx2/94QZqv
         h6Y4Gv+iNcO5gmHl3JND7LkiRekkBcCxfKkImlBLBRn9Nmr70/rE4S5f5wOwgaM/DPW0
         Lbuw==
X-Forwarded-Encrypted: i=1; AJvYcCWwwVXHjegR3fyJt0eePp+EjyVjY1WRBnkBJ5bBi2dv0Vwr3Y69NfqBGhEOj7nQ2AIljwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9cFpnUi+UcTemcywzhE/74p3H/CifsQxfL3cQ+iADLHZGbjms
	yjZt7KwohjAzw6w7KnsxTVYKRUXx9ltnYy6YDumbwWjjivwp7bjOa1QimrI6NzVyc4CZ/Svi6FI
	sP+5BuK8jFtK4vAX3WQvlqwLKQcE+KHY=
X-Gm-Gg: ASbGncuMeF1GWcKQR1nupu3IczGfOcKSJRYpgcu+hiqOsJns/nm5AOV5bY0ob9BC6mH
	82aXY2C1rOI6bePOqbzKYhX1e7J59XawZhS5q5tUMK2AYjkrsh1vi7y7Xf/4sWyyg5J6x0siA+O
	p7ovcGByStZRHUxcfzZ38ze2HVWOPnY5HXp30Ulg8Irj7Em7Mk5jflkwivkDq6VcGh3VZ/2SuVK
	cKNR6aR3QGuWAOy+y73kQq9Y2a9vzYiaopIhlFzu8BT1K+1wIZ8OVyrJi5Rn0dtRW1QVbxZiLNI
	r6cJ
X-Google-Smtp-Source: AGHT+IGuIfNjpJO+Je7q79TTwCR08Imxyhj4sqV5o/m9tM1n9LeS6BGmdnWaVdUzd6yYSJDnKm/4O1Oqupl13HrxGwU=
X-Received: by 2002:a05:6000:240d:b0:426:d53c:23a1 with SMTP id
 ffacd0b85a97d-426fb6a75b1mr1097324f8f.11.1760555635138; Wed, 15 Oct 2025
 12:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com> <066d090c7f0b9e2f3ba815b366396a96146ae5cc.camel@gmail.com>
In-Reply-To: <066d090c7f0b9e2f3ba815b366396a96146ae5cc.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 Oct 2025 12:13:43 -0700
X-Gm-Features: AS18NWDxMGy-c943XljDibNzDsai9XcqK5OdVT65e-ZnbihE3EUSM6tK0u7uSao
Message-ID: <CAADnVQ+=b81BQsMGJ9urLjsEo+2g099gTSZA0W-=jD8ghB_vow@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] bpf: Introduce file dynptr
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 11:40=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > This series adds a new dynptr kind, file dynptr, which enables BPF
> > programs to perform safe reads from files in a structured way.
> > Initial motivations include:
> >  * Parsing the executable=E2=80=99s ELF to locate thread-local variable=
 symbols
> >  * Capturing stack traces when frame pointers are disabled
> >
> > By leveraging the existing dynptr abstraction, we reuse the verifier=E2=
=80=99s
> > lifetime/size checks and keep the API consistent with existing dynptr
> > read helpers.
> >
> > Technical details:
> > 1. Reuses the existing freader library to read files a folio at a time.
> > 2. bpf_dynptr_slice() and bpf_dynptr_read() always copy data from folio=
s
> > into a program-provided buffer; zero-copy access is intentionally not
> > supported to keep it simple.
> > 3. Reads may sleep if the requested folios are not in the page cache.
> > 4. Few verifier changes required:
> >   * Support dynptr destruction in kfuncs
> >   * Add kfunc address substitution based on whether the program runs in
> >   a sleepable or non-sleepable context.
> >
> > Testing:
> > The final patch adds a selftest that parses the executable=E2=80=99s EL=
F to
> > locate thread-local symbol information, demonstrating the file dynptr
> > workflow end-to-end.
>
> Nit: could you please include summary of changes between patch-set
>      versions in the cover letter?

... and lore links to all previous revisions, so that cover
letter has full history.

