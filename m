Return-Path: <bpf+bounces-52896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A78EA4A281
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C340C189B141
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD961F873A;
	Fri, 28 Feb 2025 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxKFLSm6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8091F872A
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769993; cv=none; b=mHMt6JXKzher1YGMxGpewFTQwZzROs9X3laWnAioAN+nD/sa2VIlg8zisdQVGmc6QGTpPR82nKAci/2MWRsGWyPb/cwUCwVV74bwpoBg7K5CY4+M8Ibg+CQHxHEmY465oU0icb3czOVq6hg73dE73J/sfPCPVb88MYGM4uA54sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769993; c=relaxed/simple;
	bh=pVBRpCSc08KRsJ5O06Ye9DHo1DHWkrcWmmhearPTu7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bsv9IQbmrPYqO9Lb+Xvs1QVUHsAoBPYdNEFPlVbj88Lk0W3n7G8DUueGvuAo3lKs7Dy9H6lWuvTgm2AzYEzVZ78JN9GRP1RzN0cBVEsM1J+sr7AZTwhc2m0w3HL4HzTcTaqneUqjBQfAS8pVrkcXd2t9BVoP5SKQgsbwSJQ7hCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxKFLSm6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223480ea43aso64162625ad.1
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 11:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740769991; x=1741374791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrpocJsSNqfwzC+nyb2/BSk0FqCm3HcTFtUzhqtSJwo=;
        b=cxKFLSm6uzxvqU6PrsNXeHRENi0vsaxRBdK1/QoXiZYg7M1DbXl83WPvZQdTJlsIW4
         QWcHnaJZeuGsk0p4yvYCihNi6rJyo+2wMaepFNNiMgnIr3TpLR/HEji184gVel7/9m3B
         FCTh2m7hGbpYCsvjW5Rgmq7fWBxhChcbqc3ruJOiag50Al6L0I3xczFRHxxQhgbEWvq+
         oatuL+oAqHXjONpYVRkmgGxtTw5LSF27OWBU9yKjq2ZYq3enEpiQ9MUX5Zczk3hXCqMK
         KIWYb13lt7uzrYQkF7Ei8aU99kapCBs1nvndkHYXrxgT5jS7EP1I9kQ5Z7NL6a3GQmUT
         j9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740769991; x=1741374791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrpocJsSNqfwzC+nyb2/BSk0FqCm3HcTFtUzhqtSJwo=;
        b=VQjJVXQiP5Ro9+ml9aQYyfA0J+rfnn+/uvpvpT/O+ezCdKA0Ur7tLHRx/AILG6OWB3
         zB/0B7oRyQxRl9JbvIWRH/eoOCENN0MussY4g5hwkWgDLF++QXzCYFxFj7TWjFGAZS2u
         /259DnPy5iV2h9OL8SzpOkk5+EbBbEDotLeAvNiCgW9mIf4EFadChZEMfpnYRaoQkuzj
         4wGFgx3G2l8ktKPs81IFh7JRfu9ZlJIJfxkn6jPI5QHCRv6sw/mPQAbXI2pCBE+R9FjX
         b9FETLo+1OvB9jHCUX4bQGGiHrC7qohFbKkhRUHYkKNgRA47gAZxBRUZOlDpWbb9WmDX
         m9Yg==
X-Gm-Message-State: AOJu0Yxu+9brI7eY6976gKvuY04FGWBlfQVUKHNCZjqQoiBLaByhZCE4
	M+Ir7vvo7inJ7qAJZP10OjePrkkXVJqhdjav6NY1bV150jFxRHx9N3XjyA==
X-Gm-Gg: ASbGncv1NwBiGKO6IWkCc9Qcm2ZKKjdZIDnk2vUVOBB8pF5USSzA0K1PKQZdMNQ9apa
	WSz00RA3Un14NAKpRrZSwdftfWRj0yIXpOoK4drtxjmtUwGPWeHRLb4C+hNlSgYySXOZJlPJbFg
	XdcPGjwcueA6SZ9mkVww7w8nufqwWi5DzqlPuZJoij0M2nEoXZpd6fMBIJL0DdNIaXq1esAKaP2
	ms9YEWutcquOaoPFLbi5qQorO76713qv+xn60FiNgNrX5l4SL9fqcND26+hQ5qTsYfMhT9y2vIz
	uLQMNbgfNyD9geXPDCwPHA==
X-Google-Smtp-Source: AGHT+IF2RvvTszA7eZ+x5jpNIkEK4VSHcfneo8YkXhoogH0P5gKxdEMX83JTdlpD0uIMfqb2a7MFig==
X-Received: by 2002:a17:903:1252:b0:216:281f:820d with SMTP id d9443c01a7336-22368f739e2mr79150415ad.11.1740769990727;
        Fri, 28 Feb 2025 11:13:10 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48865sm4228799b3a.50.2025.02.28.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:13:10 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 1/3] veristat: @files-list.txt notation for object files list
Date: Fri, 28 Feb 2025 11:12:18 -0800
Message-ID: <20250228191220.1488438-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228191220.1488438-1-eddyz87@gmail.com>
References: <20250228191220.1488438-1-eddyz87@gmail.com>
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


