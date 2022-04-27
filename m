Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791535124BE
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 23:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiD0VrM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 17:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiD0VrJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 17:47:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5651C90CF7
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 14:43:56 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id p4so1620059qtq.12
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 14:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OywmHZ8Wl/zWWJ7+eEjDAYDw9cbKjPFFgbS92Z0H48k=;
        b=UZzxlEtw5rgV67Ub8Dj0VzeD7Z4dq8dozdevDkCDAvHu58NCvq+Hj9krmlQDXJGnZn
         hB7rlCH5/rjgaI7fpJk4cglqk5a+uciUqHiQfMksUF44mdIYTT+OIDeLK+xkrmDEd0g8
         a6jS+THH+271n39haamqah9dCEw1PI7bfQq4RJaHs7ARlc0pF6MqYVWwkVLbpVq+Ndl4
         a3FQZrobNgqx1YfmvF3sIq91wwkBHxGEqDjmQOEFZSBd8BHRV8X+QtMRIWI0XPhGbzbn
         AQsuBJaRyr+wWC0S/xyd+8syaBm1qaJtO4ukol0+vSRhIxHf8vsb2x+mEzJdPfo4/kCM
         uaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OywmHZ8Wl/zWWJ7+eEjDAYDw9cbKjPFFgbS92Z0H48k=;
        b=BdPDWeeOlPXWgKhx3gRynMo+wwZnBIsr2g5BumfK4ysoQtDEIjib2HUtWXQxDRINyH
         OLPMkF6oyqWYqCC4eEtbOUXXGUUTr6Ihm+MHsLjg4S+lNjBIOcGS0jDbjttWSptHyCRA
         76NbL0C1w5QnZK2J5laCHoAZ38oi2r9Nl0pDP9RKmYV3Zv7OxalwNtFQ8HgSiaYUfec6
         pK3R7YzR0Aj5QWJbXLff2JMCumhKtH8e3h/JyN0efzkeDeojWfhoM93a26xs7oGLj8hf
         d/eUh/cTWxhdy6LmBT/FN/1bYcjcq0IRChinWx+g45dnhYzVW0lIfqF5EMa70H7mNwTq
         PZ7w==
X-Gm-Message-State: AOAM532BVulXZDI2TY2aqw5EEdWVw2n0xqGipWMkZy49kgfAasRy5yxy
        MiWXnm0OjRvDE6iMQofOzGfrFqD/1Wl8xw==
X-Google-Smtp-Source: ABdhPJzVxzWNAshS+tEXfbBZKPCTFK5y8DvezqLp1aZDuW2Uy9OzrVtLYMP9Z/IFaJOQc1MwZU/MQA==
X-Received: by 2002:a05:622a:1185:b0:2f3:3560:14e6 with SMTP id m5-20020a05622a118500b002f3356014e6mr20713358qtk.324.1651095835211;
        Wed, 27 Apr 2022 14:43:55 -0700 (PDT)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id 186-20020a3707c3000000b0069f9a8cbec2sm839538qkh.131.2022.04.27.14.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:43:54 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, Grant Seltzer <grantseltzer@gmail.com>
Subject: [PATCH bpf-next] API function for retrieving data from percpu map
Date:   Wed, 27 Apr 2022 17:43:37 -0400
Message-Id: <20220427214337.716372-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

From: Grant Seltzer <grantseltzer@gmail.com>

This adds a new API function used to retrieve all data from a
percpu array or percpu hashmap.

This is useful because the current interface for doing so
requires knowledge of the layout of these BPF map internal
structures.

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/libbpf.c | 28 ++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h | 25 +++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 873a29ce7781..8d72cff22688 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -36,6 +36,7 @@
 #include <linux/perf_event.h>
 #include <linux/ring_buffer.h>
 #include <linux/version.h>
+#include <linux/math.h>
 #include <sys/epoll.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
@@ -4370,6 +4371,33 @@ int bpf_map__resize(struct bpf_map *map, __u32 max_entries)
 	return bpf_map__set_max_entries(map, max_entries);
 }
 
+void *bpf_map__get_percpu_value(const struct bpf_map *map, const void *key)
+{
+
+	if (!(bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY ||
+		bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_HASH)) {
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	int num_cpus;
+	__u32 value_size;
+	num_cpus = libbpf_num_possible_cpus();
+
+	if (num_cpus < 0)
+		return libbpf_err_ptr(-EBUSY);
+
+	value_size = bpf_map__value_size(map);
+
+	void *data = malloc(roundup(value_size, 8) * num_cpus);
+	int err = bpf_map_lookup_elem(map->fd, key, data);
+	if (err) {
+		free(data);
+		return libbpf_err_ptr(err);
+	}
+
+	return data;
+}
+
 static int
 bpf_object__probe_loading(struct bpf_object *obj)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index cdbfee60ea3e..99b218702dfb 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -921,6 +921,31 @@ LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t *psize
 LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_map__type() instead")
 LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
 
+/**
+ * @brief **bpf_map__get_percpu_value()** returns a pointer to an array
+ * of data stored in a per-cpu array or per-cpu hashmap at a specified
+ * key. Each element is padded to 8 bytes regardless of the value data
+ * type stored in the per-cpu map. The index of each element in the array
+ * corresponds with the cpu that the data was set from.
+ * @param map per-cpu array or per-cpu hashmap
+ * @param key the key or index in the map
+ * @return pointer to the array of data
+ *
+ * example usage:
+ *
+ *  values = bpf_map__get_percpu_value(bpfmap, (void*)&zero);
+ *  if (values == NULL) {
+ *     // error handling
+ *  }
+ *
+ *	void* ptr = values;
+ *  for (int i = 0; i < num_cpus; i++) {
+ *    printf("CPU %d: %ld\n", i, *(ulong*)ptr);
+ *    ptr += 8;
+ *  }
+ */
+LIBBPF_API void *bpf_map__get_percpu_value(const struct bpf_map *map, const void *key);
+
 /**
  * @brief **bpf_map__is_internal()** tells the caller whether or not the
  * passed map is a special map created by libbpf automatically for things like
-- 
2.34.1

