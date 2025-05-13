Return-Path: <bpf+bounces-58125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61929AB5952
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 18:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D982E4A1A54
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959A02BE114;
	Tue, 13 May 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6X2SgWs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAA2BE7A8
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152371; cv=none; b=PCXMwYHgEYSlz8lXNQA9D4DYiPS3qGNUgFlJ4uMIS5jeJ9PH3vgVJl6xdk56ArMSNB62fh4I0NEjOQ5OquJOsXedgOQ3A/Z+UataasMlXPolQvLOUx+gxYKJs48m2lCDLnC6RZBoNKVJ+ZYZbHdcTh1auJZsPLWDzLUvyHdnyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152371; c=relaxed/simple;
	bh=CGsMtWh+en1jfB7evlKjwAEgqDWRseR4+nQbwpeNFSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWpQbBwfrohY8ge2gRSPbv92V85VUpFRzuHr2oFMo5d1Ger3Hi81Qw4hjR4WiTW/MROvWRzxRdQSx/wQsSaKbPvHFSA5KVin21JsVe+KENAnLT0A7YsntxYw9K4/Eyfjbw+cfIUwuTPw7s+yGjprpDWO1sLDmpckaRS2CZzw64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6X2SgWs; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-309f3bf23b8so7028187a91.3
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747152369; x=1747757169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHVqDu2jngC4pA6GXRUzaP3yGa+0ktKZ/g/NBJXtwGs=;
        b=k6X2SgWsMSFQ1vKQTG0XKl4tctivsd6ZkH30CZqUAy1+KIpH1hJ4PO1sHQSJwUBSpf
         4liLm+QWj+JVjdv3mMLtoxcWz2RsPDN2QCTPCNjb0REIXqMmrzq/jL8hVJi5ebzuAhY1
         KIGH4xVNPlToT4OsbojIHVjx9ceArtTtKIRMyL3M0Fe98Hm3G4+/IFiZqxBZ0ulFoxtF
         SAAMRekIIqPyG7P1GnYC0VnyXmZ14oXEnBCA4VrFbHqfc91BSzAVyfG4hE8iYKSFIVgr
         SLbh87tkflcAYNkC9oaFQXbSTwtEK6oJzP8yq+I02ZPl0lQGOJ5npg9ZdVopk8kcisH7
         4QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747152369; x=1747757169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHVqDu2jngC4pA6GXRUzaP3yGa+0ktKZ/g/NBJXtwGs=;
        b=VA+4AVIE9s7SrX7ScIP2rgSPCFdD+W4SUzgPaywE2iBBbwjsb2lUz6xV1DQR8riEz5
         /iYhh9YxcKnu2kbdMXSH+ZE7M9g5OPj8Mi3rjsC2VQgwbZ8YBdrygyKSizq4E3xfD+g/
         WfaiIPlI0qTAtBRVJbmN4rVxLDsz45S013z0y0eRn4+VkqNB5yqvF+woeA8KO/h2FZAG
         YM7tKSOn2pX+Sc1TZZ4q15KzJh+nnUMALME4njqz6gPZeWZ3VTr7mviYG4m96qlxmgti
         C6Z2afnEHLyBy7UL/bmHZQ4yUeYoQE6fHEoDAbS45N01d9fgPsr8WwoRzj7wjoNbs2Za
         F5vQ==
X-Gm-Message-State: AOJu0Yw2m+cg7FdtYJjQiKwYSWmsWgneF2WhoaB6l49tsqhJHdvGWC2I
	m7GcNzRS8uWrvP4Ni7PZveYu65g890JdrQvBNypkUdFx9ZGKYqAsAOqhWrLnp7lpn2S1w6JKtgy
	lFJeiRSZEXUlBGTMILRl0DEeyYjU=
X-Gm-Gg: ASbGncumoN5a1mqi9yh3+TESZjgUo8Uq4AfifP+8Enekdt0SKEbKuS2+43u8urFrjhu
	fotGRKgSrorLlwVxSLwR0qEzz31shtzgQxm0gY5PvV+F6161ED+Z5ciq5QiG5v8adPzXXX9N11V
	0Eh6M5EBbwHPf6i1fkP24m0VNG/gV2HUdf0JmNmQ1Q+2aQphhy
X-Google-Smtp-Source: AGHT+IHHqlQhuep0Pzh0cX4T275zpKOXukg1oLGUyTS8Dh+y/IZUOCee/gIiBM7WtxGBMugjSaaGxOt1eyFn8M5Co9g=
X-Received: by 2002:a17:90b:38c6:b0:2ee:b2e6:4276 with SMTP id
 98e67ed59e1d1-30e2e62a163mr163721a91.27.1747152368750; Tue, 13 May 2025
 09:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513015901.475207-1-khaledelnaggarlinux@gmail.com>
In-Reply-To: <20250513015901.475207-1-khaledelnaggarlinux@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 May 2025 09:05:56 -0700
X-Gm-Features: AX0GCFuw_2L0dg2ioYzSm6CFUTAyxrdk5bP1SjHoy6KH5Z5Etsu7Qux8CgONlco
Message-ID: <CAEf4BzYVoV7_w0-WxPShYDKWSNXiG92ieLxVPwRZ1W3VoKhmgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs: bpf: fix bullet point formatting warning
To: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, andrii@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, shuah@kernel.org, tj@kernel.org, 
	kernel-team@meta.com, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 6:59=E2=80=AFPM Khaled Elnaggar
<khaledelnaggarlinux@gmail.com> wrote:
>
> Fix indentation for a bullet list item in bpf_iterators.rst.
> According to reStructuredText rules, bullet list item bodies must be
> consistently indented relative to the bullet. The indentation of the
> first line after the bullet determines the alignment for the rest of
> the item body.
>
> Reported by smatch:
>   /linux/Documentation/bpf/bpf_iterators.rst:55: WARNING: Bullet list end=
s without a blank line; unexpected unindent. [docutils]
>
> Fixes: 7220eabff8cb ("bpf, docs: document open-coded BPF iterators")
> Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
> ---
> Hello, please let me know if you have any comments, thanks!

Thanks for the fix, it makes sense. Applied to bpf-next.

>
> ---
>  Documentation/bpf/bpf_iterators.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_=
iterators.rst
> index 8f0a4a91b77a..189e3ec1c6c8 100644
> --- a/Documentation/bpf/bpf_iterators.rst
> +++ b/Documentation/bpf/bpf_iterators.rst
> @@ -52,14 +52,14 @@ a pointer to this `struct bpf_iter_<type>` as the ver=
y first argument.
>
>  Additionally:
>    - Constructor, i.e., `bpf_iter_<type>_new()`, can have arbitrary extra
> -  number of arguments. Return type is not enforced either.
> +    number of arguments. Return type is not enforced either.
>    - Next method, i.e., `bpf_iter_<type>_next()`, has to return a pointer
> -  type and should have exactly one argument: `struct bpf_iter_<type> *`
> -  (const/volatile/restrict and typedefs are ignored).
> +    type and should have exactly one argument: `struct bpf_iter_<type> *=
`
> +    (const/volatile/restrict and typedefs are ignored).
>    - Destructor, i.e., `bpf_iter_<type>_destroy()`, should return void an=
d
> -  should have exactly one argument, similar to the next method.
> +    should have exactly one argument, similar to the next method.
>    - `struct bpf_iter_<type>` size is enforced to be positive and
> -  a multiple of 8 bytes (to fit stack slots correctly).
> +    a multiple of 8 bytes (to fit stack slots correctly).
>
>  Such strictness and consistency allows to build generic helpers abstract=
ing
>  important, but boilerplate, details to be able to use open-coded iterato=
rs
> --
> 2.47.2
>

