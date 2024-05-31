Return-Path: <bpf+bounces-31060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2996A8D68F2
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 20:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D133628B790
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 18:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE53E17D348;
	Fri, 31 May 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MniWtO73"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF7167D96
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179726; cv=none; b=OUNWCCsTv6JlN+85cclvMg2uD00V4CwylthToboRgBumDqq4lcCdYu1FOipj+BD5J5YLgDdH6f/pByUoqjzKdGB2+IFrdsd6N7fjU02r68mOXQGZxhgFCozNIZ1tFvYvnMosccH6ab+U/WPLs81ZjIg+AVy8biFDh1bSWqmlJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179726; c=relaxed/simple;
	bh=QPteefjzOpPi+ZRlJlGkZ/0UqLKEW+VauzLYk4xMQuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DksmkGvkFzdJ2Ji+2juC+uOFq4lmtHi64VMDXpZfyqZSr5gQgvC719sD+9VLn6qzc3F6gdkEWP+Ox5LwR3lvGFJuGTx52HmtB05UjfCMXNlaCF+F7YdGuZMmKU/tD+wZayLG1SWJ2C20+jsx6VxH/4KrDKdPUoXjZZZYGo6WKyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MniWtO73; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso1508862a12.0
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717179724; x=1717784524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjAqTLL9HDmP4YaEBcFgHdNuFK38DvAdgqfDtnOWWcU=;
        b=MniWtO733Gjd6x/PZEBvuZ/QZQE2espNPEygXDXkhV6E8dbW339m+5Oq12sIqREZUH
         b5rMCNFuy7OpTqazSfP62Z9hkLFx0NT+DZ/s2z8TyzdRU2Cmdf1H+ruyIw3UqazlHMm7
         wVSUGIlOALJUn0S9TJ9bpu1fXNX+ZrwHqa+TinxLqUlwzwpK+JSscujvXiiU/qIsJ4WJ
         nplOgcoT58h88uqF4YlkPP8ffxGRGCXXiv1wm4xSE9v8iFGEUJVMsVhrIW5g0tEzeVmi
         YQSsdKJHSc9rlFGlAqfatLcz7MhFDskTbkzrm+tXIP2zv0/wzLV7Ya4cX+noWD+ytEwU
         RXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717179724; x=1717784524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjAqTLL9HDmP4YaEBcFgHdNuFK38DvAdgqfDtnOWWcU=;
        b=OdlM9Ea8CrzlXVff9fx6i+vLsx5+Hdyfujt1bALqI8gZGYCYXGGF4QuEJ6S8NqCBac
         lVTGEztmPlwSeJJvE4MUgNwmii+e7JZxPZVxKJ3gs6ctYeqDVDe3yRTruEBHkVEsDTOR
         A+ZkCEHnT3Fbu9QEXOUz1KbS/j/VH6ozU2wVtNDBHR1WoDCjQP0NDHNhvhgS++RLBGt3
         ooCCzqx5Iu7j9B25Bv4/JAeN2kmRlUKPKorCsMWo+WJrJPXLISRcPVh20crbfPuY6eri
         /Xba0IORCUE4fz1BhY59vcOG8vCB6N1iZltJt/knpuLQr52XC3lnPSkkRxBuEQ4Zgc0/
         OUnw==
X-Forwarded-Encrypted: i=1; AJvYcCU2RSB7sX1UrYs67jwygP6zy2nmJDg1N6oSsf7raX194VcjsZc4MB2zl6N2q0CJ1MN7YtokzsjFE/xokVgtZUOJy7Pn
X-Gm-Message-State: AOJu0YyKYdIKmo87oOepr4rnMoP5l3AHg5h4fkBeF5IssuPW7NTe5V7R
	H80CTZZR6t++99T7uTNiBPJH+n3K1/LnEtrkyvb3S+JM/gcGBoiaNR2geonB1H4m3zjep1r1DD6
	LVYYBkXMoAlkOOiGxfwkydr3Ds2A=
X-Google-Smtp-Source: AGHT+IGCLjGcpKp9z8xAaMd78tPREJq5uU9tXjnMR/SoizccgKF9pB0LJig29Kx4Bd34h7x+JHnNBReT7QoDVgtSpfs=
X-Received: by 2002:a17:90b:30cb:b0:2c0:33a7:2afb with SMTP id
 98e67ed59e1d1-2c1dc560bccmr2639386a91.10.1717179724215; Fri, 31 May 2024
 11:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122408.3154936-1-alan.maguire@oracle.com> <20240528122408.3154936-4-alan.maguire@oracle.com>
In-Reply-To: <20240528122408.3154936-4-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 May 2024 11:21:51 -0700
Message-ID: <CAEf4BzZi_QY9DB5erwNd46UfdwnHLO1=GEVzeiu=AxiYM0inzQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/9] libbpf: split BTF relocation
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 5:26=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Map distilled base BTF type ids referenced in split BTF and their
> references to the base BTF passed in, and if the mapping succeeds,
> reparent the split BTF to the base BTF.
>
> Relocation is done by first verifying that distilled base BTF
> only consists of named INT, FLOAT, ENUM, FWD, STRUCT and
> UNION kinds; then we sort these to speed lookups.  Once sorted,
> the base BTF is iterated, and for each relevant kind we check
> for an equivalent in distilled base BTF.  When found, the
> mapping from distilled -> base BTF id and string offset is recorded.
> In establishing mappings, we need to ensure we check STRUCT/UNION
> size when the STRUCT/UNION is embedded in a split BTF STRUCT/UNION,
> and when duplicate names exist for the same STRUCT/UNION.  Otherwise
> size is ignored in matching STRUCT/UNIONs.
>
> Once all mappings are established, we can update type ids
> and string offsets in split BTF and reparent it to the new base.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/Build             |   2 +-
>  tools/lib/bpf/btf.c             |  17 ++
>  tools/lib/bpf/btf.h             |  14 ++
>  tools/lib/bpf/btf_relocate.c    | 430 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map        |   1 +
>  tools/lib/bpf/libbpf_internal.h |   3 +
>  6 files changed, 466 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/bpf/btf_relocate.c
>

[...]

> +/* Set temporarily in relocation id_map if distilled base struct/union i=
s
> + * embedded in a split BTF struct/union; in such a case, size informatio=
n must
> + * match between distilled base BTF and base BTF representation of type.
> + */
> +#define BTF_IS_EMBEDDED ((__u32)-1)
> +
> +/* <name, size, id> triple used in sorting/searching distilled base BTF.=
 */
> +struct btf_name_info {
> +       const char *name;
> +       int size:31;
> +       /* set when search requires a size match */
> +       bool needs_size;

this was meant to be a 1-bit field, right? `: 1` is missing?

> +       __u32 id;
> +};
> +

[...]

> +               case BTF_KIND_INT:
> +                       if (dist_kind !=3D base_kind ||
> +                           btf_int_encoding(base_t) !=3D btf_int_encodin=
g(dist_t))
> +                               continue;
> +                       break;
> +               case BTF_KIND_FLOAT:
> +                       if (dist_kind !=3D base_kind)
> +                               continue;
> +                       break;
> +               case BTF_KIND_ENUM:
> +                       /* ENUM and ENUM64 are encoded as sized ENUM in
> +                        * distilled base BTF.
> +                        */
> +                       if (dist_kind !=3D base_kind && base_kind !=3D BT=
F_KIND_ENUM64)
> +                               continue;

probably unnecessarily strict, I'd check something like

if (!btf_is_enum_any(dist_t) || !btf_is_enum_any(base_t) ||
dist_t->size !=3D base_t->size)
    continue;

it's minor, unlikely to matter in practice

> +                       break;
> +               case BTF_KIND_STRUCT:
> +               case BTF_KIND_UNION:
> +                       /* size verification is required for embedded
> +                        * struct/unions.
> +                        */
> +                       if (r->id_map[dist_name_info->id] =3D=3D BTF_IS_E=
MBEDDED &&
> +                           base_t->size !=3D dist_t->size)
> +                               continue;
> +                       break;
> +               default:
> +                       continue;
> +               }
> +               /* map id and name */
> +               r->id_map[dist_name_info->id] =3D id;
> +               r->str_map[dist_t->name_off] =3D base_t->name_off;
> +       }

[...]

