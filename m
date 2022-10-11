Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205305FA9F5
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJKBXn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiJKBXN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:23:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C5B84E77
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:22:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so11740188pjf.5
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2x8MqaAH2YK+r/hbQyXTL8Mbl63zAUlQVec+TH6qvQ=;
        b=LpJMgAot2rsh3BYYOieTmAww0gDYBbgXW3vOslG3+oPTCWBmCemmnO3QkwGs/MOhgY
         7FstJoB372IsLc++3JfRCbiPgQur+UKe0O97nFHfk2ceIXFxKVTeYlw8RUMQO4MRCqHd
         a6ActDLHhoKg8OweuvAnPmF+g7RRoxetG95QhOCeK35gVXKJcvW+CDxW36zNg871RiR/
         algTi8DeR6PSkh3c1QM06t+5gYKVGSzhv0HR+WnbBe0DFHmYtAALD1EvmQkL3ZK9Qcdj
         AghX7FcmOtdqN3OX8MnT/Zf1tscAXKBj74vxP2v11zhRkXvBr46rLpaFniFYYuNHk9vI
         pujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2x8MqaAH2YK+r/hbQyXTL8Mbl63zAUlQVec+TH6qvQ=;
        b=ky2YzqKmYRObeQtqYPQndM6Q1tYnpuHbxN7m64kM1UJOvUWBtYxm4pF0uuZS1boJsU
         ZaPPr2UGoodNEghTiqxORuxldtzs1hX6DV/0MmHjBAE6ftYIBUVS9au/+NxlAMU5XYvy
         YfHjOkDim52XglhG2Osu7sZLJlWMTQxbFOA4IIQf1GaX4B9DGYepPl2vR5At2YQJGoct
         nDtOMl80G0TzLbtMLgI6MsZURXVrLSKlNIUe6SX/3zTDQhwk9byttxn6i7TsPzxfg1vX
         E1YPTM9hX3xLwFSMoCiFt/0F9yDmmtks72MiFJ+9Sl3YACl0EjvIALAgzxxYWe8pA/bP
         3jzg==
X-Gm-Message-State: ACrzQf1k9kRLgU/GE4k9H6lxNcppvs0scIX5yGfne16yOVjqRUiyRpK1
        whlaolGpv28n6rL/3qKKtseW7iBT18U1qQ==
X-Google-Smtp-Source: AMsMyM6mEJ/fRocW7ddjVy+5trQ7KygCGw13niVgkxn1CdVUJ5dJDLw6Q7DrX6/HVtD9y3ViHwoAqA==
X-Received: by 2002:a17:90a:b103:b0:20d:69aa:a350 with SMTP id z3-20020a17090ab10300b0020d69aaa350mr1130097pjq.178.1665451368340;
        Mon, 10 Oct 2022 18:22:48 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090a388500b0020adf65cebbsm9858023pjb.8.2022.10.10.18.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:22:48 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 01/25] bpf: Document UAPI details for special BPF types
Date:   Tue, 11 Oct 2022 06:52:16 +0530
Message-Id: <20221011012240.3149-2-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3630; i=memxor@gmail.com; h=from:subject; bh=Jqp2L7qahJANz1C3zlA77QLot+tvech5fQCMXv6Qo78=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUZL5QQwj830t8/Fj7gzjxzn9Krd5TR3EX1gF/U X2WKEyeJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGQAKCRBM4MiGSL8RylnxD/ 44p8+Lf8q5U4UDxggptfKbN6n4F9l+lS4sWzgG6+tOXedCogM5zYadpx1gRDheZ6LHfXRnTXYZKqEZ 7GXZvHtErjzFJlwYAgG24Jd66tTN1+ks0YuFRQPKJk8sMWHpOpWZIZ+Xwif93HClc6YLM8z+ngyDlh iBITm/q1lhpSRY/MobEDB74fZgLoVKz64OPQ3o1S9MmpU7aVh379g0kmMgjbP7ETMKVzP3GGhkRcVc 9tQMIp5u+JP7vlDShgX7iJ2gjc0w6H9RF+HRl3DuhsApMDhsLB6fc0I1cmPmefc5P/Mt1yf++mBtuB 5yF9AIHhnB4w8pHmHK2buPU53SakFgQ8I/ejCe0XTouBj3WmIO46wbcfDyPYARUz2MvEIrisuEqzZ9 VBvjXz2Pk4oB5o35+HBQLRGy8EnUSMtfbQ1yxJV3pmxP59DPIsyuUzGjcsT1BSYX3F6WB7joD78fXh Xhyft2VoI3G7htKMMnwEo+8nprSxJOmz75W91DI+6Or6p8/po2pY2hja50QfAxs8Ybk7vtZmuUbEG0 GZJUBL2U3qWNUIGzouIwOGrL/Ejow99D/xzaFMcxJEPbtcrbEnLSgVcletNq0bKYAlSlOH5NhNokSd xHtO9LgUiaQcB/tJqH6Z7JM0wFIBVVxMNENl/+C9pQ5MZQV4qSnxmWN4MTfg==
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

The kernel recognizes some special BPF types in map values or local
kptrs. Document that only bpf_spin_lock and bpf_timer will preserve
backwards compatibility, and kptr will preserve backwards compatibility
for the operations on the pointer, not the types supported for such
kptrs.

For local kptrs, document that there are no stability guarantees at all.

Finally, document that 'bpf_' namespace is reserved for adding future
special fields, hence BPF programs must not declare types with such
names in their programs and still expect backwards compatibility.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/bpf_design_QA.rst | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index a210b8a4df00..c82c50475e1b 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -298,3 +298,47 @@ A: NO.
 
 The BTF_ID macro does not cause a function to become part of the ABI
 any more than does the EXPORT_SYMBOL_GPL macro.
+
+Q: What is the compatibility story for special BPF types in map values?
+-----------------------------------------------------------------------
+Q: Users are allowed to embed bpf_spin_lock, bpf_timer fields in their BPF map
+values (when using BTF support for BPF maps). This allows to use helpers for
+such objects on these fields inside map values. Users are also allowed to embed
+pointers to some kernel types (with __kptr and __kptr_ref BTF tags). Will the
+kernel preserve backwards compatibility for these features?
+
+A: It depends. For bpf_spin_lock, bpf_timer: YES, for kptr and everything else:
+NO, but see below.
+
+For struct types that have been added already, like bpf_spin_lock and bpf_timer,
+the kernel will preserve backwards compatibility, as they are part of UAPI.
+
+For kptrs, they are also part of UAPI, but only with respect to the kptr
+mechanism. The types that you can use with a __kptr and __kptr_ref tagged
+pointer in your struct is NOT part of the UAPI contract. The supported types
+can and will change across kernel releases. However, operations like accessing
+kptr fields and bpf_kptr_xchg() helper will continue to be supported across
+kernel releases for the supported types.
+
+For any other supported struct type, unless explicitly stated in this document
+and added to bpf.h UAPI header, such types can and will arbitrarily change their
+size, type, and alignment, or any other user visible API or ABI detail across
+kernel releases. The users must adapt their BPF programs to the new changes and
+update them to make sure their programs continue to work correctly.
+
+NOTE: BPF subsystem specially reserves the 'bpf_' prefix for type names, in
+order to introduce more special fields in the future. Hence, user programs must
+avoid defining types with 'bpf_' prefix to not be broken in future releases. In
+other words, no backwards compatibility is guaranteed if one using a type in BTF
+with 'bpf_' prefix.
+
+Q: What is the compatibility story for special BPF types in local kptrs?
+------------------------------------------------------------------------
+Q: Same as above, but for local kptrs (i.e. kptrs allocated using bpf_kptr_new
+for user defined structures). Will the kernel preserve backwards compatibility
+for these features?
+
+A: NO.
+
+Unlike map value types, there are no stability guarantees for this case. The
+whole local kptr API itself is unstable (since it is exposed through kfuncs).
-- 
2.34.1

