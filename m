Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AD43ABF63
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 01:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhFQXbc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 19:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhFQXba (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 19:31:30 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B756C06175F
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 16:29:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e20so6272628pgg.0
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 16:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xjpoa61ZTxipIDKq4XajXOdTT5GeGdioeudpYkrdJnY=;
        b=Bof9ApXBy9tbESBu0GRdsqA9hKi3bRaOSDSdSljzDJr33Ya3Zcl0MSNF2hJEJlMBhm
         QTSqa6LWOdTV4pPQfm3YJeWvrvL7G9tVHfesEE7TDzwOmLwaOt6cAkq4Rzw7PvqJ5Cqv
         xYQHgudK2wry2C8HuE4jJqEZFVW4U0aXYDLSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xjpoa61ZTxipIDKq4XajXOdTT5GeGdioeudpYkrdJnY=;
        b=JcpxYg8G4OeVVKaUcdg7IR6k3wkvXwKYkIwQrKOXfpRp/miNunsthK0rT7b9E4laU2
         F2J0NOqRHC08t1kTNeduIkK4ELNnguSB3zGLr3iXzjUnICPEWXz3/ClEgSYj34zeJwaL
         e4STZKPVllxRm0F+SAEgGmgT7Wkhjxs+Xubp1KY5rT701WdEGQThWhT6H9GmgGbY4zgl
         I0VYNOzwbRikweSJX2uHTyTX/FcqmQpYIIyZwCUN/Mo6WtEPaMWwELJPCCRWPVf/9MjL
         DPVdf8omERGIuz0GT7rih8/ty+h1qtD+Fquzs7msb958g9Rl3TKncqyssr0xY1TmzBiy
         kJ0Q==
X-Gm-Message-State: AOAM533ic5ym2TrZaOGUup+DNtCfRp1mhcOwQCLCB435pzyPouxusx/M
        IfvrIeHY7Qie+w3VLv6sD9tEG6kJD40VsQ==
X-Google-Smtp-Source: ABdhPJwceMLr0fbPxEZYuvZmziSd6wcLMwaZGbNO4+x/lCBxE0HWZjTBNt7OVNS3VpmP6Xd3KhWSbw==
X-Received: by 2002:a63:f4b:: with SMTP id 11mr7189407pgp.250.1623972559595;
        Thu, 17 Jun 2021 16:29:19 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id a21sm6217241pfg.188.2021.06.17.16.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 16:29:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 1/4] bpf: add function for XDP meta data length check
Date:   Thu, 17 Jun 2021 23:29:01 +0000
Message-Id: <20210617232904.1899-2-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617232904.1899-1-zeffron@riotgames.com>
References: <20210617232904.1899-1-zeffron@riotgames.com>
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

