Return-Path: <bpf+bounces-59108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC22AC6073
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C5718831EC
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0921D3F5;
	Wed, 28 May 2025 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyxBi+0r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D58721CC7F;
	Wed, 28 May 2025 03:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404220; cv=none; b=t1ZKuQt7nbKRgUnPnyw4BwmxYScl+tA2Nt9YmfTvmuE9174mRy1ON7Oi/MD0pPEQSxkPCj7n9miGYIZoNBLihGuhWdxHQ3Fwa2pj7HgorAHAq0kkj0SM1LzilXsWLraISaifMOrGzu0iwQFOl+izjjX2fwzp94radL+KjwbL5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404220; c=relaxed/simple;
	bh=5V+8heoQF3gSTeQDws/G0dOXiPgoppADqa7baGsuzPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NihKajXar4IHL2/Gvmj1ILFp07H4q5vo9DzyOhK7E+UFbd529mQ9m6pYQlW3tabOOmLzL4vuu/HynEmCfVCKVN9C94EUHtJkkQbl3Fsd8Bo/CjwrKYWD5CGwZErTODjip2zfI6cWUl/cIbozTHJyqe0VVv4mca6aLP6sdX9eOoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyxBi+0r; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-234488c2ea6so28143715ad.3;
        Tue, 27 May 2025 20:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404218; x=1749009018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOAklLICFXXiJE09qqPApCXuoD1jwY/692BPEgyWx/I=;
        b=EyxBi+0rJv/PI4VAbkIVz3xeOa3V2+UEcV8dILYmAGWeyFD2+3bOO4DsOrfC0d/SYB
         Nzxq6OK8x71sdEmDeKntd791VCW+sViBu95q3eb3IkFL0Y1BB0oNwDAlG7jgWRSmH4lA
         hNLZHQkL443p9MVNwBB+gqTKd9z1ZGp/9ldt3dpKIKM0tV23T7SpQD02wuC+eGB6+2en
         ZgDSJf8qcwVjCSqOfvlfu2GKSvpwfvkSXjh06yS6/Le1pmdrtxJN9WEOqKUbvQxfSXyR
         IYZbdseWa6B6w6o7OtjNuMhaRs/kTQrmjnJsHEulkrPRDi+58zMt7Vt69rk3qNjg18Jt
         uHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404218; x=1749009018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOAklLICFXXiJE09qqPApCXuoD1jwY/692BPEgyWx/I=;
        b=LHTwwSAnJZktsrtI4j1Vch/ezRaKbkUom6tjDJfZKzoA9aBnRe1Ms3oWG60OUJk0zs
         2BidjIE+U8fb/g3YEATGIhC85nZHQbip9VwJ0LlDbeGsysUQALiRvGhIFzZwQYSStWEs
         UiLZnaapE9iAf3Hmpbw2eXvYhaqKSJ2jGAFUoIRzEY34OlyxVEUoQBl+1GhaAdP1SmyU
         ab9Y2h4qb8Sak1fEJt5WmXKdPB+maFC3KnUEXxp4PGG7u29nlCCKan0aDx/pPxAL9l08
         aythrYyCil12xtTD1zXvqdDA20ucTAxnm/+GvlN8SAqXtzALKyDDWWsiIssutkLXThtS
         V86w==
X-Forwarded-Encrypted: i=1; AJvYcCUvsqDa8XI3Edqxj+IiZzxT9DFE/ED+X5AMHdNizjBOQjk1bK6Ho0/0NnavqHOF8LPZT9NrqwN7uga9pCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrM1EM7aRf6/zcn990nlp05k5j3d3Ar0jH+2c86pWJpwrcJzM3
	OrmQFcWQmUpp/tESIOI94TH/TYVznw6f7lFKRNMhOZALBsMUUtSh6dX9
X-Gm-Gg: ASbGncuTI3OpJ2SD6Lq9JKp2FGDr7OgsBVyCvnQF6aKjkyGkogCuKDJDil7p0fu12gF
	8VvTQ+Ar8n2fr1cUcDm4MQwN+23z83ROnZjONqlHxRoKv+3xsY/j2HNLBoH0foxIfL/wlPP8maP
	h3bQaPNYsEqLteflb5EU9EWWPmJM96Uv9eLNYrGnndtTghwX1/jKeS6C5QvZI4hwE0K+QuWVobq
	ouWcSyIc6RqaUMEpE/ARtUlVrVYxQa5J1Fk9fY/YCXGy7XVp8SzGDqlv92fGXd8wmENPkWgO9bi
	VClr72SKG3/5b+nOK0fB9/v2AhQLo7vWEdHMde2nvYlNrdIoKWu186zJtGjv/vBPn3dP
X-Google-Smtp-Source: AGHT+IFjRDfKk14PTcCXJFZU5cazoUTE4t7ucC5c5KcvLGRVl1mcIVWu47Z++9kntaSV5DajC+EV3Q==
X-Received: by 2002:a17:902:e807:b0:22e:50fa:50d6 with SMTP id d9443c01a7336-23414fb1934mr238367355ad.37.1748404217643;
        Tue, 27 May 2025 20:50:17 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:17 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 19/25] libbpf: support tracing_multi
Date: Wed, 28 May 2025 11:47:06 +0800
Message-Id: <20250528034712.138701-20-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add supporting for the attach types of:

BPF_TRACE_FENTRY_MULTI
BPF_TRACE_FEXIT_MULTI
BPF_MODIFY_RETURN_MULTI

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/bpf/bpftool/common.c |   3 +
 tools/lib/bpf/bpf.c        |  10 +++
 tools/lib/bpf/bpf.h        |   6 ++
 tools/lib/bpf/libbpf.c     | 168 ++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h     |  19 +++++
 tools/lib/bpf/libbpf.map   |   1 +
 6 files changed, 204 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index ecfa790adc13..8e681fe3dd6b 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1162,6 +1162,9 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:			return "fentry";
 	case BPF_TRACE_FEXIT:			return "fexit";
 	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_TRACE_FENTRY_MULTI:		return "fentry_multi";
+	case BPF_TRACE_FEXIT_MULTI:		return "fexit_multi";
+	case BPF_MODIFY_RETURN_MULTI:		return "mod_ret_multi";
 	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
 	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
 	default:	return libbpf_bpf_attach_type_str(t);
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a9c3e33d0f8a..75a917de1a3c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -797,6 +797,16 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, tracing))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
+	case BPF_MODIFY_RETURN_MULTI:
+		attr.link_create.tracing_multi.btf_ids = ptr_to_u64(OPTS_GET(opts, tracing_multi.btf_ids, 0));
+		attr.link_create.tracing_multi.tgt_fds = ptr_to_u64(OPTS_GET(opts, tracing_multi.tgt_fds, 0));
+		attr.link_create.tracing_multi.cookies = ptr_to_u64(OPTS_GET(opts, tracing_multi.cookies, 0));
+		attr.link_create.tracing_multi.cnt = OPTS_GET(opts, tracing_multi.cnt, 0);
+		if (!OPTS_ZEROED(opts, tracing_multi))
+			return libbpf_err(-EINVAL);
+		break;
 	case BPF_NETFILTER:
 		attr.link_create.netfilter.pf = OPTS_GET(opts, netfilter.pf, 0);
 		attr.link_create.netfilter.hooknum = OPTS_GET(opts, netfilter.hooknum, 0);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 777627d33d25..c279b3bc80be 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -422,6 +422,12 @@ struct bpf_link_create_opts {
 		struct {
 			__u64 cookie;
 		} tracing;
+		struct {
+			__u32 cnt;
+			const __u32 *btf_ids;
+			const __u32 *tgt_fds;
+			const __u64 *cookies;
+		} tracing_multi;
 		struct {
 			__u32 pf;
 			__u32 hooknum;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cfe81e1640d8..0c4ed5d237e5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -136,6 +136,9 @@ static const char * const attach_type_name[] = {
 	[BPF_NETKIT_PEER]		= "netkit_peer",
 	[BPF_TRACE_KPROBE_SESSION]	= "trace_kprobe_session",
 	[BPF_TRACE_UPROBE_SESSION]	= "trace_uprobe_session",
+	[BPF_TRACE_FENTRY_MULTI]	= "trace_fentry_multi",
+	[BPF_TRACE_FEXIT_MULTI]		= "trace_fexit_multi",
+	[BPF_MODIFY_RETURN_MULTI]	= "modify_return_multi",
 };
 
 static const char * const link_type_name[] = {
@@ -410,6 +413,8 @@ enum sec_def_flags {
 	SEC_XDP_FRAGS = 16,
 	/* Setup proper attach type for usdt probes. */
 	SEC_USDT = 32,
+	/* attachment target is multi-link */
+	SEC_ATTACH_BTF_MULTI = 64,
 };
 
 struct bpf_sec_def {
@@ -7417,9 +7422,9 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 		opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
 	}
 
-	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
+	if ((def & (SEC_ATTACH_BTF | SEC_ATTACH_BTF_MULTI)) && !prog->attach_btf_id) {
 		int btf_obj_fd = 0, btf_type_id = 0, err;
-		const char *attach_name;
+		const char *attach_name, *name_end;
 
 		attach_name = strchr(prog->sec_name, '/');
 		if (!attach_name) {
@@ -7438,7 +7443,27 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 		}
 		attach_name++; /* skip over / */
 
-		err = libbpf_find_attach_btf_id(prog, attach_name, &btf_obj_fd, &btf_type_id);
+		name_end = strchr(attach_name, ',');
+		/* for multi-link tracing, use the first target symbol during
+		 * loading.
+		 */
+		if ((def & SEC_ATTACH_BTF_MULTI) && name_end) {
+			int len = name_end - attach_name + 1;
+			char *first_tgt;
+
+			first_tgt = malloc(len);
+			if (!first_tgt)
+				return -ENOMEM;
+			libbpf_strlcpy(first_tgt, attach_name, len);
+			first_tgt[len - 1] = '\0';
+			err = libbpf_find_attach_btf_id(prog, first_tgt, &btf_obj_fd,
+							&btf_type_id);
+			free(first_tgt);
+		} else {
+			err = libbpf_find_attach_btf_id(prog, attach_name, &btf_obj_fd,
+							&btf_type_id);
+		}
+
 		if (err)
 			return err;
 
@@ -9507,6 +9532,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie, st
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_trace_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
 static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
@@ -9553,6 +9579,13 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fentry.s+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fmod_ret.s+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("tp_btf+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fentry.multi+",	TRACING, BPF_TRACE_FENTRY_MULTI, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
+	SEC_DEF("fmod_ret.multi+",	TRACING, BPF_MODIFY_RETURN_MULTI, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
+	SEC_DEF("fexit.multi+",		TRACING, BPF_TRACE_FEXIT_MULTI, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
+	SEC_DEF("fentry.multi.s+",	TRACING, BPF_TRACE_FENTRY_MULTI, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
+	SEC_DEF("fmod_ret.multi.s+",	TRACING, BPF_MODIFY_RETURN_MULTI, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
+	SEC_DEF("fexit.multi.s+",	TRACING, BPF_TRACE_FEXIT_MULTI, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
@@ -12787,6 +12820,135 @@ static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_
 	return libbpf_get_error(*link);
 }
 
+struct bpf_link *bpf_program__attach_trace_multi_opts(const struct bpf_program *prog,
+						      const struct bpf_trace_multi_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+	__u32 *btf_ids = NULL, *tgt_fds = NULL;
+	struct bpf_link *link = NULL;
+	char errmsg[STRERR_BUFSIZE];
+	int prog_fd, pfd, cnt, err;
+
+	if (!OPTS_VALID(opts, bpf_trace_multi_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warn("prog '%s': can't attach before loaded\n", prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	cnt = OPTS_GET(opts, cnt, 0);
+	if (opts->syms) {
+		int btf_obj_fd, btf_type_id, i;
+
+		if (opts->btf_ids || opts->tgt_fds) {
+			pr_warn("can set both opts->syms and opts->btf_ids\n");
+			return libbpf_err_ptr(-EINVAL);
+		}
+
+		btf_ids = malloc(sizeof(*btf_ids) * cnt);
+		tgt_fds = malloc(sizeof(*tgt_fds) * cnt);
+		if (!btf_ids || !tgt_fds) {
+			err = -ENOMEM;
+			goto err_free;
+		}
+		for (i = 0; i < cnt; i++) {
+			btf_obj_fd = btf_type_id = 0;
+
+			err = find_kernel_btf_id(prog->obj, opts->syms[i],
+					 prog->expected_attach_type, &btf_obj_fd,
+					 &btf_type_id);
+			if (err)
+				goto err_free;
+			btf_ids[i] = btf_type_id;
+			tgt_fds[i] = btf_obj_fd;
+		}
+		link_opts.tracing_multi.btf_ids = btf_ids;
+		link_opts.tracing_multi.tgt_fds = tgt_fds;
+	} else {
+		link_opts.tracing_multi.btf_ids = OPTS_GET(opts, btf_ids, 0);
+		link_opts.tracing_multi.tgt_fds = OPTS_GET(opts, tgt_fds, 0);
+	}
+
+	link = calloc(1, sizeof(*link));
+	if (!link) {
+		err = -ENOMEM;
+		goto err_free;
+	}
+	link->detach = &bpf_link__detach_fd;
+
+	link_opts.tracing_multi.cookies = OPTS_GET(opts, cookies, 0);
+	link_opts.tracing_multi.cnt = cnt;
+
+	pfd = bpf_link_create(prog_fd, 0, bpf_program__expected_attach_type(prog), &link_opts);
+	if (pfd < 0) {
+		err = -errno;
+		pr_warn("prog '%s': failed to attach: %s\n",
+			prog->name, libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+		goto err_free;
+	}
+	link->fd = pfd;
+
+	free(btf_ids);
+	free(tgt_fds);
+	return link;
+err_free:
+	free(btf_ids);
+	free(tgt_fds);
+	free(link);
+	return libbpf_err_ptr(err);
+}
+
+static int attach_trace_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	LIBBPF_OPTS(bpf_trace_multi_opts, opts);
+	int i, err, len, cnt = 1;
+	char **syms, *buf, *name;
+	const char *spec;
+
+	spec = strchr(prog->sec_name, '/');
+	if (!spec || !*(++spec))
+		return -EINVAL;
+
+	len = strlen(spec) + 1;
+	buf = malloc(len);
+	if (!buf)
+		return -ENOMEM;
+
+	libbpf_strlcpy(buf, spec, len);
+	for (i = 0; i < len; i++) {
+		if (buf[i] == ',')
+			cnt++;
+	}
+
+	syms = malloc(sizeof(*syms) * cnt);
+	if (!syms) {
+		err = -ENOMEM;
+		goto out_free;
+	}
+
+	opts.syms = (const char **)syms;
+	opts.cnt = cnt;
+	name = buf;
+	err = -EINVAL;
+	while (name) {
+		if (*name == '\0')
+			goto out_free;
+		*(syms++) = name;
+		name = strchr(name, ',');
+		if (name)
+			*(name++) = '\0';
+	}
+
+	*link = bpf_program__attach_trace_multi_opts(prog, &opts);
+	err = libbpf_get_error(*link);
+out_free:
+	free(buf);
+	free(opts.syms);
+	return err;
+}
+
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	*link = bpf_program__attach_lsm(prog);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index ded98e8cf327..d7f0db7ab586 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -833,6 +833,25 @@ bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_freplace(const struct bpf_program *prog,
 			     int target_fd, const char *attach_func_name);
+struct bpf_trace_multi_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	/* array of function symbols to attach */
+	const char **syms;
+	/* array of the btf type id to attach */
+	__u32 *btf_ids;
+	/* array of the target fds */
+	__u32 *tgt_fds;
+	/* array of the cookies */
+	__u64 *cookies;
+	/* number of elements in syms/btf_ids/cookies arrays */
+	size_t cnt;
+};
+#define bpf_trace_multi_opts__last_field cnt
+
+LIBBPF_API struct bpf_link *
+bpf_program__attach_trace_multi_opts(const struct bpf_program *prog,
+				     const struct bpf_trace_multi_opts *opts);
 
 struct bpf_netfilter_opts {
 	/* size of this struct, for forward/backward compatibility */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 23df00ae0b73..fab014528b86 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -416,6 +416,7 @@ LIBBPF_1.4.0 {
 		btf__new_split;
 		btf_ext__raw_data;
 		bpf_object__free_btfs;
+		bpf_program__attach_trace_multi_opts;
 } LIBBPF_1.3.0;
 
 LIBBPF_1.5.0 {
-- 
2.39.5


