Return-Path: <bpf+bounces-20275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D7C83B299
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA9C1F2594B
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E75C133411;
	Wed, 24 Jan 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nqt3/mL+"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D07133409
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126151; cv=none; b=S/JLQa8LNiZCjq3ggMhCXX7AuEtif/bd9IlGwE8vaXedrvwUOdCYWDHBwyF9c+MLsQZACnSOSS3HkL/kPRBNlHksF8IJwN7TRrI6fRQ9qkjZpYA2YDxvPi2dMKtSZ5r5gw1ypJ6MexO4PJMx3ohDNBjj1mvm2H6RZmhAR68L5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126151; c=relaxed/simple;
	bh=WVVyJI13Shfo/IZt29wogaveEudc8xdywF1s/vdWIs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gtZW3u5kcZ2wXqxosoGMQ5w3WhxpastcQ3l3O0Bpi+wkKJffLVaBpjsQZvoOXmaNGWE/gfrCUcv4ugvfHUo9HUbsvhx2NH8GQ/KmNGKMB+dTbJP/6IflVU3eGnd5eh//sGj/mopUiMLJPKDGD/8tuJVkJnkDHJJNjdqREqXHVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nqt3/mL+; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706126147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SFlrxb82Xv2DmdaqtksaJbPBgkMBD/XHXiZ133Rc6u4=;
	b=nqt3/mL+ytoySafxL7vKkGPIh41QSeqVdf05e9aKOSGfmP2cdfPLqHBPGKfOdxFvYYPB1h
	81IpUIT3oy0OXBYRGlwWwhp95yl0Kik1HsihhbyPDojrg3l6HLniqxRWBm3LtC34Y1KIsO
	BE8cvY+KEgL1swYODlUa6WYSlw6PDa0=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next] libbpf: Stop setting -1 to value_type_btf_obj_fd which breaks backward compatibility
Date: Wed, 24 Jan 2024 11:55:19 -0800
Message-Id: <20240124195519.2136101-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

Passing -1 in value_type_btf_obj_fd to the kernel will break backward
compatibility. This patch fixes it by using 0 as the default.

Cc: Kui-Feng Lee <thinker.li@gmail.com>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Fixes: 9e926acda0c2 ("libbpf: Find correct module BTFs for struct_ops maps and progs.")
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/lib/bpf/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 3a35472a17c5..b133acfe08fb 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -192,7 +192,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.btf_key_type_id = OPTS_GET(opts, btf_key_type_id, 0);
 	attr.btf_value_type_id = OPTS_GET(opts, btf_value_type_id, 0);
 	attr.btf_vmlinux_value_type_id = OPTS_GET(opts, btf_vmlinux_value_type_id, 0);
-	attr.value_type_btf_obj_fd = OPTS_GET(opts, value_type_btf_obj_fd, -1);
+	attr.value_type_btf_obj_fd = OPTS_GET(opts, value_type_btf_obj_fd, 0);
 
 	attr.inner_map_fd = OPTS_GET(opts, inner_map_fd, 0);
 	attr.map_flags = OPTS_GET(opts, map_flags, 0);
-- 
2.34.1


