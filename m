Return-Path: <bpf+bounces-47408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8748A9F8E84
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 10:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB3E16083C
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF41A840C;
	Fri, 20 Dec 2024 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7W6+sAc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F819ADA2;
	Fri, 20 Dec 2024 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685388; cv=none; b=Bwgwz7vRObj2bCwlEiignSxFG7rUvcdDpGRRnR22e+UunE7//ELdaB3dkgjHL0gWSmM31hx1Ykbph+QbudRM3In9NAhnevj+KzD9xvJjMwlMUIenWfTeaUn8WTnUsVTMW9RxZCiCcFwtrhh11jJ2c9LozC/2XZZlIIbY3ApL2OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685388; c=relaxed/simple;
	bh=HF6loKDrtYDofJca4NB4rK5D3YgPZRHoWna/fTkqTbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rkkbAP+wPIxFLKYw8ZaOnAFIYndvDPrEcfx9LwXUxLX6wWWaiMaEWDxwnqRQ24g2ODIsIXK0GB6UkzbulIRsrKTR+PY1RsXuPcIPOkG+kuZdrNTbPQtON5EHIPf+4rSOxb4iZkbGq92HeD0zM3fpy2H5DgBJ11jai5GS4bww2aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7W6+sAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2D7C4CECD;
	Fri, 20 Dec 2024 09:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734685387;
	bh=HF6loKDrtYDofJca4NB4rK5D3YgPZRHoWna/fTkqTbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=l7W6+sAcG0A0YaZ6V7ymIKN6ZUAhUjG1/WQUNfha/DM/Hb0NIveuP0Cnypfz/RqoW
	 v7swGhQXpzfzcZ4xrvoTG5G3aPXZsRX2d1+RY/wRAJreMyd7xAHUVnSBsQgGFLHMaz
	 QdE+wv3d1U1RXi7hzBcS3VIlspl9IRj163ls7IqtG3f/9KtrcGvGSYMsq7gQfsHvAt
	 834OdHWHpNfr0hm+3oJ696gX881Is1XC74v4BvFM5DxUI0SXaYHRzui9mcHES5yskb
	 qLtyi5qqRpxqIGZSoz/9L4XBSsvCOD2/oI37NcDSrHkL4wQDL0x1aly7qUcwadPR7P
	 g9ev8F5qdDi3w==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>, Levi Zim
 <rsworktech@outlook.com>, Cong Wang <xiyou.wangcong@gmail.com>, John
 Fastabend <john.fastabend@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] Fix NPE discovered by running bpf kselftest
In-Reply-To: <6765231ce87bd_4e17208be@john.notmuch>
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
 <MEYP282MB23129373641D74DE831E07E9C6342@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <Z0+qA4Lym/TWOoSh@pop-os.localdomain>
 <MEYP282MB2312EE60BC5A38AEB4D77BA9C6372@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <87y10e1fij.fsf@all.your.base.are.belong.to.us>
 <87msgs9gmp.fsf@all.your.base.are.belong.to.us>
 <6765231ce87bd_4e17208be@john.notmuch>
Date: Fri, 20 Dec 2024 10:03:04 +0100
Message-ID: <87h66yafqv.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Fastabend <john.fastabend@gmail.com> writes:

>> Took the series for a run, and it does solve crash, but I'm getting
>> additional failures:
>
> Thanks! I'm guessing those tests were failing even without the patch
> though right?

Correct.

test_sockmap did however pass the full suite in 6.12. So, something
changed with the addition of [1].

I guess:

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

can be added to this series, and not crashing is nice, but it would be
interesting to know how it got there.


Bj=C3=B6rn


[1] https://lore.kernel.org/all/20241106222520.527076-1-zijianzhang@bytedan=
ce.com/


