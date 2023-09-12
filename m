Return-Path: <bpf+bounces-9736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EAE79CC9B
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 12:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEBF28103B
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 10:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B4A168D1;
	Tue, 12 Sep 2023 09:59:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C773A168B5
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 09:59:53 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824F210C9
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 02:59:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ad8add163cso45826466b.2
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694512791; x=1695117591; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=77xIufsnULoXgsRsUwbE+ZmisUUZGYHpzMYxcHZZkmo=;
        b=Tz7HcqBi9zSNavo2y8eWsQvCrUWT9l2CZVd9Iwo1dz0hA28bRLKNDANh3Hp4qFLb8u
         88zi4Q3bH0GddJxem/Qp9e4yJH7AgdivVpJoOeBK5pFrVSDeIXVfVM3UnP54wxuhL+Yy
         FYyFpwCmxywndyUjIPuQxa59vpdUzLdmZaK34RaDwarHBN2KCm/Vj7IPl6/HFgLgYJtw
         /LSJBTHcSenvWulgMSZrIF/dbRLFDClCRHXoQX7jadjzyPLLus36w9p5GgDv8n+JSQGH
         oT0FU0xDpFFnRNKNPNo+AiYcsI8jxPS8bC8oJKXXIzs2GuZRp+MGdoxqcD2l8TQ053dw
         Ta3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694512791; x=1695117591;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=77xIufsnULoXgsRsUwbE+ZmisUUZGYHpzMYxcHZZkmo=;
        b=PqUayh0yKstHOEQrClYFLdlXwVkuxQlwJKUFFvBrATvyjhZQFCWISzqEiEVRsJ/fTB
         ThZfNrvU1Qv0yj1olXpyWjc6e5NxlQSaQKkEsqzHe+ygj4E3vKeUAGVh+9l0yF7nPpYa
         zLh/X4b+JsGV2jE6ePD8tsHvaDb4FXxl52XX9l6UG1x6lNEwIcDy3OqvPIvwyu+AkY1L
         8uPptYw5ylegdgXyNl76wl3ab2qAtiyEipCHfQEM4lIlQJYnWo/5J1NdVb9LwZpPlycv
         YH3iGne/GETkKEqmu1pg/Xj9KgWiNY5FYhykhUISM5yAXjG2vcJEAzILDQODepCNUdda
         ZZaQ==
X-Gm-Message-State: AOJu0Ywp18vd7O2Msf39g9WiESghtnicFWUm2yZe/twN+8JDloLVbG0R
	0tVpOu4QD3TQgnWxw38IPMU=
X-Google-Smtp-Source: AGHT+IHx8A+Xqy7FPviV+rbUx9d50+Sr/5hROj2lt7iwlpih53j6fff6hf1AAXYQGafivoLfYx7TUg==
X-Received: by 2002:a17:906:3117:b0:99b:6e54:bd6e with SMTP id 23-20020a170906311700b0099b6e54bd6emr9425141ejx.56.1694512790768;
        Tue, 12 Sep 2023 02:59:50 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090657ce00b00992afee724bsm6533015ejr.76.2023.09.12.02.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 02:59:50 -0700 (PDT)
Message-ID: <9aa33caeb63721ca9093b41cdddc9df7fdf31230.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Offloaded prog after
 non-offloaded should not cause BUG
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com, 
 yonghong.song@linux.dev, sdf@google.com, kuba@kernel.org,
 bpf@vger.kernel.org,  ast@kernel.org
Date: Tue, 12 Sep 2023 12:59:48 +0300
In-Reply-To: <d8194c20-443e-d574-18c5-cecc7c5ce702@linux.dev>
References: <20230912005539.2248244-1-eddyz87@gmail.com>
	 <20230912005539.2248244-3-eddyz87@gmail.com>
	 <d8194c20-443e-d574-18c5-cecc7c5ce702@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-09-11 at 23:26 -0700, Martin KaFai Lau wrote:
> On 9/11/23 5:55 PM, Eduard Zingerman wrote:
[...]
> > +int load_dummy_prog(char *name, __u32 ifindex, __u32 flags)
>=20
> I added static.
=20
[...]
> > +	tok =3D open_netns(LOCAL_NETNS);
>=20
> Also added NULL check for tok.

[...]
> > +	if (tok)
>=20
> close_netns() can handle NULL, so removed this tok check.
>=20
> Applied. Thanks for the fix and test!

Sorry, I should have noticed these issues before sending.
Thank you for fixing it up.

