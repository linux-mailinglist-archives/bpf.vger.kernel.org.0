Return-Path: <bpf+bounces-1648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A6871F8B1
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 05:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E0C2819AE
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 03:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E515CF;
	Fri,  2 Jun 2023 03:06:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C159A15B2
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 03:06:19 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EFC18C;
	Thu,  1 Jun 2023 20:06:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QXSZC3bTNz4f3khp;
	Fri,  2 Jun 2023 11:06:11 +0800 (CST)
Received: from ubuntu20.huawei.com (unknown [10.67.174.33])
	by APP2 (Coremail) with SMTP id Syh0CgD33NqPXHlk9z6WKg--.23187S2;
	Fri, 02 Jun 2023 11:06:13 +0800 (CST)
From: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	gongruiqi1@huawei.com
Subject: [PATCH] bpf: cleanup unused function declaration
Date: Fri,  2 Jun 2023 11:08:42 +0800
Message-Id: <20230602030842.279262-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD33NqPXHlk9z6WKg--.23187S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1xJw1xKr45WF4rKFW8Xrb_yoW3KrgEv3
	4Fvr1xGr48WrWxAw1jvF9FqFn09w1rJr1fuF95WrZ3A3Z8GwsYkw1xA39rX3s7W3WDJFW3
	K3WkX3Wftr13KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

All usage and the definition of `bpf_prog_free_linfo()` has been removed
in commit e16301fbe183 ("bpf: Simplify freeing logic in linfo and
jited_linfo"). Clean up its declaration in the header file.

Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
---
 include/linux/filter.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index bbce89937fde..f69114083ec7 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -874,7 +874,6 @@ void bpf_prog_free(struct bpf_prog *fp);
 
 bool bpf_opcode_in_insntable(u8 code);
 
-void bpf_prog_free_linfo(struct bpf_prog *prog);
 void bpf_prog_fill_jited_linfo(struct bpf_prog *prog,
 			       const u32 *insn_to_jit_off);
 int bpf_prog_alloc_jited_linfo(struct bpf_prog *prog);
-- 
2.25.1


