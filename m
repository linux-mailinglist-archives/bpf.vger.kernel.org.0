Return-Path: <bpf+bounces-54013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8683AA6070F
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 02:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D688F3B3395
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 01:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17371096F;
	Fri, 14 Mar 2025 01:31:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4E2E336C
	for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741915882; cv=none; b=EskNEyh7MlwNQOasP25jWW3CqhIOCwpHJ8sCXM5x+buRF+HiOyalpWrUPdQGMMaW3Aw2VyCMDAp73HgjAviFYRDk4Cywyof+hNKBEx5/02sFyoyulVNPv44xiqeo2j7bP76b4TXdBvLOQSlQrb4PdEN5SII6M2zaBeKAnUYkGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741915882; c=relaxed/simple;
	bh=1bbpBCM8izED4ho1GRqfmW+se0PWB24MxbQ99B+S7vA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eByT5B7hGMbffEJrKtNN5oY+uMJRRgjySB3cfzzDUKEAJate4269N2syzFzabqamLcfvGlYntLcf+GjmJkmMKTlUkqUQqLzoUfyAEnAoK7w/Gs71PKbqQ+EROOrMZSp56nOChBOairjIUc2gjirzqGUMcab6AvXlpQj/y45gHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZDRf65t94z1d037;
	Fri, 14 Mar 2025 09:31:10 +0800 (CST)
Received: from kwepemh200013.china.huawei.com (unknown [7.202.181.122])
	by mail.maildlp.com (Postfix) with ESMTPS id 61647140414;
	Fri, 14 Mar 2025 09:31:17 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.175.36) by
 kwepemh200013.china.huawei.com (7.202.181.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 09:31:16 +0800
From: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH -next] lockdep: Fix upper limit for LOCKDEP_BITS configs
Date: Fri, 14 Mar 2025 01:18:43 +0000
Message-ID: <20250314011843.163100-1-zhangxiaomeng13@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh200013.china.huawei.com (7.202.181.122)

The upper limit that was initially setup for LOCKDEP_BITS configs
is too high (24 bit shift), which causes the kernel image size to exceed
KERNEL_IMAGE_SIZE (1024MB) limit. When LOCKDEP_BITS is set to 24,
the kernel image size grows to 1562.19MB.

Adjust LOCKDEP_BITS to 22, which results in a kernel image size of
888.19MB, keeping it under the KERNEL_IMAGE_SIZE limit while still
maintaining adequate debug information capacity.

This change prevents the linker error:
  ld: kernel image bigger than KERNEL_IMAGE_SIZE

Fixes: e638072e6172 ("lockdep: Fix upper limit for LOCKDEP_*_BITS configs")
Signed-off-by: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 35796c290ca3..6faba965a349 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1504,7 +1504,7 @@ config LOCKDEP_SMALL
 config LOCKDEP_BITS
 	int "Size for MAX_LOCKDEP_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 24
+	range 10 22
 	default 15
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
-- 
2.34.1


