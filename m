Return-Path: <bpf+bounces-75711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63071C92221
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F0B3A70EA
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D5832E727;
	Fri, 28 Nov 2025 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="nt2PhpbI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D01E32A2;
	Fri, 28 Nov 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336633; cv=none; b=OWvSv4gHB9AkBaj341DbM6CgWQOVR3S8uaDlFKofyR/Hw3D0hsWp9qiVsO5XokM7LY91BAVBxV8WT61a+lnq91Wddo8unJafQkVDx1qfV10yXLEg+6JtO4P07qeEPwqWfqdHkL/64L/N/glQ1KcSIJdwpyHDKNeTrErLGQ0Tgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336633; c=relaxed/simple;
	bh=vUh/7k2pNcs1qKtAadocXz/3E+juXBsA3fyjDgDAYpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7xMgbwGpSs6af43S+ktWHPJV94otKtwbC9NaLbW2Bi19K9J++SCQIPJvTD2tXyt9MDIJZ6HjFGCDbr8Tm/BnYJ2mW0zJTyxeFLeemfjkNaqkv+S9Lo55iccQjlC6qDsQZW8O0u+7HGZ3EHuOVGDhFwYPyPCV8n+MdK2FfWHOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=nt2PhpbI; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1764336628;
	bh=vUh/7k2pNcs1qKtAadocXz/3E+juXBsA3fyjDgDAYpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nt2PhpbIr2pwtrWu1/j5I4KBUiKfEHpY/p6Fq6qkN9a7wD6DotZ1r1tsvUaTinItq
	 F8h3/V7sccTzxh6QCB//D4NKa3NQVPyiN6Dn1REhpxig8T2DlbsoTlL58FK+PRQEGh
	 8/8yJvz2Fe5TjBOL+3wYdqTni+ot8BIHjop9poxjKmD0jKsOJVR576jvKus3Kz0yA1
	 d1NnT2M0nB1CV9E8WpwXQqBCRjG+IU9cTlHT3RxJs4tT7IkEfymWzMVeSN0L0HbTZn
	 LXSHJbL//8pHQPJN9sr5ZGqpJs7d9HROp0P4e+6zLRzvmkj1a2DSOCF4iOucOzbT4f
	 vMU/h83fvzeIg==
Received: from gca-msk-a-srv-ksmg01 (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 24A901F97D;
	Fri, 28 Nov 2025 16:30:28 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri, 28 Nov 2025 16:30:22 +0300 (MSK)
Received: from [10.198.57.41] (rbta-msk-lt-156703.astralinux.ru [10.198.57.41])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4dHvKk2DPGz2xBj;
	Fri, 28 Nov 2025 16:29:46 +0300 (MSK)
Message-ID: <8c5bbb80-3d28-422e-9dc7-0caebb699986@astralinux.ru>
Date: Fri, 28 Nov 2025 16:29:36 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH 5.10 1/2] bonding: restore IFF_MASTER/SLAVE flags on bond
 enslave ether type change
Content-Language: ru
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 lvc-project@linuxtesting.org, Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
 Veaceslav Falico <vfalico@gmail.com>, Moni Shoua <monis@voltaire.com>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andy Gospodarek <andy@greyhouse.net>
References: <20251127190140.346-1-apanov@astralinux.ru>
 <20251128114704-2369311bf17518b70a95dcb7-pchelkin@ispras>
From: Alexey Panov <apanov@astralinux.ru>
In-Reply-To: <20251128114704-2369311bf17518b70a95dcb7-pchelkin@ispras>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 81 0.3.81 2adfceff315e7344370a427642ad41a4cfd99e1f, {Tracking_arrow_text}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 198520 [Nov 28 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.20
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/11/28 12:43:00 #27986045
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

28/11/25 11:50, Fedor Pchelkin wrote:
>> [ Upstream commit 9ec7eb60dcbcb6c41076defbc5df7bbd95ceaba5 ]
> 
> c484fcc058ba ("bonding: Fix memory leak when changing bond type to
> Ethernet") has a Fixes tag pointing to the above-mentioned commit so
> should be ported as well I think.

Thanks for the suggestion. I've added this patch to v3.

--
Alexey


