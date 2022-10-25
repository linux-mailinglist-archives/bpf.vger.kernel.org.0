Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD92F60CDC1
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 15:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJYNmk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 09:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJYNmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 09:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D64183DB3
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 06:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B53626195F
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 13:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADECC433C1;
        Tue, 25 Oct 2022 13:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666705357;
        bh=7FBDHWd+05Py51SpeWtD9LfF37GSrVQ0zLUhk+wk2wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LSiZIPI43cg/9Fb6ETyLAYJmXDiyOo2wYpapuVDy0VQfSicRgZVhP4VZPwHDICuDd
         6DUwS8dGFP15XBxX/KsYrcLEsqJHiRCDWxZl9CGfzG5ZE7MdYklWKCja2kbHWnLr8h
         vE/GPW1veSNtkdm4uKKb/tjMUD4xE+NQo7CImIHfakzSVqvz2dNFcUn2hUelfOvPLa
         wFEDSpdukTOsUEUbvPGHch7yRSmaPFvldlvjRmC9ooF2JYJNrVQeEbHWx2tJqunXAQ
         8mctt2hnsE0rE0Lc85zZU2IO/niUpQaAPoHTR/xeezAWwDwjfjWfjUOlkiwEY8oLw4
         LXpdTfSrtBU6w==
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
Subject: [PATCHv3 bpf-next 4/8] bpf: Take module reference on kprobe_multi link
Date:   Tue, 25 Oct 2022 15:41:44 +0200
Message-Id: <20221025134148.3300700-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221025134148.3300700-1-jolsa@kernel.org>
References: <20221025134148.3300700-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 92 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 17ae9e8336db..ad6c21709dcb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2452,6 +2452,8 @@ struct bpf_kprobe_multi_link {
 	unsigned long *addrs;
 	u64 *cookies;
 	u32 cnt;
+	u32 mods_cnt;
+	struct module **mods;
 };
 
 struct bpf_kprobe_multi_run_ctx {
@@ -2507,6 +2509,14 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
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
@@ -2519,6 +2529,7 @@ static void bpf_kprobe_multi_link_release(struct bpf_link *link)
 
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
 	unregister_fprobe(&kmulti_link->fp);
+	kprobe_multi_put_modules(kmulti_link->mods, kmulti_link->mods_cnt);
 }
 
 static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
@@ -2528,6 +2539,7 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
 	kvfree(kmulti_link->addrs);
 	kvfree(kmulti_link->cookies);
+	kfree(kmulti_link->mods);
 	kfree(kmulti_link);
 }
 
@@ -2663,6 +2675,71 @@ static void symbols_swap_r(void *a, void *b, int size, const void *priv)
 	}
 }
 
+struct module_addr_args {
+	unsigned long *addrs;
+	u32 addrs_cnt;
+	struct module **mods;
+	int mods_cnt;
+	int mods_cap;
+};
+
+static int module_callback(void *data, const char *name,
+			   struct module *mod, unsigned long addr)
+{
+	struct module_addr_args *args = data;
+	struct module **mods;
+
+	/* We iterate all modules symbols and for each we:
+	 * - search for it in provided addresses array
+	 * - if found we check if we already have the module pointer stored
+	 *   (we iterate modules sequentially, so we can check just the last
+	 *   module pointer)
+	 * - take module reference and store it
+	 */
+	if (!bsearch(&addr, args->addrs, args->addrs_cnt, sizeof(addr),
+		       bpf_kprobe_multi_addrs_cmp))
+		return 0;
+
+	if (args->mods && args->mods[args->mods_cnt - 1] == mod)
+		return 0;
+
+	if (args->mods_cnt == args->mods_cap) {
+		args->mods_cap = max(16, args->mods_cap * 3 / 2);
+		mods = krealloc_array(args->mods, args->mods_cap, sizeof(*mods), GFP_KERNEL);
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
@@ -2773,10 +2850,25 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
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
+		kprobe_multi_put_modules(link->mods, link->mods_cnt);
 		bpf_link_cleanup(&link_primer);
 		return err;
 	}
-- 
2.37.3

