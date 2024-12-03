Return-Path: <bpf+bounces-45982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DAC9E10B4
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 02:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB74E163EB0
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED29225A8;
	Tue,  3 Dec 2024 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EauMN50Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BEC2500D9
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733188608; cv=none; b=Wa2Mf6FWXVHoY9CBOVbjNjqMVSJ9R2wRTJfY1KVqFWiYj6NkU6v4jzeBgO1t6iYHO6CL2XMfl7XvdsWwySC4aX8GH7Jx3isDjRxywUTwoKlZpUo2PAt6ZvX/DZWNm7FFbOUX+e94aGXQERF3lisV+6FOTcYEcUsOMgFYjCo3JrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733188608; c=relaxed/simple;
	bh=5rwqcPLYU3mOyiLu4V5YPhgvsi8kHFwBcjzyOa6Hrts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiHZfaqE1IhYT8NpTbaDoNUYgs2jEuGmqkopgSUhlFuP5OlqZ/XbVloizeg2ZaHEXv/OmGO0GgiA8NfcNvHhYa8oONhIai3LdDIv6RfIaj3VdULbvxayumMI+BrqbzKWGxrVmJ5tu20YovPgGx6GZ5p47AmXMxQmm3v6/h8NNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EauMN50Y; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so5835958a12.0
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 17:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733188605; x=1733793405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+e6S5TlFNsaA5vKqNqNmP6miAcQXzF2v7GE+CB6ESU=;
        b=EauMN50Yw6zlTn6Zz3r9QxGNoPLq6s3PTQgnd/tk7WQnv+U5rhZYeuj0siW//GpIMc
         KiJuiR6l2UtlFDwNtRdBxGftG5Nr72e9bXBLfnRCbcgpY9nTVnKFwUr7P9pIu0zIeub3
         lJOVqZNHh5jDYN7p3s13oRe+xVsgtw0dc5nsf3idAXMygqUG1dIIJ7nODLz6Jn2hAdWR
         UMI7agmgf9KjHC94Zc2pk4TBuhj8MbhGYRLfGgaplhZGZ1Ule5KOLDbSaHWuZ4iNy345
         YrQnINpehxXGu9XW3KGC7atyvJe4WhYKJSciIPDkWwHbuNAeKb6uTbCrt1tlAbLevrNb
         u99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733188605; x=1733793405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+e6S5TlFNsaA5vKqNqNmP6miAcQXzF2v7GE+CB6ESU=;
        b=wZuldvCXw3ohFLIuPRX5Urn2gbp6dG7G/doEm4qpomm9xKUXdlvKVEGrKY21zSRQyn
         7mN2BacMJnNMTt8WS3XCRn2xE3ySACWxt0ywJVA7/7jBnCHVhRWenX6v4GFB/vWBBmzV
         YO4nAM7DDbvA/ddksiD+/2dNFEhh6RnFofAGQ4xWY5jwG4CYwJ8EXfGOsOWW2tQK3Jfu
         f5FryOMOzWDVMHCxsyrG0nMSDTNXlC9bB4X+oniYor2ij64YQWFvnRw5bkC+RZXt1G7O
         H83EY+Rfsg+2AchA7RS52DrFrTi0ncr6K3ttEf+bYRGYZMR154EDsYokEIzGLiSzxdY0
         r/dg==
X-Gm-Message-State: AOJu0YxVOuOO0IZD2Y7KiPH1uqf/XCJjwzzrk/B6N86ExIzFoIWzmXjW
	MWjyLWu5gyp4mXSoytT56SWVZZOA6XmwkFTuTsA3SlcVkMZbuXdW45i/61S1CFESdTPqG6J6efq
	Fsbs2tq7WEevxFdHaT9n2AG0LJwo=
X-Gm-Gg: ASbGnctS36lknTNAoQ9UZLkamFCrRG4e2zyUVb9ysbwYQDKw6agzS4DnYSoDoPJ7vhh
	a+eYSpZ6W244R+fokHuLZIWviVMOa0JPsBg3sjXFGNKUkNpZO6wqcXjkt9/0Zp0jF
X-Google-Smtp-Source: AGHT+IENZwCkhoK2F6IuvCMIXTjCiTq5L7yduVBAQkAoragZ7elAxpRhi41mZPMZYfOKLS5Au023p4hyateba9hK/jU=
X-Received: by 2002:a05:6402:2553:b0:5d0:cca6:233a with SMTP id
 4fb4d7f45d1cf-5d10cb565f3mr388193a12.10.1733188605350; Mon, 02 Dec 2024
 17:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129001632.3828611-1-memxor@gmail.com> <20241129001632.3828611-5-memxor@gmail.com>
 <CAADnVQKyb78oeRaYZjvHVj3th6RQHg4zTVKk=rHqyCGRAPx_Mw@mail.gmail.com>
In-Reply-To: <CAADnVQKyb78oeRaYZjvHVj3th6RQHg4zTVKk=rHqyCGRAPx_Mw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 3 Dec 2024 02:16:09 +0100
Message-ID: <CAP01T74MqTV2DRtsdfY-e7HAQGjRKfcPQ+e8c6pXoruxAoEXYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: Introduce support for bpf_local_irq_{save,restore}
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Dec 2024 at 01:05, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 28, 2024 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> >         enum ref_state_type {
> > -               REF_TYPE_PTR =3D 0,
> > -               REF_TYPE_LOCK,
> > +               REF_TYPE_PTR    =3D 1,
> > +               REF_TYPE_IRQ    =3D 2,
> > +
> > +               REF_TYPE_LOCK   =3D 3,
> >         } type;
>
> why extra empty line?
>

To separate the lock types from others, but I can drop it.

> why renumber ?

To ensure we don't get assigned REF_TYPE_PTR by default after
acquire_reference_state, if someone forgets to assign the type it will
be REF_TYPE_PTR.
Right now with 1 it will get caught by refsafe's default WARN. I
caused this myself so decided it's better to be more explicit.

