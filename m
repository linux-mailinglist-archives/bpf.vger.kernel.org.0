Return-Path: <bpf+bounces-19912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F53B83302C
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8CD1F240A2
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 21:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D936C58100;
	Fri, 19 Jan 2024 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7Ex6n31"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C655E7D
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699292; cv=none; b=kKHwkzWb7AAX04X8qRChRhTCz6DM2FYk+FH9f1f+nNOSxk4hVbMdFI7/zdjvDKACrc5ecEIJIhzyRqQnOOP3oZq31urJM5jTfvaNKf0ZytNF+/PT8P39vM3E8rYnGJsx1xpQM4wNJddTsHIBC1EwF2KrgdEOI4FaEl15GGjZzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699292; c=relaxed/simple;
	bh=VOGURslMSOuNzx+LZo2SPGRpP7kJdPaIJWMxd3ox1vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzM5JCa42dOmW6O9x9t5fNmnTXQ5KoGsLrdHwDGc1pL6ZtZ55wfByyD/56zshFDqDyLRoGbG+0kR7QotCAwKEP2FusN6lCSZpo18l59xMq4nYXWxIPcjY4li/JyvIkSu4cfl5WgeFOh2bJWBWboGoiUAkU2DVtBpjWFg2qL6iYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7Ex6n31; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28bec6ae0ffso920707a91.3
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 13:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705699290; x=1706304090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOGURslMSOuNzx+LZo2SPGRpP7kJdPaIJWMxd3ox1vU=;
        b=C7Ex6n312TcVSKG5QW/lg8PPBm4EoA6vS9no6vjpLWOU/zsAAPJyd5eaaB4yzRzYgI
         k1A3Ic9ifVXnSkOPv3MddHdZpIiKNv5IEIZvf90/9+wp8aMTgzwy7kWviyxPqH8ed02h
         LChoel7smtBCozA4qUML11XRctbyFqC4gU9PRiRsQcQJsbIsL4qg1iyoAGhtmy2z74/I
         bNEePgIK+K5x2L5LejUyqGOXdDTJpZgEhapu4i9/mWsBPqjj6pT+Axgf9h+5VLI4b6bg
         DTLHQRIZsgChw6KxjjzNLSDoTQMEO07RyLEAqnhANj5dTq+OpykMUmSAWTN2eF3v5MCR
         fOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705699290; x=1706304090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOGURslMSOuNzx+LZo2SPGRpP7kJdPaIJWMxd3ox1vU=;
        b=vdi2oTHqHmuekiJ+E4K2C8TgpEFGoGifx/tugowb2pC/sPNWofXlAILBpKQKtRGQA5
         /fourD4xWWUW4SPnBa0IVr8VEOfm4bjBIZqFI9sBWKerRbvpQnMzdRkPL4078mZwgPfe
         2FslM8tuHTNUbEPQxeuQ6xldUbRIafm/5Jz54WAd13geNB+vTxafvSOhyKdvkDeCm+ct
         Mk2BW5ZpFALLcFL6DeDeDf8x4Ele/pGFrgvLesGlRkUyh4Bn4gAxWsroT1H2WFDtW8tX
         ajUU9xk7fW/t5Dd81rpyMl7OkFjob3CyMZKI+Q8CtIqSlHqQUPQtdhrAQAAUmIarTLT5
         6UtA==
X-Gm-Message-State: AOJu0YwXTcrrIxNvWh2RPVWNExuov4Avk5qp54Gh/2AMOdccxaBZqETt
	6Z3GVm5ftgckSY/lByzASjz7oxlutgLi3pEJUHeTh3+a3pYXix7vXawE0TaKA32R/ypI0zEtKps
	3VekwDqyF9htZWZFeUjBgbOBqvXg=
X-Google-Smtp-Source: AGHT+IGwM7R+8Iw/tavnTvQvvHJ6Az3l31WR/u22Cn0Z8NNaTk5EbsKnj1Oti9Tl4JUsqComzr1BL0h9BwAEk1I+OUE=
X-Received: by 2002:a17:90b:4c81:b0:28f:9294:b8b with SMTP id
 my1-20020a17090b4c8100b0028f92940b8bmr378601pjb.15.1705699290202; Fri, 19 Jan
 2024 13:21:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119210201.1295511-1-andrii@kernel.org> <CAPhsuW75zzq5W4yVOpuS9LcWV9koFrHPi+z72w1zGhCr0KKoVQ@mail.gmail.com>
In-Reply-To: <CAPhsuW75zzq5W4yVOpuS9LcWV9koFrHPi+z72w1zGhCr0KKoVQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jan 2024 13:21:18 -0800
Message-ID: <CAEf4BzZRaKsJ0T3LGxeCchSgLi6Gvs5-0pe0Ba6DQpFFSiF66w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: call dup2() syscall directly
To: Song Liu <song@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 1:18=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Fri, Jan 19, 2024 at 1:02=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > We've ran into issues with using dup2() API in production setting, wher=
e
> > libbpf is linked into large production environment and ends up calling
> > uninteded custom implementations of dup2(). These custom implementation=
s
>
> typo: unintended

oops, but probably doesn't warrant respinning

>
> > don't provide atomic FD replacement guarantees of dup2() syscall,
> > leading to subtle and hard to debug issues.
> >
> > To prevent this in the future and guarantee that no libc implementation
> > will do their own custom non-atomic dup2() implementation, call dup2()
> > syscall directly with syscall(SYS_dup2).
> >
> > Note that some architectures don't seem to provide dup2 and have dup3
> > instead. Try to detect and pick best syscall.
>
> I wonder whether we can just always use dup3().

dup3() (according to my git foo) was added in 4.17, which is more
modern than some other usable BPF, so I don't want to just randomly
bump the minimal supported (by libbpf) kernel for something like this.

>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Song Liu <song@kernel.org>
>
> [...]

