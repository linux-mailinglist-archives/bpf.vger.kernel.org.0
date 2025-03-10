Return-Path: <bpf+bounces-53743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6FBA59A8F
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 17:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6BF3A5327
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47378229B1D;
	Mon, 10 Mar 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuGJmbyw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8BE1B0F19
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622438; cv=none; b=kJ1zBhUzhdKKAwKoVCnBCw1Zi9WKTCLRDrQPSjkbvmbDpj5OsLF/aCdKZdU+QpMuSDAKJucVkD/tjJXA/xW3j+CHuyeiQLf4Mi9HReLz2JU/K4C5DZ8OyZ2oZMBSybuTP5aLOWzt+xQ19l8MveW9sDjphwHj0F+U4SDtZYc/voA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622438; c=relaxed/simple;
	bh=vAK8d9CENBBI8eQB5LZr1yYSx2c3/bNccDkLak5GCjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBHmXMOU51IM27EsJzoH+cvDmytcquRByW5ylOTTFPD8mzzWZ03WNVZ+xU3gHCt5doDLhkfbEfUu2CC+j3DFg8kzTmxiRUq75GzKcJYPD629/f3r5OCu5lNsvKiaPcARa43njFTSoNvSb7kxFSMrPp98J5Toa9zMy/8dzNz3J1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuGJmbyw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22337bc9ac3so85022395ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741622436; x=1742227236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IUMWWEZ0ju74OKJLguTW5HZ7rJPRhF8rAjRr1nIBiA=;
        b=KuGJmbywiSLv/2jfgtakwZlH3J67nuWm+vCXgGwP+oWooGVNBtRIlX61j3ugbRqp0g
         fw5vA/3iiS11eLmMDqlPxity3eq6u/66BNrzYGgfFVWUoO5WRkMT99BVyU3Qqmdn3USE
         1Yz0SMScXYcFa3CUib/beMHuQGZIXnnhaM7ohvMzqUdqMlUjDVSXgTusYZGcIFDTQCjg
         ecdem1jeZiQlPEFcpqAUddviSmCp4lLxJ1UWlHpHBqgQHknEt64HSE5WZDSnA/Uduhyg
         IstPoUQIzjmpY6R/oiryLouBV7oDK3cPEh+4BEXB6R3FjAd32Yu2l1WKUT+8+DHkNSBX
         XAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741622436; x=1742227236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IUMWWEZ0ju74OKJLguTW5HZ7rJPRhF8rAjRr1nIBiA=;
        b=m1iRa2NkCT/25bSSJAXUVy2Sh9e6CsNsDUTsSB3oyMWDLh+mxaywDna2qJa9GsQN5p
         4gDp7GFedhmqRnDru2JtyihFJK7mDjRcn1/dG+9vjUvhhzctTbsNRRe26Qd21O7bpYGK
         GZAPE8Mm22VHbNPJGF04bp8ghixlVq8KUkCXoLDXbVrE2AdhTxhZyTcR+sfCs84OUva9
         dPxng0zVKSFJhONgkfAnTvJ1prme/dBX+464+Ev2o6w3xTw5dm5pnP+o0bBb906FXFGr
         3VNSLioZSGxLvtCjEPYywOBR1hTwN8gy6tl7E/MN/7w/WIeDFqoNs9yGQUJd1Wn8FC7a
         DOgw==
X-Gm-Message-State: AOJu0Yxpyey5ItbWIIDOEhMsy9/5UhC7njWhXS4b2eExfzO7JsLB3c3o
	hqJHawFEBf4sTJOc6a3hQO1cSL8DMeAulBoYNRVmcr0IVgq6VHcx8B5OE1QGUfm58Q0ZcXhBsE7
	K1FtMdApjz75qIYYgXl/fxGgDopc=
X-Gm-Gg: ASbGnctJdqfOlNpVjcnixdaeqMAkcXXAz2seABrY7MBEeFATNkIzf1sStY/FmDRprUy
	T6qL2svO+vkRpLEsOOUHYw6bMidD6vRraVDTCRZ9stgU99vZNnZ40Fn+IrM3b9GYgt0ePo5d+Cc
	BAlks0pPemFeAUdBYLLvOMt/VOEZHIntMMxCPnwpTQlA==
X-Google-Smtp-Source: AGHT+IEqX2ufcq/hbQibFcrPzOVTJlA5dpM0eYZ5jgCTNH8QJ3KgkbToLtA7YiY04yo1G+AmNfWY611o+hmzy01C/uo=
X-Received: by 2002:a05:6a00:178d:b0:732:535d:bb55 with SMTP id
 d2e1a72fcca58-736eb7b565emr452857b3a.4.1741622436631; Mon, 10 Mar 2025
 09:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com> <20250310001319.41393-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250310001319.41393-4-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Mar 2025 09:00:24 -0700
X-Gm-Features: AQ5f1JoMxDeZ1sI5KGbdiy8rJ9Z9jbZep7CXxxVrhO2UU0eYxhdedPbvMdLwGCM
Message-ID: <CAEf4BzZsFEVTff5udLZd4gg0h5R3ZOjgaxhNJ_bPNv5No6Sz2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] libbpf: pass BPF token from
 find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	olsajiri@gmail.com, yonghong.song@linux.dev, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 5:13=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Pass BPF token from bpf_program__set_attach_target to
> BPF_BTF_GET_FD_BY_ID bpf command.
> When freplace program attaches to target program, it needs to look up
> for BTF of the target, this may require BPF token, if, for example,
> running from user namespace.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/bpf.c             |  3 ++-
>  tools/lib/bpf/bpf.h             |  4 +++-
>  tools/lib/bpf/btf.c             | 15 +++++++++++++--
>  tools/lib/bpf/libbpf.c          | 10 +++++-----
>  tools/lib/bpf/libbpf_internal.h |  1 +
>  5 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 359f73ead613..783274172e56 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1097,7 +1097,7 @@ int bpf_map_get_fd_by_id(__u32 id)
>  int bpf_btf_get_fd_by_id_opts(__u32 id,
>                               const struct bpf_get_fd_by_id_opts *opts)
>  {
> -       const size_t attr_sz =3D offsetofend(union bpf_attr, open_flags);
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, token_fd);
>         union bpf_attr attr;
>         int fd;
>
> @@ -1107,6 +1107,7 @@ int bpf_btf_get_fd_by_id_opts(__u32 id,
>         memset(&attr, 0, attr_sz);
>         attr.btf_id =3D id;
>         attr.open_flags =3D OPTS_GET(opts, open_flags, 0);
> +       attr.token_fd =3D OPTS_GET(opts, token_fd, 0);
>
>         fd =3D sys_bpf_fd(BPF_BTF_GET_FD_BY_ID, &attr, attr_sz);
>         return libbpf_err_errno(fd);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 435da95d2058..544215d7137c 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -487,9 +487,11 @@ LIBBPF_API int bpf_link_get_next_id(__u32 start_id, =
__u32 *next_id);
>  struct bpf_get_fd_by_id_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>         __u32 open_flags; /* permissions requested for the operation on f=
d */
> +       __u32 token_fd;
>         size_t :0;
>  };
> -#define bpf_get_fd_by_id_opts__last_field open_flags
> +

why new empty line? please keep the style consistent

> +#define bpf_get_fd_by_id_opts__last_field token_fd
>
>  LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
>  LIBBPF_API int bpf_prog_get_fd_by_id_opts(__u32 id,

[...]

