Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE71616EA0
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiKBU1Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiKBU1P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:27:15 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9025FA4
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:27:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j12so17675221plj.5
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=679rfVZbUxs6B459LaScwwW2xi+VSC4APp1SM8g6Ncc=;
        b=DB+jsykP03wuE+/hbuMSCyTqedKfvnL6Ye32ELR1y0vNSM4jWlhlMBiXlO4EDNUefG
         /4l1ODWHz64KVQXbPsP3oHtjXsR9NVMHrTn+A9nP8E5JB+NxdGytoDrvT9Aq7NQke4RP
         I4D/+g+3p1Mr8hm9xFmMNUeI6IJtYy2hOqWIqSoFNNu/2iGJXUsJ6GxRE6c6oM8ca5Sk
         BbGY4seVcSsFrCHFEZ/4428dhatVhSU3ed1KGofUe3n1Wq06VbPC8X/uHXGZAxfgJdPk
         1k6sBNHFPNjO5uuIfJsFFw4S3I8oct3kGuTgBSswe9CkMgEIsdMcvKtUXrgtCbq053rT
         PBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=679rfVZbUxs6B459LaScwwW2xi+VSC4APp1SM8g6Ncc=;
        b=GHreCKusSOrY3ech/8X7qQpjjveXXDzzF76rLCb3rZZZ09HvOWvbvwhnvLxw551L76
         lQEv+veOj0fs9G32dmLC06Rz9pTPObpSm4HMD7uZIlxZbj7bYFlLD0rWoyWH7smg1JDc
         MqvoIGlts/W53iYqZy5Nnt7ns2+Q8YSBcZ2Th1RtW8TSDNgU+hhpRMQHFCoBKNk+C6lV
         Qo7MhPmiMsYyiQ3nlAyW4l2buFgWCpMhigs6m2aTr42ois4olxmTOpoIL0WdvZRiRXv7
         RwgbiJ6fIcENpDu2OFIm5KAOoSc8PWmLJg919ztEPWiEVD7wXuLgp3nRQTAZZSDsBXW4
         ry8Q==
X-Gm-Message-State: ACrzQf3o+5/KtPme8tuPbEmxP6x2CJR/yWuPgIk0kW5kizLfyODasWcs
        /431+23WD/JT9/B0LnaO4ilKfydTHd0Ezg==
X-Google-Smtp-Source: AMsMyM7eJUjI+cSbaaAHefeEixmTEuPg+6tODwlFpOO4NAz2i9WjKldD1Nxv6GXdSshgoDjYSbXMtw==
X-Received: by 2002:a17:90a:df91:b0:213:8a69:c504 with SMTP id p17-20020a17090adf9100b002138a69c504mr33296053pjv.82.1667420833775;
        Wed, 02 Nov 2022 13:27:13 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090a604700b00205d70ccfeesm1835744pjm.33.2022.11.02.13.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:27:13 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 02/24] bpf: Allow specifying volatile type modifier for kptrs
Date:   Thu,  3 Nov 2022 01:56:36 +0530
Message-Id: <20221102202658.963008-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=memxor@gmail.com; h=from:subject; bh=axG5JWCUjCjgtvaXzroncQ370dgLYGtaV9qCFkTtWp0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtICs09qCok2GndHgo13T3/TvXzZv6eBeNIfNNpd 1vpsS0qJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSAgAKCRBM4MiGSL8RysaYD/ wOs+dkh01+t3NA4hplzthmhBCqG6ZMZB00hbAJ6upY0FECBaWYUYpKr/bvzd+QSHokEjQ4rSIwhsMJ 0OU/vtc5psXOjuoa7hlRdkmcdgHREhIrWjLzBe0k7qwZOhSfPMYp55Rg/ahU1T1yYrOUGREq9cN9Yc C/YxmPXt4YBS6ny/BvFx/UByPmMM2DU5xHnd2L/OiFBaYCL3S8T2wzvzvLAZJ5UJKBD79WYKObbc66 2MzISjWmjwFTjkQ6jZ+BMv1if02goKfScOH8a+znamRKDaOLOXcjNYchIvcDaHQSkf/P/WgSxPcYgy D/5eymUvcgSk3N+WwJDLswk2y913WjZtJ67kuZ12iS9mK+9xft3pU99OLQYVKsOvt8psujIQOzTkEN WXtbgrUwjCtwta+z/6SKUnNH5NMwbWfYijXP0LvhGVsFvFOXhtn0J0lZ8ur4dMEF4tq3nl48zh8znD IRPdvtQAIdfIojJ17fhgW1EdDdSJ6YlM9Dn10aNTCYV1N00XxRKKYrZhQ5sbOC5/qmJS/I2hBIlREv uuqW8bfDeuQ6r795EQpNvnK30meGbwV3eNwgtS6zfYeYFUgt/fpcyx1oWT25404VyIKaRoixCYmk7W Qy7oTW+cX9EI84yqcGmYCDnictzH7nJiOjkCVYM5rT4DMyWnq1RT7c0+fTyA==
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
index eba603cec2c5..ad301e78f7ee 100644
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

