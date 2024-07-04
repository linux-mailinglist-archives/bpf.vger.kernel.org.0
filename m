Return-Path: <bpf+bounces-33843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E1C926CAC
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 02:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3BEB2838D9
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0009D23BB;
	Thu,  4 Jul 2024 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz1onptx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E051632
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720052135; cv=none; b=NrfT8EKs9J5JfAbbC6TuVEWLyjlvxGE8PKSTFxHZU3resp7/8JSLvHePInoOy+4obPMzYyF/BjKIAB9XTQm7Oxf7GqqMiPvWPNjuQIrzG5Y1AVjgzdeBdKFE2iEt5c3LqwOGsbKnT/tUAbTcpRCwS3GNop35jqoRZ1bPgxP4vHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720052135; c=relaxed/simple;
	bh=aXSir87EfM8AN/ahmWX8k7/PTOepniot8w9AIW0ZBBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMP0XFQfa+k6ADvbU794USRVV47pLPDywcKHAb7t4/q7g2RPbpzJWvaFodHY0KthM3WKyI1zmiV2DApAMZfB2xn7OkeXJIUYB8rXHc4bsUtWET48tomK1YKD31aompc3lxvq8+l849sRKJ05gcnSmgXHMG5V05ribo/GSoiOg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gz1onptx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3064C2BD10;
	Thu,  4 Jul 2024 00:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720052135;
	bh=aXSir87EfM8AN/ahmWX8k7/PTOepniot8w9AIW0ZBBk=;
	h=From:To:Cc:Subject:Date:From;
	b=gz1onptxtegBlyiIgNe+6DUn6Mki71RXpyTJ3kb4JQ6tJpAMXk6aI9LFLdktA6p9Y
	 5mnpc6PyoMTtxcz+nu5gvnZITRBqSUn8HzIbg7Knykgkep42VanGiVOlZDBVkygMRU
	 TnhcnN43TwEyY2wDXknV7KQ2P3R1MbbmX4rvQnA7RjZ8c/s4sX8cZqhZjDEYYmKfgW
	 DOfY/p5dXxK7nkwPFuZ9fGK7qto3katKtHCgEFgOQxZcZxQ1Zsv41AR5XNO0w0Z4W7
	 f1amncQdY9rCr/yGawKHt7rjLos3O04Wj1tzFcWvKL69PGgVWnmDbmmyuINyoC1pju
	 bi3/5GkUy2YHQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/2] Fix libbpf BPF skeleton forward/backward compat
Date: Wed,  3 Jul 2024 17:15:25 -0700
Message-ID: <20240704001527.754710-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix recently identified (but long standing) bug with handling BPF skeleton
forward and backward compatibility. On libbpf side, even though BPF skeleton
was always designed to be forward and backwards compatible through recording
actual size of constrituents of BPF skeleton itself (map/prog/var skeleton
definitions), libbpf implementation did implicitly hard-code those sizes by
virtue of using a trivial array access syntax.

This issue will only affect libbpf used as a shared library. Statically
compiled libbpfs will always be in sync with BPF skeleton, bypassing this
problem altogether.

This patch set fixes libbpf, but also mitigates the problem for old libbpf
versions by teaching bpftool to generate more conservative BPF skeleton,
if possible (i.e., if there are no struct_ops maps defined).

Andrii Nakryiko (2):
  bpftool: improve skeleton backwards compat with old buggy libbpfs
  libbpf: fix BPF skeleton forward/backward compat handling

 tools/bpf/bpftool/gen.c | 46 ++++++++++++++++++++++++++++------------
 tools/lib/bpf/libbpf.c  | 47 +++++++++++++++++++++++------------------
 2 files changed, 59 insertions(+), 34 deletions(-)

-- 
2.43.0


