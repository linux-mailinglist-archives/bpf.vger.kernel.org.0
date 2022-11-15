Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E88628DE1
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 01:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiKOACB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 19:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbiKOABz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 19:01:55 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A17EF3F
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:54 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id m6so12610020pfb.0
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qiFDbqjXUxto4VZlgYzZmUfXOGly2z0K0YGSO0F0m8=;
        b=GDF4RsjJyLpg+kMFiMSR2t1PJY1t+uB37VdqwwkWCSJjOcc7YIbUa6/Tng+33FrqGr
         b2tHLO2BOYmphwWMw5AfQkAgrFqlsHj7/zvtqK5Ttc2CHfL+tBEdQ0vCOLyTYkHu1/R8
         xQTSY3T6E4PtIPVSE32O+ULKzqvd5NgjyK4bMDd4oi65sVulDp3jQLnZV/GPNwr0ROMo
         EM9RRmgHUvoroJ/N06L0ornc7eQSK7GzB6URWOp5aXBWZ+/hwrcCyNEkPGLwCgWw0ah9
         R+QZff+wqRI49164exImOHGN1tsO/w6wqNcKdQMgvk2WxKNYbDccTWsl8JZNY+QT8W3y
         40bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qiFDbqjXUxto4VZlgYzZmUfXOGly2z0K0YGSO0F0m8=;
        b=8HJwtGgY6t57NnPXznDvgxs6WB/d6Eta5eMXn25AfcyXeHxfvxTPQtksnwHviygLrB
         cbfnd7WzSv1e7AMnJhATq8uAySybwl88eJinzS7sGiAO0k25ntLgDHqwyjNKn70M61N5
         eY+VtgOQTQMO4T+dMa/BS7TuJWQcX9nkHiIeup0rce+7rrVMRGHXaguKLlkJKfwXvL1n
         Xjh9UnuGY4dFfhpUlwirfRCOPY+FvSJDwdZuTerVXcU9e45Ii7EjyGD7Aq+on5C5J46S
         95dFfUmzigwwztcrqHlK5MujWZut2Zrv742ABdi56GZNPKd5toU2jNQpgrpfKQEktDLP
         XR/g==
X-Gm-Message-State: ANoB5pkJB3z6VW6VH/6rQXkexRv4zBKzIFvqdWylgA2+BoxXgqFs/mc3
        1FD3yXfbOSmEi7oiWl3qKBDiON8wNktMRw==
X-Google-Smtp-Source: AA0mqf713gNI7CTI0lgC1Cjvu/j4qEblzw5kPeDjohTT4UI66o3oPPav5hRFdAIdQIz4hW8i8EPhTQ==
X-Received: by 2002:a63:e242:0:b0:473:e502:71d3 with SMTP id y2-20020a63e242000000b00473e50271d3mr13742939pgj.227.1668470513707;
        Mon, 14 Nov 2022 16:01:53 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id ne5-20020a17090b374500b0020b2082e0acsm7112233pjb.0.2022.11.14.16.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:01:53 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     David Vernet <void@manifault.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 7/7] selftests/bpf: Add test for dynptr reinit in user_ringbuf callback
Date:   Tue, 15 Nov 2022 05:31:30 +0530
Message-Id: <20221115000130.1967465-8-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115000130.1967465-1-memxor@gmail.com>
References: <20221115000130.1967465-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3072; i=memxor@gmail.com; h=from:subject; bh=KGMe3EiZxZpqYFfmV01eKi4iWDkcxxO+yLBDjrSQ6BI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjctaCB6l5QzhsTIZ2pAWx0VJpr8Fn4ORBOChmz815 qyXDiXaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3LWggAKCRBM4MiGSL8RypFNEA CellLPu+8tenKkc0gDDOhuSDOp8xh6cgKl8lGpMeGw+H9C+6sDaYOe79psNl1BqRTkH74EbTR5BPq7 cDU/kZKMIekG+9/S1xXcVUIDgxj8vfCQm9GaVMgmj4ZNC4nngcXjdslk0cU695pqEtAo2SVr47Z+hr FoBWTJiqYl6zgaV2NC969SD06nuHdncekkt/t30FsH2luj7BMHbPbbprq1R3rPSAFfDdoeYu6ZBviq FFLRNRmHlzD7cD8ArGU6yYDrXT7JNKNb7LdRCiqAzNyZT/HKdTomm7rxABjIVfoiLtZGiZnVMcV+lI qGFm+S7pgv9g9PZiTHEfdLuPsa11XpLwn8eJ5Mb0sDT/jI0wEXVxb61pBfXbMfJJyUdKUrs7grUnk/ cJKcxUDt5b4S0miC4PTK5a2lmpI+HStSAw5YffXqy/xORHf1H7x9eg3g3nMgsmnBMG0ID2Vm0ZgEJr 63a7KsaRrh5vH95+21zZGDgXtZyKnc5zJkU7lcccy9J21MZYW0B71R2H3Qlyf/NamI2QM+BI4B9fa2 1/gOtoAvsE5Ynwz5EbQn/GVKQ8rO3E+47YGdnwHeIEYNZhY4lv5C36H6lOo3gxnf0TfbXE5JTu7FAK Z6HK8QPXuVIeaHjIjKab+ZqfkUAJW3aGQ46mJtPjPtco6AjCUB0TiFJqjhCQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The original support for bpf_user_ringbuf_drain callbacks simply
short-circuited checks for the dynptr state, allowing users to pass
PTR_TO_DYNPTR (now CONST_PTR_TO_DYNPTR) to helpers that initialize a
dynptr. This bug would have also surfaced with other dynptr helpers in
the future that changed dynptr view or modified it in some way.

Include test cases for all cases, i.e. both bpf_dynptr_from_mem and
bpf_ringbuf_reserve_dynptr, and ensure verifier rejects both of them.
Without the fix, both of these programs load and pass verification.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/user_ringbuf.c   |  2 ++
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 35 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index 39882580cb90..500a63bb70a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -676,6 +676,8 @@ static struct {
 	{"user_ringbuf_callback_discard_dynptr", "cannot release unowned const bpf_dynptr"},
 	{"user_ringbuf_callback_submit_dynptr", "cannot release unowned const bpf_dynptr"},
 	{"user_ringbuf_callback_invalid_return", "At callback return the register R0 has value"},
+	{"user_ringbuf_callback_reinit_dynptr_mem", "Dynptr has to be an uninitialized dynptr"},
+	{"user_ringbuf_callback_reinit_dynptr_ringbuf", "Dynptr has to be an uninitialized dynptr"},
 };
 
 #define SUCCESS_TEST(_func) { _func, #_func }
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index 82aba4529aa9..7730d13c0cea 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -18,6 +18,13 @@ struct {
 	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
 } user_ringbuf SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 2);
+} ringbuf SEC(".maps");
+
+static int map_value;
+
 static long
 bad_access1(struct bpf_dynptr *dynptr, void *context)
 {
@@ -175,3 +182,31 @@ int user_ringbuf_callback_invalid_return(void *ctx)
 
 	return 0;
 }
+
+static long
+try_reinit_dynptr_mem(struct bpf_dynptr *dynptr, void *context)
+{
+	bpf_dynptr_from_mem(&map_value, 4, 0, dynptr);
+	return 0;
+}
+
+static long
+try_reinit_dynptr_ringbuf(struct bpf_dynptr *dynptr, void *context)
+{
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, dynptr);
+	return 0;
+}
+
+SEC("?raw_tp/sys_nanosleep")
+int user_ringbuf_callback_reinit_dynptr_mem(void *ctx)
+{
+	bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_mem, NULL, 0);
+	return 0;
+}
+
+SEC("?raw_tp/sys_nanosleep")
+int user_ringbuf_callback_reinit_dynptr_ringbuf(void *ctx)
+{
+	bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_ringbuf, NULL, 0);
+	return 0;
+}
-- 
2.38.1

