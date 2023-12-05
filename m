Return-Path: <bpf+bounces-16829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7937B8062F2
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CC8282160
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2712B4121D;
	Tue,  5 Dec 2023 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiMMvQuP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B8CAC
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 15:25:54 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50be03cc8a3so5899535e87.1
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 15:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701818753; x=1702423553; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RwOKPSX0vkihIhklFvBq0piAZcOiGWKDLZgChRVWcfs=;
        b=eiMMvQuP4YrDUYLR7s2dG5ABk3WB/yTCUk2MZpko4dSK06M4hHLaYAynotmVkzoI1A
         oZE+mHStztdxsExIXDYMqUTy9S9L1YRFBOpw05u5eg96q4A0C9it3yEQ4C1jfHa6Rtm+
         quUtZFDoW+BDtXKUFCKHD8xgp3rCA7j5Km70xLxlQXXqhR1JGNoDsKE+rO8bYhhPXcI2
         7qWLL148nlqCGIdTb7Vm7/XSSCCewtp5QCkPariAmcxAeW5Hur2cowTyXNKFpJ3W8j3f
         fWka7mQ3rzRMxzr7K7WOHaXbhwN7mbpCtbHkPwRmPHRwJnr8TNlnoW+bx6SdMEe+YIIJ
         Q6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701818753; x=1702423553;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwOKPSX0vkihIhklFvBq0piAZcOiGWKDLZgChRVWcfs=;
        b=ZK9qPupDzCCWxn5waUVkC2oZcCgUAz1u/BN+rDwN6C7+FwVfr7LgC9AB2Au/aIxNh4
         7F9S/5P9o2kCu4dYEBtrm9HBGBA2m6k43zaE/kTYq/C8M5MqGs6yG4LFRr2dwLILTvzw
         vLcKoBskkN2Cz2Trex9eQfjELwTaq3ogeYvlKzHukHmKoZrJtUCmhg9npKX3kwdajAtP
         U4j9T+k8U8IRCEDs6eGR5S0drRB61NR61HWxeXWq1ODAbDS6mvXSJjQKkRHzLKnL6Y9D
         xD5maJbP/0XB9RhBpa9jpjLlP+SHIgPfU0gq8/jjnVo1v4BKYUv6eI0SZanUcHrvqKgV
         1mig==
X-Gm-Message-State: AOJu0YwapTLV6gLrafcPaubRHN6A3zulJk+wpjr14z2pHSsCCUpji9MN
	SsYFE3BS/bQthnC55+T9jLW5mrA+LAY=
X-Google-Smtp-Source: AGHT+IE8kFCEbAd3VpuSL024ScJBrmcXn8AqLNluKxmVz68NlMoDNZdnzDbDcOZjvnpQy+u5acs2dw==
X-Received: by 2002:ac2:4c4a:0:b0:50b:ec28:7476 with SMTP id o10-20020ac24c4a000000b0050bec287476mr28057lfk.58.1701818752938;
        Tue, 05 Dec 2023 15:25:52 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q13-20020a19430d000000b0050be813bf9dsm1165645lfa.183.2023.12.05.15.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 15:25:52 -0800 (PST)
Message-ID: <b67f368730e2a82d78104e74aa1f3f876ca6db4f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 04/13] bpf: use bitfields for simple
 per-subprog bool flags
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 06 Dec 2023 01:25:51 +0200
In-Reply-To: <20231204233931.49758-5-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
	 <20231204233931.49758-5-andrii@kernel.org>
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
> We have a bunch of bool flags for each subprog. Instead of wasting bytes
> for them, use bitfields instead.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


