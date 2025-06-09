Return-Path: <bpf+bounces-60095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5372BAD28DE
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66E8167931
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 21:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D252222C3;
	Mon,  9 Jun 2025 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlBlQsCb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA11E521B
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505070; cv=none; b=bXrqbQNEYBXNAceZ7g6Ta8U8/qvcGQhnDt3Y/3mpvVaahtTvaFAXpbIE7SRroLpf43lNYImBHx5JygSmVwwIWxktLoTsFrvdsb26KJQSHsidPHhf3WLLK33TDIjunp8YZ9yVryVL2q6S5tdXY5aOWA9CityCTucYD/GdHwcEiAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505070; c=relaxed/simple;
	bh=SCcm3uVbyLiMZ5KcOXaJzHyxX1tNQmyMPfXx4XZgdzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6XlPiCWAlLMkRHRBdr4Pi+X29mqEJtiWcI4B2GhsG4kYe12DEr/2IPQp1rk281oxWJOhx0ndQ21Z/bqIYNkNkR1exdH3X55RAFJg6zhAS7hLpmyMrWPC/OGd2zNEh8H/qXYCQlB/zAzUf8i609/xiRUgWn4Dd+OBmf4im8V8C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlBlQsCb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235ae05d224so41529335ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 14:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749505068; x=1750109868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqxFh4E3EpcrGV2JOpo4vJCVYbiXXeaQqR9ZichLVz4=;
        b=ZlBlQsCbgKfkg1AGEYUCFmY9+00TLgWd1hUJOFUB0KiOsFzTSSn8LdSA33zX+mrC2n
         tRJV6fQ4M5+mvvBAbbkLzCla5bzsoUgCJ/jVM52w3FkJQJCgmsQoGFrH9lPeUn6CR0el
         oPJkJZkUn0l5JMUUoL8WplsMTHcGSoeRZ5ijLuxCjBXZX8tc3Ej3P1k5Yk1Ogp9cix49
         qxQr3/vE1mNUbw4J+kDbPJbMUwMW29CprjnohKw+3+mhgoJlAvosq4z2uxcMaz6KXzqJ
         8xxurB/VvZE6vKpt3EsbdRcTMhLR0J956YF3V1vZ4Bw7V+yjQPqZJ56Cg8LKfhTIEzjq
         qOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749505068; x=1750109868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqxFh4E3EpcrGV2JOpo4vJCVYbiXXeaQqR9ZichLVz4=;
        b=obKaZmBa19pcR6FkIOwpzD6yEG7aJY8ziHy8XdhdI8vBFK1cO2qIkNHah4GS583j5x
         uQjyjPPwW36p/aSdwE43BPj0QXh3rmQnsnPYdb6Lc1ziUqJR203huW2FDkINJelJr8Zr
         tuUy6JEGYIaYejlT7D2FXOuCBWROjONI3k4cZ/i9UDPjg/xDb7lnYfON89UaIeBagnUi
         HPOfvkSHdv5E3vh08OZV4vywmmhqX3vYUBvEbqpeTSYQweuHGNdB/4IdUBQt1gaJfBA2
         /BMApRIWa0Za5T+tIagdSjDm2VeNOWkIhTZPbiMnbQt41oKJmGxPbjEXaOz0M+tSMf6j
         UPXw==
X-Gm-Message-State: AOJu0YweS41WkV89NCtDsd+ITzyBP9o0Kt2eBKev96ZXqSh1UUpaV5VH
	eBcqr67y1wR5YKTqL6VW3uK5GURjes3/bSz5pFat7wiv1G7nU4EnSKY1fK+F9GVA0nG9fqqomLq
	HI38IqtalMxZPU5vonmnFhDyKjXxdFsc=
X-Gm-Gg: ASbGncs0vuw9BCRgeA5dQuyUP7XB2Yjr1H67es7n1yMlFjBCXPk5PzfENtiVDab2art
	BPeIYjWzoCe5aGqnJGPjgzAxe2YHYE++X1XLgCdh/166VHXfye+kynGuYzGv/SriO08ub7uJJee
	wHPeUVd4nHDzMOF3LxiResm59eczLNJKUZTB9R23x8znMFMrCWNrUK8M6PLmA0fbS9XgOj3Q==
X-Google-Smtp-Source: AGHT+IFrdE/Wc87t1Y/Zp5ZJBLRDtnzPYF8YEyDjmPc7e1JxKOlHI2RnwHvfdsiB/tA/oRxd9H/v/t7TVqi12TO9W4U=
X-Received: by 2002:a17:902:d4cc:b0:231:c89f:4e94 with SMTP id
 d9443c01a7336-23635c7cd6bmr14527105ad.21.1749505068464; Mon, 09 Jun 2025
 14:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605183642.1323795-1-mykyta.yatsenko5@gmail.com> <20250605183642.1323795-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250605183642.1323795-4-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Jun 2025 14:37:35 -0700
X-Gm-Features: AX0GCFvzx3MntUmHvy7Uz3YbjKpWTV9pivZIkwS_Kzi8Wwr5H-lM5teduMuGx8g
Message-ID: <CAEf4BzZe2Zu-kkXt9V7WXw207SOXOGSKAYoctRX1+-5280J=bQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: test array presets in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 11:36=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Modify existing veristat tests to verify that array presets are applied
> as expected.
> Introduce few negative tests as well to check that common error modes
> are handled.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../selftests/bpf/prog_tests/test_veristat.c  | 86 ++++++++++++++++++-
>  .../selftests/bpf/progs/set_global_vars.c     | 51 +++++++----
>  2 files changed, 114 insertions(+), 23 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/too=
ls/testing/selftests/bpf/prog_tests/test_veristat.c
> index 47b56c258f3f..057c249c82fa 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> @@ -60,12 +60,15 @@ static void test_set_global_vars_succeeds(void)
>             " -G \"var_s8 =3D -128\" "\
>             " -G \"var_u8 =3D 255\" "\
>             " -G \"var_ea =3D EA2\" "\
> -           " -G \"var_eb =3D EB2\" "\
> -           " -G \"var_ec =3D EC2\" "\
> +           " -G \"var_eb  =3D  EB2\" "\
> +           " -G \"var_ec=3DEC2\" "\
>             " -G \"var_b =3D 1\" "\
> -           " -G \"struct1.struct2.u.var_u8 =3D 170\" "\
> +           " -G \"struct1[2].struct2[1].u.var_u8[2]=3D170\" "\
>             " -G \"union1.struct3.var_u8_l =3D 0xaa\" "\
>             " -G \"union1.struct3.var_u8_h =3D 0xaa\" "\
> +           " -G \"arr[3]=3D 171\" "      \
> +           " -G \"arr[EA2] =3D172\" "    \
> +           " -G \"enum_arr[EC2]=3DEA3\" "        \
>             "-vl2 > %s", fix->veristat, fix->tmpfile);

can you please also add tests for cases where user specifies array
index for non-array type and vice versa?

[...]

