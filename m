Return-Path: <bpf+bounces-68234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B6EB54A28
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 12:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EAAC1CC7833
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 10:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A4F2ED87A;
	Fri, 12 Sep 2025 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD1t2sEM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9992EE612
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673866; cv=none; b=eloYe/7TwWPPae34MNcdh3AthpGCTrJdK7VCmpFkvGXakgw+p5A9yTyeifwGXYgMTqg18MuK7CTvxfxx3l+GVV2eO1A+rbN/5VGGVx5DVD9PeD3IMtg1zsVSL1qHKNcD3O63X7iCtl32o8VXfIdaKLKlKrQc9XgZO5n8EKxQeZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673866; c=relaxed/simple;
	bh=vUwTSRY6URg0Ifv5PkrWPyp8KD+Bis3cOfMiN8PEwFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQzXJggp/WDA3btzY86hsWLpMIRuq640gkO3ReHufbL4QEVwZaJNg0d/tw0AdJE1OU/FoXuThJOVvmx6S5fyqsI+EgvBlZAB11kqGlxZtS2hsOTCRSLGgbl6vOlXuLlIB3G2uER+u4RKsh+GixmSOnLmXwv7vGLS73kmVgClLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD1t2sEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53326C4CEF1;
	Fri, 12 Sep 2025 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757673865;
	bh=vUwTSRY6URg0Ifv5PkrWPyp8KD+Bis3cOfMiN8PEwFE=;
	h=From:To:Cc:Subject:Date:From;
	b=dD1t2sEMw4lLy6ePLjsyv8jdcMnoLuVyTWcReQrj+FY6FPnPovil9Q1rjUCJBy0K6
	 7AtuKkteQUNeewhgN5Qivgduml9s2HjYAJR0iobvtJKPkupHmhSq/GU1KzBYa7VCpO
	 xf+tF4TlGLxd4dKhahfymifjiD/Qkqjyzf0+hR9ayRy0n6IlbYIZob1i2Wnt4WuhFp
	 G72MrABkhfNQX6Mn9h7GYVrCAscjv6N61AFyGwzIr7IaXmPQyGRg2xxzL8CIBfIf3x
	 0LFmFkT2JdrWTi5Uf/1F+8PA2HVL8sr5XKm7aEg/rB0pF9rhCa/6VR8JgqOYbi3/wT
	 VX395mrV0b1HQ==
From: Quentin Monnet <qmo@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next] bpftool: Search for tracefs at /sys/kernel/tracing first
Date: Fri, 12 Sep 2025 11:43:43 +0100
Message-ID: <20250912104343.58555-1-qmo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With "bpftool prog tracelog", bpftool prints messages from the trace
pipe. To do so, it first needs to find the tracefs mount point to open
the pipe. Bpftool looks at a few "default" locations, including
/sys/kernel/debug/tracing and /sys/kernel/tracing.

Some of these locations, namely /tracing and /trace, are not standard.
They are in the list because some users used to hardcode the tracing
directory to short names; but we have no compelling reason to look at
these locations. If we fail to find the tracefs at the default
locations, we have an additional step to find it by parsing /proc/mounts
anyway, so it's safe to remove these entries from the list of default
locations to check.

Additionally, Alexei reports that looking for the tracefs at
/sys/kernel/debug/tracing may automatically mount the file system under
that location, and generate a kernel log message telling that
auto-mounting there is deprecated. To avoid this message, let's swap the
order for checking the potential mount points: try /sys/kernel/tracing
first, which should be the standard location nowadays. The kernel log
message may still appear if the tracefs is not mounted on
/sys/kernel/tracing when we run bpftool.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/r/CAADnVQLcMi5YQhZKsU4z3S2uVUAGu_62C33G2Zx_ruG3uXa-Ug@mail.gmail.com/
Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/tracelog.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/tracelog.c b/tools/bpf/bpftool/tracelog.c
index 31d806e3bdaa..49828a4f60c2 100644
--- a/tools/bpf/bpftool/tracelog.c
+++ b/tools/bpf/bpftool/tracelog.c
@@ -57,10 +57,8 @@ find_tracefs_mnt_single(unsigned long magic, char *mnt, const char *mntpt)
 static bool get_tracefs_pipe(char *mnt)
 {
 	static const char * const known_mnts[] = {
-		"/sys/kernel/debug/tracing",
 		"/sys/kernel/tracing",
-		"/tracing",
-		"/trace",
+		"/sys/kernel/debug/tracing",
 	};
 	const char *pipe_name = "/trace_pipe";
 	const char *fstype = "tracefs";
@@ -96,11 +94,11 @@ static bool get_tracefs_pipe(char *mnt)
 
 	p_info("could not find tracefs, attempting to mount it now");
 	/* Most of the time, tracefs is automatically mounted by debugfs at
-	 * /sys/kernel/debug/tracing when we try to access it. If we could not
+	 * /sys/kernel/tracing when we try to access it. If we could not
 	 * find it, it is likely that debugfs is not mounted. Let's give one
 	 * attempt at mounting just tracefs at /sys/kernel/tracing.
 	 */
-	strcpy(mnt, known_mnts[1]);
+	strcpy(mnt, known_mnts[0]);
 	if (mount_tracefs(mnt))
 		return false;
 
-- 
2.43.0


