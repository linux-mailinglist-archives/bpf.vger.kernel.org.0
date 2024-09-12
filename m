Return-Path: <bpf+bounces-39773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185A977431
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 00:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9DF1F252AA
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 22:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761391C2435;
	Thu, 12 Sep 2024 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY0BZAuB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC8A1A3020
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179453; cv=none; b=SGEqBtz34i6ApQ2S2G27onq/22xyIEdlrPinw2RQ6Se54J2RncZdJDm0ZyNg52hf0cL6G3CF403U5c5sC2gLvWyjnG7HB015SQrQfRXuCCoFQW74OfUzYWVVpb9aGtPbbun8AFf/yxGx9frFQlXROgC73+GPIUFqjNmunMH89Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179453; c=relaxed/simple;
	bh=ROdat6U3eH+9UznHXBVmdN5YTNudMAPVopfcyIrHO5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MR2JUN1S3Ddi7MctX3VC80zGucZABu5KjAEp2GJuSrkgGNS0iT7YpIvA8EsTNRzSD7QHWPOd8uHrG4vE+7NQoVZe/ddYtX2DsmBXp+MjswdR35hTT8shpD+bsEi7BcpOI0QdH6aKJqlgENIaiFHOt2NbX65B5oZyx9+w9T5I4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RY0BZAuB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d5119d6fedso1844126a12.0
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 15:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726179450; x=1726784250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTXwLL0sQU1sDjykL4qAxiNFLHDzaD7Qw4/Qk6NsZXQ=;
        b=RY0BZAuBicC4nxOjCKQbM6NpHHA6NN3919iuxCAGw4ppeUusNTbXOrrUQFbYrCKy2s
         MGvrBUyQ1Gj/5+C9bOINAH5ybMfu5Had+Mei90lLdEpGGZoHH/+0BjYHZflqYTnPQaqS
         Kpt468FC1H3d5ReDiBd+IRofD/sIaOAye4mY4M11pqIsqRlI46zOTJE0IzcN3z6mLXOR
         NpZucHIGOOerqByGo4W4egcMk3tvDCcDybNOf1pan4FmWfnrdGLGW1u0L2DgHnJ3SQNk
         wkGxbPojYnKFgaC9aHo9bMpqAyMGB5gqn4FyB2QN1mi0q4jbSM666TTrkz8OLFGqnaJ3
         zB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726179450; x=1726784250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTXwLL0sQU1sDjykL4qAxiNFLHDzaD7Qw4/Qk6NsZXQ=;
        b=B6Aof7j4q2inmFLxHLL+JEoLVPPsDsXnBGfwrZSjzWbZTrqiA6Xiu2nlu5WNYttwyf
         yereZxIIhs7Ed9bxy2vDfJW1wSEsDVdYydusQyRNL8T7cbk+Z2ZhOE3GvJ1fzaNJ++oN
         xs1qDSUi+FX025Sqy5kWXaZZl9kMgPzlKCq7WtD/i2Pn0aJakZH/NM4/3OvqMXkay9Cv
         edC537K6aF4NBlJDbpZaKnOOXPV5vE4aUljaO98DuuRGoIZ8Z1Dt5SHn/hXp4h6l7qN8
         dYFVOJ+5J4g8c7r5+dwZGono2fBvxHArAcOLMreIXH+PnYTAnR4YUMuPkFicYC/ed9g6
         n9qQ==
X-Gm-Message-State: AOJu0YwJvSD8K8W/IeftzopZ5yEc96kvJ7UqUhFqgqoA/1umBJmB/eW8
	8djOOgqLB+5FmioyGUqCf2bvk8fyYbN91F8+t8f4hXbq8EKwdCnmj1SYWNgV8jGmfC8iD7TtbYt
	WaN9ElIIdO/IVoeCaS+/LhvFWCkk=
X-Google-Smtp-Source: AGHT+IEvDHcxkDu/6t4jtqR9E7ncdwEpb+rfpuERz7gVI3hNBtc7RaCar91iMOiwpLzWbu/g8lGfZyjqrvrOYc6VD6s=
X-Received: by 2002:a17:90a:7086:b0:2d8:999a:bc37 with SMTP id
 98e67ed59e1d1-2db67226a2dmr17278912a91.19.1726179449730; Thu, 12 Sep 2024
 15:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912214849.3102215-1-ihor.solodrai@pm.me>
In-Reply-To: <20240912214849.3102215-1-ihor.solodrai@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 15:17:17 -0700
Message-ID: <CAEf4Bzb5z6gG1WG9+a8G==x5xEzZkQxosyr14qROh8Lx3grVFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add bpf_object__token_fd accessor
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:49=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> Add a LIBBPF_API function to retrieve the token_fd from a bpf_object.
>
> Without this accessor, if user needs a token FD they have to get it
> manually via bpf_token_create, even though a token might have been
> already created by bpf_object_load.

bpf_object__load() is a public API, let's use its name in the commit.

>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  tools/lib/bpf/libbpf.c   | 5 +++++
>  tools/lib/bpf/libbpf.h   | 2 ++
>  tools/lib/bpf/libbpf.map | 1 +
>  3 files changed, 8 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 84d4ec0e1f60..e9ac950ce2ff 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9059,6 +9059,11 @@ unsigned int bpf_object__kversion(const struct bpf=
_object *obj)
>         return obj ? obj->kern_version : 0;
>  }
>

Can you please add a little bit of doc comment, see other APIs that do
have it for an example and syntax

> +int bpf_object__token_fd(const struct bpf_object *obj)
> +{
> +       return obj ? obj->token_fd : -1;

we should assume obj is valid and non-NULL, but also token_fd will be
>=3D 3 *after the load, if it's at all created*, so I think we should do
something like this:

return obj->token_fd ?: -1;

Other than that, it looks good.

pw-bot: cr


> +}
> +
>  struct btf *bpf_object__btf(const struct bpf_object *obj)
>  {
>         return obj ? obj->btf : NULL;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 6917653ef9fa..5cd143e83f95 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -294,6 +294,8 @@ LIBBPF_API const char *bpf_object__name(const struct =
bpf_object *obj);
>  LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *ob=
j);
>  LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, __u32 ke=
rn_version);
>
> +LIBBPF_API int bpf_object__token_fd(const struct bpf_object *obj);
> +
>  struct btf;
>  LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
>  LIBBPF_API int bpf_object__btf_fd(const struct bpf_object *obj);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 8f0d9ea3b1b4..0096e483f7eb 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -423,6 +423,7 @@ LIBBPF_1.5.0 {
>                 btf__relocate;
>                 bpf_map__autoattach;
>                 bpf_map__set_autoattach;
> +               bpf_object__token_fd;
>                 bpf_program__attach_sockmap;
>                 ring__consume_n;
>                 ring_buffer__consume_n;
> --
> 2.34.1
>
>

