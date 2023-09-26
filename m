Return-Path: <bpf+bounces-10844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF977AE559
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 07:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D264E1C2091E
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 05:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9440E4A2A;
	Tue, 26 Sep 2023 05:59:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0372A4406;
	Tue, 26 Sep 2023 05:59:37 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02F7D6;
	Mon, 25 Sep 2023 22:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=1OE+HirvlDPCm+7RwYQEtnAESKZ0xxf7xT5DgRs5RlA=; b=iRtkIeiLedc+kI5xIm1DeMfQJG
	Q6ZFEfEqhv7uPQy/O7cBkcF2EwLSA69RTFY7tkTieYwWg3+RQEh1Zd+YYugUwDT9tNrekJS04B3FM
	xaJY9VEtQ5HEy8zjr8KcJdLC4fyh14wts4ZQDLuZb+zSPH6ooG2MQTTSTI3bJsChQ71r8+79K59pd
	snUfYx4uuuYwqQp2MD9IQNSA/a3+3gPD2mlsxdAJkpMA0GeGdMkfZCB4nxsBQdHetqzSfpN2Y35Pj
	bkpzbXYiHbPgM+gOz4+LpVLYzQVak6T/q2t5N4TJgoCvb24Odvfy0JampKP5WSlRHcK1xP4BUtG+e
	veAZojwA==;
Received: from mob-194-230-148-205.cgn.sunrise.net ([194.230.148.205] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ql16Z-0006mD-Jv; Tue, 26 Sep 2023 07:59:31 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	martin.lau@kernel.org,
	razor@blackwall.org,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 0/8] Add bpf programmable device
Date: Tue, 26 Sep 2023 07:59:05 +0200
Message-Id: <20230926055913.9859-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27042/Mon Sep 25 09:37:53 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This work adds a BPF programmable device which can operate in L3 or L2
mode where the BPF program is part of the xmit routine. It's program
management is done via bpf_mprog and it comes with BPF link support.
For details see patch 1 and following. Thanks!

Daniel Borkmann (8):
  meta, bpf: Add bpf programmable meta device
  meta, bpf: Add bpf link support for meta device
  tools: Sync if_link uapi header
  libbpf: Add link-based API for meta
  bpftool: Implement link show support for meta
  bpftool: Extend net dump with meta progs
  selftests/bpf: Add netlink helper library
  selftests/bpf: Add selftests for meta

 MAINTAINERS                                   |   9 +
 drivers/net/Kconfig                           |   9 +
 drivers/net/Makefile                          |   1 +
 drivers/net/meta.c                            | 943 ++++++++++++++++++
 include/linux/netdevice.h                     |   2 +
 include/net/meta.h                            |  38 +
 include/uapi/linux/bpf.h                      |  13 +
 include/uapi/linux/if_link.h                  |  25 +
 kernel/bpf/syscall.c                          |  30 +-
 .../bpf/bpftool/Documentation/bpftool-net.rst |   8 +-
 tools/bpf/bpftool/link.c                      |   7 +
 tools/bpf/bpftool/net.c                       |   7 +-
 tools/include/uapi/linux/bpf.h                |  13 +
 tools/include/uapi/linux/if_link.h            | 142 +++
 tools/lib/bpf/bpf.c                           |  16 +
 tools/lib/bpf/bpf.h                           |   5 +
 tools/lib/bpf/libbpf.c                        |  61 +-
 tools/lib/bpf/libbpf.h                        |  15 +
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/Makefile          |  19 +-
 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/netlink_helpers.c | 358 +++++++
 tools/testing/selftests/bpf/netlink_helpers.h |  46 +
 .../selftests/bpf/prog_tests/tc_helpers.h     |   4 +
 .../selftests/bpf/prog_tests/tc_meta.c        | 650 ++++++++++++
 .../selftests/bpf/progs/test_tc_link.c        |  13 +
 26 files changed, 2415 insertions(+), 21 deletions(-)
 create mode 100644 drivers/net/meta.c
 create mode 100644 include/net/meta.h
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.c
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_meta.c

-- 
2.34.1


