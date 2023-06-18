Return-Path: <bpf+bounces-2815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EEF73463E
	for <lists+bpf@lfdr.de>; Sun, 18 Jun 2023 15:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C0B1C209EE
	for <lists+bpf@lfdr.de>; Sun, 18 Jun 2023 13:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CE01C11;
	Sun, 18 Jun 2023 13:14:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD35184C
	for <bpf@vger.kernel.org>; Sun, 18 Jun 2023 13:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2925C433C8;
	Sun, 18 Jun 2023 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687094059;
	bh=gqU+K+qy0q1kkyOxvRYqnKpRmiiRP6kD7h7NhH+7b5w=;
	h=From:To:Cc:Subject:Date:From;
	b=az0QjdOdzmCwsUiXofzzO1NBwRgBHfVoJH+wCcbMQFuTCTDQHUojO5FH/Rp66/gEo
	 R4Y78mClV0kPyLovXwdcsPAJ0/MHAThyahSLoqGb4GBp7GPgEff7B5kuN4bigT9R1N
	 /wEwBiL9/vOYGYY4QE9TG62GNp1QHhwe9jqDF84U7ywdn57axUagCfxp8UsqXSpGpF
	 aXzPHqyy/E15aYWj5vgIf+3qAQ+fNIs5imdxQfcWa70CLn2ZJf9AKtccQ+i52GPT5v
	 FBuCw3X5htnMMWGugaAJmtNuD8NnHAqV+EqVmJCEfxRQGf1dSqU2Aa55z+dPfLaTXo
	 bU5FVJksToerQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf] bpf: Force kprobe multi expected_attach_type for kprobe_multi link
Date: Sun, 18 Jun 2023 15:14:14 +0200
Message-ID: <20230618131414.75649-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently allow to create perf link for program with
expected_attach_type == BPF_TRACE_KPROBE_MULTI.

This will cause crash when we call helpers like get_attach_cookie or
get_func_ip in such program, because it will call the kprobe_multi's
version (current->bpf_ctx context setup) of those helpers while it
expects perf_link's current->bpf_ctx context setup.

Making sure that we use BPF_TRACE_KPROBE_MULTI expected_attach_type
only for programs attaching through kprobe_multi link.

Fixes: ca74823c6e16 ("bpf: Add cookie support to programs attached with kprobe multi link")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/syscall.c | 5 +++++
 1 file changed, 5 insertions(+)

 v2 changes:
 - moved the check to bpf_prog_attach_check_attach_type [Andrii]
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0c21d0d8efe4..129cc5c276c0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3440,6 +3440,11 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 		return prog->enforce_expected_attach_type &&
 			prog->expected_attach_type != attach_type ?
 			-EINVAL : 0;
+	case BPF_PROG_TYPE_KPROBE:
+		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
+		    attach_type != BPF_TRACE_KPROBE_MULTI)
+			return -EINVAL;
+		fallthrough;
 	default:
 		return 0;
 	}
-- 
2.41.0


