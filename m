Return-Path: <bpf+bounces-68393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0D4B57DAD
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 15:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490981AA24C7
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 13:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCE531D752;
	Mon, 15 Sep 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuTkTb4j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9031AF17
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943764; cv=none; b=kAwg4U3zZO9m1QWZR5I0Xoe3Y4Boijb7tKzJttSN82IwsXxbg6Ctp3oVUA+ABFycH11tMlBuG2rdwDZB1Y+Q3QMfEELU+5Z6Pj3eYNtDyDAwPcxKnxrX6QXDWXzjaBkE+gk8zMmC+Wpa4H0tpCnxKXEh1dJxD2658WbmhxQ2XHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943764; c=relaxed/simple;
	bh=erZuEyerCGfoLXbAbs1rFxxW+uqCP4CezBqIlHGLdGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjcL/LAnpmBm4Kz83D8xf7zNLsAJD+CIG8BK9oc6IBXxrGLUOMRmG5BWasYDv+k+a8uxVMOIfFW6P3n5M9pYyM5WUQRqBeVKr7CpO9r7kGNFm9sIHcNS/EYf+f6IERF97/0ijLBobqN/lFXvXiixUWGuB4pvX5rE+/V4YOxVNAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuTkTb4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0124FC4CEF1;
	Mon, 15 Sep 2025 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757943764;
	bh=erZuEyerCGfoLXbAbs1rFxxW+uqCP4CezBqIlHGLdGM=;
	h=From:To:Cc:Subject:Date:From;
	b=XuTkTb4je1tozHIqzmUc6KGyUG87bmKDRsnCHHyR3qVEEzulh/LkpKh6CgGrJHigJ
	 nqPDq+jjO9PAxODpprM0AdjUhSkTyL36ZVsptrwKiBmV7Yz6/bbxIVdG3wF7gdzMWu
	 ZhxVSfOL8V378+Z0S5Y2GvYm++T2U8uBinYvPzW44WmgeTwKUoCJtb4DaXEeXWnfzu
	 VXtl8Vzv0AdzMYeNpkBG3FLVbUJB9GvojLAtvRYU8TJES7sZTX6eEksBrmwzEqlvgK
	 R0MmuxSdzwlX1mhFTxNdb99itUtXu9PsEjAgg0JjavsuNk9lgqKWyzVqn8C+RM+RdJ
	 Cd8cd/DwBJ+Yg==
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
Subject: [PATCH bpf-next v2] bpftool: Search for tracefs at /sys/kernel/tracing first
Date: Mon, 15 Sep 2025 14:42:09 +0100
Message-ID: <20250915134209.36568-1-qmo@kernel.org>
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
v2: Remove outdated comment entirely
---
 tools/bpf/bpftool/tracelog.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/tracelog.c b/tools/bpf/bpftool/tracelog.c
index 31d806e3bdaa..573a8d99f009 100644
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
@@ -95,12 +93,7 @@ static bool get_tracefs_pipe(char *mnt)
 		return false;
 
 	p_info("could not find tracefs, attempting to mount it now");
-	/* Most of the time, tracefs is automatically mounted by debugfs at
-	 * /sys/kernel/debug/tracing when we try to access it. If we could not
-	 * find it, it is likely that debugfs is not mounted. Let's give one
-	 * attempt at mounting just tracefs at /sys/kernel/tracing.
-	 */
-	strcpy(mnt, known_mnts[1]);
+	strcpy(mnt, known_mnts[0]);
 	if (mount_tracefs(mnt))
 		return false;
 
-- 
2.43.0


