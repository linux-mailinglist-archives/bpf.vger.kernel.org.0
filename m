Return-Path: <bpf+bounces-1765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A21472141C
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 04:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822EE1C20A95
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 02:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B448017F6;
	Sun,  4 Jun 2023 02:29:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87817ED
	for <bpf@vger.kernel.org>; Sun,  4 Jun 2023 02:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AEEC433EF;
	Sun,  4 Jun 2023 02:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685845745;
	bh=zfEkmBPuZFLSZLn5IlKeELqqgyZdzHiaAiDXC1xJHhg=;
	h=From:To:Cc:Subject:Date:From;
	b=lbhB6zltz8j434oatnR9CPUQMgCNKN24ZCbUpIknBpJBIkGy2mHjEcrCSme6q2c+K
	 pbL7vAdUxslk88IUzAJCkJfvaz1zurDFpgcNCZ5PcDPthgYcyTrqg52Tp4IDfTcsxd
	 KA+xdUOY5sy3vI9zMl7ykTac+m6Ew1X8vY83K9Kt7dKYgBw8K1zPmI5fauhn5mv2+9
	 oQF3Bg1zRIe5GpX7ugHh7EzLL3vIOXMq0jy2eSCeNcZZY9PZgPFLFXpuqDhnMIHRJu
	 lVOrcT4XsK52czIprPz4d4mzaablHRcwAJFW1/5Yt+t/VxIiO2RRyzG/ixUiqPwPQn
	 AmLDGiaBuxqVw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Florent Revest <revest@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] tracing/probes: Fix to return NULL and keep using current argc
Date: Sun,  4 Jun 2023 11:29:00 +0900
Message-ID:  <168584574094.2056209.2694238431743782342.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix to return NULL and keep using current argc when there is
$argN and the BTF is not available.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306030940.Cej2JoUx-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ba1c6e059b51..473e1c43bc57 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1273,7 +1273,8 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 			trace_probe_log_err(0, NOSUP_BTFARG);
 			return (const char **)params;
 		}
-		return 0;
+		*new_argc = argc;
+		return NULL;
 	}
 	ctx->params = params;
 	ctx->nr_params = nr_params;


