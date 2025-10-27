Return-Path: <bpf+bounces-72347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE52C0F11D
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 16:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF4D428352
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005E030F818;
	Mon, 27 Oct 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx+jkrkg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC730C619
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579906; cv=none; b=ofhcQbeow9TnqZK9SyuEjb0aNIZrSoaZeAj+pnds3+LzfnGvf0EuScAoNAPKfN0yQ5ok8/m2g+AIendoH5rV/jn/3GQlmsheSedDYBtn7mvhZ3OcAcApLe9JoR9x79ZEct4vsn47gJLTx54pZoNXfVoWwMk4FQklk4/Q+2Hd4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579906; c=relaxed/simple;
	bh=qgXmkNhAhY6WchRH7Q4rsd2FBpG4g/uYCUhhcPv5dAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwRXTXi/S0yrP9zgw5wC+vDnTBq5Ypahal4fVGR6uIjTI4+8mf5nCrslChe+3fBNljDdxQPzUEXqwV3BpSb666IPS43ZV7eUtIvp+3wKAjBeMnOHjruQzyk27JhbI5E0F9nB+Wib+h9ueJ3Wk/EuRoPxaqZ4YNwNzTp/DAT9AMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx+jkrkg; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-73b4e3d0756so48139797b3.3
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761579904; x=1762184704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBQiLZSwF/LNIt8C2mTIJJ7RPYKplhz+h76J6R2gIAY=;
        b=fx+jkrkgeH9QSQjTxN9T8lY8s1AyubSw5U6+FW9C5DI02357iT2bwN85Nx0m7ErYxB
         woBbapX4kDWldVuyI794AJtr5oLwbSxkxiRtLMZ3zk2WeTYJIwpsTgJ8so5h5/rLW3nf
         G9dW8W/DymEzYPrTjRQJbnp57EkLeTyZMe5m/w82XAbbwQX7I35LSAXArgGeqOYkXMLy
         5aJ194iyRkKx4benygsi/L4sJvpSGSwqLtLLjj4rOma43mgaA471nMI1hjrEySCGuAPT
         zc1rHcxl2zfD1OIGdc4iitzFsP9o6aTXI+e6SdSIPjDhABTsM0mzyq4lvSLviKR9MZxG
         BsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579904; x=1762184704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBQiLZSwF/LNIt8C2mTIJJ7RPYKplhz+h76J6R2gIAY=;
        b=dj1rPFNQfLlIdPV8mHXSvpd+ROaZvJ+FMUmExdNeT/qx4L+QiMDCFJrRrMW7yXJrCM
         FL73pcn+eNiD3KqVQFj5qvj3xnRZKV01esVEW9JbNK2zj09zz6mk7NO78Sbj5XMaeggM
         pIkahhyxjo69T43T6pcaxKOLEwh06LQd4zYu5sjGNJUmycDyLq41Q6pKRWwnJy/eaaKD
         aNrzGAGlXeBQXF6WSkhjuVArOw4NrMjoqC8hUQh+0hR/DFj/hUqKPH3WVdzcaoERXB5t
         6Y6LBfLLqtf5LF2cv2uQgak0YARXLt+y+x8fnOObBlMPqyx5Ra01LwT5uDO8dRtBT0YP
         QcnA==
X-Gm-Message-State: AOJu0YwqkoLgjth9EAHr5HIQuhE8jihIMzdMgQqC9wMz+9If4+ECLQWZ
	Mvnf8wEVRd8dCz0fgLivdkkh0/v/OSZ58k16rR8ea3H1tdQSN1XTM4J7AMh33hgtmlm7a184+sg
	c1+fBKTPNkCfz0avhCao9F8MATKYNieE=
X-Gm-Gg: ASbGnctOvpOCw+SgADsxfSvJDqguK6mg4Nt6teH+/8ijSLutcGRkgQ2YfwWUiI96Beg
	xKjBduaODrazwzqkv36qY5FKh4Yog2ctY43YwQ9gDSvVWnZvi4XRcAaWRg7CToI5vjOoC0edDsw
	JhpY41aGpnj2RCBU6EUkzfomvXOaIDbd3AeF+QgjeT3wlxcuS6GU9PU3oVDEvUJpIZ0FzmhOpaX
	dKpBW/7BR94XPCevSbk5T0wIiVtKkd5aGgifqO/UTuAhc8vq3cCN9UdBMyXtKx91mqsfKk=
X-Google-Smtp-Source: AGHT+IExotPP9DeycZFzjGUJtTiClWmPd9kW9XEQYVHSF3lBLy99xgpcnLYzoQeFuBkOlvR/aO1x4UpiEz1jnJW67ac=
X-Received: by 2002:a05:690c:4d06:b0:76c:1926:8029 with SMTP id
 00721157ae682-78617f70da2mr2804767b3.54.1761579903991; Mon, 27 Oct 2025
 08:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026154000.34151-1-leon.hwang@linux.dev> <20251026154000.34151-4-leon.hwang@linux.dev>
In-Reply-To: <20251026154000.34151-4-leon.hwang@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 27 Oct 2025 08:44:53 -0700
X-Gm-Features: AWmQ_blhWwrOs7XJgSMOEnYRZPoMEn0YxuvdEaBupfg1qMVmRp8bsrdLudOgbSQ
Message-ID: <CAMB2axPhcYctJYz0bH032-Kc1h2LcJL74O5iS5g=8Qp74GPK_g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/4] bpf: Free special fields when update local
 storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	memxor@gmail.com, linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 8:41=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> When updating local storage maps with BPF_F_LOCK on the fast path, the
> special fields were not freed after being replaced. This could cause
> memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
> map gets freed.
>
> Similarly, on the other path, the old sdata's special fields were never
> freed regardless of whether BPF_F_LOCK was used, causing the same issue.
>
> Fix this by calling 'bpf_obj_free_fields()' after
> 'copy_map_value_locked()' to properly release the old fields.
>
> Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/bpf_local_storage.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index b931fbceb54da..8e3aea4e07c50 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -609,6 +609,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
>                 if (old_sdata && selem_linked_to_storage_lockless(SELEM(o=
ld_sdata))) {
>                         copy_map_value_locked(&smap->map, old_sdata->data=
,
>                                               value, false);
> +                       bpf_obj_free_fields(smap->map.record, old_sdata->=
data);

[ ... ]

>                         return old_sdata;
>                 }
>         }
> @@ -641,6 +642,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
>         if (old_sdata && (map_flags & BPF_F_LOCK)) {
>                 copy_map_value_locked(&smap->map, old_sdata->data, value,
>                                       false);
> +               bpf_obj_free_fields(smap->map.record, old_sdata->data);

The one above and this make sense. Thanks for fixing it.

>                 selem =3D SELEM(old_sdata);
>                 goto unlock;
>         }
> @@ -654,6 +656,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
>
>         /* Third, remove old selem, SELEM(old_sdata) */
>         if (old_sdata) {
> +               bpf_obj_free_fields(smap->map.record, old_sdata->data);

Is this really needed? bpf_selem_free_list() later should free special
fields in this selem.


>                 bpf_selem_unlink_map(SELEM(old_sdata));
>                 bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_=
sdata),
>                                                 true, &old_selem_free_lis=
t);
> --
> 2.51.0
>
>

