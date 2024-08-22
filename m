Return-Path: <bpf+bounces-37874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DA095BB46
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 18:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C8A0B26D95
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172D1CCB5E;
	Thu, 22 Aug 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlfSPj6m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E0017A588;
	Thu, 22 Aug 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342450; cv=none; b=aoelBzdaOFT0wyyJKROV4M+KioaddfM/k4gZSHZ6WqnM07fHeXnWY6s18F7qpOsCcIwf5g91Q+SCPWnxYb/6mq6wZwBykZmFOtgCDluEvdkBlxp/LiM4jrEd0JSAId/npSYIdtndmyWGdNOo+haIyGZX/ykD3Q2C1jbDeFDDEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342450; c=relaxed/simple;
	bh=JCMQfdJHpgTileMU5Pyj2yL23LrjoTvDzUqYGZBfIv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQYtauc2Mfbsr1r04W1KOy29171xGbre1gIfM1nWZrbxOm5Ya1/VkFoxNn+gYS7wz/bYiT15g+yVSXdHuupPw+PfroJ0wLdhQjjiSNj9q1ahhvIAnurG8i6i/nkL3mE5RU+Y/sQYkc5WVKvOzRBUHfzDnqz8pOxwx+woIqCRFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlfSPj6m; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42816ca797fso7617795e9.2;
        Thu, 22 Aug 2024 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724342447; x=1724947247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCbWOITMko0wEoeUzzqieqzDXgm1IIaSCqGTrIEvCj0=;
        b=DlfSPj6mM3ugXfwxbyGAZWSmVeV5YnWk1/csvyKwVAe1Fl/zg0LPMqoPXt1YgVXSqg
         f1s0ShRz7igLuhtIIaZEiBhHpc7MMzQW+RHd3wJD9EHPWBHTP5z1kt+5vF4vzumvORuW
         IDyR53yNxT8uVi3bkr+9P9hbgaUacCt65LpHZrEq94b5Ud/hW6WWA/PslX9VsGYgCxM9
         M9ba+xOiRUKkuTuIHgbYs3zWMoE9LYBUcAXWJoScB7flb1dRWDgMtbu9+zbde7+iezTo
         JY6AaAo76cAVlLyzcF4wpIBQsnxaxOtU5wb5yxVHVFkO0Y0lXJ0sGXdC+u4hYCXdIBr+
         VLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724342447; x=1724947247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCbWOITMko0wEoeUzzqieqzDXgm1IIaSCqGTrIEvCj0=;
        b=Mvp0T+1qcESS/8v40ItPhXfPz9xXJQ5jIUJ9sUhWbTdl1vtSyGpgUeppuKmZe0I4jn
         R14g3aJEJL7QIW14DR3XVlQ7rQVdm8HksUmT4EOs8R1WQGMG+8p5pyg6dQcrUF47c7fH
         g3yZPeG+12ZRu7msvfoe1clMQuooDI7Qw4ickqDnNmSaW4q6vyFqlrkk6mKX//I/TVzG
         0gHAj4BPI4QBCa8QKt539VRqqdxzEHuAQ/mvIYfyvuva1Y+kECsCKTDRu6Rpv3oW8cKs
         qqvUOORRFmNB901jlBpQGVaLRFTzIkFctBFB49sIWIcxkwo/9u84zzY4Hcdalo2Y1Tpb
         tZFg==
X-Forwarded-Encrypted: i=1; AJvYcCW+V6DyMeTv/274Hf6TORMGDbHwD2xSImhmFDSPm81YK9lunlB2rGA4wJs59ZOfCDIYbIqqoMJRfDUzIaLs@vger.kernel.org, AJvYcCW6+Kcs0mxv2ymIofs91miOYe/D5zEHkaSTp8zCa3Eb4oN4nmC7kMBm7E21fUXDTu9JPiE=@vger.kernel.org, AJvYcCXJiaEzOQdbcgSHLT2G6pWq9EnUUBGRImSW7Jfq6yEfrnaNwp9Qxk1Sc1rlBMUACHCt5yADkFcN@vger.kernel.org
X-Gm-Message-State: AOJu0YxBs6nYu1YtB2Rl23P2NBFFVSNLOD9RfxWbR3W+B1N3qKRJd2oZ
	Iki2j+UMeDCbrwB9qa4ZW7FLxHrXIzypyzKEkRlpNgRRBcZWHRu2183ypoFU0CoZHuhVwpCprlI
	pU9EOike0+xm4N2hDIPQ7no51aOA=
X-Google-Smtp-Source: AGHT+IHcNIR54GEsYVfVx+0ed5NoDx9ZmcggKZXL1hughSPoIlUuhTZHJILgoDg7E/MKuN45stdeDEAckEYHAP13rM8=
X-Received: by 2002:a05:600c:3b1e:b0:427:fa39:b0db with SMTP id
 5b1f17b1804b1-42abd245821mr39428145e9.27.1724342446903; Thu, 22 Aug 2024
 09:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821093016.2533-1-Tze-nan.Wu@mediatek.com>
 <CAADnVQLLN9hbQ8FQnX_uWFAVBd7L9HhsQpQymLOmB-dHFR4VRw@mail.gmail.com>
 <3a7864f69b8c1d45a3fe8cda1b1e7a7c85ac9aee.camel@mediatek.com> <49d74e2c74e0e1786b976c0b12cb1cdd680c5f58.camel@mediatek.com>
In-Reply-To: <49d74e2c74e0e1786b976c0b12cb1cdd680c5f58.camel@mediatek.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Aug 2024 09:00:35 -0700
Message-ID: <CAADnVQLvbMRvCg2disV+_AR-154BwRpeB8Zg_8YpO=7gzL=Trg@mail.gmail.com>
Subject: Re: [PATCH net v4] bpf, net: Check cgroup_bpf_enabled() only once in do_sock_getsockopt()
To: =?UTF-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"kuniyu@amazon.com" <kuniyu@amazon.com>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "ast@kernel.org" <ast@kernel.org>, 
	=?UTF-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>, 
	wsd_upstream <wsd_upstream@mediatek.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	=?UTF-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"edumazet@google.com" <edumazet@google.com>, =?UTF-8?B?WWFuZ2h1aSBMaSAo5p2O6Ziz6L6JKQ==?= <Yanghui.Li@mediatek.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "haoluo@google.com" <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 12:02=E2=80=AFAM Tze-nan Wu (=E5=90=B3=E6=BE=A4=E5=
=8D=97)
<Tze-nan.Wu@mediatek.com> wrote:
>
>
> BTW, If this should be handled in kernel, modification shown below
> could fix the issue without breaking the "static_branch" usage in both
> macros:
>
>
> +++ /include/linux/bpf-cgroup.h:
>     -#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen)
>     +#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, compat)
>      ({
>             int __ret =3D 0;
>             if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT))
>                 copy_from_sockptr(&__ret, optlen, sizeof(int));
>      +      else
>      +          *compat =3D true;
>             __ret;
>      })
>
>     #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname,
> optval, optlen, max_optlen, retval)
>      ({
>          int __ret =3D retval;
>     -    if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&
>     -        cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))
>     +    if (cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))
>              if (!(sock)->sk_prot->bpf_bypass_getsockopt ||
>                ...
>
>   +++ /net/socket.c:
>     int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>      {
>         ...
>         ...
>     +     /* The meaning of `compat` variable could be changed here
>     +      * to indicate if cgroup_bpf_enabled(CGROUP_SOCK_OPS) is
> false.
>     +      */
>         if (!compat)
>     -       max_optlen =3D BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
>     +       max_optlen =3D BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen,
> &compat);

This is better, but it's still quite a hack. Let's not override it.
We can have another bool, but the question:
do we really need BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN  ?
copy_from_sockptr(&__ret, optlen, sizeof(int));
should be fast enough to do it unconditionally.
What are we saving here?

Stan ?


>
> > Thanks,
> > --tze-nan
>
> *********** MEDIATEK Confidentiality Notice ***********

Pls fix your mailer. Such a footer is not appropriate for the public
mailing list.

