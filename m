Return-Path: <bpf+bounces-15319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6082C7F0394
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 00:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBDE1F228D6
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 23:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CED20327;
	Sat, 18 Nov 2023 23:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dj0D1S2G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD37EB6;
	Sat, 18 Nov 2023 15:23:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32d9effe314so2268404f8f.3;
        Sat, 18 Nov 2023 15:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700349838; x=1700954638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQbvG9CtYoDwTOuaZlGQ3qkEGYRr7f7M4drTshza2BU=;
        b=Dj0D1S2GjtZSpLQ9bWYNnIElHqA5BJ8Vm7W7PIa3MBbUdaO1UbcZg2QrdtMDrjfLdw
         0PDT9LxQmEL2BxzdfGZhzivdclziQhnKyqnec4+DZvPpaDPealm/HKtO8gc8gtRFFw74
         alF2++AuG2g7flf5kjafNCS20yfZghYm6lfBpVP19Hi7u72F/2mibaYP1v5slwpQULke
         vnMnFclu5Ee0V2G5h32y5lEmx7MVdF8/o55Hue0MjPWqWvD+ZpblZKgz/PGKLJxH8Jy2
         x/1OmOSqc1vd0xUlDxymEAdTiKmwL4xDAp9iQ4eGgrKPyiVg1Fwgxp9kPpwV+Rz3sDAp
         OCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700349838; x=1700954638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQbvG9CtYoDwTOuaZlGQ3qkEGYRr7f7M4drTshza2BU=;
        b=FA4E/ysjeB2Hy6qv/Eaz60Uf0+ASMbBrkHzAfOBPS4jWu3c7JAySceoFaarZuNoudS
         BmeIPzvx5GYyBLEcD/LeMWiSQO1OEHLFh4kJLx+Y4rcAKxwg/wxCxTQEry2fVoEmdLwI
         F0JSSIKCSbQnaW6g0dwfy2aV3HCCk5imN8hpe+VTlq91rSDRmpENdKob0pZF75TqsvDy
         6TH1k2Fp0AoJeBzj3ox8hJBmZlWoiE1jfm3Slm+vRYOK1wvrYol5Ne4+PqtkMn3tM2gS
         ed2RqlUy5M03fC8kZNWNCmp3bU9FjgRBOBZOUitZF/cNWqGs4JZEoFky3mnbD437vgjs
         j9Sw==
X-Gm-Message-State: AOJu0YyYqV6LtXf17dvMmyIq+zrdjSmUJ2ZFJxR9R/LuvpR3lGxzI1G6
	Yw+7gRUHe/jfXZj4nWRLv/b5XzjS7JIrU+tJ4Xw=
X-Google-Smtp-Source: AGHT+IHkQRTllpNXOyf2k6YFip/CulqsradWpq8FjBJoOjl89ee3JziyQrPbCf/HgYlfX0ShxZtqHWRxYpRs6bxcCi4=
X-Received: by 2002:a5d:6052:0:b0:32d:aa11:221d with SMTP id
 j18-20020a5d6052000000b0032daa11221dmr2285193wrt.27.1700349837560; Sat, 18
 Nov 2023 15:23:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118225451.2132137-1-vadfed@meta.com>
In-Reply-To: <20231118225451.2132137-1-vadfed@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 18 Nov 2023 15:23:46 -0800
Message-ID: <CAADnVQLBE1ex-B=F07R0xQKo-r22M0L6eiS8DjOAtsur-hEbFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: add skcipher API support to TC/XDP programs
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Network Development <netdev@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 2:55=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> +/**
> + * struct bpf_crypto_lskcipher_ctx - refcounted BPF sync skcipher contex=
t structure
> + * @tfm:       The pointer to crypto_sync_skcipher struct.
> + * @rcu:       The RCU head used to free the crypto context with RCU saf=
ety.
> + * @usage:     Object reference counter. When the refcount goes to 0, th=
e
> + *             memory is released back to the BPF allocator, which provi=
des
> + *             RCU safety.
> + */
> +struct bpf_crypto_lskcipher_ctx {
> +       struct crypto_lskcipher *tfm;
> +       struct rcu_head rcu;
> +       refcount_t usage;
> +};
> +
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_crypto_lskcipher_ctx_create() - Create a mutable BPF crypto conte=
xt.

Let's drop 'lskcipher' from the kfunc names and ctx struct.
bpf users don't need to know the internal implementation details.
bpf_crypto_encrypt/decrypt() is clear enough.

