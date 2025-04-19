Return-Path: <bpf+bounces-56282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 781A2A94492
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 18:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA0E77A449D
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1421DF977;
	Sat, 19 Apr 2025 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MZfZtyqH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEA04502B
	for <bpf@vger.kernel.org>; Sat, 19 Apr 2025 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745079699; cv=none; b=KpV+2TZ7mq8XOv5qwPH0Gwn+QSyyoDwK+0cOaaqBvPF4TI/y9jF5obsR46pPcUg0HurKIYvB8KPHuVtS3Zj8ZaAQd/MheMZNxKzByP/rvNbTEWR7mipLzxAq99dq4h4HEIgC0OBNUN8Qn9zlgYe+3lNco36RY062k3PwudW82wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745079699; c=relaxed/simple;
	bh=+Auhi+fhizwmRtmPtgmlior927TsrK0KO7qctAT2pis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HClemjBrbHiNvbSZ5cQhI71XAKDC5AREuYT+plUTsG3PXXTasgVS/X8Zhk0D03ufuHQWl9RyDNm1xVZwCz73LGAsmgwdBB9jwYa8dfOpy7TSv2DsaPGUwtKPP2QATkl2q3JNMTTYWSDMBtT0ACsSlvssnXWvV4772OXnt7c6gcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MZfZtyqH; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ff27ad48beso21843077b3.0
        for <bpf@vger.kernel.org>; Sat, 19 Apr 2025 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745079697; x=1745684497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK42IqE6wVyUSsq1mCB2tip52MeUpuaz6h1iIgyehRY=;
        b=MZfZtyqHgqxtktoo7cYhykkt9iBF8PdOAfLyuhm6XYm8SU9AoTG2vsQa2i4ptrwdr8
         XYoV1WQ+4SWzy/K03ngmY2GsflAAIDlSyDqFF6iSc1Vczpl5XelCYXTxXnGha9cf0YXE
         /jf8QGo7PUPRhlFOoTNkgfDVvz59oj/tLDcdY5+J82lfE3O5q2VXoU2Er7BhGwJRQ5SN
         TK7/0HNGp+7tPfTcQrvU2xaMZGlJGs3aVTfiNSt0qELF2gbIioJoi3iMv5gz3q+CDgXP
         nP3jPWFGuX/Kj8IdBZY4d3ck6vleu1XF9TY6Vd4nmXs5Ait49vHuE9ftpglQdV2+k87D
         0zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745079697; x=1745684497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK42IqE6wVyUSsq1mCB2tip52MeUpuaz6h1iIgyehRY=;
        b=KlLrFDxm+Ysd4P7dqL2nSpm1EDurKXtXtWIKfKqiF85J5PTXHLpHCuiziTg8k3xJFW
         sx0BtI4ME2fsTWVpWhVpNEWGb77s4/hTN+36S09Wp6VzYiV2Pq/MP1Qw6rhzAGU5Z3/e
         iR9+2t7BuAaBpHuSZFPN0WXrQNkK78g8Bk3GxDX0dQubgKYZoU5ggI1pDB4qNApL62tj
         cjWOAYLnaMbLefgLj1wZkZfBXwwqOjfUFzdOl+QRzDjyGPorrL9y1t/zjCkmo1aufC34
         FZyYQw3SgOLq+Z5uTTbSQdrtPMmT5AF9x36/3e2pnlUCHTHVPhF8ZfspWM4DmrOyfNpp
         IDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe9Hi3xkluax4yx47xemJMe6viEINewOOQW/6X1M1z9yO0bqfAlARXC+CSyd0UkzGK71g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SBqUN83XwCY5lImeWADE3ovUj946uYOGP+LsyuDk4cpEYpnd
	UcnjpLFmEvPuUf9mtKmmX3CIzJnaiyT9aLMg1jHA9iYUN9VYBIS1cgUiK+3mY0DTGAPI/gui1ul
	OYRu3Rw0bj4hakO7RHcIJtH92pzYTnSBVflglkRSxJK+Aibc=
X-Gm-Gg: ASbGnctRCxajAFfnWDt4npZe7Lko40cyhqJkX2taelWg2NdcJfkgc9eEbY5ZTlIE5Sh
	CrHnn7Ke7tLPLkJJ6840PY6x054OemZxW09JgumXXOMSlDF7jqCqynYBMXpMaIzdVaZ3MAJ/AdS
	l+ezL5pfyg5UQQzMVxW00CS9g7YVC6wQ==
X-Google-Smtp-Source: AGHT+IE3BicjHYyc+GSidJ22/CQRjgbN53OMD/7E3kl6FAHBfatlg7CLbuNJlbDtFKxiZ4CU+uMFqEhJREhcjE8lbJE=
X-Received: by 2002:a05:690c:74c2:b0:703:b0e3:bd86 with SMTP id
 00721157ae682-706ccdf5d35mr99562277b3.25.1745079696848; Sat, 19 Apr 2025
 09:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com> <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <87semdjxcp.fsf@microsoft.com> <CAADnVQ+JGfwRgsoe2=EHkXdTyQ8ycn0D9nh1k49am++4oXUPHg@mail.gmail.com>
 <87friajmd5.fsf@microsoft.com> <CAADnVQKb3gPBFz+n+GoudxaTrugVegwMb8=kUfxOea5r2NNfUA@mail.gmail.com>
 <87a58hjune.fsf@microsoft.com> <874iypjl8t.fsf@microsoft.com>
In-Reply-To: <874iypjl8t.fsf@microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 19 Apr 2025 12:21:25 -0400
X-Gm-Features: ATxdqUG75P_ck3eo9mR9xrxf8isa1cXorXFN2bYVLnlyY_vUbbDdQ0hrTgMAh-o
Message-ID: <CAHC9VhRduum5_6fOFs3C7Mn153Fg7VM1HnJfdtKgA-6OUvd82Q@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, nkapron@google.com, 
	Matteo Croce <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 3:08=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> ... would you be ammenable to a simple patch in
> skel_internal.h that freezes maps? e.g

I have limited network access at the moment, so it is possible I've
missed it, but I think it would be helpful to get a verdict on the
RFC-esque patch from Blaise below.

> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.=
h
> index 4d5fa079b5d6..51e72dc23062 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -263,6 +263,17 @@ static inline int skel_map_delete_elem(int fd, const=
 void *key)
>         return skel_sys_bpf(BPF_MAP_DELETE_ELEM, &attr, attr_sz);
>  }
>
> +static inline int skel_map_freeze(int fd)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, map_fd);
> +       union bpf_attr attr;
> +
> +       memset(&attr, 0, attr_sz);
> +       attr.map_fd =3D fd;
> +
> +       return skel_sys_bpf(BPF_MAP_FREEZE, &attr, attr_sz);
> +}
> +
>  static inline int skel_map_get_fd_by_id(__u32 id)
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, flags);
> @@ -327,6 +338,13 @@ static inline int bpf_load_and_run(struct bpf_load_a=
nd_run_opts *opts)
>                 goto out;
>         }
>
> +       err =3D skel_map_freeze(map_fd);
> +       if (err < 0) {
> +               opts->errstr =3D "failed to freeze map";
> +               set_err;
> +               goto out;
> +       }
> +
>         memset(&attr, 0, prog_load_attr_sz);
>         attr.prog_type =3D BPF_PROG_TYPE_SYSCALL;
>         attr.insns =3D (long) opts->insns;
>

--=20
paul-moore.com

