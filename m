Return-Path: <bpf+bounces-74797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E26C6620F
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 21:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 280694EE6DC
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE912820D1;
	Mon, 17 Nov 2025 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RbgafMXo"
X-Original-To: bpf@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9934AB18
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763412008; cv=none; b=KVZ6CNpS3dRKJRmNJrm+QVDadW7XKs8QBrkytYKuY61ZUbfrTVY3RoNC4E8Kh3ZXIzx1aAXAgvMcxKXcNro93w9RJ0+ImsWhGn2r3gWeqPxXrNJCLgxgS7ZkpSar7UbIPC4kLpSTbdrji+6nTTkQJjokdCO2Z6qham+qBUwQNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763412008; c=relaxed/simple;
	bh=wdnCzxp+IGn8jaeY573JYIyUY74DdPbSbJbL2nzt18M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gwhon9UyZQU/lZ0IAnunOlHo68ljLVfb0FQnPtD61xW3wu57g5pmEiFy17UpSyno5jbRdAaYPXY+bwIXS+uY+8wi7L62C20VFogchXUqttw+8D4dc7stXflYzf4QcSAFN0m90fhdkdQxmmk50mi2VLKUomjSRgSaTn8G28kYdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RbgafMXo; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d9KPK4chXzllRp5;
	Mon, 17 Nov 2025 20:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:content-language:user-agent:mime-version:date
	:date:message-id:received:received; s=mr01; t=1763412004; x=
	1766004005; bh=l8WbDB7Bj1fAyuAmEkyrTuInLmN5Hjh1bG5P1yRbgVI=; b=R
	bgafMXod7mqZkumgB0U2jQf+y5Uv5Qzss/4K5vFJ+EtiQQH70ZGCJR4m79Vf82bi
	uLSAp2dsIKFFpvjVXKBKXyT+aOCaJEkeiZzYs7EzCocbJjaGK4xryMIz0p2/G4D3
	WwBOcSxZjMEZqs2MacYAF1Kwhl8q+DwkwQLXerlCz7S5Lg7WYxBM1x9nTX2+U/6L
	G+T99RCzHyaHp2RG3BsmwBGxLwkaspeYcKMCgPrj1Gz9qJhj4cWEjWasKpU2F631
	Od8A2kaVPJCKOsz5x5V4CTSvvkFXOsfcPu88dtAnLW4Rd9a+xQBAkSSVnldygczc
	a30tsCd8IrS+5vrec7pUw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PBkAsIWp7BKt; Mon, 17 Nov 2025 20:40:04 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d9KPH0SPFzltH78;
	Mon, 17 Nov 2025 20:40:02 +0000 (UTC)
Message-ID: <2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org>
Date: Mon, 17 Nov 2025 12:40:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nilay Shroff <nilay@linux.ibm.com>
From: Bart Van Assche <bvanassche@acm.org>
Subject: Kernel build fails if both CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN are
 enabled
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

If I enable both CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN in the kernel 
configuration, the
kernel build fails as follows:

$ make
[ ... ]
WARN: multiple IDs found for 'task_struct': 107, 36417 - using 107
WARN: multiple IDs found for 'vm_area_struct': 271, 36434 - using 271
[ ... ]
make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
make[2]: *** Deleting file 'vmlinux.unstripped'
make[1]: *** 
[/usr/local/google/home/bvanassche/software/linux-kernel/Makefile:1242: 
vmlinux] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Is this a known issue?

Thanks,

Bart.


