Return-Path: <bpf+bounces-60787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98036ADBE51
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 02:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE5B1892A53
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 00:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6DC188006;
	Tue, 17 Jun 2025 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqYotpPy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D35152E02
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 00:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750121839; cv=none; b=nwGCr3u3jAW4RfyW9uAWjv8npfQtizR9/e5ZDieThZF+Y952QeNbuFf9kv0MF80YtPli1HzauwrRf8jDCV/iOaB1VB/C+8YaEPCdGbLzPWvBvLNicNTJZZUI9zRu15rMb1vdSoGLmlxwkDaig4IF6hiDCHJlbFOpXKouy/hhQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750121839; c=relaxed/simple;
	bh=it27t5UESiB87PdHi/TPAl3e7hjTHwWgB2faka29GfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAOVXp7JqWLa9yXlwCSUapO6YVq7noPrnZilvMvow2grShvSouc11mEWwaMl1WgMRJ697ZxxMcoVyi9e7YybBGT1iOdoB37WuBDaHEgnMiDqDe7YNMsoSiaFutB/ycgKXoD1KYEQTIg4BsgoSBX35b9TMrFU/f9O9Ind4MaWzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqYotpPy; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-710ffc7a051so46196227b3.0
        for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 17:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750121835; x=1750726635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=my4dAmuCoJV7XQ1Zl0zd5TFdd9lYVQ+XN3PjHudIPdQ=;
        b=AqYotpPyCk5uM/ydZqgeVPsoglE61tXf2Sk466gBaiYzRTThoUwELHRQk5IazR6tGh
         SsKMy9oZlOqnIDyfCxjPAs9dKVl3zlGZvrkF6ifgWzgJRqiYOoK9wO+b38wjeKOpd1C9
         YLi9OvP3h7E0NUg7urEqT7CrLalwezFmhZEh5wLIOVkllr1MhLv6ViSdzpzh23/zrh7Y
         YEaC4d9+hYfFxxb4l9hD01NX3jTHR/4VUfaJfa760GnkpcibffurwbsOD97ilACQVMPL
         sTylpPdDLRSZhxzvMPweurjaoWEg3S/u8FNRZAmYEwhJVGA6R7dRMQUKo3SoTIkV269g
         dsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750121835; x=1750726635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=my4dAmuCoJV7XQ1Zl0zd5TFdd9lYVQ+XN3PjHudIPdQ=;
        b=Tl4HwgqcEPa+frq0GeWdoPRkDN9gQCRWr88jtjgmHEcgzJRkdoo7PuUPdxX7g75i9j
         9TH5nh4aZOtNlYeQQpWvr/Ly+eXc54hUxZz3iLmyhG45phl3YFAOoBPcQWv1K/k0/B93
         2wSg4HOCvfE6MKKy5TPqJTrPT0yFmHFypuCv3EvoszdIffX60casuhgNYrxd+z0R1OlO
         ny8YXuacyAh7L/O682ohs3N45ZRrlky60bv4rcfrpQMMqgiL171rYDwLWugpzcTu3RSg
         jRKMikj0jli2Pwbax+Lc5twjhwPVpt1PlAVaJpEnI7kdo1ZDFaqZSHQJe0paNp79MoIZ
         NBKA==
X-Gm-Message-State: AOJu0YzII49FaURAzSFAYGjvOJwwkK/T9j+fuS5V4sEhANapI9chXneY
	3pigqk3V9L1xne5f0xJppmAzzgU6sPWNrxAJ7fGD8khNlLmNO6eCdqLZFpWZPwVx
X-Gm-Gg: ASbGncsQEEhUYpAwRSqFezGsUOjZhZvhpOzdJ5gA097gk/bGIAcKrhqR1EXveFrYoio
	4wDmnrpqsBYbT4bD9MbpH8bMhbVBF45LBOwl2kiyfuVr+yRAStyHVOglyE+Tgx6B5BUD3Oaaeqx
	nEUBGYIR8kgDiwg4QzounkmRiW6/GN74ewyFKfrwdsRmGdbMaMrJ+yX/PtnNtiRn/PanryDHEWt
	i0jzrLdp2Y8Ukt+ws74F3hhximR2niR0Sb+jsuGMxFwn3kxvawkKZ+ZSPlStxa6tyKXxyS/eeYg
	VpGt8yPqEo+o3OQiZuy0voAsoQWcuZHLyugmW2gfgJhh2/pk98VY
X-Google-Smtp-Source: AGHT+IFAkHfa1AvP2lmobcGcNPdb5vs9e6c0RsieI7jbBbw7NBSmZBkPXbba1mOKaq1q4duQMkLRuQ==
X-Received: by 2002:a05:690c:680d:b0:70e:6333:64ac with SMTP id 00721157ae682-7117548a1ffmr160573417b3.10.1750121835136;
        Mon, 16 Jun 2025 17:57:15 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7118731313fsm8744207b3.118.2025.06.16.17.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 17:57:14 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	laoar.shao@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH bpf-next v3 1/1] selftests/bpf: more precise cpu_mitigations state detection
Date: Mon, 16 Jun 2025 17:57:10 -0700
Message-ID: <20250617005710.1066165-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250617005710.1066165-1-eddyz87@gmail.com>
References: <20250617005710.1066165-1-eddyz87@gmail.com>
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
e.g. when CONFIG_CPU_MITIGATIONS is disabled and boot parameter is
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
- via CONFIG_CPU_MITIGATIONS option.

This commit updates unpriv_helpers.c:get_mitigations_off() to scan
/boot/config-$(uname -r) and /proc/config.gz for
CONFIG_CPU_MITIGATIONS value in addition to boot command line check.

Tested using the following configurations:
- mitigations enabled (unpriv tests are enabled)
- mitigations disabled via boot cmdline (unpriv tests skipped)
- mitigations disabled via CONFIG_CPU_MITIGATIONS
  (unpriv tests skipped)

[1] https://lore.kernel.org/bpf/20231025031144.5508-1-laoar.shao@gmail.com/

Reported-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/unpriv_helpers.c | 93 +++++++++++++++++++-
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index 220f6a963813..3aa9ee80a55e 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -1,15 +1,75 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <errno.h>
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
+#include <sys/utsname.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <zlib.h>
 
 #include "unpriv_helpers.h"
 
-static bool get_mitigations_off(void)
+static gzFile open_config(void)
+{
+	struct utsname uts;
+	char buf[PATH_MAX];
+	gzFile config;
+
+	if (uname(&uts)) {
+		perror("uname");
+		goto config_gz;
+	}
+
+	snprintf(buf, sizeof(buf), "/boot/config-%s", uts.release);
+	config = gzopen(buf, "rb");
+	if (config)
+		return config;
+	fprintf(stderr, "gzopen %s: %s\n", buf, strerror(errno));
+
+config_gz:
+	config = gzopen("/proc/config.gz", "rb");
+	if (!config)
+		perror("gzopen /proc/config.gz");
+	return config;
+}
+
+static int config_contains(const char *pat)
+{
+	const char *msg;
+	char buf[1024];
+	gzFile config;
+	int n, err;
+
+	config = open_config();
+	if (!config)
+		return -1;
+
+	for (;;) {
+		if (!gzgets(config, buf, sizeof(buf))) {
+			msg = gzerror(config, &err);
+			if (err == Z_ERRNO)
+				perror("gzgets /proc/config.gz");
+			else if (err != Z_OK)
+				fprintf(stderr, "gzgets /proc/config.gz: %s", msg);
+			gzclose(config);
+			return -1;
+		}
+		n = strlen(buf);
+		if (buf[n - 1] == '\n')
+			buf[n - 1] = 0;
+		if (strcmp(buf, pat) == 0) {
+			gzclose(config);
+			return 1;
+		}
+	}
+	gzclose(config);
+	return 0;
+}
+
+static bool cmdline_contains(const char *pat)
 {
 	char cmdline[4096], *c;
 	int fd, ret = false;
@@ -27,7 +87,7 @@ static bool get_mitigations_off(void)
 
 	cmdline[sizeof(cmdline) - 1] = '\0';
 	for (c = strtok(cmdline, " \n"); c; c = strtok(NULL, " \n")) {
-		if (strncmp(c, "mitigations=off", strlen(c)))
+		if (strncmp(c, pat, strlen(c)))
 			continue;
 		ret = true;
 		break;
@@ -37,8 +97,21 @@ static bool get_mitigations_off(void)
 	return ret;
 }
 
+static int get_mitigations_off(void)
+{
+	int enabled_in_config;
+
+	if (cmdline_contains("mitigations=off"))
+		return 1;
+	enabled_in_config = config_contains("CONFIG_CPU_MITIGATIONS=y");
+	if (enabled_in_config < 0)
+		return -1;
+	return !enabled_in_config;
+}
+
 bool get_unpriv_disabled(void)
 {
+	int mitigations_off;
 	bool disabled;
 	char buf[2];
 	FILE *fd;
@@ -52,5 +125,19 @@ bool get_unpriv_disabled(void)
 		disabled = true;
 	}
 
-	return disabled ? true : get_mitigations_off();
+	if (disabled)
+		return true;
+
+	/*
+	 * Some unpriv tests rely on spectre mitigations being on.
+	 * If mitigations are off or status can't be determined
+	 * assume that unpriv tests are disabled.
+	 */
+	mitigations_off = get_mitigations_off();
+	if (mitigations_off < 0) {
+		fprintf(stderr,
+			"Can't determine if mitigations are enabled, disabling unpriv tests.");
+		return true;
+	}
+	return mitigations_off;
 }
-- 
2.47.1


