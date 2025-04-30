Return-Path: <bpf+bounces-57060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D6CAA510D
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED979E56D0
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A78D2609FA;
	Wed, 30 Apr 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2o2Gcns"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E3288DA
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028821; cv=none; b=GXAJE6WwHWGYKcvXpqu/dKfC44PeWadU5IytckGzi+B/17XnJuiqgCv6Tac+5a/dzigGydmiP1PKIjqka9+jZDg5rgqXhcVaHyJuXWVNHNRDz+I3V/iE9Tkc+6sagxkCtAZdGLKQKsGo95wLEs1Uoq2jOHqbWJsULo3LRiSfqvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028821; c=relaxed/simple;
	bh=srkawcBWrylY/MgSAtBOTpwRKpWlLlt2Y2bupFa33cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbz1INGQ7Xau/eVVMn7NH69Kl2joy3xacJHZnEJzcX/1RQ71QClhvRmjC3WIPRBVpZ6TOjF7c4Zkow2HFIN2syKAuMnLJesU8GX+gRvXgxGJ83ODBQZd/rpc+E4xejduu0F89QMJGtDv0l0gZtKCkrX9EMosU3Fylo5/kVMRXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2o2Gcns; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso89877b3a.2
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746028819; x=1746633619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ck1jr3GV4JJ4ORq6nZiPwKyYtkCSUQsQHQFx1KIYVW0=;
        b=O2o2GcnsFZJQInM6T+rZgqmbblLouvFtw75EsIBAZi41YAjlik5F63YZ7Yv+LBR8sg
         jm/UJPyaq4i/RrcPwBBKOE8RPV3RnvSwyamrqCFJVZ4NwTHpxtRYLX9j7z8JtQcY770a
         GSKXvmX6zvplcmG3radI7e9150Sv+9P/uApwQhkBbIpONu0B3W4te+hg07P43N9hkk3v
         v9p47F9+wl19qXyra5ppS/vA7Si38StOmKIs70cFIDiYQqx4CdGmoyHq4rOyxJgZcs7x
         6zNmHzfwVArlpZvqYzmsLPgduSXa7mpt3h6nds/hCJsE/q81ABAMUAWNP1TYhw1BhsMM
         WW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746028819; x=1746633619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ck1jr3GV4JJ4ORq6nZiPwKyYtkCSUQsQHQFx1KIYVW0=;
        b=IW6WoEoFIC+ty7RsO//oxlKWOkBTjCkwd5+ao332gnDKTVHTufInYICeZHsYl9QcYf
         Qe5FsTYQ3Ib68Ti6RVo3j7U7xh+41nHeyty7RCGacYO0GRl4MnT3SkPzPyggIs6+8L9Q
         gIQcB/qCeGG5+GV1qTBGP0iZFVR1Q/3Ma2v0s/ggvOy7chMy1gC5qMZ3Wv61LV8sRYNZ
         LJo5ScnzKsJJAII4HtNOQBGs+AIlLuASWJSnXqRyqJbizIb/xYvREZX2wUV3FQUaRtSr
         ansXt6mv59cF0dleKCmDLcicpJ661yJDjrLaYl2kNiQNImx9dW+WAGEoRFBrQFjQJXqr
         D6Ag==
X-Gm-Message-State: AOJu0YzLKoOeu+KOe9Id0bA+Do8krI+KU+lPNz9oYZcvDCnZhTK6SreK
	rFQPEAwQuO4JuSBgz5jMkPx305lfj2+znoJVfqYaN3YhKOWdEUoa+sw0haBB+HZc0mMd5gTKaFV
	StJarv351UI06R6J6J3LmIuKJ5zO22NWb
X-Gm-Gg: ASbGncs0FQaVDxt4mxxVmW09ERGvPEVI3B+WUQYxA/sAyr1Xwr3ClfbP3n02a1F2i1y
	yF8tWZtd7P9QNjTOa/IH9JM3xteuQryWevpp3yCxPkYXx4tKtaXldIy8stYASaqbhlkIBT7K/s2
	cYw0gKUJILveVXTBUYctFxt7VDaIrXZwU5376GEQ==
X-Google-Smtp-Source: AGHT+IGtgmv+TCe999QjR0YS+OkMdZWgka7JpyhAfo49/g7cxWZn7KChVaM+P7px2agZMoaoNx2pShe2A0q/zkqG9cQ=
X-Received: by 2002:a05:6a00:3497:b0:740:41eb:5850 with SMTP id
 d2e1a72fcca58-74041eb58c4mr2069299b3a.4.1746028819464; Wed, 30 Apr 2025
 09:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429142241.1943022-1-a.s.protopopov@gmail.com>
In-Reply-To: <20250429142241.1943022-1-a.s.protopopov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 30 Apr 2025 09:00:07 -0700
X-Gm-Features: ATxdqUHw8xG_hK8kGDcHKIj2_0RKJxceoYHceK-Ag_EwS0ihoJafzjs02vas4JE
Message-ID: <CAEf4BzYeKLgqn+yq3Mt+Vv-9t6qmzQqimb31zD=y-Cw474LU5w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: fix uninitialized values in BPF_{CORE,PROBE}_READ
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 7:19=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> With the latest LLVM bpf selftests build will fail with
> the following error message:
>
>     progs/profiler.inc.h:710:31: error: default initialization of an obje=
ct of type 'typeof ((parent_task)->real_cred->uid.val)' (aka 'const unsigne=
d int') leaves the object uninitialized and is incompatible with C++ [-Werr=
or,-Wdefault-const-init-unsafe]

this is BPF-side code, what does C++ have to do with this, I'm confused...


Also, why using __u8[] is suddenly ok, and using the actual type
isn't? Eventually it all is initialized by bpf_probe_read_kernel(), so
compiler is wrong or I am misunderstanding something... Can you please
help me understand this?

>       710 |         proc_exec_data->parent_uid =3D BPF_CORE_READ(parent_t=
ask, real_cred, uid.val);
>           |                                      ^
>     tools/testing/selftests/bpf/tools/include/bpf/bpf_core_read.h:520:35:=
 note: expanded from macro 'BPF_CORE_READ'
>       520 |         ___type((src), a, ##__VA_ARGS__) __r;                =
               \
>           |                                          ^
>
> Fix this by declaring __r to be an array of __u8 of a proper size.
>
> Fixes: 792001f4f7aa ("libbpf: Add user-space variants of BPF_CORE_READ() =
family of macros")
> Fixes: a4b09a9ef945 ("libbpf: Add non-CO-RE variants of BPF_CORE_READ() m=
acro family")
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  tools/lib/bpf/bpf_core_read.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.=
h
> index c0e13cdf9660..b7395b75658c 100644
> --- a/tools/lib/bpf/bpf_core_read.h
> +++ b/tools/lib/bpf/bpf_core_read.h
> @@ -517,9 +517,9 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 b=
tf_id) __ksym __weak;
>   * than enough for any practical purpose.
>   */
>  #define BPF_CORE_READ(src, a, ...) ({                                   =
   \
> -       ___type((src), a, ##__VA_ARGS__) __r;                            =
   \
> +       __u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];              =
   \
>         BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);               =
   \
> -       __r;                                                             =
   \
> +       *(___type((src), a, ##__VA_ARGS__) *)__r;                        =
   \
>  })
>
>  /*
> @@ -533,16 +533,16 @@ extern void *bpf_rdonly_cast(const void *obj, __u32=
 btf_id) __ksym __weak;
>   * input argument.
>   */
>  #define BPF_CORE_READ_USER(src, a, ...) ({                              =
   \
> -       ___type((src), a, ##__VA_ARGS__) __r;                            =
   \
> +       __u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];              =
   \
>         BPF_CORE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);          =
   \
> -       __r;                                                             =
   \
> +       *(___type((src), a, ##__VA_ARGS__) *)__r;                        =
   \
>  })
>
>  /* Non-CO-RE variant of BPF_CORE_READ() */
>  #define BPF_PROBE_READ(src, a, ...) ({                                  =
   \
> -       ___type((src), a, ##__VA_ARGS__) __r;                            =
   \
> +       __u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];              =
   \
>         BPF_PROBE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);              =
   \
> -       __r;                                                             =
   \
> +       *(___type((src), a, ##__VA_ARGS__) *)__r;                        =
   \
>  })
>
>  /*
> @@ -552,9 +552,9 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 b=
tf_id) __ksym __weak;
>   * not restricted to kernel types only.
>   */
>  #define BPF_PROBE_READ_USER(src, a, ...) ({                             =
   \
> -       ___type((src), a, ##__VA_ARGS__) __r;                            =
   \
> +       __u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];              =
   \
>         BPF_PROBE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);         =
   \
> -       __r;                                                             =
   \
> +       *(___type((src), a, ##__VA_ARGS__) *)__r;                        =
   \
>  })
>
>  #endif
> --
> 2.34.1
>
>

