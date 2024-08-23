Return-Path: <bpf+bounces-37909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C10995C228
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 02:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D99284E39
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 00:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B77538A;
	Fri, 23 Aug 2024 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaZoedF5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96F4A01
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372134; cv=none; b=DsVKerV5Jls9tbRM0KHddc+5IhqBueES6B+YD5qXC4cD4a9+a2WitibAanDGOPbddH3BAvcskrbrtadoDCHC2ADp3ppw1A36MZuE4Y4kXfwAwdbo7tF4CLgIoxitSdRI4d9bnQYzCd3n3E4PrvurUW2wak236KXzieSEtrHBf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372134; c=relaxed/simple;
	bh=CIIKZFEp3t2Uv5iQlqhkbCqzkwM3ze/4kyexvONpFZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3oXx3ZBHXlPf3KoSKV1Ug6Q5/KfhkmICpqjLt4EPYtvt8ipSBNl2brVIWiai9AfZ9gcyx/IapmYG12B99pD9SQNYfXjy0atdJOtVgH7e7n9SOJjev26///ADjSzSFfN45YkIo5TNv9QvjvQglLCiT8MY/Tx1xykvQjsfx+OXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaZoedF5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42812945633so9970005e9.0
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 17:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724372131; x=1724976931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2ESHBtrAuffrLQVHXovzucaSmYe1GjZnrnLmTFKZ88=;
        b=GaZoedF5OOXZoqs0FtRV48ethf9oSLChjxIzPMZJjWbO5rtQa3Thz9g7D7dnxQhxfd
         0UgRRDOHZLCJqAq9dFwpgpIHlELSPE0KOG1WWJQOr9JVQB+4cV9a7A8LjGqafm3j+POG
         ZM7l7Ku/o5+5G8IAMFdI0hSsb2yEPgy1MxPsin6uigDZrT/YPJlAm5XU310mZTjH8a/k
         bb0u8cOywz6b/4EHE9Q662I2Txt/1K2498bxegGibGpoxaROrhh3PRS6VojTXJIFa5u8
         Chwf1LSK407+9SM3heHUODTCzGL0s2gF717h5VapE+ex3KMdi8iT7RgaMMHf3P6koSVr
         V53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724372131; x=1724976931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2ESHBtrAuffrLQVHXovzucaSmYe1GjZnrnLmTFKZ88=;
        b=svmpREB6wOCMiIxgpfA49FugXxPgWR+hj9WxBogcUGrYy+H3rm6BxaDhZ6cd20g3Db
         nSIBwlt6wgRSgIFMJ3H+ptjlYYad5f++z+DX7xY5lJbi6dNo/oBKjF/ZWDnnWaoag7Wh
         +xnD6HzydUdaeUbe7KnwgJy3Iky1nFEat3iYIwTro+Dz4Gh4FFc5oYFKhVTRNJNX0u6f
         29rWS9kD5JjU2bn7hsd8s9cOOn+svmgJjx6/u50cykC9u8ZsGdJUFjTJ91rp/nVZ2vgz
         D3xEot362Rs79FbKhxdRi2C+Lk2xT7oYpWrf2hqafsetVmW9MbbQGmmlgIKfFeg7NLQX
         pJtw==
X-Gm-Message-State: AOJu0YzNspq4wsOAhDNHmadoH7f/kc11+8Fn8isNXRfvCwI8p3F1jHdG
	lUbhF/TbUOlVXGGKswibxCw3mhrGgJorNeglYEG70EDmkZVeLpP99kwRcAdZiE+goF9LSg5UiPH
	PiQVPl15i+lkVNLUdF98ooHB1vtDsB1LQ
X-Google-Smtp-Source: AGHT+IEFH2UnKZDgKtb+HajkSo5MOMCYWQDgehOlERFg952MkvzWmFt7UqNVhboWntl8Ko0WI/uOvvY2gWc0pzgzYFU=
X-Received: by 2002:a5d:6591:0:b0:371:8c06:82ea with SMTP id
 ffacd0b85a97d-37311840eb5mr196581f8f.1.1724372131268; Thu, 22 Aug 2024
 17:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823000552.2771166-1-linux@jordanrome.com>
In-Reply-To: <20240823000552.2771166-1-linux@jordanrome.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Aug 2024 17:15:19 -0700
Message-ID: <CAADnVQKW0HepVOqjCeiDVAMfz-Yj0OYaNGiYJXJy5_JE3GVu5w@mail.gmail.com>
Subject: Re: [bpf-next v8 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:06=E2=80=AFPM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> +/**
> + * bpf_copy_from_user_str() - Copy a string from an unsafe user address
> + * @dst:             Destination address, in kernel space.  This buffer =
must be at
> + *                   least @dst__szk bytes long.
> + * @dst__szk:        Maximum number of bytes to copy, including the trai=
ling NUL.
> + * @unsafe_ptr__ign: Source address, in user space.
> + * @flags:           The only supported flag is BPF_F_PAD_ZEROS
> + *
> + * Copies a NUL-terminated string from userspace to BPF space. If user s=
tring is
> + * too long this will still ensure zero termination in the dst buffer un=
less
> + * buffer size is 0.
> + *
> + * If BPF_F_PAD_ZEROS flag is set, memset the tail of @dst to 0 on succe=
ss and
> + * memset all of @dst on failure.
> + */
> +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const vo=
id __user *unsafe_ptr__ign, u64 flags)

Did you miss my previous comment re __szk vs __sz ?

> +enum {
> +       BPF_F_PAD_ZEROS =3D (1ULL << 0),
> +};

Pls give enum a name, so it's easier for CORE logic to detect the
presence of this feature in the kernel.

