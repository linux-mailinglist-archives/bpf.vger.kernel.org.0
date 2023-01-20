Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C97674A59
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 04:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjATDoD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 22:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjATDn6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 22:43:58 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66169A2957
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:57 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id a9-20020a17090a740900b0022a0e51fb17so1164489pjg.3
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVoBDZ5SNhH0ZFoFgKY8BU2apEtlHMmGUzr6lM5NKG8=;
        b=dsXHhSvwq+lHHudqbuFE/RSYDRxI26UqijY8g7re+tP09F2X6gRe+prdU9UeWfKhIx
         pWWb6rTpTKAu0NQB1cy35fHuPWevhfo88c3VwwD64nicpxu1Xo2myE3RQAuV+gnsNHD7
         v+ibRIVBm1ljD8bjijBw4M/or22w+hh1zptmPBWbbvyVlPOsTwvDn0F62OGZ2JN0qKMB
         /SdXn7LuMwFpSheDZnEqX4dbfvnYZelXadthZ8iPsfYNBAxIzoY9dtCUwhnHxPchFsFB
         t4r2PFd/Jy39/ueF9ji30rUfVkUOI99IJPpj5z/n0nk9gOO6JbHbxWL3WVmZRmt5bbph
         al/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVoBDZ5SNhH0ZFoFgKY8BU2apEtlHMmGUzr6lM5NKG8=;
        b=AoP902FvVGYn9eFlPNQ1xi+vLmE2xsIADADZm9gX5OR783loLV+74sjhzAbHkFT4y/
         kJxfWnWGI8HxkimljxbpIB25/fmk16rDb4Eb7rkENT1jtJN+wNNOqc4PC1aZLAtTX72J
         WJ1Rq8dJHaGYnlHCTJ3/0rjJwDM+fMGV4YJXyML7u8RJc1+PJvDVlqORtVBQhqFSuCs1
         YuGWaIl5ch5p2ALl+rqCuRDYlV670F6O2z/r+ka9CM9Qjs7OEAEqYPw5PX6+oGRwhJJd
         AlN+fpmvK4ljmHPyYPjnQZlWkzH+SzxQNmnjcDGJvKWj8VxblGK334c0EWr54LVsPjmu
         u75Q==
X-Gm-Message-State: AFqh2kqRQeTyE0C4XVsgQtaeRJ0zuXx0QArDIAH+ytN21Wm0uEa9dVlT
        7HGmiTMu5YoQs9BoK/nB73hBUIMemKs=
X-Google-Smtp-Source: AMrXdXumpRquQLmqt+oskm4vNl2M1xqCDRXwzXZbgzwvYpVsITAVeVqpocby92GFsOhhjfxRyO8dZg==
X-Received: by 2002:a17:90a:d393:b0:229:60cf:85d5 with SMTP id q19-20020a17090ad39300b0022960cf85d5mr13357622pju.13.1674186236937;
        Thu, 19 Jan 2023 19:43:56 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090a9a8900b00216df8f03fdsm384908pjp.50.2023.01.19.19.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:43:56 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 12/12] selftests/bpf: Add dynptr helper tests
Date:   Fri, 20 Jan 2023 09:13:14 +0530
Message-Id: <20230120034314.1921848-13-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120034314.1921848-1-memxor@gmail.com>
References: <20230120034314.1921848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3628; i=memxor@gmail.com; h=from:subject; bh=HfD0Om3cGvwlhTzGOGIyATsjFl1oVSy4NxvuU8Dag5M=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyg29g8kIXgjpTU6WXgms8HNf59l7I3AI8OiuQn3+ Kk5oy3iJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8oNvQAKCRBM4MiGSL8RykMyD/ 9iT+QN7NP91n/QorxurSNNB+VYC6ByvmBj4h1IUstEe6Vsefp/AFKiI3BjDaigP3BcfmTZE9NzLBtR D4wMI2sI+iErrQWg7QhySrw6jf0tMWpXRSra5k2ljVphAJDXh9kdJjbVWdt+iBMObnN6vBSSfN2mxd KnUoM07dfbyECeVWzBqIF4ZYHuXFF9Zzr9dlvgQlb4NrbA1ldNlqiOx1b0+4Dz99wGtrIz4+Pvu/bB A2o3DV/6YXZtOvQrkRUztOXLXc+VtFPgXE7yl11sDpfGEm20ZXg4TXO4rVEWbfJXeCTmhr5GN3JcBb MuSMLrf1YK3m/5hYG+odIeRUKKMbsTyiepu4M2d7XmvzBkpFkBLHRDyYcclq6hhRmAs3jwDzgI6XDx WMCGTCkvb7ZTpjOC7oeFcam7iKaf6C7OugvgJQZgz7sQAAfSZgeMSILs+76GNiLnmPolLccp/cbSPT wsppiH3kH1hPNvpCGuU8EbgoZl4Atz7UrOmLrluzNdQFXZgh6BKiG3GIk0Oui0m/yL6DnW+MkAMwLE QaE0fhuxRhCXjCcRjlHV6rXv7RdXEBSsk5t6khAF89W32rdM+7/mGon+VUUEFbDuE2xp8eQl4vSLmU frUv75ZYQ7YyI8ZF0A23Rm4zs/mKCOCcXlNToWdE5RFRNrJgrP9lL/ItO1KA==
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
Include tests to ensure slices obtained from destroyed dynptrs are being
invalidated on their destruction. The destruction needs to be scoped, as
in slices of dynptr A should not be invalidated when dynptr B is
destroyed. Next, test that MEM_UNINIT doesn't allow writing dynptr stack
slots.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index cf2d12329a1e..928ba778179b 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -900,3 +900,132 @@ int dynptr_partial_slot_invalidate(struct __sk_buff *ctx)
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
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("R1 type=scalar expected=percpu_ptr_")
+int dynptr_invalidate_slice_or_null(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u8 *p;
+
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+
+	p = bpf_dynptr_data(&ptr, 0, 1);
+	*(__u8 *)&ptr = 0;
+	bpf_this_cpu_ptr(p);
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("R7 invalid mem access 'scalar'")
+int dynptr_invalidate_slice_failure(void *ctx)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr ptr2;
+	__u8 *p1, *p2;
+
+	if (get_map_val_dynptr(&ptr1))
+		return 0;
+	if (get_map_val_dynptr(&ptr2))
+		return 0;
+
+	p1 = bpf_dynptr_data(&ptr1, 0, 1);
+	if (!p1)
+		return 0;
+	p2 = bpf_dynptr_data(&ptr2, 0, 1);
+	if (!p2)
+		return 0;
+
+	*(__u8 *)&ptr1 = 0;
+	return *p1;
+}
+
+SEC("?raw_tp")
+__success
+int dynptr_invalidate_slice_success(void *ctx)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr ptr2;
+	__u8 *p1, *p2;
+
+	if (get_map_val_dynptr(&ptr1))
+		return 1;
+	if (get_map_val_dynptr(&ptr2))
+		return 1;
+
+	p1 = bpf_dynptr_data(&ptr1, 0, 1);
+	if (!p1)
+		return 1;
+	p2 = bpf_dynptr_data(&ptr2, 0, 1);
+	if (!p2)
+		return 1;
+
+	*(__u8 *)&ptr1 = 0;
+	return *p2;
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

