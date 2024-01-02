Return-Path: <bpf+bounces-18779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5B2822098
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 18:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B7C1C226B6
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 17:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED2156C4;
	Tue,  2 Jan 2024 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXzB7oeF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF229156C7
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso3716990a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 09:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704217681; x=1704822481; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vSUOO60rLEVEVmp75iV59iLLYAb7ftSlOa2ZLUeioVY=;
        b=XXzB7oeFspInCkr5H5lE8rA0Oi07h8R502iOoD2A4RWMTXBYLwpBaOqdy3oHzNbyfc
         VDlylFmfE6XVZhvZ0RtL7bBTd1MEPeHd6FMMe3P8qNtGbVaTM4rVgFSmZ02+hXpdHrEA
         18Y8A3YVQj3i/tFpM9UTxuFtcNeXBeQmLKywPWwEpfgiUI0BFGibsHOmJtiIf86Sbrwe
         FbzfLE9OkfGhEv4S5JT0U6oqu/tlwSiYz12e7DCHi4RKFsoYVhZrGdXc+H+T3UidqbZu
         5/oL2IQxqrWn/w9cCru8y6JxlP0D4Qrsuk/yBf35KJwPyEIM1L75RZzv1gEABNyon/h7
         3TBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704217681; x=1704822481;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSUOO60rLEVEVmp75iV59iLLYAb7ftSlOa2ZLUeioVY=;
        b=w1INQMNuhg5+1kQ3HVzSKotuIz8+fSOA5oXRinJOpoW2KQMhMhTK+AWLhoctFniPQQ
         7eAkRzOX8MJQUfSxNfhMbmwv/3F0NCmhGua/i9fLLuzkiBqyrMowOmGzH+/CYmE5lDQR
         zsP8vfJKJx1uyCo68EBp38yvMT7fnEKqJ4vaFJ9m+rbi9SYvuCF//bonVunWAjby8iBp
         hmnWnUPSMF5YkN8fx/rnqMKEV7W56nK729RkO/9GUcxVDZxWssEHyxacTeOYUvDauq/e
         sdelC5iVZfwj5RATukjUNwY6Rmh5gO97alwpjsYoqkN53n7y6O6mL9IO/dMh6O/NvBCr
         CbtA==
X-Gm-Message-State: AOJu0YwLbaTVgY1MMrDFzOz1A6anolMgFaqj8UGUe51bgsqrDJOrg5Lb
	JhXVvWBIZ6/1z+jt9R7OdVw=
X-Google-Smtp-Source: AGHT+IF9Kc7rq3K1DG1paAwncodUBDc7Ealqhsy9LyXWfO7M6big/zKNk1QoCSeVT0LrjJjAaXMCnQ==
X-Received: by 2002:a50:c049:0:b0:552:d790:ce07 with SMTP id u9-20020a50c049000000b00552d790ce07mr11434786edd.36.1704217680787;
        Tue, 02 Jan 2024 09:48:00 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f11-20020a056402004b00b005557bbb81bfsm7472927edu.79.2024.01.02.09.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 09:47:59 -0800 (PST)
Message-ID: <28bcf5ae2df9ed0bd1603ed161e1d4488694c0d9.camel@gmail.com>
Subject: Re: test_kmod.sh fails with constant blinding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Bram Schuur
	 <bschuur@stackstate.com>, "ykaliuta@redhat.com" <ykaliuta@redhat.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"johan.almbladh@anyfinetworks.com"
	 <johan.almbladh@anyfinetworks.com>
Date: Tue, 02 Jan 2024 19:47:58 +0200
In-Reply-To: <08287f7c-d0aa-4ded-a26d-34023051dd14@linux.dev>
References: 
	<AM0PR0202MB3412F6D0F59E5EBA0CA74747C461A@AM0PR0202MB3412.eurprd02.prod.outlook.com>
	 <08287f7c-d0aa-4ded-a26d-34023051dd14@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-02 at 08:56 -0800, Yonghong Song wrote:
> On 1/2/24 7:11 AM, Bram Schuur wrote:
> > Me and my colleague Jan-Gerd Tenberge encountered this issue in product=
ion on the 5.15, 6.1 and 6.2 kernel versions. We make a small reproducible =
case that might help find the root cause:
> >=20
> > simple_repo.c:
> >=20
> > #include <linux/bpf.h>
> > #include <bpf/bpf_helpers.h>
> >=20
> > SEC("socket")
> > int socket__http_filter(struct __sk_buff* skb) {
> >  =C2=A0 volatile __u32 r =3D bpf_get_prandom_u32();
> >  =C2=A0 if (r =3D=3D 0) {
> >  =C2=A0 =C2=A0 goto done;
> >  =C2=A0 }
> >=20
> >=20
> > #pragma clang loop unroll(full)
> >  =C2=A0 for (int i =3D 0; i < 12000; i++) {
> >  =C2=A0 =C2=A0 r +=3D 1;
> >  =C2=A0 }
> >=20
> > #pragma clang loop unroll(full)
> >  =C2=A0 for (int i =3D 0; i < 12000; i++) {
> >  =C2=A0 =C2=A0 r +=3D 1;
> >  =C2=A0 }
> > done:
> >  =C2=A0 return r;
> > }
> >=20
> > Looking at kernel/bpf/core.c it seems that during constant blinding eve=
ry instruction which has an constant operand gets 2 additional instructions=
. This increases the amount of instructions between the JMP and target of t=
he JMP cause rewrite of the JMP to fail because the offset becomes bigger t=
han S16_MAX.
>=20
> This is indeed possible as verifier might increase insn account in variou=
s cases.
> -mcpu=3Dv4 is designed to solve this problem but it is only available at =
6.6 and above.

There might be situations when -mcpu=3Dv4 won't help, as currently llvm
would generate long jumps only when it knows at compile time that jump
is indeed long. However here constant blinding would probably triple
the size of the loop body, so for llvm this jump won't be long.

If we consider this corner case an issue, it might be possible to fix
it by teaching bpf_jit_blind_constants() to insert 'BPF_JMP32 | BPF_JA'
when jump targets cross the 2**16 thresholds.
Wdyt?

