Return-Path: <bpf+bounces-51910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC91A3B1A4
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 07:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FDDA7A2E0E
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 06:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593751BC099;
	Wed, 19 Feb 2025 06:29:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B885F1B86CC
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946575; cv=none; b=S9BOatIms4I9ulO42Rr5V90UoNitRCn7G4Qav1K6A0L1hoFL7QLMDoruEHgnvZ+ATwae8a3R6zC/Rp13aB/tM4d5nIMwhZVYnNVnl7JDxKuWkLvK+iLtvUkIvCxY8GoU3K0CYn6EXztKxHtMxneVWxl4gPQOceBV6Pns6XL1xMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946575; c=relaxed/simple;
	bh=WVS4gMqTbtue7p1bajbWHcqjNe76LT9sju+K0EsgjBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=enVyDu8VRufLi/9pzzh675cKB6C1UMoU71VWRKJC0wqaMVEQEYd7qhN1m6gbHbvv0V+ZBMgR3+bgj0Lk2dbg/w7aycdOqWSUrUTUjuKrZUUKPp70dEV8fzxtlikkkjt1G5z+o7z4RtoYugSFTsIvaoN32Wob6iL5bw+UcoNTHLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YyRLT3WKDz4f3jtD
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 14:29:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C17B51A0D9D
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 14:29:21 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgBXYmU+erVnK7z_EA--.41413S2;
	Wed, 19 Feb 2025 14:29:19 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next] kbuild, bpf: Correct pahole version that supports distilled base btf feature
Date: Wed, 19 Feb 2025 06:31:13 +0000
Message-Id: <20250219063113.706600-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXYmU+erVnK7z_EA--.41413S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1UtFyUGFW5tw13Ar1UJrb_yoWDZrX_Cr
	Z3KFWIg3yrGrsFqw4UJFW5Xr1jqr9akFs5Zw1xG3W7Zwn8KFZ5GFs3G34F9a12qay3WFyr
	AF1UZF1jq3W7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

pahole commit [0] of supporting distilled base btf feature released on
pahole v1.28 rather than v1.26. So let's correct this.

Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=c7b1f6a29ba1 [0]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 scripts/Makefile.btf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index c3cbeb13de50..fbaaec2187e5 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -24,7 +24,7 @@ else
 pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
 
 ifneq ($(KBUILD_EXTMOD),)
-module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
+module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
 endif
 
 endif
-- 
2.34.1


