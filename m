Return-Path: <bpf+bounces-16831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 476158062F7
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76FB1F21700
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D341221;
	Tue,  5 Dec 2023 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkpWPR6J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96F4AC
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 15:27:35 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bfd7be487so2948113e87.0
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 15:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701818854; x=1702423654; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cGz4VLsRrHnkWy4l7zBHVHJV17ract//qZSJ1eIp5uU=;
        b=DkpWPR6JRAs+DwGPJN2NrjjbpuZk3f3nkNpXptWLiPnHeHKXvkgEXBwxPkSaoTi8+x
         urpWmPfhN8dMCURMxrtlqd2rJs7rx+VES/292np12LRV1BX3Iei20VaFFbeTv7lw/msV
         +6ywNBGMyNBNirppc2v5iFAZoeaCPyoMHWUGEIjhdCefpQMsl7TPU5tfkC0a981KjNL1
         bOmtvEkUmSfCPx7OaRdIdvdbzmKvAfuP7TewE7BbyvcJ7SNSSZEkzG1lv+UHhdozvPR+
         Rg96p5LIbF0P3kEKUeLXoJmx2LsmsIHmQKGMFuVu/Cf+fcKhSXH1QLfYECa7iAAssbPY
         S+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701818854; x=1702423654;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGz4VLsRrHnkWy4l7zBHVHJV17ract//qZSJ1eIp5uU=;
        b=eayfeBvqXONocSJtYAiOpO3wfigEpXVsl3nQ9DWGc3CPo4cgJZTJsqkYEyJv0S+fVe
         iKoV3C7Zld/LUI/u7vgG0thfmidBF5HyBGbFl+NGdzfOudi99bcy79nCKEcpKOB0Emsm
         zSA8i/n9Ac6R96wHux6cBvzAzTfhGTHahxvnusHpBt5xVu9YOXn1+usheFrxD/isQzfP
         kBpVP0QwHHPjP3TyRi34Bh5rYm+RIXTtePUBQm65djqY0d+eGDzaPrKZv9rlM11qLpk2
         sdd0xvu8XcPqXHFFbRml6QFHWc0trph9Jfu+3BZ3KJubkIzh7jT08KFKxZOczjd5S7u3
         xhLA==
X-Gm-Message-State: AOJu0YyqUf3k40c9TKjKb6n2zRI91UHmsqtjT+hesABcAie0iD/KbKUe
	KxVArPEGimCzDqArIZWl8TSP0ERuKz4=
X-Google-Smtp-Source: AGHT+IFkIHIEIJ14nbrGt6NpWBPI1LNuAaiZHTHfuToGgXe48mwZCTwnG9nnYPgLjHkAO8pwrm7NmQ==
X-Received: by 2002:a05:6512:3482:b0:50c:6b:f16b with SMTP id v2-20020a056512348200b0050c006bf16bmr24345lfr.73.1701818853798;
        Tue, 05 Dec 2023 15:27:33 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512314600b0050bf328278fsm869649lfi.192.2023.12.05.15.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 15:27:33 -0800 (PST)
Message-ID: <7f9cab916306f322036cee995296825cce93d1b1.camel@gmail.com>
Subject: Re: [PATCH bpf-next 08/13] bpf: move subprog call logic back to
 verifier.c
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 06 Dec 2023 01:27:31 +0200
In-Reply-To: <20231204233931.49758-9-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
	 <20231204233931.49758-9-andrii@kernel.org>
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
> Subprog call logic in btf_check_subprog_call() currently has both a lot
> of BTF parsing logic (which is, presumably, what justified putting it
> into btf.c), but also a bunch of register state checks, some of each
> utilize deep verifier logic helpers, necessarily exported from
> verifier.c: check_ptr_off_reg(), check_func_arg_reg_off(),
> and check_mem_reg().
>=20
> Going forward, btf_check_subprog_call() will have a minimum of
> BTF-related logic, but will get more internal verifier logic related to
> register state manipulation. So move it into verifier.c to minimize
> amount of verifier-specific logic exposed to btf.c.
>=20
> We do this move before refactoring btf_check_func_arg_match() to
> preserve as much history post-refactoring as possible.
>=20
> No functional changes.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


