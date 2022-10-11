Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ECF5FA9F4
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJKBXo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiJKBXQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:23:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A79E8320D
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:22:57 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id i3so12157716pfk.9
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQMpkuqRiE30UQTMbViYWUHwsZQBORC4WT8qdVsbK+o=;
        b=F6GOATFtx1Kx1tCyYFkoClwbxiGZr5hhFgNpqP35h8p3dy4lBjmZdqGAQk+9Wh8I7m
         GPNEOQ79FUkNRlGsJs3wC8qXXVFScYjahpXEGGeWrjKz2sPR8yRrI+/G0KhI2DYeEvVY
         edwkLbJl/bMBTnLfXsDmyH/1c6/3dY3gdzuva9VYQmQyh4axNcvEFclfOWaaVasxFZRD
         RmkS1EgyKVuj63ykj8ErDrywE97O2o2Lklg2T78LyB/X4VvtaIidIvBfS6moLPrHtAI/
         nKcu+xfPfP0LSB4HzFH9qReAZ85lYK65QL/vRx9kwbLgIaWAen8MW4hxlgo645Mey3Ni
         JE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQMpkuqRiE30UQTMbViYWUHwsZQBORC4WT8qdVsbK+o=;
        b=EkXfp/I0vXhC0FCZW18I+7ndUhkw7OjKo32w8gZ2ZlH7274gdapF7/ZeahTDt8GROc
         2Rf7Pll99rDJQPBUZZjzlZBaoaCrt8P9Zr3kEg1yWZJzdjFH8V13L/Ndi2YP0zOoPTd+
         I13e6vOGp41u92aQIvcpm/r/hp3KiF4D+PxDalEKGRnjQOE92VQdeFQsj8Zn3AqUmEZN
         DuARIK6VNWRc8CdPjBfmsAtwFVAZYCxwZY5fY9nZdXmJVFzgVnTHqzfBPXOm8f/ln5RS
         LYqnovSMoiDMrb8vRprFlHsg/cUT80talwHGRTPM8vtTQalmBQkiB9kIu/tEw6siMEiK
         Sh3w==
X-Gm-Message-State: ACrzQf0TqdmgN0U5rGt3naiVMFQUFwFQVTegdOC4dV8hDBQklbfFPwCN
        j1jXQOqNVkoouvk5OWPnhNkkNHjbe93S/w==
X-Google-Smtp-Source: AMsMyM4hUKhdniikjVn8/TFvsPOgy48tvZ9YUfks7/yWcYsWaHa+8UFazg553twnK4Qo5QAR2v1Aaw==
X-Received: by 2002:a05:6a00:1491:b0:563:8844:3f31 with SMTP id v17-20020a056a00149100b0056388443f31mr4672891pfu.31.1665451376085;
        Mon, 10 Oct 2022 18:22:56 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id 69-20020a630048000000b0042988a04bfdsm6739994pga.9.2022.10.10.18.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:22:55 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 04/25] bpf: Fix slot type check in check_stack_write_var_off
Date:   Tue, 11 Oct 2022 06:52:19 +0530
Message-Id: <20221011012240.3149-5-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916; i=memxor@gmail.com; h=from:subject; bh=tnm1pkLo4aaZJD2OW+j95hJ5RxKVC2b0Vhxw3xbq7dI=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUai0mE9vUNXscTma0OHV7U5ZSwdBMjYFKO87l7 vRDAEkiJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGgAKCRBM4MiGSL8Ryl0PD/ 4sG3ahEYeWO6GU8KCu7KOLOeu+AIrVdolTiKFYjASrAWvxJWD762xYyeVnVFCeh0lx4kK3pisy0+d6 Q3Fc+piBf+KRQvAu6gCZXA/qIsvoUyO+L8I+R0E2cO5kVF52a8s9f4kuvr4BJmoPX3cTJ24E3sohq+ r8j0a2Lp+h7WblSOBB6ve9V/XmlP2rJpIDc8UiCkGgzIE/YtLxCwAy8iqPV/8VoYCfjBtJY+KLmx9g +ZiBJ51zsGZ13TuNjTlF7cJwLT6v5BLFCZ/l/1BjoQeZjG4PUEvhf0qvfXIAADIOUjVXzBjL5xeTSk sWNURO7PvIKUO2Ov13i2Ic8C/5xjRtY6/xlGCHoXvtv9yWmj7d1dAHfkYPG9juim9rL3KsoTy07y2G 0nV7L2JGRoYZYMXDkjMa0IqLy+5Ndrtr97RxX8GFtU7gbsKGsdLW3iE840CIo/qecLcYSdrnteVJTe fS7q9s5wrINaT8Dlhd5bL65DSDaigjjx5JILEseyU/Gg20eFajpg0kHdwZ0SO/aztAfC9DW7HWIWWF yFOrPRCA351VZvlZZdmQ+9EYYwLc05HsyoCoiNyfAE15sG3kNmWiIynoKOc12SgCZL3qdZwL4xdsUp lvZ336pgdW6qM7LZ0/5B+Udi987+Dk1c/AXOGDxVVYKic1R/7y1k8zRLzciw==
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

For the case where allow_ptr_leaks is false, code is checking whether
slot type is STACK_INVALID and STACK_SPILL and rejecting other cases.
This is a consequence of incorrectly checking for register type instead
of the slot type (NOT_INIT and SCALAR_VALUE respectively). Fix the
check.

Fixes: 01f810ace9ed ("bpf: Allow variable-offset stack access")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 48a10d79f1bf..bbbd44b0fd6f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3181,14 +3181,17 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		mark_stack_slot_scratched(env, spi);
 
-		if (!env->allow_ptr_leaks
-				&& *stype != NOT_INIT
-				&& *stype != SCALAR_VALUE) {
-			/* Reject the write if there's are spilled pointers in
-			 * range. If we didn't reject here, the ptr status
-			 * would be erased below (even though not all slots are
-			 * actually overwritten), possibly opening the door to
-			 * leaks.
+		if (!env->allow_ptr_leaks && *stype != STACK_MISC && *stype != STACK_ZERO) {
+			/* Reject the write if range we may write to has not
+			 * been initialized beforehand. If we didn't reject
+			 * here, the ptr status would be erased below (even
+			 * though not all slots are actually overwritten),
+			 * possibly opening the door to leaks.
+			 *
+			 * We do however catch STACK_INVALID case below, and
+			 * only allow reading possibly uninitialized memory
+			 * later for CAP_PERFMON, as the write may not happen to
+			 * that slot.
 			 */
 			verbose(env, "spilled ptr in range of var-offset stack write; insn %d, ptr off: %d",
 				insn_idx, i);
-- 
2.34.1

