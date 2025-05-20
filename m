Return-Path: <bpf+bounces-58558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53EFABD9A3
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 15:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83EE3B4A8D
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 13:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AD4242D63;
	Tue, 20 May 2025 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mu7r6TYZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07010242D85
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748269; cv=none; b=DeVwmmNLQbmIIUBtuy/MBaeZNLBSGnJ+Lwyf2H0rdXq3KeTx0o/IC5De2Y1tvdlBb80D8qP0jludgPhIbFybDbRP7XbCUi8OFBomFhtD4xca8l58PmrynmKG07ebjh5IcSqaEpn66dmNjTA1Rkpq9h6v5oN6K5JSj8X149B8j8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748269; c=relaxed/simple;
	bh=U5YZUOHnFba3YEEPRb4B8MFish1XcE6mlQd58Sc0Ulo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsmaU56FIE2k1etzOh/stwMxjgxT2JHVpsvMusAvy9SZkIbWzRMPLDPfMuGuLagLt02Oq/xE1b5DM3niWoeasS1B1AP26+PrxK6TbDEUr6mPjU9HN/PuridQud7rVPcEh2EWq5EcdF3CvXgQT0Tlxath6OT6FddglB93zZSmrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mu7r6TYZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747748266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMsyQ7VNnN2qO1o186LSTMN+Ccv8Zs0ud4b/iPJ/c0Y=;
	b=Mu7r6TYZVnZDNTwaVS6nfPlEKjeXDqUwq6mlWUM5aXftYmxfJaiJ7FECU7UoXt4t/FpFBJ
	p+NptotoE3cWCaB6IxCZU7yxkSMYc4hWcRutg6U4aNiZ3ODP51bPmphi3HQOmPKVZH2zb6
	kWh6wbY/ws3KTrahoHwio2BVaqRdbxo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-FFixGeFKNyWx06SnJt-_Qg-1; Tue, 20 May 2025 09:37:45 -0400
X-MC-Unique: FFixGeFKNyWx06SnJt-_Qg-1
X-Mimecast-MFC-AGG-ID: FFixGeFKNyWx06SnJt-_Qg_1747748264
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a3696a0ce6so1237696f8f.3
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 06:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747748264; x=1748353064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMsyQ7VNnN2qO1o186LSTMN+Ccv8Zs0ud4b/iPJ/c0Y=;
        b=U0kYvsXwFnSYJAaVBtUNAJUc/o5BZfcMPCk1fGK1Fei81gpL8Nw94bRmjw8qNczvoV
         H7C03uCDps9UMVN1oquTWizb/jeRgxSxYy4IFXZS2tXsyQYaV7DkXJEy92qZi/2R1Zlw
         EX84WVpJLyKKB0/U4KiGCGCGQLk9ru+X0iDiDHe8AYXRN9XhYYeP9JTqZnlfTil9KZlc
         wSsoj46ZC4x1jvXf+Z3XGiOHp3pQBov6qshwvls57KXcHRG2Nfu9wv+1xa/FDMQHnJiG
         4Zy6cHcvQSfyouL2o+PVJcYmurw+3x9BN5i8eSO20XwP3UuwY7WSgBnVM03yFJZ0yS8L
         7kgw==
X-Forwarded-Encrypted: i=1; AJvYcCW0MUCqEdyv/an8EtC3eKwAIG4t9fpzs7GN90J8sNmWbmv1gV69HjSwj06QEBhiIE8w6Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCcmAZTzPEo3RYpcwrCxQ5r6c7RtjJqrisEfVhw2dXmc6G2tcu
	J13pN+cEq8Vm4appGB1sVfxTmQYktzeotadjsDgaR9QNCH5xsTwcKS646NX04uzf5gA+Ov0QzAn
	yNhDGFjACyZNkLKlHkt2+BmntWYCwT/NV5NKSTjLCQJcE+2R4MH2ymw==
X-Gm-Gg: ASbGnctzkVOdA9EDiBuCDb0TI3AeTqoeLjCwum+jEmCwnKoD8oJv5PMGgCBlSMVzxhV
	v5J0V/2RStlXAgr/mkeDU8TiXD+8PCiJPibzqVpwprr8VKRDgciYaiKx+uSo4Sz2Yc1+Ts4rADh
	j71ssVapW3vYog4aPVzt8FWLkAr1Md7AROl9zdgHLzqKVdxNFYPZ0VNn8u2Wnuq2/K6FL2emz59
	UE3+3jFd/xHgoBAP1ZIRzSDoyK0Hmog9ZmZwtng/QeeL8LcLY8Id3jNcZtIbT+KIJ8bnaS87GkA
	kWfT/4Ks3KZe9EAEsiU=
X-Received: by 2002:a5d:5f8d:0:b0:3a0:8492:e493 with SMTP id ffacd0b85a97d-3a35c834f91mr16985997f8f.6.1747748264371;
        Tue, 20 May 2025 06:37:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2IgQR6pfl4f9JZX+mTcQQJIcZJQqSQkpv9zrll3ynmvnMB9+rl/8mcTBCpK5VIAeoxVyW1Q==
X-Received: by 2002:a5d:5f8d:0:b0:3a0:8492:e493 with SMTP id ffacd0b85a97d-3a35c834f91mr16985962f8f.6.1747748264000;
        Tue, 20 May 2025 06:37:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710::f39? ([2a0d:3344:244f:5710::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f23bfdd9sm31041385e9.18.2025.05.20.06.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 06:37:43 -0700 (PDT)
Message-ID: <c9465324-b2df-4507-8d17-7cdda55a60f0@redhat.com>
Date: Tue, 20 May 2025 15:37:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 09/15] tcp: accecn: AccECN option
To: Eric Dumazet <edumazet@google.com>, chia-yu.chang@nokia-bell-labs.com
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-10-chia-yu.chang@nokia-bell-labs.com>
 <ba1b1b36-cd7f-4b36-9cee-7444c219b4f5@redhat.com>
 <CANn89iLkyC-MfGUTvcV=zr+LYKzMsyv1im1Oft6EAXYb2x0jGw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLkyC-MfGUTvcV=zr+LYKzMsyv1im1Oft6EAXYb2x0jGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/20/25 12:32 PM, Eric Dumazet wrote:
> On Tue, May 20, 2025 at 2:31 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>>> This patch uses the existing 1-byte holes in the tcp_sock_write_txrx
>>> group for new u8 members, but adds a 4-byte hole in tcp_sock_write_rx
>>> group after the new u32 delivered_ecn_bytes[3] member. Therefore, the
>>> group size of tcp_sock_write_rx is increased from 96 to 112.
>>
>> Note that I'm still concerned by the relevant increase of the cacheline
>> groups size. My fear is that this change could defeat some/most of the
>> benefist from the cacheline reorg for all tcp users.
>>
>> Some additional feedback from Eric and/or Neal more than welcome!
> 
> I have been trapped lately with production issues, sorry for the delay.
> 
> I am still working on an idpf bug, hopefully done today.
> 
> Then, I am OOO tomorrow, and can have a look at the whole series on Thursday.

Thanks Eric!

@Chia-Yu: please consider the above timeline before posting a new
revision. i.e. it would be likely wise to wait for the additional review.

/P


