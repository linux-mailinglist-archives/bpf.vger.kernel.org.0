Return-Path: <bpf+bounces-64478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 849CCB13396
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 06:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914F41884047
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 04:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B28E221F31;
	Mon, 28 Jul 2025 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK+gBeSX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACAB220F34;
	Mon, 28 Jul 2025 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753675995; cv=none; b=HAd7NNUhFNVz6Pp2u83LSseVNXSkFDX/UHFlhznP5A8U4jrNDC1DINbNhhrMNiTdk7jUX2xCa1Y1yxyUWSRYlws39M0b2+USvCmuHvDUzUl5g3pIsr2b1P+byRQbFCmlvKYuPjkXUoc5fd7aCcpgR2EnSdv8jn/n03fpe2H6WnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753675995; c=relaxed/simple;
	bh=bRExeoONmR0WhrsbqFNroJ9+Vz1rBjIUMt3FwoFHMyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGyPmxDWkaqHwdw0+nvm7ptYnnKBHSTU/IF+FDPzNFWQaA5FW+Kx5dAS+G5kS/GPqgaqRhOGnzD+V7AFUCyEU84nLDUPtg52p3sFqk0onzYQkLvORODR9mVMgTZVe7s2/b4Iz2RGgfzNEOxGIihN4onY680G4Te/X5/YAIkf5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK+gBeSX; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-23602481460so39620015ad.0;
        Sun, 27 Jul 2025 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753675993; x=1754280793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjeNP1ojEwSXm7x5F0g4swwiLUfc7kqWz38lpPc+Rx8=;
        b=fK+gBeSX/zLgzQIWjLg5MsFYTWm+ernGTfh48OcfErjnfZT+paMLVH5PAxb4tw5CaM
         U84qSUotMtrYmmsIe5uKaMSxD5CLY37o8kTvVVxyyaroiApv92PTwAwPyPq7JmCVZ0d3
         Op2bZSeBRFRW/UiQ6E7vV9afNzaZnE6afh0GFo50W2c2LM4ig3iHhGStKQbAvn4HgtU1
         7Bzs4d+qJ/OU5imjb7mpUD5/YAUxXY7uo1pcpV3CeWaHwuoffUB7n3auWtZDSU5py9jb
         btZ1M1ZkINpni2arWmYoXV/Ly9SjYdj15ctqB+125bde17awZoXmZNwO7ztXycnP19qd
         uzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753675993; x=1754280793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjeNP1ojEwSXm7x5F0g4swwiLUfc7kqWz38lpPc+Rx8=;
        b=M3aA8Yc26ZA9mXS1iLMgQ8VIgugQysmX91hAYxjV7beJBPXlpiNl0HnkKPvjk6QLkc
         /bSobfX0u4I9M1AusMG5ieQhh7jVrkH7LoyV5vtLPbNvW4Zr+AM9zzLCTkaVvNS4q0sr
         fBrix7M1oaQbZTyqJC09hwq7KbKHGjOK8Ll2bN65aWoYtZ2vJGWqlyabDSY+JitHDPTw
         StLGoVP/R7WqTVcn8abz9Y0IJSGYkeUBm6JBiYV7M+v5zPjuq3phN7IBhnNSk1+2INPp
         41OtayBqVhqP5qdkuaZEMHlvLy6BO2yz+b+WGCEt77RiGxGERQZ7neDk68T3MLFAS/VG
         dvbw==
X-Forwarded-Encrypted: i=1; AJvYcCUWoFKvckbHYbdnRybrr1uWdf+7cTD9TF70t+y9RRIQk1YoLFbpN4KBP1QFRnYQ+weJlnNr9Q7n5r+WrqLPfolkFxS4@vger.kernel.org, AJvYcCXCWj97iTtKxhgwhR9xEkygSUAH3CL72fJfgR0EVCqC3KyGTUvUUR/rQOIn2FSiWKhv72mzzsh97YBVCnOt@vger.kernel.org, AJvYcCXXsjNMRbyx1pTj1uVRdqZTmYU6hmV5LZGpzNVaEurYad7IIzQygj6cXMOBVS0GmFXb+VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytkzG/C1Uxvmj/xkfPzskngoIdZj365ZPnpysVFDtTmUZM4vjR
	tdf9Y3KBGNqIv5cVkdqqZOt/dRppzXntBB4x6JsEJPO9K3p5NRKBNJ1O
X-Gm-Gg: ASbGncv0ZetoHcaykpEpNnrbGb75ix1ebpwUJqxpW9y7dPSqIjCN5AQb3SQUC4MNO4N
	YTIWCJl0HHTxZf2+9K2jubq7Apic+QE/rox+4npjLiJzr7XGysl6Mh7u+zh9ABVq92cZ0h8Yso7
	wgd720ZV3BD7kTT7zVSz7W31zxGyPivHwwWF20xcvuhozILzcIq+9QEkOZWxDoWNrLDUbuf2/y5
	fvJ1d+YKAVgNo5fQ/knSm8cwzP/sXmzRds0oXgXYElznKcw8ahFuXq8M3fcr17z80ILNTHgJ6w/
	zA99LBMgun5TZd9dF5+z1nQdNeNpLVp98roQo6EU1jztk4e5NMb29hJYPeFJuWMRXC4keVxr2cO
	NkubBBK6r/Dksfk40Zco=
X-Google-Smtp-Source: AGHT+IF9kh81K3dC0j67xBO5/cmUYFztZWzS9P4O92aNSAOnGEzvIs2s4ZaQScwsDq0lt6VC2wP0aw==
X-Received: by 2002:a17:903:4b50:b0:236:9726:7264 with SMTP id d9443c01a7336-23fb305083dmr171963755ad.5.1753675993352;
        Sun, 27 Jul 2025 21:13:13 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24008efc073sm20599175ad.58.2025.07.27.21.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 21:13:13 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 4/4] selftests/bpf: add benchmark testing for kprobe-multi-all
Date: Mon, 28 Jul 2025 12:12:51 +0800
Message-ID: <20250728041252.441040-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728041252.441040-1-dongml2@chinatelecom.cn>
References: <20250728041252.441040-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the benchmark for kprobe-multi is single, which means there is
only 1 function is hooked during testing. Add the testing
"kprobe-multi-all", which will hook all the kernel functions during
the benchmark.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/testing/selftests/bpf/bench.c           |  2 ++
 .../selftests/bpf/benchs/bench_trigger.c      | 30 +++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |  2 +-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index ddd73d06a1eb..da971d8c5ae5 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -510,6 +510,7 @@ extern const struct bench bench_trig_kretprobe;
 extern const struct bench bench_trig_kprobe_multi;
 extern const struct bench bench_trig_kretprobe_multi;
 extern const struct bench bench_trig_fentry;
+extern const struct bench bench_trig_kprobe_multi_all;
 extern const struct bench bench_trig_fexit;
 extern const struct bench bench_trig_fmodret;
 extern const struct bench bench_trig_tp;
@@ -578,6 +579,7 @@ static const struct bench *benchs[] = {
 	&bench_trig_kprobe_multi,
 	&bench_trig_kretprobe_multi,
 	&bench_trig_fentry,
+	&bench_trig_kprobe_multi_all,
 	&bench_trig_fexit,
 	&bench_trig_fmodret,
 	&bench_trig_tp,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 82327657846e..be5fe88862a4 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -226,6 +226,35 @@ static void trigger_fentry_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_fentry);
 }
 
+static void trigger_kprobe_multi_all_setup(void)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	char **syms = NULL;
+	size_t cnt = 0;
+
+	setup_ctx();
+	prog = ctx.skel->progs.bench_trigger_kprobe_multi;
+	bpf_program__set_autoload(prog, true);
+	load_ctx();
+
+	if (bpf_get_ksyms(&syms, &cnt, true)) {
+		printf("failed to get ksyms\n");
+		exit(1);
+	}
+
+	printf("found %zu ksyms\n", cnt);
+	opts.syms = (const char **) syms;
+	opts.cnt = cnt;
+	link = bpf_program__attach_kprobe_multi_opts(prog, NULL, &opts);
+	if (!link) {
+		printf("failed to attach bpf_program__attach_kprobe_multi_opts to all\n");
+		exit(1);
+	}
+	ctx.skel->links.bench_trigger_kprobe_multi = link;
+}
+
 static void trigger_fexit_setup(void)
 {
 	setup_ctx();
@@ -512,6 +541,7 @@ BENCH_TRIG_KERNEL(kretprobe, "kretprobe");
 BENCH_TRIG_KERNEL(kprobe_multi, "kprobe-multi");
 BENCH_TRIG_KERNEL(kretprobe_multi, "kretprobe-multi");
 BENCH_TRIG_KERNEL(fentry, "fentry");
+BENCH_TRIG_KERNEL(kprobe_multi_all, "kprobe-multi-all");
 BENCH_TRIG_KERNEL(fexit, "fexit");
 BENCH_TRIG_KERNEL(fmodret, "fmodret");
 BENCH_TRIG_KERNEL(tp, "tp");
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
index a690f5a68b6b..886b6ffc9742 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
@@ -6,7 +6,7 @@ def_tests=( \
 	usermode-count kernel-count syscall-count \
 	fentry fexit fmodret \
 	rawtp tp \
-	kprobe kprobe-multi \
+	kprobe kprobe-multi kprobe-multi-all \
 	kretprobe kretprobe-multi \
 )
 
-- 
2.50.1


