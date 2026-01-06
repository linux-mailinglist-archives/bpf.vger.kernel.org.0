Return-Path: <bpf+bounces-77899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F95CF61AE
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 01:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF5773061142
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 00:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CB31DF751;
	Tue,  6 Jan 2026 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li/oIHyr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F01C5D72
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 00:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660408; cv=none; b=RqEl1rSu5TEy8PdQizG/Y9mOx2EDS/yr3qyd3QDBVZC+J8xiaiP+pjXGFz0YGQMseT3TLjde3UxvFl9DrDe/oXtv7qFJYq3GkFj0snrWnapXnBkjKqfxYimAXZuv6UqZc9xjbWObCrvQ4uyu8eG3rT0fcNTIDfuWj+tPaCK15bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660408; c=relaxed/simple;
	bh=3ps+PEURLvrLWFLfgANLnIZ6N9CTGHZn9LKOodC4TJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gL+Nk3UpeL7GeKD6HVUu16QVuOOJEv/XCB1s8YyclwKb2EOKj4pAmQ400ZDYG0UDPCoxmvZPeYZ5klF2LwCj28NM7gh3BvE8BYXY/86vRfewCWf6CVS3ZUkbROWpytxKJgsPP5WrIoxDka6VFqQtrvp7V7NWGgcrE3Ecw+k9BaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li/oIHyr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so544967b3a.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 16:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767660405; x=1768265205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v59EJCKdQ/rJwGad/P0KyJhvAyQle9hgCtAe6P0sjJs=;
        b=Li/oIHyrBeixPKIgf+wuu6/HsWt2AXbhKl3Y9D7w7/Ip2hdZ/tkvTTeWehpZNCVKsD
         jfHRvQCGgsNQiLY7Lrn6kNQI03T/dBI0sUuZl6/b1T5anGvIZoBMfviyBfCJ0Uf4GuEw
         Dkc9d5ZWaE8umpguJriXtyvMUAv+HmdV5Od6VAS/YRXDjho4x2TtZipMBqwtqayGYJhM
         G0bbP/PtXFENmfO1XH3FudX8v6ABOQmotAVeEnOsu15juKgq3OyVWF9y+4cEXulftGcZ
         NNaH3CtCdAMqWIUmLPZiTrN5uHw3EHiKTp/QQOIkrO3KttuyxD40aSBcdoLGdxdZdttB
         y/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767660405; x=1768265205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v59EJCKdQ/rJwGad/P0KyJhvAyQle9hgCtAe6P0sjJs=;
        b=Sabt6+7r/38eyvSkziP5sO3DJ0XfFBLyw+lcX3BYzuVQ7LVdbngppFt7lLCUQrc5wM
         PFCwwPe9MTzCkndanduy19RFrQtBlBxZL1IqKDk/Buy3MpVUg+Y/4Xp7ebPmtYipUfrq
         BLKTy2MOrLem8g5ECxJGNk2hWvBgFeymGVNlOL5ZoC5WU/ChGCJxdiFtpPSfAOgsUxlx
         rSIRPXgowtNfwr8tBHbShRcGB3KIKVO3veph/AI6iQvNLek/bcAI+vfpz/7hMPwFDsSY
         WXab7UKCHJ2A9EsRm+vVWV1+1WefY+GAMsgUenHkTP/Josocna8jLoLfmbxspHYGhO+D
         h2mg==
X-Forwarded-Encrypted: i=1; AJvYcCVT5Tm/nnHaz1ZElwZyiD849UmkNLmWo/d+TtEekbkkjFw+tyg+ar0eOhelpZfBlyEU5uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLSsJoLClo/rhAszH8DK5T7XPJIPeXduzsqKkKXsNjT+1J4f6m
	WEcPNIWwdKLSMSeREFxkfnLtrn8PF+FApZLpHSJpT8NZqsjYdBafxROGx9L3tNNWzWgK9bfSU1S
	vrdTWit5f7A8J6uDGkH926TNDSLK3hmE=
X-Gm-Gg: AY/fxX7mZSnIrC1OsmkCad12EKW7Mp2fRot3wTgUZSHjr+neL96UFEMd4zocbAzq+6/
	niak7IzBwqliMC2dOVRLFr1CrRoSwGA2/Alk9A3bgO4LB5oc469JU/+o9ZxuUAnn7ps7KaBp+GC
	6VwmSHviRDVKWaGYYxLZ7m6OpqKobggit2bT5jTJazjiNWKkxyzjLIZAVSfCVaXzwYSY5bEVV79
	DdS3KK3HEVWbqV2bCUhccHGN2Q8SSPog4jxGjYDMn6hATpfBgkaBzfA6+YagLz9232EC+ulLuXW
	rjwilmgIcAk=
X-Google-Smtp-Source: AGHT+IHM2Th9d4bXEcmoMWNJdXVah2byaKz0QadHnazpxYuHPAAVtGzA8bprh21HYBb6aCRPr9zDGYTfmvfMp7O2AIg=
X-Received: by 2002:a05:6300:4093:b0:364:14f3:22a7 with SMTP id
 adf61e73a8af0-389823808d6mr1021989637.42.1767660405425; Mon, 05 Jan 2026
 16:46:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231102929.3843-1-kiraskyler@163.com> <20260104021402.2968-1-kiraskyler@163.com>
In-Reply-To: <20260104021402.2968-1-kiraskyler@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 16:46:33 -0800
X-Gm-Features: AQt7F2rcfbH9Y5m7UeUYkDt5o299KZ3ytnuUuKeZyIgmB5E7qPEvEMOV74U2TiQ
Message-ID: <CAEf4BzbKfqef+GS8UrpXNPZRZ+Nk-w+wjnNFY1SLJYPxYq3DBg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] bpftool: Make skeleton C++ compatible with
 explicit casts
To: WanLi Niu <kiraskyler@163.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, WanLi Niu <niuwl1@chinatelecom.cn>, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 6:15=E2=80=AFPM WanLi Niu <kiraskyler@163.com> wrote=
:
>
> From: WanLi Niu <niuwl1@chinatelecom.cn>
>
> Fix C++ compilation errors in generated skeleton by adding explicit
> pointer casts and using integer subtraction for offset calculation.
>
> Use struct outer::inner syntax under __cplusplus to access nested skeleto=
n map
> structs, ensuring C++ compilation compatibility while preserving C suppor=
t
>
> error: invalid conversion from 'void*' to '<obj_name>*' [-fpermissive]
>       |         skel =3D skel_alloc(sizeof(*skel));
>       |                ~~~~~~~~~~^~~~~~~~~~~~~~~
>       |                          |
>       |                          void*
>
> error: arithmetic on pointers to void
>       |         skel->ctx.sz =3D (void *)&skel->links - (void *)skel;
>       |                        ~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~
>
> error: assigning to 'struct <obj_name>__<ident> *' from incompatible type=
 'void *'
>       |                 skel-><ident> =3D skel_prep_map_data((void *)data=
, 4096,
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>       |                                                 sizeof(data) - 1)=
;
>       |                                                 ~~~~~~~~~~~~~~~~~
>
> error: assigning to 'struct <obj_name>__<ident> *' from incompatible type=
 'void *'
>       |         skel-><ident> =3D skel_finalize_map_data(&skel->maps.<ide=
nt>.initial_value,
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
>       |                                         4096, PROT_READ | PROT_WR=
ITE, skel->maps.<ident>.map_fd);
>       |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: WanLi Niu <niuwl1@chinatelecom.cn>
> Co-developed-by: Menglong Dong <dongml2@chinatelecom.cn>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> changelog:
> v3:
> - Fix two additional <obj_name>__<ident> type mismatches as suggested by =
Yonghong Song
>
> v2: https://lore.kernel.org/all/20251231102929.3843-1-kiraskyler@163.com/
> - Use generic (struct %1$s *) instead of project-specific (struct trace_b=
pf *)
>
> v1: https://lore.kernel.org/all/20251231092541.3352-1-kiraskyler@163.com/
> ---
>  tools/bpf/bpftool/gen.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 993c7d9484a4..010861b7d0ea 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -731,10 +731,10 @@ static int gen_trace(struct bpf_object *obj, const =
char *obj_name, const char *h
>                 {                                                        =
   \n\
>                         struct %1$s *skel;                               =
   \n\
>                                                                          =
   \n\
> -                       skel =3D skel_alloc(sizeof(*skel));              =
     \n\
> +                       skel =3D (struct %1$s *)skel_alloc(sizeof(*skel))=
;    \n\
>                         if (!skel)                                       =
   \n\
>                                 goto cleanup;                            =
   \n\
> -                       skel->ctx.sz =3D (void *)&skel->links - (void *)s=
kel; \n\
> +                       skel->ctx.sz =3D (__u64)&skel->links - (__u64)ske=
l;   \n\

I'm wondering if this can also trigger some warnings under some
circumstances? void * is castable to long or unsigned long, but __u64
can be defined as long long (plus it's a question what happens on
32-bit architectures). Why worry about this if we can cast to `char *`
to calculate this size?

>                 ",
>                 obj_name, opts.data_sz);
>         bpf_object__for_each_map(map, obj) {
> @@ -755,13 +755,17 @@ static int gen_trace(struct bpf_object *obj, const =
char *obj_name, const char *h
>                 \n\
>                 \";                                                      =
   \n\
>                                                                          =
   \n\
> +               #ifdef __cplusplus                                       =
   \n\
> +                               skel->%1$s =3D (struct %3$s::%3$s__%1$s *=
)skel_prep_map_data((void *)data, %2$zd,\n\

we already use __typeof__() (see gen_st_ops_shadow_init), so let's use
that unconditionally without __cplusplus special casing

pw-bot: cr


> +               #else                                                    =
   \n\
>                                 skel->%1$s =3D skel_prep_map_data((void *=
)data, %2$zd,\n\
> +               #endif                                                   =
   \n\
>                                                                 sizeof(da=
ta) - 1);\n\
>                                 if (!skel->%1$s)                         =
   \n\
>                                         goto cleanup;                    =
   \n\
>                                 skel->maps.%1$s.initial_value =3D (__u64)=
 (long) skel->%1$s;\n\
>                         }                                                =
   \n\
> -                       ", ident, bpf_map_mmap_sz(map));
> +                       ", ident, bpf_map_mmap_sz(map), obj_name);
>         }
>         codegen("\
>                 \n\
> @@ -857,12 +861,16 @@ static int gen_trace(struct bpf_object *obj, const =
char *obj_name, const char *h
>
>                 codegen("\
>                 \n\
> +               #ifdef __cplusplus                                       =
   \n\
> +                       skel->%1$s =3D (struct %4$s::%4$s__%1$s *)skel_fi=
nalize_map_data(&skel->maps.%1$s.initial_value,\n\

same as above, __typeof__ ?

> +               #else                                                    =
   \n\
>                         skel->%1$s =3D skel_finalize_map_data(&skel->maps=
.%1$s.initial_value,  \n\
> +               #endif                                                   =
   \n\
>                                                         %2$zd, %3$s, skel=
->maps.%1$s.map_fd);\n\
>                         if (!skel->%1$s)                                 =
   \n\
>                                 return -ENOMEM;                          =
   \n\
>                         ",
> -                      ident, bpf_map_mmap_sz(map), mmap_flags);
> +                      ident, bpf_map_mmap_sz(map), mmap_flags, obj_name)=
;
>         }
>         codegen("\
>                 \n\
> --
> 2.39.1
>

