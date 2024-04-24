Return-Path: <bpf+bounces-27646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF9C8B0130
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 07:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC2DB22964
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 05:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6543D15686E;
	Wed, 24 Apr 2024 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eh/bXQnA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1459A13CFAD;
	Wed, 24 Apr 2024 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937318; cv=none; b=JX6hrY6crUsZ0H++zaUV8eckb/9o+LcIJ00y6BxrI4d/IxXYTfghr8Of5cCBKCmfs+taGtR0RAUz/JR9G6zTRHrW65rVcxk0gibWEP5FrVMgsbottt5qateeAqvshcpJWHchY/glv7c1mujXIR/66VcjB9jlEvhcqbfJuVe6pdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937318; c=relaxed/simple;
	bh=xLugYiX9yb2t7DvTMC5IfpmLBUzF0Er2szAnJmqXgm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxbQKwa7Pk5b9mJ9kFQ9vbYW3NC+YtaV6+b8CTHgTkFnEZqNeCvTaMhS3t/7tpFHB/tTnV+Z/w7gwvzU7ePkomEVpfj5mby3PwS7FXlukO44UAzRTwsysBU+v/NhVfzQ1MVsmvHy+37uNlgCTGQiq04YQX1bfLl/BQwc9MHA6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eh/bXQnA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713937317; x=1745473317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xLugYiX9yb2t7DvTMC5IfpmLBUzF0Er2szAnJmqXgm0=;
  b=Eh/bXQnAw1okdBE5CrKYUuQzzGvDYzVGlLeDq4K+W8BEtD99ALqatsZy
   bLCrprMRGQWNScJ/+vibSX3WNN2lCNbqy48YQyZlCRRPFZqTeMRGqK3mA
   wPph2/DM1LzlDgTcbAbF0GPcdnR5eX6RTPZXi3gOlrV6RW/q506LmX4sq
   8it+raUdnpoqiX98nBbqizqWeTSgrMlje8mhZjSiUpLdJ0nHS2Vo+dApq
   ON77xpcWaRyi3SJG47jZiSPQ0GdbjHvlK9Fwyez8h5Ef5x9tLjNKysbV9
   TFXSM3+Cg4mgD8vb3kdU9OE/aYVxHP0Zw+jmCQGfvRPCrVNSgzrekRBUc
   w==;
X-CSE-ConnectionGUID: vQupXMaNSryt2oSB2jfbVg==
X-CSE-MsgGUID: 3elIl665S1SzP0PjTWCj0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9670128"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9670128"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 22:41:57 -0700
X-CSE-ConnectionGUID: Ieren6JkQg2WHb43rbnEgg==
X-CSE-MsgGUID: h6M/6lwcRWSSy57fmloxmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24662302"
Received: from unknown (HELO dcai-bmc-sherry-1.sh.intel.com) ([10.239.138.57])
  by fmviesa008.fm.intel.com with ESMTP; 23 Apr 2024 22:41:53 -0700
From: Haiyue Wang <haiyue.wang@intel.com>
To: bpf@vger.kernel.org
Cc: Haiyue Wang <haiyue.wang@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v1] bpf: update the comment for BTF_FIELDS_MAX
Date: Wed, 24 Apr 2024 13:45:07 +0800
Message-ID: <20240424054526.8031-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit d56b63cf0c0f ("bpf: add support for bpf_wq user type")
changes the fields support number to 11, just sync the comment.

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 include/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 64bf0cf3ee95..978200f6d925 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -184,7 +184,7 @@ struct bpf_map_ops {
 };
 
 enum {
-	/* Support at most 10 fields in a BTF type */
+	/* Support at most 11 fields in a BTF type */
 	BTF_FIELDS_MAX	   = 11,
 };
 
-- 
2.43.2


