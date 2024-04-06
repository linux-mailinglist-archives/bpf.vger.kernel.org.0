Return-Path: <bpf+bounces-26104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E31BA89ACAF
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 20:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49602B21951
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 18:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B9347F50;
	Sat,  6 Apr 2024 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMfjXadp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1AB4D9E5
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712429364; cv=none; b=WkHlxH9VvbIE7LVYWTmvypJRNxbmSInlH6d3mAMv6X66pjiIhC4LdZBNJVlD7cT+OjyTava/MyvqppK1E2ft4jwZ+0JrG04NCwk+1pe8nAiQerl1v5vl5ryXREM2DMCRV2mt6HxU7TdwfkYvqMB5RL7qvaDFElNJ/yAJ9Z4kt5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712429364; c=relaxed/simple;
	bh=t43CWXr1AvahMUiOitpxFJEZO/IZFQVwkKpyajmnW/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udArrtX4vexJ2NKKqsfOfiQQgJYOXfSkAmn0xykTYwrwCYexvX/d0fRe4cokHibKxqzuABLz6dICQdYlF1CmtPAF0Lasrm7fq/xAJjyXxZ8efAZPJJPCp3NeZ1Kt/CUf6p/iiBhynjzmIXOI/3vQ+3RRQ/ZrrMHYQjI667xs64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMfjXadp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so635087b3a.0
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712429362; x=1713034162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCYODf1ZHtJVtBJfoxRO1z6V3mc/7NFaWgOJZp9PFJw=;
        b=SMfjXadpwjBrvr+ba04y8Bryb6WBC9/z991i0T313GTQ5mJw58IzyrjIUUFAthuHYb
         +ECJWsAP0N9Z2wb8LamaW3kN+pB9HBOFi4ksKGXAFXfIT5EBzqnc9JjAL5ZyfNrJ2guU
         r5mSJiPM6WqattjQkjkpTLx4SJhq4k7PGb5kJF0p0EgtKyVPwEmrTaXMiSMynHDI/lFR
         cr7NgXenL9Ozty/VAqnUqgbp0gXh6DWTwAVW63nQOcyXVOsVOsGKACRngi4VbhJUm/KB
         QLqnfcPJF6LQQ1Yo89sGNfXnV5A+/52iv+9NssRoSX4zQVWkkTeUoAhfWY/Zjg4TBULl
         Ma4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712429362; x=1713034162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCYODf1ZHtJVtBJfoxRO1z6V3mc/7NFaWgOJZp9PFJw=;
        b=CiwzuB/Ox6g+MysGbaCtp8/4Yw8qRTF7Fa0YvWCoVk4V0n0yu4nkcncI1qL0GSnceo
         FJxEfPj2F90USDVPzkNyZvgyjiE+sFNqTwugpscpqQAjkdCJ64wWBztu4gv/ELHox8Oz
         JZUB5FSgbnILUbvUNnudjOHMEHlnCmccbCIjNl/D0k1MflNVxEcJDib7lBbuYt/b78Pd
         9ThCyAVtbGFY07kL1k1FJv7ubV+oK918y+1sjE8aM1kpdCQp1QJV2vH4pCLQqgLeUL8k
         B4rn93cFk85lFQPIR2L8298dAIA4FC+ASbCqtNdEruLMVNN8sL/LGfMeYsKVij9oUcr6
         l6tw==
X-Gm-Message-State: AOJu0YzbO7W0NwALHjADxgOTo9kkPkGRp/mR9Z1PnG8V/Zyamtzqx4Zb
	f1tdn6KKJvgLL9+Zkq2UgZy3roN4CmQw8MJyF9Kc2rdsLp5aga+F9+SMR2c5GI/TZlNX9EVgPHu
	hIy2FmNjZ7c9ULB4Xam4p1cQuPhc=
X-Google-Smtp-Source: AGHT+IGxnxytLYwws9H6HNfX+zGF/BZOKw4A0736856xfpN8f5NBGwm94qArMwlYvvjPSrb2UjGdYtS2EwPpU1dBbik=
X-Received: by 2002:a05:6a21:150d:b0:1a7:5972:f04 with SMTP id
 nq13-20020a056a21150d00b001a759720f04mr149056pzb.16.1712429362206; Sat, 06
 Apr 2024 11:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406160359.176498-1-yonghong.song@linux.dev> <20240406160409.178297-1-yonghong.song@linux.dev>
In-Reply-To: <20240406160409.178297-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 6 Apr 2024 11:49:09 -0700
Message-ID: <CAEf4BzYpoANeuoWX4EHktf3hffDejLYmvL89sjy3NZv35aC+3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/5] libbpf: Add bpf_link support for BPF_PROG_TYPE_SOCKMAP
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 9:04=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Introduce a libbpf API function bpf_program__attach_sockmap()
> which allow user to get a bpf_link for their corresponding programs.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c         | 7 +++++++
>  tools/lib/bpf/libbpf.h         | 2 ++
>  tools/lib/bpf/libbpf.map       | 5 +++++
>  tools/lib/bpf/libbpf_version.h | 2 +-
>  4 files changed, 15 insertions(+), 1 deletion(-)
>

I feel like I mentioned this before, but maybe not. Besides there
high-level attach APIs, please also add bpf_link_create() support, it
should be very straightforward, just follow the pattern for other link
types.

You'll also get a conflict in libbpf.map given I just applied another
libbpf patches (ring_buffer__consume_n). So please rebase.

pw-bot: cr

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b091154bc5b5..97eb6e5dd7c8 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -149,6 +149,7 @@ static const char * const link_type_name[] =3D {
>         [BPF_LINK_TYPE_TCX]                     =3D "tcx",
>         [BPF_LINK_TYPE_UPROBE_MULTI]            =3D "uprobe_multi",
>         [BPF_LINK_TYPE_NETKIT]                  =3D "netkit",
> +       [BPF_LINK_TYPE_SOCKMAP]                 =3D "sockmap",
>  };
>
>  static const char * const map_type_name[] =3D {
> @@ -12533,6 +12534,12 @@ bpf_program__attach_netns(const struct bpf_progr=
am *prog, int netns_fd)
>         return bpf_program_attach_fd(prog, netns_fd, "netns", NULL);
>  }
>
> +struct bpf_link *
> +bpf_program__attach_sockmap(const struct bpf_program *prog, int map_fd)
> +{
> +       return bpf_program_attach_fd(prog, map_fd, "sockmap", NULL);
> +}
> +
>  struct bpf_link *bpf_program__attach_xdp(const struct bpf_program *prog,=
 int ifindex)
>  {
>         /* target_fd/target_ifindex use the same field in LINK_CREATE */
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index f88ab50c0229..4c7ada03bf4f 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -795,6 +795,8 @@ bpf_program__attach_cgroup(const struct bpf_program *=
prog, int cgroup_fd);
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd);
>  LIBBPF_API struct bpf_link *
> +bpf_program__attach_sockmap(const struct bpf_program *prog, int map_fd);
> +LIBBPF_API struct bpf_link *
>  bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_freplace(const struct bpf_program *prog,
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 51732ecb1385..2d0ca3e8ec18 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -416,3 +416,8 @@ LIBBPF_1.4.0 {
>                 btf__new_split;
>                 btf_ext__raw_data;
>  } LIBBPF_1.3.0;
> +
> +LIBBPF_1.5.0 {
> +       global:
> +               bpf_program__attach_sockmap;
> +} LIBBPF_1.4.0;
> diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_versio=
n.h
> index e783a47da815..d6e5eff967cb 100644
> --- a/tools/lib/bpf/libbpf_version.h
> +++ b/tools/lib/bpf/libbpf_version.h
> @@ -4,6 +4,6 @@
>  #define __LIBBPF_VERSION_H
>
>  #define LIBBPF_MAJOR_VERSION 1
> -#define LIBBPF_MINOR_VERSION 4
> +#define LIBBPF_MINOR_VERSION 5
>
>  #endif /* __LIBBPF_VERSION_H */
> --
> 2.43.0
>

