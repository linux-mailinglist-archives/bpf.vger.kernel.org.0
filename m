Return-Path: <bpf+bounces-32981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A096915B98
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 03:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE2F1C21289
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 01:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A7317C73;
	Tue, 25 Jun 2024 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkkTDP2X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC1D2F5;
	Tue, 25 Jun 2024 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278565; cv=none; b=ReGm3RT5a9GeiTSc5QhLTtIpjozdRpWvgioNbxHYCJ3rCi4UBDsEtPcik12JCqQwrLTOu+BpgL2PQWe+g8qWE1i/f9vHDCcRY8QdraunjGHxPv1l8sKCGA+52w6X0qUfdjcSfcYJfQlAeI5vzsEmWjKhI+lEhpq5d7Y9ZAxsWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278565; c=relaxed/simple;
	bh=ZGwtin6IkFydRDXhg3G6A7e5bT2gMU7/bqPl3Ei9A5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULIeyipmwgiX6OXMrVpZl9exUZ8VGqiPgX9KzmXLV4QhB+uPGP5UAmcIwS879WKpUszxj0paNrKoKnhIPNR4+zS6yQdXupF9QjQa/6jiBfYEFNlL1aOGDRK9Wq/15m5ROVc/8cA/v+YqA6RgeZXlsjf6L55MvmVFtm7cueYJbfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkkTDP2X; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so2967337a12.1;
        Mon, 24 Jun 2024 18:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719278563; x=1719883363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocP+7GWOt5qm8uAfbxuKZILjuZbqgqb/oS35llmMlfI=;
        b=dkkTDP2Xr7Nq/TEjekeGvcVlYVSPHbm75OftPmTEPce45exCZBJqE7zk+rwnYUZq3r
         0PupnnYI3baUIr+FlDp5SsyeDSOZi3EQ88gSNvzK1hSUsxwZ2iq+wQQSVxAudksOdinE
         nEkaDfwUceoXq+oMqJsWOWCJ8MnhIQjJLEz4hwTD4ISqryMxHzH863UpK9PIxwJ2klFs
         SqYf2XYEkiAJ/TtMj+aD5aZEd9o4PAbZXtaQhz8V8bp+0/BXikzO5eu60qSVEo/fHVov
         7Nq7/fNvjcrq7VhNg+Dh33+mwcXkZgjIp46ioj33wL/WibsYD//OasmMPDxcK0PF4ivF
         whFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719278563; x=1719883363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocP+7GWOt5qm8uAfbxuKZILjuZbqgqb/oS35llmMlfI=;
        b=EhxFHaIlQ4Xr1UgW0BWU8ZtlwQA6loVmykU6xAeBUP6G429wg3TlSPujnSI8uc2HES
         xwyhyk1M9fAjE2YSNEwgRttPZOwWhU+mDiPQxn2est8IG3d36PLj3OhecGV1J06klX5d
         Koi4HxLUBs3bdUD9+cUPXyocFqLTB1/LSM41bopnJp/j2PXYMFVeS+79S3ksIcc/q56i
         sZm7SXIXT7A4Z7jURKzre17UnKi6amaGWh3vyuqQB/U9BK0uMA2r6jJzX3/oM//LPSJx
         sE9LcPrhORKINYoVPRbPmmq4EHJCMTJulwxDMAUKE+GMmIiiMsIR7VZnGEU2EFJB0Kx9
         GH3g==
X-Forwarded-Encrypted: i=1; AJvYcCU7QSXsRfnVkTYdzO+BN7mDCtxG67HPIQ5d9mORWgDAeFsIpqBfEMoaDdOQoYHSY1fVBm/xubLknQ2LARyhOKqgvhAOz+ODe/hpovmXpTq+vl7ztyH96QiShK+iWMF7K19fhS4Wr+KQigSSJ09147Eiba8vdKQoLRONwYlSKm0R7ZjS+/3IG/WsHu6gwzFb3CIgVKBQCRl5CdnF+msQIclLXhhaYQW9t3pLSrobcm7lwtrG
X-Gm-Message-State: AOJu0Yzm6pk7Z+Mp19eFC1A3aIDAxREkkNgWGoKFtJaka9Hw0gjrXn1r
	N7foL94lf8zGtK7SpnkYgHfGb1jjMW83bN4xjQhOqLUHWPWggbz75O43cO8SEm+HpSpbct6EBGp
	jZVk1fn5/QoLewctAQaG27KEr/F0=
X-Google-Smtp-Source: AGHT+IFOCCklcLOPy6WOiPuVU/fqKEtVmpGsdjPKTD+WPo8kIPQbu2yjkuypxUjWSU3hHx43L4MQeDRy9lY4WHhpjvY=
X-Received: by 2002:a17:90b:1bc8:b0:2c8:59f1:366f with SMTP id
 98e67ed59e1d1-2c859f13802mr4966999a91.4.1719278562794; Mon, 24 Jun 2024
 18:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZnB9X1Jj6c04ufC0@sirena.org.uk>
In-Reply-To: <ZnB9X1Jj6c04ufC0@sirena.org.uk>
From: Thinker Li <thinker.li@gmail.com>
Date: Mon, 24 Jun 2024 18:22:30 -0700
Message-ID: <CAFVMQ6R8ZZE+9jWM1vhEuz2PsLyCgKhpaVD377TKEu4AfGO_iA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, linux-input@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

I'm sorry for not getting back to you sooner. I have been traveling
since my last message.
I guess this patch is for the HID tree. The changes in this patch are great=
.

However, I suggest you implement ".update" if you think it is
reasonable for HID,
although it is not a MUST-BE. ".update" provides a good feature that
user space programs
can update an implementation on the flight.

On Mon, Jun 17, 2024 at 11:16=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> Hi all,
>
> After merging the bpf-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: error: initi=
alization of 'int (*)(void *, struct bpf_link *)' from incompatible pointer=
 type 'int (*)(void *)' [-Werror=3Dincompatible-pointer-types]
>   280 |         .reg =3D hid_bpf_reg,
>       |                ^~~~~~~~~~~
> /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: note: (near =
initialization for 'bpf_hid_bpf_ops.reg')
> /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: error: initi=
alization of 'void (*)(void *, struct bpf_link *)' from incompatible pointe=
r type 'void (*)(void *)' [-Werror=3Dincompatible-pointer-types]
>   281 |         .unreg =3D hid_bpf_unreg,
>       |                  ^~~~~~~~~~~~~
> /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: note: (near =
initialization for 'bpf_hid_bpf_ops.unreg')
>
> Caused by commit
>
>   73287fe228721b ("bpf: pass bpf_struct_ops_link to callbacks in bpf_stru=
ct_ops.")
>
> interacting with commit
>
>   ebc0d8093e8c97 ("HID: bpf: implement HID-BPF through bpf_struct_ops")
>
> from the HID tree.
>
> I've fixed it up as below:
>
> From e8aeaba00440845f9bd8d6183ca5d7383a678cd3 Mon Sep 17 00:00:00 2001
> From: Mark Brown <broonie@kernel.org>
> Date: Mon, 17 Jun 2024 19:02:27 +0100
> Subject: [PATCH] HID: bpf: Fix up build
>
> Fix up build error due to 73287fe228721b ("bpf: pass bpf_struct_ops_link =
to callbacks in bpf_struct_ops.")
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/hid/bpf/hid_bpf_struct_ops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_b=
pf_struct_ops.c
> index 5f200557ff12b..744318e7d936b 100644
> --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> @@ -175,7 +175,7 @@ static int hid_bpf_ops_init_member(const struct btf_t=
ype *t,
>         return 0;
>  }
>
> -static int hid_bpf_reg(void *kdata)
> +static int hid_bpf_reg(void *kdata, struct bpf_link *link)
>  {
>         struct hid_bpf_ops *ops =3D kdata;
>         struct hid_device *hdev;
> @@ -229,7 +229,7 @@ static int hid_bpf_reg(void *kdata)
>         return err;
>  }
>
> -static void hid_bpf_unreg(void *kdata)
> +static void hid_bpf_unreg(void *kdata, struct bpf_link *link)
>  {
>         struct hid_bpf_ops *ops =3D kdata;
>         struct hid_device *hdev;
> --
> 2.39.2
>

