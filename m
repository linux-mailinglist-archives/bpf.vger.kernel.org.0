Return-Path: <bpf+bounces-27662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0998B06D4
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 12:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655FBB22B17
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F91598FF;
	Wed, 24 Apr 2024 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz2UGCxE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA2158DA8;
	Wed, 24 Apr 2024 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952952; cv=none; b=H1HSJKThs+miAVK4U/Ntie58EKCaRoUa8+X02EI/7paIMuwXfiD55X8fuMBswn7YIgfeWBbKPRz1rBQCCwXuCO7rdbvqLLXS0pIM9OePyKfZNqBLyGgdNuMbPKpPDs8ibt/eU/FrZQZi+Q9WovLR8nFnAroh2hJWU3D/ltPnyu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952952; c=relaxed/simple;
	bh=oL7euqQOMkAdTbRR41q3h6SKHz/4uPigwGY12t28/8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vAW3kxAuCuiYi6QisdW0hZ6fvSB1aKOgCtnmim/JDeRO4TH8nnfrsd/7dFaRQoP5eisWBtjsRHM2fMW1pB80JqCQXl3qR9wm5lryn8iDMY4fa8QHdqJU/gEy5FRa6YuW9LMEn7Aahx/AuDV8go6oto9/zc7YS08ju9w71feplEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz2UGCxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3488FC32782;
	Wed, 24 Apr 2024 10:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713952951;
	bh=oL7euqQOMkAdTbRR41q3h6SKHz/4uPigwGY12t28/8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jz2UGCxEeVvwFjD9sH7F4nZA25IdIdfJozpMrCOdMQyyyaAKtscTzZzap/P3ZAaGn
	 oDhz3xoLjjWXzct00MNfAolNmGXQivHydCUJ16dbZYzRLDJqsJ50uPAHEpS5/l/gtX
	 Cc5/MGuYiJTYMtTt+XatRG2oNE2lPLN9AGeF4WiCOrfjF2zQ2pZbBUqvh/KbW6KuXj
	 7NAsleNwcWdOeFYP6atsb/dzXWjrTFxeSDmWn3f5D5UwtnyCD7oLZET0DKQjFeha7H
	 8gJzKhJY9pT4vao9Kg6cgdfsv0XKC8APGCkzkZOrwOE9FYU9aqpYSQmM/SKiSoGhxn
	 elebZmWAkjy3g==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf v6 3/3] selftests/bpf: Test PROBE_MEM of VSYSCALL_ADDR on x86-64
Date: Wed, 24 Apr 2024 10:02:10 +0000
Message-Id: <20240424100210.11982-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240424100210.11982-1-puranjay@kernel.org>
References: <20240424100210.11982-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vsyscall is a legacy API for fast execution of system calls. It maps
a page at address VSYSCALL_ADDR into the userspace program. This address
is in the top 10MB of the address space:

ffffffffff600000 - ffffffffff600fff |    4 kB | legacy vsyscall ABI

The last commit fixes the x86-64 BPF JIT to skip accessing addresses in
this memory region. Add this address to bpf_testmod_return_ptr() so we
can make sure that it is fixed.

After this change and without the previous commit, subprogs_extable
selftest will crash the kernel.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 39ad96a18123..edcd26106557 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -205,6 +205,9 @@ __weak noinline struct file *bpf_testmod_return_ptr(int arg)
 	case 5: return (void *)~(1ull << 30);	/* trigger extable */
 	case 6: return &f;			/* valid addr */
 	case 7: return (void *)((long)&f | 1);	/* kernel tricks */
+#ifdef CONFIG_X86_64
+	case 8: return (void *)VSYSCALL_ADDR;   /* vsyscall page address */
+#endif
 	default: return NULL;
 	}
 }
-- 
2.40.1


