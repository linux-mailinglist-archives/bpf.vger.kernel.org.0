Return-Path: <bpf+bounces-39358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0100D972383
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13791F22776
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F518A6B1;
	Mon,  9 Sep 2024 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0DeMMUT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37783CF51;
	Mon,  9 Sep 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913049; cv=none; b=lB6dAOBszQqTjDgr17uPBI2kjOTht/ghhH0E04jiYd8aFzy9axC2x85sgviXVFDhY6ThnCTznrkXBkc4b4VNfAJTMKWzN/1pYOL/ist9AscCiAm0NZPGD/4aPPr4fsjejXxrWekw6IsjAmVr02gl3gr4ayWzgS5RB911RRnknvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913049; c=relaxed/simple;
	bh=hzfShMQccDc4LYR7FP2dJtytwGECHP5jAW8uCsotgbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMjVkuGjUtrnK0QWxlpz+N4tf5ntAN8gJ+gsb32s3kLl+rVfJgnIbtffKTec7t75Jxqb+VYsZoXaiIip7C6CiMYFWSiVjQ+shqwhvnO5N0KNfp5qGZ+czUojUzzDFMTDdufrXwWnwgljmLeDWuo4XcYtpZ7z/zJyz6cwn0T09h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0DeMMUT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2da4e84c198so3228230a91.0;
        Mon, 09 Sep 2024 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725913047; x=1726517847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3J/pOxBJfE44Fc1eGonfzqzJd/0X96Q4NPw3q0cYhY=;
        b=T0DeMMUTdwiKvHc4yDPOopcR/8PPOf//pu/3Y1zAAef8Kwpo/6dVnOefn1P65Gv+Ts
         cK2x1EK2AGA7L+EPakpuu8sQ3BIV6oT1xaBWbFZkBjUtj9EBi03TMGjYqup+1aMQ7GSW
         mPLbfH5Cep8WdV65MQXPB18XuKxiVqXwqhVYlGQArczt1WDe3FYh/img59q2s9BZMbGN
         y2kxrz3BtMB2vKPsCjIvf5lqEp0PIPwRzpD0grsEMJk969ifVVCreO1hrP6JP/1od0g3
         VZiQ061F0ekWHDqxnpMQwfQ6lWHHUEKHTev7qWxfvHBT95GO3k67T10LxQmlnxYkl3DW
         afVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725913047; x=1726517847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3J/pOxBJfE44Fc1eGonfzqzJd/0X96Q4NPw3q0cYhY=;
        b=pVl1qPEcyaAXefINqccpkvBLaMuP6lhbauY+KcKeDf6toIeBhinb+uOSn9r2Dhe4FV
         4cnt3UQnIo1+ABp6z2FMVTf7dsxlC2mpSL0wO8RN471e1u/eO7OxHgP1uzV5QEGIB4+o
         981/tQHwetZRbKhJCbcs8ErDMrFl0h07Iobc/gjIfonWyHKPOb4iRhCtjpMAgmd/10gg
         R/O2ZJmAlICPqFDP9qqUpP/ZMgo++0oDKbpwt51wdwUMglHmWTOxTBM/sAQLd/GXHWk4
         MT4x9q0nNJF3OPNMlzaF4XoYS8B9gLV/ZNLenmF5Ri+08Bf1eQ71yUJ2hCFpMKRgE91Q
         U9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCW8xITKx6h/IalDV5AJMOeZcIPnrcPVN5SlAsIoxieg/VBUoJzxbFPD3lriLpv47fzWTlyOmkQoGdNNRPBn@vger.kernel.org, AJvYcCXHIokq70STlBIzcENANBhGPxTMCOueO3N2t79zXJrHzgBFrIdgGY7Z4Vf6xMaLCXypslw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLmYZ9Tgq86+5EuxERkAgpqubdarcOZHgvGBpLM7K1QFcCyCnl
	+phiNCFlHMjYVtrE2kMOLnebDVZ1xy/bcDiPEQM+4KBJla/KXMs5t48MysJ3CFGyht3w4Oh/QfE
	8JwKsBtHL7kQzakIwznN+xHF+Zvo=
X-Google-Smtp-Source: AGHT+IEEqqi/v/1XOT4ozzVk6WxRuIh7KOl1QeQUBIOTbkc8W+9XVH6HJlozksCuqGRlB5Hx8a4EOIYYc+KSx/XgUAc=
X-Received: by 2002:a17:90b:4c4d:b0:2d8:adea:9940 with SMTP id
 98e67ed59e1d1-2daffa7d692mr9987611a91.16.1725913046869; Mon, 09 Sep 2024
 13:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909071346.1300093-1-chen.dylane@gmail.com> <20240909071346.1300093-2-chen.dylane@gmail.com>
In-Reply-To: <20240909071346.1300093-2-chen.dylane@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 13:17:14 -0700
Message-ID: <CAEf4BzacVxXwM7LaKu7Mj7toZuXc1+TF6-j-z+fZ85dXiUg0oA@mail.gmail.com>
Subject: Re: [v2 PATCH bpf-next 1/2] bpf: Check percpu map value size first
To: Tao Chen <chen.dylane@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hou Tao <houtao1@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jinke han <jinkehan@didiglobal.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:14=E2=80=AFAM Tao Chen <chen.dylane@gmail.com> wr=
ote:
>
> Percpu map is often used, but the map value size limit often ignored,
> like issue: https://github.com/iovisor/bcc/issues/2519. Actually,
> percpu map value size is bound by PCPU_MIN_UNIT_SIZE, so we
> can check the value size whether it exceeds PCPU_MIN_UNIT_SIZE first,
> like percpu map of local_storage. Maybe the error message seems clearer
> compared with "cannot allocate memory".
>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> Signed-off-by: jinke han <jinkehan@didiglobal.com>

names in SOB should be capitalized

the check is useful, so:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> ---
>  kernel/bpf/arraymap.c | 3 +++
>  kernel/bpf/hashtab.c  | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index a43e62e2a8bb..79660e3fca4c 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -73,6 +73,9 @@ int array_map_alloc_check(union bpf_attr *attr)
>         /* avoid overflow on round_up(map->value_size) */
>         if (attr->value_size > INT_MAX)
>                 return -E2BIG;
> +       /* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
> +       if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
> +               return -E2BIG;
>
>         return 0;
>  }
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 45c7195b65ba..b14b87463ee0 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -462,6 +462,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
>                  * kmalloc-able later in htab_map_update_elem()
>                  */
>                 return -E2BIG;
> +       /* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
> +       if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
> +               return -E2BIG;
>
>         return 0;
>  }
> --
> 2.25.1
>

