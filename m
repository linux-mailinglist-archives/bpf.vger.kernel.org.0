Return-Path: <bpf+bounces-15343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8387F0A86
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 03:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158E51C208C8
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 02:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A7D1FB2;
	Mon, 20 Nov 2023 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+rlJiHb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDA3BC
	for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 18:23:39 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so5199074a12.3
        for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 18:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700447017; x=1701051817; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8XMBi1+fGrafPVMd1xya3GtPdxGhnLmu8fKW2gzcR+A=;
        b=N+rlJiHbtTaxjCLW9Pk4hZDAvtyH0hszENGFGWQDwObW3Mw86HopwoLLwVQjVS9DGO
         EcuDsypePkoW/yFli06b9YYZWo8rD5iHTzL75C4M0UGPF27t8ynAYPeNB1MavOCSPvLn
         /ByNa/lsnuwKwGaRiNm9cfTFCPegdH0u3nyBcAAMfu6AmvPwfMwtGqJwGQJtJwr4wkaF
         6ujGURUB5aHXOWUzvivZWoXGwEpLhkhkA/hlYa0E25UJv1LwUtWDd4N4Hgk3czDgpqEG
         QGsOj6aS2bceV+1QHk/JqluUr3Gn5Pdeb7aXbdtcEIfzgHrvydbDkDQLkY3H4Ka4loGI
         bi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700447017; x=1701051817;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XMBi1+fGrafPVMd1xya3GtPdxGhnLmu8fKW2gzcR+A=;
        b=hztM5+FPEocek0IVpF+tSx3ff36JfbdvuXYsfQWN5+E6NuAuG9mVEJ8rz6Xhz0fxFH
         WbRPa4Iyz/utf8GuqF1fWeAoU8EsfP+BfZgZmcKWY8OUMEjjDHzIOVMgzU8kTrz+SSUx
         9jkAUDmboG8HUiLKfRXDnfAeIix1vMPAgQCBO4dZEowr5KQJ+mvO8Vq99BTBCvOdwQfo
         YmFcNoQBZUz5Y+zyGlHAHYL0Sg/PgKSuVHMhdwgOPGleOslKq5TuV3HZtkJUflH65bfF
         1YMWlqsakTXlhlIdbsgHxng19Ih0IIwCkhEE0F45I6TQGrlwA0wIecpm4NrhV5itgk41
         iKcw==
X-Gm-Message-State: AOJu0YwcLuFdvpadpkulv9h+vRZ50XiUNOtN3VKSguOlDUzx8RT1Ne9h
	T5QIg/CRIZEWAT3yNZYjz7lSR5yUKSM=
X-Google-Smtp-Source: AGHT+IETY5B8ysMGROMMRI2YtqeCKmVSg3R0BxgZaUeN1jOZJ9USHxZ6uAq09WlrknUrmqkOwPNkfg==
X-Received: by 2002:a17:907:3e9f:b0:9e4:67f7:aa04 with SMTP id hs31-20020a1709073e9f00b009e467f7aa04mr5466652ejc.58.1700447017228;
        Sun, 19 Nov 2023 18:23:37 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m20-20020a1709062b9400b009f2c769b4ebsm3379943ejg.151.2023.11.19.18.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 18:23:36 -0800 (PST)
Message-ID: <3505860e9e272f3bba3d05ca23c70e4700fcdc5d.camel@gmail.com>
Subject: Re: [PATCH bpf v2 11/11] selftests/bpf: check if max number of
 bpf_loop iterations is tracked
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Andrew Werner <awerner32@gmail.com>
Date: Mon, 20 Nov 2023 04:23:35 +0200
In-Reply-To: <CAADnVQKw78ENkqFa65W9gxY-VEhz8-7GtbRtA=WwtnipRkmtyA@mail.gmail.com>
References: <20231118013355.7943-1-eddyz87@gmail.com>
	 <20231118013355.7943-12-eddyz87@gmail.com>
	 <CAADnVQKw78ENkqFa65W9gxY-VEhz8-7GtbRtA=WwtnipRkmtyA@mail.gmail.com>
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

On Sun, 2023-11-19 at 18:09 -0800, Alexei Starovoitov wrote:
[...]
> > +       register unsigned i asm("r2");
> > +       register __u8 *p asm("r1");
>=20
> I suspect this is fragile.
> The compiler will use r2 for 'i' if 'i' is actually there,
> but if it can optimize 'i' and 'p' away the r1 and r2 may be used
> for something else.
> The "register" keyword is not mandatory. Unlike "volatile".
[...]
> > +       if (a !=3D 0 && a !=3D 1 && a !=3D 11 && a !=3D 101 && a !=3D 1=
11 &&
> > +           b !=3D 0 && b !=3D 1 && b !=3D 11 && b !=3D 101 && b !=3D 1=
11)
> > +               asm volatile ("r0 /=3D 0;" ::: "r0");
> > +       /* Instruction for match in __msg spec. */
> > +       asm volatile ("*(u8 *)(r1 + 0) =3D r2;" :: "r"(p), "r"(i) : "me=
mory");
>=20
> Feels even more fragile. Not sure what gcc will do.
> Can 'i' be checked as run-time value ?
> If it passes the verifier and after bpf_prog_run the 'i' is equal
> to expected value we're good, no?

Runtime check should work, thank you for this suggestion.
I'll remove unnecessary 'asm' blocks and use __retval instead
('r0 /=3D 0' will remain).

