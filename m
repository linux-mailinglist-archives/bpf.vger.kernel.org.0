Return-Path: <bpf+bounces-60976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F185ADF2B1
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708011885918
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9212F0050;
	Wed, 18 Jun 2025 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+qIb6oy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6B2EE5ED;
	Wed, 18 Jun 2025 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264150; cv=none; b=e4v4075k5ntfrHGGnbH/x1U80b9tSAmUB6sP0Ws9Tz6DomQFoQVGU6iG8XKo3AoUfwevY0MdI/9B2CyM3rmKTCNMXbvFn26+rM7CNFm8Kkz5E+tJGd7qvK76bQZKa8DI6pgSz+kYy0d5feJS1pGWyB+/darhNgj852FS4JdSvF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264150; c=relaxed/simple;
	bh=9SLa1q9Pak84QCpjXco8/q2gGqSY6bF+kN8FZ0ev6fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBA5IIEb3hEvZ5aFsBNaWAmqzY1qOsYtZgRumbInI3piXOQDqiAH7B/Yn/89vzSPftTBJmTnMd2nt+rS17JLK5ikNgqxJR9bksT2jENi9AqBwoh6d+3Di6M3s0kBUvqNatzUxpMCNCSmYvN7i9/E7R8eY6tbJx9iTgOC/rg5nzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+qIb6oy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so90391065e9.1;
        Wed, 18 Jun 2025 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750264147; x=1750868947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lqAYtkpafNC7lzR5Lfub5awrDOE4jtjrDArcjQTGp0=;
        b=J+qIb6oyTjxytzJBXAWZ92f7M83UMdWHTiLclw+i059JKVqOGlYUL42wUJ8Ln52Htl
         c1UVvax/QpLfRpbcbbh/kJqyaxtgru58cY/31nicdZS/W9fneraVRrKBg0h3qtwx7VIO
         3PLdr6rg59dRDPKitvuT508/R7ya8oYlETQau62wN/DzkzRjZrBY0vdbEPTt4s6lblcS
         Nf2YpZCqkm8Urh6oIKatdkj2HSZKRoyv22y2RDScjNuW8W1jZBbD7TrABLpmmf1woXYd
         tGfR4ZCWy5kaQQbXl64ks8jnmZ6MJ4+CyzCf+vql48GPhzX6jNBNhg0wTsO3fs4feYaL
         7COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750264147; x=1750868947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lqAYtkpafNC7lzR5Lfub5awrDOE4jtjrDArcjQTGp0=;
        b=cwnoE6dvi3PC4k1AefC9d3oLSFHxEZW7NtrwVvbQVcjCqxBz9qPvaLHguYYkvBfD1x
         T0sqK5K43FmbaQa96g9Yug9SCD5+x5/H0U4dm4y4kxo0Biafwmoytk70K836b9d66I5s
         CnFkQlMawssIbPnT1waKRydqUinEZeyMzKp3cOBFc8YvpPqMcOEeNkX/6W6u+B9Xw+l5
         06IEN8KxU2O+obodnnOgwUE3x3ItHUCRHr6Lxe8F/cSbSW4k3wFc8/HX5YZIx+UvmPEm
         2zyB1bPCk7h29GvLyhooairaIDbDQu6nrLnX06ItkS/yZuo1HEwAW94+o3PrI3bMUlb/
         b/3A==
X-Forwarded-Encrypted: i=1; AJvYcCWtepYb4S87/tg+XMnwfhOTecwmJHZNJ69g7wT6AKieiYNdaLeYLP+898RV7sjkESa8PRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9C+o3KBPSkYFovJJdNjIElwrZVQxUl0sklz2s5hmBVmmoNOuA
	tdDY1RfNUhN1TEmOzjoE6DoNOrelPOMk7FqGsv4bq4cbDReYC290CSRCOeyIfdNChhgsKfN3SeN
	nomTxB4wb5U0ukH7UsyTGG8hxc57t/uQ=
X-Gm-Gg: ASbGncskVTdvOtbFbEjNpYRwPQoP9Q1WSwbpsHqz1Z44JvOlOt9c0pLgyOTh2E7dM+n
	QGPxkvMapKFn/nw/IkhEygXqi59eDTjCYogQggw7PMaw0CUU5o0bSVWQKq+SI4rBk88/P30m1C5
	5UY8xONqhUIDhSz80T0R7QPsnTJWdo8MsaAX79G6uha1DMyMYQkAKLLkHRUJjm1ZHYiIlm2A9n
X-Google-Smtp-Source: AGHT+IGoN6HWyBfV65/LyWEmoXqWenu7SN8sC6ZCkhabNJsbT32Xy+4ii7hnttDTx9oQB2WDXJ/obmubwj32atMFFlA=
X-Received: by 2002:a05:600c:620f:b0:43d:fa59:a685 with SMTP id
 5b1f17b1804b1-4533cb1b85cmr175708405e9.33.1750264147095; Wed, 18 Jun 2025
 09:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-btf_skip_structs_on_stack-v1-1-e70be639cc53@bootlin.com>
In-Reply-To: <20250618-btf_skip_structs_on_stack-v1-1-e70be639cc53@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Jun 2025 09:28:56 -0700
X-Gm-Features: Ac12FXw-X8EiXIr6EGaMDDd9Tzs40cG-ybs1fp6ccCveR6AKiIh5vRmb4lwUmzQ
Message-ID: <CAADnVQJOiqCic664bPaBdwBwf1NGqfH-T6ZkQJOF7X4h7HuxBA@mail.gmail.com>
Subject: Re: [PATCH RFC] btf_encoder: skip functions consuming structs passed
 by value on stack
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexei Starovoitov <ast@fb.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 8:02=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> - those attributes are not reliably encoded by compilers in DWARF info

What would be an example of unreliability?
Maybe they're reliable enough for cases we're concerned about ?

> +
> +               if (param_idx >=3D cu->nr_register_params) {
> +                       if(dwarf_attr(die, DW_AT_type, &attr)){
> +                               Dwarf_Die type_die;
> +                               if (dwarf_formref_die(&attr, &type_die) &=
&
> +                                               dwarf_tag(&type_die) =3D=
=3D DW_TAG_structure_type) {
> +                                       parm->uncertain_loc =3D 1;
> +                               }
> +                       }
> +                       return parm;

This is too pessimistic.
In
bpf_testmod_test_struct_arg_9(u64 a, void *b, short c, int d, void *e, char=
 f,
                              short g, struct bpf_testmod_struct_arg_5
h, long i)

struct bpf_testmod_struct_arg_5 {
        char a;
        short b;
        int c;
        long d;
};

though it's passed on the stack it fits into normal calling convention.
It doesn't have align or packed attributes, so no need to exclude it ?

