Return-Path: <bpf+bounces-46035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CB79E2F40
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 23:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF62B2F4C5
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 22:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7111E0B62;
	Tue,  3 Dec 2024 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij4tpw7G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497BE16DC28;
	Tue,  3 Dec 2024 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265075; cv=none; b=D6zBp1WtFnH4aAvNi/e6lduIUjOU5Y8PUFdYykOj1rkuz5GO19ZKxTKpqScqsUohJ/oHn0f31fIp2G0JG2UWkNHUynH2Ou8RySHht0Tk1eOpfH/O8pvlv5MuUo+WUGarrn3r/Wamgoyzo2ugOtyFS/Zaa1zANJ0sgA1e+7yMLJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265075; c=relaxed/simple;
	bh=c5MRTgEpXTs5X0a7m0YrEMmIZmXQBFn35xi7Ua6hrNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spEMXJBQlu4a8X3WSchsPRcArWOEolDxd5cvOMzjHgB7RzvDxRmIe7k1FHZXArX+i3fRAUISGnLz63QVQa9yzagktrqmNuPIC5CwPUFVuh4Jg4cqY7zxD1uOez+XS4TBFxkyHzZ45KYp82HnubZP7u4Yyc75kbvwcXzHfWe6VLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij4tpw7G; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2eeb64f3588so2372198a91.2;
        Tue, 03 Dec 2024 14:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733265073; x=1733869873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9SJqAaxmorD+9qw36Zw9nCmhZEpy3S2qNX5DSfjjVQ=;
        b=ij4tpw7GOr6MsQjumkELyINnAmT5PcRMe6pIQTtOSl2woO9OGMCyRPXwhBuL+TLUo3
         0SM0Jm/aICvgua3xu4/5aRAFPabYp9/sFW31iJ19T0fBRTat+E13M1S5BNIwEoBUjasQ
         P7YH1omuypXz4ScnUYN7vIKXjL9oTq1XYjsSn8x/wlmS798BbN8tRcWaZqTgM4qLSiGA
         03svFHmNsgEZyb5Hfleld29ikYOSmOpJKVQR3d3crB4UbW0c6n2NGdfiotdAes3TzAq0
         eRUQxxNk3A9rZbplidGg/sHauF/hMXMVXllfWlhFBLumYZHbIoKN2eQGkLevw3cFq404
         AyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733265073; x=1733869873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9SJqAaxmorD+9qw36Zw9nCmhZEpy3S2qNX5DSfjjVQ=;
        b=I/2u1YXuGvKLqcCqnlQ5ub7SDmLAHmp7CURjujUcTkKZETR/OFG85jJP5E25EsYBhY
         f8P5Nte39RT7LtVmfFo1mRm3v3rtc49MsGTJHt1c83uk8QMmlWgo8KY6UirKBHGuA/Ce
         8qGgXXGGyqC9CEJt/l6FFwQVFLwkFxK3DgeESSzxktjGXx9zRJXz6UNP8iQXAYZZ9+0U
         D/Vvv2Qf7a95fYp9jgfsTX32zhyZXje8EV2B1z4E6CvmH1OuaR+ZMAOBW1ONdGCK43UP
         orEqXhSMeL8+WGKwOOReInejLuwxBZF6X0OHK1AzQVPsgRDimL6GDm/ciW7gqIoW0AAP
         qtEg==
X-Forwarded-Encrypted: i=1; AJvYcCUlKqfDC6YDLHJRfP5S3YaY/8fTor2Vsu7vZb8DhKrxtHk0RvaLgdPGYn5Fyf6zuXegLJw7kSXgxTyjPU3x@vger.kernel.org, AJvYcCVhUQLGricL6SBSooR8M63+GdMj3vjVbojmbBErsr/z8AHg+SQ2kX4dmp7xX7qGIpsN2JViHwQSj7dZhuJ2@vger.kernel.org, AJvYcCX+RFgP+Cf+5hUHJoxBvNQIxLuTM5z2p1Wdsuct4yDu0rqEV5Fg8JuhDK3+X1Ef7Tri+jY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxps5zm23RYD4zXPArCQqaoemV1dJGSYoos54jWSjlc4yLygwBw
	IxkOysSI7WnBkufu2GGb3DyMVCv0oFYajXtdtwj8yKTVikzNCopifnzXO/pDbJteJnnnxYKMO8/
	BWZE8rbCsrMU1I3vrMlEPEcatgdVWf2HX
X-Gm-Gg: ASbGncsq37yFR3kbG9raGsjWM045p1gt+SFpnR7ik3KqCQ96OmUXVzTqNu+ZTrCRWLf
	wKCuolp1ykIZy3X6FdJPNd9d9QSLymIEGbYV6aE4Sw79LL94=
X-Google-Smtp-Source: AGHT+IH4TwTjv29KSdNXPNZihG7gXMAt+LNB/0BY05BIIhdDOd1xQNu07M3/SWh/BlrWTKhZF/fp9Vdgn1rwdwDbn+s=
X-Received: by 2002:a17:90b:3ecb:b0:2ee:44ec:e524 with SMTP id
 98e67ed59e1d1-2ef012701camr5846182a91.35.1733265073437; Tue, 03 Dec 2024
 14:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-resolve_btfids-v2-0-288c37cb89ee@weissschuh.net> <20241126-resolve_btfids-v2-1-288c37cb89ee@weissschuh.net>
In-Reply-To: <20241126-resolve_btfids-v2-1-288c37cb89ee@weissschuh.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Dec 2024 14:31:01 -0800
Message-ID: <CAEf4BzahMQWVH0Gaub-tWjH9GweG8Kt7OBU-f+PBhmmRDCKfrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools/resolve_btfids: Add --fatal-warnings option
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 1:17=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> Currently warnings emitted by resolve_btfids are buried in the build log
> and are slipping into mainline frequently.
> Add an option to elevate warnings to hard errors so the CI bots can
> catch any new warnings.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/bpf/resolve_btfids/main.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index bd9f960bce3d5b74dc34159b35af1e0b33524d2d..571d29d2da97fea75e5f9c544=
a95b9ac65f9e579 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -141,6 +141,7 @@ struct object {
>  };
>
>  static int verbose;
> +static int warnings;
>
>  static int eprintf(int level, int var, const char *fmt, ...)
>  {
> @@ -604,6 +605,7 @@ static int symbols_resolve(struct object *obj)
>                         if (id->id) {
>                                 pr_info("WARN: multiple IDs found for '%s=
': %d, %d - using %d\n",
>                                         str, id->id, type_id, id->id);
> +                               warnings++;
>                         } else {
>                                 id->id =3D type_id;
>                                 (*nr)--;
> @@ -625,8 +627,10 @@ static int id_patch(struct object *obj, struct btf_i=
d *id)
>         int i;
>
>         /* For set, set8, id->id may be 0 */
> -       if (!id->id && !id->is_set && !id->is_set8)
> +       if (!id->id && !id->is_set && !id->is_set8) {
>                 pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id=
->name);
> +               warnings++;
> +       }
>
>         for (i =3D 0; i < id->addr_cnt; i++) {
>                 unsigned long addr =3D id->addr[i];
> @@ -782,6 +786,7 @@ int main(int argc, const char **argv)
>                 .funcs    =3D RB_ROOT,
>                 .sets     =3D RB_ROOT,
>         };
> +       bool fatal_warnings =3D false;
>         struct option btfid_options[] =3D {
>                 OPT_INCR('v', "verbose", &verbose,
>                          "be more verbose (show errors, etc)"),
> @@ -789,6 +794,8 @@ int main(int argc, const char **argv)
>                            "BTF data"),
>                 OPT_STRING('b', "btf_base", &obj.base_btf_path, "file",
>                            "path of file providing base BTF"),
> +               OPT_BOOLEAN(0, "fatal-warnings", &fatal_warnings,
> +                           "turn warnings into errors"),

We are mixing naming styles here: we have "btf_base" with underscore
separator, and you are adding "fatal-warnings" with dash separator. I
personally like dashes, but whichever way we should stay consistent.
So let's fix it, otherwise it looks a bit sloppy.

Please also use [PATCH bpf-next v3] subject prefix to make it explicit
that this should go through bpf-next tree.

pw-bot: cr

>                 OPT_END()
>         };
>         int err =3D -1;
> @@ -823,7 +830,8 @@ int main(int argc, const char **argv)
>         if (symbols_patch(&obj))
>                 goto out;
>
> -       err =3D 0;
> +       if (!(fatal_warnings && warnings))
> +               err =3D 0;

nit: just

if (!fatal_warnings)
    err =3D 0;

?

>  out:
>         if (obj.efile.elf) {
>                 elf_end(obj.efile.elf);
>
> --
> 2.47.1
>

