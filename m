Return-Path: <bpf+bounces-60242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B2DAD450C
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 23:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC0F177A3E
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 21:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7DE283138;
	Tue, 10 Jun 2025 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEiE4Fm8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E11DD9D3
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592352; cv=none; b=TpJPI4SgmNG9BsW7hCrkuacg+Y7+/2GU/y2DYceAxFGVY6ulzlROhV0pXDdIpFTrL8GAUVJ1brvXstZu1csfhyt56ux5WEKCylOwh9ox/3G+sN6bn1PL0+3DTXS1u54E612H5xIYQB0kVfT0o9crLBMO71mOhWoIVQoSzaG5A0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592352; c=relaxed/simple;
	bh=dmx/2Ahpx1NcM9OhYDInW+o2Lsmr4ZRv2tXie4El0iU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvVfIS+IjJohVxaHlrJ0iFJNdL4+bnLoiJCjXaxkKmZk5qoMHBW21ntrXlrvvRkzotprvWnXLmIG4x9Poyd1eKOgyftHGr7GaJSTh3B0QmH8IjuArvR8uEyK9xxd4Bt+jwL1PAHJc2ihvoMKbO31MadHo0kvNzDyeEHgYznKv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEiE4Fm8; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e81f311a86fso1234975276.3
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749592349; x=1750197149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X7Dy+XMCp2eegTp6LjXFjKnkNwCF2ho2mg8UrlJemoY=;
        b=lEiE4Fm8H4GN3li2XOonFcm6UWiRfc8qqMznndmAbvfze/SKiVcnHRkqFWYwDGxKbe
         E7jAsb0xAiswcp4KDhzrPOuC5aalRb0XBnhVoRS3fcosIlgpcDnIazQ8U45s6vGO6KH5
         pDpY9bhpuGvhpJvEZv58cVtQ2QytLtGzmCQtJrPaXw5+Bvqzhsp2MZh7z+crrW/wGSUF
         wx441C4Z33Mw8QhUrxHDe5uPBn33VcCvqMF+XKAQDSfnZ2a0u+evuLMi7I1EoD2jRnTz
         fBSBK3dnHd00+Qmfwd9KDcEF2db3ZQgpJS6w9B/nKFle+mZ2CTG2neG1kSO+JPnihw1m
         F1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749592349; x=1750197149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7Dy+XMCp2eegTp6LjXFjKnkNwCF2ho2mg8UrlJemoY=;
        b=L7VbKWsmBsTz0cJtGHTISHgOxZM3QnybOyx0zB42K+ztB0irVP7ap1YCI8ZPgL3v7J
         HsA7Ol1En1OeQjk0z0LqN1aQ3CXZ0SEWhzYMTPgZN+3XPG/UTrf4tz2OkLDDaAnpYI4l
         /aQv5yRd5vlvPLZ9wHSrkaydVfJoj4cJyHYbLwwdXlYaNSBn/ziwLYHrAs2l9VUuLdvk
         uiXgsfz3PKUuUf+QMoPdX1dg8T3fHF0Ti6/Qn2S28+A6eNaE204HT2LCWmuTLrgQUMw6
         u7vG4ZWqq7+eOT2mwnkASWal+Is6De1dMBymUVbxo8bPv1grmHW3/p07lv+kgp4fYpun
         FaCg==
X-Gm-Message-State: AOJu0YyL1aknYZD3fS+apBsR09+TsTFtUiBdNzPnODxQsXI/0p+n9mxi
	yWm6TmoaeyCUnY5njtstYoPURx//BtkJB7AB9J7T92Vlh6y2jWTj1tTcRMYjaUGc
X-Gm-Gg: ASbGncu8qZ87SZtEfRCeVHYQF8pf3BhznvGZOSFl5Rj9G+nVy0YKgb0agOwj2ek2/AN
	q+T8D/zhesp57gyF6Px4F1W/ph0/xhPm/7A8coekbIJ9YNK7ob4vxArxgrpbo7Dp2BMCVvXxqyr
	cDjcWfB7oeJSWUhECyk7A6V9ovoerwRx2NofiV+TWEzskwvVC1M6uCxTqyG1l2ze7sFzG2g9+Ku
	kbbMivKqZTFiYX53cXrmTDWxE6+9eD2IuKGmc8DmdLrD4QEwCGiX9xh6MCsMEgQPSxh5iID3mVv
	h3iXKA3hMJEQEuaV+4L/4ElDdFvm4kJzT29kqqZSKeQiDucWcOk9Qg==
X-Google-Smtp-Source: AGHT+IHJEgWG6RGaro5tkU1J1eVyaY739G6tVUKndFkjHA4IdoXehAhWg9LBCRNsCe0f2YdaT2GPiA==
X-Received: by 2002:a05:6902:2e09:b0:e81:b843:43f6 with SMTP id 3f1490d57ef6-e81fe6a7d3fmr1605444276.21.1749592349377;
        Tue, 10 Jun 2025 14:52:29 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e81e7ad68a6sm1174494276.3.2025.06.10.14.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:52:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	mykyta.yatsenko5@gmail.com,
	laoar.shao@gmail.com
Subject: [PATCH bpf-next] selftests/bpf: more precise cpu_mitigations state detection
Date: Tue, 10 Jun 2025 14:52:21 -0700
Message-ID: <20250610215221.846484-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_progs and test_verifier binaries execute unpriv tests under the
following conditions:
- unpriv BPF is enabled;
- CPU mitigations are enabled (see [1] for details).

The detection of the "mitigations enabled" state is performed by
unpriv_helpers.c:get_mitigations_off() via inspecting kernel boot
command line, looking for a parameter "mitigations=off".

Such detection scheme won't work for certain configurations,
e.g. when CONFIG_CPU_MIGITGATIONS is disabled and boot parameter is
not supplied.

Miss-detection leads to test_progs executing tests meant to be run
only with mitigations enabled, e.g.
verifier_and.c:known_subreg_with_unknown_reg(), and reporting false
failures.

Internally, verifier sets bpf_verifier_env->bypass_spec_{v1,v4}
basing on the value returned by kernel/cpu.c:cpu_mitigations_off().
This function is backed by a variable kernel/cpu.c:cpu_mitigations.

This state is not fully introspect-able via sysfs. The closest proxy
is /sys/devices/system/cpu/vulnerabilities/spectre_v1, but it reports
"vulnerable" state only if mitigations are disabled *and* current cpu
is vulnerable, while verifier does not check cpu state.

There are only two ways the kernel/cpu.c:cpu_mitigations can be set:
- via boot parameter;
- via CONFIG_CPU_MIGITGATIONS option.

This commit updates unpriv_helpers.c:get_mitigations_off() to scan
/proc/config.gz for CONFIG_CPU_MIGITGATIONS value in addition to boot
command line check.

Tested using the following configurations:
- mitigations enabled (unpriv tests are enabled)
- mitigations disabled via boot cmdline (unpriv tests skipped)
- mitigations disabled via CONFIG_CPU_MIGITGATIONS
  (unpriv tests skipped)

[1] https://lore.kernel.org/bpf/20231025031144.5508-1-laoar.shao@gmail.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/unpriv_helpers.c | 45 +++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index 220f6a963813..1dec3c6b3d70 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -6,10 +6,46 @@
 #include <string.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <zlib.h>
 
 #include "unpriv_helpers.h"
 
-static bool get_mitigations_off(void)
+static bool scan_config(const char *pat)
+{
+	bool ret = false;
+	const char *msg;
+	char buf[1024];
+	gzFile config;
+	int n, err;
+
+	config = gzopen("/proc/config.gz", "rb");
+	if (!config) {
+		perror("gzopen /proc/config.gz");
+		goto out;
+	}
+	for (;;) {
+		if (!gzgets(config, buf, sizeof(buf))) {
+			msg = gzerror(config, &err);
+			if (err == Z_ERRNO)
+				perror("gzgets /proc/config.gz");
+			else if (err != Z_OK)
+				fprintf(stderr, "gzgets /proc/config.gz: %s", msg);
+			goto out;
+		}
+		n = strlen(buf);
+		if (buf[n - 1] == '\n')
+			buf[n - 1] = 0;
+		if (strcmp(buf, pat) == 0) {
+			ret = true;
+			goto out;
+		}
+	}
+out:
+	gzclose(config);
+	return ret;
+}
+
+static bool scan_cmdline(const char *pat)
 {
 	char cmdline[4096], *c;
 	int fd, ret = false;
@@ -27,7 +63,7 @@ static bool get_mitigations_off(void)
 
 	cmdline[sizeof(cmdline) - 1] = '\0';
 	for (c = strtok(cmdline, " \n"); c; c = strtok(NULL, " \n")) {
-		if (strncmp(c, "mitigations=off", strlen(c)))
+		if (strncmp(c, pat, strlen(c)))
 			continue;
 		ret = true;
 		break;
@@ -37,6 +73,11 @@ static bool get_mitigations_off(void)
 	return ret;
 }
 
+static bool get_mitigations_off(void)
+{
+	return scan_cmdline("mitigations=off") || !scan_config("CONFIG_CPU_MITIGATIONS=y");
+}
+
 bool get_unpriv_disabled(void)
 {
 	bool disabled;
-- 
2.47.1


