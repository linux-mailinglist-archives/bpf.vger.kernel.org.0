Return-Path: <bpf+bounces-59256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AEBAC7679
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73B61883C1D
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA93223DC4;
	Thu, 29 May 2025 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="oPSLQdbk"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF150522A;
	Thu, 29 May 2025 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748489505; cv=none; b=iGtFXYUy8/JxLEuSYuczPLi6MGp0XoS0FufagQLbtY17qsQdnF5px9arj7iuqdympQyqWOIn9notga5ZmhH3CkvB1QrOPAf0lQbD8DDsWHzf1rIrQgw6WNYZpxyAJ4oSogOxi2hW9ZBY6YgPGm5yt4S37pKhg/hBFoETJVrHUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748489505; c=relaxed/simple;
	bh=GLddzMcHmNKqGi7kbu+MAefpXvkhVCFECgYaJ+JY8XA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=RQu1HmT4vsW4SoxMnJm5PULpA8ltysYISzxjiTzgMwzobULacvmLp1OPLMOSODMUdafUwQvL77vKJPrB9XOeB331PgxguKKTE5HSOGfdiAgYv6jzzzrQxrMTr56OhmM3pMuH4vZOs5r13V5Y3Gqg5NqnRMyh4NVanCZE6HkIMUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=oPSLQdbk; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1748489194;
	bh=3ViZDnQsyPelzKAA5qIj22G7H/WSUnkg5p3rVmc7dOQ=;
	h=From:To:Cc:Subject:Date;
	b=oPSLQdbkZNGy0vKPvcyP098vW9isLAyTf3Y9YLGRfEnDoNYiHW1xsJH/xB6h+DQo7
	 HqARsYSTqkwF81eZNk4h0CQGxTP9qVeA8CYfPgbBSNghGD+M+Sr65fSc5Ni4mkItuW
	 NXKLsPVdy0vOCjrIL94F2NNBp2FySbFrhjB7F/hk=
Received: from NUC10.. ([39.156.73.10])
	by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
	id 69D358EA; Thu, 29 May 2025 11:26:29 +0800
X-QQ-mid: xmsmtpt1748489189tyxvfnux5
Message-ID: <tencent_A8B65EDD467511570D5C8400B2102E335409@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUA5CTjrv+VV5RVoF533Ali/lhqSgrYSM8vjuPx3TmYDSmLec6YXz
	 CrJcLIOVgn88p+CsifH4UG+WNfZvEoowLFwnZ68B8CMVkMYTUnyTUiibBSMIYEKCwF0gQH+Kmvjf
	 upsIPNTxVH+vGK7JQ1s7YbgAi5o4GfWsGTdyd9kMGDDT117hBlKFIvsKebxis0ILCkTmHJrC0mZ0
	 UXL/iMaMRYAdc+I/HFGsYZYovYq4gQJ+pIhIZXMni01zgna3ucp0ni3h4nfpuV4sSINXRrufnlaF
	 UONUYlOnMfvsoH6e5FcDSNcCIqMBw1AAzNKsahLVdMmJQFvbQnKCue66hQzA0m7Xtp4tFc8X90n0
	 ciuiCMCn7E2O0Wh1iVYxHnjg5zzjjNyGt1TvX3Nu7lC/Xmn5ppyaF8aUZ7ie6c9rS3nS/sr2TMO/
	 Jj27YJJFDqqZRDpRaP3gtB67I3KdkcB/OcOx9J6SafYxAffqrmJ8K0ERc3UQCZPBq3bUWlHvkjsR
	 jQRHOCoSMENaUyIvIkgoNMW9IjYAd/WvymhdsT21NNtSvtx8JnpPap7rHeDimVtlV7b0ackNhvZe
	 LGtHPZ6mmPtjJfIc/UpLU9TpgLkQhhSTnjeHO1l/AXZ8b8o2D+Te7XCMJWTyMsXHZsUnKmTqYDYy
	 iOuO+M9L7NzS0q3avzn0OtgGYmfpnbQ5kVfMb2AW0OfC3tOzuscjVjdm1FbENWSSnGrBNhSLpOjE
	 M5RLETDimRZY8voW5va49G6A5bBe451hQ9+WFVWRVt86AHDLVoOcOw1Ke33Gia8Y2YPPqQsPFvsX
	 uS/AbyZbPbH4na342U2Z4UX8m1AoUWaNSNk1NIVOT4weBAuXQDpscdyJMTsiXus7bmgdFaF3sL8i
	 FgSiIAMWIlynKcbKlxlUZF6OLoDYGBJuoaj4MvHAecS3bsduf5hJEFacsGaxpwkdRFNLwwoCzhpT
	 cgqui0fcuTaUF7Q8HsfY0T1C1UUz9xyLRO6nFdEu/XuaWIhR6LTgJvbORJJaS/YEh44WCWPfIr3w
	 pFVsW1zg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Rong Tao <rtoax@foxmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: rtoax@foxmail.com,
	rongtao@cestc.cn,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Juntong Deng <juntong.deng@outlook.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next 0/2] Add kfunc for doing pid -> task cwd
Date: Thu, 29 May 2025 11:26:13 +0800
X-OQ-MSGID: <cover.1748488784.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some application like bpftrace [1], need to get the cwd from the pid.
This patch provides a new kfunc that can get the cwd of the process from
the pid.

[1] https://github.com/bpftrace/bpftrace/issues/3314

Rong Tao (2):
  bpf: Add bpf_task_cwd_from_pid() kfunc
  selftests/bpf: Add selftests for bpf_task_cwd_from_pid()

 kernel/bpf/helpers.c                          | 45 ++++++++++++++++++
 .../selftests/bpf/prog_tests/task_kfunc.c     |  3 ++
 .../selftests/bpf/progs/task_kfunc_common.h   |  1 +
 .../selftests/bpf/progs/task_kfunc_success.c  | 47 +++++++++++++++++++
 4 files changed, 96 insertions(+)

-- 
2.49.0


