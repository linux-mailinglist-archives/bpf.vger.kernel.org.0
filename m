Return-Path: <bpf+bounces-78491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E51A5D0DDF1
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 22:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 554CD304D48B
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 21:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4AA2C1589;
	Sat, 10 Jan 2026 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fJueRw8b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B82777E0
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079230; cv=none; b=V+lTsguZ6Bs1Xj2sOIU/fYY62Hz3BRIdux1Bh6p0ZH0ER4nW/Mzg4B2MQ4vo0swcy7MLrEbxU+f2jUOBK6vWdzStWjzuxcD6MnK2+HM7earPkn3Sx68zUPIdN7C+x+yPF+3czp48pM3sqJPjAY9gvGvEnjSHur8IJb2lMgfIlGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079230; c=relaxed/simple;
	bh=IXfvwuOK5pWc53OJI2lcx6KVCLcJK9alGMkZ7Y+PoPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u0uNmjpV114YzSLhs6BHlIzp8FcDcFN9IVEAl2RdtP/C7tYpvNdpUQU6MKXlnPsrMwf3eBbAsHk0voZ6We+/mXmXEdPZJkxiV6ynKdGwcab4e25EsZBnexW44Xo4UtjTCFz9KBCV+HHJWBJUlWe1xUUdJddYiLNlOZHRu6L5mpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fJueRw8b; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so8640311a12.0
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 13:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079227; x=1768684027; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IXfvwuOK5pWc53OJI2lcx6KVCLcJK9alGMkZ7Y+PoPE=;
        b=fJueRw8b7THgvh7RWhoLt4p+QlR6Z1aXuNfnS8wX2ea0PJnk/lQLiIn3BA5PjEey0J
         VOEfDZSefDiAiknS+PLDzXJ5Y0gtGZ+J58GdFMScFTOcLodxBrP4WV8h2E7fz78k73lc
         8f5jzRuTaSd6w1fOICPFY5prtKqiZ/U7/bmcjXPPYM29czEPG0sk9PMi6l+NPWzMjT+1
         lzggTSVBEAN8SXoaFdEUyIlDxo0jZrs7Eg2gxzzSKT2grHfB3mtE61w61hJ93e0HjKcm
         ADltWAaqOvpkwE4sczsDffbpFpOj0StfMhqwoKrX8UiuaaW7cqvbMJbXcBP63WgDlfmp
         RPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079227; x=1768684027;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXfvwuOK5pWc53OJI2lcx6KVCLcJK9alGMkZ7Y+PoPE=;
        b=NNBOUpC7ywQQXDvy3mtbp+MTzTIgoxSfpOZgaJeCc0xQLZnmDQq49euF/1rwH0aWLW
         tt6LJXXiXv52WtE310a2t1EiqfpZaxekJuFzaSQ0lpGMzS5Jh4kl8aEFTj2Wh7SWJc+c
         9eBT/GNQtUhePl/831OscPorhxFK6ULZsPz8wsy0khNncmTsKsIxXRHDsU2LE7IHbjCM
         YCDDR1vjb3xpa3a0N8SrW0/gH5Tzr4aESnLpud9JnJbC3/J6MQ94ftzxqfYM3rAvzarS
         GlJMeGvhlUfBdAtpb8Z0BiP944LDwAr5igtGi4j6zayTi0IQioWPQrIdPY43ibHh0Pvu
         fhxA==
X-Gm-Message-State: AOJu0YzHs0G7iu56cmqPk4l4vqm8jQ2MVGxHuGkqUrMa6e3YqEpKPn1E
	r/FKq0cNXPfCAgIprO+se4p4cP4N3XL8SYPP7KPdhWvZBBJEQ0uRAgPNElD6VC608m/454ZqkeQ
	UdSzt
X-Gm-Gg: AY/fxX62ByNEMJKaEKZQUhMoN1BuvjwqhZcwlo7M/l/grbn1nqQhgestGIbdPF+j4pv
	2T8tW+fsqgvHssWPfNHUr4F4tgTVczd6t64YCnAU1ZQ6Gug+1HL661dJWWIeHm7i+S873C2TAon
	liZ1s6WzCDbCiYmkUSf5nVxszBDebiCYS8sqY7rK4pVtkKQ9Ynyi3SZ+0lI/pQ4yA8W6U4DPXXb
	FfaEFAT5l531JCg1CDTLEXCgZml4adLoxuYQGyKI4PzpCgPtvltyMEy5PDH2cZ1M2D54cp76RxL
	AaZRdQFCIM7Wgj+YSVy8R0OMzTW3daeZ3Am2ym8f4HSwjmBs9lOV14HGnqzwgl2e/oU9ZBkJKWT
	s4aDA9WYoT75YzibjwLN0jX0peBDME3EMz995phMPHLq8Dkwr6AAhY/Ux5beRReb8R4eL2DEqQr
	B5
X-Google-Smtp-Source: AGHT+IG8W3YOUpUXKIynx0DSfOesFASMjUPxRhrkXK7LL+GlWPJKWTfQ6zS57nlw8gfEkHEN794pLw==
X-Received: by 2002:a05:6402:2683:b0:64b:62f7:c897 with SMTP id 4fb4d7f45d1cf-65097de7c13mr11938356a12.5.1768079227158;
        Sat, 10 Jan 2026 13:07:07 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:cd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6648fsm13361525a12.28.2026.01.10.13.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:07:06 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Simon Horman <horms@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,
  Yonghong Song <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,
  Hao Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v2 00/16] Decouple skb metadata tracking from
 MAC header offset
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	(Jakub Sitnicki's message of "Mon, 05 Jan 2026 13:14:25 +0100")
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
Date: Sat, 10 Jan 2026 22:07:05 +0100
Message-ID: <875x99uqh2.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I've split out the driver changes:

https://lore.kernel.org/r/20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com

