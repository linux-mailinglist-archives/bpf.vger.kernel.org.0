Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519B95A2F47
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiHZSu4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344934AbiHZSuK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:50:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E26EE4BB
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 11:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FD9DB831BD
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 18:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA36FC433D7;
        Fri, 26 Aug 2022 18:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661539597;
        bh=du8fWsQCbxzY/EeYC3OGOcaE1VHprOzf40Mpkt7IlRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrXw6FndIPCbrWtLin8q4WPW3uZo/lDQWxmGbPLa1mUKBao+5867Y63N/HJ+iLLag
         alHLkdoL/h5K6Nct3hbqHzQO1DYvk+1waMDAhCi6RmZop8ohBZqcUUli21ow8ctASg
         JI16p5JPKTvs4+Cw49M0Sq9zyIRi1Cpg1UL4Ano5+mlldfqdLdY3cTlKKEEXsbCvlt
         hnZJY/YxT9zuhhfVOSVWXQMUDgNbxX2jbbUtW+kgz7hSxWwl2wAK5gjfwVoiCtnpcG
         JqyeO2HDiBkEm/FZ7jLfsVmuaRgHkUlPW4sDf/qZbPm1pSC/3u/CBqiqrxHEkbt/fk
         RLhnzQLpf7CXA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH bpf-next 2/2] bpf: Move bpf_dispatcher function out of ftrace locations
Date:   Fri, 26 Aug 2022 20:46:08 +0200
Message-Id: <20220826184608.141475-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826184608.141475-1-jolsa@kernel.org>
References: <20220826184608.141475-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The dispatcher function is attached/detached to trampoline by
dispatcher update function. At the same time it's available as
ftrace attachable function.

After discussion [1] the proposed solution is to use compiler
attributes to alter bpf_dispatcher_##name##_func function:

  - remove it from being instrumented with __no_instrument_function__
    attribute, so ftrace has no track of it

  - but still generate 5 nop instructions with patchable_function_entry(5)
    attribute, which are expected by bpf_arch_text_poke used by
    dispatcher update function

Enabling HAVE_DYNAMIC_FTRACE_NO_PATCHABLE option for x86, so
__patchable_function_entries functions are not part of ftrace/mcount
locations.

The dispatcher code is generated and attached only for x86 so it's safe
to keep bpf_dispatcher func in patchable_function_entry locations for
other archs.

[1] https://lore.kernel.org/bpf/20220722110811.124515-1-jolsa@kernel.org/
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/Kconfig    | 1 +
 include/linux/bpf.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..089c20cefd2b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -284,6 +284,7 @@ config X86
 	select PROC_PID_ARCH_STATUS		if PROC_FS
 	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
+	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9c1674973e03..945d5414bb62 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -925,6 +925,8 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
 }
 
 #define DEFINE_BPF_DISPATCHER(name)					\
+	__attribute__((__no_instrument_function__))			\
+	__attribute__((patchable_function_entry(5)))			\
 	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
-- 
2.37.2

