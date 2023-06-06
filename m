Return-Path: <bpf+bounces-1959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEC9724EB0
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 23:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5581C20B78
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 21:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D653A2A9E4;
	Tue,  6 Jun 2023 21:18:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8682FBED
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 21:18:29 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DA21721
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 14:18:28 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1bb2fc9c6so49033531fa.0
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686086306; x=1688678306;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ore6tiN7gN27CVm3/PEWZQ+1cOUiEutgS4+G+2tfbxA=;
        b=R7nqf2Sqs5TP42kr2PmbOc7QHoCGyYbH/AfjwOw/caZozbCfOAWSajIY8jAvgUEctC
         Pq5jTYm73d3YTkR2GkYdED7qv5ToCqau1IDidV/FDEN6cxj2a1NaP7SOWxiLkv6jTnPR
         oPMRL6sJqLm5Epj3CL9SBg8Wdd4u5rxVXJIoQtxWPb9LlNCW0bGThpjvXwwnm1gADRJr
         hY+Okt47JNY2sq9Etl/IRQy1JZAR9SfFgkeoY6iBX3KWc5er2dr6qpsJGMtb06co0kv5
         QIrJrul8khs/9O6O6kY4Iv45yBv+6rdDaP6QB+0EtMLj9qymDMuaKdL6wohkfImhSwZg
         xbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686086306; x=1688678306;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ore6tiN7gN27CVm3/PEWZQ+1cOUiEutgS4+G+2tfbxA=;
        b=BykyuT5iwnRq9ZLPWKNTxyCFKrquwflkzEfaTan0nAmPAb9QBjEt+EF8L0UUO9Gwz8
         DRzWjd7kotilFfAUyWXht7t90RVl9L73dh9pvrcKC6P+CDA0vafa+427gT8N0LLau2WW
         q0SQdFK1QBeflCYPw3pkwq3vCmjFHcEUUyVRFTtsugLEGw1FM3B6pfrJB2OPq/iID8fz
         4MjjUiKj8uW5eWT4/TN+4XzRPGbNpsJvvVo/9tJJ0mAk2cp0e77OQYmhzs84oHDE84it
         lnEsnjui/WGTE58PVml6nHBb4TVTiylgbYBMAe/ai3jXbJhngbmMWnT0q1h97RY56Op3
         Utvw==
X-Gm-Message-State: AC+VfDy5bmd+FbGgtyLE3/CAuHLnjFUozx6l7KRUjH3vBPYWIm8TLwTe
	rktr6528Ef2f1RpZtXkYZHpUle8aHq0=
X-Google-Smtp-Source: ACHHUZ5WItNgNXgG57DRnCB8GuJHHxEqeTElbLDgl9mjNFKYGN7jt2m3DoxkSMV/em1mZFM/mYZ32w==
X-Received: by 2002:a2e:b618:0:b0:2ab:bd1:93da with SMTP id r24-20020a2eb618000000b002ab0bd193damr1544409ljn.10.1686086306166;
        Tue, 06 Jun 2023 14:18:26 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t20-20020ac24c14000000b004f39837204fsm1590973lfq.85.2023.06.06.14.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 14:18:25 -0700 (PDT)
Message-ID: <5b772bb3b211a3eac630354adf0b0e5959831e88.camel@gmail.com>
Subject: Re: [bug report] selftests/bpf: specify expected instructions in
 test_verifier tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: bpf@vger.kernel.org
Date: Wed, 07 Jun 2023 00:18:24 +0300
In-Reply-To: <ZH7u0hEGVB4MjGZq@moroto>
References: <ZH7u0hEGVB4MjGZq@moroto>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-06-06 at 11:31 +0300, Dan Carpenter wrote:
> Hello Eduard Zingerman,
>=20
> This is a semi-automatic email about new static checker warnings.
>=20
> The patch 933ff53191eb: "selftests/bpf: specify expected instructions=20
> in test_verifier tests" from Jun 21, 2022, leads to the following=20
> Smatch complaint:
>=20
>     ./tools/testing/selftests/bpf/test_verifier.c:1365 get_xlated_program=
()
>     warn: variable dereferenced before check 'buf' (see line 1364)
>=20
> ./tools/testing/selftests/bpf/test_verifier.c
>   1363		*cnt =3D xlated_prog_len / buf_element_size;
>   1364		*buf =3D calloc(*cnt, buf_element_size);
>   1365		if (!buf) {
>=20
> This should be if (!*buf) {
>=20
>   1366			perror("can't allocate xlated program buffer");
>   1367			return -ENOMEM;

Hi Dan,

Thank you for this bug report, I'll submit a fixed version.

Thanks,
Eduard

>=20
> regards,
> dan carpenter


