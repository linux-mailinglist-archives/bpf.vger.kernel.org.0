Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FA959E869
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 19:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbiHWQ7y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 12:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245621AbiHWQ7Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 12:59:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C4014C7B0
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 06:30:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h1so7204811wmd.3
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 06:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=d10xVH5CYSGZmcUinThoqQj5a6dMS+wGIInd0XElJgg=;
        b=H9Gv1Y9zrJ+OUsHbNoqzeYWXNHIoXWhVc9cLX4zIpix1fnoDAojDntZUR2D5R7rAA9
         RA+T20PoJCpKJun7zQ9EFDr2aV+I1wILk/HCJtebq1+SPKrxwwVyqRH+LLlhFWDWhnrW
         OspJyfZyzptoPrvzCO98eT6tVl/V568ViK8Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=d10xVH5CYSGZmcUinThoqQj5a6dMS+wGIInd0XElJgg=;
        b=K88RKVCe6N3W+aUi32q27bNrW6GeVgkePiqRfD/U7tpqjIzoIDvMBJPexLNP9PodUL
         vT/7f1mv+TyeigSWiBHlMezdCD1dEN1s4i6K449YSWVm9cKFkczIaPgDzLvE60JEEFbU
         sn+4aKv8Zu0Hvf/54Tb44iJ5KqJ77Utnw8ofphrmXVh/zarEvPIa926VxKrzx0T3WRXo
         /lI1bzm05Ir3w46s1gESW2of7eSJEd6/ZyqRxFpg30sy6QNFD4gnBo4GIQTNRCzukd6N
         2GQTGWOX+s72eU2kiYWZwOXrF0waSF/E7PIWFZckJjWMcUw6cyZR/1iIH18QtU/Sqoh6
         6DGA==
X-Gm-Message-State: ACgBeo02jf0oGTEW2FiM9tI6ha3kiWp0R3woKgJXzoN9kg2/M91eHAZ0
        MPKF5rCpf+dI7bvvEUkPeJSchRcvXpu9zU3jFmO1ZMlRBfhiUYKKvd7VGU/CTMV8kehEGPzSTcV
        8z2tnUF+T4J1bUOjPLuy+xH2KHkZizgZQfLuv7S6R2if2Z2UG9RSSulIuvBAVK7KoA25Uy6TN
X-Google-Smtp-Source: AA6agR4++H5YfkvRD/3duJmKaMt8SnV8/drJ0qScYueZ09Rh9JJOJe2404fhDB1bDdR4MnGDhSeFfA==
X-Received: by 2002:a05:600c:3b92:b0:3a6:5645:5fc7 with SMTP id n18-20020a05600c3b9200b003a656455fc7mr2211847wms.148.1661261435302;
        Tue, 23 Aug 2022 06:30:35 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003a4efb794d7sm19264891wmq.36.2022.08.23.06.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:30:34 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v4 bpf-next 1/4] bpf: Add 'bpf_dynptr_get_data' helper
Date:   Tue, 23 Aug 2022 16:30:17 +0300
Message-Id: <20220823133020.73872-2-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823133020.73872-1-shmulik.ladkani@gmail.com>
References: <20220823133020.73872-1-shmulik.ladkani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 include/linux/bpf.h  |  1 +
 kernel/bpf/helpers.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 39bd36359c1e..6d288dfc302b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2576,6 +2576,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 int bpf_dynptr_check_size(u32 size);
+void *bpf_dynptr_get_data(struct bpf_dynptr_kern *ptr, u32 *avail_bytes);
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3c1b9bbcf971..91f406a9c37f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1461,6 +1461,16 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 	bpf_dynptr_set_type(ptr, type);
 }
 
+void *bpf_dynptr_get_data(struct bpf_dynptr_kern *ptr, u32 *avail_bytes)
+{
+	u32 size = bpf_dynptr_get_size(ptr);
+
+	if (!ptr->data || ptr->offset > size)
+		return NULL;
+	*avail_bytes = size - ptr->offset;
+	return ptr->data + ptr->offset;
+}
+
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 {
 	memset(ptr, 0, sizeof(*ptr));
-- 
2.37.2

