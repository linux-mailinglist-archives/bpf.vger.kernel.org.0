Return-Path: <bpf+bounces-34725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D329303EC
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 07:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4805C2824E9
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 05:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF9F200A0;
	Sat, 13 Jul 2024 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsuqZGuR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA611CAB5
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850176; cv=none; b=Nhlg5IOwocsi7nHq/LXKO92lES70oTI0SwWpAS0vz6VTH0ljHwY1nMK6eyNElL/Pw39v/4dOOH2d/64Hz0GY/fJMOEcYflynaCf4xzjIurVqK2DMpFqS8m5KTiqYrY7dR9ZuNRHLAW8eCl3wIl6sgFloCqJZDYlH41lEVOpiX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850176; c=relaxed/simple;
	bh=MEyjrM9VGJUQBd/B9NZhBJDoxpMXlgJazNUySD3I4Ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jJyZHqhvnyPPcA9FHK5F8C6BGD4/3PKSBCJY2zHqhcpsfbOvydjcr+6uGhfUsNVmb/3IRq3OcKz/TPTICm6dHsHOyVokxV99xjNwD1PmzSvRpudSxh+SC24VWv5zk4NgmZwNijbSoppHy7pVV9NwwEXXgUVsVzNZ4OkP+uDuKyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsuqZGuR; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e057ae1adbeso2070398276.0
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 22:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850173; x=1721454973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4jrDVvRScQJn3SQpX4VDmp2a9Cda2Pz6eZWzHp+x6I=;
        b=PsuqZGuRT/fK5+XeqvLVms5ChGOVEcMN1DWiANEPy7WPKskv97tCH/PaeSA1L3g8xj
         bftdGmRSiZka2m3Ms+X9Jy81y6Jz50Phk/Mz6BA/w8vX0LZjRSTBzhid5N+QoqWnBcIw
         TI47RnBpB+KNUbQwtVscwfANxqziuLedMokslPD/SNriAOxmnvQT+2J+xJSlKX1hDr6N
         0sqRinWk94bXJ3DH9AmaQHNifS0DdtUgb6ePkYS7HgttwPE73NqEYuciQHn635Okvt+K
         BXPkYURBfs6iSkVfgM2H6QDEnkJGNXMYfO7KeCG9/RVD5S1sN/SOo1cMUkiDV4Xfx0zE
         CXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850173; x=1721454973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4jrDVvRScQJn3SQpX4VDmp2a9Cda2Pz6eZWzHp+x6I=;
        b=Huh5+Ydsha+FMsPwImUnNf4dBvLq5jzpxNYB1rxbP/9nFjKXoyJYYTyxv+i3CiuNIl
         rgDGeXHlAlJFjbKRFO7nH3RfOsSJWYkZMCHA0gO252A1ZhA+6SHaIm5xiKnDPUJgYspq
         66YmosQea13yXBW/Tx1c1ggUwqijPqjgdWAiOp6QUsLZZQel2gA8oytOznT/bYE+zidh
         YNEZZg3IMotvi67L+WX7sHqNEEsBiIMc0guRiJeM6X9JUN6bJe+98qrtjVedqxyuWRqU
         RdgPDxV6ytbRyUmrsOZFSHqZ3YZ0yAjKln1+RQNTp1plcWX9IkEwQDxiMKuVOnBHugV8
         xPRA==
X-Gm-Message-State: AOJu0Yzxv3FzIExYbU4uvBIi2lqohwNMTFJ+pcDHVTXIxiH4O0JeSB2r
	nOt1z0r2PJa0ZT+TJFzBufC4tYpahK9YkVpgqZnW/MS4wln2EVcyrwr1j6CU
X-Google-Smtp-Source: AGHT+IE9rlR19YZpjdMFqmdNlZnhr3T/ZvDvax47lRFek8iSesd2EQRJtkLHQgwIvfEAhcXuBqaS9g==
X-Received: by 2002:a0d:ea47:0:b0:65f:7c41:30b2 with SMTP id 00721157ae682-65f7c413160mr7015097b3.3.1720850173462;
        Fri, 12 Jul 2024 22:56:13 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1e:9d09:4e82:b45e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-65fc445165dsm761927b3.105.2024.07.12.22.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:56:13 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 1/4] selftests/bpf: Add traffic monitor functions.
Date: Fri, 12 Jul 2024 22:55:49 -0700
Message-Id: <20240713055552.2482367-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713055552.2482367-1-thinker.li@gmail.com>
References: <20240713055552.2482367-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions that run tcpdump in the background, report the traffic log
captured by tcpdump, and stop tcpdump. They are supposed to be used for
debugging flaky network test cases. A monitored test case should call
traffic_monitor_start() to start a tcpdump process in the background for a
given namespace, call traffic_monitor_report() to print the log from
tcpdump, and call traffic_monitor_stop() to shutdown the tcpdump process.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 244 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |   5 +
 2 files changed, 249 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 44c2c8fa542a..cf0e03f3b95c 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -12,6 +12,8 @@
 #include <sys/mount.h>
 #include <sys/stat.h>
 #include <sys/un.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 
 #include <linux/err.h>
 #include <linux/in.h>
@@ -575,6 +577,248 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
 	return 0;
 }
 
+struct tmonitor_ctx {
+	pid_t pid;
+	const char *netns;
+	char log_name[PATH_MAX];
+};
+
+/* Make sure that tcpdump has handled all previous packets.
+ *
+ * Send one or more UDP packets to the loopback interface. The packet
+ * contains a mark string. The mark is used to check if tcpdump has handled
+ * the packet. The function waits for tcpdump to print a message for the
+ * packet containing the mark (by checking the payload length and the
+ * destination). This is not a perfect solution, but it should be enough
+ * for testing purposes.
+ *
+ * log_name is the file name where tcpdump writes its output.
+ * mark is the string that is sent in the UDP packet.
+ * repeat specifies if the function should send multiple packets.
+ *
+ * Device "lo" should be up in the namespace for this to work.  This
+ * function should be called in the same network namespace as a
+ * tmonitor_ctx created for in order to create a socket for sending mark
+ * packets.
+ */
+static int traffic_monitor_sync(const char *log_name, const char *mark,
+				bool repeat)
+{
+	const int max_loop = 1000; /* 10s */
+	char mark_pkt_pattern[64];
+	struct sockaddr_in addr;
+	int sock, log_fd, rd_pos = 0;
+	int pattern_size;
+	struct stat st;
+	char buf[4096];
+	int send_cnt = repeat ? max_loop : 1;
+	bool found;
+	int i, n;
+
+	sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0) {
+		log_err("Failed to create socket");
+		return -1;
+	}
+
+	/* Check only the destination and the payload length */
+	pattern_size = snprintf(mark_pkt_pattern, sizeof(mark_pkt_pattern),
+				" > 127.0.0.241.4321: UDP, length %ld",
+				strlen(mark));
+
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = inet_addr("127.0.0.241");
+	addr.sin_port = htons(4321);
+
+	/* Wait for the log file to be created */
+	for (i = 0; i < max_loop; i++) {
+		log_fd = open(log_name, O_RDONLY);
+		if (log_fd >= 0) {
+			fstat(log_fd, &st);
+			rd_pos = st.st_size;
+			break;
+		}
+		usleep(10000);
+	}
+	/* Wait for the mark packet */
+	for (found = false; i < max_loop && !found; i++) {
+		if (send_cnt-- > 0) {
+			/* Send an UDP packet */
+			if (sendto(sock, mark, strlen(mark), 0,
+				   (struct sockaddr *)&addr,
+				   sizeof(addr)) != strlen(mark))
+				log_err("Failed to sendto");
+		}
+
+		usleep(10000);
+		fstat(log_fd, &st);
+		/* Check the content of the log file */
+		while (rd_pos + pattern_size <= st.st_size) {
+			lseek(log_fd, rd_pos, SEEK_SET);
+			n = read(log_fd, buf, sizeof(buf) - 1);
+			if (n < pattern_size)
+				break;
+			buf[n] = 0;
+			if (strstr(buf, mark_pkt_pattern)) {
+				found = true;
+				break;
+			}
+			rd_pos += n - pattern_size + 1;
+		}
+	}
+
+	close(log_fd);
+	close(sock);
+
+	if (!found) {
+		log_err("Waited too long for synchronizing traffic monitor");
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Start a tcpdump process to monitor traffic.
+ *
+ * netns specifies what network namespace you want to monitor. It will
+ * monitor the current namespace if netns is NULL.
+ */
+struct tmonitor_ctx *traffic_monitor_start(const char *netns)
+{
+	struct tmonitor_ctx *ctx = NULL;
+	struct nstoken *nstoken = NULL;
+	char log_name[PATH_MAX];
+	int status, log_fd;
+	pid_t pid;
+
+	if (netns) {
+		nstoken = open_netns(netns);
+		if (!nstoken)
+			return NULL;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_err("Failed to fork");
+		goto error;
+	}
+
+	if (pid == 0) {
+		/* Child */
+		pid = getpid();
+		snprintf(log_name, sizeof(log_name), "/tmp/tmon_tcpdump_%d.log", pid);
+		log_fd = open(log_name, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+		dup2(log_fd, STDOUT_FILENO);
+		dup2(log_fd, STDERR_FILENO);
+		if (log_fd != STDOUT_FILENO && log_fd != STDERR_FILENO)
+			close(log_fd);
+
+		/* -n don't convert addresses to hostnames.
+		 *
+		 * --immediate-mode handle captured packets immediately.
+		 *
+		 * -l print messages with line buffer. With this option,
+		 * the output will be written at the end of each line
+		 * rather than when the output buffer is full. This is
+		 * needed to sync with tcpdump efficiently.
+		 */
+		execlp("tcpdump", "tcpdump", "-i", "any", "-n", "--immediate-mode", "-l", NULL);
+		log_err("Failed to exec tcpdump");
+		exit(1);
+	}
+
+	ctx = malloc(sizeof(*ctx));
+	if (!ctx) {
+		log_err("Failed to malloc ctx");
+		goto error;
+	}
+
+	ctx->pid = pid;
+	ctx->netns = netns;
+	snprintf(ctx->log_name, sizeof(ctx->log_name), "/tmp/tmon_tcpdump_%d.log", pid);
+
+	/* Wait for tcpdump to be ready */
+	if (traffic_monitor_sync(ctx->log_name, "hello", true)) {
+		status = 0;
+		if (waitpid(pid, &status, WNOHANG) >= 0 &&
+		    !WIFEXITED(status) && !WIFSIGNALED(status))
+			log_err("Wait too long for tcpdump");
+		else
+			log_err("Fail to start tcpdump");
+		goto error;
+	}
+
+	close_netns(nstoken);
+
+	return ctx;
+
+error:
+	close_netns(nstoken);
+	if (pid > 0) {
+		kill(pid, SIGTERM);
+		waitpid(pid, NULL, 0);
+		snprintf(log_name, sizeof(log_name), "/tmp/tmon_tcpdump_%d.log", pid);
+		unlink(log_name);
+	}
+	free(ctx);
+
+	return NULL;
+}
+
+void traffic_monitor_stop(struct tmonitor_ctx *ctx)
+{
+	if (!ctx)
+		return;
+	kill(ctx->pid, SIGTERM);
+	/* Wait the tcpdump process in case that the log file is created
+	 * after this line.
+	 */
+	waitpid(ctx->pid, NULL, 0);
+	unlink(ctx->log_name);
+	free(ctx);
+}
+
+/* Report the traffic monitored by tcpdump.
+ *
+ * The function reads the log file created by tcpdump and writes the
+ * content to stderr.
+ */
+void traffic_monitor_report(struct tmonitor_ctx *ctx)
+{
+	struct nstoken *nstoken = NULL;
+	char buf[4096];
+	int log_fd, n;
+
+	if (!ctx)
+		return;
+
+	/* Make sure all previous packets have been handled by
+	 * tcpdump.
+	 */
+	if (ctx->netns) {
+		nstoken = open_netns(ctx->netns);
+		if (!nstoken) {
+			log_err("Failed to open netns: %s", ctx->netns);
+			goto out;
+		}
+	}
+	traffic_monitor_sync(ctx->log_name, "sync for report", false);
+	close_netns(nstoken);
+
+	/* Read the log file and write to stderr */
+	log_fd = open(ctx->log_name, O_RDONLY);
+	if (log_fd < 0) {
+		log_err("Failed to open log file");
+		return;
+	}
+
+	while ((n = read(log_fd, buf, sizeof(buf))) > 0)
+		fwrite(buf, n, 1, stderr);
+
+out:
+	close(log_fd);
+}
+
 struct send_recv_arg {
 	int		fd;
 	uint32_t	bytes;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 9ea36524b9db..d757e495fb39 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -72,6 +72,11 @@ int get_socket_local_port(int sock_fd);
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
+struct tmonitor_ctx;
+struct tmonitor_ctx *traffic_monitor_start(const char *netns);
+void traffic_monitor_stop(struct tmonitor_ctx *ctx);
+void traffic_monitor_report(struct tmonitor_ctx *ctx);
+
 struct nstoken;
 /**
  * open_netns() - Switch to specified network namespace by name.
-- 
2.34.1


