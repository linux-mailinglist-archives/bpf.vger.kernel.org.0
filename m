Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE1C5F1044
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiI3QuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 12:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiI3QuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 12:50:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4259825298
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 09:50:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id rk17so10245215ejb.1
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=c6B1yIEwQpU4XABo1/44xbyjYSQ2Y4sphSXj6qcLO+A=;
        b=fHy10lxpcPTlnJF32y25DvbMHN4xnvMG/jDTaHEoaZ8I5uMpCAB9Bni/mvc+MJ8uuO
         ux975TY6frAdSOxBg5xc+OIoy8oJQFqcvUO7Oe5lJ/a7TIWbgOA/H5cbubQluJ0I3cFg
         Uej9UUJsEnd415gvSD5vHH2hA1/GRa079YXqaeyIZAfPLKf1yZI89WczwR6LPwcsg4EF
         Mp9zkhqyrcuu7977JjudEuVVSWNWNshit0D13xmyW7TmFNCk6fMPdvEXGGd/Z8lad0Ed
         pRYY2eNPKI8NPcHSgrNoMqMnHOBTfYJZ9dK2RPc0SUldjVS+LtM/gJJXF7+jlhTjtrYT
         z7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=c6B1yIEwQpU4XABo1/44xbyjYSQ2Y4sphSXj6qcLO+A=;
        b=SJOD6YJfJnt8arVwcRFscuoXkBqrmL+hoZAloPPCyw2nHy49od5JALXeraxNST+tr8
         eBt0Z3XYRmxEG6S+/S14YvUUHsmWfUt9pZtbR1uJXn11dAoYscsFBn287Ud4uc7NV+fO
         4/qk/rwKdSjmSc1KRvgKGipZNwmatujQ4C2jvSaEKwtLJrZvMhHJaf8aBbCqKUAi9hXq
         pk2vyCcQNMnuA8VQJLkvjWVf9G5V8opvooffSOCjyCD2ViSX4+qKdcCuM20so8bM1gLV
         JRYNs4ihWlq5qivtAintCazuMzj2BQ/aaSZSXHVQX37HUJNvouf6RVeStyuiXx2Jg0jZ
         vO+w==
X-Gm-Message-State: ACrzQf1+bLYkNSb3e6t/NVqTQNs4f4m7M7wB5TiKxzj2FjNv4ZbhBRhQ
        9FkiyT0LqsbGMKt420NvuLJaWSLFp4TXbw==
X-Google-Smtp-Source: AMsMyM7T9ZArljxNKsAfUBBQ0FzxBp2UavFWi6eYhdkt345iMhyoNpfrNp+aL2CV4SJLjNmqMJ5RVw==
X-Received: by 2002:a17:907:2721:b0:77f:d471:47b3 with SMTP id d1-20020a170907272100b0077fd47147b3mr7091575ejl.591.1664556618465;
        Fri, 30 Sep 2022 09:50:18 -0700 (PDT)
Received: from badger.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906304700b0073d9630cbafsm1395021ejd.126.2022.09.30.09.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:50:17 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: verify newline for struct with padding only fields
Date:   Fri, 30 Sep 2022 19:49:18 +0300
Message-Id: <20220930164918.342310-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930164918.342310-1-eddyz87@gmail.com>
References: <20220930164918.342310-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Verify that `bpftool btf dump file ... format c` correctly prints
newlines for structures that consist of anonymous-only padding fields.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/btf_dump_test_case_padding.c       | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
index f2661c8d2d90..08e43ee38188 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
@@ -102,12 +102,28 @@ struct zone {
 	struct zone_padding __pad__;
 };
 
+/* ----- START-EXPECTED-OUTPUT ----- */
+/*
+ *struct padding_wo_named_members {
+ *	long: 64;
+ *	long: 64;
+ *};
+ *
+ */
+/* ------ END-EXPECTED-OUTPUT ------ */
+
+struct padding_wo_named_members {
+	long: 64;
+	long: 64;
+} __attribute__((aligned(8)));
+
 int f(struct {
 	struct padded_implicitly _1;
 	struct padded_explicitly _2;
 	struct padded_a_lot _3;
 	struct padded_cache_line _4;
 	struct zone _5;
+	struct padding_wo_named_members _6;
 } *_)
 {
 	return 0;
-- 
2.37.3

