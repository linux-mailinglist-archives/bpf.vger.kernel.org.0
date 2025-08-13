Return-Path: <bpf+bounces-65537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B0DB2544F
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C214A1C27127
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010EC299947;
	Wed, 13 Aug 2025 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b="SsWt3Rii"
X-Original-To: bpf@vger.kernel.org
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0531C2FD7BC;
	Wed, 13 Aug 2025 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115766; cv=none; b=m53anDbqVkFyOXh1CZWSvM4Pp8nSJH8Ud4MEVcHZZ6L4mURnehYZKVM0nTKLVnt1TRxESHUgGP8MdGNasfXcKed3/BIP0+EmKDQbmFhkFDBNoqIEkUhsNhZhy4a8IojotEv6zZiejyVyiuAO2mRGgryx7Q065Thrn81OYqx4AWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115766; c=relaxed/simple;
	bh=OzJUua3I3dfZfBM409ZVp6t2ABtDZJ466Pj5V+4Me90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aw5HcJp48FOSKJcCXXz1X0s11lbW4UBJ755+MlGTpNpBMs8bMxENgjm14nSvl5E/G2ZkewqMIrGxAcYmMzY/Gv41k/4OJkeB/e1RtMeFEuslp5y3+GZ6hXAOVX+MFvlk4gzNH6mZ6qb4D+xDESeh/ZhaNEpcTCGEbwBbXFmOdik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev; spf=pass smtp.mailfrom=yuka.dev; dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b=SsWt3Rii; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yuka.dev
From: Yureka Lilian <yuka@yuka.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yuka.dev; s=mail;
	t=1755115755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9oY1i4rTziRmpYFWF7P/9IupSmWDANwMkal39AXj8XE=;
	b=SsWt3RiiIhbHMPVSOdouFC/Vb/Npm35K+V5P7aDDvR+vLOFe6IKvNHV/9gkm9Zb1SUAR1h
	hbEleQ4trsAUaE+q6ZaZpISm5x38oUQsmo7YT4BWSA6yOtj8s3CpPu+l43fqshvRBZUv7l
	IprnTmfnt+TnO516um0VSeCdhNUaSpk=
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Yureka Lilian <yuka@yuka.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] bpf: fix reuse of DEVMAP
Date: Wed, 13 Aug 2025 22:09:09 +0200
Message-ID: <20250813200912.3523279-1-yuka@yuka.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series includes the previous fix to libbpf for re-using DEVMAP
maps, but modifies it to preserve compatibility with older kernels, thanks
to the feedback given by Martin KaFai Lau.

Additionally adds a basic selftest covering the re-use of DEVMAP maps, as
requested by Eduard Zingerman.


Yureka Lilian (2):
  bpf: fix reuse of DEVMAP
  bpf: add test for DEVMAP reuse

 tools/lib/bpf/libbpf.c                        | 14 +++-
 .../bpf/prog_tests/pinning_devmap_reuse.c     | 68 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinning_devmap.c | 20 ++++++
 3 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_devmap.c

-- 
2.50.1


