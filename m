Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B05F602DBE
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 16:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiJROA1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 10:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiJROAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 10:00:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1268A1F0
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 07:00:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so14061347pjl.3
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5hKkta8jKAlESTBm7K0poJIgy7JPyEhWZPuv6W2TV8=;
        b=MurWAKhh2HwRuHRHx/Em6wUlGCZszsZIvRkcjSu3Q2RWApzNe5IKedPthMwrf9L8vq
         l1f8u8FzF37DZCjwbYlehPXABariYTzVDhKqAjNSMCdudNkPQw2CBWvYDeZZfk8YI3L9
         e7khW4ur1+opT4ER4Tb0RDgN0rsEF+EeZA4FW2A5I7YuG43Mf3ldL7q9ZKkGxmJO9RrO
         /Jp9rTdIlL3SyM7FoFJDTHdBpJOPHcdCaKKIPqB+J1GwoNNFkSb4QH9I/GTvF9F57WVY
         2UXKj/rTzhC6Emv644V/tdZpHTFYyyFM7Zd6SqwSs3UGFvGEOWNYrGV3XS60hQpG1Pqu
         AQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5hKkta8jKAlESTBm7K0poJIgy7JPyEhWZPuv6W2TV8=;
        b=KHJuBkSZ3CRlhJtZJZtNFtXKfi+/dr3k6rEMTFCsLK5gpIO+vJ2CR43yzIvoOEU7BI
         wIF0FLF+OXtnb6grIuJFiVlK6dTtRrAbJDHAgIXldmND5lSSbAz0A5Ff5Vh01Dq5ugyW
         wqyUFmdFoTs151blN0OgL2m7yBN/MbiLRGJcBY0Fgfbt0B8dFks+PQ7uQ2a7IA/SLVa2
         TJvusUS/yoE9p6wkPjciaCi3uU1zdRvnuB+oM/05so0pUlCf+Gab3mkufza94BK/o61t
         xUUomWC982dGhMaF4HyvuMLHGNmhdC28R/vAMrdCjH2yM+dzwAodEBJrd45erF4ci0zX
         ViBA==
X-Gm-Message-State: ACrzQf0tUBc42kPZoEKZkGiSIM6Di2lyBgn8o1LgAgUXBO/fgVFujPpj
        /Bh5aJtrpve39Y/2OAyj6VIYB6iTElM9AA==
X-Google-Smtp-Source: AMsMyM7tUOdAo5BDodjJRSUVGsalAuAh/zV/enKFCnRQNjR5eRGM4/ulgV1oczr8Titd3MTmLDa9aQ==
X-Received: by 2002:a17:90b:2d85:b0:20a:d20e:a5fe with SMTP id sj5-20020a17090b2d8500b0020ad20ea5femr3704508pjb.96.1666101611016;
        Tue, 18 Oct 2022 07:00:11 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903244900b001754e086eb3sm8818986pls.302.2022.10.18.07.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:00:10 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 13/13] selftests/bpf: Add dynptr helper tests
Date:   Tue, 18 Oct 2022 19:29:20 +0530
Message-Id: <20221018135920.726360-14-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
References: <20221018135920.726360-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3180; i=memxor@gmail.com; h=from:subject; bh=eMjtMuXO5rdwYTSgrRC3E52QI3/PPyZSAswoySqEGZY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEjlt03T3P4YR/mKsk4bZzlJtwLybR0v8Ar5UOw J+/BBcuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIwAKCRBM4MiGSL8Ryt93D/ 46OavxunKYHWf+txRq39+musyJGIXzYeehyvZBL4NgIGIIxx4M3/ACmT77OdQinSQtvqh1PRo+vYnc f9WGPJuuAPcXzv2ZuKSrKF4fF46AgnKX2cJgBuN2DIe4ne+4o/oEBvSJG8GVe+K7Ra8JXyTXslpPZZ JGoFnFyDwQTKSxZh306B+69xXRvrVVam2kFjCt8XOGSMwWsZzWka/1nsEJTxfqIHIT7D558TmwX4Lz 9lbLa5Basjzrl1amAcSLWSRG+bOeI9HsMLSjzj+ol5JTvPoEt8zbexH4XS6FjI8exauruKxwMZUKpC MlThyDMD6i7p1FFvw3WZKErin3cU2LGv25J4jRYx2KSpOXikbL39sWqx1ceakXgem0nXWcHsAEGkPA QxbaCo7qALDSJRwgclBENfeTm/oTgqDiLB2uqNr75G6I2/e870J/YK948R+sNLDajq+dPdS0y359sA 9G23isOJYc2ZIuzpG2hxTtuiNSmJXxNp0GGXrn6EVPZR3KOC5mfrfN7KEfdQioJ79ej/hddPdyBS/7 KlLzAp/AuJTMoxg1onkrwoW15Kn9kabGe5j5W1uspiqyxJGyf46Znz2CcFpMLB7soGzSFqiWDetwyv zkhSee4PEDCf9jss1ypCRXp+6t3Jo+8vNF1ALqunRNGvQ72GylB6qd4X9JAw==
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

Test that MEM_UNINIT doesn't allow writing dynptr stack slots. Next,
also add a test triggering the memmove case for dynptr_read and
dynptr_write.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  3 ++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 35 +++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 20 +++++++++++
 3 files changed, 58 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 947126d217bd..20910598a0a6 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -42,11 +42,14 @@ static struct {
 	{"release_twice_callback", "arg 1 is an unacquired reference"},
 	{"dynptr_from_mem_invalid_api",
 		"Unsupported reg type fp for bpf_dynptr_from_mem data"},
+	{"dynptr_read_into_slot", "potential write to dynptr at off=-16"},
+	{"uninit_write_into_slot", "potential write to dynptr at off=-16"},
 
 	/* success cases */
 	{"test_read_write", NULL},
 	{"test_data_slice", NULL},
 	{"test_ringbuf", NULL},
+	{"test_overlap", NULL},
 };
 
 static void verify_fail(const char *prog_name, const char *expected_err_msg)
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index b0f08ff024fb..43a0ed3736a9 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -622,3 +622,38 @@ int dynptr_from_mem_invalid_api(void *ctx)
 
 	return 0;
 }
+
+/* Reject writes to dynptr slot from bpf_dynptr_read */
+SEC("?raw_tp")
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
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index a3a6103c8569..401e924b15a0 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -162,3 +162,23 @@ int test_ringbuf(void *ctx)
 	bpf_ringbuf_discard_dynptr(&ptr, 0);
 	return 0;
 }
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+int test_overlap(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	void *p;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 16, 0, &ptr);
+	p = bpf_dynptr_data(&ptr, 0, 16);
+	if (!p) {
+		err = 1;
+		goto done;
+	}
+	bpf_dynptr_read(p + 1, 8, &ptr, 0, 0);
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
-- 
2.38.0

