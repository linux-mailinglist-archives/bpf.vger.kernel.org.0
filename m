Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6823D3B3864
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 23:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhFXVPd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 17:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhFXVPc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 17:15:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63128C061574
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 14:13:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b3so3624955plg.2
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 14:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kqo+96VFKjlfVy/mad4ioLL51Fxv6ZwOZvh4XlzGWBU=;
        b=B8fH6nWHHXsxWZD6NDBLH09IT8Xl6hAWmX/lUDl1Nap4auwuQS6+9th9Qo/CcJOTCn
         aQxzXfQ8sE6xCToVaKQScpgpSHfr3f5ceBRskUyFC7FFBYQ/zfjadHO+7waqyQqwFUzV
         tRqXJdH7wY72sM4WetJezK53avYnTS+nct6RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kqo+96VFKjlfVy/mad4ioLL51Fxv6ZwOZvh4XlzGWBU=;
        b=n095MuIWH1JeASjJJWuQwNu9qV2UWdCiyKm+ipuxBHLUVFwXkZznm4CoHd+xQ6Bbr5
         JY9fd+8c9VzJD7Mdt7hIx2kEG92/tP392pKjvmAQumLHLV0GpEik/I/M/i/wdeJzn6Mn
         EAXKAsLcvFCf9Dpk8F4Vstr6poJm4rO8x6FjLcR3CyKr2DWEuLfBuTsHdNwHd3t5s0AA
         4Kz/e5TMOADdW1uN7QVwPcC6m1CaZHp1uL1ZRMYMMeXMF0MVGDHdwZ47PnGKrhb0eeWy
         1xTxm1MJoJcDxrt7IGTeZyo73ZgAqXTaO5ouaiXxBEk2yZXWeFg8UN3oRlkkUzgsOJcQ
         C25g==
X-Gm-Message-State: AOAM532PMs0aMZyb2iZFOlf6WEKVHns/v2w7QkU+c1NcvUzLvEnAbfLN
        5kKCTo/HtmTaMh+OchIiTiUXYYuThmHZtbz5
X-Google-Smtp-Source: ABdhPJwM7TjrkKQtwMuATMox3XD+f4+LzMks9hzVbyaKa/QOPweVqIGa6jouVFl0PadBpn9KJdLlBA==
X-Received: by 2002:a17:90b:3a91:: with SMTP id om17mr7636667pjb.50.1624569192136;
        Thu, 24 Jun 2021 14:13:12 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id d13sm3615394pfn.136.2021.06.24.14.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:13:11 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Zvi Effron <zeffron@riotgames.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Subject: [PATCH bpf-next v7 1/4] bpf: add function for XDP meta data length check
Date:   Thu, 24 Jun 2021 21:13:01 +0000
Message-Id: <20210624211304.90807-2-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210624211304.90807-1-zeffron@riotgames.com>
References: <20210624211304.90807-1-zeffron@riotgames.com>
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
index 0b13d8157a8f..118158d6e883 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -77,6 +77,7 @@
 #include <net/transp_v6.h>
 #include <linux/btf_ids.h>
 #include <net/tls.h>
+#include <net/xdp.h>
 
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
@@ -3906,8 +3907,7 @@ BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, xdp, int, offset)
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

