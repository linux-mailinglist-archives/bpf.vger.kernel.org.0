Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE353C85D9
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 16:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhGNOSm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 10:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhGNOSl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 10:18:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDACC061765
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 07:15:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso1524936wmj.4
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KnV1IxvXRQoR00fEj1yWcBXzpeN1it4YJCVUINfscbk=;
        b=PLSU9UfQ4FbWS0Zps9YzeqR+qUSHaTWyYhANYa2EQCh1xekU6PbcRRBlLCr/SSlilc
         i1QHDfWRF86U2OKRmZiChuDFYMtQDvNRoMBRrh8lI2OfgNYjUgziLYgDZANQZlvBA2cY
         1YrcSUYj6iLr5GCKS2kpd948q5Xvsvy3gPjtz2WBc9f/aInhTVcBu2uQse6gVU26o4Q1
         qqMZ9rh6P6GMKstdnTTRkFlLnqCmdFEuvJ8PfUSzmSwBW13WaZTpEZ6Yy8o5SxVR18s5
         miO+kZlsQOSNjifJUHGts79GcnzeG6z8DQbj6ssC3NClhKuHhrNrLuzQyFSau6ONOp5J
         qJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KnV1IxvXRQoR00fEj1yWcBXzpeN1it4YJCVUINfscbk=;
        b=jBIJnWLObNQJs5KDuQTDmK0l1zOL3ZMhoNQzu7u2TIfFCy6bqohzU48P347jdB8+4T
         a/f6IDoI9McP1PVHgyiKH2Bi2+gaBZ4n3b3sg31O0YLXLUQQlLBez4hpY6AmBx1fdZTg
         qBTcGsWJeXH3S9PgMO2QKdZiUsmqwHbEsg1iH/1Nm0zXy2SAGgSnknIMKoP2W5web8F9
         7WkFxGq/tLKG0e9MVnj7/UlWdav1v0amqlmpETspZ9BB8ZjduPzguE1+Y0DEC7A2hNLz
         YJwBwJQiOcHR20yJ7CO9+SRGza//haYU9yf2r20/B8mz+51/yS4AYfuRrtcpcaUrQCxP
         Ujgg==
X-Gm-Message-State: AOAM530/1THQhRoHV2Q7EHUV/7Vzy730w8NAxrafM6OiubMIlTOw+SYu
        b8dMKFoanGrYlJY7/peiQKPbEg==
X-Google-Smtp-Source: ABdhPJzOo5vmz7mcCJLZ/ajcg6ZW/XTcy/zt2U3R9LVJ4Atwy8Aamfvhpv/Xp/eeD2k/02qEwDbl7w==
X-Received: by 2002:a1c:25c6:: with SMTP id l189mr4477132wml.49.1626272148002;
        Wed, 14 Jul 2021 07:15:48 -0700 (PDT)
Received: from localhost.localdomain ([149.86.90.174])
        by smtp.gmail.com with ESMTPSA id a207sm6380037wme.27.2021.07.14.07.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 07:15:47 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 3/6] tools: replace btf__get_from_id() with btf__load_from_kernel_by_id()
Date:   Wed, 14 Jul 2021 15:15:29 +0100
Message-Id: <20210714141532.28526-4-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714141532.28526-1-quentin@isovalent.com>
References: <20210714141532.28526-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace the calls to deprecated function btf__get_from_id() with calls
to btf__load_from_kernel_by_id() in tools/ (bpftool, perf, selftests).

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/btf.c                      | 2 +-
 tools/bpf/bpftool/btf_dumper.c               | 2 +-
 tools/bpf/bpftool/map.c                      | 4 ++--
 tools/bpf/bpftool/prog.c                     | 6 +++---
 tools/perf/util/bpf-event.c                  | 4 ++--
 tools/perf/util/bpf_counter.c                | 2 +-
 tools/testing/selftests/bpf/prog_tests/btf.c | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 385d5c955cf3..2296e8eba0ff 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -580,7 +580,7 @@ static int do_dump(int argc, char **argv)
 	}
 
 	if (!btf) {
-		err = btf__get_from_id(btf_id, &btf);
+		err = btf__load_from_kernel_by_id(btf_id, &btf);
 		if (err) {
 			p_err("get btf by id (%u): %s", btf_id, strerror(err));
 			goto done;
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 7ca54d046362..92db1fccda49 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -65,7 +65,7 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
 	info = &prog_info->info;
 
 	if (!info->btf_id || !info->nr_func_info ||
-	    btf__get_from_id(info->btf_id, &prog_btf))
+	    btf__load_from_kernel_by_id(info->btf_id, &prog_btf))
 		goto print;
 	finfo = u64_to_ptr(info->func_info);
 	func_type = btf__type_by_id(prog_btf, finfo->type_id);
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 09ae0381205b..69ced1af0ab1 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -807,7 +807,7 @@ static struct btf *get_map_kv_btf(const struct bpf_map_info *info)
 	} else if (info->btf_value_type_id) {
 		int err;
 
-		err = btf__get_from_id(info->btf_id, &btf);
+		err = btf__load_from_kernel_by_id(info->btf_id, &btf);
 		if (err || !btf) {
 			p_err("failed to get btf");
 			btf = err ? ERR_PTR(err) : ERR_PTR(-ESRCH);
@@ -1042,7 +1042,7 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 	struct btf *btf = NULL;
 	int err;
 
-	err = btf__get_from_id(info->btf_id, &btf);
+	err = btf__load_from_kernel_by_id(info->btf_id, &btf);
 	if (err) {
 		p_err("failed to get btf");
 		return;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index cc48726740ad..663828f96358 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -263,7 +263,7 @@ static void show_prog_metadata(int fd, __u32 num_maps)
 	if (!value)
 		return;
 
-	err = btf__get_from_id(map_info.btf_id, &btf);
+	err = btf__load_from_kernel_by_id(map_info.btf_id, &btf);
 	if (err || !btf)
 		goto out_free;
 
@@ -646,7 +646,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 		member_len = info->xlated_prog_len;
 	}
 
-	if (info->btf_id && btf__get_from_id(info->btf_id, &btf)) {
+	if (info->btf_id && btf__load_from_kernel_by_id(info->btf_id, &btf)) {
 		p_err("failed to get btf");
 		return -1;
 	}
@@ -2013,7 +2013,7 @@ static char *profile_target_name(int tgt_fd)
 	}
 
 	if (info_linear->info.btf_id == 0 ||
-	    btf__get_from_id(info_linear->info.btf_id, &btf)) {
+	    btf__load_from_kernel_by_id(info_linear->info.btf_id, &btf)) {
 		p_err("prog FD %d doesn't have valid btf", tgt_fd);
 		goto out;
 	}
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index cdecda1ddd36..5e0aa7d379f0 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -223,7 +223,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 			free(info_linear);
 			return -1;
 		}
-		if (btf__get_from_id(info->btf_id, &btf)) {
+		if (btf__load_from_kernel_by_id(info->btf_id, &btf)) {
 			pr_debug("%s: failed to get BTF of id %u, aborting\n", __func__, info->btf_id);
 			err = -1;
 			btf = NULL;
@@ -478,7 +478,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	if (btf_id == 0)
 		goto out;
 
-	if (btf__get_from_id(btf_id, &btf)) {
+	if (btf__load_from_kernel_by_id(btf_id, &btf)) {
 		pr_debug("%s: failed to get BTF of id %u, aborting\n",
 			 __func__, btf_id);
 		goto out;
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 5ed674a2f55e..9b9d24016772 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -85,7 +85,7 @@ static char *bpf_target_prog_name(int tgt_fd)
 	}
 
 	if (info_linear->info.btf_id == 0 ||
-	    btf__get_from_id(info_linear->info.btf_id, &btf)) {
+	    btf__load_from_kernel_by_id(info_linear->info.btf_id, &btf)) {
 		pr_debug("prog FD %d doesn't have valid btf\n", tgt_fd);
 		goto out;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 857e3f26086f..60e0be02931d 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4350,7 +4350,7 @@ static void do_test_file(unsigned int test_num)
 		goto done;
 	}
 
-	err = btf__get_from_id(info.btf_id, &btf);
+	err = btf__load_from_kernel_by_id(info.btf_id, &btf);
 	if (CHECK(err, "cannot get btf from kernel, err: %d", err))
 		goto done;
 
-- 
2.30.2

