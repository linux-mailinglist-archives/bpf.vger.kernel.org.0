Return-Path: <bpf+bounces-1766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1A272141F
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 04:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3825B1C20A96
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF47117F6;
	Sun,  4 Jun 2023 02:29:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67517C8
	for <bpf@vger.kernel.org>; Sun,  4 Jun 2023 02:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A632C433EF;
	Sun,  4 Jun 2023 02:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685845755;
	bh=y88we4Ac5oqKMeA+6cCyWjkxfe/UMHngQ2wGime+q2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aeGo+OzExfIcaVTrUQgTEBsZvOwNXFMpeRHOsfIOqR4FtAA6UqEW7LVaIYZIDsl2u
	 WMsWqdYzcamlrzjxlusrQwktdYNJFZmgpOI1TG34aSijw7JWc3Mk9vzz4CUdmvzDEr
	 6xYT86fkLlBMAxt2rQX9sLyRgf68ZfApkE88zg+lkKgSYw9FGuuKBSz6WmsPwqqABl
	 7f7kQNa7Mq6mwlnmvKgxgYL7MT5O5Z5Xyl8lcOjvUtiTvp4uSJr8dy4NdXlAhhr3Po
	 +s7jEP0HcpPIvv4pKU1+HXbLNEgVsPvUOpumgmyhNOpZZq/GO5zqiW1ZcTueeFT/g4
	 P2Hg2Uicv39vg==
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
Subject: [PATCH 2/2] Documentation: Fix typo of reference file name
Date: Sun,  4 Jun 2023 11:29:11 +0900
Message-ID:  <168584575125.2056209.5771945721143181243.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To:  <168584574094.2056209.2694238431743782342.stgit@mhiramat.roam.corp.google.com>
References:  <168584574094.2056209.2694238431743782342.stgit@mhiramat.roam.corp.google.com>
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

Fix a typo of Documentation/trace/fprobe.rst.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306040144.aD72UzkF-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/fprobetrace.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index e949bc0cff05..7297f9478459 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -38,7 +38,7 @@ Synopsis of fprobe-events
                   with a digit character, "_TRACEPOINT" is used.
  MAXACTIVE      : Maximum number of instances of the specified function that
                   can be probed simultaneously, or 0 for the default value
-                  as defined in Documentation/trace/fprobes.rst
+                  as defined in Documentation/trace/fprobe.rst
 
  FETCHARGS      : Arguments. Each probe can have up to 128 args.
   ARG           : Fetch "ARG" function argument using BTF (only for function


