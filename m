Return-Path: <bpf+bounces-49537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA338A19A9F
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 23:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEBE3A8140
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 22:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E1C1C5D77;
	Wed, 22 Jan 2025 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8gLv+A0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC1149E17
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737583365; cv=none; b=arogREZRfX5M+LOPcyew62rw1SsMWgbq3f25U0ZzHZ3mEBd3we4kYDq0cXAndofz4RUMImMLiGZPoX6kTI1e9cMNiLfWtLgbXGpPq/sbQQ2XbY7kFpJyVRRbdIyJRAU0MsrPSsGpgb+4Fnw/3zY1g6z2gLBAPTn02PKhzx47+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737583365; c=relaxed/simple;
	bh=i1HamO6e9UeDjUmUXbKx8FvH4DWMcB/nqNAPUua9sIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGo/Gm3e7hOXJxlggEglzT2uscBbTnFlPskoZhtyVDiBkJzYW75IwMqSnYjoI680yQn0C4XX1FRH8g27XEhOV+FcIu4JJBOaMaoYSLsoIkqI8hKUisUGlkNssKhvrHUTHXj6dJzsPbn0813K7xnYIkFGwNL2the1Mfm3SqV/HGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8gLv+A0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so511894a91.2
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 14:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737583364; x=1738188164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYlpZzww93rG77I4oDg8cp3fmmarmxXqx7u3WQizgCA=;
        b=k8gLv+A0FKXORZUwFieKfmj+9freNlNcLLqM1XDzeBinMzpuFsFNysN3pT8xqoeTXJ
         SXdWenqld9xCmoV0hKEwmdHFr+LKOlFutdpADEPkXkVo9PlgU/tBP6zP8+a53i3fOb1k
         Acee6WJwiyeZG1wGUV+k4KhWFAQo5p0+b7Bs9nrBy5tF2q0kmHrHjlIL90NSgvhxlrgO
         YFAfbS0ere28hfF4gGqLCsAZPPHd7+p4qEUDz/BrqF9rqyNTWyuxG5v6QpVjPz8WgmFa
         qBM5m2BOh2Q1DLrqaYoLJXqilkAET2GRxWhaP1Xyku7/E7nogeBuF65NFFpcw6EjE2pA
         p7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737583364; x=1738188164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYlpZzww93rG77I4oDg8cp3fmmarmxXqx7u3WQizgCA=;
        b=F6Q7U1EEOtNp+q0W2MpqFvwwBay2mQEwEpNhgBbydLsXSQr2IHHw1ZqEoFoI6K1M5D
         I/D6fUdewcg7wcf6FzSb3veXfB155P8UgZsoNaJoTXDirBS1XFhqTIhtkq/iWYkFpR2+
         tUAsalLAMIifo3sYxb6KsiII+0Fd6xGwWZ5pbF1wPDwJUUEvWqro8lPtGlo0NlSBZFHG
         L2XHDgsD2aWlYMfOf2bXVo+DGmtGOR9LQswDYa9BVWWR/wytmHIDX+VVxAUDX6prP5HG
         kPNe0aALmqS6NK8eqGGkaljqNTSEVh6AEF/lFsHmAnaWX2lnjACZv0xuHDev+lHEOSN2
         wzog==
X-Gm-Message-State: AOJu0YwmT4Az/eBzubnlF9SAFBZsss/Uq2Ap5hDwWT2AgUCy30Qj+KF0
	sXEJQSmVY8ccUWxCk4IM0a00A90vRfhaptHjPw5AwmtNlAQ17KiCS6SM/Up6IHVtmLZ34cvsVAl
	xFuYLUU/+M0N7DppGJ4g+n6ixpYY=
X-Gm-Gg: ASbGncuplHHSPsa/lsOULESsWuAWQxSterjPGCmZBhVtW/9EqOX+xJ3ZQgIpJzZd0Yw
	6Zhq6B8cHOSklZeGn51hriwTylB65Gn1MPCrharRiWzXWYZOxVVFJ3N/5V1oHcDoxC6g=
X-Google-Smtp-Source: AGHT+IEN+GWOfdNODC7bkDbq598hMNiTKocPySn8iPjWyf6dxmDKb/0rZ7uegN313if7NTxnjf9qkny9xQXEV8SGPks=
X-Received: by 2002:a05:6a00:2d96:b0:725:e057:c3dd with SMTP id
 d2e1a72fcca58-72dafbcdbe4mr30212427b3a.22.1737583363597; Wed, 22 Jan 2025
 14:02:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122025308.2717553-1-ihor.solodrai@pm.me> <20250122025308.2717553-2-ihor.solodrai@pm.me>
In-Reply-To: <20250122025308.2717553-2-ihor.solodrai@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 22 Jan 2025 14:02:31 -0800
X-Gm-Features: AWEUYZmtqvQ08dZgwaQnfD0KS0MXYXXYYgvQswbFHxM91eSFLSucATb5wHaBHEs
Message-ID: <CAEf4BzYFJBLrQ=mjoh5K7KimzVpqz93vxrf1eXwTxDMv3w7gSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] libbpf: introduce kflag for type_tags and
 decl_tags in BTF
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, 
	jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 6:53=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> Add the following functions to libbpf API:
> * btf__add_type_attr()
> * btf__add_decl_attr()
>
> These functions allow to add to BTF the type tags and decl tags with
> info->kflag set to 1. The kflag indicates that the tag directly
> encodes an __attribute__ and not a normal tag.
>
> See Documentation/bpf/btf.rst changes for details on the semantics.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  Documentation/bpf/btf.rst      | 27 +++++++++--
>  tools/include/uapi/linux/btf.h |  3 +-

kernel documentation and uapi changes should be in a separate patch
from libbpf-side changes

>  tools/lib/bpf/btf.c            | 87 +++++++++++++++++++++++++---------
>  tools/lib/bpf/btf.h            |  3 ++
>  tools/lib/bpf/libbpf.map       |  2 +
>  5 files changed, 93 insertions(+), 29 deletions(-)
>

Please double-check whitespacing, tabs vs space might have been messed
up in this patch.

pw-bot: cr

> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 2478cef758f8..615ded7b2442 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -102,8 +102,9 @@ Each type contains the following common data::
>           * bits 24-28: kind (e.g. int, ptr, array...etc)
>           * bits 29-30: unused
>           * bit     31: kind_flag, currently used by
> -         *             struct, union, fwd, enum and enum64.
> -         */
> +        *             struct, union, enum, fwd, enum64,
> +        *             DECL_TAG and TYPE_TAG

keep it lower case

> +        */
>          __u32 info;
>          /* "size" is used by INT, ENUM, STRUCT, UNION and ENUM64.
>           * "size" tells the size of the type it is describing.

[...]

> -/*
> - * Append new BTF_KIND_DECL_TAG type with:
> - *   - *value* - non-empty/non-NULL string;
> - *   - *ref_type_id* - referenced type ID, it might not exist yet;
> - *   - *component_idx* - -1 for tagging reference type, otherwise struct=
/union
> - *     member or function argument index;
> - * Returns:
> - *   - >0, type ID of newly added BTF type;
> - *   - <0, on error.
> - */
> -int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_i=
d,
> -                int component_idx)
> +
> +static int __btf__add_decl_tag(struct btf *btf, const char *value,
> +                int ref_type_id, int component_idx, int kflag)

nit: please call it "btf_add_decl_tag" (to distinguish it from public
API, but also not use double-underscored name unnecessarily)

>  {
>         struct btf_type *t;
>         int sz, value_off;

[..]

