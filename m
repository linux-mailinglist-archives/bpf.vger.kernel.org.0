Return-Path: <bpf+bounces-45551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8F29D792C
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 00:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1415D162EBD
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B318B484;
	Sun, 24 Nov 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G96337Wc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7C188704;
	Sun, 24 Nov 2024 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732491918; cv=none; b=qr/dN7sagniggNhYZG94ncMmEwq3yUqas7C2jpAg2rCNRz2NgZds+pk6xvgeTRe1/5ZPqnOyU8ITeti60Ziem4eNWk7l4m6B4a6HFw6E5P9yXyTghdxZFcvdcE2geIDc/XGZ1yqHjdgmFeldb7p29Rq5RoSLykNtQizqdeDistQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732491918; c=relaxed/simple;
	bh=DhQYv3h1vmFWAOcdoccCc8+IlIkNIPvU3AQtRViaYic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FifuGxFhIhWfTdHF0YqmuyoHrv4G0xZeB/k7t06NBovVQduSr1vVkZJUxCERXAzHt7Rl7LXD9oWx+SJB0mJo+9FewWaiidD32rPyBN5f4m+1vi2jAAtosQ/4WvlfTOj5+C2Br/vtANIwTb3Sv8dBLVicLB6lBTbad+n1jJpaKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G96337Wc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so33989045e9.1;
        Sun, 24 Nov 2024 15:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732491915; x=1733096715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD3mihCwNWFtiQ3u7MQvI/RPQE5lnct8KZkJL7efwOU=;
        b=G96337WcIODA7we5ZXMoSFincaYFnnp03DBWezwKMlY+KMD0gOF9w+YgwvNWb/wwTN
         18Rn/XU00pr0L21BUwUzb1Uzrh31WedLSfGJ1ZwzIic+dRtxVfnNwggzIkb7qDH380T6
         js/C2YoYiYrJgDCbesO+iM1mxgTsYDasoanaHsSPJYggDnb/L2ZYElx3MpjJCHcJWca8
         1FDpYJxO1xZM18yC7isVJq08gFMYWzt2fTMlY2YFVcRKYLCRnBTAbSYGyrMfUDq3FaTU
         k2EtJCP8/ZqFzilfRLUKTZJQm2ZzcHoJkenb6NgbGZd68vbWA93HM/MOVevAKBKJPrXk
         AGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732491915; x=1733096715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zD3mihCwNWFtiQ3u7MQvI/RPQE5lnct8KZkJL7efwOU=;
        b=X/Gm7wVRFt+05Egt04IDW+k98ZM6IxknJ1oWHduBBYh+V680G+BnO2m6jhmtYMtN0T
         sPrt3FAotua9TlZokVrwOuFQGx+PobCYMxZUaxjW0jPou8UFd7kmagdn8JRA2EozbzP3
         7uiECC/BBqktXy3u5XnY0gmM14luJwR5cWvilD1Glfb65P2dW+xSmkHxwhpkucXuevMj
         xn1gnESc2UNq+QuT2LU/TUi6rCyPZJbwHEcWS+o2AXpsgS/SPDhIzQyhku/kuLiYp7k6
         17D0j3/yF+AqEI50iWrwo99C+eU4Nq1U5QtF/B8TfkfPuw2UDc5JOISU8RqubqD6aaIp
         phjA==
X-Forwarded-Encrypted: i=1; AJvYcCUjYvIbk7vcLZn7XWz11AkHSJXXDHeOLO787OLNkHi+D8y4VEb8Aqw+ACAYwgLaAnpVebPhJA==@vger.kernel.org, AJvYcCVybf2qI2tnUUIb9isgCz987wvzbo9ouB5ab3JRSamxntBsIqWQcjX57UT1nvFFAOrRE+1A@vger.kernel.org, AJvYcCXFlQByAmho+PtCo+zPhqQTwz10zlcyYsf1jicKh/gx6zNGntYNZDCeVMgVQjxIehdMib6K1dK2CA==@vger.kernel.org, AJvYcCXdichBKzTRThNSh9YUSCQPtzD5CrXKJvbZW9PRtKCTVGav3On6hu3WLi94HejHryGegVJn4gZoIWgX7mQb@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZv28dcxW3qdwlUbzfUHFhWfSDm7SSS21hF3UynadR9CAz1pC
	MZNJY6Edb0vogvq78B/NOdGrK9GrdYWU+eHxqcFcQFwEdIHGgTvaEcKFf1TBUUQ0Gqay8mgxR+9
	b3Q1WaSvIv4vflHUD/YLEeJ2Bz5k=
X-Gm-Gg: ASbGncsRB0L5jlpV1jFuuXGX+Vm0phvLGpZ6uNv8+B70Ez9Rt7k1996w8V0G4BIHDDp
	rK0iOuMFReC5VX572W6L5bKKba/E6XP3JZixr/4P9jbLd8oQ=
X-Google-Smtp-Source: AGHT+IHXlo3psjhvmLC59iyJ2c2Irteph+vRZzZG4ccEzhBOzIj3D+JFCvQT0yaAVuqpjY9v84dOi8gINPCKWjefaRU=
X-Received: by 2002:a5d:64cc:0:b0:382:4bdc:2be2 with SMTP id
 ffacd0b85a97d-38260bce4c8mr8219911f8f.40.1732491915212; Sun, 24 Nov 2024
 15:45:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net>
In-Reply-To: <20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Nov 2024 15:45:04 -0800
Message-ID: <CAADnVQ++-VwPnem-xY+Urec0=zi71s-Pmzox+TXYgaVpshHtEA@mail.gmail.com>
Subject: Re: [PATCH] bpf, lsm: Fix getlsmprop hooks BTF IDs
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, audit@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 2:19=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> The hooks got renamed, adapt the BTF IDs.
> Fixes the following build warning:
>
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol bpf_lsm_task_getsecid_obj
> WARN: resolve_btfids: unresolved symbol bpf_lsm_current_getsecid_subj
>
> Fixes: 37f670aacd48 ("lsm: use lsm_prop in security_current_getsecid")
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  kernel/bpf/bpf_lsm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 3bc61628ab251e05d7837eb27dabc3b62bcc4783..5be76572ab2e8a0c6e18a81f9=
e4c14812a11aad2 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -375,8 +375,8 @@ BTF_ID(func, bpf_lsm_socket_socketpair)
>
>  BTF_ID(func, bpf_lsm_syslog)
>  BTF_ID(func, bpf_lsm_task_alloc)
> -BTF_ID(func, bpf_lsm_current_getsecid_subj)
> -BTF_ID(func, bpf_lsm_task_getsecid_obj)
> +BTF_ID(func, bpf_lsm_current_getlsmprop_subj)
> +BTF_ID(func, bpf_lsm_task_getlsmprop_obj)

Maybe we can remove these two instead?
I couldn't come up with a reason for bpf_lsm to attach to these two.

