Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6302B55EB40
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiF1Rnj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 13:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiF1Rng (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 13:43:36 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1F825EC
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:31 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id j5-20020a170902da8500b0016b90578019so1101590plx.5
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OfOmFF3x0paANMTRsZmlz3M5YweUU7pTeuMecuKy5YM=;
        b=eflQQdShJS4qHghrd2Thz3lvJ7Hq/aZzS5/+hKkH9xWsUtRuLACdRZFrU9LsYJAcUb
         595x7Q6b+hOs+ns+0lWZL2PjHstejCscI+h+sdyZkZar1Rtct0GELx3p3EQqnMj8DKyn
         8fG3PohxuBDSkd72vt+TZyRv5kUcdFAw+p1hhL7TAnRB8rynBmdbRAju6BoQBq+uKg2t
         EJjSZYEEZkEU4PG+P7DpyOb0cm8KpQrmCmwZfLMyMw59w4R1J/rHpK2QGHPKrloTSufG
         7RIBQ6QsNh8HI2pW+MBGEdglVs9PIfQm1nHeQCNOwSsu105FmUvvCBG8K1e/tOhImVuH
         z0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OfOmFF3x0paANMTRsZmlz3M5YweUU7pTeuMecuKy5YM=;
        b=yFxTnCncByhJQyzd0iTpMtIpECpjXk9C4LGtK0rKSR5dTPxXHdCmtizZZtZy2NPSLk
         ffDhheHqS1lnee6K2Xb+qSNc9+vN/VJQQwiUX16e+XdrTs0+QE8pwSISCS7ujX29gekE
         UeGrdSPtGOgAZF0aMo0w/Vo8oJ98cR1wPEt+/9cL0ZkE7MB6aK++A6i4dL4NuM3ty22v
         a1o9F/AplLUVDHGs1sYJQR8PGPgeV2OXXlqEZtvGokHpA1sYyGmtlcGzSthKb5Fr0n1+
         KZllQrzLo3gjpXmPFoI9YQKWYK/tif1X9D86KaxKQpnlHKLfSU1ZE9ii/tLZbBtxT8nP
         jetg==
X-Gm-Message-State: AJIora+047V5Mr9rImjIY+SpH4sRcmKve4o79ezqYYdCAi7eTmtSGrfb
        AemIYl0g9FtLQ40HuACli0hyz6+tXffBXl0gdVmhy2z6bei56SYbFpsMWFuqkzgMGFQbH39S1Ct
        zCp4bvckQGAmBKEJggB5unPatbluXtbcfGVJ4A+lhuqhOoepWjg==
X-Google-Smtp-Source: AGRyM1uuWAxQc8E60tNY76sEXmvdbOPfvwxgqtqcXbtADafBIF2/xtA7uQD9adwQb5++lg9T7wEhuHk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:2bc3:0:b0:411:66bf:9ce3 with SMTP id
 r186-20020a632bc3000000b0041166bf9ce3mr2280991pgr.165.1656438211278; Tue, 28
 Jun 2022 10:43:31 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:43:12 -0700
In-Reply-To: <20220628174314.1216643-1-sdf@google.com>
Message-Id: <20220628174314.1216643-10-sdf@google.com>
Mime-Version: 1.0
References: <20220628174314.1216643-1-sdf@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next v11 09/11] libbpf: implement bpf_prog_query_opts
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement bpf_prog_query_opts as a more expendable version of
bpf_prog_query. Expose new prog_attach_flags and attach_btf_func_id as
well:

* prog_attach_flags is a per-program attach_type; relevant only for
  lsm cgroup program which might have different attach_flags
  per attach_btf_id
* attach_btf_func_id is a new field expose for prog_query which
  specifies real btf function id for lsm cgroup attachments

Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/bpf.c      | 38 +++++++++++++++++++++++++++++++-------
 tools/lib/bpf/bpf.h      | 15 +++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 240186aac8e6..accc97cf9928 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -888,24 +888,48 @@ int bpf_iter_create(int link_fd)
 	return libbpf_err_errno(fd);
 }
 
-int bpf_prog_query(int target_fd, enum bpf_attach_type type, __u32 query_flags,
-		   __u32 *attach_flags, __u32 *prog_ids, __u32 *prog_cnt)
+int bpf_prog_query_opts(int target_fd,
+			enum bpf_attach_type type,
+			struct bpf_prog_query_opts *opts)
 {
 	union bpf_attr attr;
 	int ret;
 
+	if (!OPTS_VALID(opts, bpf_prog_query_opts))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, sizeof(attr));
+
 	attr.query.target_fd	= target_fd;
 	attr.query.attach_type	= type;
-	attr.query.query_flags	= query_flags;
-	attr.query.prog_cnt	= *prog_cnt;
-	attr.query.prog_ids	= ptr_to_u64(prog_ids);
+	attr.query.query_flags	= OPTS_GET(opts, query_flags, 0);
+	attr.query.prog_cnt	= OPTS_GET(opts, prog_cnt, 0);
+	attr.query.prog_ids	= ptr_to_u64(OPTS_GET(opts, prog_ids, NULL));
+	attr.query.prog_attach_flags = ptr_to_u64(OPTS_GET(opts, prog_attach_flags, NULL));
 
 	ret = sys_bpf(BPF_PROG_QUERY, &attr, sizeof(attr));
 
+	OPTS_SET(opts, attach_flags, attr.query.attach_flags);
+	OPTS_SET(opts, prog_cnt, attr.query.prog_cnt);
+
+	return libbpf_err_errno(ret);
+}
+
+int bpf_prog_query(int target_fd, enum bpf_attach_type type, __u32 query_flags,
+		   __u32 *attach_flags, __u32 *prog_ids, __u32 *prog_cnt)
+{
+	LIBBPF_OPTS(bpf_prog_query_opts, opts);
+	int ret;
+
+	opts.query_flags = query_flags;
+	opts.prog_ids = prog_ids;
+	opts.prog_cnt = *prog_cnt;
+
+	ret = bpf_prog_query_opts(target_fd, type, &opts);
+
 	if (attach_flags)
-		*attach_flags = attr.query.attach_flags;
-	*prog_cnt = attr.query.prog_cnt;
+		*attach_flags = opts.attach_flags;
+	*prog_cnt = opts.prog_cnt;
 
 	return libbpf_err_errno(ret);
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index cabc03703e29..e8f70ce6b537 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -442,9 +442,24 @@ LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
+
+struct bpf_prog_query_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 query_flags;
+	__u32 attach_flags; /* output argument */
+	__u32 *prog_ids;
+	__u32 prog_cnt; /* input+output argument */
+	__u32 *prog_attach_flags;
+};
+#define bpf_prog_query_opts__last_field prog_attach_flags
+
+LIBBPF_API int bpf_prog_query_opts(int target_fd,
+				   enum bpf_attach_type type,
+				   struct bpf_prog_query_opts *opts);
 LIBBPF_API int bpf_prog_query(int target_fd, enum bpf_attach_type type,
 			      __u32 query_flags, __u32 *attach_flags,
 			      __u32 *prog_ids, __u32 *prog_cnt);
+
 LIBBPF_API int bpf_raw_tracepoint_open(const char *name, int prog_fd);
 LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
 				 __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 116a2a8ee7c2..03c69cb821b3 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -462,6 +462,7 @@ LIBBPF_0.8.0 {
 
 LIBBPF_1.0.0 {
 	global:
+		bpf_prog_query_opts;
 		btf__add_enum64;
 		btf__add_enum64_value;
 		libbpf_bpf_attach_type_str;
-- 
2.37.0.rc0.161.g10f37bed90-goog

