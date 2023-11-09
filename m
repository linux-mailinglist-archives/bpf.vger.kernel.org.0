Return-Path: <bpf+bounces-14608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 433FB7E70A5
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719071C20A3E
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ADF30324;
	Thu,  9 Nov 2023 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoOk4usb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F3C225D5
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:44:52 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81126268D
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:44:51 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso1975854a12.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 09:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699551890; x=1700156690; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PN0OY/rAWlmhYa06KZ/ACM5wq0/HaXgjK6cAPtUHeRo=;
        b=DoOk4usbrKQQ7mfprDwOJORWPB3kcaRFJTEXB429LSGU2dnG1u+zE8apY337GkIZc/
         k2z/LlZVl+jyG5cQQtdtQ3mIrLB6rZKaQATbtueEQPHwk53grRnIIuihnNqLmrKspPop
         hj7BvM1g3rKQ8mVvML1OgSzNcB/VlLcxLi1v0Rn9WdzG+n9KL8pJbjfzJ7x+R6pbaT77
         QSMv8XnyK14NsWeiE3WEJVYSX0PLnam/ueNs2ZG1ZveNojHTACtimnXengq+uAtmeMZs
         A+eLJUtlpzRH9c4xqrMC4MytPjBMNLER3zsstXvwsSoO1fzi2Fy2+c8uqIVr4xNrivvG
         eZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699551890; x=1700156690;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PN0OY/rAWlmhYa06KZ/ACM5wq0/HaXgjK6cAPtUHeRo=;
        b=tusnkraXDZTbLXjL5V5vkMsnjFDxtfHCG42dU+B6IMjL1ggR29QD992MIfgsKR/lMz
         M/hJUkGYtGmfztfNF1T/3MqIc1fQC+ug1tF1aV4ktfqYX+IPDfhvVd0S2Zzrc2mOJ14D
         kp9HC0i6J0QS+n7rhVqQOLNRRZN++EbOCuIanowZvR1wwByimSsm5B9Y6sjI0qfGdjyF
         l0KDRGPQjDG5jj/+B7hVp+CF5pFHrxGEpot6uwuY8+a92K/nJ5I9w8OgwalEz780W0ku
         t4hC432bAZXTbHy2UB7JduLDi9q30f7q+xgFpPLxbIvZAB6rbJqidKe4+7JmOkMgwmoF
         /9iA==
X-Gm-Message-State: AOJu0Yz+h80Ui86sVQtH/j5mZMOgizDdiEcd0/RBfnfxq24jnEruVh4K
	Prs6Kx0m6op5HP6gTSk5znE=
X-Google-Smtp-Source: AGHT+IFpej/E0Lp7MU0i23xW2trpLN5yjqksLJLGQwYB80H6QFtCTecgpwDHP147qelESXPLfuvhzw==
X-Received: by 2002:a17:907:c13:b0:99d:e8da:c20b with SMTP id ga19-20020a1709070c1300b0099de8dac20bmr5166674ejc.24.1699551889792;
        Thu, 09 Nov 2023 09:44:49 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id gz11-20020a170906f2cb00b009b2d46425absm2814321ejb.85.2023.11.09.09.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:44:49 -0800 (PST)
Message-ID: <f0cfb43a1a9c416dceedb9fae48eb71ed5736447.camel@gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: track aligned STACK_ZERO cases as
 imprecise spilled registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Thu, 09 Nov 2023 19:44:48 +0200
In-Reply-To: <CAEf4Bzat=bHEF30nt95vGV=Jhh9FYiAPA94SK=vLcR4XACT32Q@mail.gmail.com>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-8-andrii@kernel.org>
	 <38b2c899104ac9cb7009351531787a7691748bee.camel@gmail.com>
	 <CAEf4Bzat=bHEF30nt95vGV=Jhh9FYiAPA94SK=vLcR4XACT32Q@mail.gmail.com>
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

On Thu, 2023-11-09 at 09:43 -0800, Andrii Nakryiko wrote:
> sure, though I guess I'd have to rely on verifier state printing logic
> for this, is that ok?

Sure, thank you.

