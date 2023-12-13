Return-Path: <bpf+bounces-17661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14223810FCD
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 12:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55F4281D35
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 11:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7F82377E;
	Wed, 13 Dec 2023 11:24:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371D0A0
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 03:24:33 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SqtRY1z9Sz4f3l1X
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:24:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 404B11A0800
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:24:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3OhBqlHllBOIgDg--.15138S4;
	Wed, 13 Dec 2023 19:24:28 +0800 (CST)
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
Subject: [PATCH bpf-next v2 0/4] bpf: Fix warnings in kvmalloc_node()
Date: Wed, 13 Dec 2023 19:25:27 +0800
Message-Id: <20231213112531.3775079-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3OhBqlHllBOIgDg--.15138S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr4UJr1UGF43ZFW7JryfCrg_yoW8JrWDpF
	Wvq3W5tr4rJF9rtan3A3yxWryFqan3GrW7Xr17Jw1rArs8J3W8GFZ7Kw45X3s5u398tF1a
	ywnrtr98Ga48Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set aims to fix the warnings in kvmalloc_node() when passing
an abnormally big cnt during multiple kprobes/uprobes attachment.

Patch #1 and #2 fix the warning by limiting the maximal number of
uprobes/kprobes. Patch #3 and #4 add tests to ensure these warnings are
fixed.

Please see individual patches for more details. Comments are always
welcome.

Change Log:
v2:
  * limit the number of uprobes/kprobes instead of suppressing the
    out-of-memory warning message (Alexei)
  * provide a faked non-zero offsets to simplify the multiple uprobe
    test (Jiri)

v1: https://lore.kernel.org/bpf/20231211112843.4147157-1-houtao@huaweicloud.com/
  
Hou Tao (4):
  bpf: Limit the number of uprobes when attaching program to multiple
    uprobes
  bpf: Limit the number of kprobes when attaching program to multiple
    kprobes
  selftests/bpf: Add test for abnormal cnt during multi-uprobe
    attachment
  selftests/bpf: Add test for abnormal cnt during multi-kprobe
    attachment

 kernel/trace/bpf_trace.c                      |  7 ++--
 .../bpf/prog_tests/kprobe_multi_test.c        | 14 ++++++++
 .../bpf/prog_tests/uprobe_multi_test.c        | 33 ++++++++++++++++++-
 3 files changed, 51 insertions(+), 3 deletions(-)

-- 
2.29.2


