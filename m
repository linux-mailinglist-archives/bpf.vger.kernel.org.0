Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E09567625E
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 01:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjAUAZ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 19:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjAUAZE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 19:25:04 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E67ECD235
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:33 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id jl3so6702078plb.8
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/QcajSZvIJYuBCKx7NlqHTz3x2/XOIswd7jGPSiPBU=;
        b=K87LMr+U7UzSEEs9lXC4BGm5uAvMQyNz7PR0lWWb957dCJ4r/ncKUWAMTLcApdMQP5
         S20qA8lJdIw+C+GZ7ro8cCGHSj8rDiYWrJiXflBVCN+ogVTmzWtC8Ywzf6LuzDsxSP/I
         gX6rYYYcAbwg0O5R1MM1/1tJASV1s/rYMiYAducO3q00hhLR0PLcvojvnWg+odPEPCr9
         BOiYH/mNpSfAUFK9bDNKppI5b0IiZh9cnjEKin92ck5EGjZYBB3ijiEgCRQwveWDPKXt
         MC9SufyGOCMPth3YqRm9mkbh25ICPQFSBzSS8azNw/fgSiulsqHoBaKu8XtTfxkcVK2n
         Bkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/QcajSZvIJYuBCKx7NlqHTz3x2/XOIswd7jGPSiPBU=;
        b=GSvbBq3Ld61urqrH064FV2eXNnWwGL07WdGxPJw9sPhhpixt4R0+VY0inY6wiEuLLA
         b4osXUySRKJIneHKxUs9htQOvp/v5VeWQkm3sYTltnpoGM5YzlhHs+e/D8JKTClCJrdM
         rDR4olCppCwiuk98H7vhG4zvPltbq5whaQAx+LN/duGHYdkx9cjCAxToPsxIk6s9KE+I
         ZSQwFqqfoQuWypiPmjIljJSnIVzaVnk6nqBo5EKTbUY+Y1fAvF9Pe349pZ427Q0Tt871
         zH8RVEgIt2jQPIXf0FWK90japVFO5MPGbq4c6zBj6dABqTyIcAEC0GGJR52rAc8qPxp+
         BTEQ==
X-Gm-Message-State: AFqh2kp3npw7ctrSOW8eMZ/fqHq9O+FnEXyrbWnXZBoBRAWf8ZQwGS9E
        5Orc3WEsSPHahNOKII2AJGJ1pfsS0Js=
X-Google-Smtp-Source: AMrXdXsC34qBYiFAPeAv5NOno/ub8nq9KPSPGRXiEssLhjMxrcTwAuW4dt/KFDrw/XOSVT301MozlQ==
X-Received: by 2002:a17:902:da90:b0:194:43e2:dcd9 with SMTP id j16-20020a170902da9000b0019443e2dcd9mr23571832plx.2.1674260606904;
        Fri, 20 Jan 2023 16:23:26 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b0019498ee6d95sm9794162plh.105.2023.01.20.16.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:23:26 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 12/12] selftests/bpf: Add dynptr helper tests
Date:   Sat, 21 Jan 2023 05:52:41 +0530
Message-Id: <20230121002241.2113993-13-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121002241.2113993-1-memxor@gmail.com>
References: <20230121002241.2113993-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5259; i=memxor@gmail.com; h=from:subject; bh=EV/cG3Jk6SIyLbDKkxNscw4kpd97ighWn+qGJu9gvyU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyzAkcO3eN6JFdHCSIrXoiC4lRrWALMKyYcONMI7L g7D4V9CJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8swJAAKCRBM4MiGSL8Ryv4UD/ 9OecdfuDoCldTedsqGtf2CfdhX3wNiQDM6tYM7Pj/M3yRFy9fhb2j/fDMGNOtpx67jK+u+qY3o9aQO us/UaHiY8Hk1JeGRSozzmU9sjJPVUvQPMSKhAT6qkFJvaIqSu9U0orKPbJ8/1K194+V1vZZCEOJe50 fcCtYG/lfNJtqPqPKaFwKjdYqGt0gEBKiiT4a0+q3JJV07d3rAON5n3v8ruaUvybLiEMx7Kb8ZaFwn I1u4rQUIM4zxf+WFYsl7CW6d0RQ7qNblcpFcS8pJx1ohXldT74//RucYj5BjgOAauyoJcFNMVsQPIX bBdjZmejCDzPgDm03V2AcfvxPDGD9x9V3e2+AK9SjgKBs4ztl1hRBmXx7CcafkTHF4xa+CGxGL13gg k2SG9lE/wNacXabERJK5ETyjX5frXCrO/YX9KutXAInG86aZJ4xijxJuE/q/YBKMI5hVaARm3Bi6xn 1McHDOaE33yyjikZ0kg3X0UKVXwnGJxSou8gNomYNgfoY4zptNWva5o+j3LfLd2M6fEVA8/+9ofE87 nMk9ixuxegfE2+ehi/BlDJp4V0LmswLWN+tMZQXtZyCEGtI9gwZ0g2sDcIFkwJBrxBkhQoZWu9EZx+ cqYjkVLl8eb2I3o+B3Ah9lD8D5bBxN1+zindQ3TqW5Fb35oUr1t0uSYvwKww==
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

Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 192 ++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 1cbec5468879..5950ad6ec2e6 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -900,3 +900,195 @@ int dynptr_partial_slot_invalidate(struct __sk_buff *ctx)
 	);
 	return 0;
 }
+
+/* Test that it is allowed to overwrite unreferenced dynptr. */
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
+/* Test that slices are invalidated on reinitializing a dynptr. */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int dynptr_invalidate_slice_reinit(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u8 *p;
+
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+	p = bpf_dynptr_data(&ptr, 0, 1);
+	if (!p)
+		return 0;
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+	/* this should fail */
+	return *p;
+}
+
+/* Invalidation of dynptr slices on destruction of dynptr should not miss
+ * mem_or_null pointers.
+ */
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
+	/* this should fail */
+	bpf_this_cpu_ptr(p);
+	return 0;
+}
+
+/* Destruction of dynptr should also any slices obtained from it */
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
+	/* this should fail */
+	return *p1;
+}
+
+/* Invalidation of slices should be scoped and should not prevent dereferencing
+ * slices of another dynptr after destroying unrelated dynptr
+ */
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
+/* Overwriting referenced dynptr should be rejected */
+SEC("?raw_tp")
+__failure __msg("cannot overwrite referenced dynptr")
+int dynptr_overwrite_ref(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
+	/* this should fail */
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
+
+static int callback(__u32 index, void *data)
+{
+        *(__u32 *)data = 123;
+
+        return 0;
+}
+
+/* If the dynptr is written into in a callback function, its data
+ * slices should be invalidated as well.
+ */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int invalid_data_slices(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u32 *slice;
+
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+
+	slice = bpf_dynptr_data(&ptr, 0, sizeof(__u32));
+	if (!slice)
+		return 0;
+
+	bpf_loop(10, callback, &ptr, 0);
+
+	/* this should fail */
+	*slice = 1;
+
+	return 0;
+}
-- 
2.39.1

