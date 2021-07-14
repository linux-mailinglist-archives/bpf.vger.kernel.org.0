Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2ABB3C85DD
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbhGNOSp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 10:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbhGNOSn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 10:18:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC7CC061760
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 07:15:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so1540536wmc.2
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9g7oMOBxjsI3jeOuNMCaoSoX+v79UXg5NQkt+WfPeBE=;
        b=RagfVc4cz29UZtABpYH5XLJymWhhFKFHhqsVMwsa2WXAEEqlPxcHS5blXMdL6LDS5b
         8nZdggt4SnZpunNI1bZuC60yUdnC3P5RLkJyQNsM4M2GUV+M5U/INEcrwqDoQiz2FcbS
         x30VEzbUM8rtM5Kv38UWd7fDtTJFpwBYCfNgGg+Fw5ZvMxRTLsEFEKsWB85hyFnVDbKk
         ZpHGG+d+5O+cyv3hP25JY9k3Frr3PXRtaJ5DKbAuSwEoqG90DBVwABiC2oMJGymAxD/y
         SOsALrHwSUy0RJeJYLfwu6Hr/d22VggS+umUsflKLWMAVKsOrPlummumP3iK10FQTkSv
         pKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9g7oMOBxjsI3jeOuNMCaoSoX+v79UXg5NQkt+WfPeBE=;
        b=giatmN6uQFSKfJ097pKm/4asNYmusBx/zPOxq106UchbTOsUAqEXfs21t07apMGoqP
         1swq4uoGc+iCtPtYtwbEyGVocNtylQiw9UTSSiwSb1IS+EnqO/1B318ca2TtnjhUFO2+
         PJ+wByy0HxAunMz1ukJQA0n2hw/5LKso06ms+hO1uvCO6VzrLVJDSIUIj8CiBqScovfb
         oJr3uBXaD91cKgynsrBu25bXFBhoEQ17nY3AjeeDeP2NSZ7msP4Wy+h8IVoAqd6EpnVX
         zzFoFWq1bF1J+GuQ0/KxfifEEjP0vSKe39i7lCr578oDxKw86ypOz4qD2P5z91lkQZuT
         ZGKQ==
X-Gm-Message-State: AOAM532YmSiDcEckIt+SuIHeah8imDyyYphwaR1MUqgarAQ/qLQUjSex
        HRJ2zPeXCJxbRpTYG8Z2PE1Uww==
X-Google-Smtp-Source: ABdhPJzoi3IW041Df/KOPi4/TALvaa/DA0LmFOtk5iOIqGcHvlAq5ZFzZEJAE1hoYUfQFMLyN2jO4Q==
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr11457397wme.101.1626272149176;
        Wed, 14 Jul 2021 07:15:49 -0700 (PDT)
Received: from localhost.localdomain ([149.86.90.174])
        by smtp.gmail.com with ESMTPSA id a207sm6380037wme.27.2021.07.14.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 07:15:48 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 4/6] libbpf: explicitly mark btf__load() and btf__get_from_id() as deprecated
Date:   Wed, 14 Jul 2021 15:15:30 +0100
Message-Id: <20210714141532.28526-5-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714141532.28526-1-quentin@isovalent.com>
References: <20210714141532.28526-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that we have replacement functions for btf__load() and
btf__get_from_id(), with names that better reflect what the functions
do, and that we have updated the different tools in the repository
calling the legacy functions, let's explicitly mark those as deprecated.

References:

- https://github.com/libbpf/libbpf/issues/278
- https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#btfh-apis

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/lib/bpf/btf.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 0bd9d3952d19..522277b16a88 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -45,7 +45,8 @@ LIBBPF_API struct btf *btf__parse_raw(const char *path);
 LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf);
 
 LIBBPF_API int btf__finalize_data(struct bpf_object *obj, struct btf *btf);
-LIBBPF_API int btf__load(struct btf *btf);
+LIBBPF_API LIBBPF_DEPRECATED("the name was confusing and will be removed in the future libbpf versions, please use btf__load_into_kernel() instead")
+int btf__load(struct btf *btf);
 LIBBPF_API int btf__load_into_kernel(struct btf *btf);
 LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
 				   const char *type_name);
@@ -67,7 +68,8 @@ LIBBPF_API void btf__set_fd(struct btf *btf, int fd);
 LIBBPF_API const void *btf__get_raw_data(const struct btf *btf, __u32 *size);
 LIBBPF_API const char *btf__name_by_offset(const struct btf *btf, __u32 offset);
 LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 offset);
-LIBBPF_API int btf__get_from_id(__u32 id, struct btf **btf);
+LIBBPF_API LIBBPF_DEPRECATED("the name was confusing and will be removed in the future libbpf versions, please use btf__load_from_kernel_by_id() instead")
+int btf__get_from_id(__u32 id, struct btf **btf);
 LIBBPF_API int btf__load_from_kernel_by_id(__u32 id, struct btf **btf);
 LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
 				    __u32 expected_key_size,
-- 
2.30.2

