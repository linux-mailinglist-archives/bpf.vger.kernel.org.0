Return-Path: <bpf+bounces-15341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7D47F0A7A
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 03:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10371F21643
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 02:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A081878;
	Mon, 20 Nov 2023 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iigN4vPb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515AF95
	for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 18:10:01 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4094301d505so10800735e9.2
        for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 18:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700446200; x=1701051000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3B0IuUB2NM62xV1krahzZD/JLHQpKp4AioqK62vE5c=;
        b=iigN4vPb9Hdl6+2TUURbpPmIWamdIi53EwGR6u2Qqm7F3wFPAygek2CAccD8n4JCwg
         sXQXjBu9prsHpdI5W8LxJgLGiyjDy/vVY5Nx6bRnQebjkrVMi2bHxLIeYsiiMUSqBa7S
         GicgkJYrPKpcCyilD3B0F4EtWEqDQmNwxszhPyKkr37tvW+8JuzydPCAmRpiNywZJvBN
         S3pZ2lqk/qMoWUuvlVPpmDWYM2ORDlYYeO77B2/0cTegGGTO3sRvJWggYnlIhYEli+t0
         Agm2uvis5m0bnSFY27+xl+IDZjj7CBoc5rxrQkhm0hyupTQMdJvenU6sSBWQdQWDt6Vl
         YjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700446200; x=1701051000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3B0IuUB2NM62xV1krahzZD/JLHQpKp4AioqK62vE5c=;
        b=B1NpMCMUpGv7BZSqOvNo/0v4GCl45W24DGVLT7BscRzjS2WfZi7hiZoxQe2hVEXmBg
         hDmsiOMiCBzOqcRsw0j4Oebo4Dj140T9XyTd728kOxWEZxDXOkT181NKPzOpTa7tDG/R
         232v7Gpnfhok3/bAqKHK4NfCZeICp5XctR7KQI3cAUq7iNeU3aMUTVqo0/xBvWb2Qo6w
         qLX53IeaAIM80pV/1BoyxOCC/FikRcN5clDFFNShuSizaKQrb+qmQ3AGgGuHMeX970mX
         Vv1o6w9XkF+H66PEuFI43UMKfRcvB13i9DHTU51VFE4vAsEDkZcfR2McWVloyRE14VtP
         ZgPw==
X-Gm-Message-State: AOJu0YxMwSiyal9KIk2tpp8BCnnHth2F3XsOJ1383i+2kaUgfB6GOUam
	5OkVvw2UgtB8Yb0GfydZapMPPCtP9KZ0UR4t4ik=
X-Google-Smtp-Source: AGHT+IHxsABTUoz90muCokb+j2MCul2+JK92LHa5ZyLyWNMaTGIzWwCkUCxTp+sMDRKrD5zFqONSaIt3rOejhrwWm50=
X-Received: by 2002:a5d:574e:0:b0:32f:810e:8a3f with SMTP id
 q14-20020a5d574e000000b0032f810e8a3fmr3451312wrw.14.1700446199629; Sun, 19
 Nov 2023 18:09:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118013355.7943-1-eddyz87@gmail.com> <20231118013355.7943-12-eddyz87@gmail.com>
In-Reply-To: <20231118013355.7943-12-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 19 Nov 2023 18:09:48 -0800
Message-ID: <CAADnVQKw78ENkqFa65W9gxY-VEhz8-7GtbRtA=WwtnipRkmtyA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 11/11] selftests/bpf: check if max number of
 bpf_loop iterations is tracked
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Werner <awerner32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 5:34=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
> +
> +SEC("?raw_tp")
> +__success __log_level(2)
> +/* Check that path visiting every callback function once had been
> + * reached by verifier. Variable 'i' below (stored as r2) serves
> + * as a flag, with each decimal digit corresponding to a callback
> + * visit marker.
> + */
> +__msg("(73) *(u8 *)(r1 +0) =3D r2          ; R1_w=3Dmap_value(off=3D0,ks=
=3D4,vs=3D2,imm=3D0) R2_w=3D111111")
> +int bpf_loop_iter_limit_nested(void *unused)
> +{
> +       struct num_context ctx1 =3D { .i =3D 0 };
> +       struct num_context ctx2 =3D { .i =3D 0 };
> +       /* Set registers for 'i' and 'p' to get guaranteed asm
> +        * instruction shape for __msg matching.
> +        */
> +       register unsigned i asm("r2");
> +       register __u8 *p asm("r1");

I suspect this is fragile.
The compiler will use r2 for 'i' if 'i' is actually there,
but if it can optimize 'i' and 'p' away the r1 and r2 may be used
for something else.
The "register" keyword is not mandatory. Unlike "volatile".

> +       unsigned a, b;
> +
> +       bpf_loop(1, iter_limit_level1_cb, &ctx1, 0);
> +       bpf_loop(1, iter_limit_level1_cb, &ctx2, 0);
> +       a =3D ctx1.i;
> +       b =3D ctx2.i;
> +       i =3D a * 1000 + b;
> +       /* Force 'ctx1.i' and 'ctx2.i' precise. */
> +       p =3D &choice_arr[(a % 2 + b % 2) % 2];
> +       /* Make sure that verifier does not visit 'impossible' states:
> +        * enumerate all possible callback visit masks.
> +        */
> +       if (a !=3D 0 && a !=3D 1 && a !=3D 11 && a !=3D 101 && a !=3D 111=
 &&
> +           b !=3D 0 && b !=3D 1 && b !=3D 11 && b !=3D 101 && b !=3D 111=
)
> +               asm volatile ("r0 /=3D 0;" ::: "r0");
> +       /* Instruction for match in __msg spec. */
> +       asm volatile ("*(u8 *)(r1 + 0) =3D r2;" :: "r"(p), "r"(i) : "memo=
ry");

Feels even more fragile. Not sure what gcc will do.
Can 'i' be checked as run-time value ?
If it passes the verifier and after bpf_prog_run the 'i' is equal
to expected value we're good, no?

