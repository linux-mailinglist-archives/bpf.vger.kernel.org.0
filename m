Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFC7616EA1
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiKBU1S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiKBU1S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:27:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54AF5F8E
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:27:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so2941375pjl.3
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M27BRjNYaoCB1+5IJKHZuREsYEBagQvZSID8+oBgMd4=;
        b=iT4cDo4lRxJP3wmpncIetEW2FbFi7jXUtcfTzWZA7XAagUN/v7U3KvL1eAXeIPl5Lj
         S2GpM1kEoXYJmW2C2435O6MNnUwTzcyd/Po25O3MmIfuz/E4UOdQobR/IlixpqSH1RIu
         /j7YWVyN1vp9RTaop16TsserqJ+BkAuYGmr1ZsvtSFa02weLTZr8B8LoahDynikvlaxx
         +xnV10XSVqebnU69yf2X5xgRcTdHvhx+P5vorZdqhRPKDILQS62Y6cuPx73zkSFJLbjZ
         Bw2HOTlmQnUTIhkgJmnzsWeCWC//d9kFSFRchRoxbsPDsomEP4ze3XdT0n7RJTDwfRCp
         obfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M27BRjNYaoCB1+5IJKHZuREsYEBagQvZSID8+oBgMd4=;
        b=6se/Bc22bsmpg8xnSnupluStTTA4Tj/bAS+9AheMm9aflLGXwQNBc4lWyDBPEqVgBg
         pRDP1EORfGFb2bQGRSIfCG5AH9SaL3GmGCmFh25eykdgrTHu11HRApMczbLRgPvQlhxT
         Gywb4B7RwWpwdqsG9SGS6f6hKHZ7cXsTYjyR5Kw6Jcbqc/9SyeAkdEQJSD/mXbHMVhiO
         WQ+nuiH5BXtyYqE2I9Y2VzUSzSrWne+ePWC9QXFGlQrKFruTozW/SLgEdEX1/kz5Oyqi
         fmdWm2LVoxo/VxmYq8JYY+3koc+v5AzeuO095HalQxZlhdM7mfLYIwZMzHhldGcsh6zS
         R9aQ==
X-Gm-Message-State: ACrzQf2IVWDc1YgzPqaBoPgiTDM1PDV0mXUIBMD7qQSKoKi475+u8Of4
        uzScBY3EJ8inwJSRNXnDZ0TN9H4CwQXu9g==
X-Google-Smtp-Source: AMsMyM7Xx8p8IT5ah1rtv3l9V4+VG4CJAGPon6Ak5z2kR8UEkR7gaZyCEwYOmJvl1R3VL+4oRfTENw==
X-Received: by 2002:a17:903:1250:b0:185:40c6:3c2c with SMTP id u16-20020a170903125000b0018540c63c2cmr26523418plh.64.1667420837068;
        Wed, 02 Nov 2022 13:27:17 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id g23-20020a63e617000000b0045fcfde8263sm8007884pgh.53.2022.11.02.13.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:27:16 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@meta.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 03/24] bpf: Clobber stack slot when writing over spilled PTR_TO_BTF_ID
Date:   Thu,  3 Nov 2022 01:56:37 +0530
Message-Id: <20221102202658.963008-4-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2821; i=memxor@gmail.com; h=from:subject; bh=smtUwVhThpmCYQlRPUSYD3/NycKA9FJ543l5AzSuHAY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtICHKrpnIimiF8OclK6fIYXNs6gtuKWyGBygg4S XNaIEdKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSAgAKCRBM4MiGSL8RyqHFD/ 9XT4Tm8Sqawjkwt0kq4KkAtVPoE1dsYzjvpPBlkcavbeAI6sxWsNBg00So1Z+4BhIxZ7rWnAuRiies pUek92YffDMEb8YeI4kyhU7akc0eOMAjKjyCkVowWlkdw6+G7mnDkYzZesqY71OvStoIq8ZCdtPxDU Ag5cVHuuS6gQMU3+0saNrt/qhWs4ACRDwHm17kWsmzC+MGgfwpjk/2s9TlTyVhfotpWf+0ybOfJzUW /uFdvlN/u8VyHcj8zE1G1XE/WPtjl+QJHsrHENGW1fKkHqFgmC73wcLMzp9IpSA/2Xkd6l6BtVUGgE jTjIusx7f41qCAe4ZCCTCOwT9/nEMgJ4fa8RCpG88ijBD4qJPrrn6Grclyoz8cLND2t8PcTVgbauh6 rnSBK4bqZ85YqwqdDALwZ2Ozq9wR7B/tWDU/M9pmQU3GlMuZki+E0ySbFyIb/w/9Vei9GSsMFTF9+5 BCCqXYN2XYsadO4bGb8xSdMP6i5Evf1kvO33pRRxWhdDrc7V6y89YzdpNwCrBpho7AdNX94SRAb2Ha TN77F5D9SExJwok/shGZLfeED2XjUT2Ok93ENKajcA+kuGpfG5W55PVvw9kSsIpRdGsgNQ9hcDfYR7 U5+HTWRaHjpZr1KlvuJyzcAGZKG3Mz4DZUvUwcoh6Uuf7kOXA+hNgjqFuHyQ==
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

Cc: Yonghong Song <yhs@meta.com>
Fixes: 1d68f22b3d53 ("bpf: Handle spilled PTR_TO_BTF_ID properly when checking stack_boundary")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 275c2f1f00ee..123fcb1b2cca 100644
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
2.38.1

