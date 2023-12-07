Return-Path: <bpf+bounces-16983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5CD807F6C
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 05:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FEB1F21170
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 04:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F2D5682;
	Thu,  7 Dec 2023 04:09:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63D13D73;
	Wed,  6 Dec 2023 20:08:59 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxIvBZRXFlqoY_AA--.60736S3;
	Thu, 07 Dec 2023 12:08:57 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxK9xYRXFltidXAA--.61203S2;
	Thu, 07 Dec 2023 12:08:57 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND bpf-next v1] test_bpf: Rename second ALU64_SMOD_X to ALU64_SMOD_K
Date: Thu,  7 Dec 2023 12:08:51 +0800
Message-ID: <20231207040851.19730-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxK9xYRXFltidXAA--.61203S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFyrArWfZw1rWr48trWkuFX_yoWDKwcE9a
	18AF9rAF15uFyYvw4SgFWDKrs29F4Dt3WxCr1DuFWDGay5Jry5Cr4kZr1Uua45WrZav3ZF
	v3WDt3ZrGwnYkosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU2rgADUUUU

Currently, there are two test cases with same name
"ALU64_SMOD_X: -7 % 2 = -1", the first one is right,
the second one should be ALU64_SMOD_K because its
code is BPF_ALU64 | BPF_MOD | BPF_K.

Before:
test_bpf: #170 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
test_bpf: #171 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS

After:
test_bpf: #170 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
test_bpf: #171 ALU64_SMOD_K: -7 % 2 = -1 jited:1 4 PASS

Fixes: daabb2b098e0 ("bpf/tests: add tests for cpuv4 instructions")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

Add "bpf-next" in the patch subject, sorry for that

 lib/test_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 7916503e6a6a..3c5a1ca06219 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -6293,7 +6293,7 @@ static struct bpf_test tests[] = {
 	},
 	/* BPF_ALU64 | BPF_MOD | BPF_K off=1 (SMOD64) */
 	{
-		"ALU64_SMOD_X: -7 % 2 = -1",
+		"ALU64_SMOD_K: -7 % 2 = -1",
 		.u.insns_int = {
 			BPF_LD_IMM64(R0, -7),
 			BPF_ALU64_IMM_OFF(BPF_MOD, R0, 2, 1),
-- 
2.42.0


