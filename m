Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D966EB7CD
	for <lists+bpf@lfdr.de>; Sat, 22 Apr 2023 09:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDVHfx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Apr 2023 03:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVHfw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Apr 2023 03:35:52 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128DE1BD4
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 00:35:51 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pq7me-0008RK-MU; Sat, 22 Apr 2023 09:35:48 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next] bpf: fix link failure with NETFILTER=y INET=n
Date:   Sat, 22 Apr 2023 09:35:44 +0200
Message-Id: <20230422073544.17634-1-fw@strlen.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <202304220903.fRZTJtxe-lkp@intel.com>
References: <202304220903.fRZTJtxe-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Explicitly check if NETFILTER_BPF_LINK is enabled, else configs
that have NETFILTER=y but CONFIG_INET=n fail to link:

> kernel/bpf/syscall.o: undefined reference to `netfilter_prog_ops'
> kernel/bpf/verifier.o: undefined reference to `netfilter_verifier_ops'

Fixes: fd9c663b9ad6 ("bpf: minimal support for programs hooked into netfilter framework")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304220903.fRZTJtxe-lkp@intel.com/
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 checked that my 'goodconfig' still yields a kernel that accepts bpf-nf progs.

 include/linux/bpf_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 39a999abb0ce..fc0d6f32c687 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -79,7 +79,7 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm,
 #endif
 BPF_PROG_TYPE(BPF_PROG_TYPE_SYSCALL, bpf_syscall,
 	      void *, void *)
-#ifdef CONFIG_NETFILTER
+#ifdef CONFIG_NETFILTER_BPF_LINK
 BPF_PROG_TYPE(BPF_PROG_TYPE_NETFILTER, netfilter,
 	      struct bpf_nf_ctx, struct bpf_nf_ctx)
 #endif
-- 
2.39.2

