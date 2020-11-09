Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049122AC348
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 19:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgKISKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 13:10:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:50282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbgKISKU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 13:10:20 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE08B20678;
        Mon,  9 Nov 2020 18:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604945419;
        bh=s5hGFhJEFEyS/iubhwbPqih9soNa+SDqGphzdgD56go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8Zz/YP+Lw7FnxHYyYtqHhCS78dXnEF5DUBUSHFOaOVEIjKwT2hhJYc2ngI62FoEz
         AKcIrtj56kw+t61rA5jfh1bd6RS+WQ0IpdxRh+Ykkty/VmJCTVhmBwoNQTwV5KdGXo
         1SMxZ2RGzjTaZR3NUGZkkF/KT0FI8LLf8vQsQb6Q=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B8CA1411D1; Mon,  9 Nov 2020 15:10:16 -0300 (-03)
Date:   Mon, 9 Nov 2020 15:10:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 1/3] bpf: Move iterator functions into special init
 section
Message-ID: <20201109181016.GE340169@kernel.org>
References: <20201106222512.52454-1-jolsa@kernel.org>
 <20201106222512.52454-2-jolsa@kernel.org>
 <20201109180500.GC340169@kernel.org>
 <20201109180655.GD340169@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109180655.GD340169@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Nov 09, 2020 at 03:06:55PM -0300, Arnaldo Carvalho de Melo escreveu:
> > I'm fixing it up by hand to try together with pahole's patches.
 
> Due to:
 
> 33def8498fdde180 ("treewide: Convert macro and uses of __section(foo) to __section("foo")")
> 

For convenience:

 asm-generic/vmlinux.lds.h |   16 +++++++++++++++-
 linux/bpf.h               |    8 +++++++-
 linux/init.h              |    1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

---

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81b1535a5ab..f91029b3443bf0d2 100644
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
@@ -741,7 +754,8 @@
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
 	*(.text.startup)						\
-	MEM_DISCARD(init.text*)
+	MEM_DISCARD(init.text*)						\
+	INIT_BPF_PRESERVE_TYPE
 
 #define EXIT_DATA							\
 	*(.exit.data .exit.data.*)					\
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2b16bf48aab61a1f..73e8ededde3e9c09 100644
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
index 7b53cb3092ee9956..a7c71e3b5f9a1d65 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -52,6 +52,7 @@
 #define __initconst	__section(".init.rodata")
 #define __exitdata	__section(".exit.data")
 #define __exit_call	__used __section(".exitcall.exit")
+#define __init_bpf_preserve_type __section(".init.bpf.preserve_type")
 
 /*
  * modpost check for section mismatches during the kernel build.
