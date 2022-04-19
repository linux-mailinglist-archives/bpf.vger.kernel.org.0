Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C66507588
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350306AbiDSQuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 12:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355276AbiDSQsx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 12:48:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDF5A1BB
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:46:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so2382135pjb.2
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=739vjL9LY0p/rMa995RSfXgomTnKpR8U/ytJ2nU3d2s=;
        b=S2RL+AgK1AC/5pTlZE9k/WE3Lb+JIyoqUvECxRRimWFbXTM6sEFwi/9XKO7HwDOcb+
         r8srrjpUQkOWGFkRyvPoqmSy898Pnq2jwB4S1Ri+lvhlK3f4YfPlsURYUhbRB1f6eo5K
         6BDqD9OEEGl8mfFgkWYXBNcUVvIXoz5SQfm6W0C/e7Ahhnq5Dn3BvO3G/nuROhNsF5RB
         3L1QFTals1RMGuXnxZpBWih4Fp/QP7m+e6YyMSUMhLDk3OlnFEKwLuKrVWYDo8AoKH0o
         NPECHjh+DWokx0j7Y2aFMmpqKEBbj9P6E/GgidKAUFxMtl237EX/IuJgI849zL+Jmoe5
         sFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=739vjL9LY0p/rMa995RSfXgomTnKpR8U/ytJ2nU3d2s=;
        b=7VYh8M+sEMBxti8f5Lkkad0ObPzuEFiDEReiAEv3a413YsUYihk8lhW1qBXzgDFVYA
         axRexfnRd4Y7y/zpoUc2EhheHAg5hSWI8AZkrrtaQJuDENyW29GFHGLnlcx7zFbx1mCH
         EuvDRg8WURJ+sW1OYJQ2mn+vINvaR+cBd/COjPxaxQQjHQgigfOHxZ4lKqYHomqAP4DN
         MsVhmp6rWf3WsGgBLLxM3ycyDSJ2toubFsjIooFgSFgpGF+mHCys0+U4mhejYwgbkb4r
         c7IkmA1ZoY+rb2tEJ2WNxI5ic64A34sbHRyk5Y5Cu351861q/v3p41rUgj494PfcdnvC
         tmUw==
X-Gm-Message-State: AOAM530yQ8e1C8kwIVrnUjNhC1sJAzLLtS/rWMC2kzOFtPfq525cFISN
        uKDtH2E7nlsz9S0n3ijGtm4AQ1w3Hd5XvQ==
X-Google-Smtp-Source: ABdhPJyYtWCNq+UgVibCgEJkWb36qgyFa8d4mBQSj0Qhl6c0asKKRt83TM+dmGERgub1EwSQ0GFbpw==
X-Received: by 2002:a17:902:e84d:b0:158:cd1b:8168 with SMTP id t13-20020a170902e84d00b00158cd1b8168mr16216414plg.43.1650386770566;
        Tue, 19 Apr 2022 09:46:10 -0700 (PDT)
Received: from localhost ([112.79.142.99])
        by smtp.gmail.com with ESMTPSA id q15-20020a056a00084f00b0050ab60bf37fsm1114103pfk.22.2022.04.19.09.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:46:10 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for type tag order validation
Date:   Tue, 19 Apr 2022 22:16:08 +0530
Message-Id: <20220419164608.1990559-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419164608.1990559-1-memxor@gmail.com>
References: <20220419164608.1990559-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3559; h=from:subject; bh=ZgKIZ8z383r9uxUfOYo5R2SG0HzGgrN/t/TWvMmBZ58=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiXucw0pZdon9Y6wT27Ks9900S9k7qPc1lNijT1AsM E8B5iOOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYl7nMAAKCRBM4MiGSL8RypTxD/ 9VY4be2uLZRYRwxWDTlvEk/gAYnAWx5QYKbiBOQaTlb/VZHdbbAWd1DY5ZhKk+JCkspwG0L7fJRtiC rg7UunfiYk+LtsD2skz8YzVBAq+fykey37wecv3yJ3blLURwLydMWB0rNfE5xpZetVMp475EUT5Obg LFhb+vz2m8BlqiCZvP+T9fj/BaXVREBRjGglmGauP1MGgBVgSmReOr2waxWhjcji6+axPYfFO8g/aQ qkxLFSoHbs3EMqnfIna0GRAcTlEAnYuUu525uj1uD3UCpbOKfVDPaT4eP9DGvTKI2/MbmXpt+SRfVH ho3xxvuCYMapy4iQlutzmZgzBfYVm1Ejt3iEfpCcQOdApzfAUqyjklwAIbRYsZ4kmSQaAxixmLkUEC eKkxy76NkP1hiuwol66/CxfaEfAxPXSoW5z/NKofPXkve69aPehHkO8sF2p8eYSF+M0PNNsHfnuPg6 8pBTDu5ectq2VByj70vAt5XEUFJ8hl34ciSBEu/9MlONtCAQPIpnqEDB/kAMOOnW9lAr3ZTt+2FdEZ 6xUXpenDWKXN3m36DZOQw3r0ZrtgE1Zgf/dkuLUqyWk2KiIDVwh9ANzF7Y8V8O9HUGi+Nqcro79zzX jXZpO592V1/l8r5Fju2C7xW8+Cagw8jHYVFJCfLZRF1Ml0orsHvyX0V6w6SA==
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

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 99 ++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 84aae639ddb5..ba5bde53d418 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3973,6 +3973,105 @@ static struct btf_raw_test raw_tests[] = {
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
+{
+	.descr = "type_tag test #6, type tag order",
+	.raw_types = {
+		BTF_PTR_ENC(2),					/* [1] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 3),			/* [2] */
+		BTF_CONST_ENC(4),				/* [3] */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [4] */
+		BTF_PTR_ENC(6),					/* [5] */
+		BTF_CONST_ENC(2),				/* [6] */
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
 
 }; /* struct btf_raw_test raw_tests[] */
 
-- 
2.35.1

