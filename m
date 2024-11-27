Return-Path: <bpf+bounces-45682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543879DA078
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 02:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C0BB24080
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 01:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD71BDE6;
	Wed, 27 Nov 2024 01:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfPGSc08"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF131802B;
	Wed, 27 Nov 2024 01:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732672364; cv=none; b=Sp1bSjRcmITiOYhTmPC/nKqw80I8d0pRWkn3h0Hzw4qNliYrN8BnoQ3cQBCZycXX3mcA0xpLTQUGOTLU7idedQOKUuUCBTMZV8KQqr94MGDeHKDouNrLS7O7rR8uSzSTfW5cSxe2wFNtl22YUOpxZhiKNlIoApcRMiMMRsdmxfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732672364; c=relaxed/simple;
	bh=7mOuOkpZZoXqHcUjeXr1wrFqOPZ8xCDvpX0PP+8Lo+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmCY3QZFpPBlO04brc7Y6JaMVEmk++DrMUTk1uslo00DCOJjCV++BlpMLvIrbRTOfH84HGtQVb7OyVtuP+hvXD33j2uv5gQXgib1+MxYosUsW7fXWk2q/9dl1SMtRymkYZUDtQhmR7Y/xdI8eVuRPk+6r6dLfIZv7/MxmU4RTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfPGSc08; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43497839b80so27760515e9.2;
        Tue, 26 Nov 2024 17:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732672361; x=1733277161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwQP6BBV5a5jKpJfwwMjvCqRQHR2gtIdPjXFDlvb0fY=;
        b=HfPGSc080c0tAUk/OjMdtyD6txDJqZtd9od72Ud9hQLVq92xEBna5Y5B82vX7JHXk1
         A9RTPVxAs67/dcsIEcSDgTXNNT3CQsmnsuU0WVxxh5BG9Rrbz9vh+kOGVO0SxV0tmM25
         AmswmKWLJ7JGhUXM/hih268pGYkC3nT7VMf/b7S1qdGcn48SuOCmL+U7pP8ru9NtjzYN
         Fajvy343yDw+j2XIJXgYDwBifLSbdjUydIthN77VVddUT7hz4MU2NIe8KEIm6Kg3nxA/
         gLPSQju+t+9c+o2WunfUcToG/+JXLUr8847LT2A2ceac05BqrA0FMYXaoApBQHG7hf9g
         RhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732672361; x=1733277161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwQP6BBV5a5jKpJfwwMjvCqRQHR2gtIdPjXFDlvb0fY=;
        b=UMkHfMVvJjArHOhsW3kTFF+ux04DCYkiHA2zDpT8DwVnzcwwrSaIqj8jl+/8ZdNiVC
         nfSg5T7WZ4WcZR6ZigIZVWw45Er5V5I8H10/mk9s31LZCGQpHOCIUCSv2MJpdr6KihqO
         IH2JgkA7KhMpbt8WbYxfwG1dIj3mK4m409zfJ1p4qq+Qt84rSckIw8ZcLiRxDmR+kCG2
         uvL7wSD8269j/xqfupS9+oRFMWegTwFYDmJCM+VwS4RgxI9t2aB+MwL9j5E4nShWVWRb
         BPrVa0BQvx9qjXUqrgoJCwozPUS1O49IdyRCx0eZdbZc1iOubGuEZVjZFtPsag+PG0+d
         xgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCwtWxUCcE4PWwtnIDzGlIOFTtFMB0K/aGOSxjpqDC9RMAGjhdIXo7/MQ/ozHd5AwcoIg=@vger.kernel.org, AJvYcCWy3UMos5D2AdTvbaswNuEF3GFPokbW7e9bXFEGy+nV9g+777YErrkpY7y23NOLT/5wNJP/MDIgIc5QYaMU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd9pjkqAlp3HVvGQ5hYtk9rVcbKYg1xsBwQ52tbZBtyTQGjaCd
	yHlmBbNDahe7jOQCwsMfysFTHg8/wTmznkrziCZGrJ0RytVeBOK8wMTi2Za6lyLMeSS/x8oN5zN
	6sb/WgjHLJP9Aa5U38Xslf5mf+Uk=
X-Gm-Gg: ASbGncvztzIUt4AP6aN8zJFXLHLTkoMk2k4/9OJCkoaf+In+GOhcf5EzxstiNO+60+Y
	XqmYzPa3muFSLT0irbp7Me4PRiE0SxtexeQbOjHNd6esS7es=
X-Google-Smtp-Source: AGHT+IF8UkQJQxSDvoJgYjizGcLaObXjLdJzwah5c49XNp8MW8hRc/r4pm5Wh5Rub9xTUG2rtNVOoM0PQhuqNfYQGEk=
X-Received: by 2002:a05:600c:5102:b0:434:932b:a44c with SMTP id
 5b1f17b1804b1-434a9df6b06mr10041105e9.27.1732672360612; Tue, 26 Nov 2024
 17:52:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-sysfs-const-bin_attr-bpf-v1-1-823aea399b53@weissschuh.net>
In-Reply-To: <20241122-sysfs-const-bin_attr-bpf-v1-1-823aea399b53@weissschuh.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Nov 2024 17:52:29 -0800
Message-ID: <CAADnVQLV=7Mt+DTX84u_4kP_pVNhbyHMvL29BPcFQjOj7RpM7A@mail.gmail.com>
Subject: Re: [PATCH] btf: Use BIN_ATTR_SIMPLE_RO() to define vmlinux attribute
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 4:57=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> The usage of the macro allows to remove the custom handler function,
> saving some memory. Additionally the code is easier to read.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Something similar can be done to btf_module_read() in kernel/bpf/btf.c.
> But doing it here and now would lead to some conflicts with some other
> sysfs refactorings I'm doing. It will be part of a future series.
> ---
>  kernel/bpf/sysfs_btf.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> index fedb54c94cdb830a4890d33677dcc5a6e236c13f..a24381f933d0b80b11116d054=
63c35e9fa66acb1 100644
> --- a/kernel/bpf/sysfs_btf.c
> +++ b/kernel/bpf/sysfs_btf.c
> @@ -12,34 +12,23 @@
>  extern char __start_BTF[];
>  extern char __stop_BTF[];
>
> -static ssize_t
> -btf_vmlinux_read(struct file *file, struct kobject *kobj,
> -                struct bin_attribute *bin_attr,
> -                char *buf, loff_t off, size_t len)
> -{
> -       memcpy(buf, __start_BTF + off, len);
> -       return len;
> -}
> -
> -static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init =3D {
> -       .attr =3D { .name =3D "vmlinux", .mode =3D 0444, },
> -       .read =3D btf_vmlinux_read,
> -};
> +static __ro_after_init BIN_ATTR_SIMPLE_RO(vmlinux);

To be honest I really don't like when code is hidden by macros like this.
Looks like you guys already managed to sprinkle it in a few places.

btf_vmlinux_read() can be replaced with sysfs_bin_attr_simple_read().
This part is fine, but macro pls dont.
It doesn't help readability.
imo mode =3D 0444 vs mode =3D 0400 is easier to understand
instead of _RO vs _ADMIN_RO suffix.
__ro_after_init should be a part of it, at least.

I'd like to hear what other maintainers think about
such obfuscation.

