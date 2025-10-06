Return-Path: <bpf+bounces-70453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C937DBBFBF2
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 01:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1342C4EA540
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 23:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBBC1E501C;
	Mon,  6 Oct 2025 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4zcnNf9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1EA1E47C5
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759792133; cv=none; b=WgzhmM4kQBYULsT6ByOrrqPiv57gIXtjBl/VB9xuPS3hwFX2JW2ExrxFeuDhr1RAHzEbFK7Es+3/Xqk00V8TN21C7ZT52SccOdBpMM8Ldn+lxm0eeXfqHB2cJ97O4eSwZOHY1jdUsMn8AEL0MCzD5umhtQgWWoeSN8RhMrR+fTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759792133; c=relaxed/simple;
	bh=qup/aG0kBpnmCM7191Fmapt0FxVzkpG/x0GMHw1MjzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qktyCC72JvuQctVTRNGDPN6vi4zmwk2WJhvEvBmHYr29ABZ2H8pkWZ9EWNugk6+R0vCqYKpF+5GlOoxpTL5AMc2QmTloawrjxY5tZpy9D4XaknCAgO9URDnGmNi2tmJugTZS8POfBSA2xoIZ1Uot2s4oE7NDaDr3pl6HKhs0mVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4zcnNf9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27eceb38eb1so57144755ad.3
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 16:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759792131; x=1760396931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1/ZwQdsS/4N3ZSDI/T4rJ3oMrRgkJEBUSrtnmJNjo4=;
        b=f4zcnNf9+ZW88aYv8O1ddILBGXT/al+/ibwS3oM8/Elbx9qJuxUSL+TXrtSoUIQD9C
         FVvdPLZv0ctdofnkgWJ8u6FhX3MOaiFCn7U/nx4bF8wp6FVbyg72oQeky+hc9ykGYego
         1CuxKa6cYwKDGv5cR0eikXnoa26jdKYt5ZBR3vEBj9m+iQeTWERoZx3YFr0cj7QmDkAB
         NKux0E34EzKItqesI5Hp/M5DaTkb8cqioIiVZ8QQ3h1jkCUJRtX/QoxP7+waobUnbMTN
         riitXIUPdYsdQFPzW3go/quEL6fGCH4ANjrlnAOe+LKcgoKo8ohoig8Pz0YePuRp7cqt
         QMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759792131; x=1760396931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1/ZwQdsS/4N3ZSDI/T4rJ3oMrRgkJEBUSrtnmJNjo4=;
        b=ey5vVzrnvmtzSJYEvCEwvCTM1cW2PEkjxGvzAtxkpkaFYca6idDPXv5AEP1NSTS1LD
         CJXqPULVBZAf1SIAKlvjun/ODrSVDUUexoLgq2K5NEJh/G2HeGAnvfOKkp47uYNGyF4c
         zTOwH9CY2v0qEBtTXPPrpZxeYKjHebAulANFoUUg8iOSGnLcv4kC7JsetW227wGFN377
         an+WO+/hiFOJ7vP0TKV0Z/ktJQnZ0BHGVpmnvzXVgjQD5g5zgKH/TgxhSN0c4Juyo6WN
         v/mdMBcH2/q3Kkxtfjm/p4gA8viINjRlg9A5H5zOBwb/1nq2aUd/WFmC08oRJH7AvSYQ
         LMmw==
X-Gm-Message-State: AOJu0YwLxP3mzgvzfAHhkgbHAZc18bXTj2gMm/UFromlLm5DKotxCAyv
	XOannLfFbNBfMwc5DfilXwESfD31UFNdKRoqcdt8/GnlShraCxq0eUzyd3+INQO9ql2hSXmKVZ9
	Ru4WteruQlnYs+Nt5sEXRzU66rgku5KE=
X-Gm-Gg: ASbGncs+ZdYMl74mjARmoRL8shhrsiMHA55gH6DJKhEEpcc6fNOzhH9J0Tlzx03bab6
	NBOLxaEjoADEbJZQ85aodfdDGB0HhcpOlyJ1WUqVjgEYALbx9WHode3pcRubo9P7ta/0dGWUPJL
	gKGM6ZrALz3ihA9oGKxvM8cnHLgzzbYt51lqmaamGHPZmYHHNmHzIMPxLJDxYu3GkMh2t8aEqzL
	vieKBQkkLHE8mfwBCj7l3hByb/cJIlBUOIhvVA9wRruQ94=
X-Google-Smtp-Source: AGHT+IHsvarTfBGFGRcfwRM8UgX7mlcqahmDBStsDOQXagOnXLMwQ58ZkuOS2yJmhOXeyfbjyGOvhkJ/LIPUUOSy5Vo=
X-Received: by 2002:a17:903:38cf:b0:277:71e6:b04d with SMTP id
 d9443c01a7336-28e9a5135efmr170188405ad.3.1759792131423; Mon, 06 Oct 2025
 16:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002154841.99348-1-leon.hwang@linux.dev> <20251002154841.99348-10-leon.hwang@linux.dev>
In-Reply-To: <20251002154841.99348-10-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 16:08:37 -0700
X-Gm-Features: AS18NWDKhB8t0qD6DhvftpC3xAJARkrTHwpuC9eo4fLtInjkXq5jY27hzbY6vgo
Message-ID: <CAEf4Bzaw9cboFSf1OXmD84S7pKaeyj=bcQg_diUzGwAkFsjUgg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 09/10] libbpf: Add common attr support for map_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 8:49=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> With the previous commit adding common attribute support for
> BPF_MAP_CREATE, it is now possible to retrieve detailed error messages
> when map creation fails by using the 'log_buf' field from the common
> attributes.
>
> Extend 'bpf_map_create_opts' with these new fields, 'log_buf', 'log_size'
> , 'log_level' and 'log_true_size', allowing users to capture and inspect

comma

> those log messages.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c | 17 +++++++++++++++--
>  tools/lib/bpf/bpf.h |  9 +++++++--
>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9cd79beb13a2d..ca66fcdb3f49f 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -203,10 +203,13 @@ int bpf_map_create(enum bpf_map_type map_type,
>                    __u32 key_size,
>                    __u32 value_size,
>                    __u32 max_entries,
> -                  const struct bpf_map_create_opts *opts)
> +                  struct bpf_map_create_opts *opts)

this is a breaking change, see below

>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, excl_prog_ha=
sh_size);
> +       const size_t common_attrs_sz =3D sizeof(struct bpf_common_attr);
> +       struct bpf_common_attr common_attrs;
>         union bpf_attr attr;
> +       const char *log_buf;
>         int fd;
>
>         bump_rlimit_memlock();
> @@ -239,7 +242,17 @@ int bpf_map_create(enum bpf_map_type map_type,
>         attr.excl_prog_hash =3D ptr_to_u64(OPTS_GET(opts, excl_prog_hash,=
 NULL));
>         attr.excl_prog_hash_size =3D OPTS_GET(opts, excl_prog_hash_size, =
0);
>
> -       fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> +       log_buf =3D OPTS_GET(opts, log_buf, NULL);
> +       if (log_buf && feat_supported(NULL, FEAT_EXTENDED_SYSCALL)) {
> +               memset(&common_attrs, 0, common_attrs_sz);
> +               common_attrs.log_buf =3D ptr_to_u64(log_buf);
> +               common_attrs.log_size =3D OPTS_GET(opts, log_size, 0);
> +               common_attrs.log_level =3D OPTS_GET(opts, log_level, 0);
> +               fd =3D sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &co=
mmon_attrs, common_attrs_sz);
> +               OPTS_SET(opts, log_true_size, common_attrs.log_true_size)=
;
> +       } else {
> +               fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> +       }
>         return libbpf_err_errno(fd);
>  }
>
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index e983a3e40d612..77d475e7274a0 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -57,16 +57,21 @@ struct bpf_map_create_opts {
>
>         const void *excl_prog_hash;
>         __u32 excl_prog_hash_size;
> +
> +       const char *log_buf;
> +       __u32 log_size;
> +       __u32 log_level;
> +       __u32 log_true_size;

I'm thinking that maybe we should have a separate struct that will
have these 4 fields, and pass a pointer to it. That way
bpf_map_create_opts can still be passed as const pointer, but libbpf
will still be able to write out log_true_size without violating
constness

and then we can reuse the same type (struct bpf_log? struct
bpf_log_buf? struct bpf_log_info? not sure, let's bikeshed) across
different commands that support passing log info through
bpf_common_attrs

>         size_t :0;
>  };
> -#define bpf_map_create_opts__last_field excl_prog_hash_size
> +#define bpf_map_create_opts__last_field log_true_size
>
>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>                               const char *map_name,
>                               __u32 key_size,
>                               __u32 value_size,
>                               __u32 max_entries,
> -                             const struct bpf_map_create_opts *opts);
> +                             struct bpf_map_create_opts *opts);
>
>  struct bpf_prog_load_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
> --
> 2.51.0
>

