Return-Path: <bpf+bounces-44341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046459C1E4A
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 14:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3571C2121F
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964511EF098;
	Fri,  8 Nov 2024 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2z+yRJQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A351401C;
	Fri,  8 Nov 2024 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073566; cv=none; b=F3t3f2LKizO/8PcyGv85Pn8YG8k5gmhV4+FhH4Ks1uIj/q1iMASFWuUcrqpS2eZi9cXvmg01ocfyetp5eGCNImEBcH6lgGZm/IZVWZSerD4Vz3SvYs8ZPKknOxnJXadYxuIVMDkbhDDUqAvgCcX1Oo+tUgzkzbOt2V6fXREypT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073566; c=relaxed/simple;
	bh=SIlVpzF+fN/EudeveFUgwhBFLZ4pWdPEzHn7hJDi4Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDflgDd/i1TgQyl8UFT36OQBYqPLpup2hqYuIKyw0D2Yifjq6F1c2SyU2/C43m2FPe3Lm8i5xXWGvJ6jQ67o5soURO5GfAgUAKLjN36VAGSHPXeHQ+n9yW6OIUGs8Ql9k7WzhvERnUMgMMRabt8k3XQj+tVRUKhFYs61tmC77WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2z+yRJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7210EC4CECD;
	Fri,  8 Nov 2024 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731073565;
	bh=SIlVpzF+fN/EudeveFUgwhBFLZ4pWdPEzHn7hJDi4Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2z+yRJQ90tspQlpscOn6xFNQsqaxEmlZOIvucrIa1A8A+K/niinEdUvyCrkL3KqT
	 ppR4lZaEe32fQyf5YXasAbAnnkwmlzO+JoZU2Nu4CHf5kzUAQyVJ4bvSvUDKpCAc4U
	 RqqhgbNooURShTiyzmHkw4eaglysbnONO0ELJifvfT59n3Z8kBLzS48OroYfJczXiS
	 zP1C/1qzT1oRym62V3S358Wii5iqYuzyBz3qmPo3Il68h05qsUdsr+F4nODlYd32PQ
	 FRpimNGvZei07PeO1u4StoSd9DWNPQ85QCruwgcfiMV9C89n/kZ/6raDofV0UwBqhH
	 h4JxE840Hhoaw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv9 bpf-next 01/13] bpf: Allow return values 0 and 1 for kprobe session
Date: Fri,  8 Nov 2024 14:45:32 +0100
Message-ID: <20241108134544.480660-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108134544.480660-1-jolsa@kernel.org>
References: <20241108134544.480660-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kprobe session program can return only 0 or 1,
instruct verifier to check for that.

Fixes: 535a3692ba72 ("bpf: Add support for kprobe session attach")
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7958d6ff6b73..7d8ed377b35d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16024,6 +16024,15 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 			return -ENOTSUPP;
 		}
 		break;
+	case BPF_PROG_TYPE_KPROBE:
+		switch (env->prog->expected_attach_type) {
+		case BPF_TRACE_KPROBE_SESSION:
+			range = retval_range(0, 1);
+			break;
+		default:
+			return 0;
+		}
+		break;
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		range = retval_range(SK_DROP, SK_PASS);
 		break;
-- 
2.47.0


