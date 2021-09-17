Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252A3410101
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 23:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244564AbhIQV7O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 17:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbhIQV7O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 17:59:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C018EC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so10970868pjc.3
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pf9KWTCRmuNvQZMe/iXAdPWIplRtRVUJi31P0ie9MRo=;
        b=YloAcEKWNB0hqQo60VZJigxRgdzjnxNV43xADBuG0clq0EOmb7+4C3FZ0zQ3Me9bZv
         xFBIlnzXTTZ+yyKSAOYNVQKe7+s4U0+9Q6Gp2F8VZyCIzVn8Zc8phpz4tM5QHBPQnzoe
         3lim5yG9lEvRG7WfCJVfZV+puPzVSv9UWd+u/EHGiT/E1KI5iWTdk4ngU0iEW+EEPbzu
         GKWdCY5EKUCtLdlFWftx48qvlzAuWcDyqkaKlrJm6GixEjWzuoL9FPvmFbLUUAQQ3GIR
         CgEZs8FKKL4GLxmEcinWdQH1pmYyirSspjLOes5YZSZZZb0e9Qb4nlwUkRTn+Lc/yM3R
         EWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pf9KWTCRmuNvQZMe/iXAdPWIplRtRVUJi31P0ie9MRo=;
        b=yTEDFNEEYCzBjf1c03ctaFZObP4rlh1RfY3Oey8HVUmzhdxPwcAMDZ6rKvErEMwmf6
         UFpxrlKTiw9dtgMZg3sZacK5gW84iVXaD2E3EUG8A8RLn3hX57zcTw/oKQNo/6bzhySr
         K5DpXA0C4FPHTRscSc8wt9/zVvYdKqixG3v79aaz9T2C5/eUBImwcw1+B4OfJiKvVR6J
         BM8mqcaFPVrhxqL1rBkeCVkl2CaYHj/vlrJ+uTRZ1+yrG2Yptpw1OYKPlcya4t/i/Jxc
         TcrIGa3MINyiG7GAnkH5ETlmjo4fE9WbTn2VpZu8UU0IXrgpLq/15vGbclfZV4wXfPqu
         FMrQ==
X-Gm-Message-State: AOAM531pd6CoydfOlhz84Y50T6DQLqfqs9P3f3C265fsuAqoNcIcG31g
        nsPEMCjm14Nlsg2hnO1Md3s=
X-Google-Smtp-Source: ABdhPJzQVpV35DY0nHchkglnQ/pcW+vKMIaBDaxizWU5o/J100izxYW/Sl4OlyaapSWihFamLsf9Jg==
X-Received: by 2002:a17:90b:4b47:: with SMTP id mi7mr23883361pjb.198.1631915871265;
        Fri, 17 Sep 2021 14:57:51 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::6:db29])
        by smtp.gmail.com with ESMTPSA id x1sm7310981pfc.53.2021.09.17.14.57.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 14:57:50 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        lmb@cloudflare.com, mcroce@microsoft.com, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RFC bpf-next 09/10] selftests/bpf: Improve inner_map test coverage.
Date:   Fri, 17 Sep 2021 14:57:20 -0700
Message-Id: <20210917215721.43491-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Check that hash and array inner maps are properly initialized.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/map_ptr_kern.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index d1d304c980f0..b9b7342763c3 100644
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

