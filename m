Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A92602DBA
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 16:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiJROAJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 10:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiJROAD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 10:00:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8830696FB
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 07:00:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id h13so14154605pfr.7
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg4TpE7gOTDrWPR4AW73VePXXzUIdnV9jgo5mQEobvg=;
        b=kdiMy+SZGbl4STSi7Kc5JMdBwXgar53vpaYb486izQmZOcGK6rfAg4z54UwGHCTlk5
         q3t3vuwiRfD19NeOiXIqihfeB/jlybfTInXtz3Gnht45NkZ+2dJOYec9u0cGLBFwmhw9
         M6JEOr9WqGbPSAfrTQZIm++Ftq5GnXnDDo0QOAlmrz7MmoFsBcn5S+XiV+6z1hwFjzMq
         A1yV7cdnxfuCFJuLMpzzT0aND+lIPglaDmdci0hfXrTuEP/ge6qY9qpK3tTn4lc/r0s6
         VAQgKr1cR2UwkC8IF5wSSxn+YQn1AQvjedU81XKA947cjled7yXgWVTNhRHu8124eMae
         yn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bg4TpE7gOTDrWPR4AW73VePXXzUIdnV9jgo5mQEobvg=;
        b=v3VeCUpPVMfiYJbObvu23ivkMlP3HiSFFHMNgAHUfQ4snTa7nyOG4j5SLX5g3HMRjm
         0ASrbIMrtkhzJnACuuyfH1o29SMgHvb7mlF4cp6vnFl2mmTl3gqQACH3kltIIS+9VjbC
         o/T+6fq/CHAmEUfm7vKdU+vdRZju1JKzM+1LjtdnXgBNcWlsHiZAczZugpxfOvH4k9mM
         nxUOdzbWcnew3cOSG2whUWBArPnVQeF7+ZjN6r/el2/soka9XItHtb35A5wo0JlqpSb1
         6PE1O9QIVnRq6SVgM/++KlEw7esUBZOo3YCmutXD396/1lbc0h4JF9S4agVKrkuIyLOh
         uq3A==
X-Gm-Message-State: ACrzQf1TDtlvY4Kn/srN7CcYIwAvvCN7fTzZ9wRQkjxU9bFN4GfGT9BX
        eoEsDFd9/nzjqqhL+qhMAtD/8F8Nt6oXiQ==
X-Google-Smtp-Source: AMsMyM5uUZMjENYIa27pCLr5iCoOuNLZRsW3JXdMixuNSaukt7ia+vmsgc/U5XnRKCElIJEqM+6qOw==
X-Received: by 2002:a65:580a:0:b0:439:befc:d2b0 with SMTP id g10-20020a65580a000000b00439befcd2b0mr2722649pgr.302.1666101598971;
        Tue, 18 Oct 2022 06:59:58 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id u14-20020a62790e000000b0055fe65e9203sm9361430pfc.0.2022.10.18.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:59:58 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 09/13] selftests/bpf: Add test for dynptr reinit in user_ringbuf callback
Date:   Tue, 18 Oct 2022 19:29:16 +0530
Message-Id: <20221018135920.726360-10-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
References: <20221018135920.726360-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3027; i=memxor@gmail.com; h=from:subject; bh=w+dQmpzIhiJvX6EB6pYHQqoDf3V0oUCaweyNMpUT0Sc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEi9gqtf+Uuyer0SG0n6yUuPNBIZyyL3mFccsND mYhr822JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIgAKCRBM4MiGSL8RyqLdEA DDCzIrZz9SjzmTJJVlpCZQgSecOaCYI1Xn0kIuhl4CCf+WmPGGiAY47lPwuHcGwzYt3foOo5PdpBVH D79Xs8JTjDWj7P3y9KKwVs6GomRHskbiEx/aWxIG9H2GVahoDRMW4bwMv2M3NaJSTF50GFU09uWxNI fiXzmUgdME7IsaVqwRQ5E8d7Uu9a09F2a4TFSpsi3PK9X3w0V4+RV5ewfsN8SXV3rzrNizDOSqy+xV ImAc3QMN4pdLu/ckxuuG1H3VPe4WZjIGirO/Q4bTqTXwvfOvI/baieeQNExfozCG4yAU4ejhI/BgYz o3qI0Ko0HOoIV7iXPrdsvA5/F3syoF5M6OI5ERAXWFHjdjas+JIm8/A1Uy0XRsHWBLOq4SInl7bJwm A30PcaQEDWhZzSoIdeZ0YKLads69oHHcwEfhd7vY5+0PuPndCMKB+xJABNVXXih/0wmXaRo1LUNkeJ u7hyalkOF+7jCjI81LnqNy+SHFlPNdgUxapFgkYGd2IBtOww3o9I7yyiKlV7RhtsazD7Lal1+uJQJ2 LscD8cLO+dwMVncJ2TV2AWqPWb2cDG0r1CoSLTboHiiez5WlAHHEriNyMv9+1RgvrgyxyoGhUWqumB 4HTfWiNrHAk54g1ztFvRTsCZngaxE/dartWrd+6l9gko8vd74sPd/0gs0Vbw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The original support for bpf_user_ringbuf_drain callbacks simply
short-circuited checks for the dynptr state, allowing users to pass
PTR_TO_DYNPTR (now CONST_PTR_TO_DYNPTR) to helpers that initialize a
dynptr. This bug would have also surfaced with other dynptr helpers in
the future that changed dynptr view or modified it in some way.

Include test cases for all cases, i.e. both bpf_dynptr_from_mem and
bpf_ringbuf_reserve_dynptr, and ensure verifier rejects both of them.
Without the fix, both of these programs load and pass verification.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/user_ringbuf.c   |  2 ++
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 35 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index 39882580cb90..500a63bb70a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -676,6 +676,8 @@ static struct {
 	{"user_ringbuf_callback_discard_dynptr", "cannot release unowned const bpf_dynptr"},
 	{"user_ringbuf_callback_submit_dynptr", "cannot release unowned const bpf_dynptr"},
 	{"user_ringbuf_callback_invalid_return", "At callback return the register R0 has value"},
+	{"user_ringbuf_callback_reinit_dynptr_mem", "Dynptr has to be an uninitialized dynptr"},
+	{"user_ringbuf_callback_reinit_dynptr_ringbuf", "Dynptr has to be an uninitialized dynptr"},
 };
 
 #define SUCCESS_TEST(_func) { _func, #_func }
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index 82aba4529aa9..7730d13c0cea 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -18,6 +18,13 @@ struct {
 	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
 } user_ringbuf SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 2);
+} ringbuf SEC(".maps");
+
+static int map_value;
+
 static long
 bad_access1(struct bpf_dynptr *dynptr, void *context)
 {
@@ -175,3 +182,31 @@ int user_ringbuf_callback_invalid_return(void *ctx)
 
 	return 0;
 }
+
+static long
+try_reinit_dynptr_mem(struct bpf_dynptr *dynptr, void *context)
+{
+	bpf_dynptr_from_mem(&map_value, 4, 0, dynptr);
+	return 0;
+}
+
+static long
+try_reinit_dynptr_ringbuf(struct bpf_dynptr *dynptr, void *context)
+{
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, dynptr);
+	return 0;
+}
+
+SEC("?raw_tp/sys_nanosleep")
+int user_ringbuf_callback_reinit_dynptr_mem(void *ctx)
+{
+	bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_mem, NULL, 0);
+	return 0;
+}
+
+SEC("?raw_tp/sys_nanosleep")
+int user_ringbuf_callback_reinit_dynptr_ringbuf(void *ctx)
+{
+	bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_ringbuf, NULL, 0);
+	return 0;
+}
-- 
2.38.0

