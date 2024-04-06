Return-Path: <bpf+bounces-26103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4954689ACAD
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 20:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E907A1F21F9B
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 18:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9812B4779F;
	Sat,  6 Apr 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoflykO3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455817C8B
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712429282; cv=none; b=spoDJp7EbCtcHPJ2k55tUCF9j0FLrpxV6YEfJA8bRVH/NT4CDzm5couKXLhAY8A3elPLQ4WWeaxrAAPax3a3pBvBrbL/wu+IQKcV8aZBNeuWGCHzw1noyjPiEP9gAPKOFyc5MtnivmzXs425h5mnVFgGssNAm4PeI5aJ2Vfl20g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712429282; c=relaxed/simple;
	bh=FW218fl2UghwDuqdlD89w+hYKXUPUdIxWqTM7nxMHQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5qoWZh2uvVRQHF+xA4fi1x0SC5LmqhcF5w9nAihPrj0c9xoxN5pwlKxA5YF959axl+MtabPT9Oa5uY13hEmP4yS7jSEcPaA64OBiIFJ6S4hOgVqi/jTmGZxXNGwgDlJL1IKxYxNHaOkCsdyo+bLNloxzKnOFkqtQyvTL6zpxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoflykO3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso2912634b3a.3
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712429280; x=1713034080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTMRhdy6jvlVXctRNUzVuELrkOa1dVUSnAzWpOTF4yo=;
        b=HoflykO3iqwLY/8BPVTY+sSvIAw45epYYihQiqGzXCAbA1pEqyh/FX3Esxe5XrUWvW
         unwJUxZSjlGDYbAOuXW4Sm2Qxf8FjU28a9BU/kIv9ZcQB8X8pUlZFoke0S+8yRk1uPoa
         Rnynf73jKzGgLfvxC9oFUXwyndDheVJavVlS52ID5GiGWrL/5eOtMzXCBqiFI07nmZiw
         Sn0l0+XeWcO9b9xvyc1RSORg/9wvnkMq9pVgGkKDkwVY8hxvqzE+BdL4ylpThEV59cIl
         1cb/PrMD9yrkizzsEu3sswTEbqkE9ABMskQItxxtfYERPKhbvrOb35TUDMQZ13FzZJWE
         yT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712429280; x=1713034080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTMRhdy6jvlVXctRNUzVuELrkOa1dVUSnAzWpOTF4yo=;
        b=xGEGZ8kNsKrkDyUb0QuoecJOZfBpAgg7V2VRjCyhqlmay64tOnA8roisWTdBC3Y8h5
         3iiM0S6mxcmw0MWgboMieP+8eISDOORQ0Q1rRSzCKCia9c0sIbgOuPbxga7/oOOye0yn
         wnZnCrcJCpr0P57Kft3FQEVGcBCjwflsUeVUMn5euuIoZd3rLB97yzP0pnxIsqpc9HWa
         aXVI0wUJhYWQJH4ZUxovL78WtAnJ6A9K7CTtiLVKr5qYvV72fwpigTu/1i9K3MWOKcFz
         Lj1oMVaUgbdNWFkNK3lS3otQCmOZ4nlNh6eyeXaNlZaIaRr+T9O5bQo2fjkH+GMtzZxi
         y4fg==
X-Gm-Message-State: AOJu0YwB1KB665H3rS/sVpFR3257S8posONlA2Wis40mM68jWjYSvv0i
	ztyNLz8fnR69tlWkQZohiYzS4QDQDFUb5heFAjKpnUkhiQjCwWbsI6BZiycwscR/RtIPkSL+Uiy
	65vbx8Xby4zhKq/T/HQ8ubTw4+3I=
X-Google-Smtp-Source: AGHT+IG9a1XBdthBu6NGpWEwB0iidExY6owu7ZT1uq7ET27L71cmpNdMB0VXKkymQ7mFcna/S3PHRNYj0MvAxObD5AI=
X-Received: by 2002:a05:6a20:3d91:b0:1a3:a639:ef7c with SMTP id
 s17-20020a056a203d9100b001a3a639ef7cmr5493558pzi.1.1712429279993; Sat, 06 Apr
 2024 11:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406160359.176498-1-yonghong.song@linux.dev> <20240406160404.177055-1-yonghong.song@linux.dev>
In-Reply-To: <20240406160404.177055-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 6 Apr 2024 11:47:47 -0700
Message-ID: <CAEf4BzZTM5Ce+EEhTWPkt4C5PjtC9JRrWQzw1ZGU_oiCqQSi7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 9:04=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Add bpf_link support for sk_msg and sk_skb programs. We have an
> internal request to support bpf_link for sk_msg programs so user
> space can have a uniform handling with bpf_link based libbpf
> APIs. Using bpf_link based libbpf API also has a benefit which
> makes system robust by decoupling prog life cycle and
> attachment life cycle.
>
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h            |   6 +
>  include/linux/skmsg.h          |   4 +
>  include/uapi/linux/bpf.h       |   5 +
>  kernel/bpf/syscall.c           |   4 +
>  net/core/sock_map.c            | 270 ++++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h |   5 +
>  6 files changed, 277 insertions(+), 17 deletions(-)
>

Please check bpf_prog_attach_check_attach_type(), it probably should
be updated as well. Other than that looks good.

[...]

>  static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *pr=
og,
> -                               struct bpf_prog *old, u32 which)
> +                               struct bpf_prog *old, struct bpf_link *li=
nk,
> +                               u32 which)
>  {
>         struct bpf_prog **pprog;
> +       struct bpf_link **plink;
>         int ret;
>
> -       ret =3D sock_map_prog_lookup(map, &pprog, which);
> +       ret =3D sock_map_prog_link_lookup(map, &pprog, &plink, NULL, link=
 && !prog, which);
>         if (ret)
> -               return ret;
> +               goto out;

probably could have kept `return ret;` here?

>
> -       if (old)
> -               return psock_replace_prog(pprog, prog, old);
> +       if (old) {
> +               ret =3D psock_replace_prog(pprog, prog, old);
> +               if (!ret)
> +                       *plink =3D NULL;
> +       } else {
> +               psock_set_prog(pprog, prog);
> +               if (link)
> +                       *plink =3D link;
> +       }
>
> -       psock_set_prog(pprog, prog);
> -       return 0;
> +out:

and wouldn't need out: then

> +       return ret;
>  }
>

[...]

