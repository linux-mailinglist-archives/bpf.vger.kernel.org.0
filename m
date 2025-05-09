Return-Path: <bpf+bounces-57900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CE0AB1B97
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 19:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50219176526
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6406723C397;
	Fri,  9 May 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8hghNlV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D523A993
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811911; cv=none; b=XuFdjPQpv8eZwgExpoNbYQOeFKVAjrGspbvX8JGJyGvcY5xbCSjX3+ThSeuwNNEinm9yenOGZ1NeJn97/kfyUuG43wj8vLnIJOyRmTu/hAnaXnllLZJeJAvs7JD5Aok+ItWFm3jAFHPsXKoBriEqV7sGV64A2lqpHSDjgM2oGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811911; c=relaxed/simple;
	bh=zQ+K19xlwhwtdv5LzV2CeYJpz+yzZXcD+SSAQ0k7QCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTNj52VpEvX2X4p3hRaifkoiYeTeR6oAKz+cZ4qbOTnikzDRc5rPFILkWXiuTzOTEIVRFpEHXPCwDQVdMcclNLVxN8rn11d7yj6W9WWTzxsQzFCeWrxWXMdwD2/QBArfzoJLmClM1PS0wVakBOMypW4ZEi51B5XY2lgMC+DfkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8hghNlV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso13136315e9.3
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746811908; x=1747416708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoWkmCeOWNeHi09x8ZRD2uFMEAsGEc60rYxmJ5s4ZWQ=;
        b=F8hghNlVGY0BU9CP42y8UEB535VMlxWZL4upm1ITAuTy9Qd6JVHMBHW+gLY89BgEeM
         A5zH4UKHSmkG2/1nXb18PLk1GTHerj/XDpeFDTDxuv4XXGlTMNwHJI4nv0BNmtN+t4te
         eR9BUkzd9tTMbn3CcOWgsKXLG3Es4BFz+o2O6r8bWTnYhOjc4qeVR06+pLAFT0nGnp3T
         7Csu4yt/BXm972e7TjXyWCy0MZkb2aHBf+BHUIUx+pusu75PDBMV9NutdfehQpQ23ClT
         VEPnRHX9H0dZxoMfUr0s7jbfDjS3IGN4fC1QHK2NLLJOFhsAsIe16GgNJ2MhbO+ZGNhn
         MDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746811908; x=1747416708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoWkmCeOWNeHi09x8ZRD2uFMEAsGEc60rYxmJ5s4ZWQ=;
        b=KCjPSPnyGHnmlLeBs5+p5CS4SJ1wrvOX62KUGmKB8XtrZh3EZBKQEYIeVVwsltZtFK
         LJ2TkSQREvA4jza9bSmUKPMwhXVArHtsAyFQzWaIYTIwkZB4iNnZEXqB3cFiCTKyWFgE
         mP/TvKzb/HDejj/5CcxuCchz6j/8DGUP5FNOAWRBvo91EOSMa60kgDhA1ZS47O03tpi6
         tSuOuQvvJGvoKD6ifSbf9KmNVKagtNskhbqMTpRrm+7aFxjdR7KakHe/xvuV7z5aWGfk
         /rszflXJJdLzzi7i+hPiZO+pbR+u9cv7gloQMjjSeUrk6uFb3Y5TkQPNjidUpfVkbN5W
         OFrg==
X-Forwarded-Encrypted: i=1; AJvYcCWAFdKuPAp7tfEdXF0PKCerxLhdRxloFEPAccxeQ0fg3UU2LM/m0pXOgeaZGzgVJ8GOq9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9fFZWJwRmdPXRwv5mIy7BsSQL2RcEHa4WSu8t7AYsxuPeF6yY
	PsSQRq0bs5RoAms/CDgJov8o8fzLW8EenzyeTqQTqCMvP0VN39ykYM0ILM4/klYOFM+guyAKw2s
	vF/YrRyf8ZKZ/Ml9KBVdrnkAwheQ=
X-Gm-Gg: ASbGncsZFdUuIfbAHO2eDLbh+E5/qDCzUHyXJtd2Brh3LmDduAoCsYa671X9ji8FA+p
	TcanvNPlcLkDo4HlzWmYcCJYx6OLMAOcQiv3+2sNzTkr0K5PDOJO/DpT649F3bGVvtSJy6qzda/
	w8W7ssDKXfvRjFo96bNn18yuFLLg0hJYUJyhzioQ==
X-Google-Smtp-Source: AGHT+IFxuZ4zpjLq57co3gLRd4zPTaTs7ozjCbsCNBHnN9Wq11a5GxqC2eHS2VSAVYQW8BJDVwS4Ap11h6AI4nH6wTU=
X-Received: by 2002:a05:6000:1847:b0:391:2fe3:24ec with SMTP id
 ffacd0b85a97d-3a1f647bdd1mr3850898f8f.14.1746811908430; Fri, 09 May 2025
 10:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-11-memxor@gmail.com>
 <04332abfa1e08376c10c2830373638d545fba180.camel@gmail.com>
In-Reply-To: <04332abfa1e08376c10c2830373638d545fba180.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 May 2025 10:31:37 -0700
X-Gm-Features: AX0GCFtu73H3_e7HHi0dELSN8_V2rs3SSdMjDX9ILspbL0KDKPXS1SGvF-3EGHc
Message-ID: <CAADnVQKN2S=yb_7NUO8bsu+7CxnaGyTML6gKcPS61EnCZtvG5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping streams
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 11:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
> > Add bpftool support for dumping streams of a given BPF program.
> > The syntax is `bpftool prog tracelog { stdout | stderr } PROG`.
> > The stdout is dumped to stdout, stderr is dumped to stderr.
> >
> > Cc: Quentin Monnet <qmo@kernel.org>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Do we want some utility functions for access to streams in libbpf?
> I'd say that this would be useful, otherwise many applications
> would need to reinvent their own bpftool_dump_prog_stream().

Since we're positioning streams as analogous to stdout/stderr
we have to expect that user space applications will be routinely
accessing it, so we need an easy way to read the streams.

I don't think we can ship syscall bpf prog with libbpf.
When it's part of bpftool, it's fine, but being part of the library
is taking non-uapi stance too far.

How about we extend BPF_OBJ_GET_INFO_BY_FD to return stream data?
Or add a new command ?

Then the question regarding:
- bpf_prog_stream_get()
  - bpf_stream_next_elem()
  - bpf_stream_free_elem()
- bpf_prog_stream_put()

vs

bpf_stream_read()

will disappear.
For now at least. New command will copy from stream into user space.

We wouldn't need to introduce mem_slice right now as well.
It can be added later when needed.

