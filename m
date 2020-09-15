Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1283B26B589
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 01:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgIOXqy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 19:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbgIOXpy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 19:45:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B7CC061351
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 16:45:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k3so5228091ybp.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 16:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yx65oKNxj4zCHV6KM3Xb/iijBoq//DbQkLjkFKbNTWM=;
        b=lFhkt+iS7yoIyHPHZivUIFpHn9c3Y91RtkvRkTGOt996fRF76NGs2i6sLYg6KSXwOB
         c8/0T+yVIagFotWyFGQixxsjTo+UC5ZTTqmSmvgposc6xng6URaWVzDi8hPG6vE5K6+M
         b/z2fagMTyOHVpvBFeM4KZpXTYTlTHkUkfN7MZWOsl3c7ULUzdOqWPlIirfs1kccbd17
         c67LE01KKrlELzNNF/dWJUQ31OuVkHJEefIxYnQ3EKev0WQlGoibU3A3KngU44vTy+ia
         ojONfo8qAQ4IjpfQxE/2lnjsMPcKsMTQqesvGeS2LbIaW1uCAlZ9LF5ZT010FHlJBkJT
         XoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yx65oKNxj4zCHV6KM3Xb/iijBoq//DbQkLjkFKbNTWM=;
        b=a+VW7OgnDhl2Trs1zR9dEKOxpioVLHS/TGto29PaX6/nmsGuSy8idj76pbd7qGMkbL
         pedo5ZOO4Ak6Nwa9eqBOWprpIgIR7vjhW+Fh0rfoFx8kPDgFFeeMTTOLZQcZPXKl5qXR
         GxJma+qWaozm3ZuGbLJq87XNtUbH7G/yDbWt559aqp/BD//ZbIHZuku19IhJw6nRfxg9
         64Yd+SzZ6YwxYb5WsheyKQAesfeJJC2HyxYdUyINmISwtcbqGdixFJlrl0sW8WPGsFdj
         JEwjXZ8hV+IQi3MuNXCyPWlCJNgcB50nvmIik32CSC+9jIIKnv5obo2Y06ISF0OfPg3Y
         3L+w==
X-Gm-Message-State: AOAM5313NkKWP/AY+3z1DRsYyJvnqd8YV169ttNajHxivMXOKZt+m/E8
        ATVNjTD5phAnRuGpkT/wZhYl850=
X-Google-Smtp-Source: ABdhPJy7fRu6/mzUA5rE6+jC32bTvVdnZ6XDxJU1GxAzIEEJWvEX75UFqXJRnV111ikm+aynxNc6ruE=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:c049:: with SMTP id c70mr31630593ybf.403.1600213550807;
 Tue, 15 Sep 2020 16:45:50 -0700 (PDT)
Date:   Tue, 15 Sep 2020 16:45:41 -0700
In-Reply-To: <20200915234543.3220146-1-sdf@google.com>
Message-Id: <20200915234543.3220146-4-sdf@google.com>
Mime-Version: 1.0
References: <20200915234543.3220146-1-sdf@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH bpf-next v6 3/5] libbpf: Add BPF_PROG_BIND_MAP syscall and use
 it on .rodata section
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

The patch adds a simple wrapper bpf_prog_bind_map around the syscall.
When the libbpf tries to load a program, it will probe the kernel for
the support of this syscall and unconditionally bind .rodata section
to the program.

Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/bpf.c      | 16 ++++++++++
 tools/lib/bpf/bpf.h      |  8 +++++
 tools/lib/bpf/libbpf.c   | 69 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 4 files changed, 94 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 82b983ff6569..2baa1308737c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -872,3 +872,19 @@ int bpf_enable_stats(enum bpf_stats_type type)
 
 	return sys_bpf(BPF_ENABLE_STATS, &attr, sizeof(attr));
 }
+
+int bpf_prog_bind_map(int prog_fd, int map_fd,
+		      const struct bpf_prog_bind_opts *opts)
+{
+	union bpf_attr attr;
+
+	if (!OPTS_VALID(opts, bpf_prog_bind_opts))
+		return -EINVAL;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.prog_bind_map.prog_fd = prog_fd;
+	attr.prog_bind_map.map_fd = map_fd;
+	attr.prog_bind_map.flags = OPTS_GET(opts, flags, 0);
+
+	return sys_bpf(BPF_PROG_BIND_MAP, &attr, sizeof(attr));
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 015d13f25fcc..8c1ac4b42f90 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -243,6 +243,14 @@ LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
 enum bpf_stats_type; /* defined in up-to-date linux/bpf.h */
 LIBBPF_API int bpf_enable_stats(enum bpf_stats_type type);
 
+struct bpf_prog_bind_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 flags;
+};
+#define bpf_prog_bind_opts__last_field flags
+
+LIBBPF_API int bpf_prog_bind_map(int prog_fd, int map_fd,
+				 const struct bpf_prog_bind_opts *opts);
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 550950eb1860..570235dbc922 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -174,6 +174,8 @@ enum kern_feature_id {
 	FEAT_EXP_ATTACH_TYPE,
 	/* bpf_probe_read_{kernel,user}[_str] helpers */
 	FEAT_PROBE_READ_KERN,
+	/* BPF_PROG_BIND_MAP is supported */
+	FEAT_PROG_BIND_MAP,
 	__FEAT_CNT,
 };
 
@@ -409,6 +411,7 @@ struct bpf_object {
 	struct extern_desc *externs;
 	int nr_extern;
 	int kconfig_map_idx;
+	int rodata_map_idx;
 
 	bool loaded;
 	bool has_subcalls;
@@ -1070,6 +1073,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.bss_shndx = -1;
 	obj->efile.st_ops_shndx = -1;
 	obj->kconfig_map_idx = -1;
+	obj->rodata_map_idx = -1;
 
 	obj->kern_version = get_kernel_version();
 	obj->loaded = false;
@@ -1428,6 +1432,8 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 						    obj->efile.rodata->d_size);
 		if (err)
 			return err;
+
+		obj->rodata_map_idx = obj->nr_maps - 1;
 	}
 	if (obj->efile.bss_shndx >= 0) {
 		err = bpf_object__init_internal_map(obj, LIBBPF_MAP_BSS,
@@ -3894,6 +3900,52 @@ static int probe_kern_probe_read_kernel(void)
 	return probe_fd(bpf_load_program_xattr(&attr, NULL, 0));
 }
 
+static int probe_prog_bind_map(void)
+{
+	struct bpf_load_program_attr prg_attr;
+	struct bpf_create_map_attr map_attr;
+	char *cp, errmsg[STRERR_BUFSIZE];
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int ret, map, prog;
+
+	memset(&map_attr, 0, sizeof(map_attr));
+	map_attr.map_type = BPF_MAP_TYPE_ARRAY;
+	map_attr.key_size = sizeof(int);
+	map_attr.value_size = 32;
+	map_attr.max_entries = 1;
+
+	map = bpf_create_map_xattr(&map_attr);
+	if (map < 0) {
+		ret = -errno;
+		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
+		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
+			__func__, cp, -ret);
+		return ret;
+	}
+
+	memset(&prg_attr, 0, sizeof(prg_attr));
+	prg_attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
+	prg_attr.insns = insns;
+	prg_attr.insns_cnt = ARRAY_SIZE(insns);
+	prg_attr.license = "GPL";
+
+	prog = bpf_load_program_xattr(&prg_attr, NULL, 0);
+	if (prog < 0) {
+		close(map);
+		return 0;
+	}
+
+	ret = bpf_prog_bind_map(prog, map, NULL);
+
+	close(map);
+	close(prog);
+
+	return ret >= 0;
+}
+
 enum kern_feature_result {
 	FEAT_UNKNOWN = 0,
 	FEAT_SUPPORTED = 1,
@@ -3934,6 +3986,9 @@ static struct kern_feature_desc {
 	},
 	[FEAT_PROBE_READ_KERN] = {
 		"bpf_probe_read_kernel() helper", probe_kern_probe_read_kernel,
+	},
+	[FEAT_PROG_BIND_MAP] = {
+		"BPF_PROG_BIND_MAP support", probe_prog_bind_map,
 	}
 };
 
@@ -6468,6 +6523,20 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	if (ret >= 0) {
 		if (log_buf && load_attr.log_level)
 			pr_debug("verifier log:\n%s", log_buf);
+
+		if (prog->obj->rodata_map_idx >= 0 &&
+		    kernel_supports(FEAT_PROG_BIND_MAP)) {
+			struct bpf_map *rodata_map =
+				&prog->obj->maps[prog->obj->rodata_map_idx];
+
+			if (bpf_prog_bind_map(ret, bpf_map__fd(rodata_map), NULL)) {
+				cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+				pr_warn("prog '%s': failed to bind .rodata map: %s\n",
+					prog->name, cp);
+				/* Don't fail hard if can't bind rodata. */
+			}
+		}
+
 		*pfd = ret;
 		ret = 0;
 		goto out;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 92ceb48a5ca2..5f054dadf082 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -302,6 +302,7 @@ LIBBPF_0.1.0 {
 
 LIBBPF_0.2.0 {
 	global:
+		bpf_prog_bind_map;
 		bpf_program__section_name;
 		perf_buffer__buffer_cnt;
 		perf_buffer__buffer_fd;
-- 
2.28.0.618.gf4bc123cb7-goog

