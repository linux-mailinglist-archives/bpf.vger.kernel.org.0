Return-Path: <bpf+bounces-16611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10690803D63
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610BCB20AB0
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 18:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786602F86D;
	Mon,  4 Dec 2023 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgmEJ98z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9CCCA
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 10:43:44 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1b68ae4104so193490366b.3
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 10:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701715423; x=1702320223; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4++Z2sNBabjPV0Q4Q9J34w4K444dMXDCFRsRIrazGs4=;
        b=XgmEJ98zFdgE29FuJWzFLJd7nMFJsHRqQ2qDkJT2dGq+kdENxqpgmdDfI28R+GmaA0
         UojzCtLfYbBiqJ7o4n3LmbRooVrYTp4mIkl7GrUJzqS3+6koEqAhamdg+ogdyxnC/Dii
         wbB0yI2/8zP/ZS4QWTVSqPQkpTg5z32o+Dy+iNhyN6KK3t0YLBx1nDrAPL3WjONwv/LL
         VmSKV6jDfIwvGcV6HD3X+GXgmvbwjHVpnvDYPkX8kxdEzlcIZ9rVnfWIOhmLmIDF19cu
         jtLH9FLBPBVpTSodWgjnNNAT1GcLEU87AC3RC9+TPurh5ShiVAlTEL/9oa3VibD6FWzt
         Zp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701715423; x=1702320223;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4++Z2sNBabjPV0Q4Q9J34w4K444dMXDCFRsRIrazGs4=;
        b=YWkX50v5cD+RP40eYvNXReYQt1qyxgq2LrpptstPRYoXoqPjml04eq+w5ffpiE/3JC
         CGBFfzs1hnbkHA1caf1xvFl+JSHM2O46A3nFG2Pnt6FRWlQcIzPOMuUch8y5zxh04lGp
         hB/2hjL2FSzuqmP/137u4WN6sEz0AkNKuBuR3g7n5xwBwe3VswAftQ2e5u7+EA2byHds
         C87B4u1SeBGuEFEP+wA4UVY8m4nMnUVubB1fJIAO9qWm6KAoDhzhIsuBAeO3fu+3eBdC
         nHEsrLUW8k7BtUxqSsJ/QHkDGTVq6HvoRD5RhTytCw5Pt5TPtB3xwHAQpHg/b3Jm6nHe
         xRgA==
X-Gm-Message-State: AOJu0YzZ+Odm+PGSrbnY38ETFLUAV9XRqW4lWQe1TakCwjE09nYp9TyQ
	pdC5U3uf5UHHr20RXgOE0/A=
X-Google-Smtp-Source: AGHT+IErqR6+Y2btI0AcVMiSdKFHkGViy88H/XagM0fFOzQJNleYwsA+z8CwsdjxrrDfLwcFPGC7zQ==
X-Received: by 2002:a17:906:2207:b0:a16:9a60:1bdb with SMTP id s7-20020a170906220700b00a169a601bdbmr4178869ejs.39.1701715422872;
        Mon, 04 Dec 2023 10:43:42 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qc14-20020a170906d8ae00b009a9fbeb15f2sm5560306ejb.62.2023.12.04.10.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:43:42 -0800 (PST)
Message-ID: <f3475cc9e9ee50a7fdbbfff353f07067537cf1fd.camel@gmail.com>
Subject: Re: [PATCH bpf v3 3/3] bpf: minor cleanup around stack bounds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrei Matei
	 <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com, kernel-team@dataexmachina.dev
Date: Mon, 04 Dec 2023 20:43:41 +0200
In-Reply-To: <CAEf4BzbT-UBaigkGeimFOTUqadVMbUFJJ7g2gfR-Au3xxHd6Yg@mail.gmail.com>
References: <20231202230558.1648708-1-andreimatei1@gmail.com>
	 <20231202230558.1648708-4-andreimatei1@gmail.com>
	 <CAEf4BzbT-UBaigkGeimFOTUqadVMbUFJJ7g2gfR-Au3xxHd6Yg@mail.gmail.com>
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

On Mon, 2023-12-04 at 10:19 -0800, Andrii Nakryiko wrote:
[...]
> > @@ -6828,7 +6831,10 @@ static int check_stack_access_within_bounds(
> >                 return err;
> >         }
> >=20
> > -       return grow_stack_state(env, state, round_up(-min_off, BPF_REG_=
SIZE));
> > +       /* Note that there is no stack access with offset zero, so the =
needed stack
> > +        * size is -min_off, not -min_off+1.
> > +        */
> > +       return grow_stack_state(env, state, -min_off /* size */);
>=20
> hmm.. there is still a grow_stack_state() call in
> check_stack_write_fixed_off(), right? Which is not necessary because
> we do check_stack_access_within_bounds() before that one. Can you drop
> it as part of patch #2?

I'm not sure I understand what you mean. Patch #2 (v3) drops
grow_stack_state() from check_stack_write_fixed_off()
so all seems good?

