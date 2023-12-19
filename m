Return-Path: <bpf+bounces-18292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A481890D
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 14:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC5C1F255BF
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 13:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8297F1A587;
	Tue, 19 Dec 2023 13:55:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC61B26C
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SvdVp63X5z4f3jHd
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 21:55:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 369D51A01C8
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 21:55:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBnahC+oIFl6oJPEA--.423S4;
	Tue, 19 Dec 2023 21:55:12 +0800 (CST)
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
Subject: [PATCH bpf-next 0/3] bpf: inline bpf_kptr_xchg()
Date: Tue, 19 Dec 2023 21:56:12 +0800
Message-Id: <20231219135615.2656572-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnahC+oIFl6oJPEA--.423S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyUXry3Wr4fuw43GFyUJrb_yoW8JF4kpF
	WfKFy3trZYvF9Fkw4fJw42qa4rAw4rWr13Xr1fCw1DA3Z8XFykXFnxKryF9as0qryIkFWF
	vr4jvry3K3Z0vFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The motivation for the patch set comes from the performance profiling of
bpf memory allocator benchmark (will post it soon). The initial purpose
of the benchmark is used to test whether or not there is performance
degradation when using c->unit_size instead of ksize() to select the
target cache for free [1]. The benchmark uses bpf_kptr_xchg() to stash
the allocated objects and fetches the stashed objects for free. Based on
the fix proposed in [1], After inling bpf_kptr_xchg(), the performance
for object free increase about ~4%.

Initially the inline is implemented in do_jit() for x86-64 directly, but
I think it will more portable to implement the inline in verifier.
Please see individual patches for more details. And comments are always
welcome.

[1]: https://lore.kernel.org/bpf/20231216131052.27621-1-houtao@huaweicloud.com

Hou Tao (3):
  bpf: Support inlining bpf_kptr_xchg() helper
  bpf, x86: Don't generate lock prefix for BPF_XCHG
  bpf, x86: Inline bpf_kptr_xchg() on x86-64

 arch/x86/net/bpf_jit_comp.c |  9 ++++++++-
 include/linux/filter.h      |  1 +
 kernel/bpf/core.c           | 10 ++++++++++
 kernel/bpf/verifier.c       | 17 +++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.29.2


