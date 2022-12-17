Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556EC64F6FD
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 03:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiLQCRm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 21:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiLQCRk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 21:17:40 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B23A1D66D
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 18:17:39 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p36so6117339lfa.12
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 18:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKV4IpXJqEfMLkovPacyQTYJF7rcakkNJPCMvP6w7JA=;
        b=UoxRhzIwKkYiTzy+NvuUhyJlTQdzPKKuRXnPO05rzO5dzrfTBEC/nb9bY1KkmCNYO8
         djDonHijaCh9/RXrqJgCbqOad1pDbzEwwPIfPZuXvAVGATLWmou4I7G78SA7OjDKayWe
         CozLsVAwRk6tEs8q2AqCpEP0YvhurE+oHfZm/XSqbvR87l8qSu/kPL8iMsnyUZXfadOk
         Pw0xtMnbMWzvltCIwO1sJ0+RdX8rI94Y/DyfNHh8bsJNGxYhb885oai1USB6tzntGIr1
         VX9CWyQ/fCSpWZeYwiZ6V5YUy0ixDPKCzB7qHL5xiGgjTIU3a1He9Yhyq5ueMdhh1eVZ
         jxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKV4IpXJqEfMLkovPacyQTYJF7rcakkNJPCMvP6w7JA=;
        b=iIxQNdGpSJdxsqjHqwiXCnJL/AwIkFMoimwv8Kmlchzw+wUsmBV7O2K69IvvvDdD+0
         NvnZ6aAfuoSymp0MAswiXFghAkaY9EjADACOukDTE71ojJeemeDGK5F9hw0bKmMuIEL3
         ZG1tliHAHOCNBlWiXLNT7eDe2UixZkq4Qq/69zvUAQPqtMe6rXbIXLY2AklRqvT/Tm7v
         1RLjYYYOlkGIocSxf0lmjrXnbgcm7kLs7E7WhMPQY/2pVE13gmxTPw1eEi3/SWj9NIIh
         khoVYA4wvjTvoRAEUCahNlgGN++yDoywi+jrj+BeIDk8uKexdeQdmtNp3qCxjMR5I8E4
         Q5KA==
X-Gm-Message-State: ANoB5pnjzXVZBnL4F7UFQ1LMIgKumoAYg6KziAKDlicpH6zcXFc98Bgd
        w/C0yNxT1I0bkFpMJT6MovJh5mFsF0M=
X-Google-Smtp-Source: AA0mqf63XHzYlqzjWyAf1w1MiQIv7GrmdTEZe/c6mRW8yNv+YKnIr388Gi6pJUyUiv8y1O8vPy4kOQ==
X-Received: by 2002:ac2:4a9d:0:b0:4b5:7338:e2c7 with SMTP id l29-20020ac24a9d000000b004b57338e2c7mr5293530lfp.53.1671243457421;
        Fri, 16 Dec 2022 18:17:37 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id x17-20020ac259d1000000b0049e9122bd0esm370850lfn.114.2022.12.16.18.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 18:17:36 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/4] selftests/bpf: convenience macro for use with 'asm volatile' blocks
Date:   Sat, 17 Dec 2022 04:17:09 +0200
Message-Id: <20221217021711.172247-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221217021711.172247-1-eddyz87@gmail.com>
References: <20221217021711.172247-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A set of macros useful for writing naked BPF functions using inline
assembly. E.g. as follows:

struct map_struct {
	...
} map SEC(".maps");

SEC(...)
__naked int foo_test(void)
{
	asm volatile(
		"r0 = 0;"
		"*(u64*)(r10 - 8) = r0;"
		"r1 = %[map] ll;"
		"r2 = r10;"
		"r2 += -8;"
		"call %[bpf_map_lookup_elem];"
		"r0 = 0;"
		"exit;"
		:
		: __imm(bpf_map_lookup_elem),
		  __imm_addr(map)
		: __clobber_all);
}

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index a42363a3fef1..bbf56ad95636 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -8,6 +8,12 @@
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
 #define __test_state_freq	__attribute__((btf_decl_tag("comment:test_state_freq")))
 
+/* Convenience macro for use with 'asm volatile' blocks */
+#define __naked __attribute__((naked))
+#define __clobber_all "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "memory"
+#define __imm(name) [name]"i"(name)
+#define __imm_addr(name) [name]"i"(&name)
+
 #if defined(__TARGET_ARCH_x86)
 #define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__x64_"
-- 
2.38.2

