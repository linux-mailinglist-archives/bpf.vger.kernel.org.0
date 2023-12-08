Return-Path: <bpf+bounces-17128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A06980A08A
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F541C20CC6
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C1714F7D;
	Fri,  8 Dec 2023 10:22:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F12C170F
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 02:22:54 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SmnJn08rNz4f3kG8
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:22:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5774A1A035F
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:22:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxF57nJlY85LDA--.46390S4;
	Fri, 08 Dec 2023 18:22:51 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next 0/7] bpf: Fixes for maybe_wait_bpf_programs()
Date: Fri,  8 Dec 2023 18:23:48 +0800
Message-Id: <20231208102355.2628918-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnqxF57nJlY85LDA--.46390S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4rWrWxZFy5Wry8Ww15Arb_yoW8WryUpF
	Zag343KF18GrnFkr43A3yjv3s0yr4ktw1xJr1ayry0qwsrZFy09ry8KanYy345ArWftF4F
	qry8trn3Kw1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set aims to fix the problems found when inspecting the code
related with maybe_wait_bpf_programs().

Patch #1 removes unnecessary invocation of maybe_wait_bpf_programs().
Patch #2 calls maybe_wait_bpf_programs() only once for batched update.
Patch #3 adds the missed waiting when doing batched lookup_deletion on
htab of maps. Patch #4 does wait only if the update or deletion
operation succeeds. Patch #5 fixes the value of batch.count when memory
allocation fails. Patch #6 does the similar thing as patch #4, except it
fixes the problem for batched map operations. Patch #7 handles sleepable
BPF program in maybe_wait_bpf_programs(), but it doesn't handle the bpf
syscall from syscall program.

Please see individual patches for more details. Comments are always
welcome.

Hou Tao (7):
  bpf: Remove unnecessary wait from bpf_map_copy_value()
  bpf: Call maybe_wait_bpf_programs() only once for
    generic_map_update_batch()
  bpf: Add missed maybe_wait_bpf_programs() for htab of maps
  bpf: Only call maybe_wait_bpf_programs() when map operation succeeds
  bpf: Set uattr->batch.count as zero before batched update or deletion
  bpf: Only call maybe_wait_bpf_programs() when at least one map
    operation succeeds
  bpf: Wait for sleepable BPF program in maybe_wait_bpf_programs()

 include/linux/bpf.h  | 14 +++++------
 kernel/bpf/hashtab.c | 20 ++++++++-------
 kernel/bpf/syscall.c | 60 +++++++++++++++++++++++++++++++-------------
 3 files changed, 61 insertions(+), 33 deletions(-)

-- 
2.29.2


