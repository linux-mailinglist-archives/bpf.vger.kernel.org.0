Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2A160D715
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 00:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJYW2q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 18:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiJYW2m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 18:28:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD2D13D2F
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so12984148ejc.4
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJajvPe9ilG6Fw3YANChPsLWSoYVpkS46sMZxS+1HnE=;
        b=H/gvAtjVJLzu7N39rVafy1BNAdS++1RF2K8/pZVv0B+Z0ayakGtJ/m+NeH+AyIc8IH
         RAbex5oJwvRD33v9in6N3MwjPMQd/2tJAtC87PVOLkkwGETibdbTIgH90621gy8kD6AR
         90JyGifTGqTFOkcnvA3rdQY3hNUok2/O9AbwiifAhie5mrohF7jvirSucFuKwUxDdNHn
         qSkLOGzIsFBmCvfzdVVXuA+Vc+VSSt7kjjqWQO7OAfh/8VuEwBpaaTmqqJQVFKkAqhb6
         dL3uPVqnf8mFmvsM9z4kYZLQLXxtbvHi1rz8dCsaCuDFppwjC9MX+Jc9GyZgEUdhAZpF
         x89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJajvPe9ilG6Fw3YANChPsLWSoYVpkS46sMZxS+1HnE=;
        b=3iisJiX5ar7uH2P1nA+UCJmfvrWMCMdGrMZBR/9QMRAoy7Xw8cZcNMq5WIawbwryP0
         JWNb5NyK0iXZMeWTyounyGiqUu7pOI/UJhxKvIv+WGHg9HFSSnmMv7PRqij1hfdEjJ+v
         aLSAzyb0P7sJVtp8MM+kRYU9+HZoic3KDk938qBk9mABi0wzxUNUORp1xilScqSAgKAM
         EC8T+h6eM9VHn7763GEdFWlQrISc8fKNSPoSnEideKRBalyb0bz20qgHy6sARbMJirDY
         uVVT/pZZ4DJpDMFzolZveQyweqxOvjjHaOdnOZtUj/Ak8mHgh9W+TP5yx8r0aA7u2uYO
         kwGw==
X-Gm-Message-State: ACrzQf14jj7r00Ae3Bo8XC98uTXwgj+fJwaHBXtPrJxUEUzpZQXvVpr6
        Lf/v+rsLYWm6UWRhOJtOZaXLM88mjzhIisCS
X-Google-Smtp-Source: AMsMyM7qcFEMG/d9RmxhGsKDBCZX8Iw/S8FWZMrmKA5VIBKzBJsRb2oJAm4nGUH5Q2uWtONXL0tMIw==
X-Received: by 2002:a17:906:8a6c:b0:7a8:2f09:d88d with SMTP id hy12-20020a1709068a6c00b007a82f09d88dmr11051426ejc.49.1666736920419;
        Tue, 25 Oct 2022 15:28:40 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ks23-20020a170906f85700b0078d175d6dc5sm1993119ejb.201.2022.10.25.15.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:28:40 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 02/12] selftests/bpf: Tests for standalone forward BTF declarations deduplication
Date:   Wed, 26 Oct 2022 01:27:51 +0300
Message-Id: <20221025222802.2295103-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025222802.2295103-1-eddyz87@gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
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

Tests to verify the following behavior of `btf_dedup_standalone_fwds`:
- remapping for struct forward declarations;
- remapping for union forward declarations;
- no remapping if forward declaration kind does not match similarly
  named struct or union declaration;
- no remapping if forward declaration name is ambiguous.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 152 +++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 127b8caa3dc1..f14020d51ab9 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7598,6 +7598,158 @@ static struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0e1\0e1_val"),
 	},
 },
+{
+	.descr = "dedup: standalone fwd declaration struct",
+	/*
+	 * // CU 1:
+	 * struct foo { int x; };
+	 * struct foo *a;
+	 *
+	 * // CU 2:
+	 * struct foo;
+	 * struct foo *b;
+	 */
+	.input = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_FWD_ENC(NAME_TBD, 0),                      /* [4] */
+			BTF_PTR_ENC(4),                                /* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x"),
+	},
+},
+{
+	.descr = "dedup: standalone fwd declaration union",
+	/*
+	 * // CU 1:
+	 * union foo { int x; };
+	 * union foo *another_global;
+	 *
+	 * // CU 2:
+	 * union foo;
+	 * union foo *some_global;
+	 */
+	.input = {
+		.raw_types = {
+			BTF_UNION_ENC(NAME_NTH(1), 1, 4),              /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_FWD_ENC(NAME_TBD, 1),                      /* [4] */
+			BTF_PTR_ENC(4),                                /* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_UNION_ENC(NAME_NTH(1), 1, 4),              /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x"),
+	},
+},
+{
+	.descr = "dedup: standalone fwd declaration wrong kind",
+	/*
+	 * // CU 1:
+	 * struct foo { int x; };
+	 * struct foo *b;
+	 *
+	 * // CU 2:
+	 * union foo;
+	 * union foo *a;
+	 */
+	.input = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_FWD_ENC(NAME_TBD, 1),                      /* [4] */
+			BTF_PTR_ENC(4),                                /* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_FWD_ENC(NAME_TBD, 1),                      /* [4] */
+			BTF_PTR_ENC(4),                                /* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x"),
+	},
+},
+{
+	.descr = "dedup: standalone fwd declaration name conflict",
+	/*
+	 * // CU 1:
+	 * struct foo { int x; };
+	 * struct foo *a;
+	 *
+	 * // CU 2:
+	 * struct foo;
+	 * struct foo *b;
+	 *
+	 * // CU 3:
+	 * struct foo { int x; int y; };
+	 * struct foo *c;
+	 */
+	.input = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_FWD_ENC(NAME_TBD, 0),                      /* [4] */
+			BTF_PTR_ENC(4),                                /* [5] */
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             /* [6] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_MEMBER_ENC(NAME_NTH(3), 2, 0),
+			BTF_PTR_ENC(6),                                /* [7] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x\0y"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
+			BTF_PTR_ENC(1),                                /* [3] */
+			BTF_FWD_ENC(NAME_TBD, 0),                      /* [4] */
+			BTF_PTR_ENC(4),                                /* [5] */
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             /* [6] */
+			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			BTF_MEMBER_ENC(NAME_NTH(3), 2, 0),
+			BTF_PTR_ENC(6),                                /* [7] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo\0x\0y"),
+	},
+},
 
 };
 
-- 
2.34.1

