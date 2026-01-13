Return-Path: <bpf+bounces-78699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1854AD18A58
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5E533032711
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB0738E5E9;
	Tue, 13 Jan 2026 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9M7UEEc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39CF38E127
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306376; cv=none; b=Rd9RtRtH3FaxJxyIiY6tl027M0u/229Q45t5ExwOiFiLziihFyM04p7FucjRlah0yxzARLv0lBCK5dlIrkedkh/45q5aR2SpEW3N28XVvB5m3vJP37SOIFhuu+7NjHn3GokqiGgY1H2KSn1luln8pQUsnr0tf+/MdBuyr3Yb4mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306376; c=relaxed/simple;
	bh=3Z1UgCzLihNFwTNnzn3CBpGZaDb0dtr41qS46b7uTeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljdYGvNK5FUCrAM2xjZmtnw+U363TBMbSzqp2davmykStUVQ1LIIIzvhYR3hHOV2lqkFb3/LRJW9/u9DuYOCuYKKtIRRom0SXErRQu8gTZ8chR6jYzE3vbijhCzSoIAnjXIn/BtwYUllxkH49aRdt8r30vwwpvspERyBKsTIhHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9M7UEEc; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f3c14027cso1498461b3a.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 04:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768306375; x=1768911175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QIjRrpTXF2MlYBwJ0ocSkqbjSwdZMAcaOgRZENhNgBc=;
        b=d9M7UEEc/8Pdbo4sduPp0y6VmQAzXWY13xplTnPkUo1SV24bGIayVQGnLDvfBX/owW
         9pK7vHZUPgVynqBzwP4XLd9lhmKmcP/2FklXO7Ty51gPsZ6n1FcRizZmeNOOCmwu4l15
         +EHhdAoAHO357Q6MmwXeyr3N3K7RYe0tyyGwm9p3l8SI7cqaKLGH4H+znJnRFv7V/9pD
         db+8LqcQbeAaiOesVLIKMFV7Z7E/5iPTylTmKPTYMSc8bsf8bkks/TmKq3d6Ys2EsMg/
         h1gzWQQjvExFeP/93AB9PEqFKICSrJ6bOrDd333NdiGmtHhESZEQ5BEZSCcq3Hr8fjHd
         PIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306375; x=1768911175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIjRrpTXF2MlYBwJ0ocSkqbjSwdZMAcaOgRZENhNgBc=;
        b=YwRhPvQlvLXsTj8Ds81vge3I4JhJYT4w6tPrl8A0NEyuWx6TdjVp5vtyOmy3yZysHH
         ahAwp007BPmLoePBTpxqwyPiUF8DtoPpN+hJpR1/Xv1/y2FmLdM2ReKvDhvOuvFzVNI8
         8ZGVAjlyUK9y0nYUOK9Iwz6HgpA3n1aTd3opfWPpOghXFQhwUJiGWbQOdWBKKDFSAqFr
         gilUocOanRcSErnKe8NNM+tAloHtI10QLehsy8IEggrCJAggdhcej9wHCbBUty8N6Vfx
         Fdsim7iwXI/oAX61uxeXbr1ZKhL82ERnlrElXdK+BNDOdx7Lg2x93dLzmbWFqW1fixuT
         9daw==
X-Gm-Message-State: AOJu0Yzpz7Wp3Lx0scltz3hfGLFzL21kbap2BhahY0I23hqKgWX4rKxV
	CerPrZDrEvpTpYwN3lCexZDQvZYoRh+azmFKS18BQWIwZiHdSvG2bFo/
X-Gm-Gg: AY/fxX7LaMn6Oa2zIWrVqK9iLqDYim8fLQAsX/LGVh9UwXLPYoSQBtgjqMOX0p06NYB
	agTO/C2G0R7b2ZQywmj6lfSA3/O1ZMaTlL06xyXvOGdSZ0MBmZd5i5DXmIg7g6MXE2gn8rdPW+p
	ip5jERfXThrH6bbLnKmlnpwI+VYpSYmZmFb43QhmPsruHBAi+g8Rs1TwZLqLf0FWRaN4OA6usea
	oivsmESZ6R7/Ow8BX570Hoi/fP0iwL3lZ0N7ktTpDnf3ZY6cZ052oXSwk0t6lK1a4AjPl6qYsxE
	7W6ZkM8/Z/EOp28EBEtEK5jFZEvM/4wI7/pzvydvZ4zcM3XVurSq9gnIuNUI0WdTWNLmst3a3h0
	Z8A8pIYj9YB4yBvtKXeptaJWAUCckfcMhXp4+Ik0VJ3ZbcI4B3B+U9VkME9mQWRqnkG8k+B2YPa
	VzZSbaaWy2JX2XAeuxBfKaQuw4dfCbMNBFbUP2LCIQyTRkzA4DazDBaVE=
X-Received: by 2002:aa7:88c6:0:b0:80f:4667:a94a with SMTP id d2e1a72fcca58-81f6f74ed6amr2174765b3a.10.1768306374861;
        Tue, 13 Jan 2026 04:12:54 -0800 (PST)
Received: from localhost.localdomain ([2409:891f:1d24:c3f5:8074:4004:163:94af])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81e7fd708fdsm11596703b3a.65.2026.01.13.04.12.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 04:12:54 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: roman.gushchin@linux.dev,
	inwardvessel@gmail.com,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mkoutny@suse.com,
	yu.c.chen@intel.com,
	zhao1.liu@intel.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 0/3] BPF-based NUMA balancing 
Date: Tue, 13 Jan 2026 20:12:35 +0800
Message-ID: <20260113121238.11300-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our large fleet of Kubernetes-managed servers, NUMA balancing has been
historically disabled globally on each server. With increasing deployment
of AMD EPYC servers in our fleet, cross-NUMA access has become a critical
performance issue, prompting us to consider enabling NUMA balancing to
address it.

However, enabling NUMA balancing globally is not acceptable as it would
increase overall system overhead and potentially introduce latency spikes
for latency-sensitive workloads. Instead, we aim to enable it selectively
for workloads that can genuinely benefit from it. Even for such workloads,
we require fine-grained per-workload tuning capabilities.

To maximize cross-NUMA page migration while minimizing overhead, we
propose tuning NUMA balancing per workload using BPF.

This patchset introduces a new BPF hook ->numab_hook() as a memory cgroup
based struct-ops. This enables NUMA balancing for specific workloads
while keeping global NUMA balancing disabled. It also allows tuning
NUMA balancing parameters per workload. Patch #3 demonstrates how to
adjust the hot threshold per workload using BPF.

Since bpf_struct_ops and cgroups integration [0] is still under
development by Roman, this patchset temporarily embeds the cgroup ID
into the struct-ops for review purposes. We can migrate to the new
approach once it's available.

This is still an RFC with limited testing. Any feedback is welcome.

[0]. https://lore.kernel.org/bpf/CAADnVQJGiH_yF=AoFSRy4zh20uneJgBfqGshubLM6aVq069Fhg@mail.gmail.com/

Yafang Shao (3):
  sched: add helpers for numa balancing
  mm: add support for bpf based numa balancing
  mm: set numa balancing hot threshold with bpf

 MAINTAINERS                          |   1 +
 include/linux/memcontrol.h           |   6 +
 include/linux/sched/numa_balancing.h |  44 +++++
 kernel/sched/fair.c                  |  17 +-
 kernel/sched/sched.h                 |   2 -
 mm/Makefile                          |   5 +
 mm/bpf_numa_balancing.c              | 252 +++++++++++++++++++++++++++
 mm/memory-tiers.c                    |   3 +-
 mm/mempolicy.c                       |   3 +-
 mm/migrate.c                         |   7 +-
 mm/vmscan.c                          |   7 +-
 11 files changed, 326 insertions(+), 21 deletions(-)
 create mode 100644 mm/bpf_numa_balancing.c

-- 
2.43.5


