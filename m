Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9354F54EE
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 07:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiDFFWm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 01:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356764AbiDFEnW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 00:43:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B391B9FCD
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 17:41:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s8so993251pfk.12
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 17:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C5Z43bSt7+0yZzE6MsEtQI9yzmrKRvZvaRVfXWJDahc=;
        b=XVuB/OWYjwyrpXZ/Mlr3a6wcem9djMsUVoh8tg3bhulG3c6hbUCmIVsub/5cH3Mdg/
         2xrvFFE2ZWPmviff6pzxb3Ua7vE+7MmmCqbmos33YMnxQyN6FXCACEozk3j2RXX+rKUt
         mnNsgAJvX8ifPJ/qBurh0VRpS0P1PPD5hIwfT1nhz5rgZvvCL0VHt/Gt6vS0SIVdsnSu
         E4J3IqwQAzvuIKezLcsrPdMPY5tv5iatu/Rnx7L4nTsggJbMQpujsz3q3HYUeRYndlTF
         EGxiXKz+RI9a+GbMazkR8y8WikjU6gQ4xdmcyjnkxLMmFkUvONdbMj0IHWf2FmUsvpjW
         CSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C5Z43bSt7+0yZzE6MsEtQI9yzmrKRvZvaRVfXWJDahc=;
        b=RF+9Lfo8nfEaxplEj6P4Jo5XzU0yZkfCNBQno6MH95aieZm3IzDSzeis2qC47stC28
         MADMX1tXmMUHjAzoZvFZAZTe/AvDxFgae31oh7UF5Lg1WneJwRJ5O/OIPyB74r8446kD
         S+r5NqyV85E5oreP+LaK26N9lyC4lXeP3KYMm8E7mOY4cI/B2Mqz1Xn02neKgZm0/D/P
         8rMxsJZPVCZ0mHz60rLXAihmtgAyZDRR5R4xi3dB4EFlpm5J0GxUBMi4xN8kqfZq6oSl
         Qm3r5a9dZbA5vHsADKO2j4Vj6zRYqYWO+DsZll8weuo9ZXuAfbd2o5EH7igB4Zq6rPzT
         1/+w==
X-Gm-Message-State: AOAM532JN1k7+HZR114ybCULvtdCNVux8Wv26Lkn3ONHRrB1RMX3eBpb
        itfrujRVQCgwcAnm2wPfKBjgEnYZ0EoS7g==
X-Google-Smtp-Source: ABdhPJz4OVCtd8zUmkaOGXmA1/OIYngogmkP9LbBRxIJ0Sqk+VcysAjqXBCJzecz8R+DtJ3tF52iSg==
X-Received: by 2002:a63:2cc6:0:b0:398:8d48:8b3b with SMTP id s189-20020a632cc6000000b003988d488b3bmr4952810pgs.510.1649205696621;
        Tue, 05 Apr 2022 17:41:36 -0700 (PDT)
Received: from localhost ([112.79.140.207])
        by smtp.gmail.com with ESMTPSA id x18-20020a63b212000000b00398f0e07c91sm11492423pge.29.2022.04.05.17.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 17:41:36 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for type tag order validation
Date:   Wed,  6 Apr 2022 06:11:21 +0530
Message-Id: <20220406004121.282699-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406004121.282699-1-memxor@gmail.com>
References: <20220406004121.282699-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2889; h=from:subject; bh=oBVWcjGruSpcAVr5b4yIzCpS91Or9skqs1D2VjqvUds=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiTOGSow/xHWm6ATo8MYtH3o5W3nYv2+dUMQEQD0lV 9VtWNj2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYkzhkgAKCRBM4MiGSL8RyvnyD/ 4hHyQmzIc6MSUyC97elhlml8WwsKTcPoPu6sOkKV+k3zD8zLd25hw1HTVjVpWsRMABOmRBvbk3GVj+ aRAmtWzoqQrSdd20kUJkTxvDI88IhmmshajKoQwQfngQgcDlEuDzsxMfavc4cS+IMsLyTTD61ivlWi B/cKm1lZsz3t0VoC+K6Z8c826iz08fddFOK+Na953Zu4H9so/sHeGNNcgh0DBykG6Bq2PNe5hSEBic svAWQy5MAEG2ZGedBPguge1nvGHgvCZvAxf2ApMvAGI8gJ+jtqnL8L/+EbsP9gkrUHarBrgswKantB D+uIEnXkYHXeRnwjI7D2Q+YhAYiX7XhqCl/ze+io9iOc2LtF2VO9jKU73gdRv7ihxyRspTFGCanSJu YOQqGM33sctdTIsnkCAZIyVi1VLGF1UsS5s2dYBRkAGekE/eVIFs5jG+dFOz84T4eQRuItEziK1I19 fcuZIj1NjJyVhtHGgBn9znY11E9nG2DyWZc0TQ8Q7E6S/6KOQAVrtlDMICDAUj/T7KYGq9gky7djjV VDa/EXZTGIKWYvYTSjcnVjKYZhis9UBmcM8sjhetcIIG0dwMfvnrUJ99/S25zNFy0pMM/emjZHw80a IcA537o73Tt0Fg2PuXunXHpYcbpz6eDiwy8sWYjJKPJC+jlYBBxs2OBwcCJQ==
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

Add a few test cases that ensure we catch cases of badly ordered type
tags in modifier chains.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 77 ++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index ec823561b912..fc18f0936925 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3974,6 +3974,83 @@ static struct btf_raw_test raw_tests[] = {
 	.value_type_id = 1,
 	.max_entries = 1,
 },
+{
+	.descr = "type_tag test #2, type tag order",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_CONST_ENC(3),				/* [2] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 1),			/* [3] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0tag"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "tag_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Type tags don't precede modifiers",
+},
+{
+	.descr = "type_tag test #3, type tag order",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 3),			/* [2] */
+		BTF_CONST_ENC(4),				/* [3] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 1),			/* [4] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0tag\0tag"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "tag_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Type tags don't precede modifiers",
+},
+{
+	.descr = "type_tag test #4, type tag order",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPEDEF_ENC(NAME_TBD, 3),			/* [2] */
+		BTF_CONST_ENC(4),				/* [3] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 1),			/* [4] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0tag\0tag"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "tag_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Type tags don't precede modifiers",
+},
+{
+	.descr = "type_tag test #5, type tag order",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 3),			/* [2] */
+		BTF_CONST_ENC(1),				/* [3] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 2),			/* [4] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0tag\0tag"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "tag_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 1,
+},
 
 }; /* struct btf_raw_test raw_tests[] */
 
-- 
2.35.1

