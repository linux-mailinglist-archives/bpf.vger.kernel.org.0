Return-Path: <bpf+bounces-21802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7BF852297
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012DE1F2365C
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C55025A;
	Mon, 12 Feb 2024 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9c78PPH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B184F5FE
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780979; cv=none; b=L37HiEwCduj7xbv3ntPtYpfL0dMjEKqsLL++m+xJBkl/IIeWLdMUnzj+P+n7i104vMKj1etQNB3Jz6s/U8nmRkHzzP5nCWCJ35A3/wTiP8IjB43AWH+0dFkTOzUKuHwuk9ngnhhC3u53riwcWXw91WrwQ74RYYH6sqd8r+heDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780979; c=relaxed/simple;
	bh=YLWXTqghvsglCoXndxnsOe4T1T8QQ5Sl1oDXPSZ/lOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlZt+MWzEGpNjvGGS69Nj3JZoftdfJ7vjB5lZcWYeAm6pVlXqS9KccY1t3AgxvG3967RYlurgV0nkd4fq8wtmAgLE2f8WHqRHB2D0IcM9+PYcAhEbiTJVs+dVNyuLroJKxvqTDtwrkJMsSY2tcD8fXxYRgCTsN+LZ7LwrKiAzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9c78PPH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-296c562ac70so2813195a91.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 15:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707780977; x=1708385777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IluwmsoNDeBnltxjIw/yWu9CZY8NaMdb7cmbMpwlcJE=;
        b=i9c78PPHyx/IzfaeDF4fgucBeKyb1+yNHo5u45bXR8wTs0MKUIvTMUJduD2NwjoGD7
         MiAcHpUyzPfbkyXdSnO4W4FRqUUrBhNx4lUXuX+2+E2paN7Zs8bF8tbrg3oDBEJ7LMmG
         rUUtaR4Jii/sBgyPd5ZW6/l/dmcJBATd7sqIo/iOdT1SMZazlzkE61xEr+oJu8ve+hQa
         6HPGhRKmk6huytF9N/Ng50GS63Mkx8r4BwhozVphk9OS+DvOoxm98cR/eu7wkmh5WqOS
         P7E4DXfZOMw+7lf4KlUtaSOj10Zubn960TYb+WB/14NPuTuLGG70G9zKJaUCHFBVE3hU
         t5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707780977; x=1708385777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IluwmsoNDeBnltxjIw/yWu9CZY8NaMdb7cmbMpwlcJE=;
        b=KHb9RqiEH4MFBfgdIyQuEp5zBNcX6ytjhGKHz3lJP1BAozVPsy3/dNV1aLFc+YGD2T
         DjcBlzDfg8KkmO2nnz2onhuP+ZvDYarzMiENU86LYuwfRCJMaV4hsRzV7xt9pCUq31vX
         3xXyauPOG0G7iOCV16rinY+jsW9xo9HKI2src8jJN/DOuzCb+D3atmRfZNjPu9YvkVbc
         RY0RdCVuyhN+mbyRcZg04XCL/fq3bIkWR4AGTjypMpLs3bkZwiKLYNoaYaqMgdKKAHpR
         AdgvR7mY8ubdZiiffJFR8eLy6OfddtHviQ01BuZ7JeO9Uki5ndvSBmKfncXFocBY3lb7
         QRUg==
X-Forwarded-Encrypted: i=1; AJvYcCUk7ksITJtYoizk1/oePwzG8FrbE7gSgPbsnUoho0+pHsCVyc6xkGaTP5gBQ6CAv9He8G+VBggJx0xUQqijf4Q67HWX
X-Gm-Message-State: AOJu0Ywgk7ho4Hp7cr3LDyC+OtziEoozxmJmpGkqrk1uWe0RLGPLv4x7
	GkmIZ+RJ9CqAwq9Rh+3hfTedf8XIMy9Ek7lgzFOz1USZmBfk4/mxwYxMMnkKIQfP2yp8SJp1jrw
	4Eq+8evGGaPxIMtCK4D+BYCqqDOs=
X-Google-Smtp-Source: AGHT+IFnFfBnTHtaUWfKehfnGlMHkh6RcAyk3PP6gsyXgyZC4vFC8jRqoMyDvjV4rMv+ze8aUVSPWQ6Na+8duuGZNFM=
X-Received: by 2002:a17:90a:9a86:b0:297:11b3:6064 with SMTP id
 e6-20020a17090a9a8600b0029711b36064mr5300036pjp.43.1707780977140; Mon, 12 Feb
 2024 15:36:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210003308.3374075-1-andrii@kernel.org> <CAADnVQ+yvpZ=-gWtU_4w4wJ52ULZcqVRq+4E-BGNZmTjfKPYRA@mail.gmail.com>
 <CAEf4Bzb11hQw9DX7c+AKcCjTrsh8yAcEPvUotCBwZv=1B3Su2g@mail.gmail.com>
 <CAEf4Bzb0KajZt85zgRJSeSJazFDFFXmJyhQd64zZUc5phqBUFA@mail.gmail.com> <CAADnVQLU0Gp0T6nATdMCJrwDQRA1wGcWPqi+N2a=aXUBiy87Zg@mail.gmail.com>
In-Reply-To: <CAADnVQLU0Gp0T6nATdMCJrwDQRA1wGcWPqi+N2a=aXUBiy87Zg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Feb 2024 15:36:05 -0800
Message-ID: <CAEf4BzbtzuPstmTp+mwgMQGmbzvwf-jbxNmyys_bUyKxZUq6vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: emit source code file name and line number
 in verifier log
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 12:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 12, 2024 at 11:02=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > >
> > > Can't say that either is super nice and clean. But when I tried e)
> > > proposal, I realized that semicolon separators are used also for
> > > register state (next to instruction dump) and they sort of overlap
> > > visually more and make it a bit harder to read log (subjective IMO, o=
f
> > > course).
> > >
> > > But let me know if you still prefer e) and I'll send v2 with it.
> > >
> >
> > Goodness, gmail made everything even worse. See [0] for visual comparis=
on
> >
> >   [0] https://gist.github.com/anakryiko/f5e9217f277b0f8cd156ceb6cb64126=
8
>
>
> Two ; ; are indeed not pretty.
> Maybe let's use a single character that is not used in C ?
> Like @ ?

I like @, it's both distinctive and meaningful. Will send v2 with @
<file>:<line>.

>
> Then it will be:
> ; if (i >=3D map->cnt) @ strobemeta_probe.bpf.c:396
> ; descr->key_lens[i] =3D 0; @ strobemeta_probe.bpf.c:398
>
> Some asm languages use ! as a comment. It's ok-ish. a bit worse imo:
> ; if (i >=3D map->cnt) ! strobemeta_probe.bpf.c:396
> ; descr->key_lens[i] =3D 0; ! strobemeta_probe.bpf.c:398
>
> or single underscore ?
> ; if (i >=3D map->cnt) _ strobemeta_probe.bpf.c:396
> ; descr->key_lens[i] =3D 0; _ strobemeta_probe.bpf.c:398
>
> I think all of the above are better than () or []

