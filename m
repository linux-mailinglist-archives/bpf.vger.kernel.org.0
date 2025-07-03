Return-Path: <bpf+bounces-62268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D96B0AF73C7
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F1C1C855A4
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D234E2ED144;
	Thu,  3 Jul 2025 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw6aHV7X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902272ECE8F;
	Thu,  3 Jul 2025 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545079; cv=none; b=IhP1AHbxlVIUdvsQAxBTzugC2TS1Oo6NAjVj3E2hE3+aI+brdjCk17APfFLI549Md7noNdhqZtwbcDorXdSWf0qxsMqJbjhbQZ29jKvQzHgwMGSW7kIA54fucDM10JeWsxypqD6SmXrp/Ro3h8zeCZMgVLrI4Qaa95KhunlB6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545079; c=relaxed/simple;
	bh=fWgbK1Nrj7aUDrUsV869sFHBRLH4ZDyIavaPmDxgHio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+AkHpZbLJ1SGny7Z3h/BOBpZDEIESai1N/WrP0Snx4IV6Pbfnf8l3HvHVZVtLIgdzlq0Bgt7FlR8w94RW6X+2xwvlFDZVHrdX6KjNUBk7/kDy2inhZypwDC7QmUx/kmJ29e8cGQQTlrJ7+myZjx+57dox6c7SfFUYEXSmhUQBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw6aHV7X; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-742c7a52e97so7604776b3a.3;
        Thu, 03 Jul 2025 05:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545077; x=1752149877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2U2ElMgt+22DrbBwBMcwSOfoJxUeZxDt20EbBqLamU=;
        b=Gw6aHV7XsdojFjur1fdeiTV+6go/dvpju4x4WSPYrpKJ7odM8cnKVXOomcF796z1DP
         nsYMABj74vnSzmgDaol83ElhU9XvzKKLp6UqxqaWuYVZWZqPPNIbfhlLiiMZt0xEhABg
         5n87DibexLnafYe9yQTYuHm36xdVqA783mDloms1eHoi/B4ORYqC39byLY0n0JVV6krc
         A6zwgOAAkN/dYQsGVyznRL98jZZAzJ7kjlJ3bJEfeNsimiIBx2IcTKzARovXZoL2+xiF
         9t8+fUu33ytJE70zP4EjKf4nXjS/ToBMuJAp3d18NJALKz/fagynbAVxczXFYSYYR94G
         HHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545077; x=1752149877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2U2ElMgt+22DrbBwBMcwSOfoJxUeZxDt20EbBqLamU=;
        b=ALAOAhCelazdAztWtpT1H5pWDO0WW1Y2HxLQLjrE9KlhWZOaF3qPMLBnk53s7B0o8B
         YWlZYmSYnb6pszO2FYZUwMFLcsZde1R4QX7onjTVQigVBDPprA4bR2D6PiQroVVGXMkY
         J1qdlzXZ9Ed1aWbwIHShGWFK2hbNkFgorii6Oj57Mw4wJtVWzWKe/M+dAZl+4wE0ySVL
         5XJcKZ4n92fTKjKgxppiLJ+yQYhg5fWcZpRG7thHH9nSTypu1oPrXJfORUVfFq4/4pKT
         tGsxZ052aXiR72yEj+uAHwfkf0gsgobqe5PMxAH1ruvMAXeQxiNnV7vzLHjHkTBXVkZo
         9Tvw==
X-Forwarded-Encrypted: i=1; AJvYcCXw9cxjq0Bl6bYqoKstLkrp5Tlqv56TPnZe7HBHSk2Nfuzp9niOdzQlKdlMFMUzRqD4mcoj3tLHGDSb6mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDChRUrp7kwRx5F6o+3yDs0KBs0LMvdCtqrvNcCxGIWZDK4YN
	hMan5iA2xH2zdsB1D4PSn3v2h2GheuNbMSKHVvZtH7CcaOwulHYs0bGp
X-Gm-Gg: ASbGncuxmN9xZo2Oj+8Nft6RXfieMzFknMC7FrMMwboI7Ov54uVr3vRYjAHEl2vDlw7
	YBrWW0RAupJ3e7YNHDaPkeXP8ZV3Uah/3giKcEkla9sZix0wY19NmRBg7uJFii+gSlJh3iVeQTX
	53MZOzltRqG8NyY37/NsOpzwCAAE3tom4Kd1FOFxJdNzpO8SVl5M4HWOrW81ZP+Ily8lslY2Apv
	9zxopUNYSrGhHjcpO4u2Lmk/qcT4coIu2DjYYp+Tm2GGDCxBs22WXWfqURB+k4LoYmUJ5ApXf2g
	yb9AvGe9sfhBRRXjtdTWqS1NOFSepNOud7kA84g8xfKMY8jVlWISfXcz1i3fsrQQFHSJ9NiXQ8W
	xCM4=
X-Google-Smtp-Source: AGHT+IGcRgvuITSp5oD7YcpXwuPekuvvjwtpR2avfqmSmbng4LjQapatKz4z4iZvMA7GVpsDaVuYrA==
X-Received: by 2002:a05:6a00:2354:b0:748:fb2c:6b95 with SMTP id d2e1a72fcca58-74ca8495056mr4665171b3a.18.1751545076604;
        Thu, 03 Jul 2025 05:17:56 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:56 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 13/18] libbpf: support tracing_multi
Date: Thu,  3 Jul 2025 20:15:16 +0800
Message-Id: <20250703121521.1874196-14-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
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
index b07317d2842f..bcf2991a3f8f 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1189,6 +1189,9 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
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
index 6eb421ccf91b..dd65e133d412 100644
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
index 1342564214c8..5c97acec643d 100644
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
index 530c29f2f5fc..ae38b3ab84c7 100644
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
@@ -7419,9 +7424,9 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 		opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
 	}
 
-	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
+	if ((def & (SEC_ATTACH_BTF | SEC_ATTACH_BTF_MULTI)) && !prog->attach_btf_id) {
 		int btf_obj_fd = 0, btf_type_id = 0, err;
-		const char *attach_name;
+		const char *attach_name, *name_end;
 
 		attach_name = strchr(prog->sec_name, '/');
 		if (!attach_name) {
@@ -7440,7 +7445,27 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
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
 
@@ -9519,6 +9544,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie, st
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_trace_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
 static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
@@ -9565,6 +9591,13 @@ static const struct bpf_sec_def section_defs[] = {
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
@@ -12799,6 +12832,135 @@ static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_
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
index 7cc810aa7967..1e7603c75224 100644
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
index 4a0c993221a5..5f580b134d18 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -445,4 +445,5 @@ LIBBPF_1.6.0 {
 		btf__add_decl_attr;
 		btf__add_type_attr;
 		bpf_object__free_btfs;
+		bpf_program__attach_trace_multi_opts;
 } LIBBPF_1.5.0;
-- 
2.39.5


