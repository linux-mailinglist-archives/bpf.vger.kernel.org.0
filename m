Return-Path: <bpf+bounces-7817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFD877CEFD
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FE928147B
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1A814F89;
	Tue, 15 Aug 2023 15:21:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CA412B98
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 15:21:12 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7181990
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 08:21:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQFN16bNMz4f3pJ6
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 23:21:05 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgDH68Pgl9tk7KrwAg--.42348S2;
	Tue, 15 Aug 2023 23:21:05 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yonghong Song <yhs@fb.com>,
	Zi Shen Lim <zlim.lnx@gmail.com>
Subject: [PATCH bpf-next 0/7] Support cpu v4 instructions for arm64
Date: Tue, 15 Aug 2023 11:41:51 -0400
Message-Id: <20230815154158.717901-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDH68Pgl9tk7KrwAg--.42348S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyfur1xKry3Xr4kAF4DCFg_yoWkXrXEkw
	saya4v93WrAF1SyFyUC3WxXryDCwsIqry7Gr13trZ2qr1UZw4DAF4kJa40y348Xa4SgrW3
	ZF9rK34Fkr43WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

This series adds arm64 support for cpu v4 instructions [1].

[1] https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@linux.dev/

Xu Kuohai (7):
  arm64: insn: Add encoders for LDRSB/LDRSH/LDRSW
  bpf, arm64: Support sign-extension load instructions
  bpf, arm64: Support sign-extension mov instructions
  bpf, arm64: Support unconditional bswap
  bpf, arm64: Support 32-bit offset jmp instruction
  bpf, arm64: Support signed div/mod instructions
  selftests/bpf: Enable cpu v4 tests for arm64

 arch/arm64/include/asm/insn.h                 |  4 +
 arch/arm64/lib/insn.c                         |  6 ++
 arch/arm64/net/bpf_jit.h                      | 12 +++
 arch/arm64/net/bpf_jit_comp.c                 | 91 +++++++++++++++----
 .../selftests/bpf/progs/test_ldsx_insn.c      |  2 +-
 .../selftests/bpf/progs/verifier_bswap.c      |  2 +-
 .../selftests/bpf/progs/verifier_gotol.c      |  2 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |  2 +-
 .../selftests/bpf/progs/verifier_movsx.c      |  2 +-
 .../selftests/bpf/progs/verifier_sdiv.c       |  2 +-
 10 files changed, 103 insertions(+), 22 deletions(-)

-- 
2.30.2


