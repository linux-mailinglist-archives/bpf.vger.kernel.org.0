Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF3365781
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 13:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhDTLYK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Apr 2021 07:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhDTLYH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Apr 2021 07:24:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00FCC06174A
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 04:23:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n10-20020a05600c4f8ab0290130f0d3cba3so917253wmq.1
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6vFcLQC9p9nN/hpsSg6W2eBmrNCnz7mFXHTxsgTtyxM=;
        b=iBJWfIz/C0KYJJS5Mv5clqW5ZmAMP2VXfa4gf7Et0A3y19++wOW7RX6AS9aabqyt0E
         upyOcidkhk0EMzxEeCMk3JZVk9erOC+2s7WCU9y4TpUACLgYwJMCG18xUbtMvk1Cb83u
         hdEHJE/QiVYhyNaQ7Eu9K+h8+yj+F42+O9Z0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6vFcLQC9p9nN/hpsSg6W2eBmrNCnz7mFXHTxsgTtyxM=;
        b=kmIDfFRr3DVSJOgfh8zUG9/zygU8daHxwvNpIvwDy3PpToSXYEo/oYP+HfikyYTKLK
         O5JBXoHFKqvT07fljQn6CQarkY0Zy+Jb+kOy4UVV8M6mXJ3AGdMJAXKkXxPEEey1GQRE
         taah/63lyuU9CI2egF9vU94Cu5rXD16OIe6qn5bl/gzUTptjHeU51xSHLeTt5AH0A4Nb
         5e6QrtmrXTNHZisuFeynuRvtPJMws//yyl2GeY8WvLEJyUEKNsV1vP3iaZvw+dqSxdEG
         sxf18f0quFX0xv+RpSqPd1B4DYGln52E4kq9G739MOpVHP/mUg2qoTL3v3i3cRMe6Z/3
         ADpQ==
X-Gm-Message-State: AOAM533iKyAs9w68g+MoYcM9agMq9+UdR7NwzBiIS5NoqccegFJbUDIH
        sq9Hid5gMEFTn6/sYQxNs4X7yIMrsj5ouQ==
X-Google-Smtp-Source: ABdhPJzh5/ifrt1Reoll0p0dNZonsQNQj7VRdQdq6LQHhWMn736yN6Rlqdh64iaSVzTAuC2sU04HpA==
X-Received: by 2002:a1c:2c0a:: with SMTP id s10mr3886245wms.158.1618917814604;
        Tue, 20 Apr 2021 04:23:34 -0700 (PDT)
Received: from localhost.localdomain (8.6.1.2.2.7.f.2.3.4.9.1.8.9.b.e.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:eb98:1943:2f72:2168])
        by smtp.gmail.com with ESMTPSA id l5sm2946450wmh.0.2021.04.20.04.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 04:23:34 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Some CO-RE negative testcases are buggy
Date:   Tue, 20 Apr 2021 12:16:40 +0100
Message-Id: <20210420111639.155580-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

I was looking at some CORE testcases, and noticed two problems:

* The checks for negative test cases use an incorrect CHECK(false) 
  invocation. This means negative test cases don't fail when they
  should.
* Some existence tests use incorrect file names, but the test harness
  is unable to detect this. Basically, failure to load due to a failed
  CORE relocation is not distinguished from ENOENT. I found the CHECK
  issue when investigating this problem.

I've written the patch attached below, but there are now 12 failures.
I don't understand the tests well enough to fix them, maybe you can
take a look?

Best
Lorenz

---
 .../selftests/bpf/prog_tests/core_reloc.c        | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index d94dcead72e6..bd759290347c 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -644,12 +644,12 @@ static struct core_reloc_test_case test_cases[] = {
 		.output_len = sizeof(struct core_reloc_existence_output),
 	},
 
-	FIELD_EXISTS_ERR_CASE(existence__err_int_sz),
-	FIELD_EXISTS_ERR_CASE(existence__err_int_type),
-	FIELD_EXISTS_ERR_CASE(existence__err_int_kind),
-	FIELD_EXISTS_ERR_CASE(existence__err_arr_kind),
-	FIELD_EXISTS_ERR_CASE(existence__err_arr_value_type),
-	FIELD_EXISTS_ERR_CASE(existence__err_struct_type),
+	FIELD_EXISTS_ERR_CASE(existence___err_wrong_int_sz),
+	FIELD_EXISTS_ERR_CASE(existence___err_wrong_int_type),
+	FIELD_EXISTS_ERR_CASE(existence___err_wrong_int_kind),
+	FIELD_EXISTS_ERR_CASE(existence___err_wrong_arr_kind),
+	FIELD_EXISTS_ERR_CASE(existence___err_wrong_arr_value_type),
+	FIELD_EXISTS_ERR_CASE(existence___err_wrong_struct_type),
 
 	/* bitfield relocation checks */
 	BITFIELDS_CASE(bitfields, {
@@ -864,7 +864,7 @@ void test_core_reloc(void)
 		err = bpf_object__load_xattr(&load_attr);
 		if (err) {
 			if (!test_case->fails)
-				CHECK(false, "obj_load", "failed to load prog '%s': %d\n", probe_name, err);
+				CHECK(true, "obj_load", "failed to load prog '%s': %d\n", probe_name, err);
 			goto cleanup;
 		}
 
@@ -904,7 +904,7 @@ void test_core_reloc(void)
 		}
 
 		if (test_case->fails) {
-			CHECK(false, "obj_load_fail", "should fail to load prog '%s'\n", probe_name);
+			CHECK(true, "obj_load_fail", "should fail to load prog '%s'\n", probe_name);
 			goto cleanup;
 		}
 
-- 
2.27.0

