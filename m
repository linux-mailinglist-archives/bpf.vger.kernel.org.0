Return-Path: <bpf+bounces-16050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014877FBC77
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 15:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D262B21A3F
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97C15AB98;
	Tue, 28 Nov 2023 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUoOY+cH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D6ED53
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 06:14:28 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a04196fc957so796447566b.2
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 06:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701180867; x=1701785667; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wmdLZJj+sZr2JDTV+ZjZaIoUGIaihLgm7lMKwIPughI=;
        b=BUoOY+cHWPAlwtckbixWI5kxVpyAjE+ykudEIuEJCBOJZKEdM5XXXtGyC8NrrYSR7V
         Tu00FZB6tXRk5iYfRln1dUKGPfizzZN+TRlHTxnNO0WJ4fCUlXgI0KbpBMPQdFL/GEMo
         TdkrWUi8UGuMmcs1suaccVpQuIqydvIlBw/t26aNPUda1OCdwhhQ9LQizViwDLsJ5QE5
         szVe/um0p0CLzuaVJo4n6FqXKxaN3w2e6EgZ2MYUWo0Y09Oyj65vMOeoJceoYpwUtu9n
         azSk0g99EcP4yjykVs0P6/t+8zx9pPTuoFGCSz9RnfoF8bmMcSfmGQsdYu4Z8V46E1Al
         SVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701180867; x=1701785667;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmdLZJj+sZr2JDTV+ZjZaIoUGIaihLgm7lMKwIPughI=;
        b=mHtWP8G4qcrlIbyA3KA/08TVTps5mjRpPULMjC7QVHSXt9+yaBB96Qxj2LYul0RkvV
         wLdrg/ngTCTwBBgqS4Go1hy3gUkNDJ8LbOPksSKSpBiaDVpxoAGb5Tqv1dFw0C3WflQK
         Ik2zaOE3Ptnjx9MYrYkxwGD4pnVjApkDpj3zaFDwULhc7DitCFMaxqAy2zAJTtyPUG+C
         kzFSluffjNmbCB+5h5W9mk6nLrVWGqEeZI9is0aWu/luj3KNyqHxKF4P5Os3mC2sLOh/
         PW/gb7DkgT/37XZOVwhR5oFcND38Jw4hAAs4RK14RXEzPLeS31CzHCU7QGzVi9iH8kwB
         n3OQ==
X-Gm-Message-State: AOJu0Yxw/J1OXPSPP3p59jZizBJTBxv0qdJX5nbIuZncPd6c/8pk7go9
	tXXy/OJ9vvTfXQS7/NWdfhvuQbSQRi2+6g==
X-Google-Smtp-Source: AGHT+IHRRTYLGZA7P7ZvtZHNNNBrbX1AyK3JCQ5ctFvgJzXl/p1wWuQ0c8Jh9io8tDTcTAJqW0047w==
X-Received: by 2002:a17:906:f0c7:b0:9fd:49c4:81f1 with SMTP id dk7-20020a170906f0c700b009fd49c481f1mr10533236ejb.47.1701180866461;
        Tue, 28 Nov 2023 06:14:26 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709060b4200b0099d804da2e9sm6857946ejg.225.2023.11.28.06.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:14:25 -0800 (PST)
Message-ID: <fb6dcf08ac74a21da7ed5c20582d24df4184f535.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: fix accesses to uninit stack slots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, 
	andrii.nakryiko@gmail.com
Cc: sunhao.th@gmail.com, kernel-team@dataexmachina.dev
Date: Tue, 28 Nov 2023 16:14:24 +0200
In-Reply-To: <2facccd4023ee77059fe483e0b1a21f6ef36e16e.camel@gmail.com>
References: <20231126015045.1092826-1-andreimatei1@gmail.com>
	 <20231126015045.1092826-2-andreimatei1@gmail.com>
	 <2facccd4023ee77059fe483e0b1a21f6ef36e16e.camel@gmail.com>
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

On Tue, 2023-11-28 at 03:33 +0200, Eduard Zingerman wrote:
[...]
> Also, I think there are some tests that do oob stack read in branches
> that should be proven unreachable, with expectation that if certain
> verifier logic does not work as expected stack access would serve as a
> canary. Have no idea how to identify these tests, though.

I looked through all test cases I ever added (not so many) and it
seems that only one test case should be updated:

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/self=
tests/bpf/progs/iters.c
index b2181f850d3e..3aca3dc145b5 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -846,7 +846,7 @@ __naked int delayed_precision_mark(void)
                "call %[bpf_iter_num_next];"
                "if r0 =3D=3D 0 goto 2f;"
                "if r6 !=3D 42 goto 3f;"
-               "r7 =3D -32;"
+               "r7 =3D -33;"
                "call %[bpf_get_prandom_u32];"
                "r6 =3D r0;"
                "goto 1b;\n"

Here oob access is replaced by unaligned, this does not affect error
message, but should be future proof in case if widening logic would
get smarter.

