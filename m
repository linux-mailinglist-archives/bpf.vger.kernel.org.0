Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB08B27936E
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 23:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIYVZi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 17:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729654AbgIYVZN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 25 Sep 2020 17:25:13 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601069111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91CR67pYFNd7ytF4vVQShfDIdLJOkMbVvAU7CEP8OPs=;
        b=Rp9+K/SITDJHJZVgJLmbmF0qjccKBr7zls4+AgW3aufz4dVswfIjErhr2wxFONZM1O4puY
        nZT/zyANNnYYIRjW+gQyVTACYKxVd1shTC/nUe8uA3Sl6okqemQ8y2qNad17cR7Moe/cta
        NNKGeXGXs99F8uM8kZjMtYdfTS0LO5E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-1CjCCoz5MJGARf6So8i-DQ-1; Fri, 25 Sep 2020 17:25:09 -0400
X-MC-Unique: 1CjCCoz5MJGARf6So8i-DQ-1
Received: by mail-wm1-f71.google.com with SMTP id c200so126404wmd.5
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 14:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=91CR67pYFNd7ytF4vVQShfDIdLJOkMbVvAU7CEP8OPs=;
        b=rFGMTYGoOnGuhaGLFunlIoTR3oJC10GXzFU+HOos4LpDf+P86bZXDFnFcR37aws0Uk
         gn2IYQ6HeHUBYWaYc3kUaiMNpg2GYi3g10X+cZnPFtASaDkoF5sAhVZVkqqDwNpnXjIW
         iierNRf0SgNvoi1h+GEPoEv3oyy/Gx+GrfNqzoz3Z/yLe0gtDedtov/RnOM9KtTuqlzn
         j5EZN9ntMguO+4qvP05ZfA70T3q8VFi56KJBmvcn+pGpmd+8YM5WMAhxFK2q8LjjT616
         eHVrKE2Jam4XSpL6Q2Og4/eDtMin/jttqB0m6X0TUvgJRKtV6uzUzDyJSOmXb7zPTo7s
         WjPA==
X-Gm-Message-State: AOAM5331oMoLzioc+IfBTGfFGSRNEej9yJ7wKIJMn0CiGUeAdbPd/00o
        Fd0PPPX/J5Ocw4FkMzgRxMF7+n20eygthEI4jjepaOt0CzsNDXECp2sToetPE0oG/5oq7/RUl7K
        jorCb7zD9AAhr
X-Received: by 2002:adf:eb86:: with SMTP id t6mr6392404wrn.411.1601069108270;
        Fri, 25 Sep 2020 14:25:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx10Sq1i2VD0WofHO07gBXx5LaAkxXUX4/pzfeOIBry/1GwnCODBzTSMH5XzTkVQlzUc4eqtQ==
X-Received: by 2002:adf:eb86:: with SMTP id t6mr6392360wrn.411.1601069107809;
        Fri, 25 Sep 2020 14:25:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h76sm350603wme.10.2020.09.25.14.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 14:25:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F3472183C5B; Fri, 25 Sep 2020 23:25:06 +0200 (CEST)
Subject: [PATCH bpf-next v9 07/11] libbpf: add support for freplace attachment
 in bpf_link_create
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 25 Sep 2020 23:25:06 +0200
Message-ID: <160106910695.27725.11892692056199700116.stgit@toke.dk>
In-Reply-To: <160106909952.27725.8383447127582216829.stgit@toke.dk>
References: <160106909952.27725.8383447127582216829.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds support for supplying a target btf ID for the bpf_link_create()
operation, and adds a new bpf_program__attach_freplace() high-level API for
attaching freplace functions with a target.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/bpf.c      |   18 +++++++++++++++---
 tools/lib/bpf/bpf.h      |    3 ++-
 tools/lib/bpf/libbpf.c   |   44 +++++++++++++++++++++++++++++++++++++++-----
 tools/lib/bpf/libbpf.h   |    3 +++
 tools/lib/bpf/libbpf.map |    1 +
 5 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 2baa1308737c..75f627094790 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -586,19 +586,31 @@ int bpf_link_create(int prog_fd, int target_fd,
 		    enum bpf_attach_type attach_type,
 		    const struct bpf_link_create_opts *opts)
 {
+	__u32 target_btf_id, iter_info_len;
 	union bpf_attr attr;
 
 	if (!OPTS_VALID(opts, bpf_link_create_opts))
 		return -EINVAL;
 
+	iter_info_len = OPTS_GET(opts, iter_info_len, 0);
+	target_btf_id = OPTS_GET(opts, target_btf_id, 0);
+
+	if (iter_info_len && target_btf_id)
+		return -EINVAL;
+
 	memset(&attr, 0, sizeof(attr));
 	attr.link_create.prog_fd = prog_fd;
 	attr.link_create.target_fd = target_fd;
 	attr.link_create.attach_type = attach_type;
 	attr.link_create.flags = OPTS_GET(opts, flags, 0);
-	attr.link_create.iter_info =
-		ptr_to_u64(OPTS_GET(opts, iter_info, (void *)0));
-	attr.link_create.iter_info_len = OPTS_GET(opts, iter_info_len, 0);
+
+	if (iter_info_len) {
+		attr.link_create.iter_info =
+			ptr_to_u64(OPTS_GET(opts, iter_info, (void *)0));
+		attr.link_create.iter_info_len = iter_info_len;
+	} else if (target_btf_id) {
+		attr.link_create.target_btf_id = target_btf_id;
+	}
 
 	return sys_bpf(BPF_LINK_CREATE, &attr, sizeof(attr));
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 8c1ac4b42f90..6b8dbe24adc9 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -174,8 +174,9 @@ struct bpf_link_create_opts {
 	__u32 flags;
 	union bpf_iter_link_info *iter_info;
 	__u32 iter_info_len;
+	__u32 target_btf_id;
 };
-#define bpf_link_create_opts__last_field iter_info_len
+#define bpf_link_create_opts__last_field target_btf_id
 
 LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 32dc444224d8..a4f55f8a460d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9390,9 +9390,11 @@ static struct bpf_link *attach_iter(const struct bpf_sec_def *sec,
 }
 
 static struct bpf_link *
-bpf_program__attach_fd(struct bpf_program *prog, int target_fd,
+bpf_program__attach_fd(struct bpf_program *prog, int target_fd, int btf_id,
 		       const char *target_name)
 {
+	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, opts,
+			    .target_btf_id = btf_id);
 	enum bpf_attach_type attach_type;
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
@@ -9410,7 +9412,7 @@ bpf_program__attach_fd(struct bpf_program *prog, int target_fd,
 	link->detach = &bpf_link__detach_fd;
 
 	attach_type = bpf_program__get_expected_attach_type(prog);
-	link_fd = bpf_link_create(prog_fd, target_fd, attach_type, NULL);
+	link_fd = bpf_link_create(prog_fd, target_fd, attach_type, &opts);
 	if (link_fd < 0) {
 		link_fd = -errno;
 		free(link);
@@ -9426,19 +9428,51 @@ bpf_program__attach_fd(struct bpf_program *prog, int target_fd,
 struct bpf_link *
 bpf_program__attach_cgroup(struct bpf_program *prog, int cgroup_fd)
 {
-	return bpf_program__attach_fd(prog, cgroup_fd, "cgroup");
+	return bpf_program__attach_fd(prog, cgroup_fd, 0, "cgroup");
 }
 
 struct bpf_link *
 bpf_program__attach_netns(struct bpf_program *prog, int netns_fd)
 {
-	return bpf_program__attach_fd(prog, netns_fd, "netns");
+	return bpf_program__attach_fd(prog, netns_fd, 0, "netns");
 }
 
 struct bpf_link *bpf_program__attach_xdp(struct bpf_program *prog, int ifindex)
 {
 	/* target_fd/target_ifindex use the same field in LINK_CREATE */
-	return bpf_program__attach_fd(prog, ifindex, "xdp");
+	return bpf_program__attach_fd(prog, ifindex, 0, "xdp");
+}
+
+struct bpf_link *bpf_program__attach_freplace(struct bpf_program *prog,
+					      int target_fd,
+					      const char *attach_func_name)
+{
+	int btf_id;
+
+	if (!!target_fd != !!attach_func_name) {
+		pr_warn("prog '%s': supply none or both of target_fd and attach_func_name\n",
+			prog->name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (prog->type != BPF_PROG_TYPE_EXT) {
+		pr_warn("prog '%s': only BPF_PROG_TYPE_EXT can attach as freplace",
+			prog->name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (target_fd) {
+		btf_id = libbpf_find_prog_btf_id(attach_func_name, target_fd);
+		if (btf_id < 0)
+			return ERR_PTR(btf_id);
+
+		return bpf_program__attach_fd(prog, target_fd, btf_id, "freplace");
+	} else {
+		/* no target, so use raw_tracepoint_open for compatibility
+		 * with old kernels
+		 */
+		return bpf_program__attach_trace(prog);
+	}
 }
 
 struct bpf_link *
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index a750f67a23f6..6909ee81113a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -261,6 +261,9 @@ LIBBPF_API struct bpf_link *
 bpf_program__attach_netns(struct bpf_program *prog, int netns_fd);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_xdp(struct bpf_program *prog, int ifindex);
+LIBBPF_API struct bpf_link *
+bpf_program__attach_freplace(struct bpf_program *prog,
+			     int target_fd, const char *attach_func_name);
 
 struct bpf_map;
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5f054dadf082..b1c537873b23 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -303,6 +303,7 @@ LIBBPF_0.1.0 {
 LIBBPF_0.2.0 {
 	global:
 		bpf_prog_bind_map;
+		bpf_program__attach_freplace;
 		bpf_program__section_name;
 		perf_buffer__buffer_cnt;
 		perf_buffer__buffer_fd;

