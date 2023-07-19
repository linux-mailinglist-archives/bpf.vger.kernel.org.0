Return-Path: <bpf+bounces-5283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F887595F7
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A354B1C20B5F
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3C814A9A;
	Wed, 19 Jul 2023 12:53:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3547312B79
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 12:53:57 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A14113
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 05:53:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fba86f069bso11288340e87.3
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689771234; x=1692363234;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E9xFMnxN81eE1w65KpoSQZ/8+ewnClwDhHzw0zExB2E=;
        b=aiyJWjwjbMZUpt3PY2Ay3XX3N+NHgt6GOPamQYAM1SPuQG4BNxjwZ/BoKQ9DjwtYE9
         /M9LS+z9n2yiEqI9WCQ1J77ue/1pQrFQxwjEwuKvt+bF1E0W0FQ48197vy4rEl2AMz4q
         RpImkkFhf8sJd72t3DQz3cqEn4BTmtBrLKSkpHuwg5ffaUpeZKlXPTvZOYMta0e3mfSB
         2aoewHSzcNdRAJD8kL6jSraiXV107A1LYuaxsxrQSnBFbDkV3BKdFxw/0f6Ak4WfuO6U
         /NcBhtn9LmAEazCvEWbl7RMyW0v5o4IKVU8N8hSukO+mY0KTWWZGue+j6/6k/p+ilNUO
         O9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689771234; x=1692363234;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9xFMnxN81eE1w65KpoSQZ/8+ewnClwDhHzw0zExB2E=;
        b=kXA5BxEgrL1TZP3CsKx6b264m1y8UmFn2AmOcSeThl1G7HWtZ6aXg+uCbtFZCUwCKs
         uoxXmbGLg9IjAYotPw67AAR5AOz8s1tG9O6sCBfDZ/xPFxwyDvCRB0XV0rqRdR02fKbO
         +Btd69pDQbpm0k12mTpMu+0OvfxTisnj4f3KEXE29D7s3qKpc0iT7V+tpjSHdYUVLJ9b
         98ou1iID/wW3zvSOig2+pTRoCCLci+ksX1sZVmQMJfr+Tuwnn7vMoc3QBfJzabbGk0+J
         SFR5+HH2TfuufmGh4ryKfJxeUMQJGFhZHMZdiJM1Wo9B1DUI8ZJAyBfHt12wPZYVU9ny
         2qcQ==
X-Gm-Message-State: ABy/qLbDFgipksQo02Zh13ELY3ncZuKXQVgdgSBXHUOGl5LfLYFz7G3B
	We0PSOMVHquYhYgKyp9nYWEfs7tnaOII/g==
X-Google-Smtp-Source: APBJJlGMJLWMPqeV6tAY56kvL/FAdq9A8CNqD5zGWmZKNy8DEf/D1fppwdD9Xj9RQxd+5r4ZKKM1aw==
X-Received: by 2002:a05:6512:3b83:b0:4fc:3756:754e with SMTP id g3-20020a0565123b8300b004fc3756754emr2230615lfv.56.1689771233705;
        Wed, 19 Jul 2023 05:53:53 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v10-20020ac2592a000000b004f84b36a24fsm933164lfi.51.2023.07.19.05.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 05:53:53 -0700 (PDT)
Message-ID: <40a3d3842ee4fc3323bca7112dd832486b7bed4f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/15] bpf: Support new sign-extension mov
 insns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@meta.com>, Yonghong Song <yhs@fb.com>, 
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song
 <maskray@google.com>, kernel-team@fb.com
Date: Wed, 19 Jul 2023 15:53:52 +0300
In-Reply-To: <356fc6bf-77cb-abbc-f7cf-3d2678ffa83b@meta.com>
References: <20230713060718.388258-1-yhs@fb.com>
	 <20230713060734.390551-1-yhs@fb.com>
	 <5b1f7cd2a995882a05fcfdef78bb1390794c2603.camel@gmail.com>
	 <356fc6bf-77cb-abbc-f7cf-3d2678ffa83b@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-18 at 18:17 -0700, Yonghong Song wrote:
[...]
> > > > +static void emit_movsx_reg(u8 **pprog, int num_bits, bool is64, u3=
2 dst_reg,
> > > > +			   u32 src_reg)
> > > > +{
> > > > +	u8 *prog =3D *pprog;
> > > > +
> > > > +	if (is64) {
> > > > +		/* movs[b,w,l]q dst, src */
> > > > +		if (num_bits =3D=3D 8)
> > > > +			EMIT4(add_2mod(0x48, src_reg, dst_reg), 0x0f, 0xbe,
> > > > +			      add_2reg(0xC0, src_reg, dst_reg));
> > > > +		else if (num_bits =3D=3D 16)
> > > > +			EMIT4(add_2mod(0x48, src_reg, dst_reg), 0x0f, 0xbf,
> > > > +			      add_2reg(0xC0, src_reg, dst_reg));
> > > > +		else if (num_bits =3D=3D 32)
> > > > +			EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x63,
> > > > +			      add_2reg(0xC0, src_reg, dst_reg));
> > > > +	} else {
> > > > +		/* movs[b,w]l dst, src */
> > > > +		if (num_bits =3D=3D 8) {
> > > > +			EMIT4(add_2mod(0x40, src_reg, dst_reg), 0x0f, 0xbe,
> > > > +			      add_2reg(0xC0, src_reg, dst_reg));
> >=20
> > Nit: As far as I understand 4-126 Vol. 2B of [1]
> >       the 0x40 prefix (REX prefix) is optional here
> >       (same as implemented below for num_bits =3D=3D 16).
>=20
> I think 0x40 prefix at least neededif register is from R8 - R15?

Yes, please see below.

> I use this website to do asm/disasm experiments and did
> try various combinations with first 8 and later 8 registers
> and it seems correct results are generated.

It seems all roads lead to that web-site, I used it as well :)
Today I learned that the following could be used:

  echo 'movsx rax,ax' | as -o /dev/null -aln -msyntax=3Dintel -mnaked-reg
 =20
Which opens a road to scripting experiments.

> >=20
> > [1] https://cdrdv2.intel.com/v1/dl/getContent/671200
> >=20
> >=20
> > > > +		} else if (num_bits =3D=3D 16) {
> > > > +			if (is_ereg(dst_reg) || is_ereg(src_reg))
> > > > +				EMIT1(add_2mod(0x40, src_reg, dst_reg));
> > > > +			EMIT3(add_2mod(0x0f, src_reg, dst_reg), 0xbf,
> >=20
> > Nit: Basing on the same manual I don't understand why
> >       add_2mod(0x0f, src_reg, dst_reg) is used, '0xf' should suffice
> >       (but I tried it both ways and it works...).
>=20
>  From the above online assembler website.
>=20
> But I will check the doc to see whether it can be simplified.

I tried all combinations of r0..r9 for 64/32-bit destinations,
32/16/8 sources [1]:
- 0x40 based prefix is generated if any of the following is true:
  - dst is 64 bit
  - dst is ereg
  - src is ereg
  - dst is 32-bit and src is 'sil' (part of 'rsi', used for r2)
    (!) This one is surprising and web-site shows the same results.
        For example `movsx eax,sil` is encoded as `40 0F BE C6`,
        disassembling `0F BE C6` (w/o prefix) gives `movsx eax,dh`.
- opcodes:
  - 63      64-bit dst, 32-bit src
  - 0F BF   64-bit dst, 16-bit src
  - 0F BE   64-bit dst,  8-bit src
  - 0F BF   32-bit dst, 16-bit src (same as 64-bit dst)
  - 0F BE   32-bit dst,  8-bit src (same as 64-bit dst)
 =20
Script is at [2] (it is not particularly interesting, but in case if
you want to tweak it).

[1] https://gist.github.com/eddyz87/94b35fd89f023c43dd2480e196b28ea1
[2] https://gist.github.com/eddyz87/60991379c547df11d30fa91901862227

> > > > +			      add_2reg(0xC0, src_reg, dst_reg));
> > > > +		}
> > > > +	}
> > > > +
> > > > +	*pprog =3D prog;
> > > > +}
[...]

