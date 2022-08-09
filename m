Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E477B58E1CA
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 23:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiHIVbG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 17:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiHIVan (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 17:30:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404674C633
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 14:30:42 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gk3so24415388ejb.8
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Cr1xo52Mn7YnQkOWPQapoE1OiqXxbhlwyScvUA+A2lg=;
        b=bI7QQfGnEl6p+YnC7+v6judR7n4O0xVS8V/cjpmMqe290so8JSAnFz2C4y3CYU6Lob
         p+jA0Ymlu2FvIYIPDsCScvyrOtC4c2nTUWJde4RmKpR0EfZbdBvG0V3HuBRN61PkkSto
         TmqaqRSC2gs2DFJ7JnB7GihrLBINoHbXILwAKRIuaKNo647AhDRLN4QC+utiaCghEuBM
         evFwIFhtBRsqyDivarfDDoMUkq+rdDk3R5irRdjNStpvFvg0g1kS1IxXVzH9R/h3BJMZ
         PvN5KHmo/CbJvMLx6HmHA4vzEWbpJOxpxgv6BMKCM7MsAqq8GkJCoOt+4QLB7wCC+Ke6
         G9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Cr1xo52Mn7YnQkOWPQapoE1OiqXxbhlwyScvUA+A2lg=;
        b=fF8yZmuXxi5WlhvuK/uYDAto7glcVrtds9YocHb+K2F4PhrXwtmnpumnypaPiCvNYl
         wmCxrejs6y6LmposU5KDRUchQrulPqJYDFJdffclflmlK/ZPzTtXWPrP1P0JZZFJAE4n
         GZYhwHvlY7/DrOElZxe+4u1fbUQnX+xe4FVYYGuHC+PTplC8gxIEOevTBtOhEyRguAPv
         JDQ0SWqIKyqqnkACBDHbHDdNFIkr5TgbtZv4HexQSj0R2tHJJprJF2t6Ycg6uwimIuhL
         N4Dgt5Qhz0aa/e8RxtZQ6iNq6z3puGAJYnnyMQkK0JM0z4XiwoSdErlZ6IEhgCT8oYH4
         mg+g==
X-Gm-Message-State: ACgBeo1T8v2NBmWWPw1eIgLwAbZeEsQQJpqf/ekPxzEIF4Yv/FnxqFoE
        GGY6Td/3cdV8d5f4REj0EAHtLWtGAYc=
X-Google-Smtp-Source: AA6agR616HOU79UUEmcJCdAMuq2efLWssnqAP360bPsO4+pHTu40sMz6+b4Se8IfXBP2CCbxYAdrVw==
X-Received: by 2002:a17:907:c14:b0:730:9d15:c9bc with SMTP id ga20-20020a1709070c1400b007309d15c9bcmr18449275ejc.752.1660080640555;
        Tue, 09 Aug 2022 14:30:40 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id sb1-20020a170906edc100b0072f1d8e7301sm1550980ejb.66.2022.08.09.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:30:40 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v3 3/3] selftests/bpf: Add test for prealloc_lru_pop bug
Date:   Tue,  9 Aug 2022 23:30:33 +0200
Message-Id: <20220809213033.24147-4-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809213033.24147-1-memxor@gmail.com>
References: <20220809213033.24147-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2940; i=memxor@gmail.com; h=from:subject; bh=Tp01111ug04hA339+xIw3o9CwHNLsvPF+5un+MpX3b0=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi8tHvthu1E2BpYgehMw/BJ+EPbJJO1f4tfcgvuQEv Mot9tlWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYvLR7wAKCRBM4MiGSL8Ryja7D/ 9n9n+H4pqykr4UrMckWLZqz3asNbGtcGgreoHdFDXO+0X++xkW7sCIqzkIs6Fp3U+F4jCSLGrY47BH cx0VEDzesc43rh1RYwsMx4dekGh+VO11eL2Fc71E6Y488YaIqQo4iZ+hbtO0aOCq5HwgdqcXOeZqht m/VNzyb1plZlNhFqnvC+TvIK8vr2OMHw0TDBJncon6avAl9oLWrFUaXZHdCX+NgdghATBNHDITlQqa e9QS9sADU5G41xky5jenEWD71640/0wZpbvAkR8BSWVePuJd+No6uo6Bg70JVXYrJyXmPo1Sogf3/c RtVFY0vuVjAetqoYNiXCPkzXojn3TvrCUF5jqd0twoRfneyopa2h/duiIWOOG27UCEnw5mATev+xj6 QXSn5TOvhfUjFUmVQWra3CaWP9515jRePdZWvIaKfM5xGslgjWIykk1eDSIx5kBZRmPvhgHVBMWRjd 3uFeJH8F5EGV4wsN2ULzYs7ZKU+uBsZtbPTbCt+E81F8offS/7vxb8v3KlA14fHXhBdvwBmKBM3qkB 12BaxQZQvSsbZ/hOYr2f6sMrwxkTDDHLA+MRlmugzXqhfCK8rmFwvJKZpjjOlD8/ImkQP9LgwTujW/ 1ZM8H9uBdXxpTU483x44YyOXQCTI/X/6XJDQGk+MAjF0xzDkPMbMs5dXsghg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a regression test to check against invalid check_and_init_map_value
call inside prealloc_lru_pop.

The kptr should not be reset to NULL once we set it after deleting the
map element. Hence, we trigger a program that updates the element
causing its reuse, and checks whether the unref kptr is reset or not.
If it is, prealloc_lru_pop does an incorrect check_and_init_map_value
call and the test fails.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/lru_bug.c        | 21 ++++++++
 tools/testing/selftests/bpf/progs/lru_bug.c   | 49 +++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lru_bug.c
 create mode 100644 tools/testing/selftests/bpf/progs/lru_bug.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lru_bug.c b/tools/testing/selftests/bpf/prog_tests/lru_bug.c
new file mode 100644
index 000000000000..3c7822390827
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lru_bug.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "lru_bug.skel.h"
+
+void test_lru_bug(void)
+{
+	struct lru_bug *skel;
+	int ret;
+
+	skel = lru_bug__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "lru_bug__open_and_load"))
+		return;
+	ret = lru_bug__attach(skel);
+	if (!ASSERT_OK(ret, "lru_bug__attach"))
+		goto end;
+	usleep(1);
+	ASSERT_OK(skel->data->result, "prealloc_lru_pop doesn't call check_and_init_map_value");
+end:
+	lru_bug__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/lru_bug.c b/tools/testing/selftests/bpf/progs/lru_bug.c
new file mode 100644
index 000000000000..687081a724b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lru_bug.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+struct map_value {
+	struct task_struct __kptr *ptr;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct map_value);
+} lru_map SEC(".maps");
+
+int pid = 0;
+int result = 1;
+
+SEC("fentry/bpf_ktime_get_ns")
+int printk(void *ctx)
+{
+	struct map_value v = {};
+
+	if (pid == bpf_get_current_task_btf()->pid)
+		bpf_map_update_elem(&lru_map, &(int){0}, &v, 0);
+	return 0;
+}
+
+SEC("fentry/do_nanosleep")
+int nanosleep(void *ctx)
+{
+	struct map_value val = {}, *v;
+	struct task_struct *current;
+
+	bpf_map_update_elem(&lru_map, &(int){0}, &val, 0);
+	v = bpf_map_lookup_elem(&lru_map, &(int){0});
+	if (!v)
+		return 0;
+	bpf_map_delete_elem(&lru_map, &(int){0});
+	current = bpf_get_current_task_btf();
+	v->ptr = current;
+	pid = current->pid;
+	bpf_ktime_get_ns();
+	result = !v->ptr;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

