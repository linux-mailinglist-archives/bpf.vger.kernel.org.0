Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19AC37FBF5
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 18:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhEMRA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 13:00:59 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:44810 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhEMRAw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 13:00:52 -0400
Received: by mail-ej1-f50.google.com with SMTP id gx5so40797174ejb.11;
        Thu, 13 May 2021 09:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NpvO6mejm2YD3XXfyOawknELXlmCuYeK+r5UZXV1Uw=;
        b=PTWhnKHxTzd/3QqPuqNLl1+gaySGRv0XkJljkuMf9+QNWaMYDCoIJCM4wNCUoc5ZwM
         ZktmA4Um6inX1+e5nVFo+FcdiKOr/bWX3mQGhJ9xBuuOEovWozcnjkiJwR1Eq11wx/Wk
         Wkew4vEvTkt1WGbTzfV67r17hC4bYpKSuwevVXmP+n/XaUP3ltxu8V05nDxTV/fNSE2Y
         RO2fd74JXTOJV0CK+vv8UakyIqT7UO9L0ZGGkf1VjkUtIlnX4toYtY+03acdjIQCjP8J
         4kI/6scPjEiOy0Zxio0pvIb2ETSadPKD+Q74yBIYgQxWBc0m3+DlJxrmwYA3C6xiaR3L
         SJxw==
X-Gm-Message-State: AOAM531mFwxTHYbKlXVL8uwgnYKMlCKNSTB+c3NQwxpyPgzXjoo/X5Kd
        5844omqbqw4UWQLWFvLFPDaSjE3309N4ZDEM
X-Google-Smtp-Source: ABdhPJxJKQlIvhD1ypfnRzHdTpjgOE9oL/IlTH2hn9u8CU1UrChIiimBznBhdREbtK+qU5ujn2Hhmw==
X-Received: by 2002:a17:907:7216:: with SMTP id dr22mr44771734ejc.185.1620925180980;
        Thu, 13 May 2021 09:59:40 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-5-94-253-60.cust.vodafonedsl.it. [5.94.253.60])
        by smtp.gmail.com with ESMTPSA id w11sm2959431ede.54.2021.05.13.09.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 09:59:40 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     netdev@vger.kernel.org, linux-mm@kvack.org
Cc:     Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Boris Pismenny <borisp@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
        Will Deacon <will@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Roman Gushchin <guro@fb.com>, Hugh Dickins <hughd@google.com>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Cong Wang <cong.wang@bytedance.com>, wenxu <wenxu@ucloud.cn>,
        Kevin Hao <haokexin@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        bpf@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>
Subject: [PATCH net-next v5 2/5] skbuff: add a parameter to __skb_frag_unref
Date:   Thu, 13 May 2021 18:58:43 +0200
Message-Id: <20210513165846.23722-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513165846.23722-1-mcroce@linux.microsoft.com>
References: <20210513165846.23722-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

This is a prerequisite patch, the next one is enabling recycling of
skbs and fragments. Add an extra argument on __skb_frag_unref() to
handle recycling, and update the current users of the function with that.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 drivers/net/ethernet/marvell/sky2.c        | 2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 2 +-
 include/linux/skbuff.h                     | 8 +++++---
 net/core/skbuff.c                          | 4 ++--
 net/tls/tls_device.c                       | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 222c32367b2c..aa0cde1dc5c0 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -2503,7 +2503,7 @@ static void skb_put_frags(struct sk_buff *skb, unsigned int hdr_space,
 
 		if (length == 0) {
 			/* don't need this page */
-			__skb_frag_unref(frag);
+			__skb_frag_unref(frag, false);
 			--skb_shinfo(skb)->nr_frags;
 		} else {
 			size = min(length, (unsigned) PAGE_SIZE);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index e35e4d7ef4d1..cea62b8f554c 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -526,7 +526,7 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
 fail:
 	while (nr > 0) {
 		nr--;
-		__skb_frag_unref(skb_shinfo(skb)->frags + nr);
+		__skb_frag_unref(skb_shinfo(skb)->frags + nr, false);
 	}
 	return 0;
 }
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index dbf820a50a39..7fcfea7e7b21 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3081,10 +3081,12 @@ static inline void skb_frag_ref(struct sk_buff *skb, int f)
 /**
  * __skb_frag_unref - release a reference on a paged fragment.
  * @frag: the paged fragment
+ * @recycle: recycle the page if allocated via page_pool
  *
- * Releases a reference on the paged fragment @frag.
+ * Releases a reference on the paged fragment @frag
+ * or recycles the page via the page_pool API.
  */
-static inline void __skb_frag_unref(skb_frag_t *frag)
+static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
 {
 	put_page(skb_frag_page(frag));
 }
@@ -3098,7 +3100,7 @@ static inline void __skb_frag_unref(skb_frag_t *frag)
  */
 static inline void skb_frag_unref(struct sk_buff *skb, int f)
 {
-	__skb_frag_unref(&skb_shinfo(skb)->frags[f]);
+	__skb_frag_unref(&skb_shinfo(skb)->frags[f], false);
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3ad22870298c..12b7e90dd2b5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -664,7 +664,7 @@ static void skb_release_data(struct sk_buff *skb)
 	skb_zcopy_clear(skb, true);
 
 	for (i = 0; i < shinfo->nr_frags; i++)
-		__skb_frag_unref(&shinfo->frags[i]);
+		__skb_frag_unref(&shinfo->frags[i], false);
 
 	if (shinfo->frag_list)
 		kfree_skb_list(shinfo->frag_list);
@@ -3495,7 +3495,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 		fragto = &skb_shinfo(tgt)->frags[merge];
 
 		skb_frag_size_add(fragto, skb_frag_size(fragfrom));
-		__skb_frag_unref(fragfrom);
+		__skb_frag_unref(fragfrom, false);
 	}
 
 	/* Reposition in the original skb */
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 76a6f8c2eec4..ad11db2c4f63 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -127,7 +127,7 @@ static void destroy_record(struct tls_record_info *record)
 	int i;
 
 	for (i = 0; i < record->num_frags; i++)
-		__skb_frag_unref(&record->frags[i]);
+		__skb_frag_unref(&record->frags[i], false);
 	kfree(record);
 }
 
-- 
2.31.1

