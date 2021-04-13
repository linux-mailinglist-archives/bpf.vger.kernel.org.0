Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B92C35DAE7
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 11:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245592AbhDMJQp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 05:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245611AbhDMJQm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 05:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618305381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rl3u6G0sgRgVtBxAl6voZ2FF18vI+m2QO+lKCaXhXHc=;
        b=WSIPRUr1dOToWbe/WGyBotHF/LyiIXwcA+UMKbX2gXYHDxcOL2NBx+4UaZk+FAHttx1YlV
        XlVYP6XxUHGR76QDnDPPIPQb54yxY0+qD/graYa3v5gcmJkeHsHoHC/iMlhk7xQbs/0f6B
        D69v4iE0dngYVAG0GCu1M37qihnF51c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-LX29eqYsOeqKhScp4f7s_g-1; Tue, 13 Apr 2021 05:16:20 -0400
X-MC-Unique: LX29eqYsOeqKhScp4f7s_g-1
Received: by mail-ed1-f70.google.com with SMTP id l9-20020a0564021249b02903827849a98dso942628edw.6
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 02:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rl3u6G0sgRgVtBxAl6voZ2FF18vI+m2QO+lKCaXhXHc=;
        b=AQkeU/BTX7znf4IvSGabqu3qTqYF/TWO7/P1Yej26n2K3hB7l+bSB+kUEcfmEq0faq
         /JY0b699mW97vcXQO3jyLxibkMU3wc3Ak4w+2Dsl2pq+qsXlZJxGtZSCP12OxPpUS0P9
         eDgJMVCmnDJAppyfV0s0woqJtS89bUdpi215mgzoB5Lr9DoU7f68tLbuBXEY5ccmdRRd
         nUtv7pgyoc2xzEYBA6J4u/g7InwoeBgnSz3X1DI5w9yKvbTKBnhuGMnhJyeWYN3/ROvr
         r+Y+cq4xc4eukb4ix/e+kI6Z+Z+CwWQozb7iSzdk6lgMSmOzmOVDqZIi8kdEXSt5UBVy
         7nbg==
X-Gm-Message-State: AOAM531p3G4kMZ+Rx5AwZaDihxAxwWQb5syvfFO2xOz5xGpRWXoWUDQe
        nWVDB/0w0h0SVTs73q5RxBSxopv8NtZuNnVgnACNeMzwIBsEQ0DenWVqc4FV2sY7ucOUGf+6rGt
        4sOgwTpFlDfV7
X-Received: by 2002:a05:6402:520b:: with SMTP id s11mr34276365edd.212.1618305376180;
        Tue, 13 Apr 2021 02:16:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyES2low8Z5VP3nZ8zX5UWU17TTIaReKMRvfYx5lyn6Az5AUnD0dXEbXcm0eWXPbEkoFgGOig==
X-Received: by 2002:a05:6402:520b:: with SMTP id s11mr34276345edd.212.1618305375971;
        Tue, 13 Apr 2021 02:16:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t7sm3869193ejo.120.2021.04.13.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:16:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E88B7180615; Tue, 13 Apr 2021 11:16:14 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add tests for target information in bpf_link info queries
Date:   Tue, 13 Apr 2021 11:16:07 +0200
Message-Id: <20210413091607.58945-2-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210413091607.58945-1-toke@redhat.com>
References: <20210413091607.58945-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the fexit_bpf2bpf test to check that the info for the bpf_link
returned by the kernel matches the expected values.

While we're updating the test, change existing uses of CHEC() to use the
much easier to read ASSERT_*() macros.

v2:
- Convert last CHECK() call and get rid of 'duration' var
- Split ASSERT_OK_PTR() checks to two separate if statements

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 58 ++++++++++++++-----
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 5c0448910426..63990842d20f 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -58,42 +58,73 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 				      test_cb cb)
 {
 	struct bpf_object *obj = NULL, *tgt_obj;
+	__u32 retval, tgt_prog_id, info_len;
+	struct bpf_prog_info prog_info = {};
 	struct bpf_program **prog = NULL;
 	struct bpf_link **link = NULL;
-	__u32 duration = 0, retval;
 	int err, tgt_fd, i;
+	struct btf *btf;
 
 	err = bpf_prog_load(target_obj_file, BPF_PROG_TYPE_UNSPEC,
 			    &tgt_obj, &tgt_fd);
-	if (CHECK(err, "tgt_prog_load", "file %s err %d errno %d\n",
-		  target_obj_file, err, errno))
+	if (!ASSERT_OK(err, "tgt_prog_load"))
 		return;
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
 			    .attach_prog_fd = tgt_fd,
 			   );
 
+	info_len = sizeof(prog_info);
+	err = bpf_obj_get_info_by_fd(tgt_fd, &prog_info, &info_len);
+	if (!ASSERT_OK(err, "tgt_fd_get_info"))
+		goto close_prog;
+
+	tgt_prog_id = prog_info.id;
+	btf = bpf_object__btf(tgt_obj);
+
 	link = calloc(sizeof(struct bpf_link *), prog_cnt);
+	if (!ASSERT_OK_PTR(link, "link_ptr"))
+		goto close_prog;
+
 	prog = calloc(sizeof(struct bpf_program *), prog_cnt);
-	if (CHECK(!link || !prog, "alloc_memory", "failed to alloc memory"))
+	if (!ASSERT_OK_PTR(prog, "prog_ptr"))
 		goto close_prog;
 
 	obj = bpf_object__open_file(obj_file, &opts);
-	if (CHECK(IS_ERR_OR_NULL(obj), "obj_open",
-		  "failed to open %s: %ld\n", obj_file,
-		  PTR_ERR(obj)))
+	if (!ASSERT_OK_PTR(obj, "obj_open"))
 		goto close_prog;
 
 	err = bpf_object__load(obj);
-	if (CHECK(err, "obj_load", "err %d\n", err))
+	if (!ASSERT_OK(err, "obj_load"))
 		goto close_prog;
 
 	for (i = 0; i < prog_cnt; i++) {
+		struct bpf_link_info link_info;
+		char *tgt_name;
+		__s32 btf_id;
+
+		tgt_name = strstr(prog_name[i], "/");
+		if (!ASSERT_OK_PTR(tgt_name, "tgt_name"))
+			goto close_prog;
+		btf_id = btf__find_by_name_kind(btf, tgt_name + 1, BTF_KIND_FUNC);
+
 		prog[i] = bpf_object__find_program_by_title(obj, prog_name[i]);
-		if (CHECK(!prog[i], "find_prog", "prog %s not found\n", prog_name[i]))
+		if (!ASSERT_OK_PTR(prog[i], prog_name[i]))
 			goto close_prog;
+
 		link[i] = bpf_program__attach_trace(prog[i]);
-		if (CHECK(IS_ERR(link[i]), "attach_trace", "failed to link\n"))
+		if (!ASSERT_OK_PTR(link[i], "attach_trace"))
 			goto close_prog;
+
+		info_len = sizeof(link_info);
+		memset(&link_info, 0, sizeof(link_info));
+		err = bpf_obj_get_info_by_fd(bpf_link__fd(link[i]),
+					     &link_info, &info_len);
+		ASSERT_OK(err, "link_fd_get_info");
+		ASSERT_EQ(link_info.tracing.attach_type,
+			  bpf_program__get_expected_attach_type(prog[i]),
+			  "link_attach_type");
+		ASSERT_EQ(link_info.tracing.target_obj_id, tgt_prog_id, "link_tgt_obj_id");
+		ASSERT_EQ(link_info.tracing.target_btf_id, btf_id, "link_tgt_btf_id");
 	}
 
 	if (cb) {
@@ -106,10 +137,9 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 		goto close_prog;
 
 	err = bpf_prog_test_run(tgt_fd, 1, &pkt_v6, sizeof(pkt_v6),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "ipv6",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
+				NULL, NULL, &retval, NULL);
+	ASSERT_OK(err, "prog_run");
+	ASSERT_EQ(retval, 0, "prog_run_ret");
 
 	if (check_data_map(obj, prog_cnt, false))
 		goto close_prog;
-- 
2.31.1

