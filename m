Return-Path: <bpf+bounces-39902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FBB979107
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 15:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56EC3B225C6
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7BE1CFEA2;
	Sat, 14 Sep 2024 13:37:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F361993B0
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321026; cv=none; b=Ub8wowuz8WNs/h+hLPnvZ5y9L3/X20nVfWRl8n2U3BLQOyOoqr7mSJYbTcEDhUPtJuX2JJMa2AXBfFxh4ilSK8ZhLfeE+uWZ/ZMvIPy/ssGCJ7548eUefO1X8lYmYdH/oR5361mh5J+A1cxiVTmEWq2nfJwLhvwRye+OGvl0DpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321026; c=relaxed/simple;
	bh=3dSIdK5seyPK72CLXSK5qfh+89ibrollUZuYT54QfVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rF/YrkJj1SEIwWxqYUzgwibL+uzziVdXmXws5HlDliYyWPo0XQ9iH7eEPgXRg01lVj98kX4mwhwHyci2GuuC1DcTYnebgWSoTXsZvslBXBhUKcc12nMnIW6/41NynvC+QBEWu5EibLFsfyQJp6d6zRFIIRGxX4Z41FqoAc9X84I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X5XJq5kYrz4f3jXc
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 21:36:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6696E1A018D
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 21:36:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDHR8R3keVmnUI4BQ--.14337S4;
	Sat, 14 Sep 2024 21:36:57 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf v2 0/2] Check the remaining info_cnt before repeating btf fields
Date: Sat, 14 Sep 2024 21:37:01 +0800
Message-Id: <20240914133703.1920767-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHR8R3keVmnUI4BQ--.14337S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1kXFyrKw4ktw17CFy8Krg_yoWkArXE9F
	WFkr95WF48Z3ZrKFy0gFnaqFyDKrW8uryUJFyDA3sFkw1UZw4UGF4vkryrJryUXayDXr9x
	CFsrCa9Yqr47ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
	AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set adds the missed check again info_cnt when flattening the
array of nested struct. The problem was spotted when developing dynptr
key support for hash map. Patch #1 adds the missed check and patch #2
adds three success test cases and one failure test case for the problem.

Comments are always welcome.

Change Log:
v2:
 * patch #1: check info_cnt in btf_repeat_fields()
 * patch #2: use a hard-coded number instead of BTF_FIELDS_MAX, because
             BTF_FIELDS_MAX is not always available in vmlinux.h (e.g.,
	     for llvm 17/18)

v1: https://lore.kernel.org/bpf/20240911110557.2759801-1-houtao@huaweicloud.com/T/#t

Hou Tao (2):
  bpf: Check the remaining info_cnt before repeating btf fields
  selftests/bpf: Add more test case for field flattening

 kernel/bpf/btf.c                              | 14 +++-
 .../selftests/bpf/prog_tests/cpumask.c        |  1 +
 .../selftests/bpf/progs/cpumask_common.h      |  5 ++
 .../selftests/bpf/progs/cpumask_failure.c     | 35 +++++++++
 .../selftests/bpf/progs/cpumask_success.c     | 78 ++++++++++++++++++-
 5 files changed, 127 insertions(+), 6 deletions(-)

-- 
2.29.2


