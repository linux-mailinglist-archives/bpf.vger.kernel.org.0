Return-Path: <bpf+bounces-17938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7AF813FC3
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9276128409F
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EBB815;
	Fri, 15 Dec 2023 02:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZucbDrmT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592346A3;
	Fri, 15 Dec 2023 02:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c2c5a8150so2000425e9.2;
        Thu, 14 Dec 2023 18:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702607303; x=1703212103; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bfCIH8OrwYmA18Eh0tXMCerfrbYnCxrLNDSChId0XbU=;
        b=ZucbDrmTP35LGCv/2uUIInlRrjMjndtQ7PIPrNZlW37kfqn0r+/LjBreZFkW7nXxg1
         2/h3JenQs8GMZQL3ZrYGH2fl/qiZxtQ5h23WvYgrW+Q9FAJyXl0i1jzWImHrsFBukFm4
         qBhQ7Fq6kiYodmtmq31hw7NBln7JGd+U6Wh+Zmh2QtuU/CLQC+8NDMCeHjokZ2WZjuvv
         FHM8aJeTKVt/+1bKqzCbCL+cWvPrV69PdT2HSW03PV22tCbQDdL1nD68qs71Q57JXttn
         k+pxjkJZZd2AikH5xERMYM+jLp6qaIJ2/XsecQuIvhpQCKW+YPr3ayzZgIWqe4JSUY0r
         9QNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607303; x=1703212103;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfCIH8OrwYmA18Eh0tXMCerfrbYnCxrLNDSChId0XbU=;
        b=wTLbdQh9RiMOH3aL57jBF8eog1RwY/ohmvJTCY0lo/7UErwH6UMQ+8jH27z5AGd1Yf
         eHGUkXZUaB8Fxc9UTjJbY3ys0M21/0Y13ivq8BdmyudRpWEJZ0eFn3YUhVeiHFNnbbDL
         +I/tQTPKgtO09fFg0KL6qq0Oqv8sKSNUpcqDFKnb7ckkFL45LoGZJPSLpZ416BgYW9BR
         H6IkZB3JilB0Kd9MzOH4cf3McEeSUydFfaQ7VD0WCi2BUUkB677nC//5ndo2Yjj0Xt/n
         S96jRQSdthhrb75VFMoNaonevlSrefQJEFA6rzbyddcN5hDLjYR25B483iT22wtdqbP/
         yRIg==
X-Gm-Message-State: AOJu0YyYoMOrZ+i66bEkOU8LkXAKZuTT2l6l/8thkaEXLfip3piiJV6D
	fY3nfuv5RdJ/PO1tX7ypkI4=
X-Google-Smtp-Source: AGHT+IGUKfUxOtZevuTSNI6CD2DIM36FApc26PTEPn8gLTLn/CiI7+Mvp7farsvRB3TbmQjS1TscPA==
X-Received: by 2002:a05:600c:2b0f:b0:40c:33be:d166 with SMTP id y15-20020a05600c2b0f00b0040c33bed166mr5538514wme.87.1702607303383;
        Thu, 14 Dec 2023 18:28:23 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b0040c1d2c6331sm27072969wms.32.2023.12.14.18.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:28:22 -0800 (PST)
Message-ID: <66b2a6c45045c207d8452ad3b5786a9dc0082d79.camel@gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Hao Sun
 <sunhao.th@gmail.com>,  Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf
 <bpf@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Fri, 15 Dec 2023 04:28:20 +0200
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

Should be possible. I'll try this in the morning and check veristat results=
.

By the way, I added some stats collection for find_equal_scalars() and see
the following results when run on ./test_progs:
- maximal number of registers with same id per call: 3
- average number of registers with same id per call: 1.4

