Return-Path: <bpf+bounces-70118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305D8BB1549
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 19:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8D51C73C4
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663772D29D1;
	Wed,  1 Oct 2025 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdHeKlLp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3010208961
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759338813; cv=none; b=r/C8zaOHq2Utf2pbrv6zf60TyNC60FwNZag6nOow9EzkCP11aCU/+75Eii6jAQ7GRLId7QTGzfiVjnw6MMH7QEepnDO46Ykqyfu/wIwxPj2OKGUvMd0j3j1argEFiah7Bqn8BjdV6xw3bRCUAp4Et/IdefoA5OBz3H22wCfEBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759338813; c=relaxed/simple;
	bh=EqCFC27PFbRE5F4ZtwcXXDecgBOs9lodTz7fmtynBRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGX4fVjRGp2t2YElq60i1SpsTMzgnL+ZKPQxi8Fj4alm8I5dxrIRVEXEZsYVezND8D0xKj7CP31TV2bOR7lXGPMati3mN6yiPZiJ3GXuxq4PAoMEjLTCNrYFEXXHILluD3jNdsojwqhp4upMT2MSc0oblrYe2xoluC47QPq/ZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdHeKlLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B85C4CEF1;
	Wed,  1 Oct 2025 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759338812;
	bh=EqCFC27PFbRE5F4ZtwcXXDecgBOs9lodTz7fmtynBRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdHeKlLpKGrzWokkcqoZ2fr4yZUH4aatTz44hehveib6LOAAsZ5QW4Nf+6z+cFcPH
	 dsUi1fVUs8euESUkg/mSOg6V9Idx/9rI/LpO2xhz8GnosW7atSQvZqfHilRycLala6
	 VFUwkfa0ZvUcveqYcrU61rV/bN5ItB+fwJPMi/wOBguGxMFSByjYJlftaV7MbzTb1n
	 RObAf9xxH9USMCxmRDsrsng+xPk6Wp1zLH+hBivWLvwJ9fsrelMX6ATu3iRzpfxGlk
	 YsbyxUTSk16JBNGKhzZz+HzKk4Pq3i1yOIr6sNOrSe3/Ebs+1EYC+zJ9tBs8U2JqU2
	 6fwE209RghB5w==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf 1/5] libbpf: make libbpf_errno.c into more generic libbpf_utils.c
Date: Wed,  1 Oct 2025 10:13:22 -0700
Message-ID: <20251001171326.3883055-2-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001171326.3883055-1-andrii@kernel.org>
References: <20251001171326.3883055-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Libbpf is missing one convenient place to put common "utils"-like code
that is generic and usable from multiple places. Use libbpf_errno.c as
the base for more generic libbpf_utils.c.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Build                              | 2 +-
 tools/lib/bpf/{libbpf_errno.c => libbpf_utils.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/lib/bpf/{libbpf_errno.c => libbpf_utils.c} (100%)

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index e2cd558ca0b4..c30927135fd6 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
-libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
+libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_utils.o str_error.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
 	    usdt.o zip.o elf.o features.o btf_iter.o btf_relocate.o
diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_utils.c
similarity index 100%
rename from tools/lib/bpf/libbpf_errno.c
rename to tools/lib/bpf/libbpf_utils.c
-- 
2.47.3


