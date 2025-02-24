Return-Path: <bpf+bounces-52463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE7CA430CE
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 00:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4515319C2A32
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C813320F07A;
	Mon, 24 Feb 2025 23:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9YCe5Ni"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402220F076
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439422; cv=none; b=aiKqtybqrUQlV8uCEwMqsRxmYUQQc6TZ59Qg/tAbNFeVQpenYbzRP7H65ekuefosx/WBgr2iLyrC7gYWVkxRfxngSqKFT7oK8S2nKcY8Vp0Jt2TBU3Lhtw6O+nBY9eNPgY0zJuMttipWXabEDz3pcL1WlqpNUvuOifqEiYbbzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439422; c=relaxed/simple;
	bh=reYP8YcgMB+kEFYN3dUPtBZGjZdYgNdbYjN8W0n2UbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lumag6jogJ/7tQOmPgsLYBaI0cgGtNn2roH0qBfT0ZZgW/S724ivGAVQoDSknXPJ8OhujzEcJe/L5e3byTNyp16U2nE90SHQukW4iVZfXLfXgjXCEP8AWz7CNJLC9LgDRMvRQwRCiULtEf5ntdh3KyjWQW26hn6WmEj3I2r2V9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9YCe5Ni; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fc291f7ddbso8031847a91.1
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 15:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740439420; x=1741044220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfbHn4qVetOT4uvZUNtH3TqfWfRF6g8uMXNJw986b1A=;
        b=K9YCe5Ni2KLIbpIyeRXKzBKAXHSwlMwjjJpwkB6BBVsZiLoIuuadXPkxg5Lct6Q9Pg
         3gMzKhc6ResniTbIbKfPfZmBGbvGUGEhEzm1lWmpm0zZiGTEJ5NzOSndyvXUzC8l+RhC
         zbNyxwmdk6T9hmMIhW7iyOZwQN6zVUcl78KRPHr5R37oKsaLi0jlY5NxGK8XosaILUWm
         gHtGF+TV7mIDvFRZUEBrh1NMVgk/aKd7OVhzfNCT/YZZ/+LjjWVwnZ4Njrk2xnax0tgj
         ZMrO7tTgl1imueYYJjvscR3tYbREU4ViRLmQnNoIa5ml+ImJRX9q0IW1uPbKrbKnhevE
         EgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740439420; x=1741044220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfbHn4qVetOT4uvZUNtH3TqfWfRF6g8uMXNJw986b1A=;
        b=iEOzcb+jnztjNmvwGvBUZv8u199PEVEpcrOgygT9kcZh3zmqqDIoLGWmqqtgEcP0Bi
         +4Fet8eOvgzYcw/d1+2JzHHxKPsWbYV4v4nGhVUOMW8DaAx3Pn2zDD4zeMVaYHvI49WY
         G73TIc/zAlAwwgMrqkXLXUN9qfuDNDMzEBPlqGK89xchY6pX3NitpIGAQkeEkSD2d9J3
         o1kjfa9scdxYsfR30wWkBEp2fcPM3WuaPA8e94FT5GAqVZkcusA0WYssemwszi2+PNzX
         viACiqOi8iOnxSvgaM5CBIDrJyXkje7Zw8maofnUvgN1JSQb7z9ZmpdYvhYiPOOyJIZi
         TACQ==
X-Gm-Message-State: AOJu0YyhBrIahxqvYxRUOffRtKQ0iD4/jk09juaSKP2V5zbw8n9M2gCu
	lef8hPjGu2uVg9RNsJu0Q7Ezl+AaHGairEavGSCEAZPizRxIhcIiyVW9UG5PcpicyxumUP93204
	uxmkMPhmYnYBby5R3T4sP/Djyh6Q=
X-Gm-Gg: ASbGncvrbb1m+WAlC6R2gIXLGmeAjnCov4NzWbFF2dewzMeKho8KLRzZy8JugvpzSc5
	ROaudK0NlUbUx315z2IGw8s56Zj2iognzAsleFWvReZAavQuRoCdkBDNGhgwEqpFL9kxU7g/blx
	qRwqPCJ2ePVrpfIaYL7XonW8s=
X-Google-Smtp-Source: AGHT+IFznbk8vHh9T5W8flPEbSftTf+9fRm5UC3G6IfZIeJxAvQVLk8cDnra69MGDWB0EAaI8cRwcOYcZR/g5IobbVA=
X-Received: by 2002:a17:90b:2751:b0:2ef:e0bb:1ef2 with SMTP id
 98e67ed59e1d1-2fe68ae3f40mr1478601a91.19.1740439420007; Mon, 24 Feb 2025
 15:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221221400.672980-1-mykyta.yatsenko5@gmail.com> <20250221221400.672980-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250221221400.672980-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 15:23:26 -0800
X-Gm-Features: AWEUYZn7zNk4k-9VkQL2EybbYtnF3BG4VFyvtnFHpyORVLHDAFiZfubU7ZAirH0
Message-ID: <CAEf4BzbNs0AXncqci66XZpUsyMTTEYoa7-bfpUT8zwaMmKo5iA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf/helpers: introduce bpf_dynptr_copy kfunc
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:14=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introducing bpf_dynptr_copy kfunc allowing copying data from one dynptr t=
o
> another. This functionality is useful in scenarios such as capturing XDP
> data to a ring buffer.
> The implementation consists of 4 branches:
>   * A fast branch for contiguous buffer capacity in both source and
> destination dynptrs
>   * 3 branches utilizing __bpf_dynptr_read and __bpf_dynptr_write to copy
> data to/from non-contiguous buffer
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>

LGTM, a bit of unnecessary code I pointed out, but I like how minimal
and clean all this looks, and completely reused pre-existing APIs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6600aa4492ec..264afa0effb0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2770,6 +2770,60 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_=
dynptr *p,
>         return 0;
>  }
>
> +/**
> + * bpf_dynptr_copy() - Copy data from one dynptr to another.
> + * @dst_ptr: Destination dynptr - where data should be copied to
> + * @dst_off: Offset into the destination dynptr
> + * @src_ptr: Source dynptr - where data should be copied from
> + * @src_off: Offset into the source dynptr
> + * @size: Length of the data to copy from source to destination
> + *
> + * Copies data from source dynptr to destination dynptr
> + */
> +__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
> +                               struct bpf_dynptr *src_ptr, u32 src_off, =
u32 size)
> +{
> +       struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)dst_ptr=
;
> +       struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)src_ptr=
;
> +       void *src_slice, *dst_slice;
> +       char buf[256];
> +       u32 off;
> +
> +       src_slice =3D bpf_dynptr_slice(src_ptr, src_off, NULL, size);
> +       dst_slice =3D bpf_dynptr_slice_rdwr(dst_ptr, dst_off, NULL, size)=
;
> +
> +       if (src_slice && dst_slice) {
> +               memmove(dst_slice, src_slice, size);
> +               return 0;
> +       }
> +
> +       if (src_slice)
> +               return __bpf_dynptr_write(dst, dst_off, src_slice, size, =
0);
> +
> +       if (dst_slice)
> +               return __bpf_dynptr_read(dst_slice, size, src, src_off, 0=
);
> +
> +       if (bpf_dynptr_check_off_len(dst, dst_off, size) ||
> +           bpf_dynptr_check_off_len(src, src_off, size))


__bpf_dynptr_read() and __bpf_dynptr_write() do these checks, so
either it's unnecessary and we should keep all the sanity checking to
dynptr_{read,write}, OR we ensure __bpf_dynptr_read/write don't do
sanity checking every single time and we do full checking here, but
then we'll need to also check !dst->data ||
__bpf_dynptr_is_rdonly(dst)

I think for now, I'd keep all the sanity checking to read/write and
not over-optimize. So let's drop these checks?

pw-bot: cr

> +               return -E2BIG;
> +
> +       off =3D 0;
> +       while (off < size) {
> +               u32 chunk_sz =3D min_t(u32, sizeof(buf), size - off);
> +               int err =3D 0;

nit: unnecessary =3D 0 initialization, you are overwriting it immediately b=
elow


> +
> +               err =3D __bpf_dynptr_read(buf, chunk_sz, src, src_off + o=
ff, 0);
> +               if (err)
> +                       return err;
> +               err =3D __bpf_dynptr_write(dst, dst_off + off, buf, chunk=
_sz, 0);
> +               if (err)
> +                       return err;
> +
> +               off +=3D chunk_sz;
> +       }
> +       return 0;
> +}
> +
>  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>  {
>         return obj;
> @@ -3218,6 +3272,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> +BTF_ID_FLAGS(func, bpf_dynptr_copy)
>  #ifdef CONFIG_NET
>  BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
>  #endif
> --
> 2.48.1
>

