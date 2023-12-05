Return-Path: <bpf+bounces-16823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272188062DE
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 898D2B21096
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499C441202;
	Tue,  5 Dec 2023 23:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X39j5Dzl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170EEAC
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 15:22:01 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9fe0ef02aso3366701fa.0
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 15:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701818519; x=1702423319; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y06OtWYByduUfRYZKOdbnhQtrrJd6bznOPsBjt/BDvo=;
        b=X39j5DzlOiglvu0214+tc0s4+a6FGYqy+LDdK+ovSIkaIotuHZKC3b39yDLXqXmT3B
         BrEjBKCF2s7AhJ+VtlqzQ2MhpVkczakxiQKVK64UYgQpbKLmazNGpU+2Hu/4zAu1giQW
         IUQBeLFjdLzWhUGBDFEeGynaK05fmuOcLr6axq5vGyYzPNeyJzXSnNi3QgaJHmklCHL5
         X6AparFvZhSpSy4GFsRpsdDmUsrSshjYRmD/sVBGErU1EH2YbC3JYmPSEHEAB0oDFd8W
         gyNl+Yaf97mR9WhXoxseIFxtndP1NW0sT1f7OdHBC8df++zdvPh0b6AuQcyeuse3t4Pf
         mu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701818519; x=1702423319;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y06OtWYByduUfRYZKOdbnhQtrrJd6bznOPsBjt/BDvo=;
        b=bp6M6LUckIUUIZmf1U5YOnZ23+P6AwR8QkAF/v28q/qvbp0B5hnOsG2c62JY4A+OZP
         u32h1CdLx9rRENaV0/Iyv1ICKvHx0S+KO3Dj+f0uOHsaKBHVEaHfhw0U2WcwWfgB07kL
         TcNkrEsFz2BYWIUyjHth/dw/jME53E+1ReUDVxjGvc7hnAg1qT/nLIarU3PBVJ+cK2k9
         yRfGrUkghm8oC4ItW/biozU3dClYad9x3sIJpA/Enzn45ovEQ69f396Zie1uru2sr0Re
         IOogdzltbMg52rAuv6a0ikRL8gMVVspwP+pxpCMFDnUs9r2p7lFRzol5ppLVDQ4TKY/d
         GDvA==
X-Gm-Message-State: AOJu0YzYj2mJnoBFWwhopRsp8DyJiyAfBsXMRgdzVDcMx28UaTK/mGiV
	hkNirrEXIybhusAowHMilQk=
X-Google-Smtp-Source: AGHT+IFGC2B1ShxHbi3xdWp0Aci55cbLeFIeF+PopFqB4EWxLS2vDDY2V0Kk4EBXVEHvk3oHtf6LQQ==
X-Received: by 2002:a05:6512:51b:b0:50b:ffd7:d7b8 with SMTP id o27-20020a056512051b00b0050bffd7d7b8mr1442289lfb.21.1701818519116;
        Tue, 05 Dec 2023 15:21:59 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q10-20020ac24a6a000000b0050be9ac5c26sm1108166lfp.104.2023.12.05.15.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 15:21:58 -0800 (PST)
Message-ID: <a64282c46316e59a57e86639debf14290915fd52.camel@gmail.com>
Subject: Re: [PATCH bpf-next 09/13] bpf: reuse subprog argument parsing
 logic for subprog call checks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 06 Dec 2023 01:21:57 +0200
In-Reply-To: <20231204233931.49758-10-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
	 <20231204233931.49758-10-andrii@kernel.org>
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
> Remove duplicated BTF parsing logic when it comes to subprog call check.
> Instead, use (potentially cached) results of btf_prepare_func_args() to
> abstract away expectations of each subprog argument in generic terms
> (e.g., "this is pointer to context", or "this is a pointer to memory of
> size X"), and then use those simple high-level argument type
> expectations to validate actual register states to check if they match
> expectations.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c                         | 109 ++++++------------
>  .../selftests/bpf/progs/test_global_func5.c   |   2 +-
>  2 files changed, 37 insertions(+), 74 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2103f94b605b..5787b7fd16ba 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9214,21 +9214,23 @@ static int setup_func_entry(struct bpf_verifier_e=
nv *env, int subprog, int calls
>  	return err;
>  }
> =20
> -static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> +static int btf_check_func_arg_match(struct bpf_verifier_env *env, int su=
bprog,
>  				    const struct btf *btf, u32 func_id,
> -				    struct bpf_reg_state *regs,
> -				    bool ptr_to_mem_ok)
> +				    struct bpf_reg_state *regs)

Nit: It looks like 'func_id' is always 'prog->aux->func_info[subprog].type_=
id'.
     Maybe remove this parameter and retrieve func_id inside this function?
     Or at-least, could you please rename it to subprog_btf_id?=20
     For me names 'subprog' and 'func_id' seem interchangeable and thus con=
fusing.



