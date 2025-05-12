Return-Path: <bpf+bounces-58065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B9CAB473E
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3F88613E5
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7D5299AB2;
	Mon, 12 May 2025 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu9huOor"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554325B697
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747088713; cv=none; b=cl+LIBGU0Y+fVj+ixqOKCF3MBRjxGIcd73ihnHIMWNUO9rzMNtdowFTPGfJLfpgVxRh23kodDFctHQ6Vg8/amY07CKIj+KaFGFY7776entHpUfOnrGVqQ1saL+gGoey2STLXcCe2l1+3nQM5/CKSym3uGHh30WLWkasxHiR5sVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747088713; c=relaxed/simple;
	bh=nunvOCEPeqsOQAqVX14KcuV970MnnF1t+FediTImk9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8g1jHihk3IOAKuTCjclo/FyjZp+Q0B0qM/EDHqmBfCgzfCb6MWpDWfAnKilX5lZ5CxwyxR6+/WtrjvDmxoNHQxozqSaZ5G+kroXDTK3rtnUwWgKIVvJ5xms0DfatvHwczFKPS4f0xiesmYXeKtKbldqWnA2ca1xFVXkJElZKX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu9huOor; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-309d2e8c20cso6419446a91.0
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 15:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747088711; x=1747693511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooT1P426ifPGmXAV//tQw+oilDlhR7uir9MHLNbyZ1w=;
        b=cu9huOorETEcXbdzBQ9azdIE/a2/CKu1oUO9odSGFd9maligRN5V5WGQzrg7UBbBCb
         j4wmn8ttZoPqYZIAW7XoIRW4sTZHH5YdS5nhelyM4KkgrzJ/z0LGMmtbqaT7FZNQfcIm
         SPI9HxdRVytSsiX0pnnBOBbKUATak59lPU5fii6zFgLKC078Iv7rYUt3r+KLrHRfs9iA
         HxhW8HGVfsXLaz9AHMMIWbIG1rKnkY51VZ5m47WXdcSyBii/8tFvNG2vir1USPBgjE07
         WL/agAuOAOt9bj9OLlcJPXWzAyJ44cJaxcnoBwk6lV1MznK6u5j89yhpSwAhxYp118jm
         t3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747088711; x=1747693511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooT1P426ifPGmXAV//tQw+oilDlhR7uir9MHLNbyZ1w=;
        b=DMnhw/LCCjIB/1RqSE7Qy7VhPgfGikiQxhZ/obdBnsNJoHwZDRaEZq1DzvyKGSJUsN
         a+yODEQM3TK+NomD0etUoeF6jT67jgyXBowvrpszXURzuQ4Exz9oeS1yvNDKLUbJqmK4
         mqNTJmHXwZxP9UOHFs/fdwoJuLdxZMdWIRqMgcWGEslmnEkn/9KGEfD7PTUzH71g8pIS
         9rK6mHYlpOLtrP9L9s4q03Fuy6F0jUuOWsIgaPPREBvViZ/1euFgj/IsHxNSGqG6cyVO
         s0NJxkoMKlOiBnAA6PLebkFNMhkcHVk9IACNd/a7AXEAsAJSUHcuTmewxijPyhSpK3Br
         Ijew==
X-Gm-Message-State: AOJu0YwGzsHqIz3/Qqu1E8WQo587kI0YY3aZ6QrNZvdlo9Z0Wb2O+VOd
	KbLp93JmHt5DWIHx4LdnpMVaQ7GLfQLgYovmRXN+wvJyAf2FOLNleZ/NM2hxZiWIhbXbSs/GGrN
	7j9qB6VOHoA0g8pT+KZSPVqLvbzTgAhVl
X-Gm-Gg: ASbGncv2wfDDw9L73CYgs7Vdj1ItzdxGA9+8xJaxOiebm4d5iN7O2mW94lYa9atY7z8
	pgvWaU7wwrX5ssu+8mW3JUsnacAaIMrtd94KvAsl0MsjRStbeA7dgnnkiAo7dEYIjN6MVlbj0B6
	mu4bbSJhwtoxZ6uVZSjJ3TyCG2SNulHc1aSxE6E2dtXpjkg/SR
X-Google-Smtp-Source: AGHT+IH9OYxh2+h/ol0hCWGYfJ5Hi0rARjU658woTotAGQwOdwQzfAs7GdXjn1a2+7VhDmwDie9LwBIp8jaPaLpkggY=
X-Received: by 2002:a17:90b:3903:b0:309:fd87:821d with SMTP id
 98e67ed59e1d1-30c3d64c1e4mr22625967a91.29.1747088711025; Mon, 12 May 2025
 15:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510182011.2246631-1-a.s.protopopov@gmail.com>
In-Reply-To: <20250510182011.2246631-1-a.s.protopopov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 May 2025 15:24:58 -0700
X-Gm-Features: AX0GCFuOIpruwX_6aXQ-xUxyuGS_lY2tfBG77rPai-zJ86Quinut8A2hi-u63_Y
Message-ID: <CAEf4BzYGaZHohSD2X5bp2paL+7naKFX-7XNkGd1VzNu6eRVDYg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next] libbpf: Use proper errno value in nlattr
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 11:16=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> Return value of the validate_nla() function can be propagated all the
> way up to users of libbpf API. In case of error this libbpf version
> of validate_nla returns -1 which will be seen as -EPERM from user's
> point of view. Instead, return a more reasonable -EINVAL.
>
> Fixes: bbf48c18ee0c ("libbpf: add error reporting in XDP")
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  tools/lib/bpf/nlattr.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>

Thanks for the clean up fix! Applied to bpf-next.

> diff --git a/tools/lib/bpf/nlattr.c b/tools/lib/bpf/nlattr.c
> index 975e265eab3b..0ba527d33ce4 100644
> --- a/tools/lib/bpf/nlattr.c
> +++ b/tools/lib/bpf/nlattr.c
> @@ -63,16 +63,16 @@ static int validate_nla(struct nlattr *nla, int maxty=
pe,
>                 minlen =3D nla_attr_minlen[pt->type];
>
>         if (libbpf_nla_len(nla) < minlen)
> -               return -1;
> +               return -EINVAL;
>
>         if (pt->maxlen && libbpf_nla_len(nla) > pt->maxlen)
> -               return -1;
> +               return -EINVAL;
>
>         if (pt->type =3D=3D LIBBPF_NLA_STRING) {
>                 char *data =3D libbpf_nla_data(nla);
>
>                 if (data[libbpf_nla_len(nla) - 1] !=3D '\0')
> -                       return -1;
> +                       return -EINVAL;
>         }
>
>         return 0;
> @@ -118,7 +118,7 @@ int libbpf_nla_parse(struct nlattr *tb[], int maxtype=
, struct nlattr *head,
>                 if (policy) {
>                         err =3D validate_nla(nla, maxtype, policy);
>                         if (err < 0)
> -                               goto errout;
> +                               return err;
>                 }
>
>                 if (tb[type])
> @@ -128,9 +128,7 @@ int libbpf_nla_parse(struct nlattr *tb[], int maxtype=
, struct nlattr *head,
>                 tb[type] =3D nla;
>         }
>
> -       err =3D 0;
> -errout:
> -       return err;
> +       return 0;
>  }
>
>  /**
> --
> 2.34.1
>

