Return-Path: <bpf+bounces-60658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69710AD9A27
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 07:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A82176BAA
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 05:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680DA1DC9BB;
	Sat, 14 Jun 2025 05:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFx3AHek"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F34C72632
	for <bpf@vger.kernel.org>; Sat, 14 Jun 2025 05:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749877590; cv=none; b=maJ3OAX2lBqeQGzRGGOF0BBolqt6kvlEMnxt2XZrJ7OSzIAU9ygY1sdylBzf8YqjaN0xqUzHWRjOOvy2OWEbHLulMWNEaBfFVAlgcbq67KbJam/1Jhmkq0RR34WLIK/aqqHywtILJ7puyOmM6J/79BN5B/AbVQbuqWv9iaVQlv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749877590; c=relaxed/simple;
	bh=5i/X1kQ66pozXskitRIVi9Stp+9B/Uw7NlMIRkBdbRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kbyg4HtgwgqoN/d5aHftjYg2LDC/N2i7xrDNXWV3Zex1feAP+ATWnNIvVBWbmVp70nwvqocvZdDIdTrNYNZ6jdUwFNdmz+3JyZVQvVDjWCzzt85zerzctifz4kH2gnUJmjm/w94LSNZJWITLUnRqmMUf1ETkG6Rktt5EPnWJ8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFx3AHek; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70f147b5a52so20003387b3.3
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 22:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749877587; x=1750482387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJtT1bMfnbTvzRgJT9Ve+OHRu3PyRODOtLqriCkUh4U=;
        b=mFx3AHek/82QoFIasELmV5Y5sjIajYDu/5lTzEb403ZZdn4Q08hPi+SjhLlxOLoA8f
         nhTA78PXE3vKr2rUHgEl27gYO1JkyEN0NVhTpnYnkXegxITwknquusfqsb5OVuQmMhA9
         oSnWI9IT36ENmgLXFy/H4yfV6ljc9xYotISa+3T1hEHHuAZX8yyRAQjZp0rYLLV0jyD6
         x+7qAgvgZ4QyyNCNelkO/+Ayi8NJNJeKMeqjFkKjtHslST0/64Gyy7KcwqDfmgye0oFs
         CXIyTmveC1yLwkvbRN7fJyT0zVmPd1FiRtaotmxYjA4Ibe5mziFmM4Ogid076+/TvJln
         05DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749877587; x=1750482387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJtT1bMfnbTvzRgJT9Ve+OHRu3PyRODOtLqriCkUh4U=;
        b=Jrc1snLAImEfS2FXKf79aH6kIAufYbNIoDyms/V7qcob93mqKlQI+cpmpwCqWNxjuf
         oOq3FBa2w+fhF1WtuZMqRQDPuw20W+3jJrciaW7F1ALVYgSiwWmJwLOwvDnC6q+scJEe
         89UzbPu6eDxCmbxNhyQVLh7/XWIpisJmP+3lp93OmMSQ6jCR0NbWf85s8VG+tldfevWn
         I0fIXcdUYXP0CItF2TNYyjT0Do+17ofktDKRkHuqypkSLya+Fit7Bq3fcVp4lyq6zimq
         oyyjWau8BVI7j8ZAGj/UDv1CIlrl9MOHgjeZl23xlkw4HGaOIyrNb4jSz4N9hf00q3IL
         qYrA==
X-Gm-Message-State: AOJu0Yw1SSWrV0O6TeZWGhAZ90Kaga59jbV4rYaT53qXep1Vey/Xlx2i
	tJBund0oIlDYUWcsO9EdA5UlIV0/GWPUtX4ut2tm9Fb12juIbxNAiiXEI+Sdd/Qv
X-Gm-Gg: ASbGnctxL/mMuQnCu8Q7Zad0bCIFMeYk+U3DvziQb97Z1oQc0uK5TaUxhZ8SRvDRyN8
	BH7bkamC3ytMUMCNqgMyLW/1DHGEv79eKFR6ZklXg/LNUU5TWzm+oUCZxhGBC2aDmXL/JZ+B2Rc
	de+xp4QrkkB05sl5OKA4lblyq/iUrD9ErwMtDDVQaa3zSzVTjHnDjyCkTiIiOM0DI4kPjT+CjqI
	BbgnpjdEh5g4wQIcYUYYQ2Vufs+PWZNeQTNH1Z4/spyV6Hm87tApfOIrQRsP0ZdeFntz7+3yzsK
	DM3tsaQwVqr2lN7VKVxoRMK141A9HDpgg0u18e346+W+rkOyGu0Z/Q==
X-Google-Smtp-Source: AGHT+IGEYGyp/id9r9NbVlBzh9N7msKkb/WTlP6S4+yEH973H6P7/Rap7AvjNSeCXGoGs6U8bzGZXQ==
X-Received: by 2002:a05:690c:3503:b0:70e:1874:b915 with SMTP id 00721157ae682-7117538e15emr33740337b3.10.1749877587026;
        Fri, 13 Jun 2025 22:06:27 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7117c057091sm277077b3.46.2025.06.13.22.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 22:06:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/1] selftests/bpf: more precise cpu_mitigations state detection
Date: Fri, 13 Jun 2025 22:06:17 -0700
Message-ID: <20250614050617.4161083-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250614050617.4161083-1-eddyz87@gmail.com>
References: <20250614050617.4161083-1-eddyz87@gmail.com>
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
 tools/testing/selftests/bpf/unpriv_helpers.c | 94 +++++++++++++++++++-
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index 220f6a963813..625556a0e7f1 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -1,15 +1,76 @@
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
+	int n, err, ret = -1;
+	const char *msg;
+	char buf[1024];
+	gzFile config;
+
+	config = open_config();
+	if (!config)
+		goto out;
+
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
+	ret = false;
+out:
+	gzclose(config);
+	return ret;
+}
+
+static bool cmdline_contains(const char *pat)
 {
 	char cmdline[4096], *c;
 	int fd, ret = false;
@@ -27,7 +88,7 @@ static bool get_mitigations_off(void)
 
 	cmdline[sizeof(cmdline) - 1] = '\0';
 	for (c = strtok(cmdline, " \n"); c; c = strtok(NULL, " \n")) {
-		if (strncmp(c, "mitigations=off", strlen(c)))
+		if (strncmp(c, pat, strlen(c)))
 			continue;
 		ret = true;
 		break;
@@ -37,8 +98,21 @@ static bool get_mitigations_off(void)
 	return ret;
 }
 
+static int get_mitigations_off(void)
+{
+	int enabled_in_config;
+
+	if (cmdline_contains("mitigations=off"))
+		return true;
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
@@ -52,5 +126,19 @@ bool get_unpriv_disabled(void)
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


