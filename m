Return-Path: <bpf+bounces-10141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 916B97A191C
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 10:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BACB282837
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 08:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED52D523;
	Fri, 15 Sep 2023 08:45:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8C2F38
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 08:45:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC132710;
	Fri, 15 Sep 2023 01:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694767545; x=1726303545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qjyaj6/vHYjlTgH8HsMMy0BE05DoiU6MR8cgOG0PfUI=;
  b=dgfcs0BJrGpl1Jz5lBgaP7jz1ysMyaPP7FJnEp0Uc4/V+RW3cYpTudyl
   ld59ajUuWRm6VIG9WaPMTJjHPW6s56ZejnSvJ44AiXrhDhmTS9rEHtCwU
   7O/B+4WXjFqvH6UW6iwbQHp8wyBtUaDI99APXaVQBl1zOjLOs57ZCa/Hq
   8MH5FjqSm0kcJ3Vc1jGNAlrtYRQ9IwA5TQuMqOxL8J8OCjLSmO30SnFm6
   m50A5b8DJoOHZmfy+dt9SzXbClvMusNalGiYIXo4MdjaBzd7O6V5HM1Xe
   XtRm9yi3q60WY8wJ+q8raZl6XcCh9q3GVYCzkd+0EgvbGOjibo3NhZTpp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="445657287"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="445657287"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 01:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="748122728"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="748122728"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2023 01:45:40 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 21E7F33E80;
	Fri, 15 Sep 2023 09:45:39 +0100 (IST)
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
	linux-kernel@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next v2] bpf: Allow to use kfunc XDP hints and frags together
Date: Fri, 15 Sep 2023 10:39:10 +0200
Message-ID: <20230915083914.65538-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX hints
cannot coexist in a single program.

Allow those features to be used together by modifying the flags condition
for dev-bound-only programs, segments are still prohibited for fully
offloaded programs, hence additional check.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/bpf/CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com/
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 kernel/bpf/offload.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index ee35f33a96d1..9d8e508c9b86 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -232,7 +232,14 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
 	    attr->prog_type != BPF_PROG_TYPE_XDP)
 		return -EINVAL;
 
-	if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
+	if (attr->prog_flags & ~(BPF_F_XDP_DEV_BOUND_ONLY | BPF_F_XDP_HAS_FRAGS))
+		return -EINVAL;
+
+	/* Frags are allowed only if program is dev-bound-only, but not
+	 * if it is requesting bpf offload.
+	 */
+	if (attr->prog_flags & BPF_F_XDP_HAS_FRAGS &&
+	    !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY))
 		return -EINVAL;
 
 	if (attr->prog_type == BPF_PROG_TYPE_SCHED_CLS &&
-- 
2.41.0


