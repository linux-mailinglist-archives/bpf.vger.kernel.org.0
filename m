Return-Path: <bpf+bounces-41662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634909995B3
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 01:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7135286141
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E6E1E1A23;
	Thu, 10 Oct 2024 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+F9zq3t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545863D
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728602601; cv=none; b=WHFbGpXEYg/jnr5LD/9TmoV+FraSr04wuk3kI2zyKT3HiBdvMKs2kwTaVrhmIGtTHv49mVx7/1BvFEL3AvonXvG+uGzt3nwgvVrIWExWVHo3vIr9dNLFpQLkzXnpA3OCjrZSx8snQUmLOCIQJyW6FB2IlPf5Knbk9iCV5AqUoBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728602601; c=relaxed/simple;
	bh=5GQi73hH+LLnk7u2YUmappb3UdsupBwJhsqHAlYT6Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYeQR1Q2YOvW3siIHGoSVZauA4lVZZKVnwFJHJzo7UgAqWNpNLF0AzNXnySbj114iRKEz9SiMf45weZuytjDrQQCVHwqZ4oLzt1TvsghkqvHb+ewjIpq5M+4Jp3+B143qhU2FERQdr+WDsVZccI0DewhC7zYKLnLCgVPBeemiOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+F9zq3t; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4311420b63fso10597325e9.2
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 16:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728602598; x=1729207398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GQi73hH+LLnk7u2YUmappb3UdsupBwJhsqHAlYT6Mk=;
        b=i+F9zq3tjuWizvmbTKgj3o43LiJHbZWkJuXKI3+9D9sfAbY/IaNq1D58bdHNY/eub8
         XqIDh5LBrouSClOU3TpAFud68OxhJ23dCGWRU2ykUwcLmfrm7IC+9t3FYt9FpFx9zlNP
         1QBpIFdpJFk36jjPjr4p4ilgrdQpSvCID8I+5U0pG/n9oJDO18dbjUqbxik4mRLUaq5p
         bHlterLT9zLFLQKZPXsrolK6cFZxS8vz97rAX0ZbXsFve32WzGNPUBhnZY5gmmp9pvpn
         2fEfSPlAj8q3/DCINyFgpC3kgNeZBac9BJM2QspD8EeK5ZOlLdRBmNGmgRG4YelmhsbT
         klbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728602598; x=1729207398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GQi73hH+LLnk7u2YUmappb3UdsupBwJhsqHAlYT6Mk=;
        b=nERja7l4lKwLy7Br9MWCyfqQoQWZ15hy8tVuzT6hEAcsn9YHM88/ZqlGhQtY7lMwmn
         2qvErEOCeccqZ/2PgKs/qpOVZiBpkEjs1zsOYFo5bNg0t7Ke9OmIhf+L23kXw3dh71Wb
         cYvNtOF47UBTDj7Zx4ZHB7Rp+Y5sxlUYX4vXBqRvcpRSZ2FqFIaRXzP4fjJsUVExdaMj
         UHEG/lveAx0jmhmQJQcnBFOzZ+IQt6MqyoYZ1kd3kzK6nfO6VHRBbtT7/X9utcyVS3P9
         fBAo/k/sfNNfg+6fStRL45Xtu1FvvxlxHXlrtGdAuXEuK0MHC/M/nELZJSei0NQvgmFG
         cyBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMfMmj9+BbWWGCs4kTlZiAVLkiyksmkc7scfDahtuiBbZirEKAKRcB4cYoU0NSNeFKzXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEQ4UlmM+I7wh+4/0uy3f5XyZp0m/uLk8/pNG0dGJsSTm733c
	WazwGrqjvXxCCB8UCw2a4PY7y99OV+Mtdf1TX9uLG3kCToJRfurs9pr03rjpbi/y8ORQOAzmfK/
	ALnKEQHfKlTnoBLLyFFxuCMVTKm8=
X-Google-Smtp-Source: AGHT+IHjsLRGQjdNE8u7jcxSA1/tvUGAisVSVwAAqbOj2DWXW8+u3yCrca8zST8LtJERY7YHeX3jHDeLhStAqYYF53Y=
X-Received: by 2002:a05:600c:1c1d:b0:430:53f8:38bc with SMTP id
 5b1f17b1804b1-4311ded20eemr3108055e9.12.1728602597811; Thu, 10 Oct 2024
 16:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009021254.2805446-1-eddyz87@gmail.com> <46ff5f908c2ba69ebfa2033456425632c5f74c6f.camel@gmail.com>
 <CAADnVQK8mTA_3y8YG6stQW_2yRFUOjLx2Qt1fB4SSS2Sa_0JMg@mail.gmail.com>
 <CAEf4BzZf1qr-ukaSHkv=pgCfEN5LQER7b4EovUM-TVtdwgJrZw@mail.gmail.com>
 <5c4eca8da640c4be42edca1fc3ffcd0650f69b08.camel@gmail.com> <be3d3c31438727096c9bc79f6761865574477a71.camel@gmail.com>
In-Reply-To: <be3d3c31438727096c9bc79f6761865574477a71.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Oct 2024 16:23:06 -0700
Message-ID: <CAADnVQ+Hmfp3jojCYMSi_ZacJpPov4+nPwJ7j+UR=cBN3xHxCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoints at loop back-edges
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 3:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-10-10 at 15:40 -0700, Eduard Zingerman wrote:
>
> > I think this would bring significant speedup.
> > Not sure it would completely fix the issue at hand,
> > as mark_chain_precision() walks like 100 instructions back on each
> > iteration of the loop, but it might be a step in the right direction.
>
> In theory, we can do mark_chain_precision() lazily:
> - mark that certain registers need precision for an instruction;
> - wait till next checkpoint is created;
> - do the walk for marked registers.
>
> This should be simpler to implement on top of what Andrii suggests.

Indeed it can wait until the next new_state, since
when the next iteration of the loop starts the sl->state
are guaranteed to be some olderstates. Though the verifier may have done
multiple loop iteration traversals, but it's still in 'cur' state,
so states_equal(env, &sl->state, cur...) should still be correct.

