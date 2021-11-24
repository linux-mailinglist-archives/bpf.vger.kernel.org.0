Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A38045B424
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhKXGFz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhKXGFz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:05:55 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15456C061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:46 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g18so1635668pfk.5
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c9n2wOm/ug9o4NdtOtycz1rv7HYkNG/izLJFHlHF/VM=;
        b=Lk5aPxbz/nDVOWchoru+n5k5hqyiFQCu+JyUvwJk9wU3CaAakZcZmnKQ7sW0GJ/+Wo
         uq52+vxi+yNknFAqogIqw05LzDjvQK2EruPw7NrREqh+SrGCungHZyAIPvVgM3nMlXyI
         je0Of7Ed8JK+5LhbeE/8QZSB1EKJf4XuDa0WS4IlDlpaGIpVPxu9mdhroBizR4BQ1sX3
         Dlji3ScEmLFy9oUvETSqHvAjZWzwlXZW86a+fXNshy5YcZYGjdma1dA5A+e85blTKSrd
         hqDLLWGgjp/Uh/rM8DQu75fgCl85bdRo07+OwtIvy74Qq8qq56MGi0rtn0bOESwoJ/B4
         ZytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c9n2wOm/ug9o4NdtOtycz1rv7HYkNG/izLJFHlHF/VM=;
        b=Q1vj9gq6U/WwhXD34g4+YbhZtSSaykDbpjd8OPDg9NoyGg/R4LwnFBryAYWCu4HITb
         w911hJE6jgPIhVNGojSiVZ3hpjZNQ0+QrMxQngQ/ANxeMFuVhBJQGJeemX/IPRVmjl1Y
         YL30/tyKZyXuDdkgcbGDqXVsplu5xK1Xn4p1NAN6NmVob4Uc1C+NNMsUwu94le2YpKBy
         5mUwJfKb5Br6HW/BnasdAZUeC3ZEhaDDL3Yc/to+vU582DTfug+HwnOUZLgIfPW3MrP6
         D8GKMumj7+FtIcsticU53XF8mL7vfYJrTEwEcpTJZsFxvcpyVRpEDwBkI0C1Hs82DhF+
         iODQ==
X-Gm-Message-State: AOAM530gKa5sfr97pYpHyRU3ldyDOQfHC8vlRqDHG3/wD7HTAQbl9+Ks
        gD0N/Zwd1Gf/1mPo6fAyKuk=
X-Google-Smtp-Source: ABdhPJwPa7jMuz0JptwakrcVLkt7iWWuvua6bJel6PzovcL2MQ5mk0kIru7wAruT7Bg9wRgKc2vt4A==
X-Received: by 2002:a05:6a00:888:b0:44c:c00e:189c with SMTP id q8-20020a056a00088800b0044cc00e189cmr3331779pfj.79.1637733765497;
        Tue, 23 Nov 2021 22:02:45 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id o2sm15464185pfu.206.2021.11.23.22.02.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:45 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 12/16] selftests/bpf: Improve inner_map test coverage.
Date:   Tue, 23 Nov 2021 22:02:05 -0800
Message-Id: <20211124060209.493-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124060209.493-1-alexei.starovoitov@gmail.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
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

