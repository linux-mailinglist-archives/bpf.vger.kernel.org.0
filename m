Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E835AC676
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiIDUmW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiIDUmQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033EE2CDFA
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u9so13468291ejy.5
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ze9PJqm74vyhh8KRJv1N1nnoAnnfQz4OCo8i/6eWCmY=;
        b=gCfmG3Svlzl1HZQKEUEeM2y6esjmHadvTwSs07GEoK1g4UL4OfBWnFK0M8VN5wxRXX
         3POUbcDcZa5eD10YtFOkN0rtUvdfZVeqQ0HbRkbampeJfgJ6RLXPPvELaU1SgWLdEpdJ
         30msqed0GL+k7mFABCNL+kuIBULmo4aazec+0nsGUtmcI/mS5FbCRMnJQUtI43sJgtR+
         XoOw5tNDfZkL5M2WdbX8LC1l2YsfPlYNxJ4i6FybsC37z8o1y2CPrOFvQK7UHf1EVsnu
         dCKfSVcMmPQ3R6aCpLYsX6TtpvndWYZ2bIbUaU64xmZWlUOu7PO5QihkKUVA/ERKuqm5
         6EwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ze9PJqm74vyhh8KRJv1N1nnoAnnfQz4OCo8i/6eWCmY=;
        b=KVxE1JZndKX3bWgOaoCiVVoH6rPXrLyaNmUa+u51K0qRm9wZl9sPouoh7iCZ2aw1bw
         UQsyzxZAZR4tpkFo4qZXqWj9Axg1AFWHODfgJ1V5g0EI4VesB1p6i7s9lp4OHsEdu0pc
         TN45U0lPYU9EtCSpeVb6MqyIuFD6ODnmznEh3iaXg7n1WAMf1oEQJUp2rAOdhDiwd8k5
         1KX1nZqn8Jffxh23yNV6Xc8Ut7BP5oUoBEI+XGCLlyu2H8hlmt6a2wr8xUtD6ROVZwn+
         qNCk5zsuuFLq9drIX138PRqKk+6mRn2kq0NiqsoRbqM7p2oNTG7QTVrV/vE2FoYgwO95
         yhTg==
X-Gm-Message-State: ACgBeo0zg2vKkC4128qbot7Oddtspb53yF/fGOmdEZKEnnwcVPRJ05x0
        oGZYyEt2Cb7Cpk85qZoV/oe/VRN8z9HmMQ==
X-Google-Smtp-Source: AA6agR6WRkHsJKAE0aLSlCQsKzfPlFvGONcYRED5SD310XI15JUwU10kr0LwEFufbCKdXAHcjJfu9w==
X-Received: by 2002:a17:907:7f20:b0:73d:d54f:6571 with SMTP id qf32-20020a1709077f2000b0073dd54f6571mr32204378ejc.315.1662324132331;
        Sun, 04 Sep 2022 13:42:12 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id ee35-20020a056402292300b0044dde9244fdsm2403987edb.8.2022.09.04.13.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:12 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 22/32] bpf: Bump BTF_KFUNC_SET_MAX_CNT
Date:   Sun,  4 Sep 2022 22:41:35 +0200
Message-Id: <20220904204145.3089-23-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=626; i=memxor@gmail.com; h=from:subject; bh=f1tVAwd9wAxX70EynJhpDyG+Kepv4zt2hSNjuH3l+I4=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1xEynQKUUAEh8oRAgfxMK4+WY4JQtHEMd/b6K8 YRLauPKJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcQAKCRBM4MiGSL8RynCJEA C6swL3TQLpykJb3yLbjF+B0tQVWePBbuAO5Ixni6/viaTB9IgGgHuC/o4+lOlLJ8UWeUyplcHx9GDn s3HTAxg4q8mzZpUw4MvQqFIKMs3g6Kvexdyy3QY4bzhSA44gp6JKcPo9luW77T6sH+7+zWVSvg/wpz bO/F/OG+jDA3QzrPdzGa2tJpfVKoYv7uPhoQM732/JuiISgpxHXvwfZHyxazagjbbqQMbAFOOeNbof vxEZ5BNuxliCmoucB5qxtdUBzBjKWrOgcRfadGCONXfxlcaAmttjylfYGqdsoc5gBjTV6Ozl5crs9q 9y/yegl1kV96kebuzp+wGxlSTuhcoF3xvxT6mFZWKRIR965XI7oyP+EyLaI2e/ee9WRhNLeYJke/Pw tvngX+rKzoN+pyW2W0nATXxXZ1Kc3np5ndeXkThxObHdVV4d34j8hKhQaGPr8lOPxc7NH4+QAOHVKV ZEaFNlukbWHKOjnFc415Awpv7uRWVOGhouwslNSrczlQ9aJ+a4StcrLs4V98Ve90SJXQTZhKbtQv2g O8Th5Rub0kMHiCf+LlbbRApbImZOw6HFQXUZm6eQgcUvluFLVD18Mb8NQHJDWoTBGzmlUVqCzoCSoV c8lk6/RjDT3P/7OTiatCzv5mvm3UPE0KG+2tBTF/cWnmoTBsrQDPnDqMCQMA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current number of kfuncs limit in the btf_id_set8 wouldn't suffice
any longer, especially keeping in mind the future patches in this
series, hence bump it to 64.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c8d4513cc73e..439c980419b9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -208,7 +208,7 @@ enum btf_kfunc_hook {
 };
 
 enum {
-	BTF_KFUNC_SET_MAX_CNT = 32,
+	BTF_KFUNC_SET_MAX_CNT = 64,
 	BTF_DTOR_KFUNC_MAX_CNT = 256,
 };
 
-- 
2.34.1

