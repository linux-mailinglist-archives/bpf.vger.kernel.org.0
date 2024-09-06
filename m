Return-Path: <bpf+bounces-39166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C371E96FCFF
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21441C22564
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9A71CE717;
	Fri,  6 Sep 2024 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TL/AIq0v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06106481DD
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725656625; cv=none; b=O7IqxuVOzvoCExWhil63tdyBglSyAJdkg0KODPsO0K4IbRrH7UPW9cFU7kGxhPOmT2ETZxcLkvcThGn1aEHEo+cfJzKksbuftJgfPN0J35SWrMgF1LAEG0J/MlSTrBXcZfMiWiX8f9VbK3QZsOUlXkRB3ycGJpXWwjxCnfGDDeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725656625; c=relaxed/simple;
	bh=yUW6H+jm3G6JFi4lkFBPSKHJ7M8cnkftBNvK5ILHj0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3eJldPIrpVlchMeBX1OxS7xC/SRGMTDkuzHqv/mREM4fyUwn9M6XZomxK+LsXaETvZl54hanYZrxjnWSzxXXA4J6kXQ0gnVu+QKO89ZsHIhhHA1uYKeCyDzeDLoeXRbCv3LkQu0deeupUMg5Wg66jPnF1lkSSV7fXG2aB0Z8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TL/AIq0v; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso2109574a91.0
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725656623; x=1726261423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8EsUMQ18WZ7zEZTc6rY3xDyNJGP2Dw6qpPGZThe+n8=;
        b=TL/AIq0v+Hqmuzjm79Vc7681rv3VqQGT5DObH/aXe6J0ZSdk226J3DWFhae30T7kOo
         FLt9Gi4ArpTnTW9wbg5MKsEQ0FYimD2cJUCwc8CeA/wl+sae3mh9ve3fPaz47DCI/Cf8
         SoG+Lv2+v6fy6/nvm00Co1Iby/8axrn3gn1ZJbg2lGGyGrF2tdYgeYGiKYUjxnBMi58h
         fw9vHMoOlL17ZPxLatM0LzTAtaXiTD28KjZgu414UaZQzgJgx5un/Z2O9H0XZ0wIjNec
         GGFUVuvZKubzGtdZbFKbeWK/XshbWi8n3CICf/0reQLjFADC8w9S8IfJ5qYeoSvWa4Y/
         TL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725656623; x=1726261423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8EsUMQ18WZ7zEZTc6rY3xDyNJGP2Dw6qpPGZThe+n8=;
        b=Re+33AONa2NW1SKA+PIFGAUO3+KI+DAULsT+YQNpuSHddFHkkWZOiQ7Csht177FP1c
         lEwSCn3wZUqGg8/Tc4J0KeGlticGkdSmibB7DX6ALffGjaiyEDa0PliCRvSHaVazeWLj
         sFxftALusn6e6OalIR394Lz365V9vCezQ1Gi8L002PyRHBBmRZg+Mn3bOAv114+du70k
         QP8c4fa1jwt+j7PswcY1ivJDtSzpk707GdaMaoXLzGAEQnSfN3V66cIDQy621YkzEmaZ
         eSQLw1LzV2QSZNimAwW8xiki2Io8qUJlbAcOC3n4F9qgYk5uK/sqn+mVrXA9WgTL7h9m
         LWWw==
X-Gm-Message-State: AOJu0Yz06NhTFWadJ6xThpUicFTcqEHQRZran3b8nMZsVutJ18rqCT8f
	FuqgtKYuR+cKI4lf9fLaaj4Ec95AO9rqzleDOe8gNrLLyyBHa/cNssUBdipwGCq4AQoouKxHTab
	jvYjIJhMlMN3BN6ALSUkeD4Dh05w=
X-Google-Smtp-Source: AGHT+IEOffX6ZGGzqYTY3yl3AA/YN+DaIyAMRN22ab3jc1bfaPIA21u7sdLTdaSkl04jRapX4/wqVi1dGqU29I2MGiQ=
X-Received: by 2002:a17:90b:4b10:b0:2d8:abdf:2ca9 with SMTP id
 98e67ed59e1d1-2dad4deda66mr4122544a91.3.1725656623260; Fri, 06 Sep 2024
 14:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906135608.26477-1-daniel@iogearbox.net> <20240906135608.26477-5-daniel@iogearbox.net>
In-Reply-To: <20240906135608.26477-5-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 14:03:26 -0700
Message-ID: <CAEf4Bzaf4Jsy+kibXB7UsjVrz+TmcT9SyiQ51EdVpqEhKifWEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] bpf: Zero former ARG_PTR_TO_{LONG,INT}
 args in case of error
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, shung-hsi.yu@suse.com, andrii@kernel.org, 
	ast@kernel.org, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> For all non-tracing helpers which formerly had ARG_PTR_TO_{LONG,INT} as i=
nput
> arguments, zero the value for the case of an error as otherwise it could =
leak
> memory. For tracing, it is not needed given CAP_PERFMON can already read =
all
> kernel memory anyway hence bpf_get_func_arg() and bpf_get_func_ret() is s=
kipped
> in here.
>
> Also, rearrange the MTU checker helpers a bit to among other nit fixes
> consolidate flag checks such that we only need to zero in one location wi=
th
> regards to malformed flag inputs.
>
> Fixes: 8a67f2de9b1d ("bpf: expose bpf_strtol and bpf_strtoul to all progr=
am types")
> Fixes: d7a4cb9b6705 ("bpf: Introduce bpf_strtol and bpf_strtoul helpers")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  v1 -> v2:
>  - only set *mtu_len in error path (Alexei)
>
>  kernel/bpf/helpers.c |  2 ++
>  kernel/bpf/syscall.c |  1 +
>  net/core/filter.c    | 35 +++++++++++++++++------------------
>  3 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 0587d0c2375a..ff66a0522799 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -523,6 +523,7 @@ BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf=
_len, u64, flags,
>         long long _res;
>         int err;
>
> +       *res =3D 0;
>         err =3D __bpf_strtoll(buf, buf_len, flags, &_res);
>         if (err < 0)
>                 return err;
> @@ -549,6 +550,7 @@ BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, bu=
f_len, u64, flags,
>         bool is_negative;
>         int err;
>
> +       *res =3D 0;
>         err =3D __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
>         if (err < 0)
>                 return err;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index feb276771c03..513b4301a0af 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5934,6 +5934,7 @@ static const struct bpf_func_proto bpf_sys_close_pr=
oto =3D {
>
>  BPF_CALL_4(bpf_kallsyms_lookup_name, const char *, name, int, name_sz, i=
nt, flags, u64 *, res)
>  {
> +       *res =3D 0;
>         if (flags)
>                 return -EINVAL;
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 4be175f84eb9..c219385e7bb4 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6264,18 +6264,19 @@ BPF_CALL_5(bpf_skb_check_mtu, struct sk_buff *, s=
kb,
>         int skb_len, dev_len;
>         int mtu;
>
> -       if (unlikely(flags & ~(BPF_MTU_CHK_SEGS)))
> -               return -EINVAL;
> -
> -       if (unlikely(flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len)))
> +       if (unlikely((flags & ~(BPF_MTU_CHK_SEGS)) ||
> +                    (flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len))=
)) {
> +               *mtu_len =3D 0;
>                 return -EINVAL;
> +       }

meh, why? you have *mtu_len =3D 0 below anyways, so there is already
duplication. I'd rather have extra *mtu_len than much more convoluted
condition

>
>         dev =3D __dev_via_ifindex(dev, ifindex);
> -       if (unlikely(!dev))
> +       if (unlikely(!dev)) {
> +               *mtu_len =3D 0;
>                 return -ENODEV;
> +       }
>
>         mtu =3D READ_ONCE(dev->mtu);
> -
>         dev_len =3D mtu + dev->hard_header_len;
>
>         /* If set use *mtu_len as input, L3 as iph->tot_len (like fib_loo=
kup) */

[...]

