Return-Path: <bpf+bounces-15018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A47EA79F
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 01:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E2E281099
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 00:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459813C3E;
	Tue, 14 Nov 2023 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="EOeo82EZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A4BA40;
	Tue, 14 Nov 2023 00:42:36 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA112D53;
	Mon, 13 Nov 2023 16:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=RaTfxZ/z8U3ohMMkVQkXzGbPYH2Z46ecCaNi45hAC7A=; b=EOeo82EZN+uog60FMIUCQZ3fYc
	Qu4g1+CdrWFGxUQoBs4I6LVdD30jG9K3rOZ9slgGKx2z8BROurT8+8hAWqgmcqZ2CXHmEKyoEqaTL
	iZoL3mrNqXnFMVfLz2Fu2g4MIA8FHREZWKUdFqWsokvsCIJsVTlEBI4gedHKDP38cYWK3mkygwK53
	jlC4ENh0rp/WoCOznHkt51xhwDJa3VgXCqLZNaj+Pk4dISTdzXRDumqbAjrtGMYmtoFSMrRbTQJKR
	hHixXdqyZjLaYvoLGhI9OgVITSQyCWZ7+e4JGZbgDIqGWUzaU4IQ87FFkTdwrRR5IlcdAdQNK57Ep
	Mx5QNhKg==;
Received: from mob-194-230-158-57.cgn.sunrise.net ([194.230.158.57] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2hVe-0006TC-Sc; Tue, 14 Nov 2023 01:42:31 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: kuba@kernel.org,
	razor@blackwall.org,
	sdf@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v3 0/8] bpf_redirect_peer fixes
Date: Tue, 14 Nov 2023 01:42:12 +0100
Message-Id: <20231114004220.6495-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27092/Mon Nov 13 09:38:20 2023)

This fixes bpf_redirect_peer stats accounting for veth and netkit,
and adds tstats in the first place for the latter. Utilise indirect
call wrapper for bpf_redirect_peer, and improve test coverage of the
latter also for netkit devices. Details in the patches, thanks!

The series was targeted at bpf originally, and is done here as well,
so it can trigger BPF CI. Jakub, if you think directly going via net
is better since the majority of the diff touches net anyway, that is
fine, too.

Thanks!

v2 -> v3:
  - Add kdoc for pcpu_stat_type (Simon)
  - Reject invalid type value in netdev_do_alloc_pcpu_stats (Simon)
  - Add Reviewed-by tags from list
v1 -> v2:
  - Move stats allocation/freeing into net core (Jakub)
  - As prepwork for the above, move vrf's dstats over into the core
  - Add a check into stats alloc to enforce tstats upon
    implementing ndo_get_peer_dev
  - Add Acked-by tags from list

Daniel Borkmann (6):
  net, vrf: Move dstats structure to core
  net: Move {l,t,d}stats allocation to core and convert veth & vrf
  netkit: Add tstats per-CPU traffic counters
  bpf, netkit: Add indirect call wrapper for fetching peer dev
  selftests/bpf: De-veth-ize the tc_redirect test case
  selftests/bpf: Add netkit to tc_redirect selftest

Peilin Ye (2):
  veth: Use tstats per-CPU traffic counters
  bpf: Fix dev's rx stats for bpf_redirect_peer traffic

 drivers/net/netkit.c                          |  22 +-
 drivers/net/veth.c                            |  44 +--
 drivers/net/vrf.c                             |  38 +--
 include/linux/netdevice.h                     |  30 +-
 include/net/netkit.h                          |   6 +
 net/core/dev.c                                |  57 +++-
 net/core/filter.c                             |  19 +-
 .../selftests/bpf/prog_tests/tc_redirect.c    | 317 +++++++++++-------
 8 files changed, 334 insertions(+), 199 deletions(-)

-- 
2.34.1


