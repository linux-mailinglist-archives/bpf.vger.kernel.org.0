Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB014DC562
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 13:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiCQMCV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 08:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiCQMCU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 08:02:20 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C1618A3D7
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:01:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so4255769plf.4
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rLAuWGrXE6wrqkBKY8fWh9zUEgpm9ZvObeTDLK1f9d8=;
        b=bh4lj/h8YKKEjD+7F9Qm/x/OGFJXfgTh2Y2F9OpEx8VoBzfP4HJp0BZXZFYJd3rdSf
         RRHEQJ24kYEMVFldzpCaafQQFCcc0eiS1LoTtJGxgjkgeVZ2fNTzM63fpg/gsNERyJP4
         zHA5d1aiZMLYYdM9EzQgryPmls30z1ZnHZ4t2Lh/PERXNygj6u78AC7DMbqOjeKkxP0C
         zds6E7+IZeU+jYH5Yuffdm0tECEt4FyHfUgxZNsI+VGyRVNqHcIKv5OBGAucE3RUi0qs
         Whxhw/xHkOiKE/t5o4LPU9Sox1HsCEl0cTQjmbju1FHYfFHRHXfPXd//7LDDDMjN8Vo3
         83XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLAuWGrXE6wrqkBKY8fWh9zUEgpm9ZvObeTDLK1f9d8=;
        b=l85jk/ovxNrteoh9RK8BVn/HxYTfzJLmIjoYfIzdpmdAdAGznsL9U+dRVLBWK5F1gQ
         Jsz5ZhOr4jIiDbX5uy23fMAcH+VMZDJ+q1U4mcT+XhtAuYwMbWhViR0oGAG8UYA4qvwr
         EawYKRBR4E5opVLbwZ55JWqz7jrB8Nim4Yvw48Y5PtHM3fjX5eVzlxji1O+hq3rYFNFG
         sl6NgMF1ClhxtaR/Pjd6y8bmOQ2IYuxpEGsH0xYAj2eeyNYXOwy3xbzzwfrE5ynkskrZ
         SledB/NPBDBE/4uTm56NxgEomt1sPpleurxKtG59ThdlO5WiUXrYBSClNgqXIRyG8+UE
         vqmg==
X-Gm-Message-State: AOAM531JHbm3QRkE2xsmImRrkz6OOyhPmvYGtY5/UVxAX6dwMn0klcH+
        pUnc4MLdbBkxhMUfIaIZjWaP/9YOqys=
X-Google-Smtp-Source: ABdhPJwvPPqwvdVGBp8DkITpUfjbH9BdeOVK/ghvC0Gm8CmRBrGMwCvdaidD4AAMmYgx3cg/yHPTmQ==
X-Received: by 2002:a17:902:7784:b0:151:a83a:5402 with SMTP id o4-20020a170902778400b00151a83a5402mr4190633pll.21.1647518463820;
        Thu, 17 Mar 2022 05:01:03 -0700 (PDT)
Received: from localhost ([157.51.20.101])
        by smtp.gmail.com with ESMTPSA id j6-20020a63b606000000b003808b0ea96fsm4897358pgf.66.2022.03.17.05.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:01:03 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 13/15] libbpf: Add kptr type tag macros to bpf_helpers.h
Date:   Thu, 17 Mar 2022 17:29:55 +0530
Message-Id: <20220317115957.3193097-14-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317115957.3193097-1-memxor@gmail.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; h=from:subject; bh=OKQfaxeq8Xcxgc1ML16CjILSaozz5plcNdgNu+8OGkA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiMyKkAB7DXBrd+l9BBQz51CLTR22asnN3m1Oy35y3 WkaFgdaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjMipAAKCRBM4MiGSL8RymLwEA CFyDbze7HVdMQ4+yQ36VyWobTfJ0LxZL/pkWb6nOshSQeYvJ7UEhe3beQeb2MzPHUhYsnhJtnrLMeW QIRA/9VS9iTzQFkwgErMSkMb0dDhCLA6HrRyR3tr/qazLArZIsH/I3crL43DE9hmAFt2P3jeFsLvNi V7SA7ySmp+ZVlXxmEOCGBg8mAOVtMCNlq4VnmVY3GnHAj1LtOLrXyM0arGBjdAyCdl4k5HAF46Fmpt QzAUom2WraIfZY2Cqiqf8mX/Xzt1O2/Yuf1rujTOSOiJChtwDJXl+K7gJ67KACOchsohPIy9hWb8n1 mTxf8GY3LkGRfP8/ZGVUvhA8KEw6XWFkym1jji4QgEEutDe5dkGlOR53KjKO/hlAJb9jVGYvA1l1zI ixlGUj65+/Af/8rX5++2RCvtgohXvljDlfzGjsmpkCnxKyzMQK+zAVpoVM+mIjlnlxV6r/w1CKkrmG WvQ/0pQuEyq7EWKrfLZJU7fdSX1WLw2mG1lx9l9aCJRCDwWksSn5EjLQt9mVbiNwQcyLB15ZGogtyO +Z4k4ZiMQ/BDMuhJbNI6xQMt1o/cDcfcT5aS3rEqn3G1zg2Pfrp5MfTcg8Y+VmDPciNvFGIWJbje92 7fDPVPnCFCoAs6eGNRy6o/FxyopdSJEwZrAyDJAFc8He7U55jl8WHwVKNBIQ==
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

Include convenience definitions:
__kptr:		Unreferenced BTF ID pointer
__kptr_ref:	Referenced BTF ID pointer
__kptr_percpu:	per-CPU BTF ID pointer
__kptr_user:	Userspace BTF ID pointer

Users can use them to tag the pointer type meant to be used with the new
support directly in the map value definition. Note that these attributes
require https://reviews.llvm.org/D119799 to be emitted in BPF object
BTF correctly when applied to a non-builtin type.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 44df982d2a5c..f27690110eb5 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -149,6 +149,10 @@ enum libbpf_tristate {
 
 #define __kconfig __attribute__((section(".kconfig")))
 #define __ksym __attribute__((section(".ksyms")))
+#define __kptr __attribute__((btf_type_tag("kptr")))
+#define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
+#define __kptr_percpu __attribute__((btf_type_tag("kptr_percpu")))
+#define __kptr_user __attribute__((btf_type_tag("kptr_user")))
 
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
-- 
2.35.1

