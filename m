Return-Path: <bpf+bounces-30978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 403798D5493
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 23:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B651F22EB8
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 21:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A922F180A92;
	Thu, 30 May 2024 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LawltbIm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82161F947
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717104068; cv=none; b=u4YWXsPsQ7JBQlZIM+qwFRcYhnlSrCIhEFJYXAHqmfSyGdtAWQu47JZmrK12gbJvtTmc5/atAzsfkI4zGSqPQSCiXVa8D6iK+CqVzdhMuJWS+3oaB/BvZAzlahyHxv4KQdUjdYN/O10CyC/4ndroRsDfHW+dQkGpDG8hV2rHDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717104068; c=relaxed/simple;
	bh=9eIsy8KqZDJ/+dkWYYzKA/nCOdkkR8tucLJsEdL4Ajo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jhg1YHXIZOt2YI2RRaKgJxF8CUIm4eqxxlYyF0cpdd3DtepRpml5gytkYx6o6pyRZYSbiEeGv0BBiIX/5EjfVB+hCmmPxjWee7zhlTaNd6hclIGCJPM3L35v7H3WwH0g9D1WzqSww4+Zln0LWCchi92qcKfDycZOuc45bF9RnVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LawltbIm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4a0050b9aso2860985ad.2
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717104066; x=1717708866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5mX7dbpLdBnxxRMK2BDYdahGqj8NwahDj3fDJNis1k=;
        b=LawltbIm+WDgFXmPenZQ0yIVNc74MDwYbesGGHFAEW5G8GXlHFET1cl1rf9y51uYXB
         uRLE0oSp6ZqpxpkJkXjsWXQs6iHi9qjY7XHFnw3PICzopJORVyUqPE/Pw/rr2TWRQcOZ
         IBAizcQHEaldtYIrxqrBdSiZxuhygEGZXY9c756i33F21eppFFqz/d/KJq6cz0S668nl
         hzwvL1rIWSmE13hGtzJHPD/y9uoO4MC3HZsjs3JXex6UF3URUSRx5eJuN/SA6WnCs48W
         FilB+/0kRNVfNFb2BZEng/PE2fOFyiE5vSQVRZ58N5llzZb2Gz54ranxJFYGNS8rYk+c
         /LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717104066; x=1717708866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5mX7dbpLdBnxxRMK2BDYdahGqj8NwahDj3fDJNis1k=;
        b=X8w+V27yDURFPyuHIaShteNGBBKSO4TaFY8aDtGVTH8f1TYGqS1FhR+wtc8PrwkGG2
         tpHKr9iJxB4cplt6LuRHLFNHNaK3L8xmLM/HpjirQr4fHlga8FaGO79Ab8oH9T20T4D4
         UMEgjcSiF1T1T5pkSuiqGooeyncsalJHdvDpmj6m48iV0V/kEvVQ1/6Zk+f0NkIvYKww
         9FTGtcY19tDp5HlfUw+NjnQPT6P15ONE3FlPMs3Xhrsw5AzpgOtW0Fnr/+EoRnNcK2fW
         HIv/GCFnAfFdQk3J9C4LitGwju78tciBqklrGQ5TKbO/RPZDS0gPde27MGboKZnSXf1P
         GdTw==
X-Gm-Message-State: AOJu0YyK3uANcu28Er0/qAUiei/y56RQoWdYrXvAjrkbhOb2F863HVjl
	vAMmuYNeUA29L/vqUGAcvcc3WMHEhJRTxgL3QcOeUUvlLvaTtE4D8Y7jxaAhIedp48qyn4SjAZE
	8Hv0Y3zuCfpog2l9Mq3T3nbcvnWWnaUwg
X-Google-Smtp-Source: AGHT+IGct0Njj8z1oQQq94fpTjsqF9OEnrhx+eaoX37CnC2Kvq4hgrhMmMYCZ/jC51AnadZoUlO0X2paGmzCfqX77I0=
X-Received: by 2002:a17:90a:da03:b0:2bd:ef6f:5c91 with SMTP id
 98e67ed59e1d1-2c1abc4e18bmr2846472a91.45.1717104065959; Thu, 30 May 2024
 14:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529131028.41200-1-tadakentaso@gmail.com>
In-Reply-To: <20240529131028.41200-1-tadakentaso@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 May 2024 14:20:53 -0700
Message-ID: <CAEf4Bzbt4FMqAOioJYZpuYDrtiFiT+STMqs_Z8ZhTNLD3AZxzg@mail.gmail.com>
Subject: Re: [PATCH] bpftool: Query only cgroup-related attach types
To: Kenta Tada <tadakentaso@gmail.com>
Cc: bpf@vger.kernel.org, qmo@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 6:10=E2=80=AFAM Kenta Tada <tadakentaso@gmail.com> =
wrote:
>
> When CONFIG_NETKIT=3Dy,
> bpftool-cgroup shows error even if the cgroup's path is correct:
>
> $ bpftool cgroup tree /sys/fs/cgroup
> CgroupPath
> ID       AttachType      AttachFlags     Name
> Error: can't query bpf programs attached to /sys/fs/cgroup: No such devic=
e or address
>
> From strace and kernel tracing, I found netkit returned ENXIO and this co=
mmand failed.
> I think this AttachType(BPF_NETKIT_PRIMARY) is not relevant to cgroup.
>
> bpftool-cgroup should query just only cgroup-related attach types.
>
> Signed-off-by: Kenta Tada <tadakentaso@gmail.com>
> ---
>  tools/bpf/bpftool/cgroup.c | 47 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index af6898c0f388..bb2703aa4756 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -19,6 +19,39 @@
>
>  #include "main.h"
>
> +static const bool cgroup_attach_types[] =3D {
> +       [BPF_CGROUP_INET_INGRESS] =3D true,
> +       [BPF_CGROUP_INET_EGRESS] =3D true,
> +       [BPF_CGROUP_INET_SOCK_CREATE] =3D true,
> +       [BPF_CGROUP_INET_SOCK_RELEASE] =3D true,
> +       [BPF_CGROUP_INET4_BIND] =3D true,
> +       [BPF_CGROUP_INET6_BIND] =3D true,
> +       [BPF_CGROUP_INET4_POST_BIND] =3D true,
> +       [BPF_CGROUP_INET6_POST_BIND] =3D true,
> +       [BPF_CGROUP_INET4_CONNECT] =3D true,
> +       [BPF_CGROUP_INET6_CONNECT] =3D true,
> +       [BPF_CGROUP_UNIX_CONNECT] =3D true,
> +       [BPF_CGROUP_INET4_GETPEERNAME] =3D true,
> +       [BPF_CGROUP_INET6_GETPEERNAME] =3D true,
> +       [BPF_CGROUP_UNIX_GETPEERNAME] =3D true,
> +       [BPF_CGROUP_INET4_GETSOCKNAME] =3D true,
> +       [BPF_CGROUP_INET6_GETSOCKNAME] =3D true,
> +       [BPF_CGROUP_UNIX_GETSOCKNAME] =3D true,
> +       [BPF_CGROUP_UDP4_SENDMSG] =3D true,
> +       [BPF_CGROUP_UDP6_SENDMSG] =3D true,
> +       [BPF_CGROUP_UNIX_SENDMSG] =3D true,
> +       [BPF_CGROUP_UDP4_RECVMSG] =3D true,
> +       [BPF_CGROUP_UDP6_RECVMSG] =3D true,
> +       [BPF_CGROUP_UNIX_RECVMSG] =3D true,
> +       [BPF_CGROUP_SOCK_OPS] =3D true,
> +       [BPF_CGROUP_DEVICE] =3D true,
> +       [BPF_CGROUP_SYSCTL] =3D true,
> +       [BPF_CGROUP_GETSOCKOPT] =3D true,
> +       [BPF_CGROUP_SETSOCKOPT] =3D true,
> +       [BPF_LSM_CGROUP] =3D true,
> +       [__MAX_BPF_ATTACH_TYPE] =3D false,
> +};
> +
>  #define HELP_SPEC_ATTACH_FLAGS                                         \
>         "ATTACH_FLAGS :=3D { multi | override }"
>
> @@ -187,14 +220,16 @@ static int cgroup_has_attached_progs(int cgroup_fd)
>         bool no_prog =3D true;
>
>         for (type =3D 0; type < __MAX_BPF_ATTACH_TYPE; type++) {

instead of iterating over all possible attach types and then checking
if attach type is cgroup-related, why not have an array of just cgroup
attach types and iterate it directly?

pw-bot: cr


> -               int count =3D count_attached_bpf_progs(cgroup_fd, type);
> +               if (cgroup_attach_types[type]) {
> +                       int count =3D count_attached_bpf_progs(cgroup_fd,=
 type);
>
> -               if (count < 0 && errno !=3D EINVAL)
> -                       return -1;
> +                       if (count < 0 && errno !=3D EINVAL)
> +                               return -1;
>
> -               if (count > 0) {
> -                       no_prog =3D false;
> -                       break;
> +                       if (count > 0) {
> +                               no_prog =3D false;
> +                               break;
> +                       }
>                 }
>         }
>
> --
> 2.43.0
>

