Return-Path: <bpf+bounces-32214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1740A9095E8
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 05:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E57285D22
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 03:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E7BD26D;
	Sat, 15 Jun 2024 03:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="VDFo1zls"
X-Original-To: bpf@vger.kernel.org
Received: from mail50.out.titan.email (mail50.out.titan.email [44.199.128.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BDF10A12
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.199.128.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718423057; cv=none; b=fsxhMRoWSoRUenk55PCKwgJ+VQDraSWLWQMPOO8iqBed+UuOaD8ZjmxL+uMWja18u/R3Eda3sDMGxtuQ4iqR7dltuGmvwRhiBS5D+m85ggS8SrdPLai+H252SX3+np0THB5HGxVnck7pbJstphMgDPX17dZjkCH0LIpsez23ITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718423057; c=relaxed/simple;
	bh=S8FUZUdhAx5LMwYv5mNXX8DV/odcUv3BeNHsi3wiUGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBKgqBz2dXZ/NHeCx0/XMyzCxbrMZNOVMs6V+2/P8MJ4lxxf4s1YY2vQ5CG1cmfYordbX6zBwp9wtzJ3eJLpUBE8cynWtrqmMsVED5EDeeC/Vjf+K5rmyu2iwIG8cWAqyWX/XcV7PLjfZqRgr6qo4msQdK5+6hPp12a8Kz0+lPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=VDFo1zls; arc=none smtp.client-ip=44.199.128.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Received: from smtp-out.flockmail.com (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 7F02FE001D;
	Sat, 15 Jun 2024 02:26:55 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=cID2U2F/6EVUfN51yZapFEvXhTZjJpNXhCSI7SM8ckU=;
	c=relaxed/relaxed; d=rcpassos.me;
	h=message-id:mime-version:to:cc:subject:date:from:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
	q=dns/txt; s=titan1; t=1718418415; v=1;
	b=VDFo1zls5idAVJRqcFib1eJaZbshd/N/UZGTEm1u+qquX/5SZ4EygN6AlbhOcpGI9agsCwU0
	OjKviaAqlQDFppZuUe4g3zClqm2ZZvRNwZSAqeC75sodR1Vb2Zf87PZTA9Pbc1F2CV4XJIzaN7r
	5rU9//GUJfcBYveS4IcRuRDo=
Received: from darkforce.pihole.rcpassos.me (unknown [104.28.243.51])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 10FD2E0081;
	Sat, 15 Jun 2024 02:26:52 +0000 (UTC)
Feedback-ID: :rafael@rcpassos.me:rcpassos.me:flockmailId
From: Rafael Passos <rafael@rcpassos.me>
To: andrii@kernel.org,
	ast@kernel.org,
	bjorn@kernel.org,
	bp@alien8.de,
	daniel@iogearbox.net,
	davem@davemloft.net,
	dsahern@kernel.org,
	mingo@redhat.com,
	puranjay@kernel.org,
	tglx@linutronix.de,
	will@kernel.org,
	xi.wang@gmail.com
Cc: Rafael Passos <rafael@rcpassos.me>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next V2 0/3] Fix compiler warnings, looking for suggestions
Date: Fri, 14 Jun 2024 23:24:07 -0300
Message-ID: <20240615022641.210320-1-rafael@rcpassos.me>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1718418415396134700.31293.6704488075129239866@prod-use1-smtp-out1004.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=T9KKTeKQ c=1 sm=1 tr=0 ts=666cfbef
	a=rO3HKV82O4ipXYUjDYeURw==:117 a=rO3HKV82O4ipXYUjDYeURw==:17
	a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10 a=o35cwU6MAAAA:8
	a=NEAV23lmAAAA:8 a=qM_3Ay_fVMTqAEfSYAwA:9 a=-FEs8UIgK8oA:10
	a=---8k2CCGq07aBBJLGWX:22 a=DpOgBPUa0pETyyFpiVXn:22
X-Virus-Scanned: ClamAV using ClamSMTP

Hi,
This patchset has a few fixes to compiler warnings.
I am studying the BPF subsystem and wish to bring more tangible contributions.
I would appreciate receiving suggestions on things to investigate.
I also documented a bit in my blog. I could help with docs here, too.
https://rcpassos.me/post/linux-ebpf-understanding-kernel-level-mechanics
Thanks!

Changelog V1 -> V2:
- rebased all commits to updated for-next base
- removes new cases of the extra parameter for bpf_jit_binary_pack_finalize
- built and tested for ARM64
- sent the series for the test workflow:
  https://github.com/kernel-patches/bpf/pull/7198


Rafael Passos (3):
  bpf: remove unused parameter in bpf_jit_binary_pack_finalize
  bpf: remove unused parameter in __bpf_free_used_btfs
  bpf: remove redeclaration of new_n in bpf_verifier_vlog

 arch/arm64/net/bpf_jit_comp.c   | 3 +--
 arch/powerpc/net/bpf_jit_comp.c | 4 ++--
 arch/riscv/net/bpf_jit_core.c   | 5 ++---
 arch/x86/net/bpf_jit_comp.c     | 4 ++--
 include/linux/bpf.h             | 3 +--
 include/linux/filter.h          | 3 +--
 kernel/bpf/core.c               | 8 +++-----
 kernel/bpf/log.c                | 2 +-
 kernel/bpf/verifier.c           | 3 +--
 9 files changed, 14 insertions(+), 21 deletions(-)

-- 
2.45.2


