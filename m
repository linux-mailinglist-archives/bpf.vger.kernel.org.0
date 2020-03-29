Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3BE2196DA3
	for <lists+bpf@lfdr.de>; Sun, 29 Mar 2020 15:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgC2NXX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Mar 2020 09:23:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25583 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727903AbgC2NXX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 29 Mar 2020 09:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585488202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OZFLzRVXjwY6yHEiQIg/pyvTxROQmEiSKkLvpEN2SzQ=;
        b=c2giCFgnbR1JMJ0llP4gunr4miso4lrEFQZyTBZUBnys4UNjK5ypapEprm3h0An1Z6DxeJ
        m3QjcPzfOZCD20LYWQMa+bH9ncXI35fDMMN0ABtUY6vxMFFb7Ej1utWW0Njz0QcnQxD+ga
        sfsr5g5WDwO09iHqgmi8VHqra9bTcvk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-9zn1HqTbMkSVZ5r9YJ_mLg-1; Sun, 29 Mar 2020 09:23:20 -0400
X-MC-Unique: 9zn1HqTbMkSVZ5r9YJ_mLg-1
Received: by mail-lf1-f71.google.com with SMTP id c20so6137014lfh.6
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2020 06:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZFLzRVXjwY6yHEiQIg/pyvTxROQmEiSKkLvpEN2SzQ=;
        b=auLjkR2tuRpX3G048wqaJQtQ7v7nP7xQAtbbWcAnqZd4kPY+sh3HaAUkUd/zELIIm9
         ycxE97zn3AVHXCN8eC372a/iHXbZF7/yCdWy5tMAzxFKNO/8RzMWcz3D+3RVDHPYgN63
         uuKDYYiTJjezCPW0q+qzBSVeGhjQVFa6Dj1RwCWs7+ToDVCxim8LCalndVPgErLnGuPv
         vtGTJ8HpAxUGoZNmg6dm0iaR2xvoMzi600+QDpOIqjM4NH/CiJaZunoa0W6WXdqxXUiH
         TQ6s/TRdZn1aYHHDwevKwcsKKN/Slw2JhMKwseiV4G2+omzHSDab59xFT8r+0QK24Ltr
         Strg==
X-Gm-Message-State: AGi0PuaTGXTMaOn0hsDGJ6oqASiUOsEWXk6XUYE560as2Upjbom5WnaS
        Js5P5UeXN+ubh9jRTJnfDDS0EBOnu17+Xps+2Ak9tCWE/rwBKllkgn8AWqYYnEbd6dCU5qbprxq
        Vbg+6mgpqxyUP
X-Received: by 2002:a19:ad4c:: with SMTP id s12mr5373858lfd.109.1585488199029;
        Sun, 29 Mar 2020 06:23:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypKzM3OHFU9gSHkmUycO3u9W7lD8lS5lDtQTZ024FRfMSoOOHg++98O8Pf5keKxWYmI/6T9nkg==
X-Received: by 2002:a19:ad4c:: with SMTP id s12mr5373832lfd.109.1585488198481;
        Sun, 29 Mar 2020 06:23:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q30sm2921212lfn.18.2020.03.29.06.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 06:23:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1FC9F18158C; Sun, 29 Mar 2020 15:23:15 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH v4 2/2] selftests: Add test for overriding global data value before load
Date:   Sun, 29 Mar 2020 15:22:53 +0200
Message-Id: <20200329132253.232541-2-toke@redhat.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200328182834.196578-1-toke@redhat.com>
References: <20200328182834.196578-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a test to exercise the new bpf_map__set_initial_value() function.
The test simply overrides the global data section with all zeroes, and
checks that the new value makes it into the kernel map on load.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../bpf/prog_tests/global_data_init.c         | 61 +++++++++++++++++++
 .../selftests/bpf/progs/test_global_data.c    |  2 +-
 2 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_data_init.c

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
new file mode 100644
index 000000000000..3bdaa5a40744
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_global_data_init(void)
+{
+	const char *file = "./test_global_data.o";
+	int err = -ENOMEM, map_fd, zero = 0;
+	__u8 *buff = NULL, *newval = NULL;
+	struct bpf_object *obj;
+	struct bpf_map *map;
+        __u32 duration = 0;
+	size_t sz;
+
+	obj = bpf_object__open_file(file, NULL);
+	if (CHECK_FAIL(!obj))
+		return;
+
+	map = bpf_object__find_map_by_name(obj, "test_glo.rodata");
+	if (CHECK_FAIL(!map || !bpf_map__is_internal(map)))
+		goto out;
+
+	sz = bpf_map__def(map)->value_size;
+	newval = malloc(sz);
+	if (CHECK_FAIL(!newval))
+		goto out;
+
+	memset(newval, 0, sz);
+	/* wrong size, should fail */
+	err = bpf_map__set_initial_value(map, newval, sz - 1);
+	if (CHECK(!err, "reject set initial value wrong size", "err %d\n", err))
+		goto out;
+
+	err = bpf_map__set_initial_value(map, newval, sz);
+	if (CHECK(err, "set initial value", "err %d\n", err))
+		goto out;
+
+	err = bpf_object__load(obj);
+	if (CHECK_FAIL(err))
+		goto out;
+
+	map_fd = bpf_map__fd(map);
+	if (CHECK_FAIL(map_fd < 0))
+		goto out;
+
+	buff = malloc(sz);
+	if (buff)
+		err = bpf_map_lookup_elem(map_fd, &zero, buff);
+	if (CHECK(!buff || err || memcmp(buff, newval, sz),
+		  "compare .rodata map data override",
+		  "err %d errno %d\n", err, errno))
+		goto out;
+
+	memset(newval, 1, sz);
+	/* object loaded - should fail */
+	err = bpf_map__set_initial_value(map, newval, sz);
+	CHECK(!err, "reject set initial value after load", "err %d\n", err);
+out:
+	free(buff);
+	free(newval);
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_data.c b/tools/testing/selftests/bpf/progs/test_global_data.c
index dd7a4d3dbc0d..1319be1c54ba 100644
--- a/tools/testing/selftests/bpf/progs/test_global_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_data.c
@@ -68,7 +68,7 @@ static struct foo struct3 = {
 		bpf_map_update_elem(&result_##map, &key, var, 0);	\
 	} while (0)
 
-SEC("static_data_load")
+SEC("classifier/static_data_load")
 int load_static_data(struct __sk_buff *skb)
 {
 	static const __u64 bar = ~0;
-- 
2.26.0

