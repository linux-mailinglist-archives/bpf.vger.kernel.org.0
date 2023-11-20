Return-Path: <bpf+bounces-15340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08057F0A71
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 03:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DED5280C43
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 02:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E851849;
	Mon, 20 Nov 2023 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFUq5OKg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2337133
	for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 18:06:33 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54366784377so5243004a12.3
        for <bpf@vger.kernel.org>; Sun, 19 Nov 2023 18:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700445992; x=1701050792; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nokb+JUDPyIWtpMn/jDmdIvdkj148J6Iyx6VfmOUDRc=;
        b=OFUq5OKg5vlJJ/4bWu949b1M7eGWFwSlZsxnO37gXxCrMSntlfP+r3e0Id/LimI4D+
         jDJksI8KQTnjQCt/wzASB7rutyiEDkCiT6klh9f0+3braCfuhwQBVBlTxMTwvf07PsNw
         qvyWYHOyINvTskZxoNbN1nmIb3Cv162E0fz8YcQiO/p+AKaT6wPk9VIhWYGKLFiAmXB2
         cEdWRCjnjBCcCYhA6Ouznlggn0TGmBuk0Esy3QMDApK3QJJ3XucR+bmYMfk+wwOPnOez
         nNsO+/vDfurM2lSAqTxpefXYdiEIOxw1PEPZmcDODf26TIj1l+XERBhjn3gjBDrFL4WA
         91ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700445992; x=1701050792;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nokb+JUDPyIWtpMn/jDmdIvdkj148J6Iyx6VfmOUDRc=;
        b=H26PllKX5Uh6uYotf8lCEaaer9Pp2rXo1EO1bHEDjUwhShmSztFa6WfrxsQBbfGIGu
         AbnwX1ZITpzj/uHCgJ30bKWBfzIWZR8Qnl3daxeCWf/fhjTiHwPeVHZ9w86Ys/6f6jqt
         uZtpgfpoM2G6beQrHyed7Zd8zMpWneuJCQGWVSbvCJQocHRQzYnke19TwBdxC5yhS3uN
         ZtUEaenbLXr/iy1sSzeueFbw25ZRV5mU6I+eh8FpYe7SM/ybwZw1/uM2WVTMxDtNC1eE
         mF4Ebd+R00IRAzE+GXUU+PNXp/+ySfN+Z11EKJpb2wbKhbE94nvOqQrqtYbiCMe41xSH
         LjxQ==
X-Gm-Message-State: AOJu0YwLm50QD07lyNPbXdHCRcJFFaedYWuNDIQZCQXDzGi5Dxp82N1C
	JSl9KffO/A5EobZxqTqatjlV9zz0sB8=
X-Google-Smtp-Source: AGHT+IENnowdALqULQccl+KKCw6K9OP8ygXn0tGLfx9qgresfMgnKbwpnsj30XTy1XtPqn08EuSQ+A==
X-Received: by 2002:a05:6402:3d5:b0:540:b1fb:b630 with SMTP id t21-20020a05640203d500b00540b1fbb630mr4211833edw.27.1700445992021;
        Sun, 19 Nov 2023 18:06:32 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e10-20020a50ec8a000000b00540e894609dsm3023473edr.17.2023.11.19.18.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 18:06:31 -0800 (PST)
Message-ID: <3f21d362899947f716a0cfa93b9c22bcec66afd8.camel@gmail.com>
Subject: Re: [PATCH bpf v2 10/11] bpf: keep track of max number of bpf_loop
 callback iterations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Andrew Werner <awerner32@gmail.com>
Date: Mon, 20 Nov 2023 04:06:30 +0200
In-Reply-To: <CAADnVQ+Zit-KLSnoo0x-dh7Ek-VGm1K0-oBWZ085dke-ztYLMg@mail.gmail.com>
References: <20231118013355.7943-1-eddyz87@gmail.com>
	 <20231118013355.7943-11-eddyz87@gmail.com>
	 <CAADnVQ+Zit-KLSnoo0x-dh7Ek-VGm1K0-oBWZ085dke-ztYLMg@mail.gmail.com>
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

On Sun, 2023-11-19 at 18:00 -0800, Alexei Starovoitov wrote:
> On Fri, Nov 17, 2023 at 5:34=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 7def320aceef..71b7c7c39cea 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -301,6 +301,15 @@ struct bpf_func_state {
> >         struct tnum callback_ret_range;
> >         bool in_async_callback_fn;
> >         bool in_exception_callback_fn;
> > +       /* For callback calling functions that limit number of possible
> > +        * callback executions (e.g. bpf_loop) keeps track of current
> > +        * simulated iteration number. When non-zero either:
> > +        * - current frame has a child frame, in such case it's callsit=
e points
> > +        *   to callback calling function;
> > +        * - current frame is a topmost frame, in such case callback ha=
s just
> > +        *   returned and env->insn_idx points to callback calling func=
tion.
> > +        */
> > +       u32 callback_depth;
>=20
> The first part of the comment makes sense, but the second...
> What are you trying to explain with the second part ?
> How does the knowledge of insn_idx help here ? or helps to
> understand the rest of the patch?

The intent was to explain that 'callback_depth' in frame N refers to
number of times callback with frame N+1 was simulated, e.g.:

  bpf_loop(..., fn, ...); | suppose current frame is N
                          | fn would be simulated in frame N+1
                          | number of simulations is tracked in frame N

