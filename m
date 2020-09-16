Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA1226C8B9
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgIPS4e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 14:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbgIPRyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A547C061756
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so7814688wrp.8
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+vyryLmkPcir5gGX7IxM9tzcLD9cCThO7+XXSg/AftU=;
        b=OmbmsGkqePPq02scg885HJzKk5sKhZ8YrFPvfqIoYh6HzrLza1QFdsP1f3ntwV751I
         ZFUp6fg+vstbSftPw1wMyoe7P/sz70/b4XpBRcxoEGRsgi8ErR0OCKuUZgGD7glZ6HIm
         R6nFp71y3Zts/DDyQGSr9IleKMLtnkPJ4om1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+vyryLmkPcir5gGX7IxM9tzcLD9cCThO7+XXSg/AftU=;
        b=cFobd/KniOA/A2jDd9nFpYbBVh3GsudzLgb90RETA/apRJJf+GvafPWGOF694a9qKu
         IWSXovxZqupe0ikEfjxD67dGylE3f4pkWqZcsTKQeTuYkXw2+DGCIdPIQWKn2Ka4lpfs
         Xpix+B6H0C8dwFOnUVGMqZo+6fszpRN+PjSyLETjm4ZY0VgNgVPrUh8NQDsXNqZZm5Qs
         rWbI2ojwDZohJ810W+lcWiFfKqTRWGCxtgRVgDivy2KQ2ny542lWbLONd7Xet8E+Q4X0
         S8Vrt2sNnwpsCtG3bR/G4UZ2mvUTbbdhoLL6gxfwgyhrwSAdt2yVfqeXUmrPJwK4pj0b
         iFbg==
X-Gm-Message-State: AOAM531n/t0sYfT9cqrF+5h1/74L20+MJexI/bYZihzI0WSLh6Ug7YRa
        XlCul1IIQ5F9MjaUSuVYC9l1Dw==
X-Google-Smtp-Source: ABdhPJySNrWuIbmkQBeUWY0XpWt8R+qpqPyoFkrGhwsYC+5isBVoMh6aNIZkd6WBvLubyZe1SGdp1g==
X-Received: by 2002:adf:f846:: with SMTP id d6mr30168625wrq.56.1600278811775;
        Wed, 16 Sep 2020 10:53:31 -0700 (PDT)
Received: from antares.lan (5.c.5.5.a.2.f.6.a.a.d.6.3.1.9.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1913:6daa:6f2a:55c5])
        by smtp.gmail.com with ESMTPSA id v17sm34177508wrr.60.2020.09.16.10.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:53:30 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 01/11] btf: make btf_set_contains take a const pointer
Date:   Wed, 16 Sep 2020 18:52:45 +0100
Message-Id: <20200916175255.192040-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916175255.192040-1-lmb@cloudflare.com>
References: <20200916175255.192040-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bsearch doesn't modify the contents of the array, so we can take a const pointer.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 include/linux/bpf.h | 2 +-
 kernel/bpf/btf.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5dcce0364634..4cbf92f5ecdb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1901,6 +1901,6 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
 
 struct btf_id_set;
-bool btf_id_set_contains(struct btf_id_set *set, u32 id);
+bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f9ac6935ab3c..a2330f6fe2e6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4772,7 +4772,7 @@ static int btf_id_cmp_func(const void *a, const void *b)
 	return *pa - *pb;
 }
 
-bool btf_id_set_contains(struct btf_id_set *set, u32 id)
+bool btf_id_set_contains(const struct btf_id_set *set, u32 id)
 {
 	return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
 }
-- 
2.25.1

