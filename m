Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA933BF1EA
	for <lists+bpf@lfdr.de>; Thu,  8 Jul 2021 00:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhGGWTt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 18:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhGGWTt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 18:19:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6765C06175F
        for <bpf@vger.kernel.org>; Wed,  7 Jul 2021 15:17:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b8-20020a17090a4888b02901725eedd346so2542987pjh.4
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 15:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WA3SzVjBCH0Q3Xq+A8Mtmumh+nsHK+be6i9Ea//A9I=;
        b=bFRJTltoJw1lIXiDZnx8C5g+rPe43WZmVM1uJqjEvP70s+IFYyfYplA7M1tT8Wvv5Z
         YeIQ/4Gn0FIFdd2SnNPX47/rWvfTYx9M9d106a0cKgO4D43m5V+u+4PkA8i7YNufxT+4
         bWYPZz8MSAPmCOl6BCEHOHcYnfupe2KOs/N3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WA3SzVjBCH0Q3Xq+A8Mtmumh+nsHK+be6i9Ea//A9I=;
        b=BFJAP7iZoXlBi59Yianlx01guDv9ThfPA0/AcZdGwsvfB9nKeJR72G9adzDR0Rs9Jp
         JHYShDcDsQ39x+t26vlhzIGJuUEEyaZpjMDAuhuI+QVm0SB+4dF55zPc9RHZHAk1N749
         +QaSzZ97utxSWOtGqvUfB9ktdP6c/pfiZDBgtVqB1hihMDIJr6/Y4eoGAAozZSLshXl1
         ZHEonVBiCPHLa67pcykocGMYq6tST6sbcofs9avPvhg9eDXz6qhaWuP7b2UqF2Mn7e3k
         DT7+VEDwpPtOGI2gV+eDLjiVIMP1BVqz8nWGkoxxTbDJLIVj9S/ao0cqTgIc4htSDW/z
         bQow==
X-Gm-Message-State: AOAM5321SjhEegaahwo1MO6ryGYhGbiK8lLe7wxZK1UF41I2UM4dn+g1
        sYkG4XD1mUXqU1YbXMCyyg1c639N1dTj6LxI
X-Google-Smtp-Source: ABdhPJzByQpIB335oijU1wzmQpsqh6DKiWnF0FRRtLtT6fWvJCpNxa7rT1bDs3rdeXu1FRx6puSx8w==
X-Received: by 2002:a17:90a:17e7:: with SMTP id q94mr27667052pja.117.1625696227151;
        Wed, 07 Jul 2021 15:17:07 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id 75sm203748pfx.71.2021.07.07.15.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 15:17:06 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Zvi Effron <zeffron@riotgames.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: [PATCH bpf-next v8 1/4] bpf: add function for XDP meta data length check
Date:   Wed,  7 Jul 2021 22:16:54 +0000
Message-Id: <20210707221657.3985075-2-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707221657.3985075-1-zeffron@riotgames.com>
References: <20210707221657.3985075-1-zeffron@riotgames.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit prepares to use the XDP meta data length check in multiple
places by making it into a static inline function instead of a literal.

Co-developed-by: Cody Haas <chaas@riotgames.com>
Signed-off-by: Cody Haas <chaas@riotgames.com>
Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Zvi Effron <zeffron@riotgames.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 include/net/xdp.h | 5 +++++
 net/core/filter.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 5533f0ab2afc..ad5b02dcb6f4 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -276,6 +276,11 @@ xdp_data_meta_unsupported(const struct xdp_buff *xdp)
 	return unlikely(xdp->data_meta > xdp->data);
 }
 
+static inline bool xdp_metalen_invalid(unsigned long metalen)
+{
+	return (metalen & (sizeof(__u32) - 1)) || (metalen > 32);
+}
+
 struct xdp_attachment_info {
 	struct bpf_prog *prog;
 	u32 flags;
diff --git a/net/core/filter.c b/net/core/filter.c
index d70187ce851b..f2c15b2a057a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -77,6 +77,7 @@
 #include <net/transp_v6.h>
 #include <linux/btf_ids.h>
 #include <net/tls.h>
+#include <net/xdp.h>
 
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
@@ -3880,8 +3881,7 @@ BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, xdp, int, offset)
 	if (unlikely(meta < xdp_frame_end ||
 		     meta > xdp->data))
 		return -EINVAL;
-	if (unlikely((metalen & (sizeof(__u32) - 1)) ||
-		     (metalen > 32)))
+	if (unlikely(xdp_metalen_invalid(metalen)))
 		return -EACCES;
 
 	xdp->data_meta = meta;
-- 
2.31.1

