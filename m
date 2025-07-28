Return-Path: <bpf+bounces-64484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA34EB135B3
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0918B18947EB
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 07:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F94C248881;
	Mon, 28 Jul 2025 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYbbrz90"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5410F230BCE;
	Mon, 28 Jul 2025 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753687618; cv=none; b=McSdBA4XUX6y/+D4W7+luGd+naX15LlKtv4XdyVeloaaB43fDpBdsg8SYO0ujBWmNecYPOELba4txFF51oSQfEyirLRW2aaSKx3X17koo/t5AyTnhcqmEFTPzhFkcYj/a2Y/mnp18xpI28nxzbHtkNY5OLLusKomqZPGtzaQx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753687618; c=relaxed/simple;
	bh=bRExeoONmR0WhrsbqFNroJ9+Vz1rBjIUMt3FwoFHMyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVKuxfEiPr53vv2DlUvbnEEHej0Fm1B1eBjgOXQmGPhiO9yZyI0gJSLoBdTeD6c2gOPvFXHxapvj+x8YjZ9KF2cDRqfGbtOC+ffn5AchZ4yrnVV0UYOaUDuvuLPNqKaG06Psf71FrRB88Ew5a26BFJ9oox/zSfJfhNh5+l8QcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYbbrz90; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b321bd36a41so3432769a12.2;
        Mon, 28 Jul 2025 00:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753687617; x=1754292417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjeNP1ojEwSXm7x5F0g4swwiLUfc7kqWz38lpPc+Rx8=;
        b=XYbbrz90LtDrnUwvInxDOSLeJHvn3fVoGMbH7ABuxmQF4H+stD5cH9m2huHLWnv3/n
         dsxFyajVcWnbA5F8zjvNKe8oNriZsnYShL10Mf9aJamcRY7G8uBENnDCwbkXxNt1N339
         mPKUodOel3u31qBsA3UAQJpl6abrqAeded+gejR9kYBbx82e7JAzQSfRdmuVpTUYbsPM
         vOvo64gUg0lpDCLz38W7FLmvbcN89amUSbxVQHATVoRQR4Hv1gCPswogMVoFRvipluMp
         HOIPE6IN69dFSxRftCq2eS3FrmhkSbBxCQd5IuiFVgiXq6v1Ikz3eLL+4lG4xzpcSaZE
         zxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753687617; x=1754292417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjeNP1ojEwSXm7x5F0g4swwiLUfc7kqWz38lpPc+Rx8=;
        b=sXfSAhRrIPiuHokX+37Ujim4OpTbWYw4qAmEdujbc/zMqy3a5OiqoColfJLIWH0FPu
         oBgqL4GOscWj14jQtmYPDd5fSVq0PNPC630T647iVV4YMZmnEZedyxwehE8CTgZmyo6i
         4KaRD6tqo4LFbEB3DVKKRZHvK5JcGnbDOIGwhIjByMPf3xfB8g4KObQ+LBBD4v/g5oRB
         IMyQhG5jT2TyWgyix3JTO76kpBzsYhLl8zCDn0Zh27MZ2j5D9Qx301WAsYria2sIs4mJ
         qZLo4Zui8zlpc0mOo8H/Uu7uBy3vQp8la/t0T70y2cauGitwqPVeBzsUILSo9E1jSp1m
         IIFw==
X-Forwarded-Encrypted: i=1; AJvYcCV5L8LhGKp4FstgElo3XRlpCo/J4pZSlaKkU9nU6rT3bOSa/bPErfDTyrQQ2zgVhfquIME=@vger.kernel.org, AJvYcCVYY3Iwb3K7sTwKMK9Hv37o7sRH1XmVxRrXEwPU+nh+NpGDzEihkURpJowyv5eLve1IUQgOxMk0130a23/sYFnghR7J@vger.kernel.org, AJvYcCX/Y4CGRjHrySaC/f34KAyJZQk/wExpkOoztHpBP/0GZxpjoHwWjcRHDOhkDztRxZVniQXkIBCHEiBHqNiN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/qxNeHi/DY7ldkqoPGjLc+9n/IIY6T/U497S48oqp/HnhcZtV
	McH0we6wrcx1UJK+iqHmgmgHhXtJogMkvG3mv/Pls74+ZyifBgHqfYYl
X-Gm-Gg: ASbGncu/CUadqIJmKeqWgCaUoyCWWnp8VFjrsw9VajOFP3l9Nk3h0VBbDC7IDLFiPZQ
	zDYmTTxySC5ieBBSvCPh15kPq1nAJ7I72mORc+NjEWO5EnWCfJoUZO3clhwlx7xmjvZTnnATl/b
	2LLSnlOfsvLjzH8GVZZzKQ10b8ThIqguFonNaq/zDFuB83aJPZZ/x7ctoL/MeBrbmdqmu0oYT9C
	mhERUtcLusOKf2F+aAo794/uAW1mGkHunFnF9TVTDMh0XFBtGixLBM9Epde+EFOHglc8WVRakUO
	5wcMtblBaKjiFSkurmM/qwSK98ajKtoaItmo2SVuTT0bBz5G3Rxqe3KY/VXmLjHVMGEktIiQMId
	pXfuXlvqoIzOu5uVUUEA=
X-Google-Smtp-Source: AGHT+IFZC7ZzjzX5wLnDbw02CA57fWodl50nJAry8hSvo4JT90aZvZDnnQhekEdTf7UiFDu/FyYXOQ==
X-Received: by 2002:a17:90b:37ce:b0:312:f650:c795 with SMTP id 98e67ed59e1d1-31e77a01339mr16768415a91.21.1753687616654;
        Mon, 28 Jul 2025 00:26:56 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e949bbf7asm4459599a91.9.2025.07.28.00.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 00:26:56 -0700 (PDT)
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
Subject: [PATCH RFC bpf-next v2 4/4] selftests/bpf: add benchmark testing for kprobe-multi-all
Date: Mon, 28 Jul 2025 15:22:53 +0800
Message-ID: <20250728072637.1035818-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728072637.1035818-1-dongml2@chinatelecom.cn>
References: <20250728072637.1035818-1-dongml2@chinatelecom.cn>
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


