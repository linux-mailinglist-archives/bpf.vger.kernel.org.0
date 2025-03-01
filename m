Return-Path: <bpf+bounces-52942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0811DA4A6CF
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 01:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DEE178507
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9F43214;
	Sat,  1 Mar 2025 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6H8fEcg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E946FB9
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787336; cv=none; b=d8oS2dODHgeQZgFD1UTKse/mhs9YSKPCZThvOAmNjIAjC2H39Fhpig/obhVsArrVaMSCJ5tOTbRyltfXimth80XdaVX9218QzfDMzs9SzPe/nEvbfxEaYezfWaYEAB6ShMAe8vjJuaMJtUCnB52IqLZ70QyAvmckD9hPSSe0vNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787336; c=relaxed/simple;
	bh=puRsiwHLnojWnbkcRvaAb0rKnH6aG37O6flpB1aAkoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnObWyBTc1m0Cp9eBZD8qU32mjsxAKalhme64Ud/eQWC2Uv0Qco63gNaJlyk6G+7/Q/Vo6BkTJZL5Zh9VfA4jX7397dNRkiiu9Wgig16iOz6UPw1zE8Dfb5X56hvr029bR+Zct5c7/MsqtteaADK+3qpo1iCaZAz9BzhV0Tt9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6H8fEcg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22334203781so59313455ad.0
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 16:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740787334; x=1741392134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k8ov3nANh8MH1vRD2IZ+9DmKZthAkyrs1EFG01JfAI=;
        b=J6H8fEcgplsS6nTx5c8nJX8yWyZYy9yaWyQWR2brbzX8cu8oGyomgfEPWneq36XhZx
         T+J8MO388UO1hD08WqECFPXidle98DiYt8354VMEQR6bcJW3YZqN36e3Ovrv89XBsu0m
         ToGWHxFFavFbAPGuxbOcrsK/Em1XEfUd5BJk3uMPHrWS4hZMfuGFrMkfMtloagSrnCRD
         vwF5nGjWTL2lZHfGIh/x9xKDVaCuqjsJYnxJTj7RCtp3ICFD3eqwFTxaW6Zf6VyrUlbM
         j4Vho2hgFucpMdBg5H7coZy0iOi5TDXZsET2hkrouCAurbov6wpXqS2tEyJznd83kMOQ
         0ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740787334; x=1741392134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7k8ov3nANh8MH1vRD2IZ+9DmKZthAkyrs1EFG01JfAI=;
        b=T7Zvg+WoXThsABcagQm7+gXNdy6P1WrsNTe9jFjHrpbnsdBp0YRi+smaZsHcwnDLdT
         jHC+LRaDhYmeJ/NfZU73ciZ9kx96Gug68MSzYaowKreb8KgISOmtPegGyveXwBbLX+X3
         qb3z1SuhxlLJwFZL3nTKOsZoriC1h2oFfpGO5uFtC0cqbtEffQfSz+U3IVoLOcHpwLM4
         X3A7O4WJHDByip/ngKlwSENBW22PjLMtpHlxAYTx8bp3uCEIN3hFgLBSvI0ZQC/KreVx
         neLs8lQk/rMYkE3385mStyPTcFcCqcHmPh1UcTGS8zLpjhhw02+LKz1mrF+BIZY6p+If
         mPAg==
X-Gm-Message-State: AOJu0YypwJ+E8wAU2FbN8VENaQU8Ju7YzzZoEV2U6P+Hbk0XmhDv6Ftu
	xfmVvohNMjKYq/i4/v4iuR0pkdj+pv5do64gFn0Lii/lKMinPvWkS+loxA==
X-Gm-Gg: ASbGnctCvGaE2m3Q09o49fsRLYmJn2yo/zByDty2iOIqGcI4ve5o8S4B6ShVMBK0EHF
	8jZnfkmWAjnBP5tULTCxv1ON8mun57fyrl3tbiu2utY0f/C1+Vnyh5pKcbwm2eK2A+ymBNl3xtY
	OyWypgPjXtS01XtS8buDMJmjsLCuFKBsT+0fuS/wanE7GNbfZ6hMbDfXXuk5RR00dk80hqMhEIO
	FYguJyl2lVGPgYC5yVSXrXH3gKgd1pLGh5dfCc8IdBIajAtHkzaUtM7u6pluNWgxbcFnOB+PBqc
	w4T6F7jF+NzEPI9JJwu1UYbMoOqV74IVpUiPfpYY
X-Google-Smtp-Source: AGHT+IF8FEh3yrIj71h/wE77qPiIIXc3XtkRrsa3Vl7GZRp02CQL/udbco12tYF206PbNrhyFfcpuw==
X-Received: by 2002:a05:6a21:999f:b0:1e1:f88a:3106 with SMTP id adf61e73a8af0-1f2e38759demr14882966637.7.1740787333648;
        Fri, 28 Feb 2025 16:02:13 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dedf5a8sm3993425a12.70.2025.02.28.16.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:02:13 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v2 1/3] veristat: @files-list.txt notation for object files list
Date: Fri, 28 Feb 2025 16:01:45 -0800
Message-ID: <20250301000147.1583999-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250301000147.1583999-1-eddyz87@gmail.com>
References: <20250301000147.1583999-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow reading object file list from file.
E.g. the following command:

  ./veristat @list.txt

Is equivalent to the following invocation:

  ./veristat line-1 line-2 ... line-N

Where line-i corresponds to lines from list.txt.
Lines starting with '#' are ignored.

Acked-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 62 ++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 175a03e6c5ef..8bc462299290 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -268,10 +268,11 @@ static int append_filter(struct filter **filters, int *cnt, const char *str);
 static int append_filter_file(const char *path);
 static int append_var_preset(struct var_preset **presets, int *cnt, const char *expr);
 static int append_var_preset_file(const char *filename);
+static int append_file(const char *path);
+static int append_file_from_file(const char *path);
 
 static error_t parse_arg(int key, char *arg, struct argp_state *state)
 {
-	void *tmp;
 	int err;
 
 	switch (key) {
@@ -381,14 +382,14 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 		break;
 	}
 	case ARGP_KEY_ARG:
-		tmp = realloc(env.filenames, (env.filename_cnt + 1) * sizeof(*env.filenames));
-		if (!tmp)
-			return -ENOMEM;
-		env.filenames = tmp;
-		env.filenames[env.filename_cnt] = strdup(arg);
-		if (!env.filenames[env.filename_cnt])
-			return -ENOMEM;
-		env.filename_cnt++;
+		if (arg[0] == '@')
+			err = append_file_from_file(arg + 1);
+		else
+			err = append_file(arg);
+		if (err) {
+			fprintf(stderr, "Failed to collect BPF object files: %d\n", err);
+			return err;
+		}
 		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
@@ -689,6 +690,49 @@ static const struct stat_specs default_output_spec = {
 	},
 };
 
+static int append_file(const char *path)
+{
+	void *tmp;
+
+	tmp = realloc(env.filenames, (env.filename_cnt + 1) * sizeof(*env.filenames));
+	if (!tmp)
+		return -ENOMEM;
+	env.filenames = tmp;
+	env.filenames[env.filename_cnt] = strdup(path);
+	if (!env.filenames[env.filename_cnt])
+		return -ENOMEM;
+	env.filename_cnt++;
+	return 0;
+}
+
+static int append_file_from_file(const char *path)
+{
+	char buf[1024];
+	int err = 0;
+	FILE *f;
+
+	f = fopen(path, "r");
+	if (!f) {
+		err = -errno;
+		fprintf(stderr, "Failed to open object files list in '%s': %s\n",
+			path, strerror(errno));
+		return err;
+	}
+
+	while (fscanf(f, " %1023[^\n]\n", buf) == 1) {
+		/* lines starting with # are comments, skip them */
+		if (buf[0] == '\0' || buf[0] == '#')
+			continue;
+		err = append_file(buf);
+		if (err)
+			goto cleanup;
+	}
+
+cleanup:
+	fclose(f);
+	return err;
+}
+
 static const struct stat_specs default_csv_output_spec = {
 	.spec_cnt = 14,
 	.ids = {
-- 
2.48.1


