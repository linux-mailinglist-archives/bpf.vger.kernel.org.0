Return-Path: <bpf+bounces-15642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 677C37F468C
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 13:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6FEB20BC1
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 12:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406843D973;
	Wed, 22 Nov 2023 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7Z8/Lok"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33322CB
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 04:46:13 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5098e423ba2so9438445e87.2
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 04:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700657171; x=1701261971; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aYDXdnkT1ekK7dG9g556QiA7XN+9BP6WLVnWdXb4qFk=;
        b=m7Z8/Lok5eEeFBbRlFeoEpl3uRXRm+XUO1RvFJoSyrn4UIwvVgBM8GyzY+/XzGcOQq
         gMdQcRR2rc30x+WpPFcqgu/ht/6g5V7rE/8yHmFKH3nD5M9Rlv9zSU4AyuEgOZX1/M1d
         kGC2Al7tH4Ru+zm2ENBRd/WC140b/Yx7fXUCncirodbV3GS/qpf//ZEHon73YD4d+EAc
         Ww8DInsMiGzfZCpnmzEUCC0d6tlfdCRx7L1Q1AMZeNIvjhzK9TdRTlXSAuu9ZkbpNi54
         Pew9sepyRrsw5jSK0u8J8BER4w2u4xNAOp8bkypmVQNxtMO3qglcMWb3N+YiY/3YD0Lm
         EeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700657171; x=1701261971;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYDXdnkT1ekK7dG9g556QiA7XN+9BP6WLVnWdXb4qFk=;
        b=p/SIfj09tICWRAN9nZAH66YdCRxcHruAbStuTrNcdsqcEyAJreYkiOPe9IO4wwfFsC
         XtWtYvVETvoDdJS5sPXSEd7MKUcwPCL7J92qadGvENHTVKkoYWQgCs7tyqAP1h1Dzs7h
         e5rnnqC6GttBLHfV25DH/f2CVBeBw5DAzyUIrXtqVfKUBQGvOZYky0wwND1UsUSmF1U1
         mvbZrGHBNouHlbejzXJ/0V5d7rW0U0WFINem7WmqqyEaC1xj6Otx5hB98lSCsK3NCp6e
         9ytHqtGABLs0JKfuYw5lfNEBKI7Nq5GR572xy8PuCHwHokiIGMPc/xniqW0fiIBRKCip
         2khA==
X-Gm-Message-State: AOJu0YyudIyZErWV6lDx70S9HrinN8Xi/lCJvx8ojMxBguTnfcnrjW0S
	wDOh49q5tyypjYh+mtEVVho=
X-Google-Smtp-Source: AGHT+IFOePfFRry+K3FreC3oO0Ki2QGlTRs0Sut6zFvrnXvEiJ9ymyJCM98EUaHifOuwI4Jk5FZIjw==
X-Received: by 2002:a19:644c:0:b0:503:3421:4ebd with SMTP id b12-20020a19644c000000b0050334214ebdmr1238803lfj.63.1700657171106;
        Wed, 22 Nov 2023 04:46:11 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id dw26-20020a0565122c9a00b0050aad0ded0dsm1057942lfb.113.2023.11.22.04.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:46:10 -0800 (PST)
Message-ID: <dc1a84bde2c62445b2bd05ea99dfc716d4724f6c.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: fix tracking of stack size for var-off access
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>
Cc: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  kernel-team@dataexmachina.dev
Date: Wed, 22 Nov 2023 14:46:09 +0200
In-Reply-To: <CACkBjsbWdOVMs7vRXvxi0MCoOAh+skYWFN1douBjkRzeTX=wvg@mail.gmail.com>
References: <20231113235008.127238-1-andreimatei1@gmail.com>
	 <CAEf4BzZbXML3oWaHejXRFNAG4NM2vGpsz9axjvOX6wKxEG+ExA@mail.gmail.com>
	 <CACkBjsbWdOVMs7vRXvxi0MCoOAh+skYWFN1douBjkRzeTX=wvg@mail.gmail.com>
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

On Tue, 2023-11-21 at 18:16 +0100, Hao Sun wrote:
[...]
> Yet, the sample direct read would be rejected:
>=20
> func#0 @0
> 0: R1=3Dctx() R10=3Dfp0
> 0: (bf) r6 =3D r10                      ; R6_w=3Dfp0 R10=3Dfp0
> 1: (61) r7 =3D *(u32 *)(r6 -200)
> invalid read from stack R6 off=3D-200 size=3D4
>=20
> Eduard, you added support for reading uninit slots, should we also add so=
mething
> like the following:
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8c2d31aa3d31..aa861d2da240 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6446,7 +6446,7 @@ static int check_stack_slot_within_bounds(int off,
>  {
>         int min_valid_off;
>=20
> -       if (t =3D=3D BPF_WRITE)
> +       if (t =3D=3D BPF_WRITE || env->allow_uninit_stack)
>                 min_valid_off =3D -MAX_BPF_STACK;
>         else
>                 min_valid_off =3D -state->allocated_stack;

I agree with your logic and this change seems reasonable.
Sorry for delayed response.

