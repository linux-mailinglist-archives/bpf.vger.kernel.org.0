Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C2618841
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKCTKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKCTKg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:10:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23F31CB1F
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:10:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y4so2852730plb.2
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJcqn93S4tAYEePwJLhbJs+QlSoAYe/24jf1qS9h1BI=;
        b=oKdcolRppsVRrEPGDg2C9n+0UliKLPjoKj3IzE6Wke5uFhxKF8gCfJocGbt3cnT0d1
         tONyvkbs5ODoyip6uFA5O2E2/uDZ2ybA0BERj2rFkzJNoxL6NZVeML5U+B+1JgYypvPG
         QWF/Wr4Vg+4/MtMdQLlINPJfwEkdJBB42TIGEVtnUF6yRIc+D1tRfV2h0F4TyVOAzrUY
         bKlnqzzv/bU7zVc1AICT048aYqZaXIXRxORthaTRO9z7sVCJaGhj2zckWcsLdKmUqRrN
         f5FotSME2F4WqIRWDwgIgSMQdA9p1/Swkdcvc5NuQEWA0ThOcYccYQWbSiK89vBkiyzf
         bVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJcqn93S4tAYEePwJLhbJs+QlSoAYe/24jf1qS9h1BI=;
        b=phYwfDuGKkj1NLRj+IHtYbsw4DUkG5+yiXMoo563gFO/cIh/dm9fV84hpbgdii4Rbe
         /id2Oz+Ua3nKIlKcfJnEJ+leuJwBrTmr7DqUQjCaEmdH4iBUpeVaJtm0N1HzfztCEMqE
         quWZlG6UP/3Bsf4IHPPrS6FBn+HP9UWHrsbtDZEaF5EIwtdXI33OCZkhfBMWWlYn+0OE
         g/4b7AQYg+T/cRdXFjZfUl6lvXK7G1NtrXeVH2iN1FMnxBoG5hUrQDxjCqEJmGyRMoZs
         VIa4q3LxkiVOU9a1F4mzcePMl+Pb/oTKv/saYiiye0/+UDwRKaIlOognKrQ0FjlnTkzh
         3zJQ==
X-Gm-Message-State: ACrzQf3/P/6z4tmqO0cO4+ym2mImvvc9ymqyvxLW+gnDGJaHRkh9z02Q
        6oXHLbxXoy4PQa6qNTksvgUcMv+gYNx9BQ==
X-Google-Smtp-Source: AMsMyM6X4RIRwJ02BRRjmF6n0w4YAQV+gbOPS9OubpAmCIfGiTXTajsOYw3njmq9p34vx02uQWrfNw==
X-Received: by 2002:a17:902:bf45:b0:187:337c:b967 with SMTP id u5-20020a170902bf4500b00187337cb967mr16667180pls.4.1667502635110;
        Thu, 03 Nov 2022 12:10:35 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d48300b001745662d568sm958947plg.278.2022.11.03.12.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:10:34 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 01/24] bpf: Document UAPI details for special BPF types
Date:   Fri,  4 Nov 2022 00:39:50 +0530
Message-Id: <20221103191013.1236066-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3643; i=memxor@gmail.com; h=from:subject; bh=YJ4YYMjs69QuOCsnkDF7VGnkZjoWWMSjzzlhZWYg6kI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIAMJ+rIrzMLrvMdLV0/3sG/rqpFlecJHDLrPzM EnzNgzKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAAAKCRBM4MiGSL8RyjxtEA CJRzDLu/Pvt6qEfwOsrqXjDgftqzSiEEiIGhI2IHqw6deBtZ0jp+46NDtvNtU+WlBNA3fj7NO3EAuh fGR2AZu5lsfupqqrWWqoBN+7yMToRUBGbb+0PZdRKmHSWmzyxg3564drXvXW1DcXNBs6KXisAjCpkp 4eEc9BXUlMvfvYS1b7DtkFUB5lJ30eLcoilNRYoi1TQhPrSMDlg1NA0tgn/xFuuWMtNvhyRZpU7kt9 Mi/JbXZSNjZHIPqDR9Uaak+w2rIHwWybK6MZZv8cbOMvR/IccSsS2n6YjPJBlPOiAyyZmxxarMHOu5 d4GNxSCo1Z8S8h/yClYKr/roEbXjvAwqrGgAqPb+nyldGNV9Nyy0V/HlWhbSel8qS2ZSqzlxCkl2OO 5IJMuV4i285CEaBiWCR9VXn0XF+lDJ/hZ/GQQ1uSbrOVxpuyRJaB01+wmFUHf73O2kJgVj2+MOtyR/ BYZUgpdOMc5U+W0WP/QjVWk16GKDXBa6h3YwYNqkWePpUUE46ZH/8hTNieHUuwtjvevo0sg3Yit9hD ONg0KkqjeCdTRDToGBB0JC0uiFDlguv1Q/PcZ8/M2qAVGgl2nTMYH1aP8GwpZmmfuF5I3Pwr+N308v m2FKa/vZHfnQB3orG7Agd9+gff5z5iDiq1Rq7GLSCLcdBXrORHoBBU/aCS5Q==
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
index a210b8a4df00..b5273148497c 100644
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
+pointer in your struct is NOT part of the UAPI contract. The supported types can
+and will change across kernel releases. However, operations like accessing kptr
+fields and bpf_kptr_xchg() helper will continue to be supported across kernel
+releases for the supported types.
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
+Q: Same as above, but for local kptrs (i.e. pointers to objects allocated using
+bpf_obj_new for user defined structures). Will the kernel preserve backwards
+compatibility for these features?
+
+A: NO.
+
+Unlike map value types, there are no stability guarantees for this case. The
+whole local kptr API itself is unstable (since it is exposed through kfuncs).
-- 
2.38.1

