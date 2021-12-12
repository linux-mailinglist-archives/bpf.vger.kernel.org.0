Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7FC471A75
	for <lists+bpf@lfdr.de>; Sun, 12 Dec 2021 14:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhLLNrg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Dec 2021 08:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhLLNrf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Dec 2021 08:47:35 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5B7C061714
        for <bpf@vger.kernel.org>; Sun, 12 Dec 2021 05:47:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id e3so44830011edu.4
        for <bpf@vger.kernel.org>; Sun, 12 Dec 2021 05:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CiSpeKrc6xdYQkaSsrV1saCX+tLWJIyEe2AX2g4FsfY=;
        b=ulXWmXYH8stsLnZOejOmSZSyeTh0HECoohO+a4rGro7VxdhFGeTSbSpdkZiikNDQAa
         BJp/CtQQveMhJwiLLfiWtnjVT91BnXMuDq3W6dD/uiGOcYRj3DgsJICtCbRtDQqZ8v2A
         pooR5iHRk7nxRaylbwRV9wpCgx3rOtnmF6r31KHyp8l4oQKf6IrktXzathKEF08WX1o2
         9AX5b3TvOe9JlvTFhMQIObJg5d1fDCUxYh1Fhy0R3CqC5a0O+dfG3f9pLb8c+VH3CwTb
         tWvG70NjiHsK6M2Ea1d00xkeo+5XbhIIEZId81CW6346jHUlJ6LHjaXS9pJ+74FwI3vD
         Fwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CiSpeKrc6xdYQkaSsrV1saCX+tLWJIyEe2AX2g4FsfY=;
        b=wgqnfxNcCaYYCv5VgGEff0p+0EDvuqEyqLslR1JcXmbnhc/GGKkhlMC1wby3AXN8UF
         LTOVHv87vIdFjVnv0Sz+WQCplLj3Qt6IPAdHbvHwEQ7HM4aPcyrNF6BJs9Ejkw6S5VQI
         4gq4l7EpfVgzhOQcj6sb3PLcyyH1wvbP5gEMcDiMo+ildp8aEpqQ57IKKgTVUc/8UqZ7
         E1FaMu2nglFnV5lZ+900sKAtQ8X2/1sPpPum4hLJ2q/cxZ3C1bKDrXH3thalXsnIyTOf
         zkqXSLO5VBKJ2rlECikjbRnM6VUSOszNJhBgirIYZhuJ28Jrirq/Tf/t4E54zOXhvBGK
         21HQ==
X-Gm-Message-State: AOAM533iMMHzo7QY3rqWeSpeA+waBWZpJ+e0x2Eg8X8B4f0dtBE/BWfZ
        WjKkXVg7ye/QeyfIzBaA1XbKFw==
X-Google-Smtp-Source: ABdhPJxbZDcMAGyCRfoQKuWsGxx685XQpDHyN9I0NfvgAcYf1nJUdb72Q3Ihv9iHIsidz8HWrql1mg==
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr55160604edd.169.1639316853318;
        Sun, 12 Dec 2021 05:47:33 -0800 (PST)
Received: from localhost ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id r13sm4669936edo.71.2021.12.12.05.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 05:47:33 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/2] perf namespaces: Add helper nsinfo__is_in_root_namespace()
Date:   Sun, 12 Dec 2021 21:47:20 +0800
Message-Id: <20211212134721.1721245-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211212134721.1721245-1-leo.yan@linaro.org>
References: <20211212134721.1721245-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactors code for gathering PID infos, it creates the function
nsinfo__get_nspid() to parse process 'status' node in folder '/proc'.

Base on the refactoring, this patch introduces a new helper
nsinfo__is_in_root_namespace(), it returns true when the caller runs in
the root PID namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/namespaces.c | 76 ++++++++++++++++++++++--------------
 tools/perf/util/namespaces.h |  2 +
 2 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 608b20c72a5c..48aa3217300b 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -60,17 +60,49 @@ void namespaces__free(struct namespaces *namespaces)
 	free(namespaces);
 }
 
+static int nsinfo__get_nspid(struct nsinfo *nsi, const char *path)
+{
+	FILE *f = NULL;
+	char *statln = NULL;
+	size_t linesz = 0;
+	char *nspid;
+
+	f = fopen(path, "r");
+	if (f == NULL)
+		return -1;
+
+	while (getline(&statln, &linesz, f) != -1) {
+		/* Use tgid if CONFIG_PID_NS is not defined. */
+		if (strstr(statln, "Tgid:") != NULL) {
+			nsi->tgid = (pid_t)strtol(strrchr(statln, '\t'),
+						     NULL, 10);
+			nsi->nstgid = nsi->tgid;
+		}
+
+		if (strstr(statln, "NStgid:") != NULL) {
+			nspid = strrchr(statln, '\t');
+			nsi->nstgid = (pid_t)strtol(nspid, NULL, 10);
+			/*
+			 * If innermost tgid is not the first, process is in a different
+			 * PID namespace.
+			 */
+			nsi->in_pidns = (statln + sizeof("NStgid:") - 1) != nspid;
+			break;
+		}
+	}
+
+	fclose(f);
+	free(statln);
+	return 0;
+}
+
 int nsinfo__init(struct nsinfo *nsi)
 {
 	char oldns[PATH_MAX];
 	char spath[PATH_MAX];
 	char *newns = NULL;
-	char *statln = NULL;
-	char *nspid;
 	struct stat old_stat;
 	struct stat new_stat;
-	FILE *f = NULL;
-	size_t linesz = 0;
 	int rv = -1;
 
 	if (snprintf(oldns, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
@@ -100,34 +132,9 @@ int nsinfo__init(struct nsinfo *nsi)
 	if (snprintf(spath, PATH_MAX, "/proc/%d/status", nsi->pid) >= PATH_MAX)
 		goto out;
 
-	f = fopen(spath, "r");
-	if (f == NULL)
-		goto out;
-
-	while (getline(&statln, &linesz, f) != -1) {
-		/* Use tgid if CONFIG_PID_NS is not defined. */
-		if (strstr(statln, "Tgid:") != NULL) {
-			nsi->tgid = (pid_t)strtol(strrchr(statln, '\t'),
-						     NULL, 10);
-			nsi->nstgid = nsi->tgid;
-		}
-
-		if (strstr(statln, "NStgid:") != NULL) {
-			nspid = strrchr(statln, '\t');
-			nsi->nstgid = (pid_t)strtol(nspid, NULL, 10);
-			/* If innermost tgid is not the first, process is in a different
-			 * PID namespace.
-			 */
-			nsi->in_pidns = (statln + sizeof("NStgid:") - 1) != nspid;
-			break;
-		}
-	}
-	rv = 0;
+	rv = nsinfo__get_nspid(nsi, spath);
 
 out:
-	if (f != NULL)
-		(void) fclose(f);
-	free(statln);
 	free(newns);
 	return rv;
 }
@@ -299,3 +306,12 @@ int nsinfo__stat(const char *filename, struct stat *st, struct nsinfo *nsi)
 
 	return ret;
 }
+
+bool nsinfo__is_in_root_namespace(void)
+{
+	struct nsinfo nsi;
+
+	memset(&nsi, 0x0, sizeof(nsi));
+	nsinfo__get_nspid(&nsi, "/proc/self/status");
+	return !nsi.in_pidns;
+}
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index ad9775db7b9c..9ceea9643507 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -59,6 +59,8 @@ void nsinfo__mountns_exit(struct nscookie *nc);
 char *nsinfo__realpath(const char *path, struct nsinfo *nsi);
 int nsinfo__stat(const char *filename, struct stat *st, struct nsinfo *nsi);
 
+bool nsinfo__is_in_root_namespace(void);
+
 static inline void __nsinfo__zput(struct nsinfo **nsip)
 {
 	if (nsip) {
-- 
2.25.1

