Return-Path: <bpf+bounces-16648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CF280416D
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460B81C20C0E
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 22:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1888D3A8F6;
	Mon,  4 Dec 2023 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+BXNvkW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18BD129
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 14:15:34 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50be3611794so3398626e87.0
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 14:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701728133; x=1702332933; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fdX8Bw7p/iJUenpaNo52GDnA8vcgwdEJZtchPUKoFhI=;
        b=S+BXNvkWFHTDAkmGM11YeAeNKnyFr6Tw0FPtCw8vqONzW/XARK9qjJ8Yt4VlYgn5ha
         vbjxjNIpkf1e6teve0YUIUyabrSIx2IiACKxJCwVO1DKnktcSoLY/53JFrn8tZvyePtu
         EfPWg6r8c9tfOjbgOORlYD2Aks/G9FKTov+Yu0SmSb5XtRPcOC4uF7EVxmPkYR2IXMVN
         ph7MvMhQaukfTkF6WaM8YrNetMClKLKGUsiDZjOtQ4LjHUgj53TqWjMY6mqlRJnVASA1
         W0OmNXMJ645oabCc0F6z0jhGSakXcosQbu7lPbUVaNfzMugRqN5wLypLj8KX2rh4mMdI
         mnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728133; x=1702332933;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdX8Bw7p/iJUenpaNo52GDnA8vcgwdEJZtchPUKoFhI=;
        b=eiDnV1L/na6pd+ggyxH95TEWjzqgQa40QCkj5F2IEFMRqnd6W7GRQIuZ/GaflVVHhy
         ocMwYmC0n4LMRQ7HqBfuk8UcwYRFBfGQR5cV/aDQC/A2c6Kg9x1KXj5b3FXqXxD9afH9
         MV6ssO2w0F6S3q3i29qe9fazDqZqh8lBGfYjYy/5AOVE49GITzw8OY1wOh8pyBYnBkhz
         PCFoKkMD9rxM/DPggkqjuvxwiNONS7nNKtD1upm0Zq27+Pw4vk5+aCIymhMy46zQraQi
         0KrM0cOI+TL4gVI4zyDe1j5kH/h6uUpmOmrwx4d+pf8m4RFDNDkUuC0QTMMmTpyMxpmS
         haTw==
X-Gm-Message-State: AOJu0Yz4QYoLzCQ1hIX7/P/qhJiyiqY+iswVjt1IxKL5eH4oE2CYlz7u
	iFj17GRbSN3eJ5LH9mnKIvk=
X-Google-Smtp-Source: AGHT+IEgb8Oy1lhkx9/+U5ZMIFf/pIVZH8HDtp1TyBr4cw3wzKDDKc5wsuCya38u8V+1r2Q+AQ9o2w==
X-Received: by 2002:a05:6512:92c:b0:50b:f380:c3b2 with SMTP id f12-20020a056512092c00b0050bf380c3b2mr1059132lft.46.1701728132686;
        Mon, 04 Dec 2023 14:15:32 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o25-20020a056402039900b0054ca5644e84sm273079edv.27.2023.12.04.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:15:32 -0800 (PST)
Message-ID: <2574f94d97b57f1816af4ae33f2698cc9d2658dc.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: fix check for attempt to corrupt
 spilled pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 05 Dec 2023 00:15:31 +0200
In-Reply-To: <3fca38fdfd975f735e3dd31930637cfbc70948f4.camel@gmail.com>
References: <20231204192601.2672497-1-andrii@kernel.org>
	 <20231204192601.2672497-4-andrii@kernel.org>
	 <3fca38fdfd975f735e3dd31930637cfbc70948f4.camel@gmail.com>
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

On Tue, 2023-12-05 at 00:12 +0200, Eduard Zingerman wrote:
[...]
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index a350ecdfba4a..a5ad6b01175e 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -430,7 +430,7 @@ struct cap_state {
>  static int drop_capabilities(struct cap_state *caps)
>  {
>         const __u64 caps_to_drop =3D (1ULL << CAP_SYS_ADMIN | 1ULL << CAP=
_NET_ADMIN |
> -                                   1ULL << CAP_PERFMON   | 1ULL << CAP_B=
PF);
> +                                   1ULL << CAP_PERFMON /*| 1ULL << CAP_B=
PF */);
>         int err;
> =20
>         err =3D cap_disable_effective(caps_to_drop, &caps->old_caps);

(Here I hack test_loader so that unpriv run has CAP_BPF,
 the test could be run as follows:
 ./test_progs -vvv -a 'verifier_basic_stack/spill_lo32_write_hi32 @unpriv')

