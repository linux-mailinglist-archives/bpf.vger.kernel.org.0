Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD90D4975F3
	for <lists+bpf@lfdr.de>; Sun, 23 Jan 2022 23:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbiAWWTq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Jan 2022 17:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240318AbiAWWTq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 23 Jan 2022 17:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642976385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czb04J0iAWuUi7wF0DsloRGiID6eNktOBNNduQ6TsS8=;
        b=iHqGMl8ZPcUiwTB8mZL32T/GdyMpc9hI0/zKLG8vATnp1W7Zya6T1zhCpaoeG6ZbeByVy9
        4WN+7KBiF7n2jqKyV54IRM0cRXgfNQCRVsPQMZMztFE87gSKbhO0lKC+/oDxnKVecCAOGq
        FNx1Sgw5iZ4j4an+0sY60q2KJGYuwcc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540--w7MeARHOf65ITu3cMSkcw-1; Sun, 23 Jan 2022 17:19:44 -0500
X-MC-Unique: -w7MeARHOf65ITu3cMSkcw-1
Received: by mail-ed1-f70.google.com with SMTP id c8-20020a05640227c800b003fdc1684cdeso11902723ede.12
        for <bpf@vger.kernel.org>; Sun, 23 Jan 2022 14:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czb04J0iAWuUi7wF0DsloRGiID6eNktOBNNduQ6TsS8=;
        b=q0kZG6WBZY73ABhMGmvrkljPrh92BRRMWQ/m27vk4VFfJo1ppi6maILDD6AG8C553E
         b+UhOsucswqKO+86gosvbpMciNuOCGv14wdQK3V84YEoIxKvfjgskJrshUPq0/ei5myx
         UMk3eCsfXxEkZnai1Iz0K+YDvGiO6ousNreZz9n8VFDeBmFzaYkwBKOz5fJC1hCcU3Re
         Hga3rCsMe31ilLADlhimxybjzWUKJ51VpMQYfUtQp4jlA8p2rkvG8+BiK8BEzs9iJWHO
         FGkSRPtKIGWVzeWCG1OhVgBSvgIs61ZGi/kor7gDnYho0Sb4Hlgw/bqQEv9jUpTyXj6V
         6EOA==
X-Gm-Message-State: AOAM530zt+7W6jLqsrVCn58Pb7kGumfjBpBx6SBcowDJR/2A/UVfnnXb
        iYpdw7u9ZqF7uLtrG4pgXXOEM5zb35k6k1HI1NA5dg5s2VnFLEBwuXBxQYCXzIdImQEW9T8EKdL
        Npv+/89DNuHy7
X-Received: by 2002:a05:6402:1e91:: with SMTP id f17mr2067740edf.355.1642976383240;
        Sun, 23 Jan 2022 14:19:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVYuF7CsxJM5oRyzYgfNF2Xpl0p8rJr6QVptDj3JmLvWsVzNWVHxl6z9JAMFl/bFntGavjpA==
X-Received: by 2002:a05:6402:1e91:: with SMTP id f17mr2067720edf.355.1642976382965;
        Sun, 23 Jan 2022 14:19:42 -0800 (PST)
Received: from krava.redhat.com ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id f4sm4210708ejh.93.2022.01.23.14.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:19:42 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: [PATCH 2/3] perf/bpf: Remove special bpf config support
Date:   Sun, 23 Jan 2022 23:19:31 +0100
Message-Id: <20220123221932.537060-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123221932.537060-1-jolsa@kernel.org>
References: <20220123221932.537060-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With bpf program prologue code removed, we can also remove
the program section parsing, because it is no longer used.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf-loader.c | 177 ++---------------------------------
 1 file changed, 8 insertions(+), 169 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index f9f329a48892..f7682eb7009e 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -129,179 +129,18 @@ clear_prog_priv(struct bpf_program *prog __maybe_unused,
 }
 
 static int
-prog_config__exec(const char *value, struct perf_probe_event *pev)
-{
-	pev->uprobes = true;
-	pev->target = strdup(value);
-	if (!pev->target)
-		return -ENOMEM;
-	return 0;
-}
-
-static int
-prog_config__module(const char *value, struct perf_probe_event *pev)
-{
-	pev->uprobes = false;
-	pev->target = strdup(value);
-	if (!pev->target)
-		return -ENOMEM;
-	return 0;
-}
-
-static int
-prog_config__bool(const char *value, bool *pbool, bool invert)
-{
-	int err;
-	bool bool_value;
-
-	if (!pbool)
-		return -EINVAL;
-
-	err = strtobool(value, &bool_value);
-	if (err)
-		return err;
-
-	*pbool = invert ? !bool_value : bool_value;
-	return 0;
-}
-
-static int
-prog_config__inlines(const char *value,
-		     struct perf_probe_event *pev __maybe_unused)
-{
-	return prog_config__bool(value, &probe_conf.no_inlines, true);
-}
-
-static int
-prog_config__force(const char *value,
-		   struct perf_probe_event *pev __maybe_unused)
-{
-	return prog_config__bool(value, &probe_conf.force_add, false);
-}
-
-static struct {
-	const char *key;
-	const char *usage;
-	const char *desc;
-	int (*func)(const char *, struct perf_probe_event *);
-} bpf_prog_config_terms[] = {
-	{
-		.key	= "exec",
-		.usage	= "exec=<full path of file>",
-		.desc	= "Set uprobe target",
-		.func	= prog_config__exec,
-	},
-	{
-		.key	= "module",
-		.usage	= "module=<module name>    ",
-		.desc	= "Set kprobe module",
-		.func	= prog_config__module,
-	},
-	{
-		.key	= "inlines",
-		.usage	= "inlines=[yes|no]        ",
-		.desc	= "Probe at inline symbol",
-		.func	= prog_config__inlines,
-	},
-	{
-		.key	= "force",
-		.usage	= "force=[yes|no]          ",
-		.desc	= "Forcibly add events with existing name",
-		.func	= prog_config__force,
-	},
-};
-
-static int
-do_prog_config(const char *key, const char *value,
-	       struct perf_probe_event *pev)
-{
-	unsigned int i;
-
-	pr_debug("config bpf program: %s=%s\n", key, value);
-	for (i = 0; i < ARRAY_SIZE(bpf_prog_config_terms); i++)
-		if (strcmp(key, bpf_prog_config_terms[i].key) == 0)
-			return bpf_prog_config_terms[i].func(value, pev);
-
-	pr_debug("BPF: ERROR: invalid program config option: %s=%s\n",
-		 key, value);
-
-	pr_debug("\nHint: Valid options are:\n");
-	for (i = 0; i < ARRAY_SIZE(bpf_prog_config_terms); i++)
-		pr_debug("\t%s:\t%s\n", bpf_prog_config_terms[i].usage,
-			 bpf_prog_config_terms[i].desc);
-	pr_debug("\n");
-
-	return -BPF_LOADER_ERRNO__PROGCONF_TERM;
-}
-
-static const char *
-parse_prog_config_kvpair(const char *config_str, struct perf_probe_event *pev)
-{
-	char *text = strdup(config_str);
-	char *sep, *line;
-	const char *main_str = NULL;
-	int err = 0;
-
-	if (!text) {
-		pr_debug("Not enough memory: dup config_str failed\n");
-		return ERR_PTR(-ENOMEM);
-	}
-
-	line = text;
-	while ((sep = strchr(line, ';'))) {
-		char *equ;
-
-		*sep = '\0';
-		equ = strchr(line, '=');
-		if (!equ) {
-			pr_warning("WARNING: invalid config in BPF object: %s\n",
-				   line);
-			pr_warning("\tShould be 'key=value'.\n");
-			goto nextline;
-		}
-		*equ = '\0';
-
-		err = do_prog_config(line, equ + 1, pev);
-		if (err)
-			break;
-nextline:
-		line = sep + 1;
-	}
-
-	if (!err)
-		main_str = config_str + (line - text);
-	free(text);
-
-	return err ? ERR_PTR(err) : main_str;
-}
-
-static int
-parse_prog_config(const char *config_str, const char **p_main_str,
-		  bool *is_tp, struct perf_probe_event *pev)
+parse_prog_config(const char *config_str, bool *is_tp,
+		  struct perf_probe_event *pev)
 {
 	int err;
-	const char *main_str = parse_prog_config_kvpair(config_str, pev);
-
-	if (IS_ERR(main_str))
-		return PTR_ERR(main_str);
-
-	*p_main_str = main_str;
-	if (!strchr(main_str, '=')) {
-		/* Is a tracepoint event? */
-		const char *s = strchr(main_str, ':');
-
-		if (!s) {
-			pr_debug("bpf: '%s' is not a valid tracepoint\n",
-				 config_str);
-			return -BPF_LOADER_ERRNO__CONFIG;
-		}
 
+	if (strchr(config_str, ':')) {
 		*is_tp = true;
 		return 0;
 	}
 
 	*is_tp = false;
-	err = parse_perf_probe_command(main_str, pev);
+	err = parse_perf_probe_command(config_str, pev);
 	if (err < 0) {
 		pr_debug("bpf: '%s' is not a valid config string\n",
 			 config_str);
@@ -316,7 +155,7 @@ config_bpf_program(struct bpf_program *prog)
 {
 	struct perf_probe_event *pev = NULL;
 	struct bpf_prog_priv *priv = NULL;
-	const char *config_str, *main_str;
+	const char *config_str;
 	bool is_tp = false;
 	int err;
 
@@ -333,15 +172,15 @@ config_bpf_program(struct bpf_program *prog)
 
 	config_str = bpf_program__section_name(prog);
 	pr_debug("bpf: config program '%s'\n", config_str);
-	err = parse_prog_config(config_str, &main_str, &is_tp, pev);
+	err = parse_prog_config(config_str, &is_tp, pev);
 	if (err)
 		goto errout;
 
 	if (is_tp) {
-		char *s = strchr(main_str, ':');
+		char *s = strchr(config_str, ':');
 
 		priv->is_tp = true;
-		priv->sys_name = strndup(main_str, s - main_str);
+		priv->sys_name = strndup(config_str, s - config_str);
 		priv->evt_name = strdup(s + 1);
 		goto set_priv;
 	}
-- 
2.34.1

