Return-Path: <bpf+bounces-17839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A40B81343C
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80621F20F42
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04E85C8E3;
	Thu, 14 Dec 2023 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsoWB1UD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF7D4B;
	Thu, 14 Dec 2023 07:10:35 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so67437185e9.3;
        Thu, 14 Dec 2023 07:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702566634; x=1703171434; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EvtzWefn1WPNp4reMmyULAN0Mj1CqMWBOzDb+RWo1TU=;
        b=fsoWB1UD1b2sRnQ3Fg8FSVEDsxHRGO0CoBB3n58rA4LbezLBaTPjxl+04f52hPBvaK
         FPU5Kj3ZYtjlVS6LCweW/GodbndGrtxLGxVec5w6e8CjOn6AY32GJlgBWN0JThvrOdMu
         5GFhY5Wk84eIRkjfFh5XQB+4xmkQ94Dl6kuvQui+7n1CG4DE1IG74Qa0ABMXxKg+NO28
         wkqFTvwOOJh18BZQRs3QGk3R6ZTvqhkNJbpo7NWoZ+nvGRGmDvIluJfXDrhO+aQfqIF4
         hDKgfoR6JA+/vDKtSn2etwQv6Fz82gcagPf9xIy8jrP25ZVGb1V5voHZOeITNlw5yW7n
         mUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566634; x=1703171434;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvtzWefn1WPNp4reMmyULAN0Mj1CqMWBOzDb+RWo1TU=;
        b=vNILBF22Z0DWFDWZfSfzn0/URkqngEcnE8efKaIsnzsGc955/zLfT1j+LPtDkN5xaJ
         ubxoTRVFjRIlUp9ECJw/7ieFjXx79eHv3AZMOWX3WVTVwwZKLp2gNqAjXjF0U9q1IpJj
         uT07RjruRDyZzeP39kwcnoLO9Hj35w18Ek2mCXohZLbUSBfVW0UlthaGQq840LDlMxMF
         8OCJhqXQ/A9Do5SH3n2apvRGJACInUJO0O1DqrAbfOi/4qvIPb6sQjr6QrZSyws4JMsa
         RRcAW7bs2ckM8Hf1O9KRC6yY4p22mcxDP8evdxcByEUNCqjnx9Owi6vO/r6Mu5vrJGxp
         yIGA==
X-Gm-Message-State: AOJu0YxEHaU0KrA7g9SZ45uJeuD/co6bONPKQxHPcJmbTM4a8oz7xUMs
	zrLR3NxjQ/W9at88GkyoqMQ=
X-Google-Smtp-Source: AGHT+IGZ8puUQcAZ8Zi5ZuXaAQ8xvw/HxS9GlZLfpUI2wiUByVxFBXkmzOrFaIy4zcQXitIiumQ/gg==
X-Received: by 2002:a7b:c410:0:b0:40c:2ba6:81e with SMTP id k16-20020a7bc410000000b0040c2ba6081emr5135071wmi.121.1702566633586;
        Thu, 14 Dec 2023 07:10:33 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b0040c45071c18sm17016455wmo.39.2023.12.14.07.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:10:32 -0800 (PST)
Message-ID: <9dee19c7d39795242c15b2f7aa56fb4a6c3ebffa.camel@gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>
Date: Thu, 14 Dec 2023 17:10:31 +0200
In-Reply-To: <917DAD9F-8697-45B8-8890-D33393F6CDF1@gmail.com>
References: 
	<CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
	 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
	 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
	 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
	 <917DAD9F-8697-45B8-8890-D33393F6CDF1@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

[...]
> The reason why retval checks fails is that the way you disable dead
> code removal pass is not complete. Disable opt_remove_dead_code()
> just prevent the instruction #30 from being removed, but also note
> opt_hard_wire_dead_code_branches(), which convert conditional jump
> into unconditional one, so #30 is still skipped.
>=20
> > Note that I tried this test with two functions:
> > - bpf_get_current_cgroup_id, with this function I get retval 2, not 4 :=
)
> > - bpf_get_prandom_u32, with this function I get a random retval each ti=
me.
> >=20
> > What is the expectation when 'bpf_get_current_cgroup_id' is used?
> > That it is some known (to us) number, but verifier treats it as unknown=
 scalar?
> >=20
>=20
> Either one would work, but to make #30 always taken, r0 should be
> non-zero.

Oh, thank you, I made opt_hard_wire_dead_code_branches() a noop,
replaced r0 =3D 0x4 by r0 /=3D 0 and see "divide error: 0000 [#1] PREEMPT S=
MP NOPTI"
error in the kernel log on every second or third run of the test
(when using prandom).

Working to minimize the test case will share results a bit later.

