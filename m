Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76D74CDD43
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 20:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiCDTSE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 14:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCDTSD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 14:18:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D7230676
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 11:17:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so8164053ybp.19
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 11:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FFg88VD8lHLeFAaJL0zz//A5zVr6Ua46r66BG9JX7Kc=;
        b=AanckrFSwCOURq1r3P+d7lbN50dVjfABAtQAhbnt9L3xr3geDlAhWBj8F6IvffVhEQ
         DVmE/gtmjSNn83Ee4ZQuAgOhNEEs0S5Vt3r4vMX1Bxaz2QFg/+W4QDSSvDqLWBpVzVRG
         gBzYBK5rO6NA5AS3paF6QZoRgv+4PanrKV1pniuHET8mCFEvZxFIU3hpoiGld+B02Nd6
         4tvFKlklvCOWNU5G62CS8HLXNIrKmMGEG7ZmFa4ZU857zgZd7ysWTm8wqvgkQi9eRbQG
         hop5+gOCQtmZCO1osS+ORB/EGh0WockEZ/RFgt6qd34yow6wyMRn738u5wd5ZtBUziyD
         EjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FFg88VD8lHLeFAaJL0zz//A5zVr6Ua46r66BG9JX7Kc=;
        b=7dZiN80i4X6Yel84eI7yl/EpACndBd0zOvw7PQ51QSO/vFVJNQV4p9mvIDkugJ0mkv
         IxbcnSqsMnTsbk/YXrlIxM3Aql3FP80fJLe1ae0h4zqGd2sNV1REyQU6WrcamB/XYNqW
         132KWz4PEi5w3HH8wvFRKDstFcLkZJXehSv5iPzqxqxPRhoZT7iB69g5t60oEEXV7Bd9
         L+arwgY3rX22CA1YG0sPMHsvGeTj+F05nXvNxF/840Q78mN87dsjHm2aW6fGuWJhc9FE
         68TblQfDApL/6vR6863ckjQBYyz+hOld2jAZgHSu/6ef/ADOEg3KN32kC1vrcuZB2Ktz
         AaEA==
X-Gm-Message-State: AOAM532qGFBB2V+vlDnbudkuelmpq3iqkwXN/DV7UCZqj8gJYRIe2kpf
        MQhKLz7x2fFxaNr7UhciaFGibXhNVZ8=
X-Google-Smtp-Source: ABdhPJxJNLT2bs5kjZIxmXNaSsn/pW/hOGYLTpFlGdVPZcjBoWKMwqKknHDwYOl9GqavTfHtD5FJR/pWgTk=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:d204:6f81:5498:9251])
 (user=haoluo job=sendgmr) by 2002:a25:6608:0:b0:628:d9bd:6245 with SMTP id
 a8-20020a256608000000b00628d9bd6245mr6592639ybc.560.1646421426327; Fri, 04
 Mar 2022 11:17:06 -0800 (PST)
Date:   Fri,  4 Mar 2022 11:16:55 -0800
In-Reply-To: <20220304191657.981240-1-haoluo@google.com>
Message-Id: <20220304191657.981240-3-haoluo@google.com>
Mime-Version: 1.0
References: <20220304191657.981240-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH bpf-next v1 2/4] compiler_types: define __percpu as __attribute__((btf_type_tag("percpu")))
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

This is similar to commit 7472d5a642c9 ("compiler_types: define __user as
__attribute__((btf_type_tag("user")))"), where a type tag "user" was
introduced to identify the pointers that point to user memory. With that
change, the newest compile toolchain can encode __user information into
vmlinux BTF, which can be used by the BPF verifier to enforce safe
program behaviors.

Similarly, we have __percpu attribute, which is mainly used to indicate
memory is allocated in percpu region. The __percpu pointers in kernel
are supposed to be used together with functions like per_cpu_ptr() and
this_cpu_ptr(), which perform necessary calculation on the pointer's
base address. Without the btf_type_tag introduced in this patch,
__percpu pointers will be treated as regular memory pointers in vmlinux
BTF and BPF programs are allowed to directly dereference them, generating
incorrect behaviors. Now with "percpu" btf_type_tag, the BPF verifier is
able to differentiate __percpu pointers from regular pointers and forbids
unexpected behaviors like direct load.

The following is an example similar to the one given in commit
7472d5a642c9:

  [$ ~] cat test.c
  #define __percpu __attribute__((btf_type_tag("percpu")))
  int foo(int __percpu *arg) {
  	return *arg;
  }
  [$ ~] clang -O2 -g -c test.c
  [$ ~] pahole -JV test.o
  ...
  File test.o:
  [1] INT int size=4 nr_bits=32 encoding=SIGNED
  [2] TYPE_TAG percpu type_id=1
  [3] PTR (anon) type_id=2
  [4] FUNC_PROTO (anon) return=1 args=(3 arg)
  [5] FUNC foo type_id=4
  [$ ~]

for the function argument "int __percpu *arg", its type is described as
	PTR -> TYPE_TAG(percpu) -> INT
The kernel can use this information for bpf verification or other
use cases.

Like commit 7472d5a642c9, this feature requires clang (>= clang14) and
pahole (>= 1.23).

Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/compiler_types.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3f31ff400432..223abf43679a 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -38,7 +38,12 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 #  define __user
 # endif
 # define __iomem
-# define __percpu
+# if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
+	__has_attribute(btf_type_tag)
+#  define __percpu	__attribute__((btf_type_tag("percpu")))
+# else
+#  define __percpu
+# endif
 # define __rcu
 # define __chk_user_ptr(x)	(void)0
 # define __chk_io_ptr(x)	(void)0
-- 
2.35.1.616.g0bdcbb4464-goog

