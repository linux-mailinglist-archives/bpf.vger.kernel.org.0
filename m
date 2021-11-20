Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944AF457AD4
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 04:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbhKTDgh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 22:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhKTDg3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 22:36:29 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770FCC061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:26 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so10343325pjb.4
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c9n2wOm/ug9o4NdtOtycz1rv7HYkNG/izLJFHlHF/VM=;
        b=cTx/88xEjc04Uxn9Bdnm36tUQVQ+0YAwmuHDClxMAEGXD1BWJ+VO1dwj3osybwX3tf
         BdmT6elMP1K100+vug8oMeYWRctLl8pK4LQMSxc4EtpOsrrwTfzybInH7xnuZBzwMxVc
         gS+VVfloSihpS2s5+2gAso2BLmHQyJF0OphTLIJXBmjISLdVFjNGOumVImc27pKz9N2m
         IMqbyeOsM+neytTf9XC2dQbZhCM0eRsudKghg2FTTKQ/hpfbXDYP6u1wrX7LDT4/eQv3
         pvZM64a81HNk3oQ0p7D1B0992BjOrEiEV5FUFESQqln0747BttTX9MUVKNtgeABPYgZn
         /BIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c9n2wOm/ug9o4NdtOtycz1rv7HYkNG/izLJFHlHF/VM=;
        b=UuKNVTjGnKQJ1l4TMCl/NIwWGSRNtHI/w9frUEq/bFkLzx9iaUzcRTTywFsiNzMpOs
         ebg7CtWTCNm6uW8d4Omfcp77FM+oqq3GCm4/iY417gcTqBm7Jem+3k6pINx0MhmxFwF4
         O6UPeRku8KTczrZThSJmNA042WCTf2HuXVaFY86KYca6G+qYimawJE9bWnDDPk2by8fH
         U+w6pffBWdG9bW4oHP0BmLK8A4FKzrvCYHjj1oQ/TmP6ljcW/GNG6IwYm8kRnsC1Z0ry
         syL4SfA66YMRTuZUaXc0ZZXCNjIFzJ1Np3bhVICtgTdjEskR5NJRg7yLF6JnUhYdQWaU
         7wlQ==
X-Gm-Message-State: AOAM531cRcUhjgXySbNDpRnnfXhQMh/3cHjmhQUKcgxAtGnsg1JKyg/i
        SuxiSOs6qnpeJKpwas/wYFk=
X-Google-Smtp-Source: ABdhPJxYygJfILjEXpD5RGifRRqK39FiCCINjPrVXd079I4Zpxmg3AIwUwqvvSi+6zpD73u1sUW9Ig==
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr6256829pjb.113.1637379206024;
        Fri, 19 Nov 2021 19:33:26 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:a858])
        by smtp.gmail.com with ESMTPSA id pf15sm13093285pjb.40.2021.11.19.19.33.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Nov 2021 19:33:25 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 10/13] selftests/bpf: Improve inner_map test coverage.
Date:   Fri, 19 Nov 2021 19:32:52 -0800
Message-Id: <20211120033255.91214-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
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

