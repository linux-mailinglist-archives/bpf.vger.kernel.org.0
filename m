Return-Path: <bpf+bounces-16822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044198062DD
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B482821E7
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D3D4120E;
	Tue,  5 Dec 2023 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjvXYBQZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16179135
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 15:21:51 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ca1e6a94a4so4957491fa.0
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 15:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701818509; x=1702423309; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RCCL5Kyk6TmOSOkYnjNMi3X66hWppRRKVGCwRa3LPYw=;
        b=cjvXYBQZfzNogDFWIuarpXXBLgbGRceUUSTw4jUsJM9QMr91EvNmmrTC5Q00KVqOYE
         udQ3l0cGd8TAWpM2fytXKafeiFfXRUG2bGkqwScziUgu3ZMqeg4QDt6msY/cp0Op/n2E
         obhiKGD7e5QI2PSEqfMqwjmQLW2b9UgkTU041+EgkOo73ETAZWGmm+N1SeqgtZ0bZ/7Q
         uDaVV5mpsd6vOdmJtmQbqJH+Wl3CYm4qe2VrPjRV7q7QL2PtybLZTLaUmEasOirVYMiW
         lTBunjHvuqUgKmoO7WF977BMEhw9c3BIPzWptvY9x6JM2dym7iRIxm5bfUwvfa1aNPuZ
         84qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701818509; x=1702423309;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCCL5Kyk6TmOSOkYnjNMi3X66hWppRRKVGCwRa3LPYw=;
        b=o9a5OhNuN6Iwsxk0ZEPFAUqbMNNYqTaMweifZkZQSyt75soFpFbzbkjuPoLFrNCqaq
         36KybIkpnuY3l5rJguraafSz0mtFfs9aut+P1bXI0ViCViZKgMl7TqK6/vNXIFnUwdWJ
         rLrGUjgDjpMpPl4RA7Y+nAsqSxEgg4UOTcZNqxZklmbouqE1rymz7CDLyVhhxkvHsqox
         jgyhMBAYTHFf3bvWF1Uj7k7hXpaQCwfMy6RS0y1Ab6r5oBL8ceJtvBAQGJW1lJzfZSvv
         5B6cytpr25YS+cTc4d9OHHeU4gBaHNRmS/wGMLXYzUpHI6Zomf7pKTEHNyk5S4895cgq
         ML/A==
X-Gm-Message-State: AOJu0YwJKMRJYw/dmbhBni6R+w5OcPF32LILeEoOT73UOuyL7bX+Wnt8
	b+8az/x1uvq+Ze1M+E035Ls=
X-Google-Smtp-Source: AGHT+IGqM4TQ1rI7NHeiJb2mb1ELS/KnZ/RmI142Cjwj96cjP0o1yQigFB/K5tAx1JNMnUF6LObJVg==
X-Received: by 2002:ac2:494d:0:b0:50b:eb81:2cf1 with SMTP id o13-20020ac2494d000000b0050beb812cf1mr26449lfi.132.1701818509202;
        Tue, 05 Dec 2023 15:21:49 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v8-20020ac25928000000b0050be22a52b4sm929170lfi.125.2023.12.05.15.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 15:21:48 -0800 (PST)
Message-ID: <97485a47e88f868da1ad6e42a3b19ad7216391e8.camel@gmail.com>
Subject: Re: [PATCH bpf-next 06/13] bpf: remove unnecessary and (mostly)
 ignored BTF check for main program
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 06 Dec 2023 01:21:47 +0200
In-Reply-To: <20231204233931.49758-7-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
	 <20231204233931.49758-7-andrii@kernel.org>
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

On Mon, 2023-12-04 at 15:39 -0800, Andrii Nakryiko wrote:
[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 16d5550eda4d..642260d277ce 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19899,18 +19899,6 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog)
>  		/* 1st arg to a function */
>  		regs[BPF_REG_1].type =3D PTR_TO_CTX;
>  		mark_reg_known_zero(env, regs, BPF_REG_1);
> -		ret =3D btf_check_subprog_arg_match(env, subprog, regs);

Not sure if this is important or not. btf_check_subprog_arg_match()
might have set 'func_info_aux[subprog].unreliable =3D true'.
bpf_check_attach_target() checks this flag for subprograms that are
being replaced, and seem to be ok accepting 'subprog =3D=3D 0'.
This change makes it so .unreliable is never set for 'subprog =3D=3D 0'.

[...]



