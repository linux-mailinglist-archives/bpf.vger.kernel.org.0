Return-Path: <bpf+bounces-15544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E97F3385
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EE21C21D30
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE195A0F5;
	Tue, 21 Nov 2023 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRNy4aAm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7E9197
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:20:39 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-547e7de7b6fso10924801a12.0
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700583637; x=1701188437; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YXZNT9Pzh70lGnDF2azKaGF07BTJT+pv8Ol+1JkbMtw=;
        b=VRNy4aAmBeBxXyEuKEF86/6FfKh0drw4UUutn87LJQaVHhZuRYzO7SVpVyRxR2V2tM
         GOZEN39QJ/1wiZRHSGPSmlceD0BpDvMDOxb3P7AzbTLSH7So2iiHcNK/WL0sLnaBi4CK
         uInTTIEdzMytLoMvK7QSiaI9u3cF5eCy898n5aehHwTHN83ltl3v5QmDwerOV/WBCr8v
         4CUfiqfSghHzos8F8419nCjllErJChgZxFBlFH43ksuw5tJSfs0ptfYFUKRtvndvIoiT
         F3z6nH2gVPWNZKtCcT86/WUOy5D0QWXJXm1ySDz/cRs/u1hSr5RCj8gK56v7Gj2IObYj
         gTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583637; x=1701188437;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXZNT9Pzh70lGnDF2azKaGF07BTJT+pv8Ol+1JkbMtw=;
        b=cAc7zmZkHW6VwjAlUel06MlokkWgVipPVZGDr5EyNRXnDB0z1AjRvE2fIWi2ckc/Xj
         JyxXmaQqAiMYpQdZo0yLpmcHl0J8KLUKuKL8R3P6MnIq7wL8d2K6eoNn0y/oFY5VhHUQ
         BRRLkOT/ZCwyK6Z2G+6l10H/odC6fmgUQkzkKLKosDSbEYofb09s+wnhIMD/JWt7OX6o
         6KB3cKs2paswQfnJ78zsXiwixFNhim2OU+fIYpLGcr9HOXSyrTdpogtDeMuXe/ruavzs
         5WZWuZbIHnQZ+1nkRgmkx0WW2eSgEqHJKh5YfosE0vKtp9MI2KYeaUzSA6F0s0HRCqds
         UffA==
X-Gm-Message-State: AOJu0YzBOU2/PAH6X0tKUYu0rV2Mzkn846FqgW89ZH9bT7Y19FqLWmLd
	Tr13sGOPtm5fngI+HMrbq+Q+DTR5Uv8=
X-Google-Smtp-Source: AGHT+IGn4qr05BS+FPtME/TNn0j39m8+HPuEpl0mwybImRSlD5BR/NR7w7M7oIaJtBtWMXqNY4M2BA==
X-Received: by 2002:a05:6402:2033:b0:548:786b:b46c with SMTP id ay19-20020a056402203300b00548786bb46cmr2660894edb.8.1700583637457;
        Tue, 21 Nov 2023 08:20:37 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q3-20020aa7cc03000000b0054847e78203sm4724346edt.29.2023.11.21.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:20:37 -0800 (PST)
Message-ID: <1d93b6823480c86b7bd3c8959e4f2c1fed2d189b.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/10] selftests/bpf: validate precision
 logic in partial_stack_load_preserves_zeros
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 21 Nov 2023 18:20:36 +0200
In-Reply-To: <20231121002221.3687787-10-andrii@kernel.org>
References: <20231121002221.3687787-1-andrii@kernel.org>
	 <20231121002221.3687787-10-andrii@kernel.org>
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

On Mon, 2023-11-20 at 16:22 -0800, Andrii Nakryiko wrote:
> Enhance partial_stack_load_preserves_zeros subtest with detailed
> precision propagation log checks. We know expect fp-16 to be spilled,
> initially imprecise, zero const register, which is later marked as
> precise even when partial stack slot load is performed, even if it's not
> a register fill (!).
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]



