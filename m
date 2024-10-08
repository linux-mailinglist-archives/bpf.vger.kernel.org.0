Return-Path: <bpf+bounces-41190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFB2993F77
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860821F25132
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 07:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D4B1D2F6A;
	Tue,  8 Oct 2024 06:59:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3931C230A
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370752; cv=none; b=qpmUeAyVeBBIV0N1g/KOqdTPbYpw2NpIb5owEUkKY1r2yiy/IWKTpJpVobE95Sm88ILKWAyeh9nzAXfzPKGnqm8uFLNJ+jqrRWqJQ449RHjPhd+QczUwPFwEmW3phvHOrbHoDqb7r8CAXNBqPdYgxN/tCMF/J1+8LStUj8xqCic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370752; c=relaxed/simple;
	bh=3dSIdK5seyPK72CLXSK5qfh+89ibrollUZuYT54QfVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O8xPLFzIxnjJ+vii1cfbDG3FjCM7w+w5vpXa89VXrOvgb+7U0b9IUY0a9BwBOWUG4moBZ0ZhS9ifvtFl22cNe4MKqYE7WtadA877DxndhiFOC+PCjAzJj2RKzUv41lmXxHLBOl87Hf6nXNIP2M+wT7oYfwr8UoN1o4g+AldI1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN6Lc3jGbz4f3lVc
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 14:58:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 123EF1A092F
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 14:59:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMg22ARnFIP_DQ--.38499S4;
	Tue, 08 Oct 2024 14:59:04 +0800 (CST)
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
	Kui-Feng Lee <thinker.li@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf RESEND 0/2] Check the remaining info_cnt before repeating btf fields
Date: Tue,  8 Oct 2024 15:11:12 +0800
Message-Id: <20241008071114.3718177-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXTMg22ARnFIP_DQ--.38499S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1kXFyrKw4ktw17CFy8Krg_yoWkArXE9F
	WFkr95WF48Z3ZrKFy0gFnaqFyDKrW8uryUJFyDA3sFkw1UZw4UGF4vkryrJryUXayDXr9x
	CFsrCa9Yqr47ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UZ4SrUUUUU=
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


