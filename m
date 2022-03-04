Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99E14CDD42
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 20:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiCDTSB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 14:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiCDTSB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 14:18:01 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66E323065F
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 11:17:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i62-20020a25d141000000b0062896a69ed2so8233171ybg.3
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 11:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KoYpn3AgYNDwZ8FSu31gnREGCw/9CQxmy1ddBZwxVn0=;
        b=McCPwFkpe1hKbdLUsARNZ2n/OmnJyfVv/m0D7qQIwfVosCoD80BWrsUjuXpAWS5009
         kGS1/F3cAazIaEyKjoOkKWYQdtXw7RviG8ZmcAKB8vvScs3Zy06MZeA0BI164j3l9wta
         10Y95pUwc+R0+U9ePDi5jAhEpjBeQ6ppG7OfbGzYaryvEAudyCX89UKEcCIy8i6Ghcwz
         FnSJC63aje6Kvj7TGBfd5AhBQEGhJjZrTBFvVwxm38O7Ku5EG6QxDBcp1GInbAO0SM/P
         uk6FMB4ao4duWlDQ2/FYbcMy/f+5SjTzVZLwELkh3ckeGcOdyh2I9ufpqYmEk1sVkXzl
         ADmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KoYpn3AgYNDwZ8FSu31gnREGCw/9CQxmy1ddBZwxVn0=;
        b=Bt3mmVQVueGKHsI8PS8l42e9252oAbKXopksKCZncA/te0wy8OWcDB/dt4hp2ykX93
         XAByZKMB0KM2BInQ7lEkyQCirJ0llG412PyYhCsFnfKsqgl/qQCfEWd1bI5U6lEfmUVS
         5LWTgMJ5lzzn4YJlGAsR7CbK958/gqP9KKzr28uexh+Rfxzif2HGCFOT8W0PFuq1CZbP
         rfytneDKrvJ8iyRjtIcHQp5LKSLgSqeXU89kIALPdewAPrYpCGwaRgnBd3p6QpBd9qVd
         siMRiTzYR7Tb62mbaY7UzqkQA2CHDkSZKoiq1qdMTDUlpl9IX4PJNFWSMCYL1FdR1t0u
         zH1A==
X-Gm-Message-State: AOAM5335gUpUCgi5sQW7clcbGbodIeWQsZS9YdbIDGyTGmkQRzTyNBrd
        L1bJ6pTHJEpKO2kgfXrofHzrIAp72qk=
X-Google-Smtp-Source: ABdhPJy7LQNu9aJh9BO7PAoyQ35YRZ0Xp4iq/PIBXJY/5BqIpP7pbCBBycVcYp5tznQtxjUBfuQN1NccVXE=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:d204:6f81:5498:9251])
 (user=haoluo job=sendgmr) by 2002:a25:ce05:0:b0:628:9612:16ca with SMTP id
 x5-20020a25ce05000000b00628961216camr16138013ybe.191.1646421423845; Fri, 04
 Mar 2022 11:17:03 -0800 (PST)
Date:   Fri,  4 Mar 2022 11:16:54 -0800
In-Reply-To: <20220304191657.981240-1-haoluo@google.com>
Message-Id: <20220304191657.981240-2-haoluo@google.com>
Mime-Version: 1.0
References: <20220304191657.981240-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH bpf-next v1 1/4] bpf: Fix checking PTR_TO_BTF_ID in check_mem_access
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, yhs@fb.com
Cc:     acme@kernel.org, KP Singh <kpsingh@kernel.org>,
        bpf@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With the introduction of MEM_USER in

 commit c6f1bfe89ac9 ("bpf: reject program if a __user tagged memory accessed in kernel way")

PTR_TO_BTF_ID can be combined with a MEM_USER tag. Therefore, most
likely, when we compare reg_type against PTR_TO_BTF_ID, we want to use
the reg's base_type. Previously the check in check_mem_access() wants
to say: if the reg is BTF_ID but not NULL, the execution flow falls
into the 'then' branch. But now a reg of (BTF_ID | MEM_USER), which
should go into the 'then' branch, goes into the 'else'.

The end results before and after this patch are the same: regs tagged
with MEM_USER get rejected, but not in a way we intended. So fix the
condition, the error message now is correct.

Before (log from commit 696c39011538):

  $ ./test_progs -v -n 22/3
  ...
  libbpf: prog 'test_user1': BPF program load failed: Permission denied
  libbpf: prog 'test_user1': -- BEGIN PROG LOAD LOG --
  R1 type=ctx expected=fp
  0: R1=ctx(id=0,off=0,imm=0) R10=fp0
  ; int BPF_PROG(test_user1, struct bpf_testmod_btf_type_tag_1 *arg)
  0: (79) r1 = *(u64 *)(r1 +0)
  func 'bpf_testmod_test_btf_type_tag_user_1' arg0 has btf_id 136561 type STRUCT 'bpf_testmod_btf_type_tag_1'
  1: R1_w=user_ptr_bpf_testmod_btf_type_tag_1(id=0,off=0,imm=0)
  ; g = arg->a;
  1: (61) r1 = *(u32 *)(r1 +0)
  R1 invalid mem access 'user_ptr_'

Now:

  libbpf: prog 'test_user1': BPF program load failed: Permission denied
  libbpf: prog 'test_user1': -- BEGIN PROG LOAD LOG --
  R1 type=ctx expected=fp
  0: R1=ctx(id=0,off=0,imm=0) R10=fp0
  ; int BPF_PROG(test_user1, struct bpf_testmod_btf_type_tag_1 *arg)
  0: (79) r1 = *(u64 *)(r1 +0)
  func 'bpf_testmod_test_btf_type_tag_user_1' arg0 has btf_id 104036 type STRUCT 'bpf_testmod_btf_type_tag_1'
  1: R1_w=user_ptr_bpf_testmod_btf_type_tag_1(id=0,ref_obj_id=0,off=0,imm=0)
  ; g = arg->a;
  1: (61) r1 = *(u32 *)(r1 +0)
  R1 is ptr_bpf_testmod_btf_type_tag_1 access user memory: off=0

Note the error message for the reason of rejection.

Fixes: c6f1bfe89ac9 ("bpf: reject program if a __user tagged memory accessed in kernel way")
Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a57db4b2803c..d63b1f40e029 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4556,7 +4556,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		err = check_tp_buffer_access(env, reg, regno, off, size);
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
-	} else if (reg->type == PTR_TO_BTF_ID) {
+	} else if (base_type(reg->type) == PTR_TO_BTF_ID &&
+		   !type_may_be_null(reg->type)) {
 		err = check_ptr_to_btf_access(env, regs, regno, off, size, t,
 					      value_regno);
 	} else if (reg->type == CONST_PTR_TO_MAP) {
-- 
2.35.1.616.g0bdcbb4464-goog

