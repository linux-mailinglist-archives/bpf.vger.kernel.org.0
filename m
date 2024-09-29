Return-Path: <bpf+bounces-40520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B337989772
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 22:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A06A283153
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 20:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED83817AE1D;
	Sun, 29 Sep 2024 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0KWE+kM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D780768E1;
	Sun, 29 Sep 2024 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643506; cv=none; b=PvoiJQVcSYFv2kP9Xkt5VjmCIDSd2RWdEllCVnwrjtdEISXi84nBhS38DAwVsJBOLWrgkoaWuCVgYt3FxgWI9KY39XdcFP+nxlUgvUC4a/kMByqlSTDJjjaQYJJ7f4oqdmtgp2Tja0lTjWU4PK+DRzSsqEHKUk7snbY3I5bT0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643506; c=relaxed/simple;
	bh=p7mWPSIolWA4rN8j3pRSzYOWFCyb6wl14UbPts/dKbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bH0JlUhzAQCplgbVKenX9fEfTUMZ/v3KFYtv2uiiOq7xtEKlPIhvPRtoAqoHQ3LjZ6gWnu9F/na0VkxYfaVzxQBQHmHhX8NJeQOsV7OVrsNnVETAICTs/P3ZTeFDSeDH3xGV5TPYvUidguvXcxVJZotoF9Fbuw+qozraMF0PJRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0KWE+kM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E894C4CEC5;
	Sun, 29 Sep 2024 20:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727643506;
	bh=p7mWPSIolWA4rN8j3pRSzYOWFCyb6wl14UbPts/dKbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n0KWE+kMVVW+V2cInudMS02kuTD9KwhsqN8vKJQnCF+M5ECQNH6oeG7jziF3IJLW1
	 uFBUb4LOCLbmqP2Z3fUynZ3V+YUMsZ7g1OKjVZ+3uZn/evJGebjnlGpIF9ESwzw3yQ
	 B34xvzRYRV9g1NPEoiRO8thz1fuCa8RWZ1q1MoFq8MZj3FH2DioEd4QuVMTqj0PDsv
	 GwLAfYLHtf9UiNr1/7hD3QMxZVtkPdYaGPcsD1dvSlJT+TO1gXrW4IkfFlAmh6Xee7
	 BPdUZMZQqzjK56eroNJQao1OLuqXHVDlYmohtePKvK1JQzE2snhVY1P70cbYlykchX
	 Y6fJTPzLviJdw==
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
Subject: [PATCHv5 bpf-next 05/13] bpf: Allow return values 0 and 1 for uprobe/kprobe session
Date: Sun, 29 Sep 2024 22:57:09 +0200
Message-ID: <20240929205717.3813648-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240929205717.3813648-1-jolsa@kernel.org>
References: <20240929205717.3813648-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uprobe and kprobe session program can return only 0 or 1,
instruct verifier to check for that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d9b38ffd220..c4d7b7369259 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15910,6 +15910,16 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 			return -ENOTSUPP;
 		}
 		break;
+	case BPF_PROG_TYPE_KPROBE:
+		switch (env->prog->expected_attach_type) {
+		case BPF_TRACE_KPROBE_SESSION:
+		case BPF_TRACE_UPROBE_SESSION:
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
2.46.1


