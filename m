Return-Path: <bpf+bounces-50458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B959AA27F6F
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 00:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3231627FC
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 23:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66D121B8F8;
	Tue,  4 Feb 2025 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfO1s+bl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9822054E3
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738711081; cv=none; b=GEKUpyFTUZNhBkrCtip3MRoIhzJ48A2myBfy+VahvpkSXvROdc5V1vfE0iwzkfW0LLvh7od4afd00+nq1xcEwLRfbVnj+3wnYPxf+y9f9r8AOUcOea1UM84xLxaHjVHVljeZ8DgMsz/4TpvJvg201GHMbqBGqGh/rfkFztyauKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738711081; c=relaxed/simple;
	bh=wGKdjZNm1QVwCE/Q+7CiPjP7g4TvimkNV6CEEU6LW+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKr95wFtNqdH6swN1SDw8zB8G1Xf/iOqRvLdXlWAi+T9VCsPDElVE7lNlIID0wkU5PsvdIYeoXbDRnWrnGQVrpANW6lmlNnNEeNQrhthRjC+447xQ1imz4+u8wNdohDDbf+NtxwfKLAvg60C5Dt6Pf39U1DMFoJ0fUGLBdrK128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfO1s+bl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436281c8a38so43754525e9.3
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2025 15:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738711078; x=1739315878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BYDLCiGGHLj95qSdJWi2bKJiSb3Y+kFZJZ0UHIbKp8=;
        b=RfO1s+blb56gfq5ZLVXW+oQ1sXIdJC23YFlVKDoKPWIrDzlcZD11onROLQpnpr1NmD
         xBdDoGDwIdEoUeOom8BOnQlCAnazwnDt7WQ8826vp/LroJ/9D/bCX2YQDTNnPPSgUomp
         gGfeZW2uaI/f1s74otIHr/DsfkX9iD7xHNrAtMfh4TWwnCkrSUJwH2PdHU5kmx6m4vIH
         3f4XszyrtDZp4l34B/WtluRAbMJSCvmQSfnGp+xF+glm0fA8Nf4SQKFBtZy1YDeSRmje
         52+OaOjxbuC/Hl7LhNLtMB+HCH4/m0clRHnsoTtlrUZBpwBGgwk+B8W06bFzArjWw4IO
         4+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738711078; x=1739315878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BYDLCiGGHLj95qSdJWi2bKJiSb3Y+kFZJZ0UHIbKp8=;
        b=On1pTaqb/r8tkDABXLyHlIovpdEPQvXLayvjjZ9AiS7+puoRQMkwf8g6FfXN69Z7LS
         JFzichA/UbiYz2/C8QzgmFtTo8l7OME5wpP+aHCFFeWotfT2GgtByttBVpDeW6/2bjgo
         PtK8LOTrN8SKpB5hlLXmebMwXljd0Iw8ooMP3NLOVIUKuTy5BP6HdRVZxPakpUT9ckX/
         vbpv732n2ECqS7kDoegm5hupW50A32cF2gGKcNCmMhs0LoqdzcHG4+Odyb7pVPkjAiBe
         B0ZG79BLERKo5Tm8y2efr062eA2/jyMss82YEahYO5epzpX8VZNsjULCoNFLeEtNQAcW
         6XwQ==
X-Gm-Message-State: AOJu0YzTVphMNXhRGJmFrMMbWDEz07zPS4h/cqrWZLdeQkiFR/kPcwwS
	8LVswdi7kdV5L6sfyWS/mCGxysOfU+Aa/3Op6ml+I5iP7baSxlMvrENlzFVPrAQ2bhIiCG53Sul
	NeBqOF//+TBF0LrGzygctQ/iEQPU=
X-Gm-Gg: ASbGncsrtu+Cajp+MvdpWQksi/mpAp5R0k/QHTgnvdChHUgdLk6li5mekSec5h4yfLn
	JsxtjAyeumommsXHRXWyiO7PeDq0jqXlJfF2SYjyjVk6M1OeWYV/SVRgYKtr2CvE2qKZKYnH0
X-Google-Smtp-Source: AGHT+IHXYSdoONdPlNMCFrufrSIWc0eFcBlqgFZGkdQ+gdmkP13UuMHYV2mB7oFj2Ep0WAnyeHAXXJc5aOo2pE8cpDE=
X-Received: by 2002:a05:600c:4b8a:b0:434:fdbc:5ce5 with SMTP id
 5b1f17b1804b1-4390d5a3a04mr2865485e9.29.1738711077490; Tue, 04 Feb 2025
 15:17:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125111109.732718-1-houtao@huaweicloud.com> <20250125111109.732718-2-houtao@huaweicloud.com>
In-Reply-To: <20250125111109.732718-2-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Feb 2025 23:17:46 +0000
X-Gm-Features: AWEUYZn4W7CBqW2pFjRgiKf9yGhenMX-6LxexW5TBTiQ1J3jxs2yfJB3690Ly9I
Message-ID: <CAADnVQLep5NrLfJkWbtQsBSZZq-BhBJOVcZ4US7EAZ56D27MhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/20] bpf: Add two helpers to facilitate the
 parsing of bpf_dynptr
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 10:59=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Add BPF_DYNPTR in btf_field_type to support bpf_dynptr in map key. The
> parsing of bpf_dynptr in btf will be done in the following patch, and
> the patch only adds two helpers: btf_new_bpf_dynptr_record() creates an
> btf record which only includes a bpf_dynptr and btf_type_is_dynptr()
> checks whether the btf_type is a bpf_dynptr or not.
>
> With the introduction of BPF_DYNPTR, BTF_FIELDS_MAX is changed from 11
> to 13, therefore, update the hard-coded number in cpumask test as well.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/bpf.h                           |  5 ++-
>  include/linux/btf.h                           |  2 +
>  kernel/bpf/btf.c                              | 42 ++++++++++++++++---
>  .../selftests/bpf/progs/cpumask_common.h      |  2 +-
>  4 files changed, 43 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index feda0ce90f5a3..0ee14ae30100f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -184,8 +184,8 @@ struct bpf_map_ops {
>  };
>
>  enum {
> -       /* Support at most 11 fields in a BTF type */
> -       BTF_FIELDS_MAX     =3D 11,
> +       /* Support at most 13 fields in a BTF type */
> +       BTF_FIELDS_MAX     =3D 13,

BTF_FIELDS_MAX doesn't need to be incremented when btf_field_type
learns about a new type.
The number of fields per map value is independent
from a number of types that the verifier recognizes.
The patch that incremented it last time slipped through
by accident.
Do you really need to increase it?
If so, why 13 and not 32 ?

pw-bot: cr

