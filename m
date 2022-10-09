Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074EB5F8F17
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 00:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJIWA0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Oct 2022 18:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiJIWAY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Oct 2022 18:00:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217DF2197
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 15:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C298B80D33
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 22:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23ACC433D6;
        Sun,  9 Oct 2022 22:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665352819;
        bh=QGdx2a38ofgtfkCrw2Yavh5pXqAlLA75/NiWAylwEyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D87dyD4R8HBPs+4HmAHKwQSYYvuITYEwh05Cc/NdH5tyRtnVaGKSeWVqyZh4fwHFN
         1kipe8+sITxC/Z6KGEC3KGTGTttfHXC7vQsW9dbdAPGchqWfJoK2T/cNjWP8NstGZW
         /YjUpMCL4G0quA6U+C+Eh6DZQQxOx5jK57bCafrafRaToPF/2ngBXBQ4r0hHwbnIwh
         9O8nXGvdM8Uy0UruHE4vnt6kl0OSk/sgBjUomjbe30mPHG6X+8A1WWUQfqXB32jJmn
         SnW2lgWxlfr8S7+rwAkIObs4zEMz4u1Nz666I7XBdOrcWv/huNSsnyQvY+YeFolFoQ
         l0nlI+gMcliQQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf-next 4/8] bpf: Take module reference on kprobe_multi link
Date:   Sun,  9 Oct 2022 23:59:22 +0200
Message-Id: <20221009215926.970164-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221009215926.970164-1-jolsa@kernel.org>
References: <20221009215926.970164-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently we allow to create kprobe multi link on function from kernel
module, but we don't take the module reference to ensure it's not
unloaded while we are tracing it.

The multi kprobe link is based on fprobe/ftrace layer which takes
different approach and releases ftrace hooks when module is unloaded
even if there's tracer registered on top of it.

Adding code that gathers all the related modules for the link and takes
their references before it's attached. All kernel module references are
released after link is unregistered.

Note that we do it the same way already for trampoline probes
(but for single address).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 100 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9be1a2b6b53b..f3d7565fee79 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2447,6 +2447,8 @@ struct bpf_kprobe_multi_link {
 	unsigned long *addrs;
 	u64 *cookies;
 	u32 cnt;
+	struct module **mods;
+	u32 mods_cnt;
 };
 
 struct bpf_kprobe_multi_run_ctx {
@@ -2502,6 +2504,14 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
 	return err;
 }
 
+static void kprobe_multi_put_modules(struct module **mods, u32 cnt)
+{
+	u32 i;
+
+	for (i = 0; i < cnt; i++)
+		module_put(mods[i]);
+}
+
 static void free_user_syms(struct user_syms *us)
 {
 	kvfree(us->syms);
@@ -2514,6 +2524,7 @@ static void bpf_kprobe_multi_link_release(struct bpf_link *link)
 
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
 	unregister_fprobe(&kmulti_link->fp);
+	kprobe_multi_put_modules(kmulti_link->mods, kmulti_link->mods_cnt);
 }
 
 static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
@@ -2523,6 +2534,7 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
 	kvfree(kmulti_link->addrs);
 	kvfree(kmulti_link->cookies);
+	kfree(kmulti_link->mods);
 	kfree(kmulti_link);
 }
 
@@ -2658,6 +2670,80 @@ static void symbols_swap_r(void *a, void *b, int size, const void *priv)
 	}
 }
 
+struct module_addr_args {
+	unsigned long *addrs;
+	u32 addrs_cnt;
+	struct module **mods;
+	int mods_cnt;
+	int mods_alloc;
+};
+
+static int module_callback(void *data, const char *name,
+			   struct module *mod, unsigned long addr)
+{
+	struct module_addr_args *args = data;
+	bool realloc = !args->mods;
+	struct module **mods;
+
+	/* We iterate all modules symbols and for each we:
+	 * - search for it in provided addresses array
+	 * - if found we check if we already have the module pointer stored
+	 *   (we iterate modules sequentially, so we can check just the last
+	 *   module pointer)
+	 * - take module reference and store it
+	 */
+	if (!bsearch(&addr, args->addrs, args->addrs_cnt, sizeof(unsigned long),
+		       bpf_kprobe_multi_addrs_cmp))
+		return 0;
+
+	if (args->mods) {
+		struct module *prev = NULL;
+
+		if (args->mods_cnt > 1)
+			prev = args->mods[args->mods_cnt - 1];
+		if (prev == mod)
+			return 0;
+		if (args->mods_cnt == args->mods_alloc)
+			realloc = true;
+	}
+
+	if (realloc) {
+		args->mods_alloc += 100;
+		mods = krealloc_array(args->mods, args->mods_alloc, sizeof(*mods), GFP_KERNEL);
+		if (!mods)
+			return -ENOMEM;
+		args->mods = mods;
+	}
+
+	if (!try_module_get(mod))
+		return -EINVAL;
+
+	args->mods[args->mods_cnt] = mod;
+	args->mods_cnt++;
+	return 0;
+}
+
+static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u32 addrs_cnt)
+{
+	struct module_addr_args args = {
+		.addrs     = addrs,
+		.addrs_cnt = addrs_cnt,
+	};
+	int err;
+
+	/* We return either err < 0 in case of error, ... */
+	err = module_kallsyms_on_each_symbol(module_callback, &args);
+	if (err) {
+		kprobe_multi_put_modules(args.mods, args.mods_cnt);
+		kfree(args.mods);
+		return err;
+	}
+
+	/* or number of modules found if everything is ok. */
+	*mods = args.mods;
+	return args.mods_cnt;
+}
+
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	struct bpf_kprobe_multi_link *link = NULL;
@@ -2768,7 +2854,21 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		       bpf_kprobe_multi_cookie_cmp,
 		       bpf_kprobe_multi_cookie_swap,
 		       link);
+	} else {
+		/*
+		 * We need to sort addrs array even if there are no cookies
+		 * provided, to allow bsearch in get_modules_for_addrs.
+		 */
+		sort(addrs, cnt, sizeof(*addrs),
+		       bpf_kprobe_multi_addrs_cmp, NULL);
+	}
+
+	err = get_modules_for_addrs(&link->mods, addrs, cnt);
+	if (err < 0) {
+		bpf_link_cleanup(&link_primer);
+		return err;
 	}
+	link->mods_cnt = err;
 
 	err = register_fprobe_ips(&link->fp, addrs, cnt);
 	if (err) {
-- 
2.37.3

