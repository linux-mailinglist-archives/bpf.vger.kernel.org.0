Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41361DF403
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2019 19:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfJURSJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Oct 2019 13:18:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56454 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727344AbfJURSJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 21 Oct 2019 13:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571678287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+t8QSQoLerdt4pejgVZOi0oUqAT+Edm4K+E29wMVHLM=;
        b=g4AqWU4KwemP6K2DGjAMEJVhLjGErxMvZBjNmd2DnROVq2yF9W2PNgpmAwA19pAxifhu2N
        bSgXWX626VqA8X/5TGJhA9uKd4a+fLJ0r74YmoEO7YtLgErHiMWU6TZ9T/EqqX5dqdkYmz
        sLNKy8b/OINd9nLR8dmkdU+wXNk93Uk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-is3GeFNGOU6v2DsBf5BAsw-1; Mon, 21 Oct 2019 13:18:05 -0400
Received: by mail-wr1-f71.google.com with SMTP id v8so6756895wrt.16
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2019 10:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GV5veQW78aMR5eZOJ6fuROM1N/bzq4/iR/dGSQiRmZo=;
        b=tMXfCUkj+9yhVwar5Ex2Z+ft2aaIuWyNh+Taj9hPkRw8jenrF72OCNti60P6+jfynC
         U8dc/haQBjIFEFaVve5qtj4P2Cgem1a6Y4Xi2f3mvMHTFgxvIs0wjn2pKTBo56cUIg5A
         zUebo1T8l81T197xPEQzX2g0sJzTDA1bKW9a7sU1iCbyPJilE5/McSz9I4oPP4EVUR+y
         Oa0LHxP/fD/5tBKSDPogSwRzQ1IrgDCqCUzgEYVYKOgLvb0ymgxaRkZIaKY+HeoAi4dR
         i9EuLZyGX5IiMDhuCo/fiVCc46d43FwKjDg6G45q/9tYxrSu8TAw4Es0DUfro1C4eetE
         EflQ==
X-Gm-Message-State: APjAAAVbJxFbdpIi4yP1YsMizn9+l1jg0hGIZzsC1GWlUjb+6C37x2xh
        SKoGvdKymV5ZLy+9GYIkcNDW95hHME2AkOJabRG8a1x7HcaTSEsYZZwFIwNECoQaZT8X2HuR5l6
        WiFgoCUgwsFxK
X-Received: by 2002:adf:b21a:: with SMTP id u26mr21741052wra.119.1571678284030;
        Mon, 21 Oct 2019 10:18:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzrLN72M60UQL4cOILGD73CovlUeWe1ctsIG1zMZaHXb79Klh5ixz8UOVkGISgXAVbqnYecdg==
X-Received: by 2002:adf:b21a:: with SMTP id u26mr21741027wra.119.1571678283764;
        Mon, 21 Oct 2019 10:18:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id v6sm18695282wru.72.2019.10.21.10.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 10:18:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5F1C91800E9; Mon, 21 Oct 2019 19:18:02 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next] libbpf: make LIBBPF_OPTS macro strictly a variable declaration
In-Reply-To: <20191021165744.2116648-1-andriin@fb.com>
References: <20191021165744.2116648-1-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 21 Oct 2019 19:18:02 +0200
Message-ID: <87r236ow51.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: is3GeFNGOU6v2DsBf5BAsw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> LIBBPF_OPTS is implemented as a mix of field declaration and memset
> + assignment. This makes it neither variable declaration nor purely
> statements, which is a problem, because you can't mix it with either
> other variable declarations nor other function statements, because C90
> compiler mode emits warning on mixing all that together.
>
> This patch changes LIBBPF_OPTS into a strictly declaration of variable
> and solves this problem, as can be seen in case of bpftool, which
> previously would emit compiler warning, if done this way (LIBBPF_OPTS as
> part of function variables declaration block).
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/bpf/bpftool/prog.c |  6 +++---
>  tools/lib/bpf/libbpf.h   | 13 +++++++------
>  2 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 27da96a797ab..1a7e8ddf8232 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1093,6 +1093,9 @@ static int load_with_options(int argc, char **argv,=
 bool first_prog_only)
>  {
>  =09struct bpf_object_load_attr load_attr =3D { 0 };
>  =09enum bpf_prog_type common_prog_type =3D BPF_PROG_TYPE_UNSPEC;
> +=09LIBBPF_OPTS(bpf_object_open_opts, open_opts,
> +=09=09.relaxed_maps =3D relaxed_maps,
> +=09);
>  =09enum bpf_attach_type expected_attach_type;
>  =09struct map_replace *map_replace =3D NULL;
>  =09struct bpf_program *prog =3D NULL, *pos;
> @@ -1106,9 +1109,6 @@ static int load_with_options(int argc, char **argv,=
 bool first_prog_only)
>  =09const char *file;
>  =09int idx, err;
> =20
> -=09LIBBPF_OPTS(bpf_object_open_opts, open_opts,
> -=09=09.relaxed_maps =3D relaxed_maps,
> -=09);
> =20
>  =09if (!REQ_ARGS(2))
>  =09=09return -1;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 0fdf086beba7..bf105e9e866f 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -77,12 +77,13 @@ struct bpf_object_open_attr {
>   * bytes, but that's the best way I've found and it seems to work in pra=
ctice.
>   */
>  #define LIBBPF_OPTS(TYPE, NAME, ...)=09=09=09=09=09    \
> -=09struct TYPE NAME;=09=09=09=09=09=09    \
> -=09memset(&NAME, 0, sizeof(struct TYPE));=09=09=09=09    \
> -=09NAME =3D (struct TYPE) {=09=09=09=09=09=09    \
> -=09=09.sz =3D sizeof(struct TYPE),=09=09=09=09    \
> -=09=09__VA_ARGS__=09=09=09=09=09=09    \
> -=09}
> +=09struct TYPE NAME =3D ({ =09=09=09=09=09=09    \
> +=09=09memset(&NAME, 0, sizeof(struct TYPE));=09=09=09    \
> +=09=09(struct TYPE) {=09=09=09=09=09=09    \
> +=09=09=09.sz =3D sizeof(struct TYPE),=09=09=09    \

Wait, you can stick arbitrary code inside a variable initialisation
block like this? How does that work? Is everything before the (struct
type) just ignored (and is that a cast)?

-Toke

