Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A8E5FA9F7
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiJKBXq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJKBXR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:23:17 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4611E82862
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:22:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so11757937pjl.3
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0tUfymnY67RSO3Txe4OveyCQqtPlSTs0UOa1FQFl6c=;
        b=CEXFtEteD3Nq8A6pdfGfFlqFZfMSG4/y24r0Ma+q7sQjYvkDrd1RhAf27rZfOK73p+
         jNsGu0WqmL0cN53X1MPP54+KnuIGNoeUkqd8wapKAy+57W5SU5e2++d1rsTD9pcdEY87
         w1o8LXVLuVE5mrPtpLDE+YrrtfeTnmxu2BZuWdraWoRvmrovvFTuSyGqtu4LWgXWCaAR
         Hn/ENOt81IhO++2LSwit2xR4F2np1cxMMrUP0gHC8Inu/gmEjQSZUgQugqVOe+4VCoPg
         SlCnKaaA3KWKKWYn6455Sk7Hw1xo7gbCDjT8gIi0K7HvMwLf7Rj4acGK0v5dBMWk/pFF
         Eu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0tUfymnY67RSO3Txe4OveyCQqtPlSTs0UOa1FQFl6c=;
        b=WUs7rgVsVGEiThPM6JVfMjcoWzb77iu0QFdhWfN2wkhSv3/0xJM7zQOUgIFU50XHkM
         CpmTVmTh8xJlzQoZXJ0Yv0Xs84fCSQJwYsVglbJFQG/gKSdEaDSZkjufXRWiu7Vnnfh8
         CTEeEZnnrR9a2cGyLCcUljjIyfoqSHfw6fzP0B5695/sbLQhXDQdqb+rQrZ2m12EiuvR
         ZxoQ9q0g68+eFVuzPVkyCUz/JnS91gmO+2cnRi1Udiw5MY5pZ6+L56WaYHJ0shNin5Vp
         cDDBPq/mStqf8IrQn09KosrprMWLcf5BAC5FNBJBpqNZXGqLQ/Q+X/pBb7ScX8EA1C1n
         QXtA==
X-Gm-Message-State: ACrzQf3QeBLnYLlWRvGezbqLSgey/l0/YqfkaXENqwPUfuwCILNr9xkQ
        ymqu4ZITD+itsO2ZW8eny7FehOb+Ddf8Vg==
X-Google-Smtp-Source: AMsMyM5hKH7y0EOgNJ/gJHKRbKxYJUNkeaTwTL8COJfhhsYT2XeRvgpec8RIO6VfLFPjICN8E+knCQ==
X-Received: by 2002:a17:90b:1b41:b0:20a:f406:2b90 with SMTP id nv1-20020a17090b1b4100b0020af4062b90mr24333373pjb.7.1665451373514;
        Mon, 10 Oct 2022 18:22:53 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902d1c200b0016cf3f124e1sm7230576plb.234.2022.10.10.18.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:22:53 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 03/25] bpf: Clobber stack slot when writing over spilled PTR_TO_BTF_ID
Date:   Tue, 11 Oct 2022 06:52:18 +0530
Message-Id: <20221011012240.3149-4-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2787; i=memxor@gmail.com; h=from:subject; bh=JfN71UpRfN8H8KhEVMDNn4gm0qNUQyRG5PsS+eQFPZA=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUarffUSjJ/8gBrLa9u8sYWcC9jYEa6nAzzaPu/ VjWf41KJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGgAKCRBM4MiGSL8RygPXEA Cztjmn7Cvg7EZrz7SMnXYx+TML9NzyArBXWE8PRgxZcu8uspjmgCAncX1ADCSnQ0IDaqaQYPrFF1Da gisL1aNPFrdeYJFKzroqq36/dDBEqgpAAPxmnvBs1t7RkidxYufz5DGthUrlRQmPhAHLt5JFKntNZD ILY/ErsajfnlXbCWGlNv9o2Agz/WWoixf+FfpqWl0kL5q6lP4HH7kJt/PPxQsTScj1eeop2EWTXqGK Trry+sYaFYnXD6R1/TbH4s2O9spaa+snTMd8Kg0hmvo1vhr/8LevfFb1uENcmFkn5tGrimFKLLmY8i X5jRXGuCSimO7XJWQOO9E+Z8QWqhfBRLBoRQgb7JCVUCkmHY9IuvotwwB0rRw7APhFuSa8Z5ZIz/1t fDo+sh+s2n9+2ch6Lc2+oOw5xpeYepvJqsE0uzhlqrMP2OI/o7DD19KU2+/PFRCiKMSKq7DmEaML74 CJf3PnNSPqG7AP+0PmFkeFc/HW8vMzLzZqjYcq0mo18eTILrWjXzjwuUpOdRswlQHbwMBDOpubLHjh qgcBVHqeqk0l0UuzoJ205Y9kTTnNrftoTun/0/oB5tIrlrZext6OGckP4+u/eTZ2/p8L7ADK84zCIH ozSc5roewkqvoULZyXZ1nJII5jebpvbCLNkuXQ8Pr0HMbMl0N3XZQjMxGSHA==
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

When support was added for spilled PTR_TO_BTF_ID to be accessed by
helper memory access, the stack slot was not overwritten to STACK_MISC
(and that too is only safe when env->allow_ptr_leaks is true).

This means that helpers who take ARG_PTR_TO_MEM and write to it may
essentially overwrite the value while the verifier continues to track
the slot for spilled register.

This can cause issues when PTR_TO_BTF_ID is spilled to stack, and then
overwritten by helper write access, which can then be passed to BPF
helpers or kfuncs.

Handle this by falling back to the case introduced in a later commit,
which will also handle PTR_TO_BTF_ID along with other pointer types,
i.e. cd17d38f8b28 ("bpf: Permits pointers on stack for helper calls").

Finally, include a comment on why REG_LIVE_WRITTEN is not being set when
clobber is set to true. In short, the reason is that while when clobber
is unset, we know that we won't be writing, when it is true, we *may*
write to any of the stack slots in that range. It may be a partial or
complete write, to just one or many stack slots.

We cannot be sure, hence to be conservative, we leave things as is and
never set REG_LIVE_WRITTEN for any stack slot. However, clobber still
needs to reset them to STACK_MISC assuming writes happened. However read
marks still need to be propagated upwards from liveness point of view,
as parent stack slot's contents may still continue to matter to child
states.

Fixes: 1d68f22b3d53 ("bpf: Handle spilled PTR_TO_BTF_ID properly when checking stack_boundary")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6f6d2d511c06..48a10d79f1bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5154,10 +5154,6 @@ static int check_stack_range_initialized(
 			goto mark;
 		}
 
-		if (is_spilled_reg(&state->stack[spi]) &&
-		    base_type(state->stack[spi].spilled_ptr.type) == PTR_TO_BTF_ID)
-			goto mark;
-
 		if (is_spilled_reg(&state->stack[spi]) &&
 		    (state->stack[spi].spilled_ptr.type == SCALAR_VALUE ||
 		     env->allow_ptr_leaks)) {
@@ -5188,6 +5184,11 @@ static int check_stack_range_initialized(
 		mark_reg_read(env, &state->stack[spi].spilled_ptr,
 			      state->stack[spi].spilled_ptr.parent,
 			      REG_LIVE_READ64);
+		/* We do not set REG_LIVE_WRITTEN for stack slot, as we can not
+		 * be sure that whether stack slot is written to or not. Hence,
+		 * we must still conservatively propagate reads upwards even if
+		 * helper may write to the entire memory range.
+		 */
 	}
 	return update_stack_depth(env, state, min_off);
 }
-- 
2.34.1

