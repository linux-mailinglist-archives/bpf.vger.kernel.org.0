Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6575350D563
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 23:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbiDXVwg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 17:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiDXVwY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 17:52:24 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8FF644DF
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id p8so13143191pfh.8
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AW8qQ5PmDwY2Cnqe8xprQm8XrtP1JGS8SfFeinLbgIw=;
        b=UqBwpV460WhpRflX7d1/wlZTHnlTMYPcXgbBg9w4jsYTYOP5ZVrNXjwUtJvnKO2N0j
         xzfiWaueMTYB0LIKkxIvaua/u684iih+Cfigq0lveE4zU9HuO1IQ2gGzEzhkjI+sHTCN
         cPn4EuliW5QCeTG2bKRVtdhgyUpmFmfxI/cN28UBw6gWd7MjpguN21cnJm2+4jvIU/t9
         9AOVJ5LIAs7TZeVYA4hB6tgFRiBzfOfkJCGQj2pm02ka4kfnkFJSUX8l2dLse5XHgMWV
         ds4oCUNiCnpvSQWHHy8Y62m0/UpNDU+E0/Dhrj4v11G7YDtoLzdkFa5Dw0KXKMaid0GO
         WSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AW8qQ5PmDwY2Cnqe8xprQm8XrtP1JGS8SfFeinLbgIw=;
        b=KCHTkDfWN3unmTqJMQPQ52WT1uWibPjFPLrLHUxABFHQ7wkm9JCsRGzfl7cAW9pg6D
         Zi9Ftnfr/g5UV3Q71+ToYUx1jNapKvc3P6cP+PzOw491kG8iAb/grtbefmURAS7tZ87R
         vJItGqZooCtCuLA3keSv9lj3ela4oX9qMh1gN/ElYKCS2pZb8aGMpLiecWHdu50zYImY
         nojbTaDZT6YaYMdpAGufyJoSVSXPt3SZ2+/GDX7y0Y52Q/DqK5AgBbLqc7K6Kd4ci2CN
         0lqMIMA/A2f/4Pt4Ms3UcVaSqOq5rMeTqLQg3n4Mn+4YiMMt25OQHMVj8r0GSNSWH8V9
         bzoA==
X-Gm-Message-State: AOAM53384MQL5rGHd+EDooxZduAGGerpMug4vstcWYjeq+qmTNm54hxv
        qwldXBFz51afpXUZ4yeGs0H1c2Y/yBw=
X-Google-Smtp-Source: ABdhPJx5z0DdXNXllC7srWknzDD/CZd+8JksDyP2VnWLLkUqWZl0JsdDf5fEA/ElhffDom2hL2liNA==
X-Received: by 2002:a05:6a00:9a2:b0:505:974f:9fd6 with SMTP id u34-20020a056a0009a200b00505974f9fd6mr15952280pfg.12.1650836961646;
        Sun, 24 Apr 2022 14:49:21 -0700 (PDT)
Received: from localhost ([157.49.66.127])
        by smtp.gmail.com with ESMTPSA id u12-20020a62d44c000000b0050d17e069f2sm6031242pfl.10.2022.04.24.14.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:49:21 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v6 10/13] libbpf: Add kptr type tag macros to bpf_helpers.h
Date:   Mon, 25 Apr 2022 03:18:58 +0530
Message-Id: <20220424214901.2743946-11-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424214901.2743946-1-memxor@gmail.com>
References: <20220424214901.2743946-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; h=from:subject; bh=KCXkmiTevcoAjIDkLo9QVhXFN4e6q8cN7S5Kp7T266o=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiZcTLdg7RNyvmlLAE+WBaKwVdvcGY28tbYDqgmHXT 8qtl2pSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYmXEywAKCRBM4MiGSL8RyredD/ 46t3wJZ9PCbyI6+H20Gpdewgbh46rybydhOUUenK4Bhl4w6PpDGM4R4uF16fF+uQIeQ63/Mar6cx+5 YVKQoXET6zd7o7qe7ioTIoD94wFYyMINU3qgoA5A00n5WED9TSXWIWJ0EaJbaOssKt0WlHKiHEDYWG KOuvEKG1ISrKoni6B3hVr4LeMyZ1krXThkCVNO2xW+qVlustXAwYdmcEPcazWDbM8IV/SF3QM9Yze2 G/nu/LUiV1ygxIxZ5WhLxIuK8uWztFV5FmmcI1dDhp+8NbcF7ooqnEDSMVre7vWI8uZGa3ArYIRtTK rbdX6Mtq5FnVmhgZQkftkK0LwapHcByXKLJrrkIjEljI0haiWn9g4GBi44ii7OIFiSzB1jdJHDpRAP 2ThFjQkhFHPr9+u0EQDBNdhGjRPDS3Md5eKdzjM80RfG8+OylB/IlpPUin+ib4xopSQTHJE5ggGZqo eZr2zJZYE4rDwKuNS8XUpcOaRaBOACxpdsHgWXqGqme3jjj3yXPhYaDWRTZ/nuX0/p2DmcylPiBnFh HEothnIb1Q6eWM3Z09ToKlGVXfv5HUn8roEE9ayDO2olYbottCT/gFqEPQAxhWCTgsLTKvqNXQ/GCP WBRzR2iAyn3KfJ6SZ5HlmwF4PXRlXnAnBSpruxYXt3sh763Qfkqal3oAXorQ==
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

Include convenience definitions:
__kptr:	Unreferenced kptr
__kptr_ref: Referenced kptr

Users can use them to tag the pointer type meant to be used with the new
support directly in the map value definition.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 44df982d2a5c..5de3eb267125 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -149,6 +149,13 @@ enum libbpf_tristate {
 
 #define __kconfig __attribute__((section(".kconfig")))
 #define __ksym __attribute__((section(".ksyms")))
+#if __has_attribute(btf_type_tag)
+#define __kptr __attribute__((btf_type_tag("kptr")))
+#define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
+#else
+#define __kptr
+#define __kptr_ref
+#endif
 
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
-- 
2.35.1

