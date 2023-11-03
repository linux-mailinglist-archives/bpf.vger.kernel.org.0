Return-Path: <bpf+bounces-14148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B267E0B0C
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A061C20950
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4827249E7;
	Fri,  3 Nov 2023 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZK1p2TY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185EC249E0
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:27:54 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14355D49
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 15:27:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c3aec5f326so722896166b.1
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699050471; x=1699655271; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EpUGApOCe1kdV7sNRBFA4cMkFpsFDUlCUszpzwk3kk0=;
        b=XZK1p2TYMFQykle/QZ93HI2+n+6wizp9dASqnm9DvdMBQiQr6ZeCQgLCVQn+i2qaQa
         AWQCs/viwAfTVMi4Py4PJO3oqriYi81qNXq7sgy4SummbSDZrG4zNXRYR33tgd/qnbg7
         BQO138jKNmbFty/spSYZSe0Hnyqsp6t7WbMyY/FMIToBzIYAT8iVGEoDRvyCkSFM5LVf
         hzaBkfGTtU+C/tY0MSEV8TqUxFMEqiCVOK1TCIEcUg/gvZNI6mP4FBRJ6RlDOml2VCdG
         QgiutdX2Ph7AKg+DQENr3v/xGaOpopTNf/AT/ql338cFogJ4D1SgYU7pQcCloG1R/eMY
         C7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699050471; x=1699655271;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpUGApOCe1kdV7sNRBFA4cMkFpsFDUlCUszpzwk3kk0=;
        b=jCryePIrSuJ9+iLR+c7kWIczG1ksTefbsyJ/0FMud1qay2/0ygy7i0r+M7XVqVX7jt
         ikd32NnsbhbfdWwc3QodVovEqrDin1MY7EjXA19FZIQ4Orwa5ZjoODYWK+b7GyOQC/yX
         lwlfycaAQ9yvR44XzsIV28Q2Tx3+KPdZ3ivd6em4fhN6NGsaAtV1X6vKl08gOBaBam+X
         jsSnXL59//IVpVBDEWdfVecuwwCelm9tTftIZYUpp/JoV24SbHBxrocUTR1VTmtldgn3
         OQOLiYsvTanj63hUfXYOyTF2p0LSXrfPeA9zcgEIsGjhHsavI4gBGB4pwR+moPKrQ8r3
         eBOg==
X-Gm-Message-State: AOJu0YxhA5qfOrbTZ4PtmkG1/1uY2C18OOyMyDpVZnoDKvGBpSg1v5YN
	rStjX1pjJpEsiXKl6YMc9P8TknP9lZU=
X-Google-Smtp-Source: AGHT+IFFxREzNaRCpFDkWt+hrwcWQqiQfCy61Q+RYHjCcG+KA+hxbtTYBfu12QnfrqI41PqF721Ifw==
X-Received: by 2002:a17:906:749a:b0:9dd:ce68:a28c with SMTP id e26-20020a170906749a00b009ddce68a28cmr837061ejl.24.1699050471323;
        Fri, 03 Nov 2023 15:27:51 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ov13-20020a170906fc0d00b009944e955e19sm1339267ejb.30.2023.11.03.15.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 15:27:50 -0700 (PDT)
Message-ID: <1e75c7e74e9f372e3b00ad4a5d327f37c751bc03.camel@gmail.com>
Subject: Re: [PATCH bpf-next 06/13] bpf: make __reg{32,64}_deduce_bounds
 logic more robust
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Sat, 04 Nov 2023 00:27:49 +0200
In-Reply-To: <20231103000822.2509815-7-andrii@kernel.org>
References: <20231103000822.2509815-1-andrii@kernel.org>
	 <20231103000822.2509815-7-andrii@kernel.org>
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

On Thu, 2023-11-02 at 17:08 -0700, Andrii Nakryiko wrote:
> This change doesn't seem to have any effect on selftests and production
> BPF object files, but we preemptively try to make it more robust.
>=20
> First, "learn sign from signed bounds" comment is misleading, as we are
> learning not just sign, but also values.
>=20
> Second, we simplify the check for determining whether entire range is
> positive or negative similarly to other checks added earlier, using
> appropriate u32/u64 cast and single comparisons. As explain in comments
> in __reg64_deduce_bounds(), the checks are equivalent.
>=20
> Last but not least, smin/smax and s32_min/s32_max reassignment based on
> min/max of both umin/umax and smin/smax (and 32-bit equivalents) is hard
> to explain and justify. We are updating unsigned bounds from signed
> bounds, why would we update signed bounds at the same time? This might
> be correct, but it's far from obvious why and the code or comments don't
> try to justify this. Given we've added a separate deduction of signed
> bounds from unsigned bounds earlier, this seems at least redundant, if
> not just wrong.
>=20
> In short, we remove doubtful pieces, and streamline the rest to follow
> the logic and approach of the rest of reg_bounds_sync() checks.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

