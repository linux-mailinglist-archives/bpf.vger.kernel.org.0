Return-Path: <bpf+bounces-46415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 995319E9D62
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 18:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6399164F2F
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 17:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24131F2C43;
	Mon,  9 Dec 2024 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwzuwR0X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AB61F0E56;
	Mon,  9 Dec 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766341; cv=none; b=hkYBmH6sFxLh4Ht1w/n4tUbYfkTklfEe8TJ+ZQIUxZDWb5DiOb5RSsJ8HbGGUy9Zx45IxnQ08UG3LFQ5k7pzyRsGXcikfgnVZFuiJnOF185FO+hxZWeaXVjtG3ngeE1TXAHHwaK4aMMf8VBFeP5hvzjrkEO32c6grM++jAacAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766341; c=relaxed/simple;
	bh=CcuwSq1SxtQMhtHuhAR5Boa6Ar8NA6RwQBru1LJ34o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDPVVCovw8lxm074x0N+KJOVL4GDzC1NuWQbLbsGTfG/ZPaDwStAXmpOKM6wTWogsUpx2baPcdMawHwevxN7B8hUX4qIfl54l9i2zlg3/8BCn85Oto4ke4N4BEEAft7VdfXeUxMlH9TceT8iDo1k91zBACTHbYzn2by6U8YL5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwzuwR0X; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so1097455b3a.3;
        Mon, 09 Dec 2024 09:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733766338; x=1734371138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLL+hTR2erfFMDNeV90V786XCRfTp97LfoiOqBvZZGc=;
        b=dwzuwR0XUZanDwpP+mKZfcSxP2FkoLZHfHU5yRxQahIESEsNNsA3jLjXta+RghyAzB
         LDaXRg6BFwdKKIOCKd58YG8rgFwhf3iBiOmUwM5r14FuGJh96SamYlXOm5nciMhoWYa/
         k2NEAPBNTv6rhkoueuekyh6n/KnUyzNVf1nd9mfy91gMWqYqHpByhhjb/27/4liFwkW6
         ybbLU3bvTF0jL2HeytZ2oqud/QupKgGuJgTL5LmAvYJf2lrTLA47wpNxQrLW7vH6f+5c
         TtAnPTLcjvwx10Q2QxsoIn7dl4ubi7hkHZdQOwKikM3vIllvhCLDmj2s+K6MWRW7/Wqi
         C6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733766338; x=1734371138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLL+hTR2erfFMDNeV90V786XCRfTp97LfoiOqBvZZGc=;
        b=pW9cUAlp+3epNZ1KcYggTnhwpzxhaeiEQ/AwnSP99Y/bFmo+ly8f6zrnE+Tey646Jc
         5OU2NRkvlL7kxl+KnoOtqnKVw8btnB7bH4L9QfW0p2VS6VPSX7edWJmi93eyxaL0QMNI
         TAalMhmYDbZsITnef+5/jfnLYFQ+1S/0EvbCn6t6Qjs162onhjaG7+C2KlM0Tkqmi8wh
         lzYV/WSSvS/Fi0UtIe/RJXpndClzs73XZlUhfZqvx+fHeSqzeNr3fXSjl5EAfU5s2uwh
         vZiKvdHZvtkcWxAscOF/7mk7V/dwyVsMLEIV1uudMQz+nFzV8zKGNTHLdYxSaoGBk2oh
         TMXw==
X-Forwarded-Encrypted: i=1; AJvYcCWBhqEpRJkmTFiNB74zldZx2C+nlLO2y3LJ28Abt4W0C911vC3xO4gFLodLswCgsYTWXI7mykJJKphoZdOfZnpg9wMibw==@vger.kernel.org, AJvYcCWkD/+wlh7Ccv/Y8a4EGp6iX2bFr00Wp5EP6p8fpm9bWaYERPwArKWQT7kjEGVeK19VFiwjjL3T1D+YAz4R@vger.kernel.org, AJvYcCWpgjI9vnEE0VjBAfF8CuCLNkyar/2lx6Gb2Z+1TITMJn13G2FqORG7JlEze+gK/7o6mYs06ucmAN1AeEoPbA==@vger.kernel.org, AJvYcCWt7lsVFYbU5ZqECDcut0TlVTrKU3WyjWetnwzsfkjOJSC+kRyordpZjT+ScU7WnMHytMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkGoBMYHNQ9zI3EpcmJLDtOlSJ6LKwYFJEHjH4jd62pdLlbtp5
	+Uky6pByhLfadKX7eD+ICYcRDPiEyXtG6cOQphqBMijmMUEdez+uxt8wuZSYqns8YW3xEq3QZZT
	cxlZks8EZvHjMNv9KyoQjYXs/y0Y=
X-Gm-Gg: ASbGncviDw3zN5fPGPl3wvwi3CC6P84TZM7C3VXpXovlSQ/lSP680qqMrts56zZd+Gd
	9JKhWh1xMFCdw/Zhz5L2iTDNoCdu0SWY7hrzxoeW2Xvd5mKWqINk=
X-Google-Smtp-Source: AGHT+IF6C1kyOIzspL8FJ6lY6T2B7S0Ong/QRjtBPIeAUZMab/0JVUfow4OcO3JdX8i8lSSqgjFzDc6Dn626X5R/OrY=
X-Received: by 2002:a05:6a20:9f9b:b0:1e0:d1db:4d8a with SMTP id
 adf61e73a8af0-1e1870bd5e1mr20198567637.10.1733766338437; Mon, 09 Dec 2024
 09:45:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205-sysfs-const-bin_attr-simple-v1-0-4a4e4ced71e3@weissschuh.net>
 <20241205-sysfs-const-bin_attr-simple-v1-4-4a4e4ced71e3@weissschuh.net>
In-Reply-To: <20241205-sysfs-const-bin_attr-simple-v1-4-4a4e4ced71e3@weissschuh.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Dec 2024 09:45:26 -0800
Message-ID: <CAEf4BzasK+pV69CMcy-pMk1cMf+LhKnXKPm8q6s7gioXnebRNQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] btf: Switch module BTF attribute to sysfs_bin_attr_simple_read()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:35=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> The generic function from the sysfs core can replace the custom one.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  kernel/bpf/btf.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e7a59e6462a9331d0acb17a88a4ebf641509c050..69caa86ae6085dce17e95107c=
4497d2d8cf81544 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7870,17 +7870,6 @@ struct btf_module {
>  static LIST_HEAD(btf_modules);
>  static DEFINE_MUTEX(btf_module_mutex);
>
> -static ssize_t
> -btf_module_read(struct file *file, struct kobject *kobj,
> -               struct bin_attribute *bin_attr,
> -               char *buf, loff_t off, size_t len)
> -{
> -       const struct btf *btf =3D bin_attr->private;
> -
> -       memcpy(buf, btf->data + off, len);
> -       return len;
> -}
> -
>  static void purge_cand_cache(struct btf *btf);
>
>  static int btf_module_notify(struct notifier_block *nb, unsigned long op=
,
> @@ -7941,8 +7930,8 @@ static int btf_module_notify(struct notifier_block =
*nb, unsigned long op,
>                         attr->attr.name =3D btf->name;
>                         attr->attr.mode =3D 0444;
>                         attr->size =3D btf->data_size;
> -                       attr->private =3D btf;
> -                       attr->read =3D btf_module_read;
> +                       attr->private =3D btf->data;
> +                       attr->read_new =3D sysfs_bin_attr_simple_read;
>
>                         err =3D sysfs_create_bin_file(btf_kobj, attr);
>                         if (err) {
>
> --
> 2.47.1
>

