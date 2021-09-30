Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3202A41DEA0
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 18:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349173AbhI3QRL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 12:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348925AbhI3QRK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 12:17:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04D5C06176A
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 09:15:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t4so4424865plo.0
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VQucG0n/9IMODMQgoowb7tVgxr5scORwSV2U9200/Ck=;
        b=opwV+U1TCpKvctdYcqPnibMUnRxDouy3peBvJ+UsLKO3q5g3enARVsXkXhQO/54uRu
         mb+kXLgvqMHk4YIPUK6rg78BgFcukr79Xzx/Nzg5ZjKUmd+Pg8134Z8fomBBiDRFGfpi
         IPHV2Gt41b12e4BPeMAZXKi+p075gTexQK1pM8WWOzk05PQGAg3Naa4/a8rw7YSlTKSl
         Kr8diXcYCCaNObP0OBHwFKGLFYYBRLNQW4r32jttmAUwsG9kzGlYeVIit+ljsVqfc1No
         U+pS6h6PpguaKTieGX+VRkEzpdnHW1+ewg6Ow132yKMR8wZQkKvO0192iQjaEYqaxu4X
         6hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VQucG0n/9IMODMQgoowb7tVgxr5scORwSV2U9200/Ck=;
        b=M9bTek4xUtJKT3z5oEE71XLcNEWhMhC0c1CfSV0X09J6g45SlnavkuxbVq4bvpdD1n
         oNA1OA5cjuyihNmSJcEDBJkhMqsA5LGzDi2eaVuKnXedVq8gTKkUvMm7QUOPPzNZPiNi
         hooHxOUglHIgJnX3agxdaTfvjPIEgAm3jx1VpTc+51XrFlD73wacwRJoNHyzEb+rYkPE
         UCMi2CSUoiOotuOHEt6sKYb3y4h2Gfw3VdsgnyZMm2qL5twEreHCBzyTyr7sHIoPVX1e
         zs0RNR++3nBFKUw3s4eFYdH8waEqz2FCWL4A+s2ftRutXl/na4H9+eQrhCN20UX8l+r7
         fdnw==
X-Gm-Message-State: AOAM533NCWGs4SanwsvAimkjMVtuz/YxM2J1xMQ6q22a2IfVHUoRYcxR
        kxjtmrnZQsKRRoicbaXN5Oj64pldFeIapQ==
X-Google-Smtp-Source: ABdhPJzfUqX2SnAv3SmF0fpv7bfJn82URBVshrvkXQpCCR84qZPRko/iydc9Q1JYoNtZ2HgkqQf3gg==
X-Received: by 2002:a17:902:be0f:b0:13a:95e:a51 with SMTP id r15-20020a170902be0f00b0013a095e0a51mr4834907pls.44.1633018527245;
        Thu, 30 Sep 2021 09:15:27 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id p17sm5278090pjg.54.2021.09.30.09.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 09:15:26 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/2] libbpf: Support uniform BTF-defined key/value specification across all BPF maps
Date:   Fri,  1 Oct 2021 00:14:55 +0800
Message-Id: <20210930161456.3444544-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930161456.3444544-1-hengqi.chen@gmail.com>
References: <20210930161456.3444544-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A bunch of BPF maps do not support specifying BTF types for key and value.
This is non-uniform and inconvenient[0]. Currently, libbpf uses a retry
logic which removes BTF type IDs when BPF map creation failed. Instead
of retrying, this commit recognizes those specialized maps and removes
BTF type IDs when creating BPF map.

  [0] Closes: https://github.com/libbpf/libbpf/issues/355

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ef5db34bf913..b96eb3a64cca 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4643,6 +4643,30 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 			create_attr.inner_map_fd = map->inner_map_fd;
 	}

+	switch (def->type) {
+	case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
+	case BPF_MAP_TYPE_CGROUP_ARRAY:
+	case BPF_MAP_TYPE_STACK_TRACE:
+	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
+	case BPF_MAP_TYPE_HASH_OF_MAPS:
+	case BPF_MAP_TYPE_DEVMAP:
+	case BPF_MAP_TYPE_DEVMAP_HASH:
+	case BPF_MAP_TYPE_CPUMAP:
+	case BPF_MAP_TYPE_XSKMAP:
+	case BPF_MAP_TYPE_SOCKMAP:
+	case BPF_MAP_TYPE_SOCKHASH:
+	case BPF_MAP_TYPE_QUEUE:
+	case BPF_MAP_TYPE_STACK:
+	case BPF_MAP_TYPE_RINGBUF:
+		create_attr.btf_fd = 0;
+		create_attr.btf_key_type_id = 0;
+		create_attr.btf_value_type_id = 0;
+		map->btf_key_type_id = 0;
+		map->btf_value_type_id = 0;
+	default:
+		break;
+	}
+
 	if (obj->gen_loader) {
 		bpf_gen__map_create(obj->gen_loader, &create_attr, is_inner ? -1 : map - obj->maps);
 		/* Pretend to have valid FD to pass various fd >= 0 checks.
--
2.30.2
