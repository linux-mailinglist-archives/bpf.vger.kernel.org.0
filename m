Return-Path: <bpf+bounces-17769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACE28124F2
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 03:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E69C281EDD
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B05F184E;
	Thu, 14 Dec 2023 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qW3vVudk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B34E3
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 18:05:41 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dbcb5eb96f7so3175162276.3
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 18:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702519541; x=1703124341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUMRyPJzc2KBqp9rlzOcicivZPWQYvb+p95UviyM3iw=;
        b=qW3vVudkKPZkrIl4lSqOEBWzGXIXm+KfTxXAmnZOhyb+LVRpDJhL/I1/RWb3Hy78sB
         KSX8LJbepxT0v0PNXcW8ObGJXbYtDniQJOKuqYsa9yR8Tp5MOcxe04Jp9Hq6EnWoz/lT
         u6TSX1O2G1QAyhmTlKDVhxdFh8WdFCidIrTXAYup/2Lbz808ly+rcW3KbHNK7ZfEMj1v
         +5RpvhhysARKAH9PGpsR+Xmt7hDVAQ3VB4Vn0dPqBBkWv85Jl+axtLFv87pdpz9ZPQc7
         HgtFFAgnqhqZ6OamNPXa8CD0864tKU8ei4M+OGUCUu6l6X5YZSLKiIt4bHPMxgHzajDN
         6dzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702519541; x=1703124341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUMRyPJzc2KBqp9rlzOcicivZPWQYvb+p95UviyM3iw=;
        b=nnBEOdkx2lRftbtlM3ch1gB8GATbTFZ6fZM5aveK3yFNApVlOWtJqAUbQSkC2izZQo
         eUUmux8U/GNuyYC+5gpMimyLlqO2RAwjKXeoleRYKES5QY4PsoF73iK/47DylkPAm/tW
         vJSFu5bj2DMD1SHzkubHm+4w/hFTo7m/UNZ60rCU9rfpeq0czat0BipWF7hWGZ1s6Qky
         +WFwwjiQeBNCJI0QVnHEuuLUN3cMvXMsYxgeKxmXvpbQ58XUNIjP07JW9iC1JPF/20h4
         GohGyA9scnFApVmzgfgxylfUDn4XpoJIkyxkUtQ3tPy2KacnVygcvr1h9ra0HsnU7LUE
         vVLQ==
X-Gm-Message-State: AOJu0YysTGM2lk1M1mOxf9I0cqx3+4EG0QzorFzdh7dKw/xQQr8sm/xF
	jBZpFTDuOGKWV2u078tggCqnq4qUsPOLhRURkg==
X-Google-Smtp-Source: AGHT+IET8r8BI9pfqS6KupRcShXv+0eu0hJA4DOJcShMg+bVFuCr5TXdWqpVc1aC50PtBVwEg1I8t4qSWt8xl7gpAg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:d31b:c1a:fb6a:2488])
 (user=almasrymina job=sendgmr) by 2002:a25:c0d4:0:b0:dbc:b692:65a7 with SMTP
 id c203-20020a25c0d4000000b00dbcb69265a7mr49497ybf.10.1702519540921; Wed, 13
 Dec 2023 18:05:40 -0800 (PST)
Date: Wed, 13 Dec 2023 18:05:26 -0800
In-Reply-To: <20231214020530.2267499-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214020530.2267499-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214020530.2267499-4-almasrymina@google.com>
Subject: [RFC PATCH net-next v1 3/4] net: add netmem_t to skb_frag_t
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Michael Chan <michael.chan@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, 
	Russell King <linux@armlinux.org.uk>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Jassi Brar <jaswinder.singh@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Ronak Doshi <doshir@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Shakeel Butt <shakeelb@google.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Use netmem_t instead of page directly in skb_frag_t. Currently netmem_t
is always a struct page underneath, but the abstraction allows efforts
to add support for skb frags not backed by pages.

There is unfortunately 1 instance where the skb_frag_t is assumed to be
a bio_vec in kcm. For this case, add a debug assert that the skb frag is
indeed backed by a page, and do a cast.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/linux/skbuff.h | 11 ++++++++---
 net/kcm/kcmsock.c      |  9 +++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b370eb8d70f7..6d681c40213c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -37,6 +37,7 @@
 #endif
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <net/netmem.h>
 
 /**
  * DOC: skb checksums
@@ -359,7 +360,11 @@ extern int sysctl_max_skb_frags;
  */
 #define GSO_BY_FRAGS	0xFFFF
 
-typedef struct bio_vec skb_frag_t;
+typedef struct skb_frag {
+	struct netmem *bv_page;
+	unsigned int bv_len;
+	unsigned int bv_offset;
+} skb_frag_t;
 
 /**
  * skb_frag_size() - Returns the size of a skb fragment
@@ -2435,7 +2440,7 @@ static inline void skb_frag_fill_page_desc(skb_frag_t *frag,
 					   struct page *page,
 					   int off, int size)
 {
-	frag->bv_page = page;
+	frag->bv_page = page_to_netmem(page);
 	frag->bv_offset = off;
 	skb_frag_size_set(frag, size);
 }
@@ -3422,7 +3427,7 @@ static inline void skb_frag_off_copy(skb_frag_t *fragto,
  */
 static inline struct page *skb_frag_page(const skb_frag_t *frag)
 {
-	return frag->bv_page;
+	return netmem_to_page(frag->bv_page);
 }
 
 /**
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 65d1f6755f98..926349eeeaf6 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -636,9 +636,14 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			msize += skb_shinfo(skb)->frags[i].bv_len;
 
+		/* The cast to struct bio_vec* here assumes the frags are
+		 * struct page based.
+		 */
+		DEBUG_NET_WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->frags[0]));
+
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
-			      skb_shinfo(skb)->frags, skb_shinfo(skb)->nr_frags,
-			      msize);
+			      (const struct bio_vec *)skb_shinfo(skb)->frags,
+			      skb_shinfo(skb)->nr_frags, msize);
 		iov_iter_advance(&msg.msg_iter, txm->frag_offset);
 
 		do {
-- 
2.43.0.472.g3155946c3a-goog


