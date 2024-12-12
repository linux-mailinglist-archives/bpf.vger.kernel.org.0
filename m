Return-Path: <bpf+bounces-46728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 451209EFC12
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 20:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C541884AC9
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BAD18FDAB;
	Thu, 12 Dec 2024 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzNJWmcv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AE8168497;
	Thu, 12 Dec 2024 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030589; cv=none; b=S46svGTqWunA/38DP6r649xrW9LurrhNcsVd4iq72Lt07bt/9hsuS6+HgFgkIWCuKr8wOjQ4khbSHVrC5R5uJdeh1kT/b5d9vCeCkXWnzyMYLYOsV9T+XzWxkTRjFTFgGG2s2MpaPQ/cMCsHESW3GEVO1zdEAolt2pxRsbs2rvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030589; c=relaxed/simple;
	bh=DNKPYA2WFPgRNNOUeAlWNV/mRLGE9d7lM0rvKrJvcqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjBLyDdtseEWUSxO7ka0Gjl6HXDXt2+abo26IHWa3DNMJufdted7lONeo4UgfruAqFNdnvRlEo/eXkLQim6EWwjM75IdmHYsatmKGsdC7uVwnUNyLkeYpsXDKzxWT1FVSyj4X3KTtAGaPVUiVmtgbriGa/zru1eyzf/zAVVJvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzNJWmcv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2efa856e4a4so695846a91.0;
        Thu, 12 Dec 2024 11:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734030587; x=1734635387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Y1JSw3DoTxWn8SM/qbfxjcr4SEeq3BxYATnSrJCP3c=;
        b=TzNJWmcvF4Gdt9U3W62IDJsouNoG44+v0HlRSCGCnJUIQtR3N3h1LkIoQ01vM7XmJS
         d1IkYO7s6/3ATDRQIjyZY+XT9/7i1nM6pDxS0yoejYMfSAwPCE01GW92HQ0GDXl+xnf1
         1iSbmqR+vmoWaOMe4x7qSt1lJmPbGC0/3GMdotuXySNmPTb9O/GClLYSb0rCFHbRP9O2
         NX9C1BPkhPczoNT6wASqbw6bs5LQSj95tW9KEazWL0b2izfJtrW4LHQOu0H+EEPNacwS
         p+sml5Cp+sbhzFvUgYkXHifG+i2i6tMwa8Q83ZE/8k0cExa5nMNUE7mQmD8qvcMdiD8N
         +UUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734030587; x=1734635387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Y1JSw3DoTxWn8SM/qbfxjcr4SEeq3BxYATnSrJCP3c=;
        b=JD1FJx+eqLaxf8azsM0fpe5jMmwSovwslMm8hJmQIt9Hh6bVwmt+1Ijtc7H8DEtsGA
         Ct2GHQWLaGeu+QlUz1Yhin1EerPL1aX1KDHCNsN45Fox7Hp3isRVuXu9getQkh11VKJ9
         6XVWb0pQD2aM4kUQ7B06JETw5ytO/fqIGHy+OPekzOg1/vrVwuwDLb6gYHtUdLoNEFU5
         xKxZrfSlr9QGRI4XXhDVjrDv7yXBQe4QaIyT4yEAZS5QhsiNE0ni8tb9eQGPslOE3yDk
         dORbREVy2YTBXBQkw93bK7UR0YwoUIheF20LVhIhq9ecZOWTJPDnjHa1opTuMoo+4iEn
         csaA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Jp8zIoyXvSOAHkGe2sVxtcT5I1Y8o1QLt5t6dmQ1/lf0HNn8fi+gc+FEKxamsYMnn4DjuCwW@vger.kernel.org, AJvYcCVfTmq91XSk/CtdOXLQy1hMQ4AvrUf5cioy8+mZd738U3Y4F7/9lEaTCvUpmxP6PK0GsL17Smght7go3cr+@vger.kernel.org, AJvYcCWaw6gCYteYIgi+rGUG9F3ip/dK+yYq5f8n3g4fDlgoNRsdzrz0XSrpCRiIU6BJJx+i+LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydtvjoprtkuMZ0TdQ720jWvwxRxUJxo/wDVUwKnAby2hp1OZ88
	Xkr78hnj33KZNS9IholwQXzqOT03M2tP2UDvtpdCuxWLkRDu/JnTre9xwxpUURayvwKH5UeguyJ
	QYU/AIayrqDGICtY6vZRJ9dT38bw=
X-Gm-Gg: ASbGncvzDua8Q3hwxQC/+6h5hNrZsquxsDKv7qJQgz/hKuvViRfZMBWOYk5eiZaMqKI
	J06TyvQbAUIdxzGP1u/p0WQgFSRWRg91EhUmBAHOK3Fcn9l6jzXpbqw==
X-Google-Smtp-Source: AGHT+IHaSbU2ygxG/L0zwcsASR2dK+gNnVPGMfE+RuiROXU9+RWhe0nrQc6XD6psPXHVJoeFBze84xZMP1k7ilvzJGY=
X-Received: by 2002:a17:90b:5110:b0:2ee:bc1d:f98b with SMTP id
 98e67ed59e1d1-2f139325d67mr6667254a91.31.1734030585888; Thu, 12 Dec 2024
 11:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733787798.git.dxu@dxuuu.xyz> <3bc17d33161961409dc77a5de29761bf2bed4980.1733787798.git.dxu@dxuuu.xyz>
In-Reply-To: <3bc17d33161961409dc77a5de29761bf2bed4980.1733787798.git.dxu@dxuuu.xyz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 11:09:34 -0800
Message-ID: <CAEf4BzaA9_up=3npADgJv8pCVg4eVzsWevef69c3PkdyuWNXDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpftool: btf: Support dumping a single
 type from file
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: hawk@kernel.org, john.fastabend@gmail.com, ast@kernel.org, qmo@kernel.org, 
	davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org, kuba@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, antony@phenome.org, 
	toke@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 3:45=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Some projects, for example xdp-tools [0], prefer to check in a minimized
> vmlinux.h rather than the complete file which can get rather large.
>
> However, when you try to add a minimized version of a complex struct (eg
> struct xfrm_state), things can get quite complex if you're trying to
> manually untangle and deduplicate the dependencies.
>
> This commit teaches bpftool to do a minimized dump of a single type by
> providing an optional root_id argument.
>
> Example usage:
>
>     $ ./bpftool btf dump file ~/dev/linux/vmlinux | rg "STRUCT 'xfrm_stat=
e'"
>     [12643] STRUCT 'xfrm_state' size=3D912 vlen=3D58
>
>     $ ./bpftool btf dump file ~/dev/linux/vmlinux root_id 12643 format c
>     #ifndef __VMLINUX_H__
>     #define __VMLINUX_H__
>
>     [..]
>
>     struct xfrm_type_offload;
>
>     struct xfrm_sec_ctx;
>
>     struct xfrm_state {
>             possible_net_t xs_net;
>             union {
>                     struct hlist_node gclist;
>                     struct hlist_node bydst;
>             };
>             union {
>                     struct hlist_node dev_gclist;
>                     struct hlist_node bysrc;
>             };
>             struct hlist_node byspi;
>     [..]
>
> [0]: https://github.com/xdp-project/xdp-tools/blob/master/headers/bpf/vml=
inux.h
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  .../bpf/bpftool/Documentation/bpftool-btf.rst |  7 +++++--
>  tools/bpf/bpftool/btf.c                       | 21 ++++++++++++++++++-
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/=
bpftool/Documentation/bpftool-btf.rst
> index 245569f43035..4899b2c10777 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -24,7 +24,7 @@ BTF COMMANDS
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  | **bpftool** **btf** { **show** | **list** } [**id** *BTF_ID*]
> -| **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*]
> +| **bpftool** **btf dump** *BTF_SRC* [**format** *FORMAT*] [**root_id** =
*ROOT_ID*]
>  | **bpftool** **btf help**
>  |
>  | *BTF_SRC* :=3D { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{*=
*key** | **value** | **kv** | **all**}] | **file** *FILE* }
> @@ -43,7 +43,7 @@ bpftool btf { show | list } [id *BTF_ID*]
>      that hold open file descriptors (FDs) against BTF objects. On such k=
ernels
>      bpftool will automatically emit this information as well.
>
> -bpftool btf dump *BTF_SRC* [format *FORMAT*]
> +bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
>      Dump BTF entries from a given *BTF_SRC*.
>
>      When **id** is specified, BTF object with that ID will be loaded and=
 all
> @@ -67,6 +67,9 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*]
>      formatting, the output is sorted by default. Use the **unsorted** op=
tion
>      to avoid sorting the output.
>
> +    **root_id** option can be used to filter a dump to a single type and=
 all
> +    its dependent types. It cannot be used with any other types of filte=
ring.
> +
>  bpftool btf help
>      Print short help message.
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 3e995faf9efa..18b037a1414b 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -993,6 +993,25 @@ static int do_dump(int argc, char **argv)
>                                 goto done;
>                         }
>                         NEXT_ARG();
> +               } else if (is_prefix(*argv, "root_id")) {
> +                       __u32 root_id;
> +                       char *end;
> +
> +                       if (root_type_cnt) {
> +                               p_err("cannot use root_id with other type=
 filtering");

this is a confusing error if the user just wanted to provide two
root_id arguments... Also, why don't we allow multiple root_ids?

I'd bump root_type_ids[] to have something like 16 elements or
something (though we can always do dynamic realloc as well, probably),
and allow multiple types to be specified.

Thoughts?


> +                               err =3D -EINVAL;
> +                               goto done;
> +                       }
> +
> +                       NEXT_ARG();
> +                       root_id =3D strtoul(*argv, &end, 0);
> +                       if (*end) {
> +                               err =3D -1;
> +                               p_err("can't parse %s as root ID", *argv)=
;
> +                               goto done;
> +                       }
> +                       root_type_ids[root_type_cnt++] =3D root_id;
> +                       NEXT_ARG();
>                 } else if (is_prefix(*argv, "unsorted")) {
>                         sort_dump_c =3D false;
>                         NEXT_ARG();
> @@ -1403,7 +1422,7 @@ static int do_help(int argc, char **argv)
>
>         fprintf(stderr,
>                 "Usage: %1$s %2$s { show | list } [id BTF_ID]\n"
> -               "       %1$s %2$s dump BTF_SRC [format FORMAT]\n"
> +               "       %1$s %2$s dump BTF_SRC [format FORMAT] [root_id R=
OOT_ID]\n"
>                 "       %1$s %2$s help\n"
>                 "\n"
>                 "       BTF_SRC :=3D { id BTF_ID | prog PROG | map MAP [{=
key | value | kv | all}] | file FILE }\n"
> --
> 2.46.0
>

