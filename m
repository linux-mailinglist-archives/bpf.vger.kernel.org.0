Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF383AA6C3
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 00:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhFPWtr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 18:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhFPWtr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 18:49:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7173C061574
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 15:47:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u18so1924461plc.0
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 15:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fkT/h0nuo62m1KMVklUTthfLbE7X2XqIRgu5xra2CTQ=;
        b=Ajd7j0BP8feN3kJpY/X3pZvzjZgKZqdf3b2SGM1cUnTcfFZ242liBu4ELVIrXy1ACo
         SCf/9EcWrKsN5mWgUKQVcdpo+KZjDg6wHA0h83BMEsLU4wyUV0PkHwqQYENjruwr9YIA
         cGmeScG2Vf6tl8dZuC5iCLAfEGp3No1rpmbHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fkT/h0nuo62m1KMVklUTthfLbE7X2XqIRgu5xra2CTQ=;
        b=nIfFny6LK/IeEzUAPLEV/z09lO3Dje0XGtB13AGr1/HN+xgIulxs9H56KNDNwA4pkp
         U9RERHog50/Jcs8+3X3VOTYafDsR6KI/yQaSVQo5Xwt8SqMHgLOUBhNeXoQCvreKXCXM
         TESrNEX03sxA9QpDivuIv53FKR8FRRqDdbPt68j77Pq4pYpzGFW6a1eo2NFfu1bpAE0E
         bx7bA5+MtOTprevot5RbSp8WBJFwE20+JE30NR6l48Y3ydxZC92shqNKvZ7S0Enkxw7e
         +AGX+uFSg20lnOLGGYVUQnGSJueXvysuUgo/nM5r3crkK55tMCkH/b3+e16sDeg3pBBk
         6S9w==
X-Gm-Message-State: AOAM533cwxjyNjEXaCiz4BIzRmAN2FDIEay6j0WbgqkOxIpKZ9s3xczr
        yx95UcdWfWwFggEY3mTSIjhlQ8NBnpr3yg==
X-Google-Smtp-Source: ABdhPJwHQxrkd60kP2fMwWcAm0fN3bD6WWvpgG05AW1bRqBF9vMEawvXp5L9RE8Jgq7LIY70lajx9A==
X-Received: by 2002:a17:90a:fa04:: with SMTP id cm4mr13112483pjb.111.1623883659973;
        Wed, 16 Jun 2021 15:47:39 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id p6sm6278672pjk.34.2021.06.16.15.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 15:47:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/4] bpf: add function for XDP meta data length check
Date:   Wed, 16 Jun 2021 22:47:09 +0000
Message-Id: <20210616224712.3243-2-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616224712.3243-1-zeffron@riotgames.com>
References: <20210616224712.3243-1-zeffron@riotgames.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit prepares to use the XDP meta data length check in multiple
places by making it into a defined macro instead of a literal.

Co-developed-by: Cody Haas <chaas@riotgames.com>
Signed-off-by: Cody Haas <chaas@riotgames.com>
Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
Signed-off-by: Zvi Effron <zeffron@riotgames.com>
---
 include/net/xdp.h | 5 +++++
 net/core/filter.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 5533f0ab2afc..8bfd21bfeddc 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -276,6 +276,11 @@ xdp_data_meta_unsupported(const struct xdp_buff *xdp)
 	return unlikely(xdp->data_meta > xdp->data);
 }
 
+static __always_inline int
+xdp_metalen_valid(unsigned long metalen) {
+	return (metalen & (sizeof(__u32) - 1)) || (metalen > 32);
+}
+
 struct xdp_attachment_info {
 	struct bpf_prog *prog;
 	u32 flags;
diff --git a/net/core/filter.c b/net/core/filter.c
index 5b86e47ef079..b4a64a07de88 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -77,6 +77,7 @@
 #include <net/transp_v6.h>
 #include <linux/btf_ids.h>
 #include <net/tls.h>
+#include <net/xdp.h>
 
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
@@ -3905,8 +3906,7 @@ BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, xdp, int, offset)
 	if (unlikely(meta < xdp_frame_end ||
 		     meta > xdp->data))
 		return -EINVAL;
-	if (unlikely((metalen & (sizeof(__u32) - 1)) ||
-		     (metalen > 32)))
+	if (unlikely(xdp_metalen_valid(metalen)))
 		return -EACCES;
 
 	xdp->data_meta = meta;
-- 
2.31.1

