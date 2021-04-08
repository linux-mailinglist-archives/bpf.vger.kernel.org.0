Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71821358DEC
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 21:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhDHT6L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 15:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232014AbhDHT6K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 15:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617911878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6FLmG+khv36V3Uw5aFDk67/lChGeNIu/BpMAHAPTvWU=;
        b=U3xEIc9SIflM+hzoElmDHH9wgzZyJ0l8RwyZtwXaCV9QhQsXumJUSmiaZ3dvrcwMEpcixU
        ZR86BZyEJqI3ioURKhTsSDU9OX+NWjB1U7bXiVhbVh3UiJ6mDEbdsfgT7IWjew5aX6ox9c
        IRFewNHmkmVQGdBi9aXaMEigOso1OBc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-rad8voQrMY-XLC3lsO53Qg-1; Thu, 08 Apr 2021 15:57:54 -0400
X-MC-Unique: rad8voQrMY-XLC3lsO53Qg-1
Received: by mail-ej1-f70.google.com with SMTP id bg7so1339228ejb.12
        for <bpf@vger.kernel.org>; Thu, 08 Apr 2021 12:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FLmG+khv36V3Uw5aFDk67/lChGeNIu/BpMAHAPTvWU=;
        b=XzKZ+EnDgmatf6mf9aUjuj7lxeyWKFvhgUNfpbFh7X2ULuIBNProaVQsF2jZZpVb8v
         XBHIKReVBevNqoHr1niShQ1hiUvkmn2g/yW0Unm37QWiv3SZd0i0qGwba1BpLoZPSuyS
         aEFQXNXKVWZLQAkLyI68xIMNw1AXTlylgRPQbdCuifUWuJKArhK8hlQf+d/p2520q4ya
         zZGGoXb2BRdeghttJ46LOap0glJTNzO19k4lSsJ+su+mWNCXLVcAdjSEDTKRHkXgUhBh
         4QkPSYTTX77t3q/QhyL7QbPwTJjRMExsDA4ZV9DhT1/QEwuQJjUOuc4WYZLZBxXl84kZ
         v2bQ==
X-Gm-Message-State: AOAM5303l0Z9cBhCTOBCh9DqNvZlmckltsVpaUOdDTKvj7NmiGulCk3c
        foeXFdIJLHrN5iC2uDOfOKnEIptTYxM0t5b9KkDmG8FijVniFSwkJnuTJ3FEFGJkFsueQNg7YCB
        s1bVVr0J5t1OL
X-Received: by 2002:a05:6402:440d:: with SMTP id y13mr13939541eda.316.1617911873284;
        Thu, 08 Apr 2021 12:57:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtW6dF9kTWVU6j1pW/3ISNYtFkTyVw59JpS4b22dcu95HHVgu6RVmlDJ6Ti/viXvdCB9jHWw==
X-Received: by 2002:a05:6402:440d:: with SMTP id y13mr13939525eda.316.1617911873096;
        Thu, 08 Apr 2021 12:57:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id hz24sm164309ejc.119.2021.04.08.12.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:57:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EA9DF180350; Thu,  8 Apr 2021 21:57:51 +0200 (CEST)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: add tests for target information in bpf_link info queries
Date:   Thu,  8 Apr 2021 21:57:40 +0200
Message-Id: <20210408195740.153029-2-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408195740.153029-1-toke@redhat.com>
References: <20210408195740.153029-1-toke@redhat.com>
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

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 50 +++++++++++++++----
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 5c0448910426..019a46d8e98e 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -57,11 +57,13 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 				      bool run_prog,
 				      test_cb cb)
 {
+	__u32 duration = 0, retval, tgt_prog_id, info_len;
 	struct bpf_object *obj = NULL, *tgt_obj;
+	struct bpf_prog_info prog_info = {};
 	struct bpf_program **prog = NULL;
 	struct bpf_link **link = NULL;
-	__u32 duration = 0, retval;
 	int err, tgt_fd, i;
+	struct btf *btf;
 
 	err = bpf_prog_load(target_obj_file, BPF_PROG_TYPE_UNSPEC,
 			    &tgt_obj, &tgt_fd);
@@ -72,28 +74,55 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
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
 	prog = calloc(sizeof(struct bpf_program *), prog_cnt);
-	if (CHECK(!link || !prog, "alloc_memory", "failed to alloc memory"))
+	if (!ASSERT_OK_PTR(link, "link_ptr") || !ASSERT_OK_PTR(prog, "prog_ptr"))
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
@@ -107,9 +136,8 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 
 	err = bpf_prog_test_run(tgt_fd, 1, &pkt_v6, sizeof(pkt_v6),
 				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "ipv6",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
+	ASSERT_OK(err, "prog_run");
+	ASSERT_EQ(retval, 0, "prog_run_ret");
 
 	if (check_data_map(obj, prog_cnt, false))
 		goto close_prog;
-- 
2.31.1

