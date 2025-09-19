Return-Path: <bpf+bounces-68904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F01CB87D3E
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 05:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9101CC040E
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 03:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7762264D5;
	Fri, 19 Sep 2025 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YU0Wq6FX"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A516DEB1
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 03:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758253721; cv=none; b=mQC6pkh2SyXVAyDWUXZ8i8HEMT7wxc9sHNROKl3RdTOQV7W95ODiAMguev6QzdKHIT1I4hTeFa69b4bnVUxqjV7EAnVjH/tk366KdXoaT6vHkE9zltfqMRvqCKLD4l/fYAyih4f3gEspt4LnS9IDYCzestiH0Ws/w4M4G09Gfrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758253721; c=relaxed/simple;
	bh=c1TKba1vvn2H3b40oqPAj/0PJ8nIcIAxRBiwdNbvGeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UxgQjEZ4gl1naAjgj5IC1Xq44OaLZFgfpttZ0cEjpJP/M1UdEPQ1TYEH4yNLpeSRbxgoniKa9zFU03kyuYJyXlxuEktUVItoMfSmm5M8jncEMcwDDSutO+HdXdXelaQP1NxH9mBjznw26byWuM4qiy4F86AOrex1YwiId9Wgr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YU0Wq6FX; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758253717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GZkxiC1oU8jlftWTj5wHZtzSllvcNZu+cfil17d3+Gk=;
	b=YU0Wq6FXgmVkp3X2oQ1N/Q9ricu6RgHcycdVvEbOMnNwUg9tcJqnxVCeeB6/5U3CcS5lXs
	yHxmbwtEVP/Vewch9wGZVdCQE3jNO4gt6ABWuL+JANnFHqpBaJY1IWqoXt/+n04KjcGKE0
	PvvcMqPpsa02RaptjvclDpsOrYBxBTc=
From: Tao Chen <chen.dylane@linux.dev>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	chen.dylane@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 1/2] bpftool: Add HELP_SPEC_OPTIONS in token.c
Date: Fri, 19 Sep 2025 11:48:15 +0800
Message-ID: <20250919034816.1287280-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

$ ./bpftool token help

Usage: bpftool token { show | list }
       bpftool token help
       OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} }

Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")

Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/bpf/bpftool/token.c | 1 +
 1 file changed, 1 insertion(+)

Change list:
 v1 -> v2:
  - strdup(mntent->mnt_opts) once per cmd/map/prog and
    remove another strdrup/free in print_items_per_line
    in patch2.(Alexei)
  v1: https://lore.kernel.org/bpf/20250916054111.1151487-1-chen.dylane@linux.dev
 v2 -> v3:
  - Replace PRINT_DELEGATE_OPT* macros with functions.(Quentin)
  v2: https://lore.kernel.org/bpf/20250917034732.1185429-2-chen.dylane@linux.dev
 v3 -> v4:
  - move the declaration of variable "i" to the top of
    the function.(Quentin)
  - move the declaration of "opts" and "value" inside of
    the for loop.(Quentin)
  v3: https://lore.kernel.org/bpf/20250918120908.1255263-1-chen.dylane@linux.dev

diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
index 6312e662a12..82b829e44c8 100644
--- a/tools/bpf/bpftool/token.c
+++ b/tools/bpf/bpftool/token.c
@@ -206,6 +206,7 @@ static int do_help(int argc, char **argv)
 	fprintf(stderr,
 		"Usage: %1$s %2$s { show | list }\n"
 		"       %1$s %2$s help\n"
+		"       " HELP_SPEC_OPTIONS " }\n"
 		"\n"
 		"",
 		bin_name, argv[-2]);
-- 
2.48.1


