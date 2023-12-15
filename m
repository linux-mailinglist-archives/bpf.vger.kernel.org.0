Return-Path: <bpf+bounces-18040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C4281516C
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 21:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C7E285CBD
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 20:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F8A4655F;
	Fri, 15 Dec 2023 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwpZPFfv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3203FB3B;
	Fri, 15 Dec 2023 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5522ba3f94aso1190223a12.1;
        Fri, 15 Dec 2023 12:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702673745; x=1703278545; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I0hGRHc+aRtrMvj5B54MNgghtd3JszQFmXPZ4SrZ3fA=;
        b=dwpZPFfvKQ+XVNaQm2LFA77bpfrj7WWdZmXFMfAk7Athz+X4UQpF/4/K4i9E25kyLc
         aqZah+AEoFR84/s7lex5pAcTJ0E2yuc8OnmND6ZbS2X6whkf5s2m9VNKmdBU+ytwE9G6
         ZnxzknLP9+QcFLeA+o2z3q9qN2zMJf/HqoVcegjujJ4dZhpenSpKRoI4dSdQnx5AUvkq
         /px70U3dpwCjBTKcO+Viysfs/u0yijunI+1WmBxYFmNY2sY6pu6pA1QTrCJYcmhzQZEt
         ECuHmiho+9AttFWU+GTxwownMe7yPjgS6sM2igmMkWKsfqWo4+6HDCFCl5Pu+RDb9bNg
         xgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702673745; x=1703278545;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0hGRHc+aRtrMvj5B54MNgghtd3JszQFmXPZ4SrZ3fA=;
        b=Oa4D6UDWSp3OIWI/Xx9Wg5s02+Cdi7ZqDSSNBcQg1y4CKxw7OdfLpqqxF0Aealj3wR
         RE/eP1CFiPtDhvEOb99IrefOeNZf1rQsOwRxtyK2bp3V22prkbizFpS0iIb5QV7MuCcf
         doCpd4UBANiXsc66V1wD5rTbGFyG7RCkrC4AUMEq0DHxcasppjtGpd1d0OhLGEakVlKS
         gCS9hokZD899D7cf6kBPwLairsISuzMMZf7cgQmCBDizDeOeJx5XkQCRjunW3fei5u2L
         nGCvBpQc8KueutLpQNCEzDdtaLurCsoEoKAwjm0czcNREe/Zs026islfmnt9+/fRE95w
         9YdQ==
X-Gm-Message-State: AOJu0YyqSrKd73+EQ60CzBdgcfeOPRim3uxnoQUAl355y00Xj/wyzaHM
	kaS5LHXKPsBmkY4apBbiIDDi2Br3ZYM=
X-Google-Smtp-Source: AGHT+IE/d4zgDoHtuwsjVw9AeES1li1VlJ34b3ltY+Tl0aHHnhcW1w3lPxMXlDcY+br1yEp+SAYLEA==
X-Received: by 2002:a50:c018:0:b0:551:85b6:6d94 with SMTP id r24-20020a50c018000000b0055185b66d94mr1852080edb.20.1702673745149;
        Fri, 15 Dec 2023 12:55:45 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ew12-20020a056402538c00b00552691fc7f9sm2078189edb.66.2023.12.15.12.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 12:55:44 -0800 (PST)
Message-ID: <eeb21a79555fd7e5ce7045dcf8d61168006ec3a1.camel@gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Hao Sun
 <sunhao.th@gmail.com>,  Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf
 <bpf@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Fri, 15 Dec 2023 22:55:43 +0200
In-Reply-To: <CAADnVQ+RVT1pO1hTzMawdkfc9B0xAxas2XmSk6+_EiqX9Xy9Ug@mail.gmail.com>
References: 
	<CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
	 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
	 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
	 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
	 <917DAD9F-8697-45B8-8890-D33393F6CDF1@gmail.com>
	 <9dee19c7d39795242c15b2f7aa56fb4a6c3ebffa.camel@gmail.com>
	 <73d021e3f77161668aae833e478b210ed5cd2f4d.camel@gmail.com>
	 <CAEf4BzYuV3odyj8A77ZW8H9jyx_YLhAkSiM+1hkvtH=OYcHL3w@mail.gmail.com>
	 <526d4ac8f6788d3323d29fdbad0e0e5d09a534db.camel@gmail.com>
	 <2b49b96de9f8a1cd6d78cc5aebe7c35776cd2c19.camel@gmail.com>
	 <CAADnVQ+RVT1pO1hTzMawdkfc9B0xAxas2XmSk6+_EiqX9Xy9Ug@mail.gmail.com>
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

On Thu, 2023-12-14 at 18:16 -0800, Alexei Starovoitov wrote:
[...]
> > E.g. for the test-case at hand:
> >=20
> >   0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
> >   1: (bf) r7 =3D r0                       ; R0=3Dscalar(id=3D1) R7_w=3D=
scalar(id=3D1)
> >   2: (bf) r8 =3D r0                       ; R0=3Dscalar(id=3D1) R8_w=3D=
scalar(id=3D1)
> >   3: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
> >   --- checkpoint #1 r7.id =3D 1, r8.id =3D 1 ---
> >   4: (25) if r0 > 0x1 goto pc+0         ; R0=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D1,...)
> >   --- checkpoint #2 r7.id =3D 1, r8.id =3D 1 ---
> >   5: (3d) if r8 >=3D r0 goto pc+3         ; R0=3D1 R8=3D0 | record r8.i=
d=3D1 in jump history
> >   6: (0f) r8 +=3D r8                      ; R8=3D0
>=20
> can we detect that any register link is broken and force checkpoint here?

I implemented this and pushed to github [0] for the moment.
The minimized test case and original reproducer are both passing.
About 15 self-tests are failing, I looked through each once and
failures seem to be caused by changes in the log.
I might have missed something, though.

Veristat results are "not great, not terrible", the full table
comparing this patch to master is at [1], the summary is as follows:
- average increase in number of processed instructions: 3%
- max     increase in number of processed instructions: 81%
- average increase in number of processed states      : 76%
- max     increase in number of processed states      : 482%

The hack with adding BPF_ID_TRANSFERED_RANGE bit to scalar id, if that
id was used for range transfer is ugly but necessary.
W/o it number of processed states might increase 10x times for some selftes=
ts.

I will now implement 8-byte jump history modification suggested by
Andrii in order to compare patches.

[0] https://github.com/eddyz87/bpf/tree/find-equal-scalars-and-precision-fi=
x-new-states
[1] https://gist.github.com/eddyz87/73e3c6df31a80ad8660ae079e16ae365

