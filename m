Return-Path: <bpf+bounces-60851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1969ADDD31
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6775117FCA9
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 20:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD0725CC69;
	Tue, 17 Jun 2025 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRZX5+Gn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C125524D;
	Tue, 17 Jun 2025 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750192076; cv=none; b=TbedPD+UAEZddn+cIahNLpbllnMc1PnXiizYod0lPkvlLKhOj0bpb/HFSY2WDG6bcqSGpc/XTaN5Jp1B4I1kcs0Z8OLAj+EBGdS/q1TqbzVLsXdSmw1W8fUReoZanPJ6koi60N61Gf69nnHtdvNz6KgiiQPkPc5BpX9GkXOY704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750192076; c=relaxed/simple;
	bh=yq99ck85b7qDTS+ZXcN0YZNFKs9btk7vpQPZhXYi6Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5JuOd2gU8uKtH6rHPMiCak/+IeDRe+QI4kCgSa8PFdfK38eJFlItW+sD/9BWrV+0PkvhOsNarkNQxcb3PPd8PffObqEGMAqpyEThdZEvVx/OaPYucXzgdvKK/xj4z7XebREysGXkRrplBmQKbMh2yylvVaAgoACrIcVVIGCOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRZX5+Gn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2fd091f826so58211a12.1;
        Tue, 17 Jun 2025 13:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750192073; x=1750796873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSTEQMToOv0oZJn0SroSbuUFhUU6JyythnMIhO16b3Q=;
        b=bRZX5+GnFrMzSOUVX8UICjmgwkXvJrVua3XZHntDiE8hztu8urE4jfnFUji5R7eKMD
         Nnep9xyZd2ag5GARZ3lMJb3ob+LMod54/B4ku8PZ2eTlhZJSw5bAG491tlxIMGYpxI5o
         tSOZ4O7YxnTNQoIwE6/QDh2b2WNY7Mw2mz9JyKsu5oEbV4edh84+v7aIv88wxgiksqFP
         J0eEn/o+KiKBW+g+7ifYbRhI+jil08AlzNx65VoQ5GMZJYyKVLffen5PmUYOwkVPf+bn
         3k8zU1KoUzFkNlxCRByW5uNRNGj3c/IiNyARJaOfcLtEIXdjB+fHKyzTowq0wlgXWM4J
         Je5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750192073; x=1750796873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSTEQMToOv0oZJn0SroSbuUFhUU6JyythnMIhO16b3Q=;
        b=CKPwnKcEny13gfn6ZCv191ADg0B9tOf8wU1kbXP6Zin2tZy5OyFKO/QE8F8ZpUlSTw
         VG7n4/PEd30hdnSAVIArVUxxr7OTINB/b5xEDXJEmC0xsayuT5rTqPmkHBjWTIJ7Dnuu
         UyHxHFtcqXL56Ff69vTyZRqvZjqNfaLlXxJ1ZhlS6zW9blWJEidh+FOecU1OtZ7SzPwx
         LhVsMNTc4ihAXHJHZ6Id2PXeOg+NP49XHgYNWvFGkHz4Jx3+Nnx5iU3m8PQFKmJmMd/Y
         3/mp/zrpfvKScVWLQ2T4aSP7m8yorZOzjzqoibht9L/tY01mDdXLbyJQAwpnkH9Z1EeT
         3CvA==
X-Forwarded-Encrypted: i=1; AJvYcCW8l9FTsLipwD6d0lRD06r6wIVD3k/e3ZeUCu9RHtQ5xw8TJa0pzZI68Cu8houmU0cTMu0wB8ODJAfn36fo@vger.kernel.org, AJvYcCXtjYaJPF/tXTIn8VX6o8gu5+BuFdUkJdP0fCzxAffYfzMStiKizKQ00d7RU1joXH9FKwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtS/eU3Sc2jSzjAODs/ghD6vdzU3XgTrfn9YxOApmzo7EnpRf
	JRAzhcyMMQWdKKXJqQ8KGFv4tp9ZGcgcHe9VNG+f46xYgjJuO8natvuWPs8uBVkyqQeyrXafJId
	QK+Ig+wMlKKXuOvqf/ISQXaMpAQh1ERA=
X-Gm-Gg: ASbGncv2d6NQEVa6XOWvEkIgG1IeqlysRi+qIi0E2nDhrLr7hnh8GJ5uf7rwzyCXxim
	1jX2XQX1tRLX3eY+kjEXlsxil1syIld+2ecibPkuKkUbFZnRmDs9FJPPXJQTCBgrNRMqVgUc7Ow
	4cYtd/LMMouXpHdIRe8Y8zwxQD1XeO3zbwOmkb75HD+M/5e1BO2kB2R1BXgn0=
X-Google-Smtp-Source: AGHT+IEbiUW6hhR1A/NI8FK2b+KM+cHULqADEyjctpVClitWKSBBPbEqOkOEasxmHKUUXzNmrQ5Fe5sHrN97iZYKMdE=
X-Received: by 2002:a05:6a21:9996:b0:21a:de8e:5c53 with SMTP id
 adf61e73a8af0-21fbc778ea8mr22698910637.12.1750192073214; Tue, 17 Jun 2025
 13:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617085554.51882-1-chenyuan_fl@163.com>
In-Reply-To: <20250617085554.51882-1-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Jun 2025 13:27:41 -0700
X-Gm-Features: AX0GCFtylKOo8YErl4_bgf2fKGi0X_q_60vcTN2jmbHy7kh3m_OAKQ4rIXepnb8
Message-ID: <CAEf4BzZgnDFB0Uf7bezg62aafYEVwnb0rvYkDyRj-uQyYGvLPg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix null pointer dereference in btf_dump__free on
 allocation failure
To: chenyuan <chenyuan_fl@163.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chenyuan <chenyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 1:56=E2=80=AFAM chenyuan <chenyuan_fl@163.com> wrot=
e:
>
> From: chenyuan <chenyuan@kylinos.cn>
>
> When btf_dump__new() fails to allocate memory for the internal hashmap
> (btf_dump->type_names), it returns an error code. However, the cleanup
> function btf_dump__free() does not check if btf_dump->type_names is NULL
> before attempting to free it. This leads to a null pointer dereference
> when btf_dump__free() is called on a btf_dump object.
>
> Fix: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
> Signed-off-by: chenyuan <chenyuan@kylinos.cn>
> ---
>  tools/lib/bpf/btf_dump.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 7c2f1f13f958..80b7bec201f7 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -227,6 +227,9 @@ static void btf_dump_free_names(struct hashmap *map)
>         size_t bkt;
>         struct hashmap_entry *cur;
>
> +       if (IS_ERR_OR_NULL(map))
> +               return;
> +

it looks like btf_dump__new() will always reset those failed hashmaps
to null, so it should be enough (and a bit cleaner) to just do

if (!map)
    return;

pw-bot: cr

>         hashmap__for_each_entry(map, cur, bkt)
>                 free((void *)cur->pkey);
>
> --
> 2.25.1
>
>

