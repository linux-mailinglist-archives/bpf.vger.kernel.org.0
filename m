Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B21386D49
	for <lists+bpf@lfdr.de>; Tue, 18 May 2021 00:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344259AbhEQWzB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 18:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344214AbhEQWy4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 18:54:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A9C061763
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 15:53:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so404753wmk.1
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 15:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gqn9Ht5Uc9kmMjixTJxeMDr6SN/Yeqi5Bk9pBkIYrjA=;
        b=nHIimy9JOGIP/7rqn3MNQlPeFZ59TIfhamSHvy+eDezRbbXcgS+Y6R5OSOkyPsGWAX
         zaAx7X08owN0daqHekgE/JtkD5hq7yxTZGONwbTwXjhFljzO1eJ/NpoyDjV732IuKqTp
         sjp3BlBpRP8vBlQ+BatyMWX6wqGu9UL9tT+1EPUKufqXek0r+ghrgKwJaf4V4nM4IPL6
         lzbphxfXdwZb3FMdZr6Fef/v0/stltOXkAZwSvmNVLRd1X5hHz3xWkOJ3WdljcAw7oc9
         KwD0yy4sU2cG95gW/FltLoPptV/UTIRrRiOMOWcg47DDJT2u3IwZwlQ3l+sa8b1WR1Qx
         Wfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gqn9Ht5Uc9kmMjixTJxeMDr6SN/Yeqi5Bk9pBkIYrjA=;
        b=J9xHlL14Hf/A8GOKPS1xU1vA1vrNrrpwmW5iGx4wTPuADNfeoGdzTPKFDV+RR5+5jG
         G9p0KfH51BuWVpqxESOMNZuJ3kqmheiSayEf8OnA60/zirfcUTM4VfXKKuWfI81MYSLY
         N95vkV+yEXW+t+bsFIzxZtW3CWZQhjqT9BkEdNd4yRF7mTHJfeP0sj5IwABj+fGhS4+2
         sJWulw+JSN64c8CY+O/MImsVlMYV1pU7nQKszvMV1DJKW/eRy2NoXfgf+Tjnc0r4X1eN
         BcQE4P/ENifwv9xgJW8pQmBvjIqYSI0jXfAJyt9Uec7vJZ113oWydawPCDau2WOb7+KK
         j73w==
X-Gm-Message-State: AOAM532nRvk818Ir7S0cdqAhv1sMuO1Bys/Wd4rcVB1WtDoq1X0ahL3E
        S5B8Jbr0Q6IszncbDmQM+hLQsPoCqdkB9Ge80Yk=
X-Google-Smtp-Source: ABdhPJxhYhg2QExULuqHjygfezwM/USpb63gWCHjeVCgGXDFnFBvJknwCChxlgmCfZrVoFhN1kC5LQ==
X-Received: by 2002:a1c:cc0b:: with SMTP id h11mr1388864wmb.87.1621292018169;
        Mon, 17 May 2021 15:53:38 -0700 (PDT)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id h17sm3453928wre.38.2021.05.17.15.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 15:53:38 -0700 (PDT)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, rdna@fb.com
Subject: [PATCH bpf-next 05/11] bpfilter: Add map container
Date:   Tue, 18 May 2021 02:53:02 +0400
Message-Id: <20210517225308.720677-6-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517225308.720677-1-me@ubique.spb.ru>
References: <20210517225308.720677-1-me@ubique.spb.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce common code for an associative container. This common code
will be used for maps of matches, targets and tables. Hash search tables
from libc are used as an index. The supported set of operations is:
insert, update and find.

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 net/bpfilter/Makefile                         |  2 +-
 net/bpfilter/map-common.c                     | 64 +++++++++++++++++++
 net/bpfilter/map-common.h                     | 19 ++++++
 .../testing/selftests/bpf/bpfilter/.gitignore |  1 +
 tools/testing/selftests/bpf/bpfilter/Makefile |  2 +
 .../testing/selftests/bpf/bpfilter/test_map.c | 63 ++++++++++++++++++
 6 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 net/bpfilter/map-common.c
 create mode 100644 net/bpfilter/map-common.h
 create mode 100644 tools/testing/selftests/bpf/bpfilter/test_map.c

diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index 69a6c139fc7a..908fbad680ec 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -4,7 +4,7 @@
 #
 
 userprogs := bpfilter_umh
-bpfilter_umh-objs := main.o bflog.o io.o
+bpfilter_umh-objs := main.o bflog.o io.o map-common.o
 userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi
 
 ifeq ($(CONFIG_BPFILTER_UMH), y)
diff --git a/net/bpfilter/map-common.c b/net/bpfilter/map-common.c
new file mode 100644
index 000000000000..6a4ab0c5d3ec
--- /dev/null
+++ b/net/bpfilter/map-common.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Telegram FZ-LLC
+ */
+
+#include "map-common.h"
+
+#include <linux/err.h>
+
+#include <errno.h>
+#include <string.h>
+
+int create_map(struct hsearch_data *htab, size_t nelem)
+{
+	memset(htab, 0, sizeof(*htab));
+	if (!hcreate_r(nelem, htab))
+		return -errno;
+
+	return 0;
+}
+
+void *map_find(struct hsearch_data *htab, const char *name)
+{
+	const ENTRY needle = { .key = (char *)name };
+	ENTRY *found;
+
+	if (!hsearch_r(needle, FIND, &found, htab))
+		return ERR_PTR(-ENOENT);
+
+	return found->data;
+}
+
+int map_update(struct hsearch_data *htab, const char *name, void *data)
+{
+	const ENTRY needle = { .key = (char *)name, .data = data };
+	ENTRY *found;
+
+	if (!hsearch_r(needle, ENTER, &found, htab))
+		return -errno;
+
+	found->key = (char *)name;
+	found->data = data;
+
+	return 0;
+}
+
+int map_insert(struct hsearch_data *htab, const char *name, void *data)
+{
+	const ENTRY needle = { .key = (char *)name, .data = data };
+	ENTRY *found;
+
+	if (!hsearch_r(needle, ENTER, &found, htab))
+		return -errno;
+
+	if (found->data != data)
+		return -EEXIST;
+
+	return 0;
+}
+
+void free_map(struct hsearch_data *htab)
+{
+	hdestroy_r(htab);
+}
diff --git a/net/bpfilter/map-common.h b/net/bpfilter/map-common.h
new file mode 100644
index 000000000000..b29829230eff
--- /dev/null
+++ b/net/bpfilter/map-common.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Telegram FZ-LLC
+ */
+
+#ifndef NET_BPFILTER_MAP_COMMON_H
+#define NET_BPFILTER_MAP_COMMON_H
+
+#define _GNU_SOURCE
+
+#include <search.h>
+
+int create_map(struct hsearch_data *htab, size_t nelem);
+void *map_find(struct hsearch_data *htab, const char *name);
+int map_insert(struct hsearch_data *htab, const char *name, void *data);
+int map_update(struct hsearch_data *htab, const char *name, void *data);
+void free_map(struct hsearch_data *htab);
+
+#endif // NET_BPFILTER_MAP_COMMON_H
diff --git a/tools/testing/selftests/bpf/bpfilter/.gitignore b/tools/testing/selftests/bpf/bpfilter/.gitignore
index f5785e366013..be10b50ca289 100644
--- a/tools/testing/selftests/bpf/bpfilter/.gitignore
+++ b/tools/testing/selftests/bpf/bpfilter/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_io
+test_map
diff --git a/tools/testing/selftests/bpf/bpfilter/Makefile b/tools/testing/selftests/bpf/bpfilter/Makefile
index c02d72d89199..77afbbdf27c5 100644
--- a/tools/testing/selftests/bpf/bpfilter/Makefile
+++ b/tools/testing/selftests/bpf/bpfilter/Makefile
@@ -9,9 +9,11 @@ BPFILTERSRCDIR := $(top_srcdir)/net/bpfilter
 CFLAGS += -Wall -g -pthread -I$(TOOLSINCDIR) -I$(APIDIR) -I$(BPFILTERSRCDIR)
 
 TEST_GEN_PROGS += test_io
+TEST_GEN_PROGS += test_map
 
 KSFT_KHDR_INSTALL := 1
 
 include ../../lib.mk
 
 $(OUTPUT)/test_io: test_io.c $(BPFILTERSRCDIR)/io.c
+$(OUTPUT)/test_map: test_map.c $(BPFILTERSRCDIR)/map-common.c
diff --git a/tools/testing/selftests/bpf/bpfilter/test_map.c b/tools/testing/selftests/bpf/bpfilter/test_map.c
new file mode 100644
index 000000000000..6ac61a634e41
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpfilter/test_map.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "map-common.h"
+
+#include <linux/err.h>
+
+#include "../../kselftest_harness.h"
+
+FIXTURE(test_map)
+{
+	struct hsearch_data map;
+	const char *key;
+	void *expected;
+	void *actual;
+};
+
+FIXTURE_SETUP(test_map)
+{
+	const int max_nelements = 100;
+
+	create_map(&self->map, max_nelements);
+	self->key = "key";
+	self->expected = "expected";
+	self->actual = "actual";
+}
+
+FIXTURE_TEARDOWN(test_map)
+{
+	free_map(&self->map);
+}
+
+TEST_F(test_map, insert_and_find)
+{
+	void *found;
+
+	found = map_find(&self->map, self->key);
+	ASSERT_TRUE(IS_ERR(found))
+	ASSERT_EQ(-ENOENT, PTR_ERR(found))
+
+	ASSERT_EQ(0, map_insert(&self->map, self->key, self->expected));
+	ASSERT_EQ(0, map_insert(&self->map, self->key, self->expected));
+	ASSERT_EQ(-EEXIST, map_insert(&self->map, self->key, self->actual));
+
+	found = map_find(&self->map, self->key);
+
+	ASSERT_FALSE(IS_ERR(found));
+	ASSERT_STREQ(self->expected, found);
+}
+
+TEST_F(test_map, update)
+{
+	void *found;
+
+	ASSERT_EQ(0, map_insert(&self->map, self->key, self->actual));
+	ASSERT_EQ(0, map_update(&self->map, self->key, self->expected));
+
+	found = map_find(&self->map, self->key);
+
+	ASSERT_FALSE(IS_ERR(found));
+	ASSERT_STREQ(self->expected, found);
+}
+
+TEST_HARNESS_MAIN
-- 
2.25.1

