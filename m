Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C47618843
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiKCTKv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiKCTKo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:10:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37541D0C7
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:10:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u6so2814670plq.12
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdmRGU3Y77pVpuYP6VCMvdmUlDIJQeGQjkcU+bcvX4I=;
        b=oX6n4GZLRy8mF0X37awnt2/GcsnWpFhx1lcx2hriJsdd/REHATq+mTN00xD3hgxNFo
         fi21Q4cmvnj8eCb5fmujZk8Gpg7YlkbjRNwycb66O5MC0bLi8FOa8blQ7wRn8PTUgwhp
         q6OPruxCayvjKYcVQTpP1avX+vEVCKE6noEnAXsaCrT06lNNwu/bXt3NuvDwM3Z3N60z
         HOJvgzqzODgcJme/NNjRFWG+ymOdr8Pe89hV95YoGRn4frBaJ4fA1FoPt6+e0PDlZGws
         SJY47sr9Di2x0/av8LjLZh4ZqLZbRpq2Y01YGy3JQOY1UegkT9GIp+7rQ002y68xL2Bt
         11eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdmRGU3Y77pVpuYP6VCMvdmUlDIJQeGQjkcU+bcvX4I=;
        b=dA56AMje3bPxFZT6ncv567VJ+TqX09t0uNzjd1D0hv9P1LQBJT6cMDkZMg3Ys11fwp
         vM3rRsCn9Rzwpa2xlsRjRB8PaRFzIEaU531eX/qbbyMPkDrSCZVhobxDx4N0SQ4Kv5Id
         p5UApc2xc661t6u45i2jwoBFelwthYt28Shn+wW9tk/Ra4GZBva2PSOBxIV91CLAeRzG
         dtz+erHUTyAnxPNwU/958eiondHPV6oeUeCPWeQIOJeWXxuxOpFDqKIiQLl2oBJ59/4A
         3RdPSJC9M9kOma9/60z13NmjnD16EHOy2Csc8quTDXnimd8tOABxP5IXOrYlv7FUGoLw
         eKVw==
X-Gm-Message-State: ACrzQf2H5IOXmzkFqBHtzeXxi8FMY8R9r5/NWk52c6kdnWav5HFoqcPm
        GJ6drvw6VcLAgsS/VRfzhLWvnWanjEBzHw==
X-Google-Smtp-Source: AMsMyM7nXPYwnzR8jgEtox/3FF5dwaL2bs1rfR0Suxr4XEkgAuRCtzrFBwZWS5lkr9qEnx1O0VV+WA==
X-Received: by 2002:a17:902:ed53:b0:186:6ad3:c155 with SMTP id y19-20020a170902ed5300b001866ad3c155mr30721276plb.43.1667502642877;
        Thu, 03 Nov 2022 12:10:42 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id l3-20020a655603000000b00438834b14a1sm1068326pgs.80.2022.11.03.12.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:10:42 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@meta.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 03/24] bpf: Clobber stack slot when writing over spilled PTR_TO_BTF_ID
Date:   Fri,  4 Nov 2022 00:39:52 +0530
Message-Id: <20221103191013.1236066-4-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2821; i=memxor@gmail.com; h=from:subject; bh=Dogk83g2dp5n4+0P8GLLYMG/WYzA2mEITQeu4vHDf/k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIAI2wW8wQ7W/YDmdBG96JsQvge1WUcwJYH+4/e ywI+xxqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAAAKCRBM4MiGSL8Rynx1EA CeQ2Nbhd7mWjtEbwRgf1pzMygWPvJzVTw55kQvZ3kfiXF/ibES/+SKDabmNrnVM88V/Wn3uyA3DagL S0GKrKd9V2X7pwxxMtRZXtVq8I+8TTnJBdqqmUt2DBx1fzKI0kAsurCP3rgOqTD+71AnFjsXf08eKY qdBOl6TBBWvuDq6GXgrTkC+r+B3V2NlShHaiW3w/Tq/JAhN3aGroN8UL8GRTJUVgTVe7gKPfEX5DGJ CIbKCiSEeoRV06HsA2WENH/zCmrhmRHpZ6fZ9M0SDBxe/pOtV24R17F9SvkjnqQ1+obPw1KApMW017 VNbz3JdZGwwpxi1v5KLj60VUdiYH8Yd6o5ythewPLHGdfQNkXhRxN+YaUBxi1RwGzmum7wHot0Klj4 MoffZxdLmsgLZtJpIuURhKSEs8WOdCeqxzpw3wBzwxg5r4pz9pUH6j4rIWd3ZCVYyuIU8hIKQCFQbN 5aoLHweC3zL0rDvfsiy7p9UhImnyj5xKMaTH+X9rJCaf9CexwxAxRsobCjVhvdAbmjlNdRKLrw/XyO vrD96gyb9HbzadL3ZVYiBqrUPCMAVsnnSOxYorDc49cNCrJlQAoZKVO6wf0zaJRbo6/VRVLMVl7T7H 0h6tIUVoHckweJvE4mrUBnY3WbDy44spHh3ltQYaBLNlNM3ZMPFSR4oU1kyg==
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
index 82c07fe0bfb1..7bf12c492201 100644
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

