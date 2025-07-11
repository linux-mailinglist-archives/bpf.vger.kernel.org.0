Return-Path: <bpf+bounces-63079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7C5B0235C
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 20:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84D21C225CD
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 18:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFC52F1FED;
	Fri, 11 Jul 2025 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlOcBcF/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95352F1FF5
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257478; cv=none; b=RnX3OMULSUYeF2HtbYLmBFOnwboUSm1gVAJWLgTbzWnX07snPw86X4GUULROk/XLMCOYPeW3cmNbXZ3EGggFJYh2/aXoaHBER2BIBL2L1nMl8jjepOPTo1OB0IStdqgPdMPQ9gC0lU8gimDDgVcqYVy8ihBCh4zwJpzU0ipiAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257478; c=relaxed/simple;
	bh=fQbvgJmeBOI/MRXk65FwJTcihimmIxOtdD8RGsyQgdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uz03sAvpZznrhUCJXZ9dmtJIH5YfkDo3Bocg463KNIYICLeZbPa4TovCrEzoivUq1L64ZYSjua0zJ9UJxOoEuzpbTCy1A0iz7P35ocdoUQnXmddKGl60bKxChvFb/0rG4VlbiOK1z0gZBJnEG/yS3EzsRBP0w3S59hvI/qA6Ccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlOcBcF/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso2230039a12.0
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752257475; x=1752862275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjD+SXQAHQuZourpSTc+slyCqJRpQnKfabqnSRy+Sxk=;
        b=QlOcBcF/14RUNyUDVn1sd423R7hjtU9WWMG5ALhgn+/EqdZzgqBDG5TYYJ23mOt+Ie
         E0EwLOf60mfhECNALUUEho9CRgR0tu3jTUi+W7KPY8ITM9QxIF13sQWxFB1iI/pW9hUr
         mQCLIsZXW9qRBO1Ch37lHc1YExoC2avfYYq7CyFBQTY3Zhu2JiGiUE66WjMFbQP+rjuC
         4Io/HDajleKMKtm2xBhRkwkrjRPEtNYvKA9pXNBtC6dJA2O+VhJVwGFDbix26U9cZWfG
         XtBNpJM4YdMuCtpGRUOJjAct1YM4AruaSSwRxlurCmF7ZWSCvAWZ3x0PHhbY+yGGaPeN
         M3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752257475; x=1752862275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjD+SXQAHQuZourpSTc+slyCqJRpQnKfabqnSRy+Sxk=;
        b=YTL9ljc+sN9NNxjiD4LSYImx31Y7G64FLu4ZTZUnscrJsBTgR3S0/KQzFYg6BLL4T9
         m1D4VKrfY+/8GLPyAFDNujJVc55pnnnvzXNVHcL05G8MFrB+6EmwvtvAnVX8GVbWh97W
         n6DONtOQGeWQtQr+3y+k81Ld5mO+uj5i9kQ4rTwNteqcfmWiB5N/tKybYM2PUHipfbHX
         PMQlhzywwsNxgE2y+I5dMi7bsQFra/aN+0ofN+3PZid8GKHVAI1MvcwZ7enEwzK2Qcfb
         Hh4xwimy5a+EK7rN6o65Voc+BcHeC9H64gUduIL8TO0epmlPiUYEgSuWEN4WUcZ30TLe
         D0Cg==
X-Gm-Message-State: AOJu0Yzg0OQO3xR+cOjLhTu5dlQHzaL/cAC1x3rRNgwnmsf+giyOp6MH
	YT1iDpsUzsHT6vZpvfnxoC/fS9ttps2RX/4DK3kYWq7p8OVoqXN6EfPqlD/Hl/XdyvxpsYUeHjc
	NeJ5YubOBFWb1hV9mZ3lX4gvkkSwNq3Jm3Q==
X-Gm-Gg: ASbGncs6Dwi2jWcrFG12SMRoZwkEizwcFfOx9JvmBrJ2HXXVdpYA27CJOwfjGrjxroy
	b30dptpEDq/A2rPls/zwzmCfEx7i0BonWilr63hSdRzF4OfE71DKx/ZAfSgqjAQjz+firIYFtdB
	Wd5C6Avva2xEvE6TLm8MibEpaDOCFP/oHeBh1CnJXhpqrHn2v/xvDPiwrIyuH0gcsc/Mm7zs/8O
	2kuc2AumP1+7CXJf+rm/Sw=
X-Google-Smtp-Source: AGHT+IH9eAtYqvlET2eOFkji8GxA7TdjqH/SdH1mESZott5trvgvvu52kYO/bYir2Sn9u5LQFcqrk19d5yXMStoktdY=
X-Received: by 2002:a17:90b:554f:b0:311:e305:4e97 with SMTP id
 98e67ed59e1d1-31c4f512c31mr4905968a91.19.1752257474849; Fri, 11 Jul 2025
 11:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707160404.64933-1-leon.hwang@linux.dev> <20250707160404.64933-3-leon.hwang@linux.dev>
In-Reply-To: <20250707160404.64933-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Jul 2025 11:10:58 -0700
X-Gm-Features: Ac12FXz4UBJdcfLgHwUVnMwcgBuYWQki9cAxedJn5Nu0XZIF4Dz9hps8mcYWxag
Message-ID: <CAEf4BzYa6_EHLkf7F+e9B18wc5oK7KizA7x5CEQ3jT7Lx4V3Cg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/3] bpf, libbpf: Support BPF_F_CPU for
 percpu_array map
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:04=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> This patch adds libbpf support for the BPF_F_CPU flag in percpu_array map=
s,
> introducing the following APIs:
>
> 1. bpf_map_update_elem_opts(): update with struct bpf_map_update_elem_opt=
s
> 2. bpf_map_lookup_elem_opts(): lookup with struct bpf_map_lookup_elem_opt=
s
> 3. bpf_map__update_elem_opts(): high-level wrapper with input validation
> 4. bpf_map__lookup_elem_opts(): high-level wrapper with input validation
>
> Behavior:
>
> * If opts->cpu =3D=3D (u32)~0, the update is applied to all CPUs.
> * Otherwise, it applies only to the specified CPU.
> * Lookup APIs retrieve values from the target CPU when BPF_F_CPU is used.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c           | 23 ++++++++++++++
>  tools/lib/bpf/bpf.h           | 36 +++++++++++++++++++++-
>  tools/lib/bpf/libbpf.c        | 56 +++++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf.h        | 53 ++++++++++++++++++++++++++++-----
>  tools/lib/bpf/libbpf.map      |  4 +++
>  tools/lib/bpf/libbpf_common.h | 14 +++++++++
>  6 files changed, 172 insertions(+), 14 deletions(-)
>

LGTM, just see the note about libpbf.map file, thanks.

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 1bbf77326420..d21288991d1c 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -436,6 +436,10 @@ LIBBPF_1.6.0 {
>                 bpf_linker__add_buf;
>                 bpf_linker__add_fd;
>                 bpf_linker__new_fd;
> +               bpf_map__lookup_elem_opts;
> +               bpf_map__update_elem_opts;
> +               bpf_map_lookup_elem_opts;
> +               bpf_map_update_elem_opts;

I'm planning to cut libbpf 1.6 release early next week, so for the
next revision please add it into 1.7 section


>                 bpf_object__prepare;
>                 bpf_prog_stream_read;
>                 bpf_program__attach_cgroup_opts;
> diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.=
h
> index 8fe248e14eb6..84ca89ace1be 100644
> --- a/tools/lib/bpf/libbpf_common.h
> +++ b/tools/lib/bpf/libbpf_common.h
> @@ -89,4 +89,18 @@
>                 memcpy(&NAME, &___##NAME, sizeof(NAME));                 =
   \
>         } while (0)
>
> +struct bpf_map_update_elem_opts {
> +       size_t sz; /* size of this struct for forward/backward compatibil=
ity */
> +       __u64 flags;
> +       __u32 cpu;
> +       size_t:0;
> +};
> +
> +struct bpf_map_lookup_elem_opts {
> +       size_t sz; /* size of this struct for forward/backward compatibil=
ity */
> +       __u64 flags;
> +       __u32 cpu;
> +       size_t:0;
> +};
> +
>  #endif /* __LIBBPF_LIBBPF_COMMON_H */
> --
> 2.50.0
>

