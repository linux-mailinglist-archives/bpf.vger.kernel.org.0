Return-Path: <bpf+bounces-11963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F537C6036
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 00:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472AB1C209E6
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 22:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA89249E8;
	Wed, 11 Oct 2023 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c61g5YNW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F8249E2
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:14:45 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001BB91
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:14:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50305abe5f0so503397e87.2
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697062482; x=1697667282; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c4Hw2QjF7uomNkpyrrQrJqUZ8qfvURzS1mbxQaF4shg=;
        b=c61g5YNW2uT+x8pGfmMucfnnpZ62Tycta5Fd23AaaYn38jkjtDNgqQ53tuZo/PQp1y
         M4d0deNLwjUaArVRD/G2Wis1a891SePVKLwVbUq3U6vlfaRzTZvJW655Lyi335/rcy/e
         4J0Gh7B7OHW23Ha1RTdrr1k/5O8jlazf/Rnz3KWW/dNrkerAIfCPz7uB1l5Qi53bk+MP
         03KJFrfpvGpNO6Sev3oC7Tg2ubwdUW7FUd46eHVx5AE0GR97y7xNV3EhMcZpxT6rrodJ
         y+C30KJRfGrjIlDWKtVd3B2qrdPMTQRx3rAaGrEEtSBKzs81QhYD7TInmuMpE7r4Ijlg
         o5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697062482; x=1697667282;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4Hw2QjF7uomNkpyrrQrJqUZ8qfvURzS1mbxQaF4shg=;
        b=Q9TDc7Epu43NcDnbhmOHEpMZPlCITyWPPqeL8/F25VpebKEvfbzLR182ggx3ATKGXh
         VjkDmdjPv5f2CQKt0xZ1ldXAzGfWtLqfZmbXu8JGIrp0jTU+XVSvVAo3BbqEUZL6LJ2z
         EXaocBXirMmNDIt7Rrilc7kgZSM0TDuNL/9fgSKEogL4KVb02eOHTGBPj6BgC59DNbAN
         MdTSLj+nmrxXuxwnzJENHtrBquCG3fhPbRm+fd3gtmXfFIe3npArecNH1fZl3dZf5WIc
         u+XPEf/UCIrNdDU6STy0Pby3xXMRyVq1VeijBYyGVxaCI1F3CegvGPcUoTWcapRbz2re
         J2LQ==
X-Gm-Message-State: AOJu0Yycu7jvexY1MvIF9+UKPZW4vIwhDN0rboufsv0Sy4UA9Vs7ND9h
	YOyarodipyi3Nu7XR3Oei94=
X-Google-Smtp-Source: AGHT+IHCRD9ruioFugW2RZ04J8Cpf1HfoFrozRoKLuUY570DyI44OFPxieu9u116aNx+Ts/xIq89GQ==
X-Received: by 2002:a05:6512:3f18:b0:503:35bb:1e74 with SMTP id y24-20020a0565123f1800b0050335bb1e74mr18592606lfa.61.1697062481927;
        Wed, 11 Oct 2023 15:14:41 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id p9-20020a2e7409000000b002bfe8537f37sm3172561ljc.33.2023.10.11.15.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:14:41 -0700 (PDT)
Message-ID: <07a9eb9eaa6cd424ac5025f76ea620eae6062c54.camel@gmail.com>
Subject: Re: [RFC dwarves 3/4] pahole: add
 --btf_features=feature1[,feature2...] support
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org,  sdf@google.com,
 haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org, Andrii Nakryiko
 <andrii@kernel.org>
Date: Thu, 12 Oct 2023 01:14:39 +0300
In-Reply-To: <7b4ff1c8-f8c7-b96e-c581-f27a389379f0@oracle.com>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
	 <20231011091732.93254-4-alan.maguire@oracle.com>
	 <b7b61031f41ab4082205ed061bb66cb859bd1f0d.camel@gmail.com>
	 <f822334f-335e-bd38-09c7-95c69086ba6f@oracle.com>
	 <5b40ffbfa5949c24dad44ed6adf70d35cf72f757.camel@gmail.com>
	 <7b4ff1c8-f8c7-b96e-c581-f27a389379f0@oracle.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-11 at 23:05 +0100, Alan Maguire wrote:
[...]
> > > > I'm not sure I understand the logic behind "skip" features.
> > > > Take `decl_tag` for example:
> > > > - by default conf_load->skip_encoding_btf_decl_tag is 0;
> > > > - if `--btf_features=3Ddecl_tag` is passed it is still 0 because of=
 the
> > > >   `skip ? false : true` logic.
> > > >=20
> > > > If there is no way to change "skip" features why listing these at a=
ll?
> > > >=20
> > > You're right; in the case of a skip feature, I think we need the
> > > following behaviour
> > >=20
> > > 1. we skip the encoding by default (so the equivalent of
> > > --skip_encoding_btf_decl_tag, setting skip_encoding_btf_decl_tag
> > > to true
> > >=20
> > > 2. if the user however specifies the logical inversion of the skip
> > > feature in --btf_features (in this case "decl_tag" - or "all")
> > > skip_encoding_btf_decl_tag is set to false.
> > >=20
> > > So in my code we had 2 above but not 1. If both were in place I think
> > > we'd have the right set of behaviours. Does that sound right?
> >=20
> > You mean when --features=3D? is specified we default to
> > conf_load->skip_encoding_btf_decl_tag =3D true, and set it to false onl=
y
> > if "all" or "decl_tag" is listed in features, right?
> >=20
>=20
> Yep. Here's the comment I was thinking of adding for the next version,
> hopefully it clarifies this all a bit more than the original.
>=20
> +/* --btf_features=3Dfeature1[,feature2,..] allows us to specify
> + * a list of requested BTF features or "all" to enable all features.
> + * These are translated into the appropriate conf_load values via
> + * struct btf_feature which specifies the associated conf_load
> + * boolean field and whether its default (representing the feature being
> + * off) is false or true.
> + *
> + * btf_features is for opting _into_ features so for a case like
> + * conf_load->btf_gen_floats, the translation is simple; the presence
> + * of the "float" feature in --btf_features sets conf_load->btf_gen_floa=
ts
> + * to true.
> + *
> + * The more confusing case is for features that are enabled unless
> + * skipping them is specified; for example
> + * conf_load->skip_encoding_btf_type_tag.  By default - to support
> + * the opt-in model of only enabling features the user asks for -
> + * conf_load->skip_encoding_btf_type_tag is set to true (meaning no
> + * type_tags) and it is only set to false if --btf_features contains
> + * the "type_tag" feature.
> + *
> + * So from the user perspective, all features specified via
> + * --btf_features are enabled, and if a feature is not specified,
> + * it is disabled.
>   */

Sounds reasonable. Maybe also add a line saying that
skip_encoding_btf_decl_tag defaults to false if --btf_features is not
specified to remain backwards compatible?

Thanks,
Eduard

[...]

