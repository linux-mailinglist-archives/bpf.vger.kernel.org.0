Return-Path: <bpf+bounces-63375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F41B068DC
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 23:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BD156507E
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 21:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D362C158D;
	Tue, 15 Jul 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFpYZhJI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B400262FD3;
	Tue, 15 Jul 2025 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616369; cv=none; b=UyOMG0Ltukih0oh8eNzVOiz/C75cs9sYasjHApy5OJGAxcso6bKIf4kmcEcN5rHhoIsdUtXs4KjLi3O7t/w5oyUBSvGJbW/qTxGn5mBzHY7aZXCwJ8CXKMxsUeXFGWrpYDCv0eEzs9hBac4Er6IpcXdWGEROVXjuZdchAN7jfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616369; c=relaxed/simple;
	bh=Ge/cctw+NXe1+MRq03rvs+wlvLtRg87qIQYx1yHumfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BU2sshgHAPB1aE5KX4rh4x/Zdyz8j0g/1qWu/Y5paO8WQOcStxnSlvpAAoM9cqAjDnykiCx5/Lnk+f7aXqjFM9ASUGpeq8txmGYxdEZ18mUuzw7leRMlsmOtMAg73wcdcbmdpk2R5AAFuABf+munBh1tpP2VrdoQpBIC2AuMjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFpYZhJI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3121aed2435so5081405a91.2;
        Tue, 15 Jul 2025 14:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752616368; x=1753221168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfFYPJTC0I1v1ZEhrPXUSN0MIdrTssECU7FDWoGrzhw=;
        b=WFpYZhJIHlx6FRE25hkdjGOLByDpkJPOt49cfxraowpUnLtTiFnKhvCb5oQLRcszKV
         z6jc2U4kAKEcSJM1S1SyKwfEjZLv/NGDk4VaUw9r15AL1GQDzeYSiVd5w4U919cM2JGR
         xwOYRLE6cqvykCm4NupoYzllv2pk1xaNTV7VHHH0pIXK3G43nao5GGDC2aXCgB/K+DYH
         yGwmzFs3dfcCL2D0c0lx/VnzBzhSbFq2NWb2t6Bd7q9j0kHZvPuLMMuRwXOeZfYfE5Zs
         JeKAFkATtTxUGu+bZI5Gvo+x1qP69hAt4Ds+v0ut3ScCeo3FO8KqevKPogmoNCeSUDYh
         Ea0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752616368; x=1753221168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfFYPJTC0I1v1ZEhrPXUSN0MIdrTssECU7FDWoGrzhw=;
        b=Wa1X8ix6+fbpUEQWqCJ3T6TbpfbQVADfoIKr4tYAElu8/ej+L5wZ9QKIKGVrzNyVJS
         2wJC5I3CX/Y14dMVTO7MY5qLw/meFd9cLnRKk8mflYP7RC7lLd4mqf1jQqPq4z64Io7L
         NTH5jRdj27QbpnqrKX/T5BdqP40ORT0DAcok2pxzpB5B5OoUWKSVgtwUZdHp6RcZAEtZ
         tPTu80oCqwayzr+hK/5zJcKnNW+lT+1NScsi3nb4tRz59y0UxZj8EvHkP8XnMNdjzBhY
         KRy/BGM1X/1iKCriK62fHQFIY/tHc4OTjq/pvqBHwEnhH5jlXOEBYkSzQ5tBec0PprHL
         tnTw==
X-Forwarded-Encrypted: i=1; AJvYcCUnClRmLUG8/D+usX3lR5bTbjTTdjGu4nzT2HjmJcoNJjSA+iRDAaQjAyHFtdUCJn98g/g=@vger.kernel.org, AJvYcCWA3Hvp3c8AIQEZ8VJBdrVAdravtRWOBZdOevQxL4i0nBpaVjYQIq2X0vI+Fb6ivbmyYUgXyd3CoN3BkZeH@vger.kernel.org
X-Gm-Message-State: AOJu0YyDWn2yiSFx3fIwaHppFEOe+a/6FwS+Lgvf2SAu43dKXmz+M3fY
	Kj2sDQaTII2vBLu8hWsf454R/RxKUITmAlt4ZgSUpf4CMqQy6Q7k4IPb9NhSernxzCBvhvQTfad
	xPuAdaB7ta7ThKyW47P9kjB+atgeAA8V/r6+m
X-Gm-Gg: ASbGncuPivcGTmYUUVi7MdY0K3viFZWY8V3kT3UG+6M31ymekoE8sjbl2DcAsBlYICx
	iIModtjU2tYICJXtFiKQCpTJUGIPdaT5SttNAmj168dwerjgtS5My7ldMLK0UlGLANih6lc7yC3
	J3cc7v1keMNi5j9GeSucG1BIQDGTdk+GgWl2V25Zp0Hf33ekBgLIr/XYGs+d/FE6gqmSUCBs4Nt
	BM89n2x9jHYkK8qIFHILg==
X-Google-Smtp-Source: AGHT+IGLRt+pcxVTGx2Sv86iRSPINzMc4fpbtNOZ5MIdOtjFqhJqLQEbfF9zdnI+mPaufujHK1TNLSvL8c4Bi0EqmcU=
X-Received: by 2002:a17:90b:37cb:b0:313:db0b:75db with SMTP id
 98e67ed59e1d1-31c9e7a37e3mr1255256a91.33.1752616367698; Tue, 15 Jul 2025
 14:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715035831.1094282-1-chen.dylane@linux.dev>
In-Reply-To: <20250715035831.1094282-1-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Jul 2025 14:52:33 -0700
X-Gm-Features: Ac12FXxzcMpTVI7-7wHM4I_AMczS5O3LtpJrT0mJQh0coskkQkxHbQmHhi3yApY
Message-ID: <CAEf4BzbkfhqfpBt49h7SXYwbR1SK423pqf1328i8XujofjLYhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add struct bpf_token_info
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, willemb@google.com, 
	kerneljasonxing@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 8:59=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> The 'commit 35f96de04127 ("bpf: Introduce BPF token object")' added
> BPF token as a new kind of BPF kernel object. And BPF_OBJ_GET_INFO_BY_FD
> already used to get BPF object info, so we can also get token info with
> this cmd.
> One usage scenario, when program runs failed with token, because of
> the permission failure, we can report what BPF token is allowing with
> this API for debugging.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  include/linux/bpf.h            | 11 +++++++++++
>  include/uapi/linux/bpf.h       |  8 ++++++++
>  kernel/bpf/syscall.c           | 18 ++++++++++++++++++
>  kernel/bpf/token.c             | 28 +++++++++++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h |  8 ++++++++
>  5 files changed, 72 insertions(+), 1 deletion(-)
>

LGTM, but see a nit below and in selftest patch

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

>
> +int bpf_token_get_info_by_fd(struct bpf_token *token,
> +                            const union bpf_attr *attr,
> +                            union bpf_attr __user *uattr)
> +{
> +       struct bpf_token_info __user *uinfo;
> +       struct bpf_token_info info;
> +       u32 info_copy, uinfo_len;
> +
> +       uinfo =3D u64_to_user_ptr(attr->info.info);
> +       uinfo_len =3D attr->info.info_len;
> +
> +       info_copy =3D min_t(u32, uinfo_len, sizeof(info));

you don't use info_len past this point, so just reassign it instead of
adding another variable (info_copy); seems like some other
get_info_by_fd functions use the same approach

> +       memset(&info, 0, sizeof(info));
> +
> +       info.allowed_cmds =3D token->allowed_cmds;
> +       info.allowed_maps =3D token->allowed_maps;
> +       info.allowed_progs =3D token->allowed_progs;
> +       info.allowed_attachs =3D token->allowed_attachs;
> +
> +       if (copy_to_user(uinfo, &info, info_copy) ||
> +           put_user(info_copy, &uattr->info.info_len))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +

[...]

