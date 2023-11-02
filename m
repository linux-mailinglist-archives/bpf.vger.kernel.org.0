Return-Path: <bpf+bounces-13909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC607DECA9
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6492B281AAC
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE425227;
	Thu,  2 Nov 2023 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQoo7nS7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F7D4C9A
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 05:59:05 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B92CD7
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 22:59:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4083f61312eso4189835e9.3
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 22:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698904742; x=1699509542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXX2qenhOsv3lSe1EamJq3W8kEVyRo3eOOz+lcy0UEQ=;
        b=KQoo7nS73hI3WmsVFNulEIv1Ip6ZWXmus7aToN/fIuyACzCulYygrUgrsf1wETPLZd
         Nj6No/FL4Z8Xqs+lVE4dx9vziSFs+Ui/P/FzYYrf/P7g8tOqcPwglX7r6feH37e64moW
         lKTee0CuCXxHh+ItzUm9R72SdFSaCJZXmyFakZ95Q0hrlWfbiPA20wzyjKVx8UeQ07Vq
         pERyTbH/zyaZkfBoAu9M+xl/9w62xv822/iexCYQ79w3AzwM42a90+gtVfpDV6thfr7F
         AXjfQBUNE2mRBnSZ59m4fxssz55B5r+VWGS6TpDjrEMXFSFIvdT9X0mKyDuZXxu8gjak
         q6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698904742; x=1699509542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXX2qenhOsv3lSe1EamJq3W8kEVyRo3eOOz+lcy0UEQ=;
        b=Ld1PkiR56a+08htwyYMmUgEW6Ruz+Ft5wN6EELVsvu0d2UCZbhY6Zd43JQ7l2aPl2z
         gLGC2diEbxcRtNZZ1EeOYVVUS07t4oN+iXGC+Al7UEEMSDB+19EqbeeBSrMS+PhIPFNB
         tiyM3MNlbYh+1XkD99ipY0O/HPsPfsYpMGR+kSaTZsvphHC7xcVP0OddTh7QxHKV9/YS
         Gj68XSoR8hWEPJO2rE9z4M/V4dV8EUUemCOjvPgFHto+ji5qaKAMC9zMZk+Ny+x1Kxu8
         DKGCyYAMJKqP00E9alflxoL6ya+x86a6jUhYBwuqZAgrTd/Yt/v8VU7ApH/2efeXNPnV
         tm0A==
X-Gm-Message-State: AOJu0YzeDUBeQQqbh5bY9OpqVXrpWF2EZNE3GLBljY9T6Qv3b+PT/OF2
	mU/OyJYIvMq3B+Pyhq/PbaSg9rRXBFgTqZvCWW4=
X-Google-Smtp-Source: AGHT+IFXJoQUVrP10UvEpxyjpq1KrF/R5gyGwk15+ii5TiHgxAl2HxSDGWtsNU7faoVWvZJxsyXyHQROeMGwKT48yYM=
X-Received: by 2002:a05:600c:1d18:b0:408:4475:8cc1 with SMTP id
 l24-20020a05600c1d1800b0040844758cc1mr15920925wms.35.1698904741521; Wed, 01
 Nov 2023 22:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024235551.2769174-1-song@kernel.org> <20231024235551.2769174-4-song@kernel.org>
In-Reply-To: <20231024235551.2769174-4-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Nov 2023 22:58:49 -0700
Message-ID: <CAADnVQ+rqwPARuwkuRJLJSYN45m7vC1sLkiVX=BQbP0ho+3DJQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/9] bpf: Introduce KF_ARG_PTR_TO_CONST_STR
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, fsverity@lists.linux.dev, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 4:56=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
>
> +2.2.5 __const_str Annotation
> +----------------------------
> +This annotation is used to indicate that the argument is a constant stri=
ng.
> +
> +An example is given below::
> +
> +        __bpf_kfunc bpf_get_file_xattr(..., const char *name__const_str,=
 ...)

After sleeping on it this still looks too verbose to me.
'const' is repeated back to back.
Let's use __str suffix?

> +                       ret =3D check_reg_const_str(env, reg, regno);

I don't mind that helper has a more verbose name.

