Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011DE4654DA
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 19:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352180AbhLASQK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 13:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352247AbhLASO5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 13:14:57 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB48C061763
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 10:11:19 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r5so24393220pgi.6
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 10:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c9n2wOm/ug9o4NdtOtycz1rv7HYkNG/izLJFHlHF/VM=;
        b=C0LdCvjB3PrzgNz8mg/FT6lY5441py8+lPENqdFATcuZZZsJ2zrsg3WJF8q1ziYsQs
         dqvnXtopRL9FMB2cDa6JnT4H3T6WiSxyJz4CCXVlQm0kBN7trERUdfjhjsHELIcnUPqw
         pceAYKmIGY/Pj8pc1zKeL/qdg+h9roTAqpx1jqoN3FPwh326Rgg7Rrt5RKkpcEWmIyjg
         O5iTmglb4x9MsI60e3IVBmYF5C0miqnJjyfz46NieHe8Nmt7hHseyK9QWyYG3f9nEoXH
         iFg6hnYYaByj9I0ZjgQ8coqiAUfxshJ5nhFfdQW1HIgT/3NDyphxMZjg0AvhhvfurmG8
         WzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c9n2wOm/ug9o4NdtOtycz1rv7HYkNG/izLJFHlHF/VM=;
        b=5of/tBOCpF0klvWIr/K83aXrgft9H9M7Teec9GsqgkydFwQSd5EJCGQMqS/qaCgRR9
         4XNKOfpZ4TmKmEBVfZBTIDQtn+3PSxxMtFLXTsXrLsE4eEOFDAGhRjjNfzt1rr4u7QNq
         amou/uHoO42o4asbCTlMRqT46rBer5z53GwQ6r6MveKVWmLui/+a0Yc8cScZlXs4vwgE
         fIj5o2RAoBls7vUXVHYK05tLWhTPyK/MDWtpKpl+HQObhgwmwGSFEvYU3iSHYHLO19rW
         ulHTQU1+bfq/hISWOsH2UlBAL6mGZCGjRONd57DcpwgD0+cLAIH8eh1mJsmYTXbzGPx5
         UDJA==
X-Gm-Message-State: AOAM531kiWXO9anXkIyuF7whvyR1deyhduOP64kc2/CV6qSnuPzlXzkc
        Eq2q2dr/NEL9Yg/g0mQ61ew=
X-Google-Smtp-Source: ABdhPJwLqRkqVjguqIKpfRzCrFO7aJnizcf12U+8GzzYGbZKDqouFacCC9G9Tagsml+/g2wKFf5sTw==
X-Received: by 2002:a63:2d03:: with SMTP id t3mr5781621pgt.428.1638382279308;
        Wed, 01 Dec 2021 10:11:19 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id j15sm502494pfh.35.2021.12.01.10.11.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:11:19 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 bpf-next 13/17] selftests/bpf: Improve inner_map test coverage.
Date:   Wed,  1 Dec 2021 10:10:36 -0800
Message-Id: <20211201181040.23337-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Check that hash and array inner maps are properly initialized.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/map_ptr_kern.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index b1b711d9b214..b64df94ec476 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -334,9 +334,11 @@ static inline int check_lpm_trie(void)
 	return 1;
 }
 
+#define INNER_MAX_ENTRIES 1234
+
 struct inner_map {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
+	__uint(max_entries, INNER_MAX_ENTRIES);
 	__type(key, __u32);
 	__type(value, __u32);
 } inner_map SEC(".maps");
@@ -348,7 +350,7 @@ struct {
 	__type(value, __u32);
 	__array(values, struct {
 		__uint(type, BPF_MAP_TYPE_ARRAY);
-		__uint(max_entries, 1);
+		__uint(max_entries, INNER_MAX_ENTRIES);
 		__type(key, __u32);
 		__type(value, __u32);
 	});
@@ -360,8 +362,13 @@ static inline int check_array_of_maps(void)
 {
 	struct bpf_array *array_of_maps = (struct bpf_array *)&m_array_of_maps;
 	struct bpf_map *map = (struct bpf_map *)&m_array_of_maps;
+	struct bpf_array *inner_map;
+	int key = 0;
 
 	VERIFY(check_default(&array_of_maps->map, map));
+	inner_map = bpf_map_lookup_elem(array_of_maps, &key);
+	VERIFY(inner_map != 0);
+	VERIFY(inner_map->map.max_entries == INNER_MAX_ENTRIES);
 
 	return 1;
 }
@@ -382,8 +389,13 @@ static inline int check_hash_of_maps(void)
 {
 	struct bpf_htab *hash_of_maps = (struct bpf_htab *)&m_hash_of_maps;
 	struct bpf_map *map = (struct bpf_map *)&m_hash_of_maps;
+	struct bpf_htab *inner_map;
+	int key = 2;
 
 	VERIFY(check_default(&hash_of_maps->map, map));
+	inner_map = bpf_map_lookup_elem(hash_of_maps, &key);
+	VERIFY(inner_map != 0);
+	VERIFY(inner_map->map.max_entries == INNER_MAX_ENTRIES);
 
 	return 1;
 }
-- 
2.30.2

