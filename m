Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5662E4D5383
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 22:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343706AbiCJVSF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 16:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343945AbiCJVSC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 16:18:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C05179269
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 13:16:59 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p69-20020a257448000000b006295d07115bso5533689ybc.14
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 13:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=R/v6KW4/eQNCq3G1uNeftKx9yVwkfwEl1Z51lMH01Iw=;
        b=RijW4NhWbanUW0eqBv6ZJPqUG+6PV38erP0aqfQZxAJyWErTgggoR3qtmkTJ252lcI
         bn9WMcxJKPNPVIkG/gmUkpNfolmeA60A8AD9sV9KAHZiCD8RhY/dzwci5id0HY/OE9Uf
         UPq2tqnwhfm/oxaGtQv+XKzbaX0I4iFeZNetUradNRP7ceYsmQ4qyVTAltcK/qhhnb69
         HN0Rif/Eaxi6rVyMvj4WxdmIS8AScjZY9hO1Zm9HaxWvK31HLcb7J4/hR8udPVLrahh5
         Nzi9DreDs0iokLJPLs3lb7H9Q5H1pfj35ccAJjPUHCXxaf2d605XhUNCyIP/DoufBbe3
         ybgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R/v6KW4/eQNCq3G1uNeftKx9yVwkfwEl1Z51lMH01Iw=;
        b=efxNvfY0K1jctc8fsl6vkZIbVcsJhdj2Y0xANnTfOxmTS7b5syeaIxJdcSoG2A1jgX
         vOjGJcKfIuCg3yfCPxSboaUDfUj62TiFLbLriqdeGtOUbepuCxClexaqCn+OSuUcQHpy
         eVJHxOnFDhUtA7B6c8Kdw0vKb8UFzUWPdUa+W2Gjhf6E7MLVMMIR+BV0Sq6J3GUZse0R
         o/D0Vm7tJPBZd3bAzinbQzJY5z249rGkVL4Q5uyMPWQT1FswYDl3sNW2iQTh/2/dIrd3
         PpSQE0pJ0RwUZi+xsdQqSypMEazEsiatr1mB43kUmtP3aIbJBaIqgriwoGl8aPECHzKV
         9CDA==
X-Gm-Message-State: AOAM531rAwCHejLHm8yQxz5X9r6IeSJ+pYAeL3ePGxtACL6kv6BrpCnq
        RbFmffI4i95DXYYHRUZtweqF4kEPGug=
X-Google-Smtp-Source: ABdhPJxiMOHXFGRWJhxq3dgpT/ouBgijWM84sxqbKmhnzIGVKdFopaH4O1YcRv4G+B4K3lhbMmERdeCA22Y=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:6cb4:9e19:c513:9337])
 (user=haoluo job=sendgmr) by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr5396280ybe.365.1646947018999; Thu, 10
 Mar 2022 13:16:58 -0800 (PST)
Date:   Thu, 10 Mar 2022 13:16:55 -0800
Message-Id: <20220310211655.3173786-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH bpf-next] compiler_types: Refactor the use of btf_type_tag attribute.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, yhs@fb.com
Cc:     KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previous patches have introduced the compiler attribute btf_type_tag for
__user and __percpu. The availability of this attribute depends on
some CONFIGs and compiler support. This patch refactors the use
of btf_type_tag by introducing BTF_TYPE_TAG, which hides all the
dependencies.

No functional change.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/compiler_types.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index b9a8ae9440c7..1bc760ba400c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -4,6 +4,13 @@
 
 #ifndef __ASSEMBLY__
 
+#if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
+	__has_attribute(btf_type_tag)
+# define BTF_TYPE_TAG(value) __attribute__((btf_type_tag(#value)))
+#else
+# define BTF_TYPE_TAG(value) /* nothing */
+#endif
+
 #ifdef __CHECKER__
 /* address spaces */
 # define __kernel	__attribute__((address_space(0)))
@@ -31,19 +38,11 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 # define __kernel
 # ifdef STRUCTLEAK_PLUGIN
 #  define __user	__attribute__((user))
-# elif defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
-	__has_attribute(btf_type_tag)
-#  define __user	__attribute__((btf_type_tag("user")))
 # else
-#  define __user
+#  define __user	BTF_TYPE_TAG(user)
 # endif
 # define __iomem
-# if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
-	__has_attribute(btf_type_tag)
-#  define __percpu	__attribute__((btf_type_tag("percpu")))
-# else
-#  define __percpu
-# endif
+# define __percpu	BTF_TYPE_TAG(percpu)
 # define __rcu
 # define __chk_user_ptr(x)	(void)0
 # define __chk_io_ptr(x)	(void)0
-- 
2.35.1.723.g4982287a31-goog

