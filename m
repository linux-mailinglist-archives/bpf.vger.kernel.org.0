Return-Path: <bpf+bounces-35083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087789376F1
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 12:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C171C22129
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699F61422D6;
	Fri, 19 Jul 2024 10:56:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96683A14;
	Fri, 19 Jul 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386560; cv=none; b=nQI7y9/aGJe0RmnsTgU5C+A40E5YQ2LXZqpdx9PzmoL9oaoOmlRJjCPTpvSmKK7zBigofjt9p+7Mgu3XeLMknX+nkkqbXq8fXh02Ey6ztC2F2IEcu8BATcTD1/GgjWjtikLfKsUfVEcGrGO19jHE+K4QMPXdyXD6jPxxBZoO3f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386560; c=relaxed/simple;
	bh=rE6Ptw6QyPGUyOgXwCWyVd8DT9HkJTMUPru9G3bLjfo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tlk8zWCmOU+/PECPPROfJLuf3/Blizf7Gc92CjRRxtCSFCJc78Wq3jj7kLR3L6TRGMcuXe4VMQPJivoIV6rb3PYE+YXUV1UToV3qNJpP5bGkaKNvQZBoiV7r+iogVn2GLT+0gWX3gnyy1PfHTDLVtwMBHYgyIzVQ+f32O+B3W80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQRRG6Tmpz4f3l11;
	Fri, 19 Jul 2024 18:55:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 389771A0572;
	Fri, 19 Jul 2024 18:55:52 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgD3BVE0RppmM3cvAg--.11767S2;
	Fri, 19 Jul 2024 18:55:49 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Florent Revest <revest@google.com>
Subject: [PATCH bpf-next v2 0/9] Add BPF LSM return value range check, BPF part
Date: Fri, 19 Jul 2024 19:00:50 +0800
Message-Id: <20240719110059.797546-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgD3BVE0RppmM3cvAg--.11767S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1rArWUZr1UZrW7WF4fuFg_yoW5Xryrpa
	ykury5tr1FkF12qF4xGFW7CrWrJa1kX343C3Wxtr1rZF1UJryDXrWxGr1Ygr9xJrWFgwnY
	v3WagFnak3W8Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

LSM BPF prog may make kernel panic when returning an unexpected value,
such as returning positive value on hook file_alloc_security.

To fix it, series [1] refactored LSM hook return values and added
BPF return value check on top of that. Since the refactoring of LSM
hooks and checking BPF prog return value patches is not closely related,
this series separates BPF-related patches from [1].

v2:
- Update Shung-Hsi's patch with [3]

v1: https://lore.kernel.org/bpf/20240719081749.769748-1-xukuohai@huaweicloud.com/

Changes to [1]:

1. Extend LSM disabled list to include hooks refactored in [1] to avoid
   dependency on the hooks return value refactoring patches.

2. Replace the special case patch for bitwise AND on [-1, 0] with Shung-Hsi's
   general bitwise AND improvement patch [2].

3. Remove unused patches.

[1] https://lore.kernel.org/bpf/20240711111908.3817636-1-xukuohai@huaweicloud.com
    https://lore.kernel.org/bpf/20240711113828.3818398-1-xukuohai@huaweicloud.com

[2] https://lore.kernel.org/bpf/ykuhustu7vt2ilwhl32kj655xfdgdlm2xkl5rff6tw2ycksovp@ss2n4gpjysnw

[3] https://lore.kernel.org/bpf/20240719081702.137173-1-shung-hsi.yu@suse.com/

Shung-Hsi Yu (1):
  bpf, verifier: improve signed ranges inference for BPF_AND

Xu Kuohai (8):
  bpf, lsm: Add disabled BPF LSM hook list
  bpf, lsm: Add check for BPF LSM return value
  bpf: Prevent tail call between progs attached to different hooks
  bpf: Fix compare error in function retval_range_within
  selftests/bpf: Avoid load failure for token_lsm.c
  selftests/bpf: Add return value checks for failed tests
  selftests/bpf: Add test for lsm tail call
  selftests/bpf: Add verifier tests for bpf lsm

 include/linux/bpf.h                           |   2 +
 include/linux/bpf_lsm.h                       |   8 +
 kernel/bpf/bpf_lsm.c                          |  65 ++++++-
 kernel/bpf/btf.c                              |   5 +-
 kernel/bpf/core.c                             |  21 ++-
 kernel/bpf/verifier.c                         | 139 ++++++++++----
 .../selftests/bpf/prog_tests/test_lsm.c       |  46 ++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/err.h       |  10 +
 .../selftests/bpf/progs/lsm_tailcall.c        |  34 ++++
 .../selftests/bpf/progs/test_sig_in_xattr.c   |   4 +
 .../bpf/progs/test_verify_pkcs7_sig.c         |   8 +-
 tools/testing/selftests/bpf/progs/token_lsm.c |   4 +-
 .../bpf/progs/verifier_global_subprogs.c      |   7 +-
 .../selftests/bpf/progs/verifier_lsm.c        | 178 ++++++++++++++++++
 15 files changed, 486 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_tailcall.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lsm.c

-- 
2.30.2


