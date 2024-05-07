Return-Path: <bpf+bounces-28752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB78BD97F
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 04:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883811C20E96
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B172E40D;
	Tue,  7 May 2024 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pr5ywb6V"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AD615C9;
	Tue,  7 May 2024 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715049959; cv=none; b=o9BtP0ZCEDFz+Kh1fHsdFFjm7MlcmIs6fr53mXgZ+5SGDmOmfOAJRjcPBO+tptpTUhs4Y/rF5Iqmd+rwGcQpOHzSeO2gugr58vj1UVi+SgkBLK2/ev0p0JuxE1DPIVeBHLETWH+H5rWiAjkONa7Bov10umaQWzUpEwbgxzQWrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715049959; c=relaxed/simple;
	bh=4G4o0Jo/rKX6UsEbQz7dosJdScsz2KSFW0v5nc8PWqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8RqalhO8oZPw1r8sBkk2lUtzKcilPMwFAZ4KTJ0JMp+NX1h9i9rZ+xX3/wIOzJC8LlD+Cf/8GV6zWxAbLoO3LORyyP/cnN180yI9z7GN1mEQKlTlcJd9UAqSqKbOxSkosTjra7NCY+kN+3BI5r3VDTzCTodbHM3Jb2rl1nU1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pr5ywb6V; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715049958; x=1746585958;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4G4o0Jo/rKX6UsEbQz7dosJdScsz2KSFW0v5nc8PWqg=;
  b=Pr5ywb6VEfrc7Zeja5XXGxL+XcfzHQ1RmXZUaHedLEuD6sPDtxpJyFpG
   gHDcxK40gAuV3izHcxZZi2Wnzg1ab4ebJMptbXY0OLJYuBQOdmW53oBDQ
   hRygk+GQVdfsg6bCaZ5Tc4PgvLb1YE9LB/GgdiYUDKJ2gHqhTJDwY+N/7
   8BF45JEN11lGfd14kdT2YvuLjoDhEmNcIO7ngtOvzpENAr1NLbd7V5lkA
   jXmT/AE1GlTbEvG1oFFhwdc5hpFMyl0aeSGBmtM0eoEshUuZ2080ZOFrJ
   e42PaKCKQ7HgtUPdpg43TGjviRVVUuseIKcq7EiTn8t0J7SCAhU3Sa4tO
   w==;
X-CSE-ConnectionGUID: FB/7CP4HRHOFWYdr0BokRA==
X-CSE-MsgGUID: F7fIWhnvRa6vD4DGvjbviA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="11361892"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="11361892"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 19:45:57 -0700
X-CSE-ConnectionGUID: NRqpgIBnQvOc3cwys/A6cA==
X-CSE-MsgGUID: gqaHCpsDRqyB8yQbhPi6+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="32872793"
Received: from unknown (HELO dcai-bmc-sherry-1.sh.intel.com) ([10.239.138.57])
  by fmviesa003.fm.intel.com with ESMTP; 06 May 2024 19:45:52 -0700
From: Haiyue Wang <haiyue.wang@intel.com>
To: bpf@vger.kernel.org
Cc: Haiyue Wang <haiyue.wang@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v1] bpf,arena: Rename the kfunc set variable
Date: Tue,  7 May 2024 10:49:15 +0800
Message-ID: <20240507024952.1590681-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the kfunc set variable to specify the 'arena' function scope,
although the 'UNSPEC' type BPF program is mapped to 'COMMON' hook.

And there is 'common_kfunc_set' defined for real 'common' function in
file 'kernel/bpf/helpers.c'.

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 kernel/bpf/arena.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 6c81630c5293..ef2177c0465f 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -557,13 +557,13 @@ BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_KFUNCS_END(arena_kfuncs)
 
-static const struct btf_kfunc_id_set common_kfunc_set = {
+static const struct btf_kfunc_id_set arena_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set   = &arena_kfuncs,
 };
 
 static int __init kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set);
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &arena_kfunc_set);
 }
 late_initcall(kfunc_init);
-- 
2.43.2


