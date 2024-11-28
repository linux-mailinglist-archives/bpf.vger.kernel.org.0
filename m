Return-Path: <bpf+bounces-45790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201409DB14A
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6192164227
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25555335C0;
	Thu, 28 Nov 2024 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvwDCB80"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599848467
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732759011; cv=none; b=Ms9MNFhU+lP/Wj2aE7o6zNb+3AD+zMr0XddovwTR05yP/0q27pQPSqv7fq1DWh4qAyqJHLwCZjeNpTYFuqhzW2XEjX4GjYd2kEV8I35EspUvANGxHyJEVrw71cponku3lCxRqKuyiLKqkOrffZeZUMGeADIgZUXNMAqce2QGy+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732759011; c=relaxed/simple;
	bh=NjPS6Vr07uzuPLMQyCOGOpu0Ghr4bBf3DcN8qzVB2F8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=evdLxolb05uGfMEDj0gsCeGBZXpPQKzDzPppRBlpdXQ5XY4+f1+Mm/gDf6SrITXyGmNhpAh1+A2mjCIQoNW1jb34mIaWAEmfle35GXz3g9OyQg2YF2+q8xjXopTC8O+bDeISPYnf+923utOAS5we28Yk18Dj1HS45BZUb9OMtdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvwDCB80; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fc2b80c845so146823a12.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 17:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732759009; x=1733363809; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NjPS6Vr07uzuPLMQyCOGOpu0Ghr4bBf3DcN8qzVB2F8=;
        b=mvwDCB80Zz98iYqTCkQxMbEevPu3/l/XJSMGNNptwOGlLp/akKFeOvNQqu6Eow9Rd+
         PKQPgGTyIMt7xj2SHWjcn+z6VlXZeWdHEVuoHvRrzbPxqGv+Z+00Db5FxOUwhtTJ19kl
         z1XcnSpdFR65Q9Q97S52B8YBVYDxYTpotNOUd41kBsPrHmbM+tTwSGrdfV6dWhq/V9I+
         SZ0MyAwCDgXZybsMWFbfEwFrKerk3lcXM37zYxcDhFrcbXrM5fL1Izl4zXTyPffxNF5t
         KaCCCCbsb4jr3Xk9Q+HRRgZZJ1Co7FZrmlrqBhLfm8WK/keBf8MQDe4EtX8QfOOJKblp
         E5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732759009; x=1733363809;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NjPS6Vr07uzuPLMQyCOGOpu0Ghr4bBf3DcN8qzVB2F8=;
        b=ou4pUEiXkamh8h/P+xo8Gl2ZiIVWElMIsZfkwTgxn6wBXf3iR3uxjTm7qATxoEJ91J
         PHk9tzR8DtX5JT9KhUKYLo8lRXUnmcFent52K1k8mDM36CPnxHlIfumBbw+8QHkdL4hu
         EeNIfl34NrieSrVpbCx6hnXyAlhaWii/iAVAr5oQLCo2Fjy2jkv42r7PMFyvyLiqUstR
         9Z86aQqtVsJ4VUXOWSPVk8S0IDepyYpqRZLYhP/yrOuFjUZfUJg6KkbAqD9I6NY4ba0P
         bk9sTf9IPBz58ETzUL/jdQ6+Fbwl4v0lWIei+ev0NXJCOIOkb+AlJpRtcjaDu4vZSfqr
         qbcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZWSDcthr/7bbV5E3GAVy7rBcBFAptEjiqazXGFIjWmTAuMGjJgZw7sdkG4R2z/igq9JE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWtiF2L9QTps2Z0K0MHdy7OPNmbA4FBYkhKblCYy4Wh4qrYMH
	kQoV0h2gyYmHVreWlKPDTMYKFyscp0ETQP0qXFu372ks3uwO3l91
X-Gm-Gg: ASbGncu8foCxKgIhh7hzHjLDpwHxsGN+tzWkop2NGUOEjwDb4QFsxqznMNMV3Ys5y/L
	CC4VNZlNHj5uCEn5gJtnm20DMzFLe9r/L/jQ7PKVXQ+ty/mJiO/KZmqOh39VqfX+/C/Ra/bxGs9
	y53pkRK7xfKxd7+ZStqtH/D8yGCKJSWy+CASXjeIkdUdG1axKP6LlvIEDvj6JWBOHznDyADomc6
	Beb/uz8T/Szq+DTmr13S9lIJs/0VS5ggstkzmx569HpcKE=
X-Google-Smtp-Source: AGHT+IFHfUKdbyUHt2RWDWt29o+rPW2k/14O2buFE/4yn+undljY0xs5lo9OwJZXFhcI2+SLzV+Bzg==
X-Received: by 2002:a05:6a20:7349:b0:1e0:d1dc:753d with SMTP id adf61e73a8af0-1e0e0b3fa1bmr8345894637.27.1732759009645;
        Wed, 27 Nov 2024 17:56:49 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbac2sm263862b3a.96.2024.11.27.17.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 17:56:49 -0800 (PST)
Message-ID: <49bd3d5572da81c487d028d7aab79c847b2af998.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add test for narrow
 spill into 64-bit spilled scalar
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,  Mathias Payer
 <mathias.payer@nebelwelt.net>, Meng Xu <meng.xu.cs@uwaterloo.ca>, Sanidhya
 Kashyap	 <sanidhya.kashyap@epfl.ch>
Date: Wed, 27 Nov 2024 17:56:44 -0800
In-Reply-To: <20241127212026.3580542-5-memxor@gmail.com>
References: <20241127212026.3580542-1-memxor@gmail.com>
	 <20241127212026.3580542-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-27 at 13:20 -0800, Kumar Kartikeya Dwivedi wrote:
> Add a test case to verify that without CAP_PERFMON, the test now
> succeeds instead of failing due to a verification error.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


