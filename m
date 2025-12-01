Return-Path: <bpf+bounces-75824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 096E1C98834
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 18:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55469344696
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0FC337BA6;
	Mon,  1 Dec 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDHDxekv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319A531813F
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610038; cv=none; b=WYUXUwmisT1sZ4v9RjtnAEXx/6bwNOdWDdUI9gzEe1YtfYFNh3feyHESTB63OrzkhLltRF7cSBmwRY3fcVXeERIUn1mvO0o+M4H793CKgvGW2Xtgszujrf74bpyKZaqVML/fhUcRvJqJbRzTD4J+e/iYUpzy+IH9VqxlhtYoLcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610038; c=relaxed/simple;
	bh=UKEcAU5XG9XTh0LArW+wQNvSNYiB+nKnM68aZ0vsVi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhZa7NF8R4VrnzL2uJyQl0HVHYJi0kN+F3N+us1VAi9YvDXIV5VXKfcZSI4o/nbjTVrbthvY+2JhApZyv8wTf94Ci7Veuv8Eqj39b8BNbjUibfRSEhWukGM6ZK1k6l6jt1NHGwJX9q0DxaKBmvjFGNlK/+OM8NfWq/rK4dRfSt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDHDxekv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3438231df5fso5138712a91.2
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 09:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764610036; x=1765214836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijq5sdrlqJg37gB6OmgS7cKCkkSyxlmrkLtviwXuwno=;
        b=iDHDxekv4gVpeFGVHXCkHbjAFU5Dbw3m+XHVPOMWq1BNS+K7IX1RHNnnKUu4BLu6uI
         21ZCWI9LqrjGSfPChFUJRdCkVxZpRJohTyeIrTJajDnbX1V14FFyFwk1bzLhfXqOBBxS
         uisHkfBVsgmHbk6t7fEgi4YlkCH87v7I1UGLWBWCsV77fzHDa0oPAwxGyyV1wDm4YvHx
         lcDovKGVJmrKonM7g5AZWjPhmjIxpCv3ExyuSpoCQ82u0baI8CSbHimXM1VYklw0KqGU
         e7kb8HJDw6Wq3xtMYEODEJ3kR7gfj9F6YtC3YK2gIFfP4dOvL64dMBidoCiZoJcRfmBY
         aMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764610036; x=1765214836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ijq5sdrlqJg37gB6OmgS7cKCkkSyxlmrkLtviwXuwno=;
        b=PiayJtG2gn3MdBgzbGTPZTHm4GY7m8zD6df7jAgoN+/Z46C3rBufxADEfnHwK/6zsF
         36ly0CFVwzUHZXeI1hecFlS+ErZYipvW+f1qkvQUXKhfJ+dPYVs/RwiTuV7cp0jAY1HZ
         YkZ7lL5kKu/KnUbKiOLjILB7DsJkXpZJcuBdc/40spOuQmmm5sUlKr7iKJDkAknFDaXH
         qjbMKdPMhS1ZY9TpR7L3lDaGwZvKdffzL35Z/NyZnWSOvyYmYEZMwSeoDIJhuQlrLxHJ
         gAwZ+sa2juxf8uBxCBo52zfcDhEdQJnXn4N6uQVQKmJXQgJ0IU8aMdeUVfP7wK+DoGh5
         hcOA==
X-Forwarded-Encrypted: i=1; AJvYcCUu1e4/DxG8AHM+iS2u6zu8tyYNGy5e5Mwr9ReowoHHiSBNCEpo0w9YjdfFpvNci/0B29M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+E07uIMxWBAi4OV5nYQJSndLf3cNV7Mcba5fb9jCgBv3rf5Ux
	koxrqS4UpYW65j/UlrYT7JL5902YYcQV7Fm9lFQnMqaaEY1Kfpj1SWWyRT893IQVZ202D0rY4u8
	dMdUfer3S1xrw22W7aZ+W57rHi5KtY0M=
X-Gm-Gg: ASbGnct8xEEZgVpBx+IrGm3di2BNf7e7EKo45rBwNJLt5/1FHI4wIQjpfVzbThHF48E
	OJqg/ByTo0J0vginHwov7f9wJm/l/lS8XLPvzlNsKkmMHQwlhle+tvqRvtz+VnfhwgCdmR59Aei
	Bde37pTYMYqhB9w3eGCOBQZDjd5OLBiRZbmmRR/W+rvxe8aQSar3w5vLWWvl1gpVSa/FRadYm54
	UdqTiMAhfzx2NX2hZ62ioWJ2zmVyOY9NcasbRsOdnxnBMM+D8hTR22028ELrDpxULFtGzTgkCPI
	CZfxogTt7cM=
X-Google-Smtp-Source: AGHT+IGx09HDUgaoADTduGqPajX6ASw2XvUan4kcA666p0ucXEytDotdQYFZNC19FTRcVAIVrhsi5V5N6apBj1QvUjk=
X-Received: by 2002:a17:90b:2781:b0:341:194:5e82 with SMTP id
 98e67ed59e1d1-3475ed5183fmr24662841a91.30.1764610036443; Mon, 01 Dec 2025
 09:27:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev> <20251127185242.3954132-4-ihor.solodrai@linux.dev>
In-Reply-To: <20251127185242.3954132-4-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Dec 2025 09:27:03 -0800
X-Gm-Features: AWmQ_bkjXdi8-UO2T_nJR5GKr0m3vFgYdnfm11dAyI-KtaylhiOL7YCwKriYRGE
Message-ID: <CAEf4Bza+L_RL_d7JFFLmzkYj2dbnT8rDgqwCat2zLOekToRm-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] resolve_btfids: introduce enum btf_id_kind
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Donglin Peng <dolinux.peng@gmail.com>, bpf@vger.kernel.org, dwarves@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 10:53=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> Instead of using multiple flags, make struct btf_id tagged with an
> enum value indicating its kind in the context of resolve_btfids.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/resolve_btfids/main.c | 62 ++++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 20 deletions(-)

[...]

>
> -static struct btf_id *add_set(struct object *obj, char *name, bool is_se=
t8)
> +static struct btf_id *add_set(struct object *obj, char *name, enum btf_i=
d_kind kind)
>  {
>         /*
>          * __BTF_ID__set__name
>          * name =3D    ^
>          * id   =3D         ^
>          */
> -       char *id =3D name + (is_set8 ? sizeof(BTF_SET8 "__") : sizeof(BTF=
_SET "__")) - 1;
> +       int prefixlen =3D kind =3D=3D BTF_ID_KIND_SET8 ? sizeof(BTF_SET8 =
"__") : sizeof(BTF_SET "__");
> +       char *id =3D name + prefixlen - 1;
>         int len =3D strlen(name);
> +       struct btf_id *btf_id;
>
>         if (id >=3D name + len) {
>                 pr_err("FAILED to parse set name: %s\n", name);
>                 return NULL;
>         }
>
> -       return btf_id__add(&obj->sets, id, true);
> +       btf_id =3D btf_id__add(&obj->sets, id, true);
> +       if (btf_id)
> +               btf_id->kind =3D kind;
> +
> +       return btf_id;
>  }
>
>  static struct btf_id *add_symbol(struct rb_root *root, char *name, size_=
t size)
>  {
> +       struct btf_id *btf_id;
>         char *id;
>
>         id =3D get_id(name + size);
> @@ -288,7 +301,11 @@ static struct btf_id *add_symbol(struct rb_root *roo=
t, char *name, size_t size)
>                 return NULL;
>         }
>
> -       return btf_id__add(root, id, false);
> +       btf_id =3D btf_id__add(root, id, false);
> +       if (btf_id)
> +               btf_id->kind =3D BTF_ID_KIND_SYM;

seeing this pattern repeated, wouldn't it make sense to just pass this
kind to btf_id__add() and set it there?

> +
> +       return btf_id;
>  }
>

[...]

> @@ -643,7 +656,7 @@ static int id_patch(struct object *obj, struct btf_id=
 *id)
>         int i;
>
>         /* For set, set8, id->id may be 0 */
> -       if (!id->id && !id->is_set && !id->is_set8) {
> +       if (!id->id && id->kind =3D=3D BTF_ID_KIND_SYM) {

nit: comment says the exception is specifically for SET and SET8, so I
think checking for those two instead of for SYM (implying that only
other possible options are set and set8) would be a bit more
future-proof?

>                 pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id=
->name);
>                 warnings++;
>         }

[...]

