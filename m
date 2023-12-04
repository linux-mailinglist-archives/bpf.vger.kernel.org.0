Return-Path: <bpf+bounces-16570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D95803043
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 11:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DBB1C20A69
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFB221A05;
	Mon,  4 Dec 2023 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4ux66rL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720C2CC
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 02:28:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c09dfd82aso13065895e9.0
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 02:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701685711; x=1702290511; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZQXTUsSUj/aJKvxre5oz5Fe9ABcL3iK5D919OR3TRQ=;
        b=E4ux66rLkiYXEcedFhRXHGFHeRcHqnY7EBnvDZ9Pj9i07r4CoV2NCA2PzVB/2cnTar
         LpfyorgjuctpELr412EERCKhCcCsqyEW6itfM/TqeaCyk8iwJ3PnxGbKOQSxvrh7Hay/
         8gIfm6WwIfMbkCLzJerhvxtbxN8A64xf9QQcNCOjYh+jmhj3zwS+6akIM8I0L6HMCUza
         oyFdmWiG2yEy8Hm5xepEjVUPW9iPOQmc2iNy+GFQD3biC0HzMubldB7Kt8490aELizmi
         EpSvmopnMnNekuYcF9JvYTwmmQpnDj79Rp0A787vskZ8arkvnIg6+28EbieUfaXBWOBt
         0yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701685711; x=1702290511;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZQXTUsSUj/aJKvxre5oz5Fe9ABcL3iK5D919OR3TRQ=;
        b=bOMnkZyRHWykcNz7SyJlEtiBI+wpZNDTN4nYT3pcz2WDQu8AzlL+ymCiKk760xxRHx
         Hu3coMwaJlJkwmjJvSHOIz74F79GHtlKjFR8PaaPPjIWdNswM5zxWRKhExWgkxKKBzzz
         d3rsVVQdtt4BG4Wd7uygI5UynCXTGpF/CHHM75jEtHehLJgxTeoH/iH/jZBybdpJ3Z/R
         xjE7c66TSqZ22CIpaI7YH1vejxgx6K/F9Vd2LHVaKb+YR+Lm2bjsG8kri+Te9rcKpnN/
         SFY52v0ZiFqraGsGGSsiDrMYOpZCO1kPGUVGSsMOM3BunuYiRyIkhmdofk5rv6JB/Rmg
         A4sA==
X-Gm-Message-State: AOJu0Yzy0LkQtONXkiyERRmYSb3OruwBb5HYvIvu7XUvB7P59R77fpLN
	2G7e9yAHdXt47a6DCYo6JrTUIiOCLQ==
X-Google-Smtp-Source: AGHT+IHLsn74bZkl/O6fgT6FstU1SUp9hCanwDEXe30U6KJrbB2rAAvWvXCmJHeh2/35CgJ5A2iCTw==
X-Received: by 2002:a05:600c:314e:b0:40b:5e21:dd26 with SMTP id h14-20020a05600c314e00b0040b5e21dd26mr2383012wmo.84.1701685710528;
        Mon, 04 Dec 2023 02:28:30 -0800 (PST)
Received: from smtpclient.apple (2001-67c-10ec-5784-8000--16b.net6.ethz.ch. [2001:67c:10ec:5784:8000::16b])
        by smtp.gmail.com with ESMTPSA id bi10-20020a05600c3d8a00b0040b4c7e1a65sm18147385wmb.13.2023.12.04.02.28.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2023 02:28:30 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH bpf] bpf: fix verification of indirect var-off stack
 access
From: Hao Sun <sunhao.th@gmail.com>
In-Reply-To: <20231204010139.2038464-1-andreimatei1@gmail.com>
Date: Mon, 4 Dec 2023 11:28:18 +0100
Cc: bpf@vger.kernel.org,
 andrii.nakryiko@gmail.com,
 kernel-team@dataexmachina.dev,
 Andrei Matei <andreimatei1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB2EA8CD-8B4C-49E8-B017-1B93954C85C9@gmail.com>
References: <20231204010139.2038464-1-andreimatei1@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)



On Mon, Dec 4, 2023 at 2:02=E2=80=AFAM Andrei Matei =
<andreimatei1@gmail.com> wrote:
>=20
> This patch fixes a bug around the verification of possibly-zero-sized
> stack accesses. When the access was done through a var-offset stack
> pointer, check_stack_access_within_bounds was incorrectly computing =
the
> maximum-offset of a zero-sized read to be the same as the register's =
min
> offset. Instead, we have to take in account the register's maximum
> possible value.
>=20
> The bug was allowing accesses to erroneously pass the
> check_stack_access_within_bounds() checks, only to later crash in
> check_stack_range_initialized() when all the possibly-affected stack
> slots are iterated (this time with a correct max offset).
> check_stack_range_initialized() is relying on
> check_stack_access_within_bounds() for its accesses to the
> stack-tracking vector to be within bounds; in the case of zero-sized
> accesses, we were essentially only verifying that the lowest possible
> slot was within bounds. We would crash when the max-offset of the =
stack
> pointer was >=3D 0 (which shouldn't pass verification, and hopefully =
is
> not something anyone's code attempts to do in practice).
>=20
> Thanks Hao for reporting!
>=20
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
> Closes: =
https://lore.kernel.org/bpf/CACkBjsZGEUaRCHsmaX=3Dh-efVogsRfK1FPxmkgb0Os_f=
rnHiNdw@mail.gmail.com/
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
> kernel/bpf/verifier.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index af2819d5c8ee..a428735d232e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6816,10 +6816,7 @@ static int check_stack_access_within_bounds(
>                        return -EACCES;
>                }
>                min_off =3D reg->smin_value + off;
> -               if (access_size > 0)
> -                       max_off =3D reg->smax_value + off + =
access_size - 1;
> -               else
> -                       max_off =3D min_off;
> +               max_off =3D reg->smax_value + off + access_size - 1;
>        }
>=20
>        err =3D check_stack_slot_within_bounds(min_off, state, type);
> =E2=80=94

(Resend, forgot cc list)

Andrei, thanks for the quick fix! But with this fix, I suspect the
max_off would be incorrect when access_size is zero. We probably
should do something like this:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2a9d521b64f4..70d5201f7d08 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6556,10 +6556,9 @@ static int check_stack_access_within_bounds(
 			return -EACCES;
 		}
 		min_off =3D reg->smin_value + off;
+		max_off =3D reg->smax_value + off;
 		if (access_size > 0)
-			max_off =3D reg->smax_value + off + access_size =
- 1;
-		else
-			max_off =3D min_off;
+			max_off +=3D access_size - 1;
 	}
=20
 	err =3D check_stack_slot_within_bounds(env, min_off, state, =
type);


