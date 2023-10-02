Return-Path: <bpf+bounces-11201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64C97B53CF
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 15:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 926A6283B0C
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 13:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FCD18E32;
	Mon,  2 Oct 2023 13:19:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190918C3F
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 13:19:16 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D027D8
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 06:19:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50444e756deso21557208e87.0
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696252753; x=1696857553; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A2QTZBDsCJY6vGXtV6zK3IjU15Szb/XlwvWJDPAkttc=;
        b=KlD4CqKpUqVaRdB3u7+l4whbq5zYv3c7UHzf6qH3cq3IKLGDuYCjg9olPXjTyOm79O
         ujDsUnFjLlpushXOGBm7rvDdoQB1PtMjfmIX7+IohyaPSpf0wUosEGrlEXIDCPxzZubR
         2sxvNR2DTTOFXGpWWEFomuhTZVCLA/xh8zugHNHXC1A6yId8qxY2BUcsAFCtii9F6dWJ
         XT+boooDJ7+mnq4vY0EzOnnqzo+Iop2VlJACEG2DH+WAMLuAhogw3MzdDzkm/OmwNfRz
         OA7aBXuNedGbGUyY1sHDL349csjQ7Sc5PZK4U8gaRdDuRWCaf1w6k4RW0xLj/K3cv/e4
         TI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252753; x=1696857553;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2QTZBDsCJY6vGXtV6zK3IjU15Szb/XlwvWJDPAkttc=;
        b=hssocCuupCEtY64bycBPgbWsf/BmRjwY5tS1S4NsaqpGjTr3XnXDxETDX7pf4koEWe
         M09vT9dtD6SgMhjUfZif1e3f5ih7yFgDvVyCZHG5CrB4p7AWpkqE2T+jdNWqhYP7mj1h
         DDHL9xmGj2tExrdPZQfwpOQ2xZpVWe8i5YyHXjIwod8WI00bgOePaem/+fH9vIwfz5Xc
         XI23AMWS5/IAn/QXAhszj8WimWX5/Eikq1qrHCRiNptYPvVJtUDoC2lppHSDxR+PTF8y
         Mqg/Uvyi18JDy71AG4rDiXTGiVXKATnmVA0RSlEAng4KaVXbwA3u75bHsNa3yzEvf1bt
         RLzw==
X-Gm-Message-State: AOJu0Yz8z7oCj0nh+Pr/MapKxAJD1AwbgJ9fF8SzXGHRXZXP+VtMc4nA
	g8lwbSOtdzHk9bGstfpc82A=
X-Google-Smtp-Source: AGHT+IFioS7JWhtkkKuDzAxZJ6NGa6g6JRdj3ii6AKRV2jEL1rYcfuuPz3gRKk6pNbErQwqtlgrQUw==
X-Received: by 2002:a05:6512:280f:b0:500:7fc7:8521 with SMTP id cf15-20020a056512280f00b005007fc78521mr13038677lfb.64.1696252752969;
        Mon, 02 Oct 2023 06:19:12 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f13-20020a19380d000000b005056cc4b82bsm1560305lfa.229.2023.10.02.06.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:19:12 -0700 (PDT)
Message-ID: <57e6fefadaf3b2995bb259fa8e711c7220ce5290.camel@gmail.com>
Subject: Re: [Bpf] Signed modulo operations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Dave Thaler
	 <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "bpf@ietf.org" <bpf@ietf.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>
Date: Mon, 02 Oct 2023 16:19:11 +0300
In-Reply-To: <CAADnVQLg+p8uQ4JX16JAj8hMNji+OfManPymisO3c_o=ZseQdA@mail.gmail.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
	 <20220927185958.14995-7-dthaler1968@googlemail.com>
	 <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
	 <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
	 <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com>
	 <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
	 <PH7PR21MB387814B98538D7D23A611E89A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
	 <CAADnVQLg+p8uQ4JX16JAj8hMNji+OfManPymisO3c_o=ZseQdA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 2023-09-30 at 07:48 -0700, Alexei Starovoitov wrote:
> On Fri, Sep 29, 2023 at 2:03=E2=80=AFPM Dave Thaler
> <dthaler=3D40microsoft.com@dmarc.ietf.org> wrote:
> >=20
> > Perhaps text like the proposed snippet quoted in the exchange above sho=
uld be
> > added around the new text that now appears in the doc, i.e. the ambiguo=
us text
> > is currently:
> > > For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU`=
`,
> > > 'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'im=
m'
> > > is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and t=
hen
> > > interpreted as a 64-bit signed value.
>=20
> That's what we have in the doc and it's a correct description.
> Which part is ambiguous?
>=20

As far as I understand Dave suggests to add exact specification for
the SMOD instruction as "signed modulo" might have different definitions [1=
].

I double checked and current clang implementation generates SMOD for
LLVM's 'srem' operation [2], which follows C semantics and defines
remainder as:

  remainder =3D a - n * trunc(divident / divisor)

> This instruction returns the remainder of a division (where the
> result is either zero or has the same sign as the dividend, op1)

And this is consistent with interpreter logic in core.c, e.g.:

	ALU64_MOD_K:
		switch (OFF) {
		case 0: ... break;
		case 1:
			AX =3D div64_s64(DST, IMM); /* implemented as '/' */
			DST =3D DST - AX * IMM;
			break;
		}
		CONT;

[1] https://en.wikipedia.org/wiki/Modulo
[2] https://llvm.org/docs/LangRef.html#srem-instruction

