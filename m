Return-Path: <bpf+bounces-49893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EE6A20089
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CE816226A
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD451DB122;
	Mon, 27 Jan 2025 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPev0QIO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E4C1D88DB
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738016846; cv=none; b=OdMbmyCHyvLC0gDtSS0LZKT04NuXFz2lhjAVxZimtCgvorjqZXR4JvriY/Mv/AT8vxxMujUrNGSdRbrhZ/8QI5r1fCmbdZYV3fvZoB2WW/p4amz65ZhhhqrY9yje1mQK9LqVNFt+XfAOyNtpGDBQW0agoIoWSZXXFwK+9t1wF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738016846; c=relaxed/simple;
	bh=y3wTT1UySivtV2KOvJxdGpQCByX6sYuwX+Ftgfmw8t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4TTOjXbHlwZHfRURUr6RrCM/WlSWfIeY8RHD1Hhtsz/gkOhwfi654mcqeuece3zQ99VmbuScu2YwqEgNRScn0hMoDcBc2gN0AwGyJCsA5sYuoikTuSZMTz9Yc2ARO05OaNM2FAO1gxVhGoOKWJbkkzVFKIq2XbO1NDvtwPww1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPev0QIO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so3039622f8f.0
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 14:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738016843; x=1738621643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWHMGMmf83sdyJBsVnxonDtOjI7Hl8K15GchNrxkfUs=;
        b=YPev0QIOtuPRiIe8+OpOqYvNUDmFdx9SLY0C+j8S80YpZNNg+z8fwmGghH0TrK9O9U
         LBh1De9cmJXzzkimSnhtNmci+aQMN5ejXa14xIo52+rciuOXPJ6T/TgrnI8glQ+UrXeq
         unUcrBCeebzU12W/Vt0hbmyxferIhoS7+0FY9K9xfWVUsDJQnkUIqTL3xx63ml4CEGJw
         XaPeBEEKiudgQZeHmD89cik0gk1oZ51UQ3xFQfMi9Otp31Ps8Y2AiDC7y46Bcjx5aRvb
         QwdyVWLEZb4r6wxhS78hA/uSgYALQqmLMP9xj1BEERllYmZAcxUaOG6zAxndxVtVKiiL
         YViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738016843; x=1738621643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWHMGMmf83sdyJBsVnxonDtOjI7Hl8K15GchNrxkfUs=;
        b=dr2lt8I1YxhtBw6EdFWkB2DRBMWpqgQ1ortClyo0r8OQe1xHVHit5qOwasyegKWhpb
         bP1HX5HyABMqFHkz+ExYaZDwlAa+Yu71OMJkicDVpTiSX1UFO3SmfpNBqorq+2dQI0Uv
         On1l4RB4P4HyK7p5bClymbw5vLeleqG6eXlnoyKL/0+Y5uq0D4xDcszO7af01v1rmC8n
         lGLUg3O2apeWEN+j9dZl30iloTUFMjysZdMP0GHA/6sqs77rDF0pYS6JK0vvzJmkC1gy
         I9yW5IuYF7yJPMSMIahSrrZKqVNOgfSFudah3HqmfvTV2OoPE/a+6cRR0AUn19CYl48d
         dciA==
X-Gm-Message-State: AOJu0YyZhkRlSzaEiagTYZzVRBEQKYR3z9uQTqBIkAVThPtVUh6ffxjV
	k/Zg0ic5ys9KsP2ITOBqnw2w8idMEVcJ+Jgfetc7yRtq346JdWgsaBrFNmdQLMIxnb142sh94/2
	7K152Of52/dfrhZEPZcjoPgtxwVs3i67J
X-Gm-Gg: ASbGncsyYX/k/c1Kghkbjn2+QYNKOwg3cdQqceBUVOo5c7lVzProVnGJZdedTTo6lIp
	IiPH4H6i+GBCCJ7RjMSarYcCpcqtJcb6ghn4QIZ2/AeZO6PwyM/S/+wGSnhY93MArwB4QDRdWun
	niUz5NnX/OB4Q+HfH3Jw==
X-Google-Smtp-Source: AGHT+IFAyJN1Xtih+8Qv5N+FBNQk0P+kWhdrcLbBUtXbNooF7/pjqiuiaqljfC6Ak57JjbgYjorTYioTbVVUWCjcS7o=
X-Received: by 2002:a05:6000:2c8:b0:38b:f3f4:5812 with SMTP id
 ffacd0b85a97d-38c49a536d2mr861158f8f.21.1738016842710; Mon, 27 Jan 2025
 14:27:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124195600.3220170-1-andrii@kernel.org>
In-Reply-To: <20250124195600.3220170-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Jan 2025 14:27:11 -0800
X-Gm-Features: AWEUYZm3T4rTsHEXVBHWp2huBTxjeO0aEyTEa1atpzAghu-KgRWwuSneSnGPbBM
Message-ID: <CAADnVQJ-QiXv6FA0n6N9+2z4sxksg2HSdzyS2z00CCqP3CbfGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: avoid holding freeze_mutex during mmap operation
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, 
	syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 11:56=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> We use map->freeze_mutex to prevent races between map_freeze() and
> memory mapping BPF map contents with writable permissions. The way we
> naively do this means we'll hold freeze_mutex for entire duration of all
> the mm and VMA manipulations, which is completely unnecessary. This can
> potentially also lead to deadlocks, as reported by syzbot in [0].
>
> So, instead, hold freeze_mutex only during writeability checks, bump
> (proactively) "write active" count for the map, unlock the mutex and
> proceed with mmap logic. And only if something went wrong during mmap
> logic, then undo that "write active" counter increment.
>
> Note, instead of checking VM_MAYWRITE we check VM_WRITE before and after
> mmaping, because we also have a logic that unsets VM_MAYWRITE
> forcefully, if VM_WRITE is not set. So VM_MAYWRITE could be set early on
> for read-only mmaping, but it won't be afterwards. VM_WRITE is
> a consistent way to detect writable mmaping in our implementation.

bpf_map_mmap_open/bpf_map_mmap_close use VM_MAYWRITE,

Do they need to change as well?

>   [0] https://lore.kernel.org/bpf/678dcbc9.050a0220.303755.0066.GAE@googl=
e.com/
>
> Fixes: fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY")
> Reported-by: syzbot+4dc041c686b7c816a71e@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/syscall.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0daf098e3207..0d5b39e99770 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1035,7 +1035,7 @@ static const struct vm_operations_struct bpf_map_de=
fault_vmops =3D {
>  static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>         struct bpf_map *map =3D filp->private_data;
> -       int err;
> +       int err =3D 0;
>
>         if (!map->ops->map_mmap || !IS_ERR_OR_NULL(map->record))
>                 return -ENOTSUPP;
> @@ -1059,7 +1059,12 @@ static int bpf_map_mmap(struct file *filp, struct =
vm_area_struct *vma)
>                         err =3D -EACCES;
>                         goto out;
>                 }
> +               bpf_map_write_active_inc(map);
>         }
> +out:
> +       mutex_unlock(&map->freeze_mutex);
> +       if (err)
> +               return err;
>
>         /* set default open/close callbacks */
>         vma->vm_ops =3D &bpf_map_default_vmops;
> @@ -1070,13 +1075,14 @@ static int bpf_map_mmap(struct file *filp, struct=
 vm_area_struct *vma)
>                 vm_flags_clear(vma, VM_MAYWRITE);
>
>         err =3D map->ops->map_mmap(map, vma);
> -       if (err)
> -               goto out;
> +       if (err) {
> +               if (vma->vm_flags & VM_WRITE) {
> +                       mutex_lock(&map->freeze_mutex);
> +                       bpf_map_write_active_dec(map);
> +                       mutex_unlock(&map->freeze_mutex);

Extra lock/unlock looks unnecessary.

This functiona and map_freeze() need to see frozen and write_active coheren=
t,
but write_active_dec looks like without mutex.
It's atomic64_dec.

