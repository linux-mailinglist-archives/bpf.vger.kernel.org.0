Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EC5522632
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 23:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiEJVQ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 17:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiEJVQ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 17:16:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DC650B32
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:16:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p12so281389pfn.0
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xpX90vW0ie4OzvzsESGKI1NHF8NtrEf1cBYtL1UKGw=;
        b=fhaxqmRITvqWRh9bEBFjmrNLliHf5IajR2f0IB2DfAVZkNFJ8UN3o/WcVRfazv4+3b
         GNZj34xxXVUj7GK6wai9YLlx6lFOntxtOhnDt7rZ4yP9Fj+cYrFIppBVdzUgAR8UE4vn
         EDYoLjbDtkvBmSWvgzI0iSWBo6BeYXvxui5WVezFqC/Ry0WpZZkp24ZHMKyEgoV5nVws
         Y5AT+YQQZequbPLeF5/5S2JUH3CNYYXNJetd6Dwy4S+0nTV/jrSNEaWTsVZCX0ED7TWx
         eVFCK/C3YnXgniuyC2DAAou2SF1tey9sVMMmCvgi9riaixDHckdpK2wCjm2gcfArfv6k
         43Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xpX90vW0ie4OzvzsESGKI1NHF8NtrEf1cBYtL1UKGw=;
        b=ihrwA57ZE4wZp9BKP8c8BsaCIijMwLo3zwc2J7oTKVjbQwf/X+O0KpNHABwOMaMO/B
         B7PbIoENy/ePvvJcZR6LH3ngzMKo/6piNrDEsiuPUDGPdDnWC8UBGgbExOeA/2wLRx+a
         82U8bHBGvQ4ojHFCW0QaowwOgQ/0VkDj0wCw5tjjtrJEhFRAhSvBVFhcoCYt2vG2/2mV
         NOYRygSfN+fH6Q84Y9EyUCxyMPbhfR0Lode90Q1Jh2XFCxoBGri4PXQzBx7HQ1YGAkhP
         PIN7nWHKXFXS8Iu82ozKP12FH2Zef7aTYXG5eYZAbnqiX/V/73l4ZCDLrBjDcvf67DfH
         acww==
X-Gm-Message-State: AOAM531goFD/RPQ++mYDYChLSUaH25hW/aRuuHDPcu3LUox1P47erfS/
        zXIpGWhUbKCSNlmieCjZhSDHcx5iaeY=
X-Google-Smtp-Source: ABdhPJyLzG3ulmrHe2IIsGD+pzCPX9v783LX+Bo5u+PxcgQ7RuhWBhdvRwouDMgaddxLEu+hOHKkKg==
X-Received: by 2002:a63:8341:0:b0:3d8:2047:9a6e with SMTP id h62-20020a638341000000b003d820479a6emr4439488pge.88.1652217417148;
        Tue, 10 May 2022 14:16:57 -0700 (PDT)
Received: from localhost ([112.79.164.242])
        by smtp.gmail.com with ESMTPSA id 3-20020a170902c20300b0015e8d4eb2desm55187pll.296.2022.05.10.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 14:16:56 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 1/4] bpf: Fix sparse warning for bpf_kptr_xchg_proto
Date:   Wed, 11 May 2022 02:47:24 +0530
Message-Id: <20220510211727.575686-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510211727.575686-1-memxor@gmail.com>
References: <20220510211727.575686-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062; h=from:subject; bh=kq7nDmnV9XBoyaDfey7/3SnjokAn6ne091SWL0wgihM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBietZjf96DICdz7abQqS96rYi1g1qCYOZ979Gn8QJt toGv70+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYnrWYwAKCRBM4MiGSL8RyhBzEA CYRweCqCqZ6iE7hqHyEq39kAoasi8meBTQV9bwMpxzSAM7HbkbgpVcTX9eLOh1ywtePekB3BLwAF4C wqeePLxdyM1eR4jeBlMiO1jKINHxqeIAWdNKjP8QJjzO9LF5AZUBvmAe1/tOWPezj6ZwBdUKZOj9Rk jXZDDAxk8VdWyh2ecFnNiKJOC6+kejkcTwf2CS2eVYwFLACPP7dzNIGoihy815jGuDBW/Rr4xAw6l7 SpudbiPrCFNMwqPqwaZ4YbaVPxKk7LO90BuGTh/5VSJzxKnXt//xLWKBqBK5Jvznpfeks7BtWFt2x2 JVWhqFYEze7YCH4HOSdKvGY3BCv8O9txHHLjRGdHhUaommjBQHZOfCi4ds+sDm+6KrldylaNBXo3gR le0SuoRZVc3Biz7anOlonN5Bb16Ruwpf7NJVNlHAIuQjBObvS1Na6zaD4v0IVVb5nLywbsDF/XW5OD iZXRYQJ2ETB5xiw+iox6pR+h9G4ybDx+wxzL9rLdH4YFmP0OoBAM/OBKAlI1CrIDW+UDwLWo7XpMgy F+tLEY0EBDEdIjhD5lrcWjd2JYrQgRGeAf9qQjI59AD+MpmvlMxqHid5mqXo6/6rcjzVUlKWCaXYM0 GWCNDgDqj6+ea3a3O2Hw/pHas1OlQZtYaG1Awv8SPS8NkBJgAk2rrNBPhm5A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Kernel Test Robot complained about missing static storage class
annotation for bpf_kptr_xchg_proto variable.

sparse: symbol 'bpf_kptr_xchg_proto' was not declared. Should it be static?

This caused by missing extern definition in the header. Add it to
suppress the sparse warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 551b7198ae8a..d1871eacf728 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2224,6 +2224,7 @@ extern const struct bpf_func_proto bpf_find_vma_proto;
 extern const struct bpf_func_proto bpf_loop_proto;
 extern const struct bpf_func_proto bpf_strncmp_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
+extern const struct bpf_func_proto bpf_kptr_xchg_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
-- 
2.35.1

