Return-Path: <bpf+bounces-56110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A67A91629
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 10:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A5B5A3D0D
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C84122DFA4;
	Thu, 17 Apr 2025 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OB3/zi4b"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C722DFB0;
	Thu, 17 Apr 2025 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877312; cv=none; b=dC+V74L9GzqaLzdKgp1n/SaGHAEaf6qR0t3Y43/HjuZ/j5u8oRJsAZY4yFVBXnl4RhpJyWbXg+wXfNkspmFZHRRhMG2tujUz/usgmcldyfX7EIed1X2NF0d1NffwifZI1iYnQZ/EFwdEHbyBdWQD+n93jZTS6Vr19xq9Vmw7Y/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877312; c=relaxed/simple;
	bh=gVesOrvoau7AsyeGxarwTYoa1tVmy2GhuC6dycroowQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HORt8Pni+P4BVZa+DysuGZr7xfJ721zoTopd43MldCmUc+/jwJG5bExA9JuJ0p67jluxm1m4JwHcaHpWZNK2KBytDHy9oMHTj2fvEx3IXVYK35vOnSMIDwvYXxMnbx/8vdlstTirwGBFPBUyMUAooGXfzxQQAOZJYRLfEw5tgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OB3/zi4b; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uDfyS
	AK+gNNK6WaBDsaneipbk7k25PXVv3a0r1cjtDI=; b=OB3/zi4bbUJAM5uCwv9t7
	KJ7b6+YdWFWTdKpqSP78PeaPuLVCE6Z4cU48DuDvPwAV5qrIk3sniZzBrl6/33Ld
	Ghfb+d5Tv2p+YJzF1wlCBCXTL4UIDkyoxJjDACFdWdkC1WDMfoA3s5MP7ipwhnBd
	00n1ZiZ4Ig/y7O2czLg2as=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3BxOttgBoy+aUBA--.4732S2;
	Thu, 17 Apr 2025 16:07:10 +0800 (CST)
From: Honglei Wang <jameshongleiwang@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	joshdon@google.com,
	brho@google.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	jameshongleiwang@126.com
Subject: [PATCH 0/2] rename var for slice refill event and add helper
Date: Thu, 17 Apr 2025 16:07:06 +0800
Message-Id: <20250417080708.1333-1-jameshongleiwang@126.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3BxOttgBoy+aUBA--.4732S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUjEfOUUUUU
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiJBcyrWgArHbrrQAAsY

SCX_EV_ENQ_SLICE_DFL gives the impression that the event only occurs
when the tasks were enqueued, which seems not accurate. So rename the
variable to SCX_EV_REFILL_SLICE_DFL.

The slice refilling with default slice always come with event
statistics together, add a helper routine to make it cleaner.

Honglei Wang (2):
  sched_ext: change the variable name for slice refill event
  sched_ext: add helper for refill task with default slice

 kernel/sched/ext.c             | 36 +++++++++++++++++-----------------
 tools/sched_ext/scx_qmap.bpf.c |  4 ++--
 2 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.45.2


