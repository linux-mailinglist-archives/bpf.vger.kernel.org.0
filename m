Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC53672EBA
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 03:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjASCP1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 21:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjASCPZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 21:15:25 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8304467965
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:24 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id 7-20020a17090a098700b002298931e366so447219pjo.2
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yrpR/SCix5EZ4emtkeSeJwHi4dQd0xwh5o1jZ30hQs=;
        b=OuwF3ZJNMpbXT7ece4iWPjjF9m8EdIfffvxt35K22IfPNDbeBHiU80XFwV7mjbmtMx
         y3M/EiU4XJScCqFR31H0sZfRnBt/CqSjshEv+iVRD0OUB4105yM8nDsK0q8M3ifYSTrS
         cmjGG6fzDvsOo/UU6uIDCAt/+N/XqWDpjrM2wdifh3O0MTD+srFu0n+q8CQlunlDWO2g
         ieq+J5ei9LT/S790tGYNYoAfoKM7R2zm5kDRW14DzqQ1tuwkgVYCr2q33xkCUOuPYiwZ
         GYc4tuoHT6nYqh06P7QBsLpc41Ll8LtejVxFg1D6Xmwa1/tuXjOcyeMc6mMM1WahMMiG
         Cw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yrpR/SCix5EZ4emtkeSeJwHi4dQd0xwh5o1jZ30hQs=;
        b=y2mUi+RnKi8Ws7WpEZstsh8Ir98qxkeZS/s3tZH03b4ojyQaT7IwXF1cKe/2P8DEks
         rmcXfjU0Jd3x8qYiN39FEClfUvzzDUIizaKcf14r/dU/qRi1RTn+dD3OzSZXuNRm37Gx
         aOL/lTKVvBzEwksXx3nWoX6vFhYJfJNtUmMoLZsD1R5vQou2n6KlBPnhdpO6thb5sVos
         Af56Zl6LNWebyyCaYgjv0fIJkusMjGRO53nTHwvpvddse/kBP4Cj+TXeUS9IsrpQRcDr
         WC4iKB5uia95DW0GSm4PVAJ4vGd1z2R6RclyPk5RCUA2kRNqU8uFoAzgkt6F9xZm88Sk
         wBgw==
X-Gm-Message-State: AFqh2krWXhZSc1PKODsGxfAueFoBhfefwheAzXpuOKcXFFmBHBE0FE9u
        f41vwKbcWmotm1DeD7dtlMk4gwr5eWQ=
X-Google-Smtp-Source: AMrXdXur9ht9BpctGeuk1F7MFRVOoNDG0hlqezH1RdC9xZozOjhBrOEZKYS4FLSedbQcGU//MofBrg==
X-Received: by 2002:a17:902:bd07:b0:194:9331:3d79 with SMTP id p7-20020a170902bd0700b0019493313d79mr9745657pls.32.1674094523984;
        Wed, 18 Jan 2023 18:15:23 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ecca00b001891a17bd93sm23925943plh.43.2023.01.18.18.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 18:15:23 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 11/11] selftests/bpf: Add dynptr helper tests
Date:   Thu, 19 Jan 2023 07:44:42 +0530
Message-Id: <20230119021442.1465269-12-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119021442.1465269-1-memxor@gmail.com>
References: <20230119021442.1465269-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=memxor@gmail.com; h=from:subject; bh=hZd0AYASHtGwY/BLZDwFFAlra8GAsKg+4NXfOeE+i5E=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyKdAi3sdmPrFCEWEHf1V1ngxI4OE95eXlq2lC+0P mXb6Kg+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8inQAAKCRBM4MiGSL8RyrK8D/ 40VPVTFn0URC2Av6MDWfjwHPks03aAJEQF/tYGji6YWWuc3DrfoswTRS5m6u0ZUgt9qWY6o58NUzbJ 6BMKylNeSqYb/QPxwwq6Vj1uPBYMlHqqd7pXS49Xz8yQ6nhCpI+D0dlMWJV/KhAmAeT9qCP56UFYlK aPVvywJ1wxlrRHlHsnWhVLJD5qrhPH3bQyX5RoWDNhF8NnWsz5Rl3aMWECzuf//g7dluYT/3O2tvL5 BmD2C+mxi5epfOYsP/CUUhWAS4ArooabDlyXZvv/xesqxNFcTQLypq7B0xtj5Q3BugDL7pJagXEFTk RfSGL4VLH3I/L+yW0ouP/Mj9J7FNGKZ67Vq+taVjTSCaLJ3PPDRgsIO6N2aQjS9bfjopqD9p9NoT4e hCVXDzO/8DhaB1D6szGLDAZt8ApLNytIv0pqqgf7yLMhYhtoT/FFJXTPpx9srQuaQUDZGEt50Rm4eG z5fhkECdy2ZbX6DLw0NY998HF4B7SBkqpjQDAaFOmgby6jykwoCg3ZB28TryALzhI9vjRBZptS2xON TqZOUawzb7w+AtGWyXX2pEpslKIeQ3xhBEUZVxo/auIRPqppmtLZwVGiLKXOePDwB5uH4yVy4pNCrp 6CgEFvgzXCI15TpGFgUV2zAuDKNN2HV+xq3sEeDbNmYrRlrXXBiHTDiPKbmA==
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
them in unreferenced case, and disallow overwriting for referenced case.
Next, test that MEM_UNINIT doesn't allow writing dynptr stack slots.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index e63d25d82b05..94686366dcde 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -900,3 +900,65 @@ int dynptr_partial_slot_invalidate(struct __sk_buff *ctx)
 	);
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
+__failure __msg("cannot overwrite referenced dynptr")
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
2.39.1

