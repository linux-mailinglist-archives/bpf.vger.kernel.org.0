Return-Path: <bpf+bounces-61214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C93BBAE2422
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 23:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6419B1C2169B
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 21:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0A238C16;
	Fri, 20 Jun 2025 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhdJlHLQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33E2AD16
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455575; cv=none; b=XSB/pN00glQuucvAxy4NUpxI5tDvvYE79WgaobNn4CS0ifIy04B6+m/Q7lX85S2UBj4pZ2fVzVwAjwDCMC0GE3NIZuLqUY/JFReuvCJremLcQazjeoVKrRKr8r1XZJtG47NNi6bsD3uiGWNb+5kSufpKBTMho5Lpa0fO8JzW6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455575; c=relaxed/simple;
	bh=Q89lMpAPVaFgjBNVN6IRZgjd7Yn1FU7RIR63xoarIRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQj0+sA5FJ6moaTCEDwp94zWEWf1p5XParJzxrmhnMm2NjNUy8S8J2Czb9YuXqWGfJ1/kARW3RB9ntckdq2ierX7U3yt/0wXNaWfx6MZyYsmaJzsK2+HXs8yjA5/7o4IeS9hk5tDNWT/aD6d58E/u/UUc8+6NQ9HpyYsVv8+wMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhdJlHLQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so1448866f8f.2
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750455572; x=1751060372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A3biamfPPc7jyu8lBs2iNLBinzExkA5TaAZLyYfucQ=;
        b=GhdJlHLQ5emE11J+eDgWn9i2Jvh28l6knLlVfQ7NuB/+sla7+o8V+W/SiryaS7eCzu
         uAYtp9txvpDhWSe2UCULFLgGn2Gh/LzCRif2TD6iCSJtst6KMTIvkMFiyPSw2D//RI7z
         HqalGfZEnlTjdO/4SczBncmn7HXyRgEuAmeUCoVjxChmZ61oeP3ON76oammSMgciq4Zy
         CE4PeufLiE/gqEVXCVmn0xOvc+eohIGUKN6pEXegVB3jC2YHzKLxhfS5gonqCzyRtrJd
         9ZkfIVwdbrh9tCGFfrxu5tNHOJvV092Hfe6mn2Blb0XbhoXLPI4oq21E7vADZpKV73EI
         4SAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455572; x=1751060372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2A3biamfPPc7jyu8lBs2iNLBinzExkA5TaAZLyYfucQ=;
        b=BJGAepH9FiVjCjdY2ZUR6NhLsh2UNNeF1RIL74mBgwZ3QU7sVrhy0DfhVuqoXDT+Rw
         yiguuJJuzyzekXSO/mribkyidwFhWvx+CTiQFnaJ2CSjpYx6qFgVnX3E9kq2TO+HuKM/
         lHQGVgOk3E4HzZImjnaOUEW1G/RKRhMlDAvjFhggwrGXe7jUwF3ws0E2tw/B0i5+XZt0
         zor3Mt2+SwoSq5if2eW0Wwhrs/UITUy6ekJ+ExPiXL2UtI0yy4YRPbp7BVABEGawAqe0
         8IOsYhQNyfsK40+P2RwiDLFfXKEFpPWz+VOzxqwmNKb+wrTQMrFWkuFWwewfp1WMRRCt
         R0xQ==
X-Gm-Message-State: AOJu0YwRY1uU/aaJTq1eKMDvc0ATC1CBtJ/UMRsW5CNIE3SsalSzm1Ns
	3ua/Gl0nvpBjuxq8ih6qwePhqJIp5nGK5321sfw8Ce10ruXYwNki8XslAjC420T7vinbV+g0e4T
	VNCEnQzMb8Pb8wSdIaraHbT+yrudAUaU=
X-Gm-Gg: ASbGncsjOpRy+whxIAZZO6uAiJmR+y4UwSWj2P8c8dkhHKc3rvTm24T9zsJ7ZD6TfrV
	1gJwIAYCl55YiGyG7D/w850nzDKGINsSsw+YheMdN9lyTpEcItCQ318eNZ04LF7J/UIlMsOIVNM
	kvd/dl+yNvX04ncZf04vMAtPbwey11LRqnFqXJWZ3HTizE4+V6aPvRYYJtceZetXN89ZqUBQLa
X-Google-Smtp-Source: AGHT+IH6g9rO1FLAZjDJtLYq7S/+yvneZS78divmWCllz55B20X5q6gmqgpW8OFoR3UtwUz0JmL6Kt01D3UABNkrRCk=
X-Received: by 2002:a05:6000:40c7:b0:3a4:d3ff:cef2 with SMTP id
 ffacd0b85a97d-3a6d12d8000mr3837042f8f.27.1750455571492; Fri, 20 Jun 2025
 14:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619221256.50893-1-adin@scannell.ca>
In-Reply-To: <20250619221256.50893-1-adin@scannell.ca>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Jun 2025 14:39:20 -0700
X-Gm-Features: Ac12FXxKCbToS7ihy6pkb4mgk5g6fgk9IRWP0az9ih5ZcDOzj-xYF2QFxWI9JnE
Message-ID: <CAADnVQ+Bn6SjGUL1fTYvBTmQP36XKpfV=RMtKYgqUHr0jdciDg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix possible use-after-free for externs
To: Adin Scannell <adin@scannell.ca>, inwardvessel <inwardvessel@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 3:14=E2=80=AFPM Adin Scannell <adin@scannell.ca> wr=
ote:
>
> The `name` field in `obj->externs` points into the BTF data at load time.
> However, some functions may invalidate this after loading (e.g.
> `bpf_map__set_value_size`), which results in pointers into freed memory a=
nd
> undefined behavior.
>
> The simplest solution is to simply `strdup` these strings, similar to the
> `essent_name`, and free them at the same time.
>
> Signed-off-by: Adin Scannell <adin@scannell.ca>
> ---
>  tools/lib/bpf/libbpf.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6445165a24f2..5adf2b68adb3 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -597,7 +597,7 @@ struct extern_desc {
>         int sym_idx;
>         int btf_id;
>         int sec_btf_id;
> -       const char *name;
> +       char *name;
>         char *essent_name;
>         bool is_set;
>         bool is_weak;
> @@ -4259,7 +4259,7 @@ static int bpf_object__collect_externs(struct bpf_o=
bject *obj)
>                         return ext->btf_id;
>                 }
>                 t =3D btf__type_by_id(obj->btf, ext->btf_id);
> -               ext->name =3D btf__name_by_offset(obj->btf, t->name_off);
> +               ext->name =3D strdup(btf__name_by_offset(obj->btf, t->nam=
e_off));
>                 ext->sym_idx =3D i;
>                 ext->is_weak =3D ELF64_ST_BIND(sym->st_info) =3D=3D STB_W=
EAK;
>
> @@ -9138,8 +9138,10 @@ void bpf_object__close(struct bpf_object *obj)
>         zfree(&obj->btf_custom_path);
>         zfree(&obj->kconfig);
>
> -       for (i =3D 0; i < obj->nr_extern; i++)
> +       for (i =3D 0; i < obj->nr_extern; i++) {
> +               zfree(&obj->externs[i].name);
>                 zfree(&obj->externs[i].essent_name);
> +       }

Good catch!
It's certainly a footgun that obj->btf->... will be reallocated
during bpf_map__set_value_size().

Probably this commit caused this issue:

Fixes: 9d0a23313b1a ("libbpf: Add capability for resizing datasec maps")

