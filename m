Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5029259F2BB
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 06:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiHXEle (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 00:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbiHXEld (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 00:41:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF04A8D3E4
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 21:41:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bq11so12712118wrb.12
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 21:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MkzqQL0WPvxh3UGJC6duQh0T4DlbEBaV/R9lCTytzv4=;
        b=KSHEyUs63M9L6Nukzf+V6xuzqazkFFrrs0s0RFwjB1dnEeSEeFPVrKUzx4kEosTBRi
         kAXuzExELL5oP8MceFFEhB8YrDqBiJ6OYCp1HjkyQ+QKBUCBQKb49p/d3Q3xP3Y+DwlE
         sUTwkiaT0Cpy8GtdF3qCKia+caEQrGhAmGe2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MkzqQL0WPvxh3UGJC6duQh0T4DlbEBaV/R9lCTytzv4=;
        b=Ccww+dlBv/01BSIcOPclbBBkwHeDXf2MJowKEe8/ijBqDsLuboE8CDwDogySxtmrrU
         wYaJBXU26GnudbuAbHToS4sknOHM9SbXtq3sRPzNcy/aZVZ0UsBY6FB+jKoqCkhR+aA8
         XC+ApU8QQSE5lr+l8SMS48Q4XSupKhA7+LjBhxdfGoHuQ6xzwPf0EwhZCWQMYt9j57uq
         G+jSzj7Oh73EDMV3zvJfvjRY4jZhuhi3dfFaGUs3kKJHiVz+634i52TNj1szOiFvk8DM
         NKEK1G1ZIMOSlqd8VuXstY7yv95THgmIMxTJCehvVx18hI0YRJH2JdudMH3YhVsFv61w
         Ml+Q==
X-Gm-Message-State: ACgBeo2rVKJwnbbhVMPxLQCHbeMRHii9E8HFAHAC8SAzMHYi7WsiuMJV
        xJChA8Scn90JLxkvaWDBNK0DfphC5Izxw3Df/SdbSsqbmMRQAND0pMrZXFZGSi7bgq9DnbL1ix1
        xxGvdUOCJulIK95yrfA9+7Nq2jMUajqVh+n+klZ/HCN0unrTJ1bpWOCogazs8iqDqckKC2f6X
X-Google-Smtp-Source: AA6agR5EJ58ZII4qZc3n3gksD5kC4MjtwZ/bAgB6QUmDW/PNhJx59qTJ4DVb5FtwlIlxbkRwMS09wg==
X-Received: by 2002:a05:6000:1541:b0:222:cf65:18d7 with SMTP id 1-20020a056000154100b00222cf6518d7mr14663044wry.659.1661316088951;
        Tue, 23 Aug 2022 21:41:28 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe0c9000000b00225206dd595sm15572735wri.86.2022.08.23.21.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 21:41:28 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v5 bpf-next 1/4] bpf: Add 'bpf_dynptr_get_data' helper
Date:   Wed, 24 Aug 2022 07:41:14 +0300
Message-Id: <20220824044117.137658-2-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824044117.137658-1-shmulik.ladkani@gmail.com>
References: <20220824044117.137658-1-shmulik.ladkani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The task of calculating bpf_dynptr_kern's available size, and the
current (offset) data pointer is common for BPF functions working with
ARG_PTR_TO_DYNPTR parameters.

Introduce 'bpf_dynptr_get_data' which returns the current data
(with properer offset), and the number of usable bytes it has.

This will void callers from directly calculating bpf_dynptr_kern's
data, offset and size.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
v5:
- fix bpf_dynptr_get_data's incorrect usage of bpf_dynptr_kern's size
  spotted by Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h  | 1 +
 kernel/bpf/helpers.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 99fc7a64564f..d84d37bda87f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2577,6 +2577,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 int bpf_dynptr_check_size(u32 size);
+void *bpf_dynptr_get_data(struct bpf_dynptr_kern *ptr, u32 *avail_bytes);
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fc08035f14ed..96ff93941cae 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1427,6 +1427,14 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 	bpf_dynptr_set_type(ptr, type);
 }
 
+void *bpf_dynptr_get_data(struct bpf_dynptr_kern *ptr, u32 *avail_bytes)
+{
+	if (!ptr->data)
+		return NULL;
+	*avail_bytes = bpf_dynptr_get_size(ptr);
+	return ptr->data + ptr->offset;
+}
+
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 {
 	memset(ptr, 0, sizeof(*ptr));
-- 
2.37.2

