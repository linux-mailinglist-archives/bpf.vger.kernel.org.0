Return-Path: <bpf+bounces-34114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F31792A832
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED0D1C20F8B
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D32148310;
	Mon,  8 Jul 2024 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re6Hbey5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28906AD55
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720459782; cv=none; b=LtUb4YqFZIu4YvMFoiNsuz1LY06zghOsUawXDNAxlqYUr5fIxzOp9ckWLpL1K/pO1rHcZbpp+rPa9yXqX3W0lOVL4e15q53SvmPd3Oo5ED6ACZ8OeWhdUgdW+B6LxfFfFsLiIpHvWoIF3UWmNMZv5cE+2szIBHw+YUDOvey5lW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720459782; c=relaxed/simple;
	bh=GiF5mHW+5oOS+CCtS3zBDnuEbGV+L6LJMjmKP7leY1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YzLEVYBVVqwUGhomBHHddLrnOdBcLqDFzcA4mi3xsuWyRmMMyAkfbFkkezM5XS71pbDszJDv2ZMhqYwL2FvNcY/ZG9wDW+dRTkgvOri8sF1xJGLK3nOqc+RzYzsGVf5ZQ21sAa2/4Jlm+qqqBFE/tnntGgE0Mh+Ax8F3oA9wYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re6Hbey5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b0e7f6f6fso2573336b3a.2
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 10:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720459780; x=1721064580; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w159HV3exMmQnTjfmo5jcwsvRb426HP+to/cw2bwKuc=;
        b=Re6Hbey5Nyno0HGfHcS2i9F9qy65EIZ9Xjz9bM2FXQ87qiWzUkBszTQKzWAjiLCubx
         S+ZPn/mXakRSRA4UYh9dszUasO6e2f1sRAJ06mKdYIINS1+RRi1XjAS30/QUjHd+sK6R
         Fid3b2t+w9CXJdpBopzOmTPekvIUaffaG96bpCjbrOkedxVkblJd/DSrvHJHOUD6Kid3
         fwhW7v84xfOyugg8gQEBPNMhVjFS2TBOG9TA0Df0s7l9fGYPXJ9hrXSq79n8lPnNZpBE
         L8d3xRI3gYb42c1vang9Hl84vWJFqr0Z6KbixRHIVvi8Y6VnK9zZA6jDs1kgQ2d7FM0T
         i1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720459780; x=1721064580;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w159HV3exMmQnTjfmo5jcwsvRb426HP+to/cw2bwKuc=;
        b=JHmCMRmVbVaSt2fOQK1CabIVxkuBClkbA7SesKxA/zRrf0X4dfZ57YmCJASoEvPTnJ
         EgOcUY4YfCEUF9DqPuFwc48pzmujRi4DQSAqNS+bnVoJwmjuUf5VbuKbd41NSp9uF5OG
         01jqGGPuXcBm6ZZrFsTIZgfKC/6yKGPSCgWqZAWY585Te7ygK7xNPPuqSC3tpGAyap0n
         WU201CkbHtk2giQaRHGBv00hdXAafMBBBRPWxPYdmj8cxsYhM9T+JwqjpP+ZdyIUAMYc
         cJeW9C9ZZHDm1+yKcXoiVXnvAjHue7TOz+vw5K7Re1kwOgl1JB9vIz4aTaUuyhPxUmvy
         3DtA==
X-Forwarded-Encrypted: i=1; AJvYcCXErOxKcFkE9k1UauVU6xCIJoyu7Jd04mChke2Yfk1fRVI0FEefKjeFY2TGI+d85B2qwNIlAsoJzwhVJh4pe+Lik6B8
X-Gm-Message-State: AOJu0YxQ7gKJVSqMmy6QUJUiMQaB6KZzufSQVN53MQGSeV8Wbwy3g7n2
	im7W7wAB1dQgpsbhell+Em+pHgBsQLZxKGbvTIs92hUZYt64t9n26LiXXQ==
X-Google-Smtp-Source: AGHT+IF52i/DMVAT1GXE+rOHDI6p2IrLlV8dr4jbsV+2xhnfde6DHOMSyy0F0slf2hClGtzYTbjCJA==
X-Received: by 2002:a05:6a21:3393:b0:1c1:e75a:5504 with SMTP id adf61e73a8af0-1c29821bb16mr93123637.15.1720459780272;
        Mon, 08 Jul 2024 10:29:40 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab79e6sm1155865ad.141.2024.07.08.10.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 10:29:39 -0700 (PDT)
Message-ID: <f36adfc9c1f4d9f42b22248de42795285e9de161.camel@gmail.com>
Subject: Re: [RFC bpf-next v2 0/9] no_caller_saved_registers attribute for
 helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, jose.marchesi@oracle.com
Date: Mon, 08 Jul 2024 10:29:35 -0700
In-Reply-To: <mb61psewk3y75.fsf@kernel.org>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
	 <mb61psewk3y75.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 11:44 +0000, Puranjay Mohan wrote:

[...]

> Ran the selftest on riscv-64 on qemu:
>=20
>     root@rv-tester:~/bpf# uname -a
>     Linux rv-tester 6.10.0-rc2 #27 SMP Mon Jul  8 09:58:20 UTC 2024 riscv=
64 riscv64 riscv64 GNU/Linux
>     root@rv-tester:~/bpf# ./test_progs -a verifier_nocsr/canary_arm64_ris=
cv64
>     #496/2   verifier_nocsr/canary_arm64_riscv64:OK
>     #496     verifier_nocsr:OK
>     Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>=20
> Tested-by: Puranjay Mohan <puranjay@kernel.org> #riscv64

Great, thank you for testing!

