Return-Path: <bpf+bounces-75691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B54C91554
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 09:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 270E74E4068
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 08:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60872FD7B8;
	Fri, 28 Nov 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="CtP0t7ZO"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965C29E0E6;
	Fri, 28 Nov 2025 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320342; cv=none; b=L5dZ953b4+iUhPsEJmlExzXWj1+DUWIrA93GjHAkqtC29wjGuFZbAL9jubj3+IPNtm1BxBMqPzI7IxIp7TqApc7GsvM6HWXOWbFVPLpuEjea2553pXCj1Xg8lvdFuoyx0jPxtmuYKtgGfBySczMFe4piFYEfupmywFm+CpNQMgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320342; c=relaxed/simple;
	bh=YAM74eKyEhCV+5y8iMMdd/s1oJmYepKSWrFYbusRBrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh/aCJ+EKn+HSqczfFWA+hYbaGZjeq5yglCAJLSEszroLTBWeaaBKC48jSWmVeF8ssZvijisOR2loG4yo2axeVUcLlr8pRWy/1zGUL8QH2YT5vCFVfUqLhuf9TVNaqwpo7AqudwkblPM2ec+tBHjvZFvyLTNvO/i03meZ772LFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=CtP0t7ZO; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.15])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 2067B40D3C55;
	Fri, 28 Nov 2025 08:50:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2067B40D3C55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1764319820;
	bh=YAM74eKyEhCV+5y8iMMdd/s1oJmYepKSWrFYbusRBrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CtP0t7ZODyDAMXPrQBDIuDlL8R4pW+xRr1N5PIJY54/JpA/crdhfqI3LaLNFe6MiY
	 YWfGk5lAlDyI8tSI4TbwYvWjJ72sJ1f7eKOk6Wl7SANbJJDPu3WVFF1BeuUL2YgJl2
	 lo8m3H08hzF9NXfHXH+yIDjwtD409VIGhAyghWbg=
Date: Fri, 28 Nov 2025 11:50:20 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Alexey Panov <apanov@astralinux.ru>
Cc: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Song Liu <songliubraving@fb.com>, 
	Martin KaFai Lau <kafai@fb.com>, lvc-project@linuxtesting.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, 
	Jay Vosburgh <j.vosburgh@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>, 
	netdev@vger.kernel.org, Veaceslav Falico <vfalico@gmail.com>, 
	Moni Shoua <monis@voltaire.com>, KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Andy Gospodarek <andy@greyhouse.net>
Subject: Re: [PATCH 5.10 1/2] bonding: restore IFF_MASTER/SLAVE flags on bond
 enslave ether type change
Message-ID: <20251128114704-2369311bf17518b70a95dcb7-pchelkin@ispras>
References: <20251127190140.346-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251127190140.346-1-apanov@astralinux.ru>

On Thu, 27. Nov 22:01, Alexey Panov wrote:
> [ Upstream commit 9ec7eb60dcbcb6c41076defbc5df7bbd95ceaba5 ]

c484fcc058ba ("bonding: Fix memory leak when changing bond type to
Ethernet") has a Fixes tag pointing to the above-mentioned commit so
should be ported as well I think.

--
Fedor

