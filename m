Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC67213811
	for <lists+bpf@lfdr.de>; Fri,  3 Jul 2020 11:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgGCJvl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 3 Jul 2020 05:51:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55807 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725891AbgGCJvl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jul 2020 05:51:41 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-MbOE_MnvPYODZa9ezuitKA-1; Fri, 03 Jul 2020 05:51:32 -0400
X-MC-Unique: MbOE_MnvPYODZa9ezuitKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6907BBFC1;
        Fri,  3 Jul 2020 09:51:30 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B69B9CA0;
        Fri,  3 Jul 2020 09:51:25 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v5 bpf-next 3/9] bpf: Add BTF_ID_LIST/BTF_ID/BTF_ID_UNUSED macros
Date:   Fri,  3 Jul 2020 11:51:05 +0200
Message-Id: <20200703095111.3268961-4-jolsa@kernel.org>
In-Reply-To: <20200703095111.3268961-1-jolsa@kernel.org>
References: <20200703095111.3268961-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support to generate .BTF_ids section that will hold BTF
ID lists for verifier.

Adding macros that will help to define lists of BTF ID values
placed in .BTF_ids section. They are initially filled with zeros
(during compilation) and resolved later during the linking phase
by resolve_btfids tool.

Following defines list of one BTF ID value:

  BTF_ID_LIST(bpf_skb_output_btf_ids)
  BTF_ID(struct, sk_buff)

It also defines following variable to access the list:

  extern u32 bpf_skb_output_btf_ids[];

The BTF_ID_UNUSED macro defines 4 zero bytes. It's used when we
want to define 'unused' entry in BTF_ID_LIST, like:

  BTF_ID_LIST(bpf_skb_output_btf_ids)
  BTF_ID(struct, sk_buff)
  BTF_ID_UNUSED
  BTF_ID(struct, task_struct)

Suggested-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/asm-generic/vmlinux.lds.h |  4 ++
 include/linux/btf_ids.h           | 87 +++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 include/linux/btf_ids.h

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef218d7..a9b77a4314a8 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -641,6 +641,10 @@
 		__start_BTF = .;					\
 		*(.BTF)							\
 		__stop_BTF = .;						\
+	}								\
+	. = ALIGN(4);							\
+	.BTF.ids : AT(ADDR(.BTF.ids) - LOAD_OFFSET) {			\
+		*(.BTF.ids)						\
 	}
 #else
 #define BTF
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
new file mode 100644
index 000000000000..d317150bc9e3
--- /dev/null
+++ b/include/linux/btf_ids.h
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
+ * linking phase by btfid tool.
+ *
+ * Any change in list layout must be reflected in btfid
+ * tool logic.
+ */
+
+#define BTF_IDS_SECTION ".BTF.ids"
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
-- 
2.25.4

