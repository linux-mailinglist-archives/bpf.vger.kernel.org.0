Return-Path: <bpf+bounces-53655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98CEA57E76
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 22:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D7D16DF59
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8394F1F5855;
	Sat,  8 Mar 2025 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GixY0COE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CE02BB13;
	Sat,  8 Mar 2025 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468696; cv=none; b=RZIHzywp6OCGGcPNCEdfhVfMhmJipXrb93jt6Z57PkigWyZIN2K7UGgkHFCsbWiZF67e/sPcg0DHMdspH0yxE419F6w5CIP9FFC800UTv1HAhwyL2LNpG8J5xqKSc6xc5adc43ALCEVORt8CuGyQJFA4uxevkY52BSSLUIdHLhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468696; c=relaxed/simple;
	bh=C2Kv4MITOi6OL55LCwWuTAWFMhpww0gMCavXp5OrRwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FI0/RGLihUD5RtMsvfiEPT03maRkGbU0md8HM8R5LABm2vuHtM9RXCW/A9XE38xFgPVLG918ag9JkEXyo3IKCm1Rte6U64UhouuMkc0DST8mlZWJWBc7gpQke1g3PKtl1FE05u5sGiwESGfGBImtfpySoH95SmV9kj0zh39apmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GixY0COE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DD9C4CEE0;
	Sat,  8 Mar 2025 21:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741468695;
	bh=C2Kv4MITOi6OL55LCwWuTAWFMhpww0gMCavXp5OrRwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GixY0COEojb9BpSGMfZUPaSIh5/UztIPX6UO9C+pr1S07atQRXvlUHGXJ/ARkhO+b
	 QfjqXcSmrT0KNqauOuXc50F5rj+HFd5uU5I2FrCciuCDcpT1UkC65mEyzTjjl/qfR2
	 LcUqBTCEBJHtiWiq/TDSW+D0s114atS1+0wmA+b19TMiFon+O+Kaqgh9zObiotksSW
	 CDC2CUN/RgL+kzM9wlai1zrjPZdpTcqIUiiGyZ6fBqKiEaEBgRSv70j07R1SYjZ4ZC
	 tic+K4M85wJE9Wb0d1DDLaEc24sXpwfexj+5+7u8MahZbZmVsajh5UGPqTiVfoHHQD
	 qrZrelpzfiguA==
Date: Sat, 8 Mar 2025 13:18:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, "Ahmed Zaki"
 <ahmed.zaki@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Kohei Enju <kohei.enju@gmail.com>
Subject: Re: [PATCH net-next v1] dev: remove netdev_lock() and
 netdev_lock_ops() in register_netdevice().
Message-ID: <20250308131813.4f8c8f0d@kernel.org>
In-Reply-To: <20250308203835.60633-2-enjuk@amazon.com>
References: <20250308203835.60633-2-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Mar 2025 05:37:18 +0900 Kohei Enju wrote:
> Both netdev_lock() and netdev_lock_ops() are called before
> list_netdevice() in register_netdevice().
> No other context can access the struct net_device, so we don't need these
> locks in this context.

Doesn't sysfs get registered earlier?
I'm afraid not being able to take the lock from the registration
path ties our hands too much. Maybe we need to make a more serious
attempt at letting the caller take the lock?

