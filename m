Return-Path: <bpf+bounces-15175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2277EE26C
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDED280FE5
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0571315BC;
	Thu, 16 Nov 2023 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8aUr8iV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E4B7
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:13:59 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9f26ee4a6e5so123884466b.2
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700144038; x=1700748838; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gzWXmNE34Xz2pqPLLLkPGgyGfsAIczrBuWjSvDlSAHo=;
        b=m8aUr8iVq+659Rq9v36HKv01WZuoB4Svo3CYL23HLEudEVPRZuE1TAXymErGhKHs1E
         IVn+igvMbb7zDBYXdYrNEexX8bP4C9FdOA5Fc2gANojklQPZprCzMl2BubHm4+7TT+Q8
         oeEhADWSmcGpJjNbyhNJ+Rrk98cDjV+I5XZDAIsTA1WDAUNNusLuWPdI947MGJYQw1QF
         pyInl+etW6nsfWNFepXg0EGvQujGibLKUpPtBrmS79+ju7gcWqPe5aiZbeDn0iuU0gFc
         K8amYDUHdSroOnk9YohqFlcWjxiZlpU2yaoHdWCwSKzqsnZNluInHyhI9U31B+LhqWSc
         1x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700144038; x=1700748838;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzWXmNE34Xz2pqPLLLkPGgyGfsAIczrBuWjSvDlSAHo=;
        b=rKfShK1x19C2EPOqfqu/daqCy2M88aNPtr58WZjw82ehisOhDzK8iL0iRwP/15ytCf
         vJdPTQ+NPMoPeAIOfCXk8Dpsv5heKnkXHyfKJukgDxqjjH/lBnAWaJ/rwEJE7Xej/iW5
         w3z4j6/gJDEKPkdvfn84pWf2o0pdx8Qq07ze5lMrABwp0iOFSqXpVLVnb4BSmSCInNTU
         jZwSDC/NpE+eooIW7mPE6jYSM+4f4Di59ucqBoWW6Xpo4BlEDdfC5ZLhMnNCSIsEvy/c
         cJ/j59Ti378yPOoFrA7UXmy+/bOKVi/NWFYncx6ktxoa9tX6V+mYq8i39NdlT1ZhL9JR
         +DaA==
X-Gm-Message-State: AOJu0Yy4SrQOj4XCYPH/1NbULT0HH+8Azs//J9yDTfm8ocZ4aSQm18yG
	9aljTvLgluZqXR3yxZzLO+0=
X-Google-Smtp-Source: AGHT+IFDQo5lH8HRVCthXed9LsyX9bE7rRyD28mi6p1az1L85chzfbhL0vFD5I0aicxoJ085oFpYFA==
X-Received: by 2002:a17:907:96a9:b0:9d3:f436:61e5 with SMTP id hd41-20020a17090796a900b009d3f43661e5mr15708223ejc.29.1700144037731;
        Thu, 16 Nov 2023 06:13:57 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906168400b009aa292a2df2sm8480483ejd.217.2023.11.16.06.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:13:57 -0800 (PST)
Message-ID: <5fcab3fc8a9dabfb3632877ac805c6db67e11487.camel@gmail.com>
Subject: Re: [PATCH bpf 10/12] bpf: keep track of max number of bpf_loop
 callback iterations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com
Date: Thu, 16 Nov 2023 16:13:56 +0200
In-Reply-To: <CAEf4BzY8-97hcj2eKjo-uPoOJAnxy-jmbhRxxzQxO1naUiMHdg@mail.gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
	 <20231116021803.9982-11-eddyz87@gmail.com>
	 <CAEf4BzY8-97hcj2eKjo-uPoOJAnxy-jmbhRxxzQxO1naUiMHdg@mail.gmail.com>
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

On Thu, 2023-11-16 at 09:08 -0500, Andrii Nakryiko wrote:
[...]
> > @@ -10479,8 +10481,14 @@ static int check_helper_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn
> >                 break;
> >         case BPF_FUNC_loop:
> >                 update_loop_inline_state(env, meta.subprogno);
> > -               err =3D push_callback_call(env, insn, insn_idx, meta.su=
bprogno,
> > -                                        set_loop_callback_state);
> > +               if (env->log.level & BPF_LOG_LEVEL2)
> > +                       verbose(env, "frame%d callback_depth=3D%u\n",
> > +                               env->cur_state->curframe, cur_func(env)=
->callback_depth);
> > +               if (cur_func(env)->callback_depth < regs[BPF_REG_1].uma=
x_value)
>=20
> I haven't had time to look at the patch set properly yet and I'm not
> sure if I'll have time today. But one thing that I randomly realized
> is that if you are taking umax_value into account then this BPF_REG_1
> has to be precise, so please make sure to mark_chain_precision() on it
> first.

Yes, makes sense, thank you for spotting this.
Will update in v2, waiting for some more feedback before resending.

