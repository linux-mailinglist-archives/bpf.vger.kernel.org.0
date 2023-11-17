Return-Path: <bpf+bounces-15271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7D97EF942
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 22:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4652E1F269C8
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A274642D;
	Fri, 17 Nov 2023 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brAzEF47"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E082A19A0
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:10:43 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso3398662a12.1
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700255442; x=1700860242; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CAPzKbErxds7AGDXdKpYy3lp27f1vq2SryuBNZauay8=;
        b=brAzEF47Wb01brOB2M+qyYJDdb+tcP/7UJvFv28oqjHuy/xhuoi3qz0F6fBM6h06Nt
         I5I8xsMgthZecuovc7BUFmItq/4DDjbx4Phee5bqMqtgQJNNVr9/Q/JGK/V5d8vOBGlT
         MsG4hjoNy1PDuk5/a41BWASIjZAEbZNf7+oTHmO3uGjCmacyqN/0vJiHsL82+tI0ZgoC
         wocUrI25cIE419m4+GuB2xb1ygWAWzPnVUVV6EPLbWAZmpLKvA55SqpTKN1aGpDK4Fbp
         mLF4Jrlih59qiwOpftlxO9x5e8AQxjn9gSzIqJ0l78HqqkDIC6D4FfVQIH068jf6ow5U
         RbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700255442; x=1700860242;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAPzKbErxds7AGDXdKpYy3lp27f1vq2SryuBNZauay8=;
        b=bQny15vc2LNDrGsV09KoJs+uaztwZ74+SYlcg5YvpcUGvmdhRdkcQavnLZOBHb3S/l
         v86N76b998L0yE8m/+Fbzec3oJoK8dvAQuULxX9jQcHxEKxonngA3qtxAJVV7++1bgGb
         xXDFCIK9J+ZdBzZTe5os0SGe5yjem1RfgKBW+2mZnInXUxv3xGKdqePaxbf+UMslw1cB
         efGA5PgalH+nGHAyLCesADj6VoWAT4lHLIMnFmTaX94ZBut53mxXw3Zned6DqSRaMv3H
         awNeaWscAH48EoTVnKO2R7Rm10XOLt9UgQFSx7Hq1c4CqJrra7laZzUodVbpa/pTmu4u
         dE4w==
X-Gm-Message-State: AOJu0Yyo8TZFjRdh40BeGNjjkkEoOzZ2ofrXGxgZqi1bG0b9TSNraV7m
	c83r+229BDroZD5MYde2U82ybzcyCu4=
X-Google-Smtp-Source: AGHT+IHgyBMnsW0MdPgUmA2VmW1B4ZHUP8nBdh+tsyaS3TA6GLzk67t2T+tvMyBvMDf6vVOtBuPutA==
X-Received: by 2002:a17:907:9153:b0:9da:f76f:c101 with SMTP id l19-20020a170907915300b009daf76fc101mr203292ejs.37.1700255441830;
        Fri, 17 Nov 2023 13:10:41 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id p20-20020a170906a01400b009adc77fe164sm1165341ejy.66.2023.11.17.13.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:10:41 -0800 (PST)
Message-ID: <6a0e48e8061eb1c2d6b18424fd761affcb2821b3.camel@gmail.com>
Subject: Re: [PATCH bpf 11/12] selftests/bpf: add __not_msg annotation for
 test_loader based tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com
Date: Fri, 17 Nov 2023 23:10:39 +0200
In-Reply-To: <CAEf4BzYHjLdw4xDkoa_r2hBc_RiOtZE78uGcg013GxJ-am0uBw@mail.gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
	 <20231116021803.9982-12-eddyz87@gmail.com>
	 <CAEf4BzZhEU-h0yfY2WCBfPDjmwOzxxw1a70J4c78Bix34W70QQ@mail.gmail.com>
	 <d6e728aa421b08544b982a0ce60148ef45af7b53.camel@gmail.com>
	 <CAEf4BzYHjLdw4xDkoa_r2hBc_RiOtZE78uGcg013GxJ-am0uBw@mail.gmail.com>
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

On Fri, 2023-11-17 at 15:31 -0500, Andrii Nakryiko wrote:
[...]
> > > I think this implementation has an undesired surprising behavior.
> > > Imagine you have a log like this:
> > >=20
> > > A
> > > C
> > > D
> > > B
> > >=20
> > > And you specify
> > >=20
> > > __msg("A")
> > > __nomsg("B")
> > > __msg("C")
> > > __msg("D")
> > > __msg("B")
[...]
> I think it's useful in general, I believe I had few cases where this
> would be helpful. So submitting separately makes sense. But I think
> this patch set doesn't need it if we can validate logic in last patch
> without relying on this feature.

Ok, will do it separately. While at it can also add two more features:
- __msg_next, again mimicking FileCheck [0], which would require match to
  be on a line subsequent to previous match;
- __msg_re, with support for regular expressions (using [1]).

[0] https://llvm.org/docs/CommandGuide/FileCheck.html
[1] https://www.gnu.org/software/libc/manual/html_node/Regular-Expressions.=
html

