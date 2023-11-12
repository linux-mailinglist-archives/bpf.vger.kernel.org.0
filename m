Return-Path: <bpf+bounces-14939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B1E7E9113
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 15:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A240280C7C
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 14:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55328125DE;
	Sun, 12 Nov 2023 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU0VWdv0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935211C89
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 14:05:38 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B202273E
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 06:05:34 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso3473850e87.1
        for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 06:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699797932; x=1700402732; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3R32/OjCpvKgcrsmJQJrRqo7jaYyo78jYP0tO9YN034=;
        b=XU0VWdv0cA3MyMEIu65PSNDbcHcAkmXsLU/jCNmh4V9LJvzBvj78d66oaxMQm14B9U
         52a5ps/PDY8lz/AQgbtsLsyFyCD5Ef9KciWW+BYYOCtTHZzV4E4ebrKEUuB3Neq5XX4B
         N6L4InTH4rN6pEGW4q9+ZFnfwcWivhVw7g6jQmqKHUYVEno9e1piNBoXFjcBih8VGVZV
         Gzw42r1Ufvitdzuf7JK92i1KCcggTcddO5IMOnJOOJZHyPxaFzyOO9ngy4uy3VwWcwWw
         YsPZMUF0LAxVD2AvQS7e7xPS5jvcnD5MZKcKA8u1DE8EMY5+G0+dM2QS7oh0dJceUqgS
         cTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699797932; x=1700402732;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3R32/OjCpvKgcrsmJQJrRqo7jaYyo78jYP0tO9YN034=;
        b=P9HnqA40sngy//6X2ABZdcBuOJlxpSzgCKp1N5VCqdudplu44ql2U0434+nmGySOm1
         FHffiVta57M7BliNlPOAyVM0pdzn9wgCLLkvBj7P9xXZh5GFmSp+BO+eNlrXk1R2vkAq
         yWWmehoDWOFUuaobI/plaDZVPHBlPwiEI11T43j+PdVKJG6mOiDQUEUPyb3PmiuJCEhe
         pSGegB2mpF7Xrw+6pfhs5nvs8wvEeVWUbayS+EU42ol06dzj9PNyuemsEL4QgqQVprW9
         EA1K2EZZrAK7moQoSQKwp/iT1H7uGQkaxXUs9IIb2H7HDerMoaFvbbMqdU2QQHJsv0Fh
         bgIw==
X-Gm-Message-State: AOJu0YyEYaO3tkkmeACp+aNYyU239FallE2YOkv8n9LfHt8PgOQvGbiN
	fTLUNDWF+EmM5WhRhUw+eJw=
X-Google-Smtp-Source: AGHT+IGGWCcnegDH4REvA1LFwgLp0Hzg2FLKvvi3+AbAAixGSyhrerU95MqU5L+SwsFlli7qIRnXQA==
X-Received: by 2002:a19:f807:0:b0:4ff:7004:545e with SMTP id a7-20020a19f807000000b004ff7004545emr2792203lff.4.1699797931833;
        Sun, 12 Nov 2023 06:05:31 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k37-20020a0565123da500b00507987ff761sm631277lfv.56.2023.11.12.06.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 06:05:31 -0800 (PST)
Message-ID: <f642a19de4ee36b9ee1c08511c05fe196346d184.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/7] bpf: support non-r10 register spill/fill
 to/from stack in precision tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com, Tao Lyu <tao.lyu@epfl.ch>
Date: Sun, 12 Nov 2023 16:05:29 +0200
In-Reply-To: <CAEf4BzZOtAdzfBqP4H0sqhev00mCuRhbMkTX=DkPyh34s7ypeQ@mail.gmail.com>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-3-andrii@kernel.org>
	 <3a40d06c4194c5ece81b2e9301a85d70862eaf1e.camel@gmail.com>
	 <CAEf4BzbC9=6haCwQ7U5qzt9=zKTTTYxsh3s74hBBVxwNWPPx3w@mail.gmail.com>
	 <df3cb08a39fb2646ce14c8398ace0507bb6e1258.camel@gmail.com>
	 <CAEf4BzYF7m6H6hcT6QnPFoMH9tXiqR4w1CM0jmkPG4X4DBhxEw@mail.gmail.com>
	 <CAEf4BzZOtAdzfBqP4H0sqhev00mCuRhbMkTX=DkPyh34s7ypeQ@mail.gmail.com>
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

On Sat, 2023-11-11 at 17:57 -0800, Andrii Nakryiko wrote:
[...]
> I ended up with these changes on top of this patch:
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 23dbfb5022ba..d234c6f53741 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3167,6 +3167,21 @@ static int check_reg_arg(struct
> bpf_verifier_env *env, u32 regno,
>         return 0;
>  }
>=20
> +static int insn_stack_access_flags(int frameno, int spi)
> +{
> +       return INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno;
> +}
> +
> +static int insn_stack_access_spi(int insn_flags)
> +{
> +       return (insn_flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK;
> +}
> +
> +static int insn_stack_access_frameno(int insn_flags)
> +{
> +       return insn_flags & INSN_F_FRAMENO_MASK;
> +}

Looks good, thank you.

