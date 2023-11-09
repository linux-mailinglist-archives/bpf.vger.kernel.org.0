Return-Path: <bpf+bounces-14645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528777E7412
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 23:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F61C20C1A
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4532138F9F;
	Thu,  9 Nov 2023 22:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1ZuAGaR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A938F97
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:00:14 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D774206
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 14:00:14 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c603e235d1so228434066b.3
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 14:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699567212; x=1700172012; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QxRUS8SoAmqU4SUyI1zXkqineRdxkPqWJ4HgNsBxWtM=;
        b=P1ZuAGaRK5WU6qzXXcNKpmpvvHrhZmLdpvzCP3j9T7iNznCJYrAiC3iW9QWP1A8meK
         CzyWqld0JGrAIIV+4I87RBSNefXR+6mH/MCx5yFdhS2aOpQR4TJUn1YObyJQyEa02oix
         VWSB6izfdW9peYB+ORjR+3/OPNzztkaCjcSMnSYts16BsZJW8SifOlwrYok3rbYRah6o
         nr9ewgWrBJ/uZtoBj4K9rKCHudwj7rQhC5FzVvr3Ke1YH9FYGpWvd594yyu9lgi6fX9o
         9sk2ZjCv4P8xq2RK2WDU49u6zAhMeIkcTzKga4a+suR4hNyKBvPxWLTrcnbi6L9BeGep
         ufsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699567212; x=1700172012;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxRUS8SoAmqU4SUyI1zXkqineRdxkPqWJ4HgNsBxWtM=;
        b=rps5uFR2lOHvz0P3k6tkIFiqmY/1xBxw03rtQfdBIdzqfCLyD7etM2i0tsbQfZdzSQ
         E/pSH4tzLZD+9NMi48Q3IxEpPGE0iIXIa+3Jowgh6btv98nHgZ7vRgRSZ9MTwADDDOGZ
         DycWajaW1pbUQsJrdbQbe/2XXtEPZ4RK3hJkDIzgJA5xPW9xjHsc8BWilInHSiv5L054
         6DHa0Gd9qO4o5SB/DkPIxrEZko/xYISV0AHRov6r3wST3fl9nuqAa7X09nx/5tA5AChh
         JmDRg6EE3uedJdMH2gMF6spdNeBWzMR5vz0kDh90oZsZZEYay6DncOP0i4JHmbEHrzDa
         Bqdg==
X-Gm-Message-State: AOJu0Yw1HeAQ5c8sqPtizE3NHAlYI+VO/Hd/L8QRXCaCL+Aq/yl2TxF5
	4J13UU7Nn0dwRJ4GgZ6QLTUiWsPSZ2o=
X-Google-Smtp-Source: AGHT+IGbmGSlIbZhoQ6e7dP47fE7SG8yULi8z/C/ol8hmIWkY6m8zoOT6b1PBEUj5Fl3TzCAqrlLsA==
X-Received: by 2002:a17:907:a09:b0:9c7:4e5d:12bc with SMTP id bb9-20020a1709070a0900b009c74e5d12bcmr5239540ejc.51.1699567211748;
        Thu, 09 Nov 2023 14:00:11 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e22-20020a1709067e1600b009ddaa2183d4sm3017427ejr.42.2023.11.09.14.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 14:00:11 -0800 (PST)
Message-ID: <9f8030ae333daaf50ae975e192103f236270eb55.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: fix control-flow graph checking in
 privileged mode
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Hao Sun <sunhao.th@gmail.com>
Date: Fri, 10 Nov 2023 00:00:10 +0200
In-Reply-To: <20231108231152.3583545-4-andrii@kernel.org>
References: <20231108231152.3583545-1-andrii@kernel.org>
	 <20231108231152.3583545-4-andrii@kernel.org>
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

On Wed, 2023-11-08 at 15:11 -0800, Andrii Nakryiko wrote:

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
(given that I understood check in push_insn correctly).

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edca7f1ad335..35065cae98b7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15433,8 +15433,9 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno)

Nitpick: there is a comment right above this enum which has to be
         updated after changes to the enum.

>  enum {
>  	DISCOVERED =3D 0x10,
>  	EXPLORED =3D 0x20,
> -	FALLTHROUGH =3D 1,
> -	BRANCH =3D 2,
> +	CONDITIONAL =3D 0x01,
> +	FALLTHROUGH =3D 0x02,
> +	BRANCH =3D 0x04,
>  };
> =20
>  static void mark_prune_point(struct bpf_verifier_env *env, int idx)
> @@ -15468,16 +15469,15 @@ enum {
>   * w - next instruction
>   * e - edge
>   */
> -static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
> -		     bool loop_ok)
> +static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
>  {
>  	int *insn_stack =3D env->cfg.insn_stack;
>  	int *insn_state =3D env->cfg.insn_state;
> =20
> -	if (e =3D=3D FALLTHROUGH && insn_state[t] >=3D (DISCOVERED | FALLTHROUG=
H))
> +	if ((e & FALLTHROUGH) && insn_state[t] >=3D (DISCOVERED | FALLTHROUGH))
>  		return DONE_EXPLORING;

This not related to your changes, but '>=3D' here is so confusing.
The intent is to check:
  ((insn_state[t] & (DISCOVERED | FALLTHROUGH)) =3D=3D (DISCOVERED | FALLTH=
ROUGH))
i.e. DONE_EXPLORING if fall-through branch of 't' had been explored already=
,
right?

[...]

