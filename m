Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768983BF199
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 23:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhGGVvz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 17:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230378AbhGGVvz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Jul 2021 17:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625694554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zbTjAalRT8G7ucBl7KamxhzUVx0mh7mTfA4EZ32X+1U=;
        b=Qyh3ogfsjzwZ9ol+utWPc0bgKEDV+JcdUEzVZYC8x6CrBvjYvbn1aFQ0OrH+mOmb68z654
        KvIH0Z9eS8zJJA8JkBHBx10Yzb//M7K9eLUiQexmhLAV7x8z0ZzdFzJL4BRlbfFuReLPef
        7xbCDkE1fuLDUlg6MpDz7febFRxU4Ks=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-5_mVwFRdMY2fezgdbSFQgA-1; Wed, 07 Jul 2021 17:49:11 -0400
X-MC-Unique: 5_mVwFRdMY2fezgdbSFQgA-1
Received: by mail-wm1-f69.google.com with SMTP id p4-20020a05600c3584b0290210725ac6bcso2687141wmq.2
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 14:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zbTjAalRT8G7ucBl7KamxhzUVx0mh7mTfA4EZ32X+1U=;
        b=mnXKSGD8o4WpDFYN5NwFhFfkgsq5MKDrk4SaJzqxtIXWIKKvLXxl1mffxoV0JcfQdI
         mMKmUa6FWRFjeNJ3IvLFV9qHSRmSPlMQZ+ZYe+QzRHar03vL/zDHnF25V5PCWuR+5e4J
         4DN0xPcZD1piiX/6OZII8nZ/ht5L35zllA3bef2eeHuan2cGqDeuXsnNGy/uX7nEPSsT
         D1AaN66tjVZbB6gg717Y+2o5YSCUZl11oYkrfysY8jJj2xmvXdmMx6WqmUmh8t+Y/edR
         VFFLG6uk5FwQnI2V3E3W0ubTdOCj9Lke+Y2SlHtbWsQPibelDjvQRUFDCV9O+GPG2ntV
         4ETg==
X-Gm-Message-State: AOAM5316v85kI56TEASchQimZ4nq62RhlQfI81CaoTVCMH6qPC3yc3/g
        MZpUXJtSKqPI8bFnzGO40YPa1M4hfJcqYHcvwyopCJTZSbAU5VMH9IBM6U5tneJVt0LxyklY4kZ
        eiEZvBvHH/EdG
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr28161396wma.80.1625694550244;
        Wed, 07 Jul 2021 14:49:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMElhZP2kH1WV42xtt2FEDaPsQDguhdbByE9+5Y4+JgnQ44u0SnjbpMEECslWGFOsiWd4PPQ==
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr28161385wma.80.1625694550135;
        Wed, 07 Jul 2021 14:49:10 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id k5sm148994wmk.11.2021.07.07.14.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 14:49:09 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv3 bpf-next 7/7] selftests/bpf: Add test for bpf_get_func_ip in kprobe+offset probe
Date:   Wed,  7 Jul 2021 23:47:51 +0200
Message-Id: <20210707214751.159713-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707214751.159713-1-jolsa@kernel.org>
References: <20210707214751.159713-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding test for bpf_get_func_ip in kprobe+ofset probe.
Because of the offset value it's arch specific, adding
it only for x86_64 architecture.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../testing/selftests/bpf/progs/get_func_ip_test.c  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 8ca54390d2b1..e8a9428a0ea3 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -10,6 +10,7 @@ extern const void bpf_fentry_test2 __ksym;
 extern const void bpf_fentry_test3 __ksym;
 extern const void bpf_fentry_test4 __ksym;
 extern const void bpf_modify_return_test __ksym;
+extern const void bpf_fentry_test6 __ksym;
 
 __u64 test1_result = 0;
 SEC("fentry/bpf_fentry_test1")
@@ -60,3 +61,15 @@ int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
 	test5_result = (const void *) addr == &bpf_modify_return_test;
 	return ret;
 }
+
+#ifdef __x86_64__
+__u64 test6_result = 0;
+SEC("kprobe/bpf_fentry_test6+0x5")
+int test6(struct pt_regs *ctx)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	test6_result = (const void *) addr == &bpf_fentry_test6 + 5;
+	return 0;
+}
+#endif
-- 
2.31.1

