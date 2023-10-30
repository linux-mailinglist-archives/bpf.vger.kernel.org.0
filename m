Return-Path: <bpf+bounces-13619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F337DBF97
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 19:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297BB2816D4
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1062719BAC;
	Mon, 30 Oct 2023 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDviNoVH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A119BBA
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 18:16:39 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2769E;
	Mon, 30 Oct 2023 11:16:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e855d7dacso7824656a12.0;
        Mon, 30 Oct 2023 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698689797; x=1699294597; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MpHHf9xas8OW3Kjr9CsNsjI7QnAkaIwmHfMSF5Ql6DE=;
        b=lDviNoVHLOYL4i697bxRV/yZXocIWizBMJV8QfOP9EpguVSiIOuZU1SbR1arfH6tYi
         cIdebrHdieJ/TxZ2XN/z8f1TItNYCDXR8dnzZ3CxLH7gM737xV84gi+ofoXQfKACxg72
         kOItnF6zrZJezSQAxl166r96zzuWQ0FJv5EoNQt3eBGiA2hsvVjg8E2YvZvXOcA5+LLd
         T+xrSXC24JxeyLR1icPepWLsZ3r5a8uTXfKMZi37uThwq2XKUfgHp8Sp1QyLVfe84zB7
         ai8ESTagC7ThrOp1+leVLAa23w5op+EVTDYLsI1qbWivJQFVLuzzrF5PZHPggSoYIzmE
         rsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698689797; x=1699294597;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpHHf9xas8OW3Kjr9CsNsjI7QnAkaIwmHfMSF5Ql6DE=;
        b=AZFWSV9Vw1jvPwYww6YwruW9ONRGChxbRBqCJRzkazByfqr9kn4YV0XS0e4+JRXV2z
         dY64TOUO7Ns28SD1JlNYNdFZ0D2uEY2oKUrAC/Wh14Ps0uLos243/DQH4ByjjwTrh0d5
         vIXpFqjnj3QL5YngVjZcbNMWxcMYg4tpMHHnfyK+660Ys10zPYb2Qnsv1+LYO6L2SbP/
         lh+0oEFJ+rRD7sUrf9KEb5qnR4eL5BfhYUFxtpJQfzevHLN350Cvpsyanz9h72jWV6oV
         ICOQsgo/iRW99PDoglQYewieDtO3TEQJbDNwfCBfmrDfAzSgcK5kHUH5cTVX6WQ7n9AB
         ySpA==
X-Gm-Message-State: AOJu0YwyUe+QClptzz3NeghEhOvHgGnbMe33XqDwfgJSIvLWzNvXwu8y
	aAVQs/G0VENN3GyXbUkosyY=
X-Google-Smtp-Source: AGHT+IFsxpwYPNeKpNYGJp017SOoui4ESE0IY6o1gTa8kJWuGX2NSakE1SfuAUHBDXyXZcG2spBFHA==
X-Received: by 2002:a17:907:5cb:b0:9bf:b022:dc7 with SMTP id wg11-20020a17090705cb00b009bfb0220dc7mr9009960ejb.48.1698689796736;
        Mon, 30 Oct 2023 11:16:36 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id bq27-20020a170906d0db00b009ca522853ecsm6322229ejb.58.2023.10.30.11.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:16:35 -0700 (PDT)
Message-ID: <c9c5c5d267dacd68d97e539bf294111345f91ed8.camel@gmail.com>
Subject: Re: bpf: incorrect passing infinate loop causing rcu detected stall
 during bpf_prog_run()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 30 Oct 2023 20:16:34 +0200
In-Reply-To: <CACkBjsZ5iYQRc6_EREhKA1cg-dFtopSOKQhDo+6SgDnVrz+vcA@mail.gmail.com>
References: 
	<CACkBjsY22BOUCns43Rza5gXCBtEKbdRqXxOTviZQOjjDySYGHQ@mail.gmail.com>
	 <CAADnVQK2nsdzviA1q_tBuh+7g6Xo6wZY2VxGR1H4ag40nNrSgg@mail.gmail.com>
	 <CACkBjsZ5iYQRc6_EREhKA1cg-dFtopSOKQhDo+6SgDnVrz+vcA@mail.gmail.com>
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

On Mon, 2023-10-30 at 11:29 +0100, Hao Sun wrote:
> On Sun, Oct 29, 2023 at 2:35=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >=20
> > On Fri, Oct 27, 2023 at 2:09=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> w=
rote:
> > >=20
> > > Hi,
> > >=20
> > > The following C repro contains a bpf program that can cause rcu
> > > stall/soft lockup during running in bpf_prog_run(). Seems the verifie=
r
> > > incorrectly passed the program with an infinite loop.
> > >=20
> > > C repro: https://pastebin.com/raw/ymzAxjeU
> >=20
> > Thanks for the report.
> > Did you debug what exactly caused this bug?
> > Are you planning to work on the fix?
>=20
> This bug is really hard to debug. Here is a simplified view of
> the original program:
>=20
> loop:
> 0: r4 =3D r8
> 1: r1 =3D 0x1f
> 2: r8 -=3D -8
> 3: if r1 > r7 goto pc+1
> 4: r7 <<=3D r1         ; LSH r7 by 31
> 5: r5 =3D r0
> 6: r5 *=3D 2
> 7: if r5 < r0 goto pc+1
> 8: r8 s>>=3D 6
> 9: w7 &=3D w7       ; r7 =3D 0 after the first iter
> 10: r8 -=3D r7
> 11: r8 -=3D -1
> 12: if r4 >=3D 0x9 goto loop
> 13: exit
>=20
> At runtime, r7 is updated to 0 through #4 and #9 at the first iteration,
> so the following iteration will not take #3 to #4, so #3 can be ignored
> after the first iteration. r0 is init by get_current_task, and r5 is alwa=
ys
> smaller than r0 at runtime, so #7 to #8 will never run. So, the update
> to r8 is only #2 and #11, which together add 9 to r8. Since r4 is set
> to r8 at the start of each iteration, so it's an infinite loop at runtime=
.
>=20
> Based on the log, the verifier keeps tracking #7 to #8 and to #9, and
> at some point, the verifier prunes states and path from #7 to #9, so
> it stops checking. The log is huge and hard to follow, the issue is likel=
y
> in pruning logic, but I don't have much knowledge about that part.

I can take a look at this issue but closer to the end of the week (Thu/Fri)=
.

>=20
> >=20
> > > Verifier's log: https://pastebin.com/raw/thZDTFJc
> >=20
> > log is trimmed.
>=20
> Full log: https://pastebin.com/raw/cTC8wmDH
>=20


