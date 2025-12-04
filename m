Return-Path: <bpf+bounces-76040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDBFCA33BC
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 11:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D6930C7BC7
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 10:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2624333452;
	Thu,  4 Dec 2025 10:29:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A632FA3C;
	Thu,  4 Dec 2025 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764844174; cv=none; b=BgYNgtQfmNs4D2ksHhEoYOYKrLHTsIXy2mX5324/2uJMBDTvCFCVMiYHrzYKJrVAOG/eziZLwbeKk0nHFafGxdvWV43Jet492cGMlxoRe/sMiIGe5xbxeXJpdMFaVnXPtXa+p0SQfvW47RxcJA97rb/ZcrDJJIi7J7+Pdec+rKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764844174; c=relaxed/simple;
	bh=l2h8g4WGbCWh28gjOZs6mQzOxwYEBxj0oFGDolxTEPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaqCbLIZp1SeyzdBkpsRvvHCgXVHemIvnxDVc8tsoHpBWfJVq+lljyewYzUNGKIGZiCivKr7FiBbUAnZhxUfdn03Q8idxplsaVnz9/zJgADEUCJOGpLvpp5lKNjDpLya0+nVvoFTDU56bVX2XaHifI1ZUMfi/ZKjJMAFd+lDXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F7AC113D0;
	Thu,  4 Dec 2025 10:29:27 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kui-Feng Lee <thinker.li@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] bpf: Fix register_bpf_struct_ops() dummy
Date: Thu,  4 Dec 2025 11:29:15 +0100
Message-ID: <ead27aa92275c71c1fcd148f88ca6926a524f322.1764843951.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1764843951.git.geert@linux-m68k.org>
References: <cover.1764843951.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If CONFIG_BPF_SYSCALL=y, but CONFIG_BPF_JIT=n:

    net/smc/smc_hs_bpf.c: In function ‘bpf_smc_hs_ctrl_init’:
    include/linux/bpf.h:2068:50: error: statement with no effect [-Werror=unused-value]
     2068 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
	  |                                                  ^~~~~~~~~~~~~~~~
    net/smc/smc_hs_bpf.c:139:16: note: in expansion of macro ‘register_bpf_struct_ops’
      139 |         return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);
	  |                ^~~~~~~~~~~~~~~~~~~~~~~

As type is not a variable, but a variable type, this cannot be fixed by
just converting register_bpf_struct_ops() into a static inline function.
Hence fix this by introducing a static inline intermediate dummy.

Fixes: f6be98d19985411c ("bpf, net: switch to dynamic registration")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/bpf.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6498be4c44f8c275..bb69905c28a761e7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2065,7 +2065,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
 void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc);
 #else
-#define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
+static inline int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
+{
+	return 0;
+}
+#define register_bpf_struct_ops(st_ops, type) __register_bpf_struct_ops(st_ops)
 static inline bool bpf_try_module_get(const void *data, struct module *owner)
 {
 	return try_module_get(owner);
-- 
2.43.0


