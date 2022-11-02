Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754FB616E9D
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiKBU1M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiKBU1M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:27:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C46C1017
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:27:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 78so17200464pgb.13
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJcqn93S4tAYEePwJLhbJs+QlSoAYe/24jf1qS9h1BI=;
        b=ShR9ZIy0Y7Si6Hp45OQW8K6KwkSc6npylfL/FLeA3vqRY2fBaQtER3kwPI8tEEqqSw
         2kOwE5B8h/6tJCERZYxJXbEJ+4URKrTdnN7loTY5fmUz1L0xX0Qw5MZEmX+T389ppCH9
         9lXDH2gvi87yGEUa8HvNl5y0ds+FbT/i+bSMXXGy6hnx744hf8AWfFYf0wgYZGFIKdvU
         PcoU6C4iCc+gg9JkNiQrWM9aKUEkPkdDJ1c5HmILlcX7jXaE2A6ttqgRhgq+CxiElFR0
         4QHCAuTBc1VCm7H2+p3ymjYV0Ei1TIUaT0iUKL7jwDCT3MENpgrHla3P0nu6s78nGzOC
         Bzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJcqn93S4tAYEePwJLhbJs+QlSoAYe/24jf1qS9h1BI=;
        b=2CZCMoA8zfjWpUT0ydXSucq4rgdVbA9F/z37RQzm5mxKJYvnwrMEfc0/wQI9Lfkw6u
         AwX3SruS4ip6FfYD5KS/rETSMJ4NyxO6qKVwQPZil6zFxdmE52MkAa+PUAXtAxHLHr1j
         JarIAU4ThIVGuFr0QFIMub6k+fTK5o/Xtinx05VQS3rojUi4gtA5FncCTRGSy5ST2vUE
         Ax2khj/fehYnL9a0tqnn+8oUKRMfR23QOV5hDsl5Q5fC3c9Sk9ivKkNCrw9slkZtRDES
         ZfVDEGCYAqc/N3V0ypPYM9sIQ72IRkx0oMsNqU/zFdCHUEOjiEIURhIxD0J34X56TMYW
         f61Q==
X-Gm-Message-State: ACrzQf3hDu2nQk3TvGP7q2UXqH5j2GJu3hIW7aAXVrejKDqQzFnfrI1b
        /eEn0cBOdDRWLr/KGpew+ad4NHByDR/kKQ==
X-Google-Smtp-Source: AMsMyM5US8ndr/wFe2tCcmqhLcCPncVpqIsr8wD4/aX81mSK7erf04UmKtIqQQoHwPA4vfZhkRUBoQ==
X-Received: by 2002:a05:6a00:24c3:b0:56c:dd9c:dab4 with SMTP id d3-20020a056a0024c300b0056cdd9cdab4mr26945058pfv.36.1667420830700;
        Wed, 02 Nov 2022 13:27:10 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902e48200b0017c37a5a2fdsm8640769ple.216.2022.11.02.13.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:27:10 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 01/24] bpf: Document UAPI details for special BPF types
Date:   Thu,  3 Nov 2022 01:56:35 +0530
Message-Id: <20221102202658.963008-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3643; i=memxor@gmail.com; h=from:subject; bh=YJ4YYMjs69QuOCsnkDF7VGnkZjoWWMSjzzlhZWYg6kI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtICMJ+rIrzMLrvMdLV0/3sG/rqpFlecJHDLrPzM EnzNgzKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSAgAKCRBM4MiGSL8RyjwrD/ 0UhbqO9LZyGSRvyNYtjuzDHb2K56c3UXXZvtOqqqtbxBK4/+xNSYRwO5fCrT+sbHduXUx0f1BhImW8 6BqzBdPBuJwkb3i9SlUlmtONfyma8kwu4x+M24Fxvdq2jU1TsUo96TjRMJx3+yCEJkRxqrXcEOXsgv cva0eZACTedlegGEhM55bUnmhBOOZLxRkLoTY8UgBxArYAt6V93EhYEHUPnQWl1YWE6osTflcYNptr 4BVz9Jinf6KTxXfLgQNZewjO4IiVwPYzSS1tRaIhSmpim1/NwPy9gyoUmrfCebJNzRkXkhDaPLUik3 Vl+FkQgO8axO8Ms5C315xqdxJ+55k3D/tZULSfnpje1bRpTwvgaiT+udqnezPnIu1dwI6A5D+lyEqf G6imoA3uOkRcjGGbb1zDPLLq3HPZ9l/oD4JuUR9AfCVZN0BNAiOywGcassZzbb+5HUP619d1PnniwV abKTS/xpTF+aFtzu0uXXExWi7ErhCA1Cy5zHAKcnFbZ60FORMPpmj0pi7lzZSEtWOgnCOpoZeue+kn hzNU7/sFNdFmx0NOD7c72pSRJXcntEAe2Dp8k9foaayu0BLcTItltIj95MoFtFzjE2JB8xdq+6bP1Z DewE4DTy3ImMBseORJKjeKtmO0ckra/13bY78A0anJAGH72803iUxbppvz+g==
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

