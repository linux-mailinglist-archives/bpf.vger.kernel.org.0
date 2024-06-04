Return-Path: <bpf+bounces-31339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A5F8FB666
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB415B21C21
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6435713CFA4;
	Tue,  4 Jun 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Etw1PN7j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E3EEC8
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513230; cv=none; b=Y6Q6gD8eREsBAPVrsBtUjPmKvtGbXfWTCTtduDztJNbeDLAJULgxpr/tPOFRXQOViiZQg2biNj1FsKQPWwaERTngpdKutuDrbQ5+P1n96fwtKGCbV4MAMffu8Nr8xWz0nFcTLFvV6xhrzBZ4Y6I13LPvlgursmwNcziYwUiwZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513230; c=relaxed/simple;
	bh=nUqRJuVCN8dBA6pcEsa57rbYzFOAcYqwk3jKhxje+uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMAkmbN7KeumFtb3+OjSxIpncVQgsPVekMyeBmREhPTX+cU9LmNV7LvKHzEUtd6jhJqVDr4vzXxjJZxCTjGWwSyNqdQWtQUBaT/z95WyzfFc+YQk8+7xrjV58aSDBxG1f3ltVnLk4YrPx1BBoLZzQ0pAx49qWs9C8TL+CewZBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Etw1PN7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F61FC2BBFC;
	Tue,  4 Jun 2024 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717513229;
	bh=nUqRJuVCN8dBA6pcEsa57rbYzFOAcYqwk3jKhxje+uU=;
	h=From:To:Cc:Subject:Date:From;
	b=Etw1PN7jubN7ZreId9EiAKqrsv/NAhEEjoFbiXH1xTH9cZomOjiC4tkCQrKkRnIBs
	 bsoT6BVc5bNK2inQXXwJ+G3f1x1N/LdGrfB3xLr8mSiMOSKlprf3e50urimhvoU9JR
	 vHNqHmGhs2ifCRBhbrTZOna1nLGHSmZ03TAIxlQ7/zRoo9nozzFH7paSzBTQhjpQYQ
	 Y13d+2OybpaCFpnGp7WavHXOG8UrFWRe6mNRV8F6KWqD5q3g0W+ugQgZqUByohoptq
	 AXBMicLS0zxFH4/Ml13XqVJ8D6F188ltAODBMybMDjd+UhD6p6YWLsqHXpm6Zr4WE2
	 IKMwxMMoUrvSA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHv2 bpf] bpf: Set run context for rawtp test_run callback
Date: Tue,  4 Jun 2024 17:00:24 +0200
Message-ID: <20240604150024.359247-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported crash when rawtp program executed through the
test_run interface calls bpf_get_attach_cookie helper or any
other helper that touches task->bpf_ctx pointer.

Setting the run context (task->bpf_ctx pointer) for test_run
callback.

Fixes: 7adfc6c9b315 ("bpf: Add bpf_get_attach_cookie() BPF helper to access bpf_cookie value")
Reported-by: syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ab78ff125b7979e45f9
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2 changes:
  - setting run context for test_run callback instead of
    using __bpf_trace_run [Alexei]

 net/bpf/test_run.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index f6aad4ed2ab2..36ae54f57bf5 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -727,10 +727,16 @@ static void
 __bpf_prog_test_run_raw_tp(void *data)
 {
 	struct bpf_raw_tp_test_run_info *info = data;
+	struct bpf_trace_run_ctx run_ctx = {};
+	struct bpf_run_ctx *old_run_ctx;
+
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 
 	rcu_read_lock();
 	info->retval = bpf_prog_run(info->prog, info->ctx);
 	rcu_read_unlock();
+
+	bpf_reset_run_ctx(old_run_ctx);
 }
 
 int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
-- 
2.45.1


