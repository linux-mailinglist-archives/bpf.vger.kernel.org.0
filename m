Return-Path: <bpf+bounces-50916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE795A2E3FD
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0423A39E5
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 06:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6186718FDAB;
	Mon, 10 Feb 2025 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrYdjMJN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC22F85B;
	Mon, 10 Feb 2025 06:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167381; cv=none; b=O2L9f7ARsKT74lQxLq/BB6nHqiq9wwmbehgHMDxAj1Ef+R5dIj746VwkZPzTAk3usfxZQpopHtyXBw4pjELcn0ie/lfEB300rP58V7hQclOIWruOsHHek5mrYcQaX+LArIPkqvBERA0IKTWUWd8M3rFrUQuCgoCDD4gaIRTMuXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167381; c=relaxed/simple;
	bh=+3QgKQPoTIH0+wQ+7JtLpuSAapuhNkwKBQz34gQM4Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZ42irksTPhzgezZ4AMWLLc162CVNpA9ppddlgPMc/Hq7N6S58PADXJEY9Qg2UiBPXsV8dSVru63sc3DXT9HkR/FLkTCgx8T/iWXAEZtY3nUuv/6hBiCnjGzOyPMvMNXEVbxPhz/B7S1eDwNXc6Zvzom77J4INJYJF2KunPxU1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrYdjMJN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so1602269a91.3;
        Sun, 09 Feb 2025 22:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739167379; x=1739772179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1cNQcPTZwmCoIHeRTz8PvwWE2m4fjmllHZAXO9Nt1c=;
        b=JrYdjMJN+m3YC5DUVIbZXG3rVQuWZ+vQIZW9KqBNtNDe4N++Uz/VvM7Ig0jpN2P6fK
         +TQOBmVC7UUnmi1k4pqg6kP11MNNnxSjvH5ozCRMNrSqqEXPQRplsk5oyxk6d8RL+qFz
         FEoiJ8jWGUAkCuWVrM43l/2RfTDCf692caMhvHahuVf7lE06i5vn7VSbS7SfD8JEez6/
         jLc3qW9d/28we+SlHjZhY+N6102eeylFq2/nYnAFxaVx6oFgnuFrncJKFpXUtT9eeQd1
         YN2H8EfemCIlfDI8WlIBZ8pdSjsFZJCsODVH5qDPFBG5Hmws87R3m7goRUS5iXl9+Te8
         04EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739167379; x=1739772179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1cNQcPTZwmCoIHeRTz8PvwWE2m4fjmllHZAXO9Nt1c=;
        b=J6i1zTMYtVTxlW6cBtb+itInkD62lQj3aBQvaHqKrSpl9EUgmUYLCrxwtaymVB648P
         GWaMRLw9eGdxRlIAQpj5TZAvLwCcl/6I9mfzUyqtZeyUTmNK7Fycr8Ka3qabpGY4SlLt
         FBJBNGS5Pc2Pbx7Sar1KO17i9v/BzXVsm5d7M1GHaFk4/5o3eBZqAHdDLl4dsooWTcPa
         wGBgqXx+tyZgoWbVu0JRc7HebOdpKOXoHAX+SV7DF8h0h9v8ADih7R5B7GHu0liJKrwT
         s8HoI18jLGKvi3tHXstIisMjKX5z8UmAFbfhUPS8Qobu69astSQ6U1kYKTkN03UpBmuF
         wUzw==
X-Forwarded-Encrypted: i=1; AJvYcCWU46obJbVkW3RphHxtZ8bQhL5CcM/Q8I5pubXX9cyAB+7YJLl02VaIWhXsck56VdbrNw1dZ2plMnQhVo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRm4ldHRU195MJU/rM8ldQuIl0LKXOLUwAcU5zYNLdt7cME2ev
	HY6t0SOE7frzO0QttckWCiu1UkhGVR3nZBzaEryKwbzYcxf3imPKy+HHnNuz
X-Gm-Gg: ASbGncvDa5eAHiU+gqNBWUSoPWrH6/NDdzkmn4ObM/riFwElEMqOa4HL+zvLo32//fh
	F5MBfTZN09vNmkM4qa+0I2yb6n+n9siQonMDeyEd5/ElziSDCfuCzhnxJ1BfMLrcMyUN7PEAgFm
	/SsrkHFpALNtbgSvysvEPFaMEZuibP+JBx506tlDUf2MmtkXDGIfKsiqNMF4c+RzdZJ8zLcJ87k
	QJQXsTEQ8DdjCEXBphj4F99hk8KNuK/lsNZJst+/w07npD8cvhRKKwLw/UpzspQaBzyI3s8IuIp
	sQUPbCcOrPh7eA==
X-Google-Smtp-Source: AGHT+IEDXs9zLs3Jp4PiuXgvGOt7awJ4JD5oIq3sCGSeyXlz0QPcsuO7svKqMd2b7gnDyik0Z2zHrg==
X-Received: by 2002:a17:90b:4b0b:b0:2f4:49d8:e718 with SMTP id 98e67ed59e1d1-2fa23f6d51cmr19416990a91.9.1739167378532;
        Sun, 09 Feb 2025 22:02:58 -0800 (PST)
Received: from localhost.localdomain ([119.147.10.191])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fa09a6fe28sm7726361a91.26.2025.02.09.22.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 22:02:58 -0800 (PST)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: 
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ze Gao <zegao@tencent.com>
Subject: [PATCH] selftests/sched_ext: Fix false positives of init_enable_count test
Date: Mon, 10 Feb 2025 14:02:51 +0800
Message-ID: <20250210060252.59424-1-zegao@tencent.com>
X-Mailer: git-send-email 2.41.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests run in VM might be slow, so that children may exit before bpf
programs are loaded. SCX_GE(skel->bss->init_task_cnt, num_pre_forks)
would fail in this case.

For tests working in any env, use signals to control the lifetime of
children beyond bpf prog loading deterministically to get expected
results.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 .../selftests/sched_ext/init_enable_count.c   | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/init_enable_count.c b/tools/testing/selftests/sched_ext/init_enable_count.c
index 97d45f1e5597..3b2c8ab8464f 100644
--- a/tools/testing/selftests/sched_ext/init_enable_count.c
+++ b/tools/testing/selftests/sched_ext/init_enable_count.c
@@ -31,6 +31,11 @@ open_load_prog(bool global)
 	return skel;
 }
 
+/* Signal handler for children */
+void sigusr1_handler(int sig)
+{
+}
+
 static enum scx_test_status run_test(bool global)
 {
 	struct init_enable_count *skel;
@@ -39,9 +44,15 @@ static enum scx_test_status run_test(bool global)
 	int ret, i, status;
 	struct sched_param param = {};
 	pid_t pids[num_pre_forks];
+	sigset_t blocked_set;
 
 	skel = open_load_prog(global);
 
+	/* Block SIGUSR1 in parent, children will inherit this*/
+	sigemptyset(&blocked_set);
+	sigaddset(&blocked_set, SIGUSR1);
+	sigprocmask(SIG_BLOCK, &blocked_set, NULL);
+
 	/*
 	 * Fork a bunch of children before we attach the scheduler so that we
 	 * ensure (at least in practical terms) that there are more tasks that
@@ -52,7 +63,13 @@ static enum scx_test_status run_test(bool global)
 		pids[i] = fork();
 		SCX_FAIL_IF(pids[i] < 0, "Failed to fork child");
 		if (pids[i] == 0) {
-			sleep(1);
+			signal(SIGUSR1, sigusr1_handler);
+			sigprocmask(SIG_UNBLOCK, &blocked_set, NULL);
+			/*
+			 * Wait indefinitely for signal, will be interrupted
+			 * by signal handler.
+			 */
+			pause();
 			exit(0);
 		}
 	}
@@ -60,6 +77,13 @@ static enum scx_test_status run_test(bool global)
 	link = bpf_map__attach_struct_ops(skel->maps.init_enable_count_ops);
 	SCX_FAIL_IF(!link, "Failed to attach struct_ops");
 
+	/* Give children time to set up handlers */
+	sleep(1);
+
+	/* Send SIGUSR1 to all children */
+	for (int i = 0; i < num_pre_forks; i++)
+		kill(pids[i], SIGUSR1);
+
 	for (i = 0; i < num_pre_forks; i++) {
 		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
 			    "Failed to wait for pre-forked child\n");
@@ -69,6 +93,7 @@ static enum scx_test_status run_test(bool global)
 	}
 
 	bpf_link__destroy(link);
+	SCX_EQ(skel->bss->init_task_cnt, skel->bss->exit_task_cnt);
 	SCX_GE(skel->bss->init_task_cnt, num_pre_forks);
 	SCX_GE(skel->bss->exit_task_cnt, num_pre_forks);
 
-- 
2.41.1


