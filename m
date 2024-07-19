Return-Path: <bpf+bounces-35063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4E09374E2
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D1DB21A6C
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 08:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924C584037;
	Fri, 19 Jul 2024 08:13:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5039FCE;
	Fri, 19 Jul 2024 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376811; cv=none; b=hc0Na19u/1Aum34bNOQVVUtnmZbJU4jkir6fi/OpfMMN1bveghYuWxQ0/IuIe/yIOec/F/RQSSNrDSmfcLrtC5971NvagcEkMSfwp3NvGOaEqjC/75FzybHtYUHFWLcsURWj1ec8myq9UfJ9rLKI0Ph4TwyTHarKKgTUXjBqlcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376811; c=relaxed/simple;
	bh=lwEa9rjwFk7AVGkFM3y3tQoXZQQJ1Fyw52N6f8rgx7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oksw+IDW3IcpqM6A11AB3thStyUTPFXXTuDb2GcpmD3mQC8lVSS8ETGoMgQq7SF8y5Xk7m6MxdrMQtwv2q4E83ic/XgZhTAW8Dm2+mWtTANnOe+L15bPlXrrORX6H/wNVzmBkCXc45AQo4RR5S8WDz/qrnHKger2IsRLKFb3CcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQMqq3g6Qz4f3kvb;
	Fri, 19 Jul 2024 16:13:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CCAEC1A0568;
	Fri, 19 Jul 2024 16:13:24 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgCXo04hIJpm5CslAg--.56491S2;
	Fri, 19 Jul 2024 16:13:22 +0800 (CST)
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
Subject: [PATCH -next v1 0/9] Add BPF LSM return value range check, BPF part
Date: Fri, 19 Jul 2024 16:17:40 +0800
Message-Id: <20240719081749.769748-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXo04hIJpm5CslAg--.56491S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3uF4DZw17CF1UAryDtrb_yoW5JrWrpa
	ykWr98tr1FkF12qF13JF47urWrZa1kX345A3Wxtr1Fv3WUJryDXrWxGr1Ygr9xArWFgrnY
	v3W2gFnak3W8Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

LSM BPF prog may make kernel panic when returning an unexpected value,
such as returning positive value on hook file_alloc_security.

To fix it, series [1] refactored LSM hook return values and added
BPF return value check on top of that. Since the refactoring of LSM
hooks and checking BPF prog return value patches is not closely related,
this series separates BPF-related patches from [1].

Changes to [1]:

1. Extend LSM disabled list to include hooks refactored in [1] to avoid
   dependency on the hooks return value refactoring patches.

2. Replace the special case patch for bitwise AND on [-1, 0] with Shung-Hsi's
   general bitwise AND improvement patch [2].

3. Remove unused patches.

[1] https://lore.kernel.org/bpf/20240711111908.3817636-1-xukuohai@huaweicloud.com
    https://lore.kernel.org/bpf/20240711113828.3818398-1-xukuohai@huaweicloud.com

[2] https://lore.kernel.org/bpf/ykuhustu7vt2ilwhl32kj655xfdgdlm2xkl5rff6tw2ycksovp@ss2n4gpjysnw

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
 kernel/bpf/verifier.c                         | 138 ++++++++++----
 .../selftests/bpf/prog_tests/test_lsm.c       |  46 ++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/err.h       |  10 +
 .../selftests/bpf/progs/lsm_tailcall.c        |  34 ++++
 .../selftests/bpf/progs/test_sig_in_xattr.c   |   4 +
 .../bpf/progs/test_verify_pkcs7_sig.c         |   8 +-
 tools/testing/selftests/bpf/progs/token_lsm.c |   4 +-
 .../bpf/progs/verifier_global_subprogs.c      |   7 +-
 .../selftests/bpf/progs/verifier_lsm.c        | 178 ++++++++++++++++++
 15 files changed, 485 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_tailcall.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lsm.c

-- 
2.30.2


