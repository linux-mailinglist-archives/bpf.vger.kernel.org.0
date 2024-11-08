Return-Path: <bpf+bounces-44334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B619C1799
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 09:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163E21F23FAF
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 08:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035B31DC06B;
	Fri,  8 Nov 2024 08:15:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B141F5FA;
	Fri,  8 Nov 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053738; cv=none; b=WTIy7aDYECh++A9MnJiRlcsiiKp2R9z/tUjnSQ+Djixq1YAhD+9ZhPRoJElxhQyTwM7SnlZA4PhFyFgmZQPtaIhbZYIBeWGsRe35CAMa8q0ub6OGxR3n71P6w/i4x2urGBQjZ7Y8pXBvegAhxAtLnoC4huULJSOjF9iJWxQGs8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053738; c=relaxed/simple;
	bh=HHHyiUWdL+mT8XT8mOSl8Zd9IRBTVbg2Xlu2B1EnlZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tzuTDkyW29VIMiKVMJgluWR9YkPpqmrOrQZVvhiFrsihLsBqZ+kfp3b5yJSI+2MtFkos3nUj+eGX72u6GDZmAB6hRtNqj1mpJhw7OhJ2Xs07cBLClnaxdhTWjFAZbSG2FsuNTJ7nKJai5URS0qkDSXhXnU08cky/ej7u5yu+Cik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XlBZP31Qnz4f3jXc;
	Fri,  8 Nov 2024 16:15:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 77D8A1A07BA;
	Fri,  8 Nov 2024 16:15:27 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgAXDK6eyC1nOEOhBA--.5950S2;
	Fri, 08 Nov 2024 16:15:27 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 0/2] Fix release of struct_ops map
Date: Fri,  8 Nov 2024 16:26:31 +0800
Message-Id: <20241108082633.2338543-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXDK6eyC1nOEOhBA--.5950S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFy3tF43KF1kWr48Xw4DCFg_yoW3urbE9w
	43KrykGw43G3WFyFW5Cr13WFZ2g39xKryUZF1DXasrXrn8trn8AF4kCrsxKa45ZrWfGFya
	vw1kX34I9r1aqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x07jeLvtUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

This series fix a bug I found when doing rcu waiting cleanup for struct_ops
map. When there is sleepable prog in struct_ops map, the map risks being
released while the prog is still running.

Xu Kuohai (2):
  bpf: Fix release of struct_ops map
  selftests/bpf: Add test for struct_ops map release

 kernel/bpf/bpf_struct_ops.c                   |  37 +++--
 kernel/bpf/syscall.c                          |   7 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  78 ++++++---
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   2 +-
 .../bpf/prog_tests/test_struct_ops_module.c   | 154 ++++++++++++++++++
 .../bpf/progs/struct_ops_map_release.c        |  30 ++++
 6 files changed, 267 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_map_release.c

-- 
2.39.5


