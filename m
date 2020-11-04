Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315462A7013
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 23:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbgKDWA6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 4 Nov 2020 17:00:58 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:27662 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732143AbgKDV7k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 16:59:40 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-tOPf7Uf1MSGu3Rqy_ydRxA-1; Wed, 04 Nov 2020 16:59:33 -0500
X-MC-Unique: tOPf7Uf1MSGu3Rqy_ydRxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0F8B801FCC;
        Wed,  4 Nov 2020 21:59:31 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C3971007600;
        Wed,  4 Nov 2020 21:59:29 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: [PATCH 1/3] bpf: Move iterator functions into special init section
Date:   Wed,  4 Nov 2020 22:59:21 +0100
Message-Id: <20201104215923.4000229-2-jolsa@kernel.org>
In-Reply-To: <20201104215923.4000229-1-jolsa@kernel.org>
References: <20201104215923.4000229-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With upcoming changes to pahole, that change the way how and
which kernel functions are stored in BTF data, we need a way
to recognize iterator functions.

Iterator functions need to be in BTF data, but have no real
body and are currently placed in .init.text section, so they
are freed after kernel init and are filtered out of BTF data
because of that.

The solution is to place these functions under new section:
  .init.bpf.preserve_type

And add 2 new symbols to mark that area:
  __init_bpf_preserve_type_begin
  __init_bpf_preserve_type_end

The code in pahole responsible for picking up the functions will
be able to recognize functions from this section and add them to
the BTF data and filter out all other .init.text functions.

Suggested-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Jiri Olsa <jolsa@redhat.com>
---
 include/asm-generic/vmlinux.lds.h | 16 +++++++++++++++-
 include/linux/bpf.h               |  8 +++++++-
 include/linux/init.h              |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index cd14444bf600..e18e1030dabf 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -685,8 +685,21 @@
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
 		*(.BTF_ids)						\
 	}
+
+/*
+ * .init.bpf.preserve_type
+ *
+ * This section store special BPF function and marks them
+ * with begin/end symbols pair for the sake of pahole tool.
+ */
+#define INIT_BPF_PRESERVE_TYPE						\
+	__init_bpf_preserve_type_begin = .;                             \
+	*(.init.bpf.preserve_type)                                      \
+	__init_bpf_preserve_type_end = .;				\
+	MEM_DISCARD(init.bpf.preserve_type)
 #else
 #define BTF
+#define INIT_BPF_PRESERVE_TYPE
 #endif
 
 /*
@@ -740,7 +753,8 @@
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
 	*(.text.startup)						\
-	MEM_DISCARD(init.text*)
+	MEM_DISCARD(init.text*)						\
+	INIT_BPF_PRESERVE_TYPE
 
 #define EXIT_DATA							\
 	*(.exit.data .exit.data.*)					\
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2fffd30e13ac..12ab39a034a3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1276,10 +1276,16 @@ struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
 int bpf_obj_get_user(const char __user *pathname, int flags);
 
+#ifdef CONFIG_DEBUG_INFO_BTF
+#define BPF_INIT __init_bpf_preserve_type
+#else
+#define BPF_INIT __init
+#endif
+
 #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
 #define DEFINE_BPF_ITER_FUNC(target, args...)			\
 	extern int bpf_iter_ ## target(args);			\
-	int __init bpf_iter_ ## target(args) { return 0; }
+	int BPF_INIT bpf_iter_ ## target(args) { return 0; }
 
 struct bpf_iter_aux_info {
 	struct bpf_map *map;
diff --git a/include/linux/init.h b/include/linux/init.h
index 212fc9e2f691..133462863711 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -52,6 +52,7 @@
 #define __initconst	__section(.init.rodata)
 #define __exitdata	__section(.exit.data)
 #define __exit_call	__used __section(.exitcall.exit)
+#define __init_bpf_preserve_type __section(.init.bpf.preserve_type)
 
 /*
  * modpost check for section mismatches during the kernel build.
-- 
2.26.2

