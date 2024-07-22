Return-Path: <bpf+bounces-35211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7189389D9
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 09:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC2F1C21106
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91CC1CD37;
	Mon, 22 Jul 2024 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjxG8N8p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC581B969;
	Mon, 22 Jul 2024 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632408; cv=none; b=K/9a65qvHG8eKZ5W4r7aG7OGzO8/r2IRBQWFcjadZvhnUA074suoYYf5wwEkOAFGUdyNTWMrb6NrUww802uCGPygor8CM3ZdfQrNGsh9X2z51wZwmgOkKBDlpd/AHgOcfQyn6+vs0bHc0PSAZ6gbX+wpEaMbMjtxBNDS8JQYXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632408; c=relaxed/simple;
	bh=x5Wg36hIMdYFrhhqgCS4o7e/N1aHzPmQO+sgltViDbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iJPZZJrshuvzvuo5W/GSoYnHJWGKr0eAZF/2qf5knEk4nm4UEAiX59m9MXF/kT11Cuf/abzYugMg8V6pQTD12CKr0MNAUmN7Z2bNMcIqynd/w5Mqfw8vSYHigDC7l7yxIBkbjDAeIOfarnHTBF9b/WZQcSCJHLCh3YSRqRq6Yg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjxG8N8p; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d2b921c48so316558b3a.1;
        Mon, 22 Jul 2024 00:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721632406; x=1722237206; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=igkQ00TUuMQildPejDAwnH78KHdTHKVABM52KsHDG/Y=;
        b=QjxG8N8poo0w8PgCMmGwBEabot/O2uTv2pB69ML9fLdssQPr4JpQsUYT3nc/Bz0MJQ
         IQBngSCZdfA1yj+fUzpZd2t8Ok3ahTbAvXKzHS2g00THzFgAGx0vlAFRVbOBlGGSa1Av
         h+PSfybrEp/CEo4TJnSXULt6+rKR17muIerEVl0b9YSxpJa/OFBXsIIhENR2pjsGqWVv
         nw7py5knlbSVw248z9TCw7K6r5KRW9ixTIaF1wLLa3FV41fvrOBavWc64IJZ52vUS0Us
         pLC7uTd6btjQLzTmoElkWG1sr0bvp/OBH3qsxBqR+zdE5w2cN5z6agZtZ3JT0sUnPerb
         ZzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721632406; x=1722237206;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igkQ00TUuMQildPejDAwnH78KHdTHKVABM52KsHDG/Y=;
        b=Ak8eV7uKB02IW0zs9vh4xFvHqBP1uEF7u0ucHhi6F6P2fmqPBkUMxXOWnnEqZuId4b
         8op9kQ2LpfMTvlye5Ly3lSD0V46QesH8y2wZz+5RXUeFkptbnJ7nEF9by+ODfcVDSGLk
         I1KVexGNhDH4i8B8jkIYNudY27isxWtP6aMNBTOp/6u2GnFb47/RDai2JYWXbOBkZ3Ub
         iBBzcqvz97lwqwhZULnv5pUog10z9rydL9wK0+uve/6Sk0yQMYh/TNkCfxPaecPNEU4n
         1chTYfCSItIaZHyCnCy/q7xdIlNELVn0vwFE0vHXFOFB8J4Pg+BWtC1SXm8jaQwFBv5+
         rFqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHkNrJTTGNUB6amnFJ8VYwi9BUGzx5t78E6q622vmxPEn0JM1TF5Jj9FwrSWQ0UGmaFYJDy2ekSGo/sgj4GF+XVpIGjG3CeUbG6gjJau6ssa5h9pSaR4x81CdOxkSnL0Tl3AXWqtWRlRDwJBFMCWa0DtyVd+JzxpLchIa6jQ3Dw31R
X-Gm-Message-State: AOJu0YyewpLg8xOmxD82okoVdeT6R2DueWjEuOxXRcDceaeYm3KEMbOL
	uluQs4xNMxqixzp3xyeYJpusUDzrl/vYd3UYCk4Dtb4K8vFBPV5s
X-Google-Smtp-Source: AGHT+IHMDZrZKO0nbRoj3na9xXFEvvb63FEpSpD3S4S3Xd/wM4AmPbE1tZM+p8pRjyU9cLO9pYUSNw==
X-Received: by 2002:a05:6a20:d50a:b0:1c2:93a7:2541 with SMTP id adf61e73a8af0-1c428594bfcmr3541183637.24.1721632406288;
        Mon, 22 Jul 2024 00:13:26 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b2f30esm6190456a91.9.2024.07.22.00.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 00:13:25 -0700 (PDT)
Message-ID: <a5afdfca337a59bfe8f730a59ea40cd48d9a3d6b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/9] bpf, verifier: improve signed ranges
 inference for BPF_AND
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, Matt
 Bobrowski <mattbobrowski@google.com>,  Yafang Shao <laoar.shao@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, "Jose E . Marchesi"
 <jose.marchesi@oracle.com>, James Morris <jamorris@linux.microsoft.com>, 
 Kees Cook <kees@kernel.org>, Brendan Jackman <jackmanb@google.com>, Florent
 Revest <revest@google.com>
Date: Mon, 22 Jul 2024 00:13:20 -0700
In-Reply-To: <20240719110059.797546-6-xukuohai@huaweicloud.com>
References: <20240719110059.797546-1-xukuohai@huaweicloud.com>
	 <20240719110059.797546-6-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-19 at 19:00 +0800, Xu Kuohai wrote:
> From: Shung-Hsi Yu <shung-hsi.yu@suse.com>

[...]

>=20
>                         |                         src_reg
>        smin' =3D ?        +----------------------------+-----------------=
----------
>   smin'(r) <=3D smin(r)   |        negative            |       non-negati=
ve
> ---------+--------------+----------------------------+-------------------=
--------
>          |   negative   |negative_bit_floor(         |negative_bit_floor(
>          |              |  min(dst->smin, src->smin))|  min(dst->smin, sr=
c->smin))
> dst_reg  +--------------+----------------------------+-------------------=
--------
>          | non-negative |negative_bit_floor(         |negative_bit_floor(
>          |              |  min(dst->smin, src->smin))|  min(dst->smin, sr=
c->smin))
>=20
> Meaning that simply using
>=20
>     negative_bit_floor(min(dst_reg->smin_value, src_reg->smin_value))
>=20
> to calculate the resulting smin_value would work across all sign combinat=
ions.
>=20
> Together these allows the BPF verifier to infer the signed range of the
> result of BPF_AND operation using the signed range from its operands,
> and use that information
>=20
>     r0 s>>=3D 63; R0_w=3Dscalar(smin=3Dsmin32=3D-1,smax=3Dsmax32=3D0)
>     r0 &=3D -13 ; R0_w=3Dscalar(smin=3Dsmin32=3D-16,smax=3Dsmax32=3D0,uma=
x=3D0xfffffffffffffff3,umax32=3D0xfffffff3,var_off=3D(0x0; 0xffffffffffffff=
f3))
>=20
> [0] https://lore.kernel.org/bpf/e62e2971301ca7f2e9eb74fc500c520285cad8f5.=
camel@gmail.com/
>=20
> Link: https://lore.kernel.org/bpf/phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bq=
w6cjk2x7rt5@m2hl6enudv7d/
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Acked-by: Xu Kuohai <xukuohai@huawei.com>
> ---

I find derivation of these new rules logical.
Also tried a simple brute force testing of this algorithm for 6-bit
signed integers, and have not found any constraint violations:
https://github.com/eddyz87/bpf-and-brute-force-check

As a nitpick, I think that it would be good to have some shortened
version of the derivation in the comments alongside the code.
(Maybe with a link to the mailing list).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


