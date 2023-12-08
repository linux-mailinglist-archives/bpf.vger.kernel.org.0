Return-Path: <bpf+bounces-17170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3C580A111
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253B81F2182B
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2B1945B;
	Fri,  8 Dec 2023 10:33:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B1A2102
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 02:32:57 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SmnXK1FSnz4f3l1w
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:32:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EFD3B1A01CF
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:32:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxHS8HJlAndMDA--.46929S4;
	Fri, 08 Dec 2023 18:32:52 +0800 (CST)
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
Subject: [PATCH RESEND bpf-next 0/2] bpf: Use GFP_KERNEL in bpf_event_entry_gen()
Date: Fri,  8 Dec 2023 18:33:55 +0800
Message-Id: <20231208103357.2637299-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnqxHS8HJlAndMDA--.46929S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GF18Cw48CrWfAFyxJF45GFg_yoWfJwc_W3
	92kry5Cr1DJ3WYqa10kr40grs3Kry8J3WUAayUtry2vr15Zws3Ars5CFyY9ryDXFZ7WF95
	trnxZw4qvr45ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbc8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIx
	AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The simple patch set aims to replace GFP_ATOMIC in bpf_event_entry_gen().
These two patches in the patchset were preparatory patches in "Fix the
release of inner map" patchset [1] and are not needed for v2, so re-post
it to bpf-next tree.

Patch #1 reduces the scope of rcu_read_lock when updating fd map and
patch #2 replaces GFP_ATOMIC by GFP_KERNEL. Please see individual
patches for more details.

Comments are always welcome.

Regards,
Tao

[1]: https://lore.kernel.org/bpf/20231107140702.1891778-1-houtao@huaweicloud.com


Hou Tao (2):
  bpf: Reduce the scope of rcu_read_lock when updating fd map
  bpf: Use GFP_KERNEL in bpf_event_entry_gen()

 kernel/bpf/arraymap.c | 2 +-
 kernel/bpf/hashtab.c  | 2 ++
 kernel/bpf/syscall.c  | 4 ----
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.29.2


