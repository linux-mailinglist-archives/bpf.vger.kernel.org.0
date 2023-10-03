Return-Path: <bpf+bounces-11327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E357B748A
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 01:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 44A8328148C
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 23:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BB13F4B1;
	Tue,  3 Oct 2023 23:14:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA53CCF8
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 23:14:21 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593A3AB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 16:14:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so1702971e87.1
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 16:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696374856; x=1696979656; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ehmHMkpJCHhZTzol/iFwANfQ4qNc/+KStXgtIKVBxBw=;
        b=FXQlwm9KPFnAEiUobN3ZDrMXaE0i7Zw7IwC8rKFVQcSLaGIVA9HVNNrH6tDUAxhC4c
         yic7IZZTQQJqtinPIVTwzLDIfnBi0j4GvPN8HmwExOaLQDVKbONtLg6QRtQWMp8r1SpT
         oxuS6h0CRu1T2+57AmE2HouS7ceXUvHeVxsmi0kz71YkEvAqEeJZHFOzYg0v4EESAjRm
         RUlGjVlzXcChgA7hVRQNpMkgqgfITc+DRNXL6s6Fss0QINTA2Ub5slVxe2ALXnbsmN0x
         LggPUWVAD+heZmcec7VWG7BCmpeWyKMZILMAfwa+CQ2CpdodenUNtMy/sEjxFj2vE7iN
         YL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696374856; x=1696979656;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehmHMkpJCHhZTzol/iFwANfQ4qNc/+KStXgtIKVBxBw=;
        b=e6NIqBKtOpjFOCazWs9cS7pSwljIPZbOZv3YuYfZ54lj3rQARWRt0axPIMqZob4gBr
         YfOE9Ly4v3Bag2pPVT+NGYoEVX9JZF+rH83qbyVf34FJjuHPQD66eZDs4E+VrnTbjaMl
         kJXPbUQHVtrVffBUcfk7IZp07FiiauQ2QeRPNtdb9wmhjQPMFm6JCOyES9+OSZIXFcDY
         hEnQ8pwte1fNjeZ+Q398W7xzRb5RqYk9nqARZGJUUreuB/5K3W2F7R80I1bIGVh5y1Ma
         dlnFClnGimYz1oBu1ndI1ZVd9/fqTpnh5RQ5Lpw5yAyLIuiR0oDqsqdKok8xETAqUusK
         X3rQ==
X-Gm-Message-State: AOJu0YwflfcWBltfx+DfWmWmyQsSVWvW/JaAtjw5+4gHiHL3/d8RCfxh
	gghuCMbisLQFEuRQqahE8j8=
X-Google-Smtp-Source: AGHT+IGWfFgtp3jPHBzwm4O78K+TMH3gVIhydioR+esqqHNmVLFZ49VwshUnzvbUj8Is7Cm8FYzvkg==
X-Received: by 2002:a05:6512:1586:b0:500:daf6:3898 with SMTP id bp6-20020a056512158600b00500daf63898mr630200lfb.26.1696374856218;
        Tue, 03 Oct 2023 16:14:16 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d23-20020ac241d7000000b0050332394bcasm349387lfi.150.2023.10.03.16.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:14:15 -0700 (PDT)
Message-ID: <7fd8b2cb49ba45a0c695aa954db8cd753c664ce4.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 04 Oct 2023 02:14:14 +0300
In-Reply-To: <20231003230820.iazvofhysfmurwon@MacBook-Pro-49.local>
References: 
	<CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com>
	 <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
	 <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
	 <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
	 <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
	 <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
	 <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com>
	 <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
	 <CAADnVQLTe2=K1nTk+Ry8WmBU1C724paoT8p8_7jYL9oymchp_A@mail.gmail.com>
	 <5b7f4b6199decf266a9218b674c232662ed13db5.camel@gmail.com>
	 <20231003230820.iazvofhysfmurwon@MacBook-Pro-49.local>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-10-03 at 16:08 -0700, Alexei Starovoitov wrote:
> ...

I'll reply a bit later.
Keeping all states before loop in a limbo might indeed be an issue
performance wise.

> I think we need a call to converge. Office hours on Thu at 9am?
> Or tomorrow at 9am?

Both are fine by me.

