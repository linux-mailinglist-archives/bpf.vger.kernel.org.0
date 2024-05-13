Return-Path: <bpf+bounces-29622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3438C3ABE
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 06:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED76F1C20E44
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 04:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D797145B37;
	Mon, 13 May 2024 04:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UV/hin/B"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68A3214;
	Mon, 13 May 2024 04:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715574945; cv=none; b=Ye6AkHyBKO/et7vRBXtk0WhQK57jR7i9xpV+2y5g3+EsrhlQj7KapOw2hAQNAK1wb6jb72RNBGQKFUxnzWTJJHFyvQjltfCpjC1IuUeLcd0KmHbDomx3vK6sWOQBZRdC70C/p+gL2Rqe8Ilx3qQfmKFmWLxYP6TTdD573dMBgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715574945; c=relaxed/simple;
	bh=Z0dpvmrI28eS45WbkEYgkTyMwjgnIk1pOV23QNe9tlY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mEpydEH/ElGBKBsjtyDmNUqKzhZWBf5Mvoph5gh3NzPAEQ4gPkBSisZTOIS5KUymi5Y+KjUHd6mteXqk/cSsqDxvLfDf76VJyeAws/Ek4w2UQKMCgeAy80yKDT0vyfbvbZpivzDUp94/bdykdjFrlChy5qCZq3c/ofLpbYPHI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=UV/hin/B; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=+sDYxjeeVc0BhplR7Zet4dAgkgFt/tCSA/bSQmrCSdw=; b=UV/hin/BgQMGOaPvHyPvH6z8Bq
	V16plrNrV3oeoHrlOUQgL6qKKLMdLfcssW2hLVICN68tqBQCWCqAvtCMmr96VLMfecdqG9c2WbZep
	dnJMMUU10xH9jBRcGAMLXOkhwBvFJQzc41pov/eNGA+dXab/CwGyYz4EOBHr7w38CS4nNFU8B2JIs
	EZgNhJ6DX1FPiq+6X29/Y+Qum3Viws5m1ZEpu5HpN58PDv7cGs8yh8f7t3vER22qzYtG8xvDMmPhx
	0pcxsO7GldBy+GMy0FgX+xQWLg6tc65qOE/nFY+7qaeszjdkQkcorqcXm8EymPxlhWaYOm40MKwHY
	YDmhRuaw==;
Received: from mob-194-230-158-151.cgn.sunrise.net ([194.230.158.151] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s6N9E-0005yl-Rg; Mon, 13 May 2024 06:18:49 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf 2024-05-13
Date: Mon, 13 May 2024 06:18:45 +0200
Message-Id: <20240513041845.31040-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27273/Sun May 12 10:22:49 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 3 non-merge commits during the last 2 day(s) which contain
a total of 2 files changed, 62 insertions(+), 8 deletions(-).

The main changes are:

1) Fix a case where syzkaller found that it's unexpectedly possible to attach a
   cgroup_skb program to the sockopt hooks. The fix adds missing attach_type
   enforcement for the link_create case along with selftests, from Stanislav Fomichev.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Eduard Zingerman

----------------------------------------------------------------

The following changes since commit b867247555c4181bf84eb10b72b176862c29112d:

  Merge branch 'qed-error-codes' (2024-04-29 10:02:43 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 3e9bc0472b910d4115e16e9c2d684c7757cb6c60:

  Merge branch 'bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE' (2024-04-30 10:45:44 -0700)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Martin KaFai Lau (1):
      Merge branch 'bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE'

Stanislav Fomichev (3):
      bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE
      selftests/bpf: Extend sockopt tests to use BPF_LINK_CREATE
      selftests/bpf: Add sockopt case to verify prog_type

 kernel/bpf/syscall.c                             |  5 ++
 tools/testing/selftests/bpf/prog_tests/sockopt.c | 65 +++++++++++++++++++++---
 2 files changed, 62 insertions(+), 8 deletions(-)

