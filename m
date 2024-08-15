Return-Path: <bpf+bounces-37268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4525F952EAF
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 15:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4306B27246
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 13:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638421991B1;
	Thu, 15 Aug 2024 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCsg5EeE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9111DFFB;
	Thu, 15 Aug 2024 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726909; cv=none; b=qbfrDcryoBaT+6u0/LxjBtXrwTOsf6KijglSKtRvk/5Jt5rvkpRmYXng3uye0iMrVWEHYrTYLwdNnZV+kMDpL2CYVL4iYiKuPX4KhSgf1SyXcftV4M1DQ36ottHmMFoTF7yMDEbguRYKXptLrBcbCy8TwVXE4XcaHlCofXlmx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726909; c=relaxed/simple;
	bh=sXMYf+v+9isfvGYFsv9Oh7uS72yjEyA9xJY+Z/JwoWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taPWKO5hTM1kHRLxTaZvkaVS6CRUmVnwMRKSkBslAwGTbWnRksKhHhAYdIPkWIEYuqztUjJjHU3lm68N0nB6wWB1MS0F/Ouf/Z0AFq0uEoTFpBi5nyNRyzi75v0n+7r2mqkRlmrk2oVWix8dSZD+dnlfMdTiKGV2IBci22fNJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCsg5EeE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371893dd249so353857f8f.2;
        Thu, 15 Aug 2024 06:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723726905; x=1724331705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXMYf+v+9isfvGYFsv9Oh7uS72yjEyA9xJY+Z/JwoWs=;
        b=fCsg5EeEXuzuXsJZ6Pd6VQDWSjStD40KKrryOtw7U9+44dmwwSFeJ/GCqQw7LP75rC
         nBBk6AfvOT+ZeLNPnU5svxZS+h5+Ul+zoLEr0WTrr2Ah3YhdClyeNDdvDq/6R+snPapj
         DIVL/eV9xRpD9DWk4neHGGNtVV3uR4G4vAe0FeNfiJkcsMFUMd8IU1ZWtpWRZtRY6f31
         vzD5uIxnJ1cic4cb9uPGIHB9YtdUOzz+0BlAVzqNFw7I/XFRd1SRd74sT8n4oH+UtyMl
         KeYVwcfs8CrD4xSjbFDra0M/Npa1mbEYQXN1stHCCAGbMGt++pz8PZ78ouKaOWGouTi1
         vnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723726905; x=1724331705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXMYf+v+9isfvGYFsv9Oh7uS72yjEyA9xJY+Z/JwoWs=;
        b=fs7kAcIoJ9Vq7rSJ+WRcWHGcsG4XsswKXuJZw0BLdsVlKwm3BTDUymMovvmWBZRzEL
         dTvq2c7n8ZgiU0HJ6sZitPuGZyLvIKkLQ8yVXOWN6YJA9HdJQFAbi6r8UWk7UHvd0yY4
         SsnWqb9FBiIkDTONw+Uv6chCX3xnGcXrEWKlO18cbfm0LqIiKAWbwenIEWpV9K8lYg+F
         UN1AJYEEueakpIpNXVHb+bWCDWRy+yqcerFizFa1avqbETsdk3VqOJbxBeh+Li6VvA0J
         BPE/mCBPrfooOB2iT/FARmRscr6swyjPIQc3JAZm0cj53WbKYevFVgCvkdIe9Kp6Zqv5
         +G/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+sFUGxcTu4n6JstNgr/i3koj2PYupP/9Jp3fSOzyg/0L8ghLX5PtXs4HHVcyxgz7SSezoQIu2rOKLC+6PHeXjibihBl9u
X-Gm-Message-State: AOJu0YxfSCelMhz9/ezK+acQemO2kMVQEEa5HHK8+Zrioa5XajyAeTFc
	bfP32wgtQfOlsIQdj64tVPrvN/8ajPT8fJVK4G/UaAil+0NyG2HAoUyEE0o+UGU3Z2UlKFaeTbl
	inYr9jZpojfdht2q/pnHShpdPcw0=
X-Google-Smtp-Source: AGHT+IFS9+Aq+B7gQqzRKZ+YsSAvq8fnCFhAiRQhFWQIJrLbzske8v+JhGw7GGlFnSUmFmnbO/FTUMNR9CsmhhbnN1I=
X-Received: by 2002:a05:6000:3:b0:371:8c09:dd9a with SMTP id
 ffacd0b85a97d-3718c09de6amr1083215f8f.62.1723726904989; Thu, 15 Aug 2024
 06:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com>
 <87bk1ucctj.fsf@toke.dk>
In-Reply-To: <87bk1ucctj.fsf@toke.dk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 15 Aug 2024 15:01:33 +0200
Message-ID: <CAADnVQKNULb55aFOt1Di53Crf64TvF6p7upvUxLwSbrgMw=puw@mail.gmail.com>
Subject: Re: bpf-next experiment
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 12:15=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > 2. Non-networking bpf commits land in bpf-next/master branch.
> > It will form bpf-next PR during the merge window.
> >
> > 3. Networking related commits (like XDP) land in bpf-next/net branch.
> > They will be PR-ed to net-next and ffwded from net-next
> > as we do today. All these patches will get to mainline
> > via net-next PR.
>
> So from a submitter PoV, someone submitting an XDP-related patch (say),
> should base this off of bpf-next/net, and tag it as bpf-next in the
> subject? Or should it also be tagged as bpf-next/net?

This part we're still figuring out.
There are few considerations...
it's certainly easier for bpf CI when the patch set
is tagged with [PATCH bpf-next/net] then CI won't try
to find the branch,
but it will take a long time to teach all contributors
to tag things differently,
so CI would need to get smart anyway and would need
to apply to /master, run tests, apply to /net, run tests too.
Currently when there is no tag CI attempts to apply to bpf.git,
if it fails, it tries to apply to bpf-next/master and only
then reports back "merge conflict".
It will do this for bpf, bpf-next/master, bpf-next/net now.

Sometimes devs think that the patch is a fix, so they
tag it with [PATCH bpf], but it might not be,
and after review we apply it to bpf-next instead.

So tree/branch to base patches off and tag don't
matter that much.
So I hope, in practice, we won't need to teach all
developers about new tag and about new branch.
We certainly won't be asking to resubmit if patches
are not tagged one way or the other,
but if you want to help CI and tell maintainers
your preferences then certainly start using
[PATCH bpf-next] and [PATCH bpf-next/net] when necessary.
Or don't :) and instead help us make CI smarter :)

