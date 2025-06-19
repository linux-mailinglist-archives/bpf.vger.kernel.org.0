Return-Path: <bpf+bounces-61106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D556AE0C0A
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 19:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68B916C299
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F06C28CF6B;
	Thu, 19 Jun 2025 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkswTbCn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612322AF1C
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750354971; cv=none; b=YMH7DEhorcU/Met6+XIIbTjyVSFLxqvhpIxOfWFvQyQuYxAyNWXZxPXbCi7ve4czKNEZx2e324nTRUNFvb8SEk1o2E7/QH/wPMl0AQML8LGV0xSslN8/KGjO0tcnx2P7FaRPkHeEo3YVjBYuW2CvQnt3jykNVPikXJ+XCnwK2MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750354971; c=relaxed/simple;
	bh=zhgkBBPAEthE1uuLhrEWZWgOxfjnjgvMR0ApkrgoEls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eGfLu+1diGYrM0s7yegCxIVGyQO4hi6/0GfMG9MIlADt4LYqs7z+ikTx25Av9XmseTJICNwsMdeUtvK0QD6h2wH9GjeqZg1vA4cJOQcmlKkvQuqfGQkH7eZzSVo6l20JW2VbmcuLRfyDm56fcqmcEFmoaoZpKS5b9uWpvOD1wyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkswTbCn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23636167afeso10192945ad.3
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750354969; x=1750959769; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Udg/L5Uvf5SI2iKVdlRL8b7V6dUS3aAwyAPpSPZTf2I=;
        b=RkswTbCnmCAKKsOqb1deaBaMI+072CrI3iupFKRInILV1BcKB/ydiK9B24cXpWIbbX
         n0/Q0PwhlzrIGJBej4kYScuOROwmKyxEdwk8NtVcRk8/hRmURflolebvZ4GENXaxNkEy
         XTHhaoCUJ9O3l4L2+kLtqLBdUqbtt/ybX9Npgl+xZw+LYsOhX9LQZcbEVaWmA07vFWUs
         2pQTDoMq5wLoF6QZw0uYembyoQl9dxZiekIg28Zq73G7/xMR6RbFX39yRk9X1low3lsX
         DdC1RsuF9wYmOtfH9UGpcfehivTnhwjhRs4LXjMufZRAoIVLeSD5t4efPjgtTATRSEK2
         Wcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750354969; x=1750959769;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Udg/L5Uvf5SI2iKVdlRL8b7V6dUS3aAwyAPpSPZTf2I=;
        b=Uct1TZhVpUkpaUXw0/Fp0DZap/c39sWEN8LURcTn/oKvShH3f0CtekoNubACYKyAOw
         GRVzHzgW6FrGsGtl89aBZEuocpB6hYpKhJsAgWs78UumcHXf7kHHNojosnX19mfp/AlC
         dZx0JBJ9MVqFB6mABKO4WtHvZlVTSbsJyI/Ylvu8nL/QCNBJFaDRZtR9KdC2XnZOGatt
         VFJonjlGrRBZ6rg0pSfMj9a0xuuo4B6MisG5v3vks3Zm2r6onDaHu7yLMHEH4ZW1NHmE
         wHqMql9U8Y+RfHnOMhisGBOUAO21BSO4HU/kwv861BKuWVYc4yTp9NVJIWVw+CNnC/lh
         1Q2w==
X-Forwarded-Encrypted: i=1; AJvYcCWk37lfNOP6vC38BSlHtWBAHlNCslNp+il6Il3xoDkUGRiWkXephB7WAwei1Ot+E695TtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRwZTxWaID3vAbcz7QSxucxDgOo2gAmm4YUIvWqOLc5JQVFCp
	D2tklzGa/UCCt1eJR6Q+lJ3jhvU/fmrLN43MKlvWIt44Vxxwc68ECHMz
X-Gm-Gg: ASbGncvV64ktsqnhV8c4yJQgmizMg0ZfdHPPfrsEM+dY19lDTpiX1r8RUj3Jckd9Dzf
	jf+IWSywHBtZVuN98Wmap9hxq2sEhzYLEN/mlA/okGp14/ZrEG/M/uyqDqQd5fq05MWpQTQB65R
	W07MabzRVtLhepGyrNO/QbE7MTqn84x/qSJHUzOkYlWn2e0/pj8HGr/K08WcQbbDQUYQ9xvhkOk
	BBuJNTd2wTUapc39tFAXauOS8uhw1er2ycKIRVkv8BqCAOLeF9IhIdGqzzOtsG98yrgH/0RXvwN
	a6SSJgBpcvJd2V80/4CFWhyDkI5306pyO97lSB7IaGqIUvJW6vchIvfGgjRv9PGeE/Jf
X-Google-Smtp-Source: AGHT+IEiKN/6/GNOA6wpyFYWsbTWTytpN3hWWFqDKu2/6Ct442sHivvewwaHQw6JeiEs27JClQqTBw==
X-Received: by 2002:a17:902:f712:b0:234:8e78:ce8a with SMTP id d9443c01a7336-2366b3e02ebmr316620455ad.48.1750354969627;
        Thu, 19 Jun 2025 10:42:49 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea88desm122601105ad.150.2025.06.19.10.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 10:42:49 -0700 (PDT)
Message-ID: <4cb46243470f8dc4f2d8eabd7662788285dcfdf3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: test array presets in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Thu, 19 Jun 2025 10:42:47 -0700
In-Reply-To: <20250618203903.539270-4-mykyta.yatsenko5@gmail.com>
References: <20250618203903.539270-1-mykyta.yatsenko5@gmail.com>
	 <20250618203903.539270-4-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-18 at 21:39 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Modify existing veristat tests to verify that array presets are applied
> as expected.
> Introduce few negative tests as well to check that common error modes
> are handled.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  .../selftests/bpf/prog_tests/test_veristat.c  | 127 +++++++++++++++++-
>  .../selftests/bpf/progs/set_global_vars.c     |  56 +++++---
>  2 files changed, 159 insertions(+), 24 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/too=
ls/testing/selftests/bpf/prog_tests/test_veristat.c
> index 47b56c258f3f..f4de22302083 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> @@ -60,13 +60,19 @@ static void test_set_global_vars_succeeds(void)
>  	    " -G \"var_s8 =3D -128\" "\
>  	    " -G \"var_u8 =3D 255\" "\
>  	    " -G \"var_ea =3D EA2\" "\
> -	    " -G \"var_eb =3D EB2\" "\
> -	    " -G \"var_ec =3D EC2\" "\
> +	    " -G \"var_eb  =3D  EB2\" "\
> +	    " -G \"var_ec=3DEC2\" "\

Nit: white space is allowed for '=3D' but is not allowed for array
     indexing, e.g. 'a[ 2]=3D1' or 'a [2]'.

>  	    " -G \"var_b =3D 1\" "\
> -	    " -G \"struct1.struct2.u.var_u8 =3D 170\" "\
> +	    " -G \"struct1[2].struct2[1][2].u.var_u8[2]=3D170\" "\
>  	    " -G \"union1.struct3.var_u8_l =3D 0xaa\" "\
>  	    " -G \"union1.struct3.var_u8_h =3D 0xaa\" "\
> -	    "-vl2 > %s", fix->veristat, fix->tmpfile);
> +	    " -G \"arr[3]=3D 171\" "	\
> +	    " -G \"arr[EA2] =3D172\" "	\
> +	    " -G \"enum_arr[EC2]=3DEA3\" " \
> +	    " -G \"three_d[31][7][EA2]=3D173\"" \
> +	    " -G \"struct1[2].struct2[1][2].u.mat[5][3]=3D174\" " \
> +	    " -G \"struct11[7][5].struct2[0][1].u.mat[3][0] =3D 175\" " \
> +	    " -vl2 > %s", fix->veristat, fix->tmpfile);
> =20
>  	read(fix->fd, fix->output, fix->sz);
>  	__CHECK_STR("_w=3D0xf000000000000001 ", "var_s64 =3D 0xf000000000000001=
");

[...]


