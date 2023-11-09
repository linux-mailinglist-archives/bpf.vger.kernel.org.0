Return-Path: <bpf+bounces-14648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B3A7E744F
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 23:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B308128120D
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 22:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA19638FA6;
	Thu,  9 Nov 2023 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp26wWzA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DEA38F9D
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:21:43 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB9F1FF6
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 14:21:42 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9e5dd91b0acso49796466b.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 14:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699568501; x=1700173301; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6NoNo3IHo+I5ttSvApp/J0Rc7mziwhaHkN2dF/mHUs0=;
        b=Sp26wWzAj+RtBobvav2kqYVzmISh5ThgQvY01l3Sd7stSWXpsAzXt+Hec3+DOfpNex
         RRVbLTvz+2UicG6AbfSPYlKDHJza+YMPNuX7wCFK1txdS6oJ5lzVIp4cxt7v3OMaKLw+
         y7nDU1VNdFeHXVo4WtXgqVEOocEraraveRrVR3pyddeFBe7qENJ16U+mYSV8YxrE0+7B
         bJzr51WmjCR+xwrFDX9y5ny5pi01mymdKAvLEg+tLbepR1ZULdYJcD4Cw/mofB9k69MZ
         fOGR28Dewcq1LdPpIxWr9IqnycyacQPRqJbXUPFUksYrEu/UjX1yA3T2hsG4cnTWvIYT
         T7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699568501; x=1700173301;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NoNo3IHo+I5ttSvApp/J0Rc7mziwhaHkN2dF/mHUs0=;
        b=AbigrByr9e9x/Ns4WiNVwNzzZN//jQ3fGkO1iLNTZPaUPB/h7nzflX8uOF/lwnOaWS
         PyilCLoqNoPdfz//sLe96mzYRnl1caOttAAgKZL/k/sBGeQOmrl/gDgidXGyQXui9uq0
         oPbYJlm2rPlNvb+BHJCH7vqeMRJs6SlQe+gV1zCzmhlpz2wS2oEMoXK+43TYfwTmQE2E
         QRwuo9p1a/a3sfaE6P6YyvEfLhL8oWB4we10KwYJXayA5KYch/17dOPoCUbMdliy6psT
         7Jpih9TCNsvfL2hjS8vDuBLQ7IZ32DRTKU7X/s6vNMM8ZFmbtJZYiEFwKdVfGeJpH0fj
         OVtA==
X-Gm-Message-State: AOJu0Yx2zIOMgz9y3XJ7coi5xtNVzd16as2y0FWXKv60KPk35bjTXy6S
	1/zdqFWoOpToj2nCEUbFlho=
X-Google-Smtp-Source: AGHT+IEk3K/PpI9nfl/VbBHSGbZs+EJ6dGCNfsWYyhojyCyYiImdYwydyB1s8vcCPZHLAfRqhYSNQA==
X-Received: by 2002:a17:906:6a1c:b0:9dd:b89a:9959 with SMTP id qw28-20020a1709066a1c00b009ddb89a9959mr5871270ejc.16.1699568501082;
        Thu, 09 Nov 2023 14:21:41 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906504200b009b65b2be80bsm3093296ejk.76.2023.11.09.14.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 14:21:39 -0800 (PST)
Message-ID: <3e8f251498ecaac279b3e60e0f37716c3c5fa34b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: add more test cases for
 check_cfg()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Hao Sun <sunhao.th@gmail.com>
Date: Fri, 10 Nov 2023 00:21:38 +0200
In-Reply-To: <20231108231152.3583545-5-andrii@kernel.org>
References: <20231108231152.3583545-1-andrii@kernel.org>
	 <20231108231152.3583545-5-andrii@kernel.org>
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

On Wed, 2023-11-08 at 15:11 -0800, Andrii Nakryiko wrote:
> Add a few more simple cases to validate proper privileged vs unprivileged
> loop detection behavior. conditional_loop2 is the one reported by Hao
> Sun that triggered this set of fixes.
>=20
> Suggested-by: Hao Sun <sunhao.th@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

