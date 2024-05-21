Return-Path: <bpf+bounces-30166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5894F8CB5DE
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044011F21E6C
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249BD5B69E;
	Tue, 21 May 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj1isJ0L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58401487B0
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716328899; cv=none; b=i3SxwfutjvuknjjnSxvhty4RH3/w8D+SU/nW4B34XY1ySqg8a+kzdsz66+YkHSPY2k2D1BfMZZ7t6EbCtyslOkK6jQb3a6G4B/O4W1Sh5MArnQW+5l3fb2UDji4l2P5WSTs80/mRro1TBrnR+QtWmqmi3BUZRiAHFT9wQbPtHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716328899; c=relaxed/simple;
	bh=0KBfc5FpK42C6SSmHbTjRhEa0c7bBXN/FfAtotebPHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ypcl4HoUMYX6p6+KNkBt103u+EcLAJZoCw3U2m0KhVFWCVSYEKm9cKUMCvedEvvlx6kt4zz3QK+CB39zBVFXVRejinqko/y8XfkoKG8exwSSyPk9Qq9DNr/Epr6ePF7+HgVoKZieYofs57q1cK3dU9WO49x/p6xV2GJyYrK+lhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aj1isJ0L; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-66629f45359so662861a12.3
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716328897; x=1716933697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KBfc5FpK42C6SSmHbTjRhEa0c7bBXN/FfAtotebPHA=;
        b=aj1isJ0L9cFw2Vy3MNZTKDw0bD9TxSnuj3+yyy2ReOIJZNB7CVtjgYmHt4hxRDBMYU
         nNnuLF6HLcxkQOc7tsgJxuOSDpzQ61qvtkCkjwVkzZE3NNq8hsyWafrJYgcmxv5leWf+
         8Dg/bCqYklPCN+xI9L4DeKXPbNhmRiuPJmVdxczHjnv0Ktg0dKDnk4a5WnzKfYVmH0P+
         lIPAAIl3Y7cZs6WNdrOieXsZ9HCDHY+IvXH71EsEoYIjRPKqvYVSEvTxx9zaMNBdZ7Th
         VZdmez1K2IzhdhLiJViLLI36zt+TuO1OaXLD4pvLjrff72hZU//8fQipfjRwqBVVbJ4M
         9ybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716328897; x=1716933697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KBfc5FpK42C6SSmHbTjRhEa0c7bBXN/FfAtotebPHA=;
        b=N0OqE0eEYtH0gOSMAkXdRte9al9MD9gPTNzuuupmZP3MQe1+A9SAxd4kVywkHDNUQ8
         7KRH+FpMoO1bknltcDuT2ODGsPvCZ4oerkaxMU7ZttIQ+lgbKMegExvKctVx3t0mM1yf
         xPnNuzGpBYoMNzB5oG2ZhvJTo8CwYcW8IY1VH3DjIQlt3oHQ8LqIMx4xb5v1H60S7snH
         ClsKCWKK1vVDyvdnJ3rd29B7JB3m3OVJNW5jkIhM43woinSI53N25NtBqUQppLOHKAks
         wPBVLD0nQEmJ+gGn4C+vein+t9KAmtGJGZN7ik/oTmFooPUttXG9cl9OoBVYcvnjXRtH
         VTqw==
X-Forwarded-Encrypted: i=1; AJvYcCXYPLBtTXYy1PJKgSU2NpJIeHjS34TiK8tjWyRuYOh+JHxkg0rFgL3KRBrTAwYyWSzjYyYhFytWIpcucRbIA68O7CLl
X-Gm-Message-State: AOJu0Ywsck4wFaajZtN0X6FPGB7+o2zkuPO+V8nsTPDKZj8EUfaNCQSM
	URvJiR7XHERXfCgGEYkW508/BxRJCyHMfLpTNmMeag6I58VFjLzQOd3wQJUOUHpDF5h7WxmLrvd
	T7qnx8J4Q0tA/3cRnuqIc8athjh0=
X-Google-Smtp-Source: AGHT+IGqKVZppjyEDzEY+O1drnwpeb6I4LBIHbR2WYr1eYGPmPbMH/IDAwGc7fFUKUIdliEc1wmgXANa9N8271/Ss2M=
X-Received: by 2002:a17:90a:4315:b0:2b9:ab0b:c5b with SMTP id
 98e67ed59e1d1-2bd9f46b1d0mr376680a91.17.1716328897440; Tue, 21 May 2024
 15:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
 <b647e0d1d225f9d21e78c6ffedb722507f42eff0.camel@gmail.com>
 <3ae296b2-402a-4e17-b874-e067c57fc091@oracle.com> <81bbbbad95244dd74801497414c2cdad88815f83.camel@gmail.com>
 <CAEf4BzbdoXTeTSx-1Vu+sA6MKphQq91p1TwnSkK3Yv3msa7h9Q@mail.gmail.com> <eda720142ac52a9bd9599f5444a2c2897255b5c4.camel@gmail.com>
In-Reply-To: <eda720142ac52a9bd9599f5444a2c2897255b5c4.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 May 2024 15:01:25 -0700
Message-ID: <CAEf4BzbghAqpTSfWH_v10uK4ynXqG5Nm2e-_xTWFOF=bmLqd_Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/11] bpf: support resilient split BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, jolsa@kernel.org, 
	acme@redhat.com, quentin@isovalent.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 12:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2024-05-21 at 11:54 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > I'm probably leaning towards not doing automatic relocations in
> > btf__parse(), tbh. Distilled BTF is a rather special kernel-specific
> > feature, if we need to teach resolve_btfids and bpftool to do
> > something extra for that case (i.e., call another API for relocation,
> > if necessary), then it's fine, doesn't seems like a problem.
>
> My point is that with current implementation it does not even make
> sense to call btf__parse() for an ELF with distilled base,
> because it would fail.

True (unless application loaded .BTF.base as stand-alone BTF first,
but it's pretty advanced scenario)

>
> And selecting BTF encoding based on a few retries seems like a kludge
> if there is a simple way to check if distilled base has to be used
> (presence of the .BTF.base section).

agreed

>
> > Much worse is having to do some workarounds to prevent an API from
> > doing some undesired extra steps (like in resolve_btfids not wanting a
> > relocation). Orthogonality FTW, IMO.
>
> For resolve_btfids it is a bit different, imo.
> It does want some base: for in-tree modules it wants vmlinux,
> for out-of-tree it wants distilled base.
> So it has to be adjusted either way.

Ok, so I read some more code and re-read your discussion w/ Alan. I
agree with your proposal, I think it's logical (even if relocation
does feel a bit "extra" for "parse"-like API, but ok, whatever).

I see what you are saying about resolve_btfids needing the changes
either way, and that's true. But instead of adding (unnecessary, IMO)
-R argument, resolve_btfids should be able to detect .BTF.base section
presence and infer that this is distilled BTF case, and thus proceed
with ignoring `-B <vmlinux>` argument (we can even complain that `-B
vmlinux` is specified if distilled BTF is used, not sure.

