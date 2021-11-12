Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A88B44E142
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 06:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhKLFFu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 00:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhKLFFt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 00:05:49 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE40AC061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so6157508pju.3
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GoPiOP6vip6QZI9MnHa0LaX4XcBmuvGfSVkJgubAMs=;
        b=V7FNE9FO6YZLJl8ClSpFxJnjawdh8aWGVafmDnx/UplnnqTDUoEZQ2EKle8ag2pV9P
         JcaOJbbKpe9EKHHC3vJgLlCsCrVK2c+EIUzAELouOcrYXnqe7RscdaVivoCBflsS8Okt
         //XheGiLdMcVCv1MvBaNCnCuw98o0txN8ZlF3j/rMxGS17i8LBhLmV9yVuD0KdwtVjLw
         x8WJPHto+nTEaWTYJZwyQu5rJeJ1s4NnOMkoKpuXFbm9HxmCNsjxc5noBl7CNGMEU9wd
         NiVpc6bemGLlF0cNu340oRn3G4/85gqCsgrSxyvhYQRl7CJwboVbCnMTweZTrFp3tycu
         ZvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GoPiOP6vip6QZI9MnHa0LaX4XcBmuvGfSVkJgubAMs=;
        b=Hcs3IgKFCjJJCOG/gy5jAq6s2aLt7HoEUJ1F1j+c28A/PbN4MYCF7wbRUehozRcxbo
         ig5yCQTw1Sf1n3eDQK7QQn+AubuyFmJj9sY3IvyZVeh/JojQa2Q14H4t66toZFdlY2MP
         EGoXQXERasOS6PKFqjiOtllIRBnxHQdqeeqo02C1KFNPKCq+JQS6FgwjnrJ1Hf2RqIFg
         EinFg7zq5DnoUc94AJeLJKhS5E9aMcljqsKdFG7uIbb2iFbvjmpOz9GK2ny0cppRYfYF
         jnbCZIjxJxoFPT/mTuMLry9JbX62Cw3Kmt107V8d2JMemT+TmXct9lxw/p97i7t7keTf
         P4Qw==
X-Gm-Message-State: AOAM531Reo43o6EMc8gw8fBfYuBlZP6TNezEDhN/aiuzhHjqVDgSVDJ3
        uHH20aT54NWXINVBuJ0t/Q4=
X-Google-Smtp-Source: ABdhPJw/yh+xMWPqMcLdrzrmswYaW8LmPPmQaJrzG+HronFyom3l+0kTkiJ2lCaywq8Qtwjmw9yGHQ==
X-Received: by 2002:a17:902:a717:b0:142:76bc:da69 with SMTP id w23-20020a170902a71700b0014276bcda69mr5302422plq.12.1636693379320;
        Thu, 11 Nov 2021 21:02:59 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:3dc4])
        by smtp.gmail.com with ESMTPSA id kk7sm10212545pjb.19.2021.11.11.21.02.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Nov 2021 21:02:58 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 10/12] selftests/bpf: Improve inner_map test coverage.
Date:   Thu, 11 Nov 2021 21:02:28 -0800
Message-Id: <20211112050230.85640-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
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

