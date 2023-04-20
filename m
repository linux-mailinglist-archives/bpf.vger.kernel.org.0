Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EEA6E8B3B
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 09:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjDTHPx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 03:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbjDTHPw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 03:15:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0759440CA
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:15:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2470e93ea71so459073a91.0
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681974949; x=1684566949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foBgX29KmsxdT/6n9L7AxQAtmKsqf+eCDmE/O1qqaWA=;
        b=azGvu+Mx34IDn6K0XpGnEDNq8QwF5Kbio62GiRyOsDBaSWjXB1eutZu7RzK6N8DjdX
         hJ6gS9KQwH67jhxZlDHizLG5U8rnG7ZtB2n1eDhctzpFC+w0n5TB28z09Y7gtxOFCZSS
         zM8/BmjawAD3BWe5rMCPkOGZ4e7AmnBlViPVB+NhYQXBTWeDW9wCn4DagoSNym/p8kAA
         5IIKbapW/Vcv8okUEqeQlpNbGXURKj+xmjt/ls2nMayO3QPoyw2eLvUZgH5GhDRkIPhD
         KMkZ0uWZwBUk875P0zB/R5/r5PTmKgf7Gj07uhPTjZkMfuJfva1kXygMFNe7cmGVhZvy
         XRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974949; x=1684566949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foBgX29KmsxdT/6n9L7AxQAtmKsqf+eCDmE/O1qqaWA=;
        b=VquwfCovtCtmPLNzW3czLjqlv43yeUQVxhi6iNjg5xHGa9HOaFiOi6p3bzYXdnLyKF
         TqgQjd2QP6KYOm/PdFeT5uj/Cbl2NvMDuVAUHcTalLM/G15N4KRMZFU6FxG6UzTNOpwC
         ixLGPBaynB4aNvxVELhKrpV9NmAmhe8rz/+XHAXRtbcTaBHHETZyrxlkRp5XVDBv5kHe
         O2BxunD8yy0sQrYy4ucF246jzp1yLlgbY47qjqw7znhQaLwwMX+Z+pq4YiDVLvDTKmp0
         bJNB1EjrU4PY6GUGQ7dOBruRq9NI2MbpolNqlhLP+9rpL8KFYeAFjEMfujw6sFKKGqDv
         O7Xg==
X-Gm-Message-State: AAQBX9d/RGeohHZ9thCre6nPZTLqCL3dxdorm9wz0tzYPgGIV4mRVgwE
        k75HoMEWzCvyMr4Z0LV2lFGUYggpWcHl1A==
X-Google-Smtp-Source: AKy350Y4HvSioXihaA9OiLh64uwzedSTvF1DgbhD2arNCtoTyUm25qdHdTWpyIPOScyRc0Z26sTG/Q==
X-Received: by 2002:a17:90b:1d01:b0:247:83ed:7e5d with SMTP id on1-20020a17090b1d0100b0024783ed7e5dmr798234pjb.18.1681974949282;
        Thu, 20 Apr 2023 00:15:49 -0700 (PDT)
Received: from gatsby.corp.tfbnw.net (75-172-126-232.tukw.qwest.net. [75.172.126.232])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090acb8700b00246b5a609d2sm588208pju.27.2023.04.20.00.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:15:49 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v2 bpf-next 5/5] selftests/bpf: add tests for dynptr convenience helpers
Date:   Thu, 20 Apr 2023 00:14:14 -0700
Message-Id: <20230420071414.570108-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420071414.570108-1-joannelkoong@gmail.com>
References: <20230420071414.570108-1-joannelkoong@gmail.com>
MIME-Version: 1.0
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

Add various tests for the added dynptr convenience helpers.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   6 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |   6 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 287 +++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 298 ++++++++++++++++++
 4 files changed, 597 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 8c993ec8ceea..f3c41f8902a0 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -35,4 +35,10 @@ extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, __u32 offset,
 extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *ptr, __u32 offset,
 			      void *buffer, __u32 buffer__szk) __ksym;
 
+extern int bpf_dynptr_adjust(const struct bpf_dynptr *ptr, __u32 start, __u32 end) __ksym;
+extern int bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym;
+extern int bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
+extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym;
+extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index d176c34a7d2e..0478916aff37 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -20,6 +20,12 @@ static struct {
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
+	{"test_adjust", SETUP_SYSCALL_SLEEP},
+	{"test_adjust_err", SETUP_SYSCALL_SLEEP},
+	{"test_zero_size_dynptr", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_is_null", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_is_rdonly", SETUP_SKB_PROG},
+	{"test_dynptr_clone", SETUP_SKB_PROG},
 };
 
 static void verify_success(const char *prog_name, enum test_setup_type setup_type)
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 759eb5c245cd..efe4ce72d00e 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1378,3 +1378,290 @@ int invalid_slice_rdwr_rdonly(struct __sk_buff *skb)
 
 	return 0;
 }
+
+/* bpf_dynptr_adjust can only be called on initialized dynptrs */
+SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as arg #1")
+int dynptr_adjust_invalid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_dynptr_adjust(&ptr, 1, 2);
+
+	return 0;
+}
+
+/* bpf_dynptr_is_null can only be called on initialized dynptrs */
+SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as arg #1")
+int dynptr_is_null_invalid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_dynptr_is_null(&ptr);
+
+	return 0;
+}
+
+/* bpf_dynptr_is_rdonly can only be called on initialized dynptrs */
+SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as arg #1")
+int dynptr_is_rdonly_invalid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_dynptr_is_rdonly(&ptr);
+
+	return 0;
+}
+
+/* bpf_dynptr_size can only be called on initialized dynptrs */
+SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as arg #1")
+int dynptr_size_invalid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	/* this should fail */
+	bpf_dynptr_size(&ptr);
+
+	return 0;
+}
+
+/* Only initialized dynptrs can be cloned */
+SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as arg #1")
+int clone_invalid1(void *ctx)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr ptr2;
+
+	/* this should fail */
+	bpf_dynptr_clone(&ptr1, &ptr2);
+
+	return 0;
+}
+
+/* Can't overwrite an existing dynptr when cloning */
+SEC("?xdp")
+__failure __msg("cannot overwrite referenced dynptr")
+int clone_invalid2(struct xdp_md *xdp)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr clone;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr1);
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &clone);
+
+	/* this should fail */
+	bpf_dynptr_clone(&ptr1, &clone);
+
+	bpf_ringbuf_submit_dynptr(&clone, 0);
+
+	return 0;
+}
+
+/* Invalidating a dynptr should invalidate its clones */
+SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as arg #3")
+int clone_invalidate1(void *ctx)
+{
+	struct bpf_dynptr clone;
+	struct bpf_dynptr ptr;
+	char read_data[64];
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), &clone, 0, 0);
+
+	return 0;
+}
+
+/* Invalidating a dynptr should invalidate its parent */
+SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as arg #3")
+int clone_invalidate2(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct bpf_dynptr clone;
+	char read_data[64];
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+
+	bpf_ringbuf_submit_dynptr(&clone, 0);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0, 0);
+
+	return 0;
+}
+
+/* Invalidating a dynptr should invalidate its siblings */
+SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as arg #3")
+int clone_invalidate3(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct bpf_dynptr clone1;
+	struct bpf_dynptr clone2;
+	char read_data[64];
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone1);
+
+	bpf_dynptr_clone(&ptr, &clone2);
+
+	bpf_ringbuf_submit_dynptr(&clone2, 0);
+
+	/* this should fail */
+	bpf_dynptr_read(read_data, sizeof(read_data), &clone1, 0, 0);
+
+	return 0;
+}
+
+/* Invalidating a dynptr should invalidate any data slices
+ * of its clones
+ */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int clone_invalidate4(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct bpf_dynptr clone;
+	int *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+	data = bpf_dynptr_data(&clone, 0, sizeof(val));
+	if (!data)
+		return 0;
+
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	/* this should fail */
+	*data = 123;
+
+	return 0;
+}
+
+/* Invalidating a dynptr should invalidate any data slices
+ * of its parent
+ */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int clone_invalidate5(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct bpf_dynptr clone;
+	int *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+	data = bpf_dynptr_data(&ptr, 0, sizeof(val));
+	if (!data)
+		return 0;
+
+	bpf_dynptr_clone(&ptr, &clone);
+
+	bpf_ringbuf_submit_dynptr(&clone, 0);
+
+	/* this should fail */
+	*data = 123;
+
+	return 0;
+}
+
+/* Invalidating a dynptr should invalidate any data slices
+ * of its sibling
+ */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int clone_invalidate6(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct bpf_dynptr clone1;
+	struct bpf_dynptr clone2;
+	int *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone1);
+
+	bpf_dynptr_clone(&ptr, &clone2);
+
+	data = bpf_dynptr_data(&clone1, 0, sizeof(val));
+	if (!data)
+		return 0;
+
+	bpf_ringbuf_submit_dynptr(&clone2, 0);
+
+	/* this should fail */
+	*data = 123;
+
+	return 0;
+}
+
+/* A skb clone's data slices should be invalid anytime packet data changes */
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int clone_skb_packet_data(struct __sk_buff *skb)
+{
+	char buffer[sizeof(__u32)] = {};
+	struct bpf_dynptr clone;
+	struct bpf_dynptr ptr;
+	__u32 *data;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+	data = bpf_dynptr_slice_rdwr(&clone, 0, buffer, sizeof(buffer));
+	if (!data)
+		return XDP_DROP;
+
+	if (bpf_skb_pull_data(skb, skb->len))
+		return SK_DROP;
+
+	/* this should fail */
+	*data = 123;
+
+	return 0;
+}
+
+/* A xdp clone's data slices should be invalid anytime packet data changes */
+SEC("?xdp")
+__failure __msg("invalid mem access 'scalar'")
+int clone_xdp_packet_data(struct xdp_md *xdp)
+{
+	char buffer[sizeof(__u32)] = {};
+	struct bpf_dynptr clone;
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+	__u32 *data;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &clone);
+	data = bpf_dynptr_slice_rdwr(&clone, 0, buffer, sizeof(buffer));
+	if (!data)
+		return XDP_DROP;
+
+	if (bpf_xdp_adjust_head(xdp, 0 - (int)sizeof(*hdr)))
+		return XDP_DROP;
+
+	/* this should fail */
+	*data = 123;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index b2fa6c47ecc0..be7de62de045 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -207,3 +207,301 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
 
 	return 1;
 }
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_adjust(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u32 bytes = 64;
+	__u32 off = 10;
+	__u32 trim = 15;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	err = bpf_ringbuf_reserve_dynptr(&ringbuf, bytes, 0, &ptr);
+	if (err) {
+		err = 1;
+		goto done;
+	}
+
+	if (bpf_dynptr_size(&ptr) != bytes) {
+		err = 2;
+		goto done;
+	}
+
+	/* Advance the dynptr by off */
+	err = bpf_dynptr_adjust(&ptr, off, bpf_dynptr_size(&ptr));
+	if (err) {
+		err = 3;
+		goto done;
+	}
+
+	if (bpf_dynptr_size(&ptr) != bytes - off) {
+		err = 4;
+		goto done;
+	}
+
+	/* Trim the dynptr */
+	err = bpf_dynptr_adjust(&ptr, off, 15);
+	if (err) {
+		err = 5;
+		goto done;
+	}
+
+	/* Check that the size was adjusted correctly */
+	if (bpf_dynptr_size(&ptr) != trim - off) {
+		err = 6;
+		goto done;
+	}
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_adjust_err(void *ctx)
+{
+	char write_data[45] = "hello there, world!!";
+	struct bpf_dynptr ptr;
+	__u32 size = 64;
+	__u32 off = 20;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	if (bpf_ringbuf_reserve_dynptr(&ringbuf, size, 0, &ptr)) {
+		err = 1;
+		goto done;
+	}
+
+	/* Check that start can't be greater than end */
+	if (bpf_dynptr_adjust(&ptr, 5, 1) != -EINVAL) {
+		err = 2;
+		goto done;
+	}
+
+	/* Check that start can't be greater than size */
+	if (bpf_dynptr_adjust(&ptr, size + 1, size + 1) != -ERANGE) {
+		err = 3;
+		goto done;
+	}
+
+	/* Check that end can't be greater than size */
+	if (bpf_dynptr_adjust(&ptr, 0, size + 1) != -ERANGE) {
+		err = 4;
+		goto done;
+	}
+
+	if (bpf_dynptr_adjust(&ptr, off, size)) {
+		err = 5;
+		goto done;
+	}
+
+	/* Check that you can't write more bytes than available into the dynptr
+	 * after you've adjusted it
+	 */
+	if (bpf_dynptr_write(&ptr, 0, &write_data, sizeof(write_data), 0) != -E2BIG) {
+		err = 6;
+		goto done;
+	}
+
+	/* Check that even after adjusting, submitting/discarding
+	 * a ringbuf dynptr works
+	 */
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+	return 0;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_zero_size_dynptr(void *ctx)
+{
+	char write_data = 'x', read_data;
+	struct bpf_dynptr ptr;
+	__u32 size = 64;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	if (bpf_ringbuf_reserve_dynptr(&ringbuf, size, 0, &ptr)) {
+		err = 1;
+		goto done;
+	}
+
+	/* After this, the dynptr has a size of 0 */
+	if (bpf_dynptr_adjust(&ptr, size, size)) {
+		err = 2;
+		goto done;
+	}
+
+	/* Test that reading + writing non-zero bytes is not ok */
+	if (bpf_dynptr_read(&read_data, sizeof(read_data), &ptr, 0, 0) != -E2BIG) {
+		err = 3;
+		goto done;
+	}
+
+	if (bpf_dynptr_write(&ptr, 0, &write_data, sizeof(write_data), 0) != -E2BIG) {
+		err = 4;
+		goto done;
+	}
+
+	/* Test that reading + writing 0 bytes from a 0-size dynptr is ok */
+	if (bpf_dynptr_read(&read_data, 0, &ptr, 0, 0)) {
+		err = 5;
+		goto done;
+	}
+
+	if (bpf_dynptr_write(&ptr, 0, &write_data, 0, 0)) {
+		err = 6;
+		goto done;
+	}
+
+	err = 0;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_dynptr_is_null(void *ctx)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr ptr2;
+	__u64 size = 4;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	/* Pass in invalid flags, get back an invalid dynptr */
+	if (bpf_ringbuf_reserve_dynptr(&ringbuf, size, 123, &ptr1) != -EINVAL) {
+		err = 1;
+		goto exit_early;
+	}
+
+	/* Test that the invalid dynptr is null */
+	if (!bpf_dynptr_is_null(&ptr1)) {
+		err = 2;
+		goto exit_early;
+	}
+
+	/* Get a valid dynptr */
+	if (bpf_ringbuf_reserve_dynptr(&ringbuf, size, 0, &ptr2)) {
+		err = 3;
+		goto exit;
+	}
+
+	/* Test that the valid dynptr is not null */
+	if (bpf_dynptr_is_null(&ptr2)) {
+		err = 4;
+		goto exit;
+	}
+
+exit:
+	bpf_ringbuf_discard_dynptr(&ptr2, 0);
+exit_early:
+	bpf_ringbuf_discard_dynptr(&ptr1, 0);
+	return 0;
+}
+
+SEC("cgroup_skb/egress")
+int test_dynptr_is_rdonly(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr ptr2;
+	struct bpf_dynptr ptr3;
+
+	/* Pass in invalid flags, get back an invalid dynptr */
+	if (bpf_dynptr_from_skb(skb, 123, &ptr1) != -EINVAL) {
+		err = 1;
+		return 0;
+	}
+
+	/* Test that an invalid dynptr is_rdonly returns false */
+	if (bpf_dynptr_is_rdonly(&ptr1)) {
+		err = 2;
+		return 0;
+	}
+
+	/* Get a read-only dynptr */
+	if (bpf_dynptr_from_skb(skb, 0, &ptr2)) {
+		err = 3;
+		return 0;
+	}
+
+	/* Test that the dynptr is read-only */
+	if (!bpf_dynptr_is_rdonly(&ptr2)) {
+		err = 4;
+		return 0;
+	}
+
+	/* Get a read-writeable dynptr */
+	if (bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr3)) {
+		err = 5;
+		goto done;
+	}
+
+	/* Test that the dynptr is read-only */
+	if (bpf_dynptr_is_rdonly(&ptr3)) {
+		err = 6;
+		goto done;
+	}
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr3, 0);
+	return 0;
+}
+
+SEC("cgroup_skb/egress")
+int test_dynptr_clone(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr1;
+	struct bpf_dynptr ptr2;
+	__u32 off = 2, size;
+
+	/* Get a dynptr */
+	if (bpf_dynptr_from_skb(skb, 0, &ptr1)) {
+		err = 1;
+		return 0;
+	}
+
+	if (bpf_dynptr_adjust(&ptr1, off, bpf_dynptr_size(&ptr1))) {
+		err = 2;
+		return 0;
+	}
+
+	/* Clone the dynptr */
+	if (bpf_dynptr_clone(&ptr1, &ptr2)) {
+		err = 3;
+		return 0;
+	}
+
+	size = bpf_dynptr_size(&ptr1);
+
+	/* Check that the clone has the same size and rd-only */
+	if (bpf_dynptr_size(&ptr2) != size) {
+		err = 4;
+		return 0;
+	}
+
+	if (bpf_dynptr_is_rdonly(&ptr2) != bpf_dynptr_is_rdonly(&ptr1)) {
+		err = 5;
+		return 0;
+	}
+
+	/* Advance and trim the original dynptr */
+	bpf_dynptr_adjust(&ptr1, 5, 5);
+
+	/* Check that only original dynptr was affected, and the clone wasn't */
+	if (bpf_dynptr_size(&ptr2) != size) {
+		err = 6;
+		return 0;
+	}
+
+	return 0;
+}
-- 
2.34.1

