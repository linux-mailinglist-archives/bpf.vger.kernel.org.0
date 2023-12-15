Return-Path: <bpf+bounces-17983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05392814522
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 11:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B2A1C22C6A
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 10:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CC318C29;
	Fri, 15 Dec 2023 10:06:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1B18C01
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ss4cJ25Nrz4f3kjg
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 18:06:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8E43B1A05EB
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 18:06:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHlQsLJXxlJTfVDg--.54090S4;
	Fri, 15 Dec 2023 18:06:05 +0800 (CST)
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
Subject: [PATCH bpf-next v3 0/5] bpf: Fix warnings in kvmalloc_node()
Date: Fri, 15 Dec 2023 18:07:03 +0800
Message-Id: <20231215100708.2265609-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHlQsLJXxlJTfVDg--.54090S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy7JF4fZF1rWrW7AFW7XFb_yoW8AFy5pF
	Wvq3W5Kr4rXF9xJan3C3s7WryFqws5GrW7XryxJw1rCrs8J3W8GFs7K3y5Wr95urZ0g3Wa
	ywnrtr90ga4UZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The patch set aims to fix the warnings in kvmalloc_node() when passing
an abnormally big cnt during multiple kprobes/uprobes attachment.

Patch #1 and #2 fix the warning by limiting the maximal number of
uprobes/kprobes. Patch #3, #4, and #5 add tests to ensure these
warnings are fixed.

Please see individual patches for more details. Comments are always
welcome.

Change Log:
v3:
  * add ack tags from Jiri
  * return -E2BIG instead of -EINVAL for too-big cnt (Andrii)
  * patch #3: rename the subtest from "failed_link_api" to
              "attach_api_fails", so it is consistent with the naming
	      convention in multi-kprobe test.
  * patch #4: newly-added patch to remove libbpf_get_error() in
              kprobe_multi_test (Andrii)

v2: https://lore.kernel.org/bpf/20231213112531.3775079-1-houtao@huaweicloud.com/
  * limit the number of uprobes/kprobes instead of suppressing the
    out-of-memory warning message (Alexei)
  * provide a faked non-zero offsets to simplify the multiple uprobe
    test (Jiri)

v1: https://lore.kernel.org/bpf/20231211112843.4147157-1-houtao@huaweicloud.com/

Hou Tao (5):
  bpf: Limit the number of uprobes when attaching program to multiple
    uprobes
  bpf: Limit the number of kprobes when attaching program to multiple
    kprobes
  selftests/bpf: Add test for abnormal cnt during multi-uprobe
    attachment
  selftests/bpf: Don't use libbpf_get_error() in kprobe_multi_test
  selftests/bpf: Add test for abnormal cnt during multi-kprobe
    attachment

 kernel/trace/bpf_trace.c                      |  7 ++++
 .../bpf/prog_tests/kprobe_multi_test.c        | 31 +++++++++++++++---
 .../bpf/prog_tests/uprobe_multi_test.c        | 32 ++++++++++++++++++-
 3 files changed, 64 insertions(+), 6 deletions(-)

-- 
2.29.2


