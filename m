Return-Path: <bpf+bounces-17693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BC4811B74
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7EE282A03
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 17:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E0F56B98;
	Wed, 13 Dec 2023 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObTF/taP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3E1CF
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:43:28 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso74744455e9.2
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702489407; x=1703094207; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PD7SGWv3OFyry7Ud39j1GvY3EOQyaPxfcuCDGnwtv1g=;
        b=ObTF/taPFlL9D0Wj+uYllKwjpp9EcTDZGpqLwV23mgIByKUuhKcT57ZrYewDGR8g+a
         tyvl5QZl3uWAmIV5YeN+C2w/q80/h66SfC1IGZdm5Q16dlKJOC4m4142NNCb9rKQREwI
         9xYefqo5cR5dr6SXRQhaZFjR3P4Ho5mtMm1RuvDERAULJuCU1E/KkViSOWG0mbSD1Rh0
         i+6j/FCFfKXNGXmMhVrwxfHAkLpqS8ZaOhZi1fiXqF1a6WNTSgoe3Ht5p1VVj4z0IVh7
         KWo0uIyV3awii9wMjRi7BQIIz7aDmE8JQkdm/P/026BfwzMRocWJVpxDt2kYXFFp0dcb
         kAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702489407; x=1703094207;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PD7SGWv3OFyry7Ud39j1GvY3EOQyaPxfcuCDGnwtv1g=;
        b=IXG31PnAStUdYiKKMBTuHrvez3q3n6PpsSSd/KHi2HCMsPuFtPIbItuE8y0ogBlFcg
         YAGmtdIVyV498Zou1aXWX8WRy80OY3xggoTpKvqORGJCeo6kNypDh67z+sqoa5Xc6w8p
         8nAxam8lAe2lOEizv0ks5x4H8yGVMR9w5gQ16fJDy13PTm9YddjI0IGLIADOEbn5Lht4
         0hyeWUZQaMwfh482pADLfXy7IUeEXj1ZdTCUTqyNgJay5TgmBUWJ19OBB+0w3LcSRtFa
         04CO1l5HNMIWODNlfgFd6JrhVW81xphlWkToPF0yC91Xq0HGFbUfeoOaehi2fmiowGpK
         g3EA==
X-Gm-Message-State: AOJu0Yz3j2f/1NSincWj8IWrGeWMqYwhPEViNXL1hJUsI8sHPodcrp4k
	6wGRyRuCCBZQ2MR7vWgZo1g=
X-Google-Smtp-Source: AGHT+IF3mfNM7IbqLLdj2r6jlE28kdpqPfv9vC0YJTBk/x4jTTA1D65vczCc4LYjmMaTa6kBZg5cPw==
X-Received: by 2002:a05:600c:2941:b0:40b:5e4a:40db with SMTP id n1-20020a05600c294100b0040b5e4a40dbmr3694286wmd.251.1702489406806;
        Wed, 13 Dec 2023 09:43:26 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c17-20020a05600c0a5100b0040b4fca8620sm23895557wmq.37.2023.12.13.09.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:43:26 -0800 (PST)
Message-ID: <1c6862c290c555c900e34ff0552a37f5779886e0.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/10] bpf: add support for passing dynptr
 pointer to global subprog
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 13 Dec 2023 19:43:25 +0200
In-Reply-To: <20231212232535.1875938-8-andrii@kernel.org>
References: <20231212232535.1875938-1-andrii@kernel.org>
	 <20231212232535.1875938-8-andrii@kernel.org>
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

On Tue, 2023-12-12 at 15:25 -0800, Andrii Nakryiko wrote:
> Add ability to pass a pointer to dynptr into global functions.
> This allows to have global subprogs that accept and work with generic
> dynptrs that are created by caller. Dynptr argument is detected based on
> the name of a struct type, if it's "bpf_dynptr", it's assumed to be
> a proper dynptr pointer. Both actual struct and forward struct
> declaration types are supported.
>=20
> This is conceptually exactly the same semantics as
> bpf_user_ringbuf_drain()'s use of dynptr to pass a variable-sized
> pointer to ringbuf record. So we heavily rely on CONST_PTR_TO_DYNPTR
> bits of already existing logic in the verifier.
>=20
> During global subprog validation, we mark such CONST_PTR_TO_DYNPTR as
> having LOCAL type, as that's the most unassuming type of dynptr and it
> doesn't have any special helpers that can try to free or acquire extra
> references (unlike skb, xdp, or ringbuf dynptr). So that seems like a saf=
e
> "choice" to make from correctness standpoint. It's still possible to
> pass any type of dynptr to such subprog, though, because generic dynptr
> helpers, like getting data/slice pointers, read/write memory copying
> routines, dynptr adjustment and getter routines all work correctly with
> any type of dynptr.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>



