Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8CE602BAD
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 14:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJRM1T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 08:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJRM1S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 08:27:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2D9B1DF5;
        Tue, 18 Oct 2022 05:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A82E0B81E9F;
        Tue, 18 Oct 2022 12:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA08C433D6;
        Tue, 18 Oct 2022 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666096034;
        bh=VQPk5DjCowXwXW+B/j4PJh6cSP/7mrS4QgVwxTpPUrE=;
        h=From:To:Cc:Subject:Date:From;
        b=SnamShzRyVDajya2DifAvhooiLO2rs+X1yv+zEsKTGIIEWf+rnyEBaElBV2jhOeUV
         HO3XiGQn/GxhVD18TF6M1npJGJOuDg5BCi9VRB0VOjicJxBudNTjXhFedimSQvKIlx
         h2yjtY87OQ1CBhIfj6LkvD/18NqpzDx15OaHRKD12pkUwILEaj0xUjtz8S+LO8/9ug
         rJF/6pd4qXU8gqYcwSoxrBfkbqNsfW+rquNXAX4N9e6bm58F4tRx4Q30qsXMG0npf5
         PDd2MkqAlPFFIv+nX781y3zeLosEdoyyw8kbvpd2LJOQjPptljtOGDYXvFKuxFH0ER
         vgbIwyaq1KVJw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Akihiro HARAI <jharai0815@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH] x86: Include asm/ptrace.h in syscall_wrapper header
Date:   Tue, 18 Oct 2022 14:27:08 +0200
Message-Id: <20221018122708.823792-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jiri Olsa <olsajiri@gmail.com>

With just the forward declaration of the 'struct pt_regs' in
syscall_wrapper.h, the syscall stub functions:

  __[x64|ia32]_sys_*(struct pt_regs *regs)

will have different definition of 'regs' argument in BTF data
based on which object file they are defined in.

If the syscall's object includes 'struct pt_regs' definition,
the BTF argument data will point to 'struct pt_regs' record,
like:

  [226] STRUCT 'pt_regs' size=168 vlen=21
         'r15' type_id=1 bits_offset=0
         'r14' type_id=1 bits_offset=64
         'r13' type_id=1 bits_offset=128
  ...

If not, it will point to fwd declaration record:

  [15439] FWD 'pt_regs' fwd_kind=struct

and make bpf tracing program hooking on those functions unable
to access fields from 'struct pt_regs'.

Including asm/ptrace.h directly in syscall_wrapper.h to make
sure all syscalls see 'struct pt_regs' definition and resulted
BTF for '__*_sys_*(struct pt_regs *regs)' functions point to
actual struct, not just forward declaration.

Reported-by: Akihiro HARAI <jharai0815@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/syscall_wrapper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 59358d1bf880..fd2669b1cb2d 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -6,7 +6,7 @@
 #ifndef _ASM_X86_SYSCALL_WRAPPER_H
 #define _ASM_X86_SYSCALL_WRAPPER_H
 
-struct pt_regs;
+#include <asm/ptrace.h>
 
 extern long __x64_sys_ni_syscall(const struct pt_regs *regs);
 extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
-- 
2.37.3

