Return-Path: <bpf+bounces-14149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243CB7E0B0F
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4213281FC2
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B931724A05;
	Fri,  3 Nov 2023 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MrKnJJUz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4F12421F;
	Fri,  3 Nov 2023 22:28:01 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7C1D65;
	Fri,  3 Nov 2023 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Kd8nDdkeZKH413rYnesg4bxUDxmt4vLm8yZD8oac5Rk=; b=MrKnJJUzpU1FSCOX9YuDdJkL0i
	eb9OYFClc4HoI3brlOmPz8IJGS3aGBmQOKCBdBUDzGEzeD+aBAqET5VIRh//4441aJmXPtfhi8nJ4
	JRjMu+uLW6s4zuyLT6HSqFQA5JdrZBhxxFL9qk93jJzNQ54IYWgP/0dW0hGYXCY9KYEStWta5lLZd
	MC+PooSAywhalPEAAAgSCy2lpSSHHDVjEdVAdJVwKurRHNGvw7r2nwTigU4pR3M9Yv/2MCKWflFPL
	e7BcQimT+nxxpQdVJjioROx/i3s5Q7QWg3hOMNvWrZu08BBGOVZHNSKcC0S95I9mDTjFWgIX+M+ry
	zQc6caWw==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qz2dw-000CpT-DX; Fri, 03 Nov 2023 23:27:56 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 0/6] bpf_redirect_peer fixes
Date: Fri,  3 Nov 2023 23:27:42 +0100
Message-Id: <20231103222748.12551-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27081/Fri Nov  3 08:43:47 2023)

This fixes bpf_redirect_peer stats accounting for veth and netkit,
and adds tstats in the first place for the latter. Utilise indirect
call wrapper for bpf_redirect_peer, and improve test coverage of the
latter also for netkit devices. Details in the patches, thanks!

Daniel Borkmann (4):
  netkit: Add tstats per-CPU traffic counters
  bpf, netkit: Add indirect call wrapper for fetching peer dev
  selftests/bpf: De-veth-ize the tc_redirect test case
  selftests/bpf: Add netkit to tc_redirect selftest

Peilin Ye (2):
  veth: Use tstats per-CPU traffic counters
  bpf: Fix dev's rx stats for bpf_redirect_peer traffic

 drivers/net/netkit.c                          |  42 ++-
 drivers/net/veth.c                            |  36 +-
 include/linux/netdevice.h                     |   3 +-
 include/net/netkit.h                          |   6 +
 net/core/filter.c                             |  19 +-
 .../selftests/bpf/prog_tests/tc_redirect.c    | 317 +++++++++++-------
 6 files changed, 262 insertions(+), 161 deletions(-)

-- 
2.34.1


