Return-Path: <bpf+bounces-17782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D31D281266C
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 05:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E3F1C2143B
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 04:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93951610C;
	Thu, 14 Dec 2023 04:29:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB51106
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 20:29:13 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SrK9r3H51z4f3lD3
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 12:29:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 740DD1A09B8
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 12:29:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCX5QuRhHplTSBjDg--.29483S4;
	Thu, 14 Dec 2023 12:29:07 +0800 (CST)
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
	xingwei lee <xrivendell7@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 0/2] bpf: Use GFP_KERNEL in bpf_event_entry_gen()
Date: Thu, 14 Dec 2023 12:30:08 +0800
Message-Id: <20231214043010.3458072-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCX5QuRhHplTSBjDg--.29483S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4fKF17uw1DJw4xJrykuFg_yoW8Xr13pr
	ZYka13Wr4UKrnrXwn3Kay7G3yUCws8GrnrJFn3Jw1FvFyUWF1xCF40gFsxZrWYqryakFWS
	qw1akFn2ya48Xa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

The simple patch set aims to replace GFP_ATOMIC by GFP_KERNEL in
bpf_event_entry_gen(). These two patches in the patch set were
preparatory patches in "Fix the release of inner map" patchset [1] and
are not needed for v2, so re-post it to bpf-next tree.

Patch #1 reduces the scope of rcu_read_lock when updating fd map and
patch #2 replaces GFP_ATOMIC by GFP_KERNEL. Please see individual
patches for more details.

Comments are always welcome.

Change Log:
v3:
 * patch #1: fallback to patch #1 in v1. Update comments in
             bpf_fd_htab_map_update_elem() to explain the reason for
	     rcu_read_lock() (Alexei)

v2: https://lore.kernel.org/bpf/20231211073843.1888058-1-houtao@huaweicloud.com/
 * patch #1: add rcu_read_lock/unlock() for bpf_fd_array_map_update_elem
             as well to make it consistent with
	     bpf_fd_htab_map_update_elem and update commit message
             accordingly (Alexei)
 * patch #1/#2: collects ack tags from Yonghong

v1: https://lore.kernel.org/bpf/20231208103357.2637299-1-houtao@huaweicloud.com/

[1]: https://lore.kernel.org/bpf/20231107140702.1891778-1-houtao@huaweicloud.com/


Hou Tao (2):
  bpf: Reduce the scope of rcu_read_lock when updating fd map
  bpf: Use GFP_KERNEL in bpf_event_entry_gen()

 kernel/bpf/arraymap.c | 2 +-
 kernel/bpf/hashtab.c  | 6 ++++++
 kernel/bpf/syscall.c  | 4 ----
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.29.2


