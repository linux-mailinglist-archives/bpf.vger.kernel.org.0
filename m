Return-Path: <bpf+bounces-39198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 605F797060A
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 11:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28F21F21611
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3B51386DF;
	Sun,  8 Sep 2024 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V5UUinUW"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3821B85DC
	for <bpf@vger.kernel.org>; Sun,  8 Sep 2024 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725787464; cv=none; b=QUYnJsOeidpuI4hwP2Jv2Rs80a9mHULDu5bEXvPMHJe4Zau/iuNILUXHWi4iekkafjZSk3X+xCTP7idsSBoX0UCtBYkTHHS4pgTfGOiAyPxgz83YYKxcKN1WJezzQN6iz7amyrMI/rvUIuJhqR9FwoWOmlXNooteCsQiJSkjoO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725787464; c=relaxed/simple;
	bh=vnNAMmCd/hXHlE4dmWxI8Bo5xTGZoiPojWh2hGLL/Wc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NyomcA/qNDFSOzIa7CXzaUWSYweQE0jSgMsNb5TeHEUWOyS0+3Ims9cGfBkGJLuGvw/NaOt9UJ757wCZuLGJ9TjiT6OTV8OYbeZCSXA3VHIx61EE4aKqR8fJQSNVvBu9CESjepwDqZd75HoVVo8ecKsvfFIkQr1o1ExS3o8k3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V5UUinUW; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725787453; h=From:To:Subject:Date:Message-Id;
	bh=iUrOqa0/7kjvI9b7foLPxgiqXlIapLthAOsnrFce3C8=;
	b=V5UUinUW8OZ7YBgzyxSsLZYXQqjr8ZDMrKf2NM18946jWTYbQgM0K9evK3zKTLh0O97vX1biS8U2FXm6nnkcNdv+i5muNyd0h1RB4w9RAm6hcoaJL5UYi56bf57Q3+W0ztGFA8toYKT84eCOR+hdK6ZOE3pFOsgh8C+OUajOuh0=
Received: from VM20210331-6.tbsite.net(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0WEUNoVG_1725787441)
          by smtp.aliyun-inc.com;
          Sun, 08 Sep 2024 17:24:12 +0800
From: Shuyi Cheng <chengshuyi@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: chengshuyi@linux.alibaba.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	song@kernel.org
Subject: [PATCH bpf-next] libbpf: Fixed getting wrong return address on arm64 architecture
Date: Sun,  8 Sep 2024 17:23:53 +0800
Message-Id: <1725787433-77262-1-git-send-email-chengshuyi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

ARM64 has a separate lr register to store the return address, so here
you only need to read the lr register to get the return address, no need
to dereference it again.

Signed-off-by: Shuyi Cheng <chengshuyi@linux.alibaba.com>
---
 tools/lib/bpf/bpf_tracing.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 4eab132a963e..aa3b04f5542a 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -522,7 +522,7 @@ struct pt_regs;
 #define BPF_KPROBE_READ_RET_IP(ip, ctx)		({ (ip) = (ctx)->link; })
 #define BPF_KRETPROBE_READ_RET_IP		BPF_KPROBE_READ_RET_IP
 
-#elif defined(bpf_target_sparc)
+#elif defined(bpf_target_sparc) || defined(bpf_target_arm64)
 
 #define BPF_KPROBE_READ_RET_IP(ip, ctx)		({ (ip) = PT_REGS_RET(ctx); })
 #define BPF_KRETPROBE_READ_RET_IP		BPF_KPROBE_READ_RET_IP
-- 
2.32.0.3.g01195cf9f


