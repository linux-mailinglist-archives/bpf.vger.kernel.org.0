Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6700C6F3B84
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 02:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjEBAwe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 20:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEBAwc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 20:52:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E9A30F6
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 17:52:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f324b3ef8so3787993276.0
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 17:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682988749; x=1685580749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rijO/xqtP62+kTHQFbkJP5lful9qOa3cZ4WzW7LFpEs=;
        b=EjKbiPmKz/D0CLJlw2T3t6DZlK1KGIuvF6NX00rIT6VVlKtCc0ynODJCR4qFM8CBpd
         Hykblxm7QyCqcgFJEFXv54jnEu+okCN5uYxLn6blk16FIBidZkK+Qtju7YgJ8by+lV2h
         3YqiggxPw/S23UQl624JELMifTQDK9dxEqoiNj1yQsc35vOW8NOkn9NL2BpCiSYX+9+B
         F2mmq2nmNIVKj1/oLAPz8KARJGM47bqMUqXg2VuNfYiIV6nH8U2ECkD9/Axv3+bpikud
         SIWtGpJRg9mWZbQm9gzDsTz25yhmgaWOInyyn/vtqhHQtqH6Hwel1at4Wy+aLHhY+o7d
         HAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682988749; x=1685580749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rijO/xqtP62+kTHQFbkJP5lful9qOa3cZ4WzW7LFpEs=;
        b=XGNA3/DZ7GHRvEor51ToHNf1Q/f/aVTsyt2rsgxDm27Cjpn7Q/IUXbc4B9boE9I94Q
         1auMEhJsC0NziI1j4rDQOaeorUp2sG2cisS0IiJxad2V0yZgT00GOEmC1lZRX+lkKs7M
         40D5gbzw2eDj1+0HI2WqTonBikXZfD1vhmMBaXghSe178cvCB2duqceg+ZqxZqWf7yb6
         JSag9O6/JklonvtlSvRfxTiYGC54HGxqtraPI52D6KfmdrwuiulGTI+N3FXfkUM3k2Bk
         /1y/pdUI/BV3YbkYz7NDDpA/NcbbMBcNAEjQzFUSTzYmHd1K0SCcFWjcYQ1KbV/fqZDh
         Wwgw==
X-Gm-Message-State: AC+VfDxfZaKSNP9MORaFR18hMZ8dhNoOrQcikuba4pbLqCxXQC6mhvMZ
        6LanT6mC1Y4/ZHY4xPhKz49zyQkB5CcVB3VNtHX8c6goF2ZI6Yj1NG7mZgOsnO3O3h+jONREr7z
        6lyR09sO0rvxMx39wc4VRG7v/+lmd1icQG0x1iacGW5vM9JuTTb1WwjZgdA==
X-Google-Smtp-Source: ACHHUZ7n5zq4WwCc7p8yjzM6u7iRD3ekgnKIsVQM/t4WotSBIWJT2O2TfGLlAeMOYhobkxdnWZJ45ShEFvQ=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:908a:598a:7b5a:d40b])
 (user=drosen job=sendgmr) by 2002:a25:4683:0:b0:b92:1f3c:a212 with SMTP id
 t125-20020a254683000000b00b921f3ca212mr9414301yba.8.1682988749577; Mon, 01
 May 2023 17:52:29 -0700 (PDT)
Date:   Mon,  1 May 2023 17:52:18 -0700
In-Reply-To: <20230502005218.3627530-1-drosen@google.com>
Mime-Version: 1.0
References: <20230502005218.3627530-1-drosen@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502005218.3627530-3-drosen@google.com>
Subject: [PATCH v2 3/3] selftests/bpf: Check overflow in optional buffer
From:   Daniel Rosenberg <drosen@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This ensures we still reject invalid memory accesses in buffers that are
marked optional.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 759eb5c245cd..ee98f7ce0b0d 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1378,3 +1378,23 @@ int invalid_slice_rdwr_rdonly(struct __sk_buff *skb)
 
 	return 0;
 }
+
+/* Buffers that are provided must be sufficiently long */
+SEC("?cgroup_skb/egress")
+__failure __msg("memory, len pair leads to invalid memory access")
+int test_dynptr_skb_small_buff(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	char buffer[8] = {};
+	__u64 *data;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* This may return NULL. SKB may require a buffer */
+	data = bpf_dynptr_slice(&ptr, 0, buffer, 9);
+
+	return !!data;
+}
-- 
2.40.1.495.gc816e09b53d-goog

