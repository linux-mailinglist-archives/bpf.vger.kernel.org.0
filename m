Return-Path: <bpf+bounces-22896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AFB86B651
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570951C213B2
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAA115D5DE;
	Wed, 28 Feb 2024 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3cyqU+p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FAA3FBB5
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142353; cv=none; b=QV46Xv2mRpR+4IVj52jz4drw0RicchSg2oMa2GEYWm79u/+gM1+7C6ruzTx7LPx0VwZJyFNrX89T6ax9VVtHZap/tSfGRZ4LNMu1aE4iTK5YxR8V7dBbF9VcaX3kco/JJn0aM43MhJ2k4i/98IxBip89hGk/Fl7POeM4o+5xE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142353; c=relaxed/simple;
	bh=+Nw7Pv3zxNVDQG2S3vyJM3wxtQwWvDc6zLyM889vZ6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tf9jGpT/UjYvh3Kstvv+2wBecAxkGXC2TyRpc5Wf0sDVXaY+NSoDPvY5kLNTGiBiOFF9LwK2MNXXH4i3kIjVoSz5G0csFR2dLAlsh10n7vZy51Scu+Xtug2OTLWBGuIZ85kWLaxFXBrhABm7w6wUlvwNwf47KZX1YvCtw9VSHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3cyqU+p; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e48e42a350so2423815a34.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709142351; x=1709747151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rug+XZmSKkUln1osjhk9xEzvON9Sj1tZqLltXxqnKDw=;
        b=f3cyqU+ptuLYgOGeB7oeLsj+fcv8YoKOCy1ufUkU3PVF++pdevzSNqn9FIFu9xyInv
         1nbOegpYX55OmOlE9Nhp5OzZ3PjW15p+PxvMn5eH8mMJ6oih6ZDetmY5yXD/80AHEc5D
         9G4hc7CgN5iil4ybAN3WYg4qKfJaNNaALnlZFZy45jy3ncsaIGjsb9wOB39Wr1NxcQc0
         YyPvwSepcSRHpa8uXH+hG8vYcHbXm7wneN0xGz5K/PXYFV3KLdpnzSkaTKcKdjFNd1Nc
         dQ+hX86J5rQETtrCAZL5z3Qbz0/oaIG0/5OTX7y0anGJxEfE5pgBtwdMDku+QUpixm7f
         iprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142351; x=1709747151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rug+XZmSKkUln1osjhk9xEzvON9Sj1tZqLltXxqnKDw=;
        b=twsEoi5QfnQGKvO0eCjmbAUFWJd7rn/aMjiBIv5a0X7f2My84rcS4qRS1BI+8pt26Z
         CpF8nIk7IVvMtne6CZLS51RQrWavf5msunCJS6mOb27onjPVPQQ4bD8Wg9Q0shkhXKpB
         +mxpbEf0bjOlFx5ly8hC0gtkHPfg0aWU/yv2F1aIHizIFX/wU8CEFiHcGPPtAShMbC5y
         cYKzM6Q7jtXkOOAG8at4copITOTasE4DbRq/vbfhqmwgPl3pyxBybWR3aDfF80byU+FO
         Ld6FvJWnihTboFJX6361Ra2S9USNvXdbMRROHaZoEHSnM6hfG5ZBCe5v2annYajtyIfV
         4AEw==
X-Gm-Message-State: AOJu0YzmZybTRPWaZXMA2/ALTXOc6e4B2LwOZY+4diGciCmjOhQr6X29
	6sZo+ajY7y2KPtKuZ0yhA+xXEo2kfebD61tcgF/FmdG4KONszng45cjg2fWiHgPzipfs2jDBhDY
	hARYHreKLtaCf80S0hSEjyCZLS7Y=
X-Google-Smtp-Source: AGHT+IGprdM2IMxiUlWk08iXB+jyHV2blkN2ZShdD1ZBfJQ49bO4x2X1Au3Ofzi1Jvoqd7D6XYKiy3HUK4Y3GChrIvo=
X-Received: by 2002:a05:6830:1107:b0:6e4:81d3:30a with SMTP id
 w7-20020a056830110700b006e481d3030amr281870otq.15.1709142350970; Wed, 28 Feb
 2024 09:45:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227010432.714127-1-thinker.li@gmail.com> <20240227010432.714127-2-thinker.li@gmail.com>
In-Reply-To: <20240227010432.714127-2-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 09:45:39 -0800
Message-ID: <CAEf4BzY5dytoYwfZw3UV60fRtw_yh2LakDJHBFt2KWq0C189ow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/6] libbpf: expose resolve_func_ptr() through libbpf_internal.h.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, quentin@isovalent.com, 
	sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:04=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com>=
 wrote:
>
> bpftool is going to reuse this helper function to support shadow types of
> struct_ops maps.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c          | 2 +-
>  tools/lib/bpf/libbpf_internal.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 01f407591a92..ef8fd20f33ca 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2145,7 +2145,7 @@ skip_mods_and_typedefs(const struct btf *btf, __u32=
 id, __u32 *res_id)
>         return t;
>  }
>
> -static const struct btf_type *
> +const struct btf_type *
>  resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id)
>  {
>         const struct btf_type *t;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index ad936ac5e639..17e6d381da6a 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -234,6 +234,8 @@ struct btf_type;
>  struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
>  const char *btf_kind_str(const struct btf_type *t);
>  const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u=
32 id, __u32 *res_id);
> +/* This function is exposed to bpftool */
> +const struct btf_type *resolve_func_ptr(const struct btf *btf, __u32 id,=
 __u32 *res_id);

it's trivial helper, there is no need for bpftool to reuse it, let's
just implement a local helper for bpftool. We should have done the
same with skip_mods_and_typedefs() in gen.c, but oh well, we can fix
that later.

Generally speaking, I'd like to minimize amount of internal functions
exposed from libbpf to bpftool. It's justified if the logic is
non-trivial, but resolve_func_ptr() is not such case.

>
>  static inline enum btf_func_linkage btf_func_linkage(const struct btf_ty=
pe *t)
>  {
> --
> 2.34.1
>

