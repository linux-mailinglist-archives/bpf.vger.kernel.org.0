Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3B265A94E
	for <lists+bpf@lfdr.de>; Sun,  1 Jan 2023 09:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjAAIeh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Jan 2023 03:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjAAIeg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Jan 2023 03:34:36 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043992AC5
        for <bpf@vger.kernel.org>; Sun,  1 Jan 2023 00:34:36 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d9so9567694pll.9
        for <bpf@vger.kernel.org>; Sun, 01 Jan 2023 00:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+mjdVq/lm8o2u1+aLRQmVRqK+3LLxx6Bpmv9V0f4BU=;
        b=jk70oeVTZjk5L2lF6nDjRCl1vJNgLHeIHQM+zTFmVHSZFK9T67R/QMQvwBaOtdM75M
         J9Euflo94zXqeCqfu7vcGqW8EDYfzpVOSAUzQsgJHO9vpkqrg455mfggsacjx+ZrrUiE
         HUKpiqKAZdauuvIRTpMjrmp7mZLFo6MEFMjYlm3NsM4UUQL16D/ziSWchZ+txU8wgRAb
         H1Wq8CRVLZPSRjdRVQt91tTc8iB5sdUYDQB15N653Pi9hYMlI3ddX/ZTfOSW5Rp+hju3
         JWq6GYWHqZe9YQuHSwRQWjwUJ7JJGue2vSeWRx4R9utVN2aTTW4ZcccSTWgE0IfEACoW
         eenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+mjdVq/lm8o2u1+aLRQmVRqK+3LLxx6Bpmv9V0f4BU=;
        b=JTWJwRcWCAA8yZdAdYePXP6ZuJzImS9rnLN6XvBqBqWocXRpjHF+qQGrjdaDWr4l2M
         cCOqeMJoxqu0gJoGiAliJFb9lO5DuoNGpxlP4w7Fz8RW6pE8sdBjNSoav+/R9Kc0E6Ok
         vPv9/l7G1ButpnQg7jtRauzmONT6U+T6HRIu4bBcEnkQnvlUWLqxfpXFACUsGeuAmsjn
         IFUx8qgl6GLGBv9TqCe0MaO+ktohIbjz+MUG0eYP8kfKEEm2Rx6esGJWAJlypSGqcGr2
         9MF5WwQdNSJ1xSbiQc95fNEiAMugrsn2quqdpwJuoQkru1O9NV9II/nCL0tFNn9WASgP
         3WXA==
X-Gm-Message-State: AFqh2kpc5S1UV1+N+d8CJBBVXzPZm82S128ar0Yu1a+y2GfXazH696lt
        KGyXGqrBWHPPtN23SVKyIZR8JqG/306nB+f2
X-Google-Smtp-Source: AMrXdXv17V9mL++853ZZoja00kL5FxMBarCRVfC6A5fSQRcqlNnr3X7k5Eh5Lmc6L1Zc1Le/uLaP/Q==
X-Received: by 2002:a17:902:7582:b0:192:4d6b:2311 with SMTP id j2-20020a170902758200b001924d6b2311mr38077442pll.46.1672562075316;
        Sun, 01 Jan 2023 00:34:35 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902f15300b00189fdadef9csm17934185plb.107.2023.01.01.00.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 00:34:34 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 8/8] selftests/bpf: Add dynptr helper tests
Date:   Sun,  1 Jan 2023 14:04:02 +0530
Message-Id: <20230101083403.332783-9-memxor@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101083403.332783-1-memxor@gmail.com>
References: <20230101083403.332783-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2023; i=memxor@gmail.com; h=from:subject; bh=HbuEZDUs+WYocuqEBo6afen2xIUnVrhRd4cXTonJBa0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjsUV1jkqMm9yl9KI8SazkU2R1Oan0Znmjaw6Ldc58 TWsVq4yJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY7FFdQAKCRBM4MiGSL8Ryr0cEA C3h6EGnHwpGhZi8ZB/xnacauXOnCuhm6qngfB5JtpiVQsXKeWKS191SmutrvUjGfeAZyFEFoTaKeIc ASWjmGytSPLxBiRlPYClFpR4xphJLtupoeX85W927+1D+SVtlPYQz8f4mwOslk+W8LYqrVifagNJbk upU4fjvnHf0rmHqYmu6PEZg1e+bCDpQe0RT8DhGcBLN9dpVHcFVDEAT3lr2vSArDRJ9LeQrlVM7CHO MywdT/7PguTk6KdqKOeCd6iDK/x2FXuMuym8uxpwHxToXWILMetYJr+CwWjplLfSSeqp9mfS5XXGmw rx1dFkJ89RR2d8x02IKW6WLjGF9PQvh5TwM2qbWMW7o+hESBD/X7Cb2imh47JyVSsKkFCKJCswCI92 1VmkXZzM8aHVJFewSjH0n4zxQZD1ZpKrfDQ22wwK5+4JvV8vOvovoIne4K8S9h6Wmh22WcR4grka4+ CQaRrEDwpdaIBDK5VUkRJC8hE7NzOGTJjzxNXARkMi0CQdNdIm2Ug59yKVAgBQKvnWZiyJJQFzSiSs 8ZOL2FXV+3Hejxckc9MK7XM+t+c6A+EvkooTmvijd0amhDpzhuEZksE75PIc/diuIQJF/iYcOlElYB +zPvOf01lR60wC2EyNFxpTIooJwpsiBPaap38bSDoghFH1+GZ5YJheu0XLZw==
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

First test that we allow overwriting dynptr slots and reinitializing
them. Next, test that MEM_UNINIT doesn't allow writing dynptr stack
slots.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 32df3647b794..73ae93dedaba 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -653,3 +653,65 @@ int dynptr_from_mem_invalid_api(void *ctx)
 
 	return 0;
 }
+
+SEC("?raw_tp")
+__success
+int dynptr_overwrite_unref(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	get_map_val_dynptr(&ptr);
+	get_map_val_dynptr(&ptr);
+	get_map_val_dynptr(&ptr);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("Unreleased reference")
+int dynptr_overwrite_ref(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
+	if (get_map_val_dynptr(&ptr))
+		bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+/* Reject writes to dynptr slot from bpf_dynptr_read */
+SEC("?raw_tp")
+__failure __msg("potential write to dynptr at off=-16")
+int dynptr_read_into_slot(void *ctx)
+{
+	union {
+		struct {
+			char _pad[48];
+			struct bpf_dynptr ptr;
+		};
+		char buf[64];
+	} data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &data.ptr);
+	/* this should fail */
+	bpf_dynptr_read(data.buf, sizeof(data.buf), &data.ptr, 0, 0);
+
+	return 0;
+}
+
+/* Reject writes to dynptr slot for uninit arg */
+SEC("?raw_tp")
+__failure __msg("potential write to dynptr at off=-16")
+int uninit_write_into_slot(void *ctx)
+{
+	struct {
+		char buf[64];
+		struct bpf_dynptr ptr;
+	} data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 80, 0, &data.ptr);
+	/* this should fail */
+	bpf_get_current_comm(data.buf, 80);
+
+	return 0;
+}
-- 
2.39.0

