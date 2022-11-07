Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF1C61FACF
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 18:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiKGRHj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 12:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiKGRHh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 12:07:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB461EED1;
        Mon,  7 Nov 2022 09:07:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D8D611B9;
        Mon,  7 Nov 2022 17:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2624C433C1;
        Mon,  7 Nov 2022 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667840855;
        bh=JhvxwGh6CHd/kos2GLFjcIg4ffzMl1S5afABnifg974=;
        h=From:To:Cc:Subject:Date:From;
        b=KT+9TnHx220XRrjPA99dqFGYvbztZkzEPy/Gb6QPRBp3heSpQG85+Xs+KiH3THlxt
         iJ08hNiBO5837fWdJnWDWUD6bJX3QDaaHGYdy6q4DkPD7kvvMWDrXtpnw3DCmOzCd/
         MZ/76QrKnkIYgld5Qgav+c4n3sKg3gsfLjKy8VRWCVYyLtgztWepGUuYS7xJWt4K/n
         RkdHXCJ6kteVMslBChX2CxdM1VOqxSfgm3qlFLrRWFDfOVH1IF/YA4mig8stoF7i7Z
         OKsb5t+kpvtiKh4xBogxIAvM9aI/b+fTotVqPmc1hcjLBzLE7fBM4caDdV1BsOtDW2
         evw/zwgutMHHw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH bpf] bpf: Add explicit cast to 'void *' for __BPF_DISPATCHER_UPDATE()
Date:   Mon,  7 Nov 2022 10:07:11 -0700
Message-Id: <20221107170711.42409-1-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
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

When building with clang:

  kernel/bpf/dispatcher.c:126:33: error: pointer type mismatch ('void *' and 'unsigned int (*)(const void *, const struct bpf_insn *, bpf_func_t)' (aka 'unsigned int (*)(const void *, const struct bpf_insn *, unsigned int (*)(const void *, const struct bpf_insn *))')) [-Werror,-Wpointer-type-mismatch]
          __BPF_DISPATCHER_UPDATE(d, new ?: &bpf_dispatcher_nop_func);
                                     ~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/bpf.h:1045:54: note: expanded from macro '__BPF_DISPATCHER_UPDATE'
          __static_call_update((_d)->sc_key, (_d)->sc_tramp, (_new))
                                                              ^~~~
  1 error generated.

The warning is pointing out that the type of new ('void *') and
&bpf_dispatcher_nop_func are not compatible, which could have side
effects coming out of a conditional operator due to promotion rules.

Add the explicit cast to 'void *' to make it clear that this is
expected, as __BPF_DISPATCHER_UPDATE() expands to a call to
__static_call_update(), which expects a 'void *' as its final argument.

Fixes: c86df29d11df ("bpf: Convert BPF_DISPATCHER to use static_call() (not ftrace)")
Link: https://github.com/ClangBuiltLinux/linux/issues/1755
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 kernel/bpf/dispatcher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index 7dfb8d0d5202..c19719f48ce0 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -123,7 +123,7 @@ static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
 			return;
 	}
 
-	__BPF_DISPATCHER_UPDATE(d, new ?: &bpf_dispatcher_nop_func);
+	__BPF_DISPATCHER_UPDATE(d, new ?: (void *)&bpf_dispatcher_nop_func);
 
 	if (new)
 		d->image_off = noff;

base-commit: c86df29d11dfba27c0a1f5039cd6fe387fbf4239
-- 
2.38.1

