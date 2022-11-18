Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A60B62EB70
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbiKRB5L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiKRB5J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:57:09 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A3B742FB
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:09 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id y13so3531911pfp.7
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0oYW6CSgia3ZDMW31MUs8LAdA0G8OfFhqnou127z6E=;
        b=lmz4BzqZp2iDIBSskA9o+Co3qFGWWH2L1/O1OBHAprfaeH3ch5UvQgyTzWB/vazoyH
         xr5ha/2IDgLyRGx1VQNHbPg0m5QcXMEwcsJpkqKAQhZhqHEdOnrNqvWjA2u56blva6Zh
         llIKsCKXsAhrrda6OSSbq2sLDu5j/uzy9PB4K9iIG6ApgZW/3pBP7BZSYmsohNPrZpvn
         M6e68Ajc8k0oV7pTDRx/Vn3z4LFrHsdA30I/0752kyC/X2Wgd2E0TBGoP5Z2SIG25oQL
         2QfAgarOxvEDmt6gkRomDQPdq8v5SQHSY2JwQtvKnzrIJHSf4Z4Dh4o8tdDP2MtIJA00
         WYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0oYW6CSgia3ZDMW31MUs8LAdA0G8OfFhqnou127z6E=;
        b=4uPJyRjBerxSD8Mtvr3uOnlJy1docbbiGxylP3orkglwBxUPub5p1a2YNASgI7ZNCc
         939Wi7o7W4UxNnrHC1pwb82yN1Wwll6mcoIzSqxzNQyV0rJpCUUXaR6FJgZRrvInfg49
         Vs0k9jQzcDbBwF2V6EL+YWKATIW4S9vwYjwvQwk5ytMa4VLEF+Lyl8vAKiMyBkmRpjGh
         7RPdI6aLsSQR4vnnEAtG5H/OHfyuf82tX2kTFJS8uDeU2RzIG+hKfXGVZhFX71stNuOs
         dM6FV0MFKu8JNNWmRvVH2Sy8Iy4DTynqIriFyRgno0CixkqjXnBpryQmQsfFDdgH1E3c
         RQIQ==
X-Gm-Message-State: ANoB5plx7w8GcZ5MbfKoYLGK/+Z9X+OVnY/UkFUZbIyAOIAIij+DD9a6
        iflFmKI8Keuwc34iMoza+/g/kl6o20E=
X-Google-Smtp-Source: AA0mqf4dmsdgDJ3TSF28wYtTx6v3aQM2wONqp1FTii/2+qCjttKAAtmYHytyNABPmMtftN3ZUs2LJg==
X-Received: by 2002:a63:f4f:0:b0:476:a62d:386e with SMTP id 15-20020a630f4f000000b00476a62d386emr4511111pgp.501.1668736628501;
        Thu, 17 Nov 2022 17:57:08 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902e84400b001767f6f04efsm2107440plg.242.2022.11.17.17.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:57:08 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 15/24] bpf: Permit NULL checking pointer with non-zero fixed offset
Date:   Fri, 18 Nov 2022 07:26:05 +0530
Message-Id: <20221118015614.2013203-16-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422; i=memxor@gmail.com; h=from:subject; bh=QqIjznvMREUvClA/SY+f+dLsmIqQx5TgUXhtVM11oiA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXPkxL0MMoCB/k+OAFU/+jQzTUPlRvU/shbYny5 2nO5cpyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzwAKCRBM4MiGSL8Rygg7D/ wN1qnBnivlOI0o4uMBAtzJ9LFDsexI6l/P2qPRiSAF+jTK5GDDJhmyo1xyh8YS2noWZnayyZWzbYuU zjJ9tw92Md1+VCT1QfHRkp+LpC3yxhotiG9Tk83Jg8bCyKyuoj8Gz974T8YQSArSHhzTCZ9cUOQHb2 RTlMIbgyMvjg9nfWoqNMDxG3lKR5jE+3C7A8eDwfKz+1+O5VIZCMP7PHEc36B3MlxdFxZ7UH+yELXl Cb0sIOm36RdO988WWCT+hgoos2E4Tm2kvo2eEImPYuJ9aAuFWmggQEUgQByBHH2EQhEG9lrUzKTk0h CKGJ8P6rAh9MlfxQ+mv1hrqxe8g6YwOBc61fipSOXqe21QMnHSlnIPAu5d5dJLGgWOYFtAZgl94le4 pYBIKCOM+tNa/etPsrCbADSlbdplDLkB/Y2WB6GX0xhMg+EfVFPFe3mJTslgbzDIwW94ViyjA13oG5 Ry3O7LYK0hK7HobWhGHpzQGE/SJW+oGzBrPvzE6fpWxAigXX1LjaHUYjmyFA7MYo21sZkHu4VCIqFe EPGmlbmoC7tULLvxF2DrlaMHDci8XkV4N1tzXBmXyVKQb/kQOnJ2Mu0JMEjh84lNXyCpCjW7hBRbZI tD6UMTv0zGHsg7Zzhkls+5eFWLSd+c3o1fQSM52iilpwXOCY2+YDiQG7MWng==
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

Pointer increment on seeing PTR_MAYBE_NULL is already protected against,
hence make an exception for PTR_TO_BTF_ID | MEM_ALLOC while still
keeping the warning for other unintended cases that might creep in.

bpf_list_pop_{front,_back} helpers planned to be introduced in next
commit will return a MEM_ALLOC register with incremented offset pointing
to bpf_list_node field. The user is supposed to then obtain the pointer
to the entry using container_of after NULL checking it. The current
restrictions trigger a warning when doing the NULL checking. Revisiting
the reason, it is meant as an assertion which seems to actually work and
catch the bad case.

Hence, under no other circumstances can reg->off be non-zero for a
register that has the PTR_MAYBE_NULL type flag set.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 75aa52b27e8b..84798773b592 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10791,16 +10791,19 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 {
 	if (type_may_be_null(reg->type) && reg->id == id &&
 	    !WARN_ON_ONCE(!reg->id)) {
-		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value ||
-				 !tnum_equals_const(reg->var_off, 0) ||
-				 reg->off)) {
-			/* Old offset (both fixed and variable parts) should
-			 * have been known-zero, because we don't allow pointer
-			 * arithmetic on pointers that might be NULL. If we
-			 * see this happening, don't convert the register.
-			 */
+		/* Old offset (both fixed and variable parts) should have been
+		 * known-zero, because we don't allow pointer arithmetic on
+		 * pointers that might be NULL. If we see this happening, don't
+		 * convert the register.
+		 *
+		 * But in some cases, some helpers that return local kptrs
+		 * advance offset for the returned pointer. In those cases, it
+		 * is fine to expect to see reg->off.
+		 */
+		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
+			return;
+		if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL) && WARN_ON_ONCE(reg->off))
 			return;
-		}
 		if (is_null) {
 			reg->type = SCALAR_VALUE;
 			/* We don't need id and ref_obj_id from this point
-- 
2.38.1

