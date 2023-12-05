Return-Path: <bpf+bounces-16777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D94C805E16
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE371C210DB
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB9E675C6;
	Tue,  5 Dec 2023 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEEiAfJX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C8F1BF
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 10:49:59 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9f57d9952so43202561fa.3
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 10:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701802198; x=1702406998; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9T7gaq3g3xpUZlL0V+HU0XCAc1PbTafrJHtPKk2bamI=;
        b=JEEiAfJXwBpMh2WNQ4eX57Yczqbs9+KbTFKs57xMWqV7LZJPgqXT1jFyIt/mjZmkyr
         X8p20VifDz5nysupSwJJ3ZEwym/gochbqmuBstD8tBsMeEg2qu8d7hf8GYCzShFx6Oi1
         IE9dicUIb46cBnM++ORIh5lBq3rOPnGeRC6fqlxzPlSvOSkCFE3QlK0w18NgoUCWKpki
         LJVFCBURsIcSeB5StYvKPz4ogpkRLR9WwPtl/G8jFitHC/cZ46jkktf/YrklYYp8qiGL
         2DVFXpQ722mH+4CYHGEcTh+X6217gDCdATa4LvFquP5MgtGTXGW5WmyfaND5Z1E0/ESs
         T7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701802198; x=1702406998;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9T7gaq3g3xpUZlL0V+HU0XCAc1PbTafrJHtPKk2bamI=;
        b=JG9ugoqeUpYAkJb303sPAcN63aC0oraAfrV0jLwHfxyw3BEqL8/K8f68X4tB/j5oe9
         qEFK2HSX3wQplv8nu/V8o3rt5i5KQk8AMkeMWUScU+ixVdHM0e8ikg/YqDEyWVijcYAn
         1Nc+/Rp9//u0YBSeVCqoCQarHQcSOmLQA5BovC3GFpPiDkzPnnaWnVF01r9qUD25+iyH
         f7wEr009SWMIrf0tO+W+zHkCR+FQXq33OXqZamNcdAOA0YYt+68RVO8s78jvYMhOH4+D
         BVWyRUbpzhfB/4vKoRrIipbvowZQSAyjPqS8FhJeec/mTNxkev+2i6F3b+RjP40fPmsh
         Qc4A==
X-Gm-Message-State: AOJu0Yx52gtg25vFyUpnq7TOrRsPYXUYcvgpaqrYJGvAKt8sCK/PGspK
	S5ho22mY2GEEyX/MIDuXKKw=
X-Google-Smtp-Source: AGHT+IHS09sJzE6Q4K886UT/gi/6TcLIAGeDAbDw+QdOrj3BQKqFSc/fSu6jriwlK9y3w7Ajifmbzw==
X-Received: by 2002:a05:651c:146:b0:2ca:e10:af71 with SMTP id c6-20020a05651c014600b002ca0e10af71mr1377874ljd.10.1701802197626;
        Tue, 05 Dec 2023 10:49:57 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b10-20020a2e894a000000b002c9fbb50770sm918803ljk.90.2023.12.05.10.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:49:57 -0800 (PST)
Message-ID: <534cdf2646333c301d80f731bd08424a15b20eca.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: fix check for attempt to corrupt
 spilled pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  bpf@vger.kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org,  kernel-team@meta.com
Date: Tue, 05 Dec 2023 20:49:56 +0200
In-Reply-To: <CAEf4BzbK-D0+WU8A--+43TXb2rgUgNPaUs3Dbg4Rz1_hL6A_tw@mail.gmail.com>
References: <20231204192601.2672497-1-andrii@kernel.org>
	 <20231204192601.2672497-4-andrii@kernel.org>
	 <3fca38fdfd975f735e3dd31930637cfbc70948f4.camel@gmail.com>
	 <CAEf4BzZ0Ao7EF4PodPBxTdQphEt-_ezZyNDOzqds2XfXYpjsHg@mail.gmail.com>
	 <6875401e502049bfdfa128fc7bf37fabe5314e2f.camel@gmail.com>
	 <CAEf4Bzb8LouFSSX5DED_ucgq_xuhukE1BQ7y=hxY0c17Nq4T+Q@mail.gmail.com>
	 <7aa8af01db4fdcbedab376423d3960c22016aba3.camel@gmail.com>
	 <CAEf4BzbK-D0+WU8A--+43TXb2rgUgNPaUs3Dbg4Rz1_hL6A_tw@mail.gmail.com>
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

On Tue, 2023-12-05 at 10:30 -0800, Andrii Nakryiko wrote:
[...]
> > 'type !=3D SCALAR_VALUE' makes sense as well.
> > Do you plan to add this check as a part of current patch?
>=20
> nope :) this will turn into another retval patch set story. Feel free
> to follow up if you care enough about this, though!

Well, it's a regression. On the other hand at my old job we considered
that feature does not exist if it's not covered by a test.
I'll do a follow-up.

