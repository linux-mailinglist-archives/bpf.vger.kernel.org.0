Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5038620370
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiKGXLU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiKGXLQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:11:16 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5AC252A2
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:11:15 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id l2so12547049pld.13
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvClsRh3v5gFbaU1jzvofNyI0Z9RpJBT7Vd2BU8lRCc=;
        b=leCXJnBsTqt2zPsVDMw7+SsiUzBtyKJv4xu9hGO4K0y1e2vUd2bp8KS1HYonLa9rzm
         +Vx36ZgYw5ajMG2NGGKC8xxQqe4+daI9VmZ12dPnZubUL1H5M2eFQjy5lzgahMA6EAQ3
         FlHLhVszKkoF8MGybJwEjmmaKNAvK1T3Tkiu5MZV0hSj1MZlvkF7sEjGq43xv4JjKqul
         NvH28LwBb9iI6xNQs/lJ9nrmJu3Juz0OWzdkybERZOao8aSbkKrjH+v4UTPAvueokJbj
         I5j2c2vbDQpZgX8CQekhG0Dpa1Wiq/wSV+uJC9rkZY/EENE2qdiLSMnaV33MDU4ig59x
         okcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvClsRh3v5gFbaU1jzvofNyI0Z9RpJBT7Vd2BU8lRCc=;
        b=u8uNcV58IivWu7pPelapNRwQMwi+KgnTqTDi3A7B7k4fbSbWSK4S1ZufJI/fOfe8q6
         Y/HmFWjq+thIzyu3m2WAFEu17MwluqZuP1OS9ClmOL+KCDR9kBwWxxcgRKBn5OXIYMWP
         lxccRjyWo4Q6Xam+SbtaBIgeeIM5d+GW4vthG2+XUekXPGlUVSFDlcxJZl4F3F5TuOWV
         H20lcHgaLyid+NgFJuTRF4c2hAbHgWB3by/E/WnKIreZ+MvmDbexLsHkCmYMyG1CXx5w
         lZmaBD7twahT9IgDKtrrEMzgQnPOFXEGMyEQBJqCWG2Pga9M3vuWUJ5bzoec3h3A8zvh
         iEIg==
X-Gm-Message-State: ACrzQf1MwGhoTTSdjsl/jpRWhH46TCpnkOpYwPBSKfexGb8yov61jMIz
        xcoDsPj63gZXsokY2DXxKIt0V1gNEnvgWQ==
X-Google-Smtp-Source: AMsMyM6qxJYObRu/o6OaNewQ/JHvvsP0Hr1jXcDUP+8+un2UB01d3JS2KIK7epiV3o1HhgTUau3qGA==
X-Received: by 2002:a17:902:9b8e:b0:187:30ec:67dd with SMTP id y14-20020a1709029b8e00b0018730ec67ddmr38613316plp.79.1667862674923;
        Mon, 07 Nov 2022 15:11:14 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id w7-20020a634747000000b0042b5095b7b4sm4662062pgk.5.2022.11.07.15.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:11:14 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 21/25] selftests/bpf: Add __contains macro to bpf_experimental.h
Date:   Tue,  8 Nov 2022 04:39:46 +0530
Message-Id: <20221107230950.7117-22-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=memxor@gmail.com; h=from:subject; bh=3SBEBkFd6yk9WI5S8fottjaJAS2IxuA3Y+yaTULKiTw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+3FvEaxj1+aO2Gm8TsAmFakFfU+XZWjWzSjQ6/ 9REQUBCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtwAKCRBM4MiGSL8RyvrPD/ 9jCmikgaHEMhk1kIml3UXMAoLS2f2cxwCn2YlpS1dVAaNX/LoDOrxJSzyAyPigooOUugtTBNw4bIKl zMYsS+4KTTGsHS1Aiufsdw71V18ZhNV5blhDpToZpAzLyTVZY+FPUVxLDK5Y1RMO9BgcD63PjwRdBZ YDI/wSdt3teb9mkj+JRzEeU+nh11mQqFuKRCDcHs9tEap+rcNvYE/R7pi0MGr4AvWv+wee3rReGn3j WMW1VpnM//MJW0XLM429iCx4XTFMPVpaLycXIaUlWEMLaRqctfW5YoG36IHHQMww4QW49l4zgmXQpz JKDj5bF4tmlKzUX9uCV6Q7gytnRiJD6BMhJuCY1ssLyMq8zYJLV6tYFuwXiNgzIPy3i51f6n7viDIc sPdEANvQ7P+zipHnPk2eqlQvl+JtoEAXOztBgODPKwudpvDI4TzcowZQKQ3ovrxQVDAc5XZjXK/M79 u8k7kKkF7zdgMH5IQAxzXo+BRDi0uYyP1q5+7PjbjX9hk49+TCMTy7W5j5yIQfVoIsXoztQD2mrfw9 3nTcrB8TrqUL/gZEHGps5mXZ15h+EGTFfH5AzhXXjfaL2SegqGuG2SdscIUYw51A3QOkFWWu5kA+ky rFxCvc28LVKJd8F8zz6frRpte9bfWSz8N5b9lVgbmTgxzfUSqJtHoqNgu0LA==
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

Add user facing __contains macro which provides a convenient wrapper
over the verbose kernel specific BTF declaration tag required to
annotate BPF list head structs in user types.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 828dd868b658..c5103587b6df 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -6,6 +6,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 
+#define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
+
 /* Description
  *	Allocates a local kptr of type represented by 'local_type_id' in program
  *	BTF. User may use the bpf_core_type_id_local macro to pass the type ID
-- 
2.38.1

