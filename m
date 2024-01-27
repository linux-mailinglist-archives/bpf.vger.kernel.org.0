Return-Path: <bpf+bounces-20474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9393783ED6A
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 14:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BAF282601
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CCF25765;
	Sat, 27 Jan 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enKQqQey"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DF25615;
	Sat, 27 Jan 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706363267; cv=none; b=pl+C9a8XfIJXfzx3VhcOJ6k/mem9jb6JVDG5ZxzxE08l1XElxfiAFzCV87J1hdqje5RKQptIw3fPHD6LN37ZHuN7sdfz06t2CAnVOYE0p2ypsYIbOEcRzYwYXvSgpWbGT/T4cAM56Z0M3w+GqsqnIOl2Or0Dj+pq4RcFGVEjZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706363267; c=relaxed/simple;
	bh=aRVHGBE+E6YdaQtcIX4FAyk7BsARAU5+7Mp+IKkOdkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBywnDiALXl7EwOCpI2MeWpiQmleBpv72Ux2vzps6bgR/EIk5gjjCFwBcY7awSNjJ3Z8JOdsHWXz179FVileNYBpzF24Eh+KgCOlCVU8o1EhIxbhJ5dtzBkDeVXcSVovqgaihl0rO56/Xg8dDUUzu9mYAaxwn+vD5jJNIC1PtBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enKQqQey; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706363265; x=1737899265;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aRVHGBE+E6YdaQtcIX4FAyk7BsARAU5+7Mp+IKkOdkY=;
  b=enKQqQeys8X4sbDyC5kjWlpT2YT6Es9hxHESuxjOl8ShGegezQNYMdE7
   3Uq7MXkHHlczHmUZO+01M6tzAH8aBp7kgDIh5MvZ5JL4Y4J2YJz2PvmXA
   VtRUCZnBeJARxa5B/4zOVLT2BqEMCT9NKNByDK6WTaaUpCqEbi4E2jJjt
   Y+rw3izC/T28pvUaR3kEH8a4DY69FZBfx+KeWI/Cgl6Msmj0dX84BV3Zo
   XHjAtSz3qul7k5XLtU/7YmHQjCTvMaoMHKHz0lemYdW7rB2H9ez9qvgdl
   aGGRadS9g8nhUaXdIQIkic+DyuV3t6ux/KOCznirrdUb+VHuKd6MQ4JrA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="401543230"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="401543230"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 05:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="910611848"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="910611848"
Received: from dcai-bmc-sherry-1.sh.intel.com ([10.239.138.57])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2024 05:47:38 -0800
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
Subject: [PATCH bpf-next v1] bpf,token: use BIT_ULL() to convert the bit mask
Date: Sat, 27 Jan 2024 21:48:56 +0800
Message-ID: <20240127134901.3698613-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the '(1ULL << *)' with the macro BIT_ULL(nr).

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 kernel/bpf/token.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 0bca93b60c43..d6ccf8d00eab 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -72,28 +72,28 @@ static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
 	u64 mask;
 
 	BUILD_BUG_ON(__MAX_BPF_CMD >= 64);
-	mask = (1ULL << __MAX_BPF_CMD) - 1;
+	mask = BIT_ULL(__MAX_BPF_CMD) - 1;
 	if ((token->allowed_cmds & mask) == mask)
 		seq_printf(m, "allowed_cmds:\tany\n");
 	else
 		seq_printf(m, "allowed_cmds:\t0x%llx\n", token->allowed_cmds);
 
 	BUILD_BUG_ON(__MAX_BPF_MAP_TYPE >= 64);
-	mask = (1ULL << __MAX_BPF_MAP_TYPE) - 1;
+	mask = BIT_ULL(__MAX_BPF_MAP_TYPE) - 1;
 	if ((token->allowed_maps & mask) == mask)
 		seq_printf(m, "allowed_maps:\tany\n");
 	else
 		seq_printf(m, "allowed_maps:\t0x%llx\n", token->allowed_maps);
 
 	BUILD_BUG_ON(__MAX_BPF_PROG_TYPE >= 64);
-	mask = (1ULL << __MAX_BPF_PROG_TYPE) - 1;
+	mask = BIT_ULL(__MAX_BPF_PROG_TYPE) - 1;
 	if ((token->allowed_progs & mask) == mask)
 		seq_printf(m, "allowed_progs:\tany\n");
 	else
 		seq_printf(m, "allowed_progs:\t0x%llx\n", token->allowed_progs);
 
 	BUILD_BUG_ON(__MAX_BPF_ATTACH_TYPE >= 64);
-	mask = (1ULL << __MAX_BPF_ATTACH_TYPE) - 1;
+	mask = BIT_ULL(__MAX_BPF_ATTACH_TYPE) - 1;
 	if ((token->allowed_attachs & mask) == mask)
 		seq_printf(m, "allowed_attachs:\tany\n");
 	else
@@ -253,7 +253,7 @@ bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
 {
 	if (!token)
 		return false;
-	if (!(token->allowed_cmds & (1ULL << cmd)))
+	if (!(token->allowed_cmds & BIT_ULL(cmd)))
 		return false;
 	return security_bpf_token_cmd(token, cmd) == 0;
 }
@@ -263,7 +263,7 @@ bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type t
 	if (!token || type >= __MAX_BPF_MAP_TYPE)
 		return false;
 
-	return token->allowed_maps & (1ULL << type);
+	return token->allowed_maps & BIT_ULL(type);
 }
 
 bool bpf_token_allow_prog_type(const struct bpf_token *token,
@@ -273,6 +273,6 @@ bool bpf_token_allow_prog_type(const struct bpf_token *token,
 	if (!token || prog_type >= __MAX_BPF_PROG_TYPE || attach_type >= __MAX_BPF_ATTACH_TYPE)
 		return false;
 
-	return (token->allowed_progs & (1ULL << prog_type)) &&
-	       (token->allowed_attachs & (1ULL << attach_type));
+	return (token->allowed_progs & BIT_ULL(prog_type)) &&
+	       (token->allowed_attachs & BIT_ULL(attach_type));
 }
-- 
2.43.0


