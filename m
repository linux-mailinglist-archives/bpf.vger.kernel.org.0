Return-Path: <bpf+bounces-53603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 417BEA571EC
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7186217543B
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B53B253B5C;
	Fri,  7 Mar 2025 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="i8S6m7b8"
X-Original-To: bpf@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A158224242;
	Fri,  7 Mar 2025 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376071; cv=none; b=MccOWbqccPzzqJt3Fb5Qrwz7PNmN9g5LoVVL6zE0cUXN1kkB+PVjHjJj1x9P26Ekc0HWD4Z9j44iDK1U+ZwP7SjkXJ1mTeQ5Sh/igCuwIQNmwrMGHt3TT64f8/VHUE5Uc6+1tKB09znWsR8MWurLUz1K1R2CLt6rRp1pu4x6PTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376071; c=relaxed/simple;
	bh=50NLhdDhI8V8GO7o5jfDm1HRHcKPZ5EFPUWRP6MJAIA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VOqoQDSeSxkydviSEd5JTFwJ3/B1aJabn/xJokO4FivqkN4OWalSx7m+cU8Q/QeQYA4CYpmgv5bVxDAXrEB1NR+TXrDuTpsxSyw0ouumocYe5ccM/TE/H/Y/50NEYHBdM2Jo9+A6XLFi0TXT4sNVx56QyHe+varQSOoSGEXHuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=i8S6m7b8; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527JUdCN395426
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 11:30:39 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527JUdCN395426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741375842;
	bh=50NLhdDhI8V8GO7o5jfDm1HRHcKPZ5EFPUWRP6MJAIA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=i8S6m7b8Y1bYbI/KAMAEMHyLmm3Y3FEbOP1TAp45PLhWp0+UZa3jzXqYD/PAma8k8
	 b/Oan43NQx+G8Psx4knFdBaIeGVMBY9RXM4Ckdpi6bnHPizobhJTlwJ9C/oeCEh78k
	 Stf+80k1tjWDPUZPs2+t5W4E7bcn5x1ArDfWYB9dAaAevi8RglcCPIr1tB2PeYVj29
	 O7H/KNA8J4/SredKAKB+hHce7/GwWHh4ARCY3vBRtJzld1LsziwXJjEV7Ueot213Z/
	 QRKE/cCgjphvTYe81eN7CwuSerqHAkatZ00EB031zjlPdsrSQAYtuWc+oXJ6lMl8EH
	 7JnS1tGvALMKw==
Date: Fri, 07 Mar 2025 11:30:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
CC: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
        akpm@linux-foundation.org, alistair@popple.id.au,
        andrew+netdev@lunn.ch, andrzej.hajda@intel.com,
        arend.vanspriel@broadcom.com, awalls@md.metrocast.net, bp@alien8.de,
        bpf@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211@lists.linux.dev, dave.hansen@linux.intel.com,
        davem@davemloft.net, dmitry.torokhov@gmail.com,
        dri-devel@lists.freedesktop.org, eajames@linux.ibm.com,
        edumazet@google.com, eleanor15x@gmail.com, gregkh@linuxfoundation.org,
        hverkuil@xs4all.nl, jernej.skrabec@gmail.com, jirislaby@kernel.org,
        jk@ozlabs.org, joel@jms.id.au, johannes@sipsolutions.net,
        jonas@kwiboo.se, jserv@ccns.ncku.edu.tw, kuba@kernel.org,
        linux-fsi@lists.ozlabs.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux@rasmusvillemoes.dk,
        louis.peens@corigine.com, maarten.lankhorst@linux.intel.com,
        mchehab@kernel.org, mingo@redhat.com, miquel.raynal@bootlin.com,
        mripard@kernel.org, neil.armstrong@linaro.org, netdev@vger.kernel.org,
        oss-drivers@corigine.com, pabeni@redhat.com,
        parthiban.veerasooran@microchip.com, rfoss@kernel.org, richard@nod.at,
        simona@ffwll.ch, tglx@linutronix.de, tzimmermann@suse.de,
        vigneshr@ti.com, visitorckw@gmail.com, x86@kernel.org,
        yury.norov@gmail.com
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
User-Agent: K-9 Mail for Android
In-Reply-To: <efc2ee9d-5382-457f-b471-f3c44b81a190@citrix.com>
References: <4732F6F6-1D41-4E3F-BE24-E54489BC699C@zytor.com> <efc2ee9d-5382-457f-b471-f3c44b81a190@citrix.com>
Message-ID: <5A790652-1B22-4D13-AAC5-5D9931E90903@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 10:49:56 AM PST, Andrew Cooper <andrew=2Ecooper3@citrix=2E=
com> wrote:
>> (int)true most definitely is guaranteed to be 1=2E
>
>That's not technically correct any more=2E
>
>GCC has introduced hardened bools that intentionally have bit patterns
>other than 0 and 1=2E
>
>https://gcc=2Egnu=2Eorg/gcc-14/changes=2Ehtml
>
>~Andrew

Bit patterns in memory maybe (not that I can see the Linux kernel using th=
em) but for compiler-generated conversations that's still a given, or the m=
anager isn't C or anything even remotely like it=2E

