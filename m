Return-Path: <bpf+bounces-75900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA9EC9C61F
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 18:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5491A4E3122
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB60B2C0F7D;
	Tue,  2 Dec 2025 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB39evq4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC32C0307
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696434; cv=none; b=BoA+Q4lnSHY/WvM+p2vl6GKxcaUfqJN+LEkJPUZgfkQNo/fYp5LnsTOAf+RdZ++p89FuVzz4JrMZDFT2GDgmIOKJl8DHLVaoBkGPVB09xxpKKVY5fY9Y5CAzNKwUoAa2vV58jGKpw6KbWrmC7DudGm8Kw57pQVcDD8VyPF8JEhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696434; c=relaxed/simple;
	bh=lbprACJXOsDs9quCd1cHPcC8LxjPjXJX4lofHSs/8P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ix/POXquRXrPK++ufc4yC8frfs/VLy7cpfgBQ3fo7q16OMgF3HTh8xioIzpFl7ayGnJl9RC7GaNRJQCV4d4B2P0iAn5PU8KmbjUf6eMGJHFxs9kNuC1aIo19fDJijO32Rl/p0Q6koVqxOE0IcqumpOoUohzXxbngbsk0qQnaX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB39evq4; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-477632b0621so36552595e9.2
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 09:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764696431; x=1765301231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L830+//zOm25WYXSXk+Iz08LvtsPyToF3gamuliHtQM=;
        b=PB39evq4Ke3G9HYkxIDdAnJ4yBL5c4FchOPRmH+TP6cZagRbMfpemiwiaq5Zttpaas
         4QErHrD8VeBo6opPKgW5k1fWPwGewanbSYIdk+WfPzjkpXxFamUrFF4sCA/bpSew9RSz
         4dHJN/J/lXC7hpGXw289dIl7/mfSqeD/ZzPCRCDi9QRQFfc+MKvEuCkPFfL/LrqR6zWv
         YJrnJGJZC1U4cQSutVB5S4FhCgbXtdKPWxfloR/pCDqVT/d5h5zAhJ2xSxXSpoiUXFhF
         E30597g70Gi4iVM+ASk0x3Fj8Knh/64nLqKmS5ng94YbixT6GpaAa4ut/lfcFqVtV03D
         ljcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764696431; x=1765301231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L830+//zOm25WYXSXk+Iz08LvtsPyToF3gamuliHtQM=;
        b=FyA8dpICClfRuCirpM/9/2Odd3X6egBVhmUlE7QxGRH5WCYjME3bBM7h9reEfozJCg
         Nq0RShMUIWiuPOEkUvd+pPlc+XxI/eSHIXqAQ/qLZAa4v4g+j6NTHpdnRhKUAV6xFTwc
         9iaMmV3fMBxJXMLncumTrvc88LHF1Euhkgogm2qJMV1ZTnNd56NwQRLc3a3rYjaSKvXh
         /cG4Vq69HfDAoF1lh8J2Sd30ZwRji8OnnsmGMFNNa9LeAkr43wj0s/zSsqM3EAfQXPpv
         9SgtK24YD0/dC6RlMyv37/xUKYv5PHaNvY43Et30kTFGCG3w9FFJVCRfeaGNUv9vpJLw
         JyrA==
X-Gm-Message-State: AOJu0YyR5baeqwLLvCZug3lCsZjUMMvrXYoHbsO6DkFuRk11xgHRimZ/
	GS3NCq3ZQQ2CAu8ef9J2KwGLqrIuetgSAbEowuvgVV3Elw0subNMA/rP5XqRWBVcMNAQltYnZaN
	/1i6E6or5F8VqRpcaGKtvWWX7S8ByXns=
X-Gm-Gg: ASbGncsn7/e/K1EK6jiFqHOHpVSCegLDU+rqxBzKW7v81/Kw/YdU/Eo8Wvt8KV9WoRK
	tTYG+whgUoigDNwWGsWpVGDKVsl9lGsJN5IaWNl79yQRp9WXjKNJdXAkI0zfEieJBmM3Pch43SK
	1q4/tbZAD2wucFG/FJg61QLHxdSJcjpNIVI5dcUY50o8rsLFBV7SGFnHzyfsfNdT6nOYwZqLiNj
	qEIuU9s3HjANS3xMPtwrc19kXmY27hRac5Z6g7cumy8AFzrdF4H0MDcPl+fai+FY1P6DHd0o5KF
	zcmP+ogjQPtUvSUP0ylSTvCcyDL4
X-Google-Smtp-Source: AGHT+IGLJ+nbQjGFp53SgBuaj7GBJvlo5YLxoq4TlZ1krH5g2A3cvjCUKTQbkdSGyvDEqtgNp6MX3X0+AiCB9ZfW9eU=
X-Received: by 2002:a05:600c:4583:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-4792a4b0848mr3473515e9.33.1764696430746; Tue, 02 Dec 2025
 09:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202171615.1027536-1-ameryhung@gmail.com>
In-Reply-To: <20251202171615.1027536-1-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 2 Dec 2025 18:26:33 +0100
X-Gm-Features: AWmQ_bl2lk2cCWi9ldDTVZI-Wy6MPjSccB7QvC-nW1ieyYidfYW3YZiamy3Jsiw
Message-ID: <CAP01T75C+Zj12g08q3XE2X+TV8Qwx_dua=s489w71or2bu64gg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Disallow tail call to programs that use
 cgroup storage
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Dec 2025 at 18:16, Amery Hung <ameryhung@gmail.com> wrote:
>
> Mitigate a possible NULL pointer dereference in bpf_get_local_storage()
> by disallowing tail call to programs that use cgroup storage. Cgroup
> storage is allocated lazily when attaching a cgroup bpf program. With
> tail call, it is possible for a callee BPF program to see a NULL
> storage pointer if the caller prorgam does not use cgroup storage.
>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/c9ac63d7-73be-49c5-a4ac-eb07f7521adb@hust.edu.cn/
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/arraymap.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 1eeb31c5b317..9c3f86ef9d16 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -884,8 +884,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
>                                  void *key, void *value, u64 map_flags)
>  {
>         struct bpf_array *array = container_of(map, struct bpf_array, map);
> +       u32 i, index = *(u32 *)key, ufd;
>         void *new_ptr, *old_ptr;
> -       u32 index = *(u32 *)key, ufd;
> +       struct bpf_prog *prog;
>
>         if (map_flags != BPF_ANY)
>                 return -EINVAL;
> @@ -898,6 +899,14 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
>         if (IS_ERR(new_ptr))
>                 return PTR_ERR(new_ptr);
>
> +       if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY) {
> +               prog = (struct bpf_prog *)new_ptr;
> +
> +               for_each_cgroup_storage_type(i)
> +                       if (prog->aux->cgroup_storage[i])
> +                               return -EINVAL;
> +       }

Would a similar check be needed for extension programs (BPF_PROG_TYPE_EXT)?

> +
>         if (map->ops->map_poke_run) {
>                 mutex_lock(&array->aux->poke_mutex);
>                 old_ptr = xchg(array->ptrs + index, new_ptr);
> --
> 2.47.3
>
>

