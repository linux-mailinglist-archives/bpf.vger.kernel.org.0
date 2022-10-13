Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED5E5FD4AB
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJMGXU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJMGXT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:23:19 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D5122BEA
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:18 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q1so750568pgl.11
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxaggkmisATW4jSh91JlRiAvV4fHMmDmN0p8HQGqwMk=;
        b=iZebN3cORgHRM5UkH3SgakBeoqGfQZLwa97KzjN3mpzx7Kckqlrobi99swdv48cmD2
         /hLlr4DQDbuqVJ68xled8O5vcVY1Bc30ikN74kqtsFgq2YsJs0TJfnYefEt7bkPC2ePj
         FuAj0Fr0PqGtdHsI02AJ5giV7HBvkELga5E4ZqLsc9B+uzVutwPsp6NiRXNPAFy5Sug6
         //uvbmJfPyfYi5RvhnREvNv8JD4Y4RaSUIDeEf8fUMoWGpvJAV9v5CVz0LBIheoz3fhX
         p1oQx7CikDPwK67jdjdZIsvdeKb0oky+9Lkpzm5kJVT0TaRY+H+SQFBnnTR8m9EK6h92
         cbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxaggkmisATW4jSh91JlRiAvV4fHMmDmN0p8HQGqwMk=;
        b=rUIbGh0jdCe82hwFbPxVGPdd2QwCqv+ZUhT23QnWxp8h30ikC4nReCJAU0KOqw5kyM
         sSeqkkSLPJiYbWYGixCQMR9IY6ioU4o50QwMHnoKOsi9kJCSvBlgNJq3tYRec0OCM1Tz
         RGC8k/zqNxCY53/Ua3Ya7u++u/6RPWMvF6deuPRn+cHBQlqfQtvh3ulmc9KrGJqX9DQ0
         R9lk9ABaZB1muagaW5GIuhGdiiHj9McQ19zY0WKWaHM5VRSWkFxnO/15kTL0Xogm7+xz
         AKVVQhhKcPjxNr+o3MPPOgLaR2xqjD37KklkIhTdDpVSyJ167jhQ8rxaDNm38oBtW8lg
         eZbw==
X-Gm-Message-State: ACrzQf3sx955E0qRzPvZYoH1j4O6u4f40vVDe4xl0fMcTRVzsj9E32yg
        oJCJVCVpCJC1YiAbzACDZ+JpEsxgX24=
X-Google-Smtp-Source: AMsMyM48wgm6+ZzueToDO5imTa26r0LKaDWJT8JTJWfJpm+O4GBapJyKa/OMpt12yqn2RYzITLW8uw==
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:6302 with SMTP id b12-20020a056a00114c00b005282c7a6302mr34680747pfm.37.1665642197520;
        Wed, 12 Oct 2022 23:23:17 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id w7-20020aa79a07000000b0056328e4d466sm1020860pfj.146.2022.10.12.23.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:23:17 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 01/25] bpf: Document UAPI details for special BPF types
Date:   Thu, 13 Oct 2022 11:52:39 +0530
Message-Id: <20221013062303.896469-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3630; i=memxor@gmail.com; h=from:subject; bh=Vcm9Nk1YNu7y1pvoNSeUhIFNdHm8kGmrXA0pfEo1r5g=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67Ca49axVATAylh1XWjlMYX7AEaN45Y0NL6CuOJ bDKEqqWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euwgAKCRBM4MiGSL8RysmpD/ 0e0/PwFh9GruPytfxX4YvOBlvZL4DUK/uuXy3eaqK0dawJhrNuxcHCL4mgdJKlWYQbfTDQL3zqPaX/ SH1hL5aXy7ii0TKABnoZ6PgHJNoJ6KNQpETzMTmiEuJNFV5emIjEj/mWYcn1UEPJ+hJMlyV7dQv17D 6tlh9a4afdnswM532ePMAZDCdFDJC+jarkiGfSJS2jyPgKIPYrAx8kUboruPk0fvJjBPqc9rtSbrDU ANGppLJMxt9n46BqARnkBzBumxLrZKm5tTSvv8BEwDT/4Pe0sDpA/8dX9sMjaf+gacYYq4EuZkvtHB 2kibgPVtN72NGxDBvbA5ac5Mkt3VEcENPMVorffVT9of6W8o2ZoRh2I6DxEl1vzojHxC6GZBT16sh/ UFiXvFmaX07bVWzOq/Iull55sHxDc6ql3DWSqFsuSvC//6PEt0rjGicXVolO8EqlSOvf+x0HvzxBXq 3BCNMLd7BG/JWiZPkQ4n+TPx06j9paWrqfDvNBp1cve65SGcfcASMOqpZtn+Nobbm2YPCW99HWYsDO D3/Ogt1jDGrLQuhFjobsucDgA3OeP600ZnF2hwyG24qvsn456gDSKrIeGFMnuMMpQ7Doz4Iu6JiS4I lQ0YBs2cUyzFNVcZ53MTTKbRjhdegodxgS5dy0hiYTZYKrvanIvE5GdwqvsA==
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
2.38.0

