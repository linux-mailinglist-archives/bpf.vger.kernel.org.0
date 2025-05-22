Return-Path: <bpf+bounces-58725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A0AC0E10
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 16:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258A74E596B
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E3228C875;
	Thu, 22 May 2025 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="HKj4qv6A"
X-Original-To: bpf@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0ED1F09B3;
	Thu, 22 May 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747924147; cv=none; b=QDOVqMsGL2iOIXY3RKmfW5hrJhL/JtvjVXVfvWheXuPcjLe4BvLyjdgrQ1i7TJnJNtc4KnhPPWpOFKZRaujgY54rWdHo9gx9pRJ8j62z8hY+msaMAFxEqSp4pBMcaBmaajEHWtgHh/LaRpYTBIbp4AEEBznVDrTgv+LVceEgmhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747924147; c=relaxed/simple;
	bh=0xdoVZSHqQNJL8DyRyMKO1Xb1BzCSnmhrjE9JK1DF9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IxwcWOe+S05MnnA1KCliQCr2P2K4cS/C0+olrvtChHlmHKd0CVIUQVXD32juEL81YsoqqHPlzY2BV42FhVQbfTjdcYHGCNk95LR/YX//fdurnaKl8c2dCtxyZBDcuJfA/csQMlc9zhp9ihS5DUYGl6MDRzfTjgRx495FR+3OIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=HKj4qv6A; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2b89:0:640:9815:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6A45C6236F;
	Thu, 22 May 2025 17:27:29 +0300 (MSK)
Received: from alex-shalimov-osx.yandex.net (unknown [2a02:6b8:b081:6420::1:13])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id NRQ6W30FciE0-dzt0lpPU;
	Thu, 22 May 2025 17:27:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1747924048;
	bh=7MNz74RTEhR3rcKWJ8ZtJcPNJ/4oo/fxpgPe3AC8HcE=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=HKj4qv6AvW+P/pYhVduCAddBNSl9OprCcckmFNXdIQiIBtM1LKTkk8QsopKZQzL2R
	 uxTtO1T88zbiJo5E6rwTGWcppKFCyYxFy0Zvcu8C/Hr+c8MtheiUqx1ncX6iK4vxQj
	 GckvJaDDLehLsgwwpjMjGJuARUrtAZALEiJVFwhE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Alexander Shalimov <alex-shalimov@yandex-team.ru>
To: dxu@dxuuu.xyz
Cc: alex-shalimov@yandex-team.ru,
	andrew@lunn.ch,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jasowang@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH] net/tun: expose queue utilization stats via ethtool
Date: Thu, 22 May 2025 17:26:54 +0300
Message-Id: <20250522142654.96438-1-alex-shalimov@yandex-team.ru>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <81d6fb01-e914-4c04-875a-58e61b433a80@app.fastmail.com>
References: <81d6fb01-e914-4c04-875a-58e61b433a80@app.fastmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> Thanks a lot for your response, Daniel. Good to know that we can get
>> this information without kernel changes. And I learned something new
>> :) Replicated your examples.
>
> Nice! Feel free to CC me if you have other stuff in the future.
> 
> Bug fix for parsing implicit module BTF up here:
> https://github.com/bpftrace/bpftrace/pull/4137

Daniel and Willem, I appreciate you help!

My mistake was that we had tun configured as a module (CONFIG_TUN=m), and I
didn't explicitly specify the module name in the kprobe. Also, thank you for
pointing out that recent kernels have added the 'priv' field to net_device.
As a result, the script has now become much more universal and simpler.

Now we will think about how to efficiently implement monitoring on top of
our bpftrace script, which dynamically reports queue utilization.


