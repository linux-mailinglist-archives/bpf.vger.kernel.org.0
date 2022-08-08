Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ADF58CA2B
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbiHHOIv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbiHHOIt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:08:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6AEE02F
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:08:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7067CCE1104
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3C1C433D6;
        Mon,  8 Aug 2022 14:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967724;
        bh=CPh9o+TjDhpbKIvPyxl3RMPxAeLpPxDlSpJikR8AfLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgcIbYufgQXDRU2TRAmVPEmQTGF5ado9o7wIFVaq2TZUd6uYyTdEKXGVTb9vBapEa
         iYYfkpSnPCnHQBbbzzt2YRiIZfMMdXMktCDxr2UMvvFCTgt9GSEWqub3GAk2sFqTIM
         ktVzfwEaeP+JHNr2PkRtCnxqC5ULAGRH8USoLQkjy+j1pV02NUQY/uLkcDofbVzwHo
         uZ/Lk1XQnNz+iQZMMixAO1d3ABav70CEaTtp99dncnJaC2JBjmWHtvkprL9YvvmQDD
         YpK5b/iu08hqjaYTmf0BhQf9XG5nt3vipmOyEokNsPQAA5Ct5avp1+l9/FYBUS1z38
         0puuL53VdT5pA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC PATCH bpf-next 12/17] libbpf: Add btf__find_by_glob_kind function
Date:   Mon,  8 Aug 2022 16:06:21 +0200
Message-Id: <20220808140626.422731-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808140626.422731-1-jolsa@kernel.org>
References: <20220808140626.422731-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding btf__find_by_glob_kind function that returns array of
BTF ids that match given kind and allow/deny patterns.

int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
                           const char *allow_pattern,
                           const char *deny_pattern,
                           __u32 **__ids);

The __ids array is allocated and needs to be manually freed.

The pattern check is done by glob_match function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/btf.c             | 41 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h             |  3 +++
 tools/lib/bpf/libbpf.c          |  2 +-
 tools/lib/bpf/libbpf_internal.h |  1 +
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d14f1a52d7a..ffe08acb2f9b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -770,6 +770,47 @@ __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
 	return btf_find_by_name_kind(btf, 1, type_name, kind);
 }
 
+int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
+			   const char *allow_pattern, const char *deny_pattern,
+			   __u32 **__ids)
+{
+	__u32 i, nr_types = btf__type_cnt(btf);
+	int cnt = 0, alloc = 0;
+	__u32 *ids = NULL;
+
+	for (i = 1; i < nr_types; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+		const char *name;
+		__u32 *p;
+
+		if (btf_kind(t) != kind)
+			continue;
+		name = btf__name_by_offset(btf, t->name_off);
+		if (!name)
+			continue;
+
+		if (deny_pattern && glob_match(name, deny_pattern))
+			continue;
+		if (allow_pattern && !glob_match(name, allow_pattern))
+			continue;
+
+		if (cnt == alloc) {
+			alloc = max(16, alloc * 3 / 2);
+			p = libbpf_reallocarray(ids, alloc, sizeof(__u32));
+			if (!p) {
+				free(ids);
+				return -ENOMEM;
+			}
+			ids = p;
+		}
+		ids[cnt] = i;
+		cnt++;
+	}
+
+	*__ids = ids;
+	return cnt;
+}
+
 static bool btf_is_modifiable(const struct btf *btf)
 {
 	return (void *)btf->hdr != btf->raw_data;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 583760df83b4..4c05d2e77771 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -546,6 +546,9 @@ static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
 	return (struct btf_decl_tag *)(t + 1);
 }
 
+int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
+			   const char *allow_pattern, const char *deny_pattern,
+			   __u32 **__ids);
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 77e3797cf75a..0952eac92eab 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10153,7 +10153,7 @@ struct bpf_link *bpf_program__attach_ksyscall(const struct bpf_program *prog,
 }
 
 /* Adapted from perf/util/string.c */
-static bool glob_match(const char *str, const char *pat)
+bool glob_match(const char *str, const char *pat)
 {
 	while (*str && *pat && *pat != '*') {
 		if (*pat == '?') {      /* Matches any single character */
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 4135ae0a2bc3..9dfc11f26364 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -573,4 +573,5 @@ static inline bool is_pow_of_2(size_t x)
 	return x && (x & (x - 1)) == 0;
 }
 
+bool glob_match(const char *str, const char *pat);
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.37.1

