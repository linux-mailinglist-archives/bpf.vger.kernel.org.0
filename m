Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551A3618842
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKCTKn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiKCTKl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:10:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF45A12AB2
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:10:40 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k5so2562169pjo.5
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Lc706GwNapjFquiXyWB+lyzui/fdMPG+KzVG5uKH9M=;
        b=hLmpohcGeb3rupAWnsIS94fUs44DgeK3+73xtRqPX9kXCFxiaXEDrXXfjVip3qiRAv
         MxurJEcgRCcm2HFnhbpsAHhT0T2Y7D9yWjYWVNJwWAMagf8tVWlZMmJZApqb69lym4+6
         XeH78wzM1n9TkxV+Z7qCmXVKWLOrAinAD7odFDZYyh20WdohE9z+LJwiNOtDC76SmLxz
         q9munmipu+6wl6ZC1AVZBGqGaBRYFT6T4eZrJyEtqJNG49Q9o1Q4+qlB2jL/lS7hdluY
         HK6OlU6W69Lsk6LKujrMD+3FrdbObZI24tQ5gL7eIYMPLPhXXdHYfqo5pECFlIsyeft6
         6QXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Lc706GwNapjFquiXyWB+lyzui/fdMPG+KzVG5uKH9M=;
        b=k+7HQujxE3GK5cdAF78lZD/wfAH7lE8abYfk8+Pr9ia4LyqsLKRxmVavtCNa+OcitU
         mFEo50rQQ3GUE5XwSBjO6w3/O1qlkLS0VSMYpJPBqM2g4dTzzGW8T3j60YQLDuiYbxnd
         efdJyc2giiirV++W7PIYYQ3/yvSwDWGqS7yVKpEsQv28+V1ilRVJeN8Y6ZmRhh82GRJ6
         LUCpU6nhlaBMnyrLgVyLuIZ1rpEFUcCUjV8N4JjXq/jScqo3Ol1jVsCr0yC21gcvJwHG
         aFJcE3LYIZSOfAl50Y33YeBpp2OuNeU632JS2L9qbC1CMaOTDUDqW2mnk92njM+5IptI
         mSNQ==
X-Gm-Message-State: ACrzQf1/XMEX+zoFkglKjLKQQ2KjEPBYtWjJijga8CFB+QvSipXurR/n
        JfHA2pt6C0wDWSsqSOEm0sCopT5/XdV79Q==
X-Google-Smtp-Source: AMsMyM5tsgT+wKItfDA1wbeA8/m0QU77gQ762UTIuvN4gkHYgGHdP0UvT2/PPevkxFMX2xNumsv5aw==
X-Received: by 2002:a17:903:11c8:b0:179:de93:bd7e with SMTP id q8-20020a17090311c800b00179de93bd7emr31693553plh.95.1667502639877;
        Thu, 03 Nov 2022 12:10:39 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902e35400b0016be834d54asm932184plc.306.2022.11.03.12.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:10:39 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 02/24] bpf: Allow specifying volatile type modifier for kptrs
Date:   Fri,  4 Nov 2022 00:39:51 +0530
Message-Id: <20221103191013.1236066-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=memxor@gmail.com; h=from:subject; bh=UE8V6yvdXZF76Mps6QpQeIy8MEWTIpPT5HrXdPOKfh0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIAnT9XFt3DkDeOqLgO/iWSMVxRkePd4mVpqHnS G4FfOCKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAAAKCRBM4MiGSL8RyoohD/ 9BCXS/aT5Wz9Na7pFXMMrEdb9NikkgrbocB0IYZ54Lj+3pEsIEpjbe9U1qx9rKclAonMZZqtrQ4GcT FoP68vChY8zooXbYofa5wlqxWcYhILETd+8+QvcUnEwkSv7w5dnCecHhOyTr91WAzoyJo4owqt5sWd HiWfQyDeLBBpDqI6u29A9qt2aYTm1w41VPGo40OrB8BvVXWHLcUjGoYUDVhv54E0LZlBFSQT8YdGx0 E/wUOJLN9UioKYiEpeafzG62zDLgXH0AuWA0/daid5mQAXuBDtoT5UnWKwdo4JaOvrj3nPeQPc5su2 bvutMGmbNoMonU0NEgpRx4aIormVBqlUzcCaepzp7AilDQ870bzUOjrA03F7D1GUPKCOFKOuqoBhV6 qG3CvDHaGMFH+xpd9ovH7sn9ZgUf59MRa+CDhhdxRsDr3NgSLU46u0hny9KINcrn77n4ye2D+hSWp6 aQwiePFibGYiTp3b13vCLXG+zMpzrMxI7c7FDPNSN7gk6WFKZT2FY/vFzqwhvKBYhhMo5zmKcT7q9P zy7iMfjaZClMpbsDwZgxHBoLMKloUVtnFJeGNV4iTbBgbelxz88IV3CekBu2RCYvd42OzDiEQAj3Kd sGuIwN+xc3wQryj5Jm0CRXS7HXNjfgknEFq0fgqDBtQCxXVBX1stojlA4GCw==
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

This is useful in particular to mark the pointer as volatile, so that
compiler treats each load and store to the field as a volatile access.
The alternative is having to define and use READ_ONCE and WRITE_ONCE in
the BPF program.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h | 5 +++++
 kernel/bpf/btf.c    | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f9aababc5d78..86aad9b2ce02 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -288,6 +288,11 @@ static inline bool btf_type_is_typedef(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_TYPEDEF;
 }
 
+static inline bool btf_type_is_volatile(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_VOLATILE;
+}
+
 static inline bool btf_type_is_func(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_FUNC;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 35c07afac924..f4d21eef6ebd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3225,6 +3225,9 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	enum bpf_kptr_type type;
 	u32 res_id;
 
+	/* Permit modifiers on the pointer itself */
+	if (btf_type_is_volatile(t))
+		t = btf_type_by_id(btf, t->type);
 	/* For PTR, sz is always == 8 */
 	if (!btf_type_is_ptr(t))
 		return BTF_FIELD_IGNORE;
-- 
2.38.1

