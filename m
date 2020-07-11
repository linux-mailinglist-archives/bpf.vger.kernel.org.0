Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BCF21C68A
	for <lists+bpf@lfdr.de>; Sat, 11 Jul 2020 23:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgGKVxx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 11 Jul 2020 17:53:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38020 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728226AbgGKVxx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Jul 2020 17:53:53 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-X2XlL2ssMWKT5n745HGvtQ-1; Sat, 11 Jul 2020 17:53:48 -0400
X-MC-Unique: X2XlL2ssMWKT5n745HGvtQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EF7A800FED;
        Sat, 11 Jul 2020 21:53:47 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9777360BEC;
        Sat, 11 Jul 2020 21:53:45 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v7 bpf-next 8/9] tools headers: Adopt verbatim copy of btf_ids.h from kernel sources
Date:   Sat, 11 Jul 2020 23:53:28 +0200
Message-Id: <20200711215329.41165-9-jolsa@kernel.org>
In-Reply-To: <20200711215329.41165-1-jolsa@kernel.org>
References: <20200711215329.41165-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It will be needed by bpf selftest for resolve_btfids tool.

Also adding __PASTE macro as btf_ids.h dependency, which is
defined in:

  include/linux/compiler_types.h

but because tools/include do not have this header, I'm putting
the macro into linux/compiler.h header.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Tested-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/linux/btf_ids.h  | 87 ++++++++++++++++++++++++++++++++++
 tools/include/linux/compiler.h |  4 ++
 2 files changed, 91 insertions(+)
 create mode 100644 tools/include/linux/btf_ids.h

diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
new file mode 100644
index 000000000000..fe019774f8a7
--- /dev/null
+++ b/tools/include/linux/btf_ids.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_BTF_IDS_H
+#define _LINUX_BTF_IDS_H
+
+#include <linux/compiler.h> /* for __PASTE */
+
+/*
+ * Following macros help to define lists of BTF IDs placed
+ * in .BTF_ids section. They are initially filled with zeros
+ * (during compilation) and resolved later during the
+ * linking phase by resolve_btfids tool.
+ *
+ * Any change in list layout must be reflected in resolve_btfids
+ * tool logic.
+ */
+
+#define BTF_IDS_SECTION ".BTF_ids"
+
+#define ____BTF_ID(symbol)				\
+asm(							\
+".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
+".local " #symbol " ;                          \n"	\
+".type  " #symbol ", @object;                  \n"	\
+".size  " #symbol ", 4;                        \n"	\
+#symbol ":                                     \n"	\
+".zero 4                                       \n"	\
+".popsection;                                  \n");
+
+#define __BTF_ID(symbol) \
+	____BTF_ID(symbol)
+
+#define __ID(prefix) \
+	__PASTE(prefix, __COUNTER__)
+
+/*
+ * The BTF_ID defines unique symbol for each ID pointing
+ * to 4 zero bytes.
+ */
+#define BTF_ID(prefix, name) \
+	__BTF_ID(__ID(__BTF_ID__##prefix##__##name##__))
+
+/*
+ * The BTF_ID_LIST macro defines pure (unsorted) list
+ * of BTF IDs, with following layout:
+ *
+ * BTF_ID_LIST(list1)
+ * BTF_ID(type1, name1)
+ * BTF_ID(type2, name2)
+ *
+ * list1:
+ * __BTF_ID__type1__name1__1:
+ * .zero 4
+ * __BTF_ID__type2__name2__2:
+ * .zero 4
+ *
+ */
+#define __BTF_ID_LIST(name)				\
+asm(							\
+".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
+".local " #name ";                             \n"	\
+#name ":;                                      \n"	\
+".popsection;                                  \n");	\
+
+#define BTF_ID_LIST(name)				\
+__BTF_ID_LIST(name)					\
+extern u32 name[];
+
+/*
+ * The BTF_ID_UNUSED macro defines 4 zero bytes.
+ * It's used when we want to define 'unused' entry
+ * in BTF_ID_LIST, like:
+ *
+ *   BTF_ID_LIST(bpf_skb_output_btf_ids)
+ *   BTF_ID(struct, sk_buff)
+ *   BTF_ID_UNUSED
+ *   BTF_ID(struct, task_struct)
+ */
+
+#define BTF_ID_UNUSED					\
+asm(							\
+".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
+".zero 4                                       \n"	\
+".popsection;                                  \n");
+
+
+#endif
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 9f9002734e19..6eac24d44e81 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -201,4 +201,8 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 # define __fallthrough
 #endif
 
+/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
+#define ___PASTE(a, b) a##b
+#define __PASTE(a, b) ___PASTE(a, b)
+
 #endif /* _TOOLS_LINUX_COMPILER_H */
-- 
2.25.4

