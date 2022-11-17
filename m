Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2897D62E1B4
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbiKQQ1d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240397AbiKQQ0d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:33 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B2C7AF74
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:54 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n17so2394111pgh.9
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bydv3kCbIfnpZJCDWVNSsOM/hEDP+5Rsyiqy1sq5Ic=;
        b=HQ1HskR8JNit6lWgY30pYKbr7WhSV2GrSOvLheZucxesbcT1pBuqR573V+NKFZ5QxP
         PgshxlAqkNsbgVMfkCHcW8ZI6glMEg/NqooL2sRHa1S+4qDNFNzzGliu7+u2s9m7FxAP
         zLYtmnUUQ1DaowNe2ITs251Y6Ik3cKjkbCsQpG/S/NWkjsLMrKnWpFou0AyS93mCUNj5
         2NFnV7TSX5L8+BEs3UnmBx6f9NNM+kUpXgtNrUqgBQBRBSkkvS1U+Jrquz1IySScgCop
         G3JXkgJWdSjjo2G5Fh9yzT80kcI7YgW9RQ0z/7b54ZMi29tTLIKmmctl1MqkmXzNgJaU
         SNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bydv3kCbIfnpZJCDWVNSsOM/hEDP+5Rsyiqy1sq5Ic=;
        b=SLqtQsjHSPws7MTTql8pnaZLbNbrZcw1xYro/oIxdxFnHEYiM6/aufXKXJKNtctPGu
         tUX9D5AS+nf46hK/cD/umu4yV4vE+Qp0jmQ2ajuHrRBn8qEcUsfE8hYQLshTULH6TK3p
         cTlA2BzbWAKjkCeuXjrl2Tph5L+v/cTZKPAb/KZe2XX3cBXCaPD0MJ1A/n8OwC/LsXDx
         ZZxiv0EK4qSUgaFGrQ+PeY7oaoZI4xQXvAyaHEyLWfCYa/6oOfeATLHgUhMMJjWasRfc
         A+wqYUo6z7OqYawLr+8pIEfcOKU22B6rqBatSPF4adHvkrOKdHaiOTddP7hUYAt2XqUm
         OLyQ==
X-Gm-Message-State: ANoB5pmQhlKBj3MUEOsaFuhujjFs0MZTka926siDdtniyfiGrFbogpHo
        kBg0q+ZPiMfZB1GIosCj4J/fbhzrnQ4=
X-Google-Smtp-Source: AA0mqf7CReYO4QGKEScA8irS+r/6JFrII4tFKmuR1IA2iza1J8vQPg+k/KfO/uaiWvCWt5adobB2Jg==
X-Received: by 2002:a62:a515:0:b0:56e:28b1:56a3 with SMTP id v21-20020a62a515000000b0056e28b156a3mr3687711pfm.43.1668702353255;
        Thu, 17 Nov 2022 08:25:53 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902bd4800b00188fc33e96dsm6047plx.198.2022.11.17.08.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:25:53 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 18/22] selftests/bpf: Add __contains macro to bpf_experimental.h
Date:   Thu, 17 Nov 2022 21:54:26 +0530
Message-Id: <20221117162430.1213770-19-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=memxor@gmail.com; h=from:subject; bh=QUh2azS5YwjYBzJI16lM6Jjvlpavd9KadUbWM8+nCmM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl8ASV6X77+yli7nBHANFRr4j1zNcbG36mWEM3uR skI91oOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3ZfAAAKCRBM4MiGSL8RyjNAD/ 9/0jq0l/hVQEcMIiGsYnW2B2B4giYgO42/gUXygwwEfM1DyPhmksKkCMnzBaSTZPF9st38ip1IVgWX XGkvuIdsXIjZucHfQQNfVzCHfdSlDek58QJLG2+dYSH1IufwQhCx8yuZdqNapNeMkaSJrabilMr7zO dhjn2BLgl8Mlhh33CDNoa76ddPAWBYPkAuR2X4tMyqmZG9Z9WgRbv9wULSt46rGjvyA0EDszk7K5mK or4FzoBFlaMM1a9e6iyy761bxC3TK06kuWGVi+CKbL81yLVzYndOHp57QX34xE/KVX1tcI8u0CLCHa 8LYHWTPELx3QSIrabycgGIn5uiT3CO1pDfKnMSuXodrXd80oESFGk9kjVzOCWThOfh3UqA3n1CjmwP YZs0EJvGHuUwtcv2rqmA02QNlm/Piqkh+F+FAzKAUa3S7gjmATx0BhX/MGt0uOTUEFcjVJa2vuJvVc AtkxeVgaU5FsfgjvLkcu8hrEMzowmRWGq/c0MtGCevppNuuCdyNtmGTXcbU/KSHnkpTIewJaDeGqRy siOnAJLReHDz2SDFbbXW1NSp9BzrepNSqN8CM0GpzF/m7Huf0wzkCcaHFrKSkl+yNGf1rizpL7JhPL 6I/7JdiPcZOumGL+FtkNm3JXKc6EePwOeYz6evY7qYbjJglIisCLyhJn5ytA==
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

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index d6b143275e82..424f7bbbfe9b 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -6,6 +6,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 
+#define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
+
 /* Description
  *	Allocates an object of the type represented by 'local_type_id' in
  *	program BTF. User may use the bpf_core_type_id_local macro to pass the
-- 
2.38.1

