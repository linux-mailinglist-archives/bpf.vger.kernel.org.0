Return-Path: <bpf+bounces-9982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22C179FEA8
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C481B20B73
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEF410A1B;
	Thu, 14 Sep 2023 08:43:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1B1CFBD
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 08:43:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD4E1FD9;
	Thu, 14 Sep 2023 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694681010; x=1726217010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iYC62UtRoejh4gTBR8ZARtuwUYWBWuvoadPJmKvqBHc=;
  b=PxogW5Hcv9SkjIlLqT2+a8iVdqLSOenOA8AiHhTbVSxdzsc4nNnCnkM1
   K3VFWCMxXkrn1JOYZDeWXkY3WajTwphvTAQ3p6qaRXgfbYR4Rl1w/ATvA
   2u+4Br/PcsJK7UTVMxiuGAi3oZOq7qXG5N066/ioYgYDjXWjDn9oTP/kW
   YHy1peoC5GhdiXQWnYC0bpC2yfcJAkfwiVyErkd1qHptE8F+g+uxZLoP8
   5wUiRGAEVMeI+isWkrJEcXIt4jf//ETsXZE8mOWQ+NV4OouslDGq0zK42
   0Rb/8iROurR5Y3Ew1oImn4n364LCCAVJ95IGkIdioZLk9x3mtuovNMDYR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378815020"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="378815020"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 01:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="991315995"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="991315995"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga006.fm.intel.com with ESMTP; 14 Sep 2023 01:43:25 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 83FA332CB0;
	Thu, 14 Sep 2023 09:43:24 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Allow to use kfunc XDP hints and frags together
Date: Thu, 14 Sep 2023 10:37:11 +0200
Message-ID: <20230914083716.57443-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX hints
cannot coexist in a single program.

Allow those features to be used together by modifying the flags conditions.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/bpf/CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com/
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 kernel/bpf/offload.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index ee35f33a96d1..43aded96c79b 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -232,7 +232,11 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
 	    attr->prog_type != BPF_PROG_TYPE_XDP)
 		return -EINVAL;
 
-	if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
+	if (attr->prog_flags & ~(BPF_F_XDP_DEV_BOUND_ONLY | BPF_F_XDP_HAS_FRAGS))
+		return -EINVAL;
+
+	if (attr->prog_flags & BPF_F_XDP_HAS_FRAGS &&
+	    !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY))
 		return -EINVAL;
 
 	if (attr->prog_type == BPF_PROG_TYPE_SCHED_CLS &&
-- 
2.41.0


