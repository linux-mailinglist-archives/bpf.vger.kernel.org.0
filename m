Return-Path: <bpf+bounces-17770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963CC8124F6
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 03:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B33428209E
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F69EA3;
	Thu, 14 Dec 2023 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyjNwApW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B900E8
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 18:05:44 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5e302b65cc7so8334787b3.1
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 18:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702519543; x=1703124343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUHNM84aY8bG1LONwHsP22xk6JoFkZxhjeLJi0hGskg=;
        b=hyjNwApWA7SKLTPSJVh0jfKdMFRiadOxZOwaOXmi0tgr35njGncZrFAW5A5zaHzUki
         XaTVTsrV3XRI/QAIi6x058hg7Z4Wj1dfo4PHZZfOP67Rz1OrQK0mQq6VLG/oQ3fn/uO8
         PFmrJB7b4/w1O39ZvwoxSrTPXpAPFPKtZYF8P3AAp4+2VZrJpwvPXoPGNJWeX2BvwZ2d
         KrHWXt86pYD5EaTx+kgSUNdRo0SrbZxSQhaWdaTz7ytVND4sCiznQE1H0lZUKnefW5Ux
         56ZuR6YVlhZpffTRFufpZF8exS6TtRw9GSy38iwH5bu8G0R1SxTK9mtAXYNy5nkTZyY8
         REVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702519543; x=1703124343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUHNM84aY8bG1LONwHsP22xk6JoFkZxhjeLJi0hGskg=;
        b=tkF+GGpRUAh6gzGXgLw/cEqQ+A0baGs+sWYgW+FIrmRJvKD5oxgR82tR0J3jGeqRbs
         dHw1gPM3Pg9rr8HrSxZu3yLmDzJpHvK8bOfMWq8xQXdrvvNubmN+nKhE8+hycyOACN+n
         JVexSBItZbf3XQzgaSLEtb8GHBoJW5O/fqoyLDROOd/BjBHlwT9JToL7bMn7i7znXuQG
         cy6Nmpx9h0OQ4lkX+D/V3wHGTq90duk3DNsCeTc+5/+pY93mbFJhTaYybI0e5KkfHCzY
         2sBhw1EYyhOU0Y7yV7si4CyzqGth4uTlXEMGplP8l5I1jK/jWu6k0CT5n+MXdI2EDPJs
         vNVg==
X-Gm-Message-State: AOJu0Yw7aJJU+UhWF0Y+q3KofFaxlu9J1aMWz7NRJpae/M5PyxBxj+PT
	ElYMjzUcu3rtB6xW9aWwEb0/7W5QPiZyjl5nAg==
X-Google-Smtp-Source: AGHT+IHL9bTDSelId43RHE3R2vaIHDYkHh5qttulZDOCmhkgdaYnPJXKhGJ3z5E1GjseILXVxNA9sIlle6yWXot0MQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:d31b:c1a:fb6a:2488])
 (user=almasrymina job=sendgmr) by 2002:a5b:787:0:b0:d9c:801c:4230 with SMTP
 id b7-20020a5b0787000000b00d9c801c4230mr92069ybq.5.1702519543403; Wed, 13 Dec
 2023 18:05:43 -0800 (PST)
Date: Wed, 13 Dec 2023 18:05:27 -0800
In-Reply-To: <20231214020530.2267499-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214020530.2267499-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214020530.2267499-5-almasrymina@google.com>
Subject: [RFC PATCH net-next v1 4/4] net: page_pool: use netmem_t instead of
 struct page in API
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

Replace struct page in the page_pool API with the new netmem_t.

Currently the changes are to the API layer only. The internals of the
page_pool & drivers still convert the netmem_t to a page and use it
regularly.

Drivers that don't support other memory types than page can still use
netmem_t as page only. Drivers that add support for other memory types
such as devmem TCP will need to be modified to use the generic netmem_t
rather than assuming the underlying memory is always a page.

Similarly, the page_pool (and future pools) that add support for
non-page memory will need to use the generic netmem_t. page_pools that
only support one memory type (page or otherwise) can use that memory
type internally, and convert it to netmem_t before delivering it to the
driver for a more consistent API exposed to the drivers.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 15 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  8 ++-
 drivers/net/ethernet/engleder/tsnep_main.c    | 22 +++---
 drivers/net/ethernet/freescale/fec_main.c     | 33 ++++++---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 14 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 15 ++--
 drivers/net/ethernet/marvell/mvneta.c         | 24 ++++---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 18 +++--
 .../marvell/octeontx2/nic/otx2_common.c       |  8 ++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 22 +++---
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 27 ++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 28 ++++----
 .../ethernet/microchip/lan966x/lan966x_fdma.c | 16 +++--
 drivers/net/ethernet/microsoft/mana/mana_en.c | 10 +--
 drivers/net/ethernet/socionext/netsec.c       | 25 ++++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 48 ++++++++-----
 drivers/net/ethernet/ti/cpsw.c                | 11 +--
 drivers/net/ethernet/ti/cpsw_new.c            | 11 +--
 drivers/net/ethernet/ti/cpsw_priv.c           | 12 ++--
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 18 +++--
 drivers/net/veth.c                            |  5 +-
 drivers/net/vmxnet3/vmxnet3_drv.c             |  7 +-
 drivers/net/vmxnet3/vmxnet3_xdp.c             | 20 +++---
 drivers/net/wireless/mediatek/mt76/dma.c      |  4 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  5 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  4 +-
 drivers/net/xen-netfront.c                    |  4 +-
 include/net/page_pool/helpers.h               | 72 ++++++++++---------
 include/net/page_pool/types.h                 |  9 +--
 net/bpf/test_run.c                            |  2 +-
 net/core/page_pool.c                          | 39 +++++-----
 net/core/skbuff.c                             |  2 +-
 net/core/xdp.c                                |  3 +-
 34 files changed, 330 insertions(+), 233 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index be3fa0545fdc..9e37da8ed389 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -807,16 +807,17 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 	struct page *page;
 
 	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
-		page = page_pool_dev_alloc_frag(rxr->page_pool, offset,
-						BNXT_RX_PAGE_SIZE);
+		page = netmem_to_page(page_pool_dev_alloc_frag(rxr->page_pool,
+							       offset,
+							       BNXT_RX_PAGE_SIZE));
 	} else {
-		page = page_pool_dev_alloc_pages(rxr->page_pool);
+		page = netmem_to_page(page_pool_dev_alloc_pages(rxr->page_pool));
 		*offset = 0;
 	}
 	if (!page)
 		return NULL;
 
-	*mapping = page_pool_get_dma_addr(page) + *offset;
+	*mapping = page_pool_get_dma_addr(page_to_netmem(page)) + *offset;
 	return page;
 }
 
@@ -1040,7 +1041,7 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 				bp->rx_dir);
 	skb = napi_build_skb(data_ptr - bp->rx_offset, BNXT_RX_PAGE_SIZE);
 	if (!skb) {
-		page_pool_recycle_direct(rxr->page_pool, page);
+		page_pool_recycle_direct(rxr->page_pool, page_to_netmem(page));
 		return NULL;
 	}
 	skb_mark_for_recycle(skb);
@@ -1078,7 +1079,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 
 	skb = napi_alloc_skb(&rxr->bnapi->napi, payload);
 	if (!skb) {
-		page_pool_recycle_direct(rxr->page_pool, page);
+		page_pool_recycle_direct(rxr->page_pool, page_to_netmem(page));
 		return NULL;
 	}
 
@@ -3283,7 +3284,7 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 		rx_agg_buf->page = NULL;
 		__clear_bit(i, rxr->rx_agg_bmap);
 
-		page_pool_recycle_direct(rxr->page_pool, page);
+		page_pool_recycle_direct(rxr->page_pool, page_to_netmem(page));
 	}
 
 skip_rx_agg_free:
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 037624f17aea..3b6b09f835e4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -161,7 +161,8 @@ void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 			for (j = 0; j < frags; j++) {
 				tx_cons = NEXT_TX(tx_cons);
 				tx_buf = &txr->tx_buf_ring[RING_TX(bp, tx_cons)];
-				page_pool_recycle_direct(rxr->page_pool, tx_buf->page);
+				page_pool_recycle_direct(rxr->page_pool,
+							 page_to_netmem(tx_buf->page));
 			}
 		} else {
 			bnxt_sched_reset_txr(bp, txr, tx_cons);
@@ -219,7 +220,7 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 	for (i = 0; i < shinfo->nr_frags; i++) {
 		struct page *page = skb_frag_page(&shinfo->frags[i]);
 
-		page_pool_recycle_direct(rxr->page_pool, page);
+		page_pool_recycle_direct(rxr->page_pool, page_to_netmem(page));
 	}
 	shinfo->nr_frags = 0;
 }
@@ -320,7 +321,8 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 
 		if (xdp_do_redirect(bp->dev, &xdp, xdp_prog)) {
 			trace_xdp_exception(bp->dev, xdp_prog, act);
-			page_pool_recycle_direct(rxr->page_pool, page);
+			page_pool_recycle_direct(rxr->page_pool,
+						 page_to_netmem(page));
 			return true;
 		}
 
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index df40c720e7b2..ce32dcf7c6f8 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -641,7 +641,7 @@ static int tsnep_xdp_tx_map(struct xdp_frame *xdpf, struct tsnep_tx *tx,
 		} else {
 			page = unlikely(frag) ? skb_frag_page(frag) :
 						virt_to_page(xdpf->data);
-			dma = page_pool_get_dma_addr(page);
+			dma = page_pool_get_dma_addr(page_to_netmem(page));
 			if (unlikely(frag))
 				dma += skb_frag_off(frag);
 			else
@@ -940,7 +940,8 @@ static void tsnep_rx_ring_cleanup(struct tsnep_rx *rx)
 	for (i = 0; i < TSNEP_RING_SIZE; i++) {
 		entry = &rx->entry[i];
 		if (!rx->xsk_pool && entry->page)
-			page_pool_put_full_page(rx->page_pool, entry->page,
+			page_pool_put_full_page(rx->page_pool,
+						page_to_netmem(entry->page),
 						false);
 		if (rx->xsk_pool && entry->xdp)
 			xsk_buff_free(entry->xdp);
@@ -1066,7 +1067,8 @@ static void tsnep_rx_free_page_buffer(struct tsnep_rx *rx)
 	 */
 	page = rx->page_buffer;
 	while (*page) {
-		page_pool_put_full_page(rx->page_pool, *page, false);
+		page_pool_put_full_page(rx->page_pool, page_to_netmem(*page),
+					false);
 		*page = NULL;
 		page++;
 	}
@@ -1080,7 +1082,8 @@ static int tsnep_rx_alloc_page_buffer(struct tsnep_rx *rx)
 	 * be filled completely
 	 */
 	for (i = 0; i < TSNEP_RING_SIZE - 1; i++) {
-		rx->page_buffer[i] = page_pool_dev_alloc_pages(rx->page_pool);
+		rx->page_buffer[i] =
+			netmem_to_page(page_pool_dev_alloc_pages(rx->page_pool));
 		if (!rx->page_buffer[i]) {
 			tsnep_rx_free_page_buffer(rx);
 
@@ -1096,7 +1099,7 @@ static void tsnep_rx_set_page(struct tsnep_rx *rx, struct tsnep_rx_entry *entry,
 {
 	entry->page = page;
 	entry->len = TSNEP_MAX_RX_BUF_SIZE;
-	entry->dma = page_pool_get_dma_addr(entry->page);
+	entry->dma = page_pool_get_dma_addr(page_to_netmem(entry->page));
 	entry->desc->rx = __cpu_to_le64(entry->dma + TSNEP_RX_OFFSET);
 }
 
@@ -1105,7 +1108,7 @@ static int tsnep_rx_alloc_buffer(struct tsnep_rx *rx, int index)
 	struct tsnep_rx_entry *entry = &rx->entry[index];
 	struct page *page;
 
-	page = page_pool_dev_alloc_pages(rx->page_pool);
+	page = netmem_to_page(page_pool_dev_alloc_pages(rx->page_pool));
 	if (unlikely(!page))
 		return -ENOMEM;
 	tsnep_rx_set_page(rx, entry, page);
@@ -1296,7 +1299,8 @@ static bool tsnep_xdp_run_prog(struct tsnep_rx *rx, struct bpf_prog *prog,
 		sync = xdp->data_end - xdp->data_hard_start -
 		       XDP_PACKET_HEADROOM;
 		sync = max(sync, length);
-		page_pool_put_page(rx->page_pool, virt_to_head_page(xdp->data),
+		page_pool_put_page(rx->page_pool,
+				   page_to_netmem(virt_to_head_page(xdp->data)),
 				   sync, true);
 		return true;
 	}
@@ -1400,7 +1404,7 @@ static void tsnep_rx_page(struct tsnep_rx *rx, struct napi_struct *napi,
 
 		napi_gro_receive(napi, skb);
 	} else {
-		page_pool_recycle_direct(rx->page_pool, page);
+		page_pool_recycle_direct(rx->page_pool, page_to_netmem(page));
 
 		rx->dropped++;
 	}
@@ -1599,7 +1603,7 @@ static int tsnep_rx_poll_zc(struct tsnep_rx *rx, struct napi_struct *napi,
 			}
 		}
 
-		page = page_pool_dev_alloc_pages(rx->page_pool);
+		page = netmem_to_page(page_pool_dev_alloc_pages(rx->page_pool));
 		if (page) {
 			memcpy(page_address(page) + TSNEP_RX_OFFSET,
 			       entry->xdp->data - TSNEP_RX_INLINE_METADATA_SIZE,
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index bae9536de767..4da3e6161a73 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -996,7 +996,9 @@ static void fec_enet_bd_init(struct net_device *dev)
 				struct page *page = txq->tx_buf[i].buf_p;
 
 				if (page)
-					page_pool_put_page(page->pp, page, 0, false);
+					page_pool_put_page(page->pp,
+							   page_to_netmem(page),
+							   0, false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1520,7 +1522,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			xdp_return_frame_rx_napi(xdpf);
 		} else { /* recycle pages of XDP_TX frames */
 			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
-			page_pool_put_page(page->pp, page, 0, true);
+			page_pool_put_page(page->pp, page_to_netmem(page), 0,
+					   true);
 		}
 
 		txq->tx_buf[index].buf_p = NULL;
@@ -1568,12 +1571,13 @@ static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	struct page *new_page;
 	dma_addr_t phys_addr;
 
-	new_page = page_pool_dev_alloc_pages(rxq->page_pool);
+	new_page = netmem_to_page(page_pool_dev_alloc_pages(rxq->page_pool));
 	WARN_ON(!new_page);
 	rxq->rx_skb_info[index].page = new_page;
 
 	rxq->rx_skb_info[index].offset = FEC_ENET_XDP_HEADROOM;
-	phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
+	phys_addr = page_pool_get_dma_addr(page_to_netmem(new_page)) +
+		    FEC_ENET_XDP_HEADROOM;
 	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 }
 
@@ -1633,7 +1637,8 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
 xdp_err:
 		ret = FEC_ENET_XDP_CONSUMED;
 		page = virt_to_head_page(xdp->data);
-		page_pool_put_page(rxq->page_pool, page, sync, true);
+		page_pool_put_page(rxq->page_pool, page_to_netmem(page), sync,
+				   true);
 		if (act != XDP_DROP)
 			trace_xdp_exception(fep->netdev, prog, act);
 		break;
@@ -1761,7 +1766,8 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 		 */
 		skb = build_skb(page_address(page), PAGE_SIZE);
 		if (unlikely(!skb)) {
-			page_pool_recycle_direct(rxq->page_pool, page);
+			page_pool_recycle_direct(rxq->page_pool,
+						 page_to_netmem(page));
 			ndev->stats.rx_dropped++;
 
 			netdev_err_once(ndev, "build_skb failed!\n");
@@ -3264,7 +3270,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	for (q = 0; q < fep->num_rx_queues; q++) {
 		rxq = fep->rx_queue[q];
 		for (i = 0; i < rxq->bd.ring_size; i++)
-			page_pool_put_full_page(rxq->page_pool, rxq->rx_skb_info[i].page, false);
+			page_pool_put_full_page(rxq->page_pool,
+						page_to_netmem(rxq->rx_skb_info[i].page),
+						false);
 
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
@@ -3293,7 +3301,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 			} else {
 				struct page *page = txq->tx_buf[i].buf_p;
 
-				page_pool_put_page(page->pp, page, 0, false);
+				page_pool_put_page(page->pp,
+						   page_to_netmem(page), 0,
+						   false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -3390,11 +3400,12 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	}
 
 	for (i = 0; i < rxq->bd.ring_size; i++) {
-		page = page_pool_dev_alloc_pages(rxq->page_pool);
+		page = netmem_to_page(page_pool_dev_alloc_pages(rxq->page_pool));
 		if (!page)
 			goto err_alloc;
 
-		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
+		phys_addr = page_pool_get_dma_addr(page_to_netmem(page)) +
+			    FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
 		rxq->rx_skb_info[i].page = page;
@@ -3856,7 +3867,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 		struct page *page;
 
 		page = virt_to_page(xdpb->data);
-		dma_addr = page_pool_get_dma_addr(page) +
+		dma_addr = page_pool_get_dma_addr(page_to_netmem(page)) +
 			   (xdpb->data - xdpb->data_hard_start);
 		dma_sync_single_for_device(&fep->pdev->dev, dma_addr,
 					   dma_sync_len, DMA_BIDIRECTIONAL);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index b618797a7e8d..0ab015cb1b51 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3371,15 +3371,15 @@ static int hns3_alloc_buffer(struct hns3_enet_ring *ring,
 	struct page *p;
 
 	if (ring->page_pool) {
-		p = page_pool_dev_alloc_frag(ring->page_pool,
-					     &cb->page_offset,
-					     hns3_buf_size(ring));
+		p = netmem_to_page(page_pool_dev_alloc_frag(ring->page_pool,
+							    &cb->page_offset,
+							    hns3_buf_size(ring)));
 		if (unlikely(!p))
 			return -ENOMEM;
 
 		cb->priv = p;
 		cb->buf = page_address(p);
-		cb->dma = page_pool_get_dma_addr(p);
+		cb->dma = page_pool_get_dma_addr(page_to_netmem(p));
 		cb->type = DESC_TYPE_PP_FRAG;
 		cb->reuse_flag = 0;
 		return 0;
@@ -3411,7 +3411,8 @@ static void hns3_free_buffer(struct hns3_enet_ring *ring,
 		if (cb->type & DESC_TYPE_PAGE && cb->pagecnt_bias)
 			__page_frag_cache_drain(cb->priv, cb->pagecnt_bias);
 		else if (cb->type & DESC_TYPE_PP_FRAG)
-			page_pool_put_full_page(ring->page_pool, cb->priv,
+			page_pool_put_full_page(ring->page_pool,
+						page_to_netmem(cb->priv),
 						false);
 	}
 	memset(cb, 0, sizeof(*cb));
@@ -4058,7 +4059,8 @@ static int hns3_alloc_skb(struct hns3_enet_ring *ring, unsigned int length,
 		if (dev_page_is_reusable(desc_cb->priv))
 			desc_cb->reuse_flag = 1;
 		else if (desc_cb->type & DESC_TYPE_PP_FRAG)
-			page_pool_put_full_page(ring->page_pool, desc_cb->priv,
+			page_pool_put_full_page(ring->page_pool,
+						page_to_netmem(desc_cb->priv),
 						false);
 		else /* This page cannot be reused so discard it */
 			__page_frag_cache_drain(desc_cb->priv,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 1f728a9004d9..bcef8b49652a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -336,7 +336,7 @@ static void idpf_rx_page_rel(struct idpf_queue *rxq, struct idpf_rx_buf *rx_buf)
 	if (unlikely(!rx_buf->page))
 		return;
 
-	page_pool_put_full_page(rxq->pp, rx_buf->page, false);
+	page_pool_put_full_page(rxq->pp, page_to_netmem(rx_buf->page), false);
 
 	rx_buf->page = NULL;
 	rx_buf->page_offset = 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index df76493faa75..5efe4920326b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -932,18 +932,19 @@ static inline dma_addr_t idpf_alloc_page(struct page_pool *pool,
 					 unsigned int buf_size)
 {
 	if (buf_size == IDPF_RX_BUF_2048)
-		buf->page = page_pool_dev_alloc_frag(pool, &buf->page_offset,
-						     buf_size);
+		buf->page = netmem_to_page(page_pool_dev_alloc_frag(pool,
+								    &buf->page_offset,
+								    buf_size));
 	else
-		buf->page = page_pool_dev_alloc_pages(pool);
+		buf->page = netmem_to_page(page_pool_dev_alloc_pages(pool));
 
 	if (!buf->page)
 		return DMA_MAPPING_ERROR;
 
 	buf->truesize = buf_size;
 
-	return page_pool_get_dma_addr(buf->page) + buf->page_offset +
-	       pool->p.offset;
+	return page_pool_get_dma_addr(page_to_netmem(buf->page)) +
+	       buf->page_offset + pool->p.offset;
 }
 
 /**
@@ -952,7 +953,7 @@ static inline dma_addr_t idpf_alloc_page(struct page_pool *pool,
  */
 static inline void idpf_rx_put_page(struct idpf_rx_buf *rx_buf)
 {
-	page_pool_put_page(rx_buf->page->pp, rx_buf->page,
+	page_pool_put_page(rx_buf->page->pp, page_to_netmem(rx_buf->page),
 			   rx_buf->truesize, true);
 	rx_buf->page = NULL;
 }
@@ -968,7 +969,7 @@ static inline void idpf_rx_sync_for_cpu(struct idpf_rx_buf *rx_buf, u32 len)
 	struct page_pool *pp = page->pp;
 
 	dma_sync_single_range_for_cpu(pp->p.dev,
-				      page_pool_get_dma_addr(page),
+				      page_pool_get_dma_addr(page_to_netmem(page)),
 				      rx_buf->page_offset + pp->p.offset, len,
 				      page_pool_get_dma_dir(pp));
 }
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 29aac327574d..f20c09fa6764 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1940,12 +1940,13 @@ static int mvneta_rx_refill(struct mvneta_port *pp,
 	dma_addr_t phys_addr;
 	struct page *page;
 
-	page = page_pool_alloc_pages(rxq->page_pool,
-				     gfp_mask | __GFP_NOWARN);
+	page = netmem_to_page(page_pool_alloc_pages(rxq->page_pool,
+						    gfp_mask | __GFP_NOWARN));
 	if (!page)
 		return -ENOMEM;
 
-	phys_addr = page_pool_get_dma_addr(page) + pp->rx_offset_correction;
+	phys_addr = page_pool_get_dma_addr(page_to_netmem(page)) +
+		    pp->rx_offset_correction;
 	mvneta_rx_desc_fill(rx_desc, phys_addr, page, rxq);
 
 	return 0;
@@ -2013,7 +2014,8 @@ static void mvneta_rxq_drop_pkts(struct mvneta_port *pp,
 		if (!data || !(rx_desc->buf_phys_addr))
 			continue;
 
-		page_pool_put_full_page(rxq->page_pool, data, false);
+		page_pool_put_full_page(rxq->page_pool, page_to_netmem(data),
+					false);
 	}
 	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
 		xdp_rxq_info_unreg(&rxq->xdp_rxq);
@@ -2080,10 +2082,12 @@ mvneta_xdp_put_buff(struct mvneta_port *pp, struct mvneta_rx_queue *rxq,
 
 	for (i = 0; i < sinfo->nr_frags; i++)
 		page_pool_put_full_page(rxq->page_pool,
-					skb_frag_page(&sinfo->frags[i]), true);
+					page_to_netmem(skb_frag_page(&sinfo->frags[i])),
+					true);
 
 out:
-	page_pool_put_page(rxq->page_pool, virt_to_head_page(xdp->data),
+	page_pool_put_page(rxq->page_pool,
+			   page_to_netmem(virt_to_head_page(xdp->data)),
 			   sync_len, true);
 }
 
@@ -2132,7 +2136,7 @@ mvneta_xdp_submit_frame(struct mvneta_port *pp, struct mvneta_tx_queue *txq,
 		} else {
 			page = unlikely(frag) ? skb_frag_page(frag)
 					      : virt_to_page(xdpf->data);
-			dma_addr = page_pool_get_dma_addr(page);
+			dma_addr = page_pool_get_dma_addr(page_to_netmem(page));
 			if (unlikely(frag))
 				dma_addr += skb_frag_off(frag);
 			else
@@ -2386,7 +2390,8 @@ mvneta_swbm_add_rx_fragment(struct mvneta_port *pp,
 		if (page_is_pfmemalloc(page))
 			xdp_buff_set_frag_pfmemalloc(xdp);
 	} else {
-		page_pool_put_full_page(rxq->page_pool, page, true);
+		page_pool_put_full_page(rxq->page_pool, page_to_netmem(page),
+					true);
 	}
 	*size -= len;
 }
@@ -2471,7 +2476,8 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 		} else {
 			if (unlikely(!xdp_buf.data_hard_start)) {
 				rx_desc->buf_phys_addr = 0;
-				page_pool_put_full_page(rxq->page_pool, page,
+				page_pool_put_full_page(rxq->page_pool,
+							page_to_netmem(page),
 							true);
 				goto next;
 			}
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 93137606869e..32ae784b1484 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -361,7 +361,7 @@ static void *mvpp2_frag_alloc(const struct mvpp2_bm_pool *pool,
 			      struct page_pool *page_pool)
 {
 	if (page_pool)
-		return page_pool_dev_alloc_pages(page_pool);
+		return netmem_to_page(page_pool_dev_alloc_pages(page_pool));
 
 	if (likely(pool->frag_size <= PAGE_SIZE))
 		return netdev_alloc_frag(pool->frag_size);
@@ -373,7 +373,9 @@ static void mvpp2_frag_free(const struct mvpp2_bm_pool *pool,
 			    struct page_pool *page_pool, void *data)
 {
 	if (page_pool)
-		page_pool_put_full_page(page_pool, virt_to_head_page(data), false);
+		page_pool_put_full_page(page_pool,
+					page_to_netmem(virt_to_head_page(data)),
+					false);
 	else if (likely(pool->frag_size <= PAGE_SIZE))
 		skb_free_frag(data);
 	else
@@ -750,7 +752,7 @@ static void *mvpp2_buf_alloc(struct mvpp2_port *port,
 
 	if (page_pool) {
 		page = (struct page *)data;
-		dma_addr = page_pool_get_dma_addr(page);
+		dma_addr = page_pool_get_dma_addr(page_to_netmem(page));
 		data = page_to_virt(page);
 	} else {
 		dma_addr = dma_map_single(port->dev->dev.parent, data,
@@ -3687,7 +3689,7 @@ mvpp2_xdp_submit_frame(struct mvpp2_port *port, u16 txq_id,
 		/* XDP_TX */
 		struct page *page = virt_to_page(xdpf->data);
 
-		dma_addr = page_pool_get_dma_addr(page) +
+		dma_addr = page_pool_get_dma_addr(page_to_netmem(page)) +
 			   sizeof(*xdpf) + xdpf->headroom;
 		dma_sync_single_for_device(port->dev->dev.parent, dma_addr,
 					   xdpf->len, DMA_BIDIRECTIONAL);
@@ -3809,7 +3811,8 @@ mvpp2_run_xdp(struct mvpp2_port *port, struct bpf_prog *prog,
 		if (unlikely(err)) {
 			ret = MVPP2_XDP_DROPPED;
 			page = virt_to_head_page(xdp->data);
-			page_pool_put_page(pp, page, sync, true);
+			page_pool_put_page(pp, page_to_netmem(page), sync,
+					   true);
 		} else {
 			ret = MVPP2_XDP_REDIR;
 			stats->xdp_redirect++;
@@ -3819,7 +3822,8 @@ mvpp2_run_xdp(struct mvpp2_port *port, struct bpf_prog *prog,
 		ret = mvpp2_xdp_xmit_back(port, xdp);
 		if (ret != MVPP2_XDP_TX) {
 			page = virt_to_head_page(xdp->data);
-			page_pool_put_page(pp, page, sync, true);
+			page_pool_put_page(pp, page_to_netmem(page), sync,
+					   true);
 		}
 		break;
 	default:
@@ -3830,7 +3834,7 @@ mvpp2_run_xdp(struct mvpp2_port *port, struct bpf_prog *prog,
 		fallthrough;
 	case XDP_DROP:
 		page = virt_to_head_page(xdp->data);
-		page_pool_put_page(pp, page, sync, true);
+		page_pool_put_page(pp, page_to_netmem(page), sync, true);
 		ret = MVPP2_XDP_DROPPED;
 		stats->xdp_drop++;
 		break;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 7ca6941ea0b9..bbff52a24cab 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -530,11 +530,12 @@ static int otx2_alloc_pool_buf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 	sz = SKB_DATA_ALIGN(pool->rbsize);
 	sz = ALIGN(sz, OTX2_ALIGN);
 
-	page = page_pool_alloc_frag(pool->page_pool, &offset, sz, GFP_ATOMIC);
+	page = netmem_to_page(page_pool_alloc_frag(pool->page_pool,
+						   &offset, sz, GFP_ATOMIC));
 	if (unlikely(!page))
 		return -ENOMEM;
 
-	*dma = page_pool_get_dma_addr(page) + offset;
+	*dma = page_pool_get_dma_addr(page_to_netmem(page)) + offset;
 	return 0;
 }
 
@@ -1208,7 +1209,8 @@ void otx2_free_bufs(struct otx2_nic *pfvf, struct otx2_pool *pool,
 	page = virt_to_head_page(phys_to_virt(pa));
 
 	if (pool->page_pool) {
-		page_pool_put_full_page(pool->page_pool, page, true);
+		page_pool_put_full_page(pool->page_pool, page_to_netmem(page),
+					true);
 	} else {
 		dma_unmap_page_attrs(pfvf->dev, iova, size,
 				     DMA_FROM_DEVICE,
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index a6e91573f8da..68146071a919 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1735,11 +1735,13 @@ static void *mtk_page_pool_get_buff(struct page_pool *pp, dma_addr_t *dma_addr,
 {
 	struct page *page;
 
-	page = page_pool_alloc_pages(pp, gfp_mask | __GFP_NOWARN);
+	page = netmem_to_page(page_pool_alloc_pages(pp,
+						    gfp_mask | __GFP_NOWARN));
 	if (!page)
 		return NULL;
 
-	*dma_addr = page_pool_get_dma_addr(page) + MTK_PP_HEADROOM;
+	*dma_addr =
+		page_pool_get_dma_addr(page_to_netmem(page)) + MTK_PP_HEADROOM;
 	return page_address(page);
 }
 
@@ -1747,7 +1749,8 @@ static void mtk_rx_put_buff(struct mtk_rx_ring *ring, void *data, bool napi)
 {
 	if (ring->page_pool)
 		page_pool_put_full_page(ring->page_pool,
-					virt_to_head_page(data), napi);
+					page_to_netmem(virt_to_head_page(data)),
+					napi);
 	else
 		skb_free_frag(data);
 }
@@ -1771,7 +1774,7 @@ static int mtk_xdp_frame_map(struct mtk_eth *eth, struct net_device *dev,
 	} else {
 		struct page *page = virt_to_head_page(data);
 
-		txd_info->addr = page_pool_get_dma_addr(page) +
+		txd_info->addr = page_pool_get_dma_addr(page_to_netmem(page)) +
 				 sizeof(struct xdp_frame) + headroom;
 		dma_sync_single_for_device(eth->dma_dev, txd_info->addr,
 					   txd_info->size, DMA_BIDIRECTIONAL);
@@ -1985,7 +1988,8 @@ static u32 mtk_xdp_run(struct mtk_eth *eth, struct mtk_rx_ring *ring,
 	}
 
 	page_pool_put_full_page(ring->page_pool,
-				virt_to_head_page(xdp->data), true);
+				page_to_netmem(virt_to_head_page(xdp->data)),
+				true);
 
 update_stats:
 	u64_stats_update_begin(&hw_stats->syncp);
@@ -2074,8 +2078,9 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			}
 
 			dma_sync_single_for_cpu(eth->dma_dev,
-				page_pool_get_dma_addr(page) + MTK_PP_HEADROOM,
-				pktlen, page_pool_get_dma_dir(ring->page_pool));
+						page_pool_get_dma_addr(page_to_netmem(page)) +
+						MTK_PP_HEADROOM,
+						pktlen, page_pool_get_dma_dir(ring->page_pool));
 
 			xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_q);
 			xdp_prepare_buff(&xdp, data, MTK_PP_HEADROOM, pktlen,
@@ -2092,7 +2097,8 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			skb = build_skb(data, PAGE_SIZE);
 			if (unlikely(!skb)) {
 				page_pool_put_full_page(ring->page_pool,
-							page, true);
+							page_to_netmem(page),
+							true);
 				netdev->stats.rx_dropped++;
 				goto skip_rx;
 			}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index e2e7d82cfca4..c8275e4b6cae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -122,7 +122,8 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 	 * mode.
 	 */
 
-	dma_addr = page_pool_get_dma_addr(page) + (xdpf->data - (void *)xdpf);
+	dma_addr = page_pool_get_dma_addr(page_to_netmem(page)) +
+		   (xdpf->data - (void *)xdpf);
 	dma_sync_single_for_device(sq->pdev, dma_addr, xdptxd->len, DMA_BIDIRECTIONAL);
 
 	if (xdptxd->has_frags) {
@@ -134,8 +135,8 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 			dma_addr_t addr;
 			u32 len;
 
-			addr = page_pool_get_dma_addr(skb_frag_page(frag)) +
-				skb_frag_off(frag);
+			addr = page_pool_get_dma_addr(page_to_netmem(skb_frag_page(frag))) +
+			       skb_frag_off(frag);
 			len = skb_frag_size(frag);
 			dma_sync_single_for_device(sq->pdev, addr, len,
 						   DMA_BIDIRECTIONAL);
@@ -458,9 +459,12 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
 
 			tmp.data = skb_frag_address(frag);
 			tmp.len = skb_frag_size(frag);
-			tmp.dma_addr = xdptxdf->dma_arr ? xdptxdf->dma_arr[0] :
-				page_pool_get_dma_addr(skb_frag_page(frag)) +
-				skb_frag_off(frag);
+			tmp.dma_addr =
+				xdptxdf->dma_arr ?
+					xdptxdf->dma_arr[0] :
+					page_pool_get_dma_addr(page_to_netmem(
+						skb_frag_page(frag))) +
+						skb_frag_off(frag);
 			p = &tmp;
 		}
 	}
@@ -607,9 +611,11 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 			skb_frag_t *frag = &xdptxdf->sinfo->frags[i];
 			dma_addr_t addr;
 
-			addr = xdptxdf->dma_arr ? xdptxdf->dma_arr[i] :
-				page_pool_get_dma_addr(skb_frag_page(frag)) +
-				skb_frag_off(frag);
+			addr = xdptxdf->dma_arr ?
+				       xdptxdf->dma_arr[i] :
+				       page_pool_get_dma_addr(page_to_netmem(
+					       skb_frag_page(frag))) +
+					       skb_frag_off(frag);
 
 			dseg->addr = cpu_to_be64(addr);
 			dseg->byte_count = cpu_to_be32(skb_frag_size(frag));
@@ -699,7 +705,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
 				 * as we know this is a page_pool page.
 				 */
-				page_pool_recycle_direct(page->pp, page);
+				page_pool_recycle_direct(page->pp,
+							 page_to_netmem(page));
 			} while (++n < num);
 
 			break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 8d9743a5e42c..73d41dc2b47e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -278,11 +278,11 @@ static int mlx5e_page_alloc_fragmented(struct mlx5e_rq *rq,
 {
 	struct page *page;
 
-	page = page_pool_dev_alloc_pages(rq->page_pool);
+	page = netmem_to_page(page_pool_dev_alloc_pages(rq->page_pool));
 	if (unlikely(!page))
 		return -ENOMEM;
 
-	page_pool_fragment_page(page, MLX5E_PAGECNT_BIAS_MAX);
+	page_pool_fragment_page(page_to_netmem(page), MLX5E_PAGECNT_BIAS_MAX);
 
 	*frag_page = (struct mlx5e_frag_page) {
 		.page	= page,
@@ -298,8 +298,9 @@ static void mlx5e_page_release_fragmented(struct mlx5e_rq *rq,
 	u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
 	struct page *page = frag_page->page;
 
-	if (page_pool_defrag_page(page, drain_count) == 0)
-		page_pool_put_defragged_page(rq->page_pool, page, -1, true);
+	if (page_pool_defrag_page(page_to_netmem(page), drain_count) == 0)
+		page_pool_put_defragged_page(rq->page_pool,
+					     page_to_netmem(page), -1, true);
 }
 
 static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
@@ -358,7 +359,7 @@ static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, struct mlx5e_rx_wqe_cyc *wqe,
 		frag->flags &= ~BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
 
 		headroom = i == 0 ? rq->buff.headroom : 0;
-		addr = page_pool_get_dma_addr(frag->frag_page->page);
+		addr = page_pool_get_dma_addr(page_to_netmem(frag->frag_page->page));
 		wqe->data[i].addr = cpu_to_be64(addr + frag->offset + headroom);
 	}
 
@@ -501,7 +502,8 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
 {
 	skb_frag_t *frag;
 
-	dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
+	dma_addr_t addr =
+		page_pool_get_dma_addr(page_to_netmem(frag_page->page));
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len, rq->buff.map_dir);
 	if (!xdp_buff_has_frags(xdp)) {
@@ -526,7 +528,7 @@ mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_buff *skb,
 		   struct page *page, u32 frag_offset, u32 len,
 		   unsigned int truesize)
 {
-	dma_addr_t addr = page_pool_get_dma_addr(page);
+	dma_addr_t addr = page_pool_get_dma_addr(page_to_netmem(page));
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len,
 				rq->buff.map_dir);
@@ -674,7 +676,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 			if (unlikely(err))
 				goto err_unmap;
 
-			addr = page_pool_get_dma_addr(frag_page->page);
+			addr = page_pool_get_dma_addr(page_to_netmem(frag_page->page));
 
 			dma_info->addr = addr;
 			dma_info->frag_page = frag_page;
@@ -786,7 +788,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 		err = mlx5e_page_alloc_fragmented(rq, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
-		addr = page_pool_get_dma_addr(frag_page->page);
+		addr = page_pool_get_dma_addr(page_to_netmem(frag_page->page));
 		umr_wqe->inline_mtts[i] = (struct mlx5_mtt) {
 			.ptag = cpu_to_be64(addr | MLX5_EN_WR),
 		};
@@ -1685,7 +1687,7 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr(page_to_netmem(frag_page->page));
 	dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
 				      frag_size, rq->buff.map_dir);
 	net_prefetch(data);
@@ -1738,7 +1740,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	va = page_address(frag_page->page) + wi->offset;
 	frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr(page_to_netmem(frag_page->page));
 	dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
 				      rq->buff.frame0_sz, rq->buff.map_dir);
 	net_prefetchw(va); /* xdp_frame data area */
@@ -2124,7 +2126,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			while (++pagep < frag_page);
 		}
 		/* copy header */
-		addr = page_pool_get_dma_addr(head_page->page);
+		addr = page_pool_get_dma_addr(page_to_netmem(head_page->page));
 		mlx5e_copy_skb_header(rq, skb, head_page->page, addr,
 				      head_offset, head_offset, headlen);
 		/* skb linear part was allocated with headlen and aligned to long */
@@ -2159,7 +2161,7 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr(page_to_netmem(frag_page->page));
 	dma_sync_single_range_for_cpu(rq->pdev, addr, head_offset,
 				      frag_size, rq->buff.map_dir);
 	net_prefetch(data);
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 3960534ac2ad..fdd4a9ccafd4 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -16,11 +16,12 @@ static struct page *lan966x_fdma_rx_alloc_page(struct lan966x_rx *rx,
 {
 	struct page *page;
 
-	page = page_pool_dev_alloc_pages(rx->page_pool);
+	page = netmem_to_page(page_pool_dev_alloc_pages(rx->page_pool));
 	if (unlikely(!page))
 		return NULL;
 
-	db->dataptr = page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM;
+	db->dataptr = page_pool_get_dma_addr(page_to_netmem(page)) +
+		      XDP_PACKET_HEADROOM;
 
 	return page;
 }
@@ -32,7 +33,8 @@ static void lan966x_fdma_rx_free_pages(struct lan966x_rx *rx)
 	for (i = 0; i < FDMA_DCB_MAX; ++i) {
 		for (j = 0; j < FDMA_RX_DCB_MAX_DBS; ++j)
 			page_pool_put_full_page(rx->page_pool,
-						rx->page[i][j], false);
+						page_to_netmem(rx->page[i][j]),
+						false);
 	}
 }
 
@@ -44,7 +46,7 @@ static void lan966x_fdma_rx_free_page(struct lan966x_rx *rx)
 	if (unlikely(!page))
 		return;
 
-	page_pool_recycle_direct(rx->page_pool, page);
+	page_pool_recycle_direct(rx->page_pool, page_to_netmem(page));
 }
 
 static void lan966x_fdma_rx_add_dcb(struct lan966x_rx *rx,
@@ -435,7 +437,7 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 				xdp_return_frame_bulk(dcb_buf->data.xdpf, &bq);
 			else
 				page_pool_recycle_direct(rx->page_pool,
-							 dcb_buf->data.page);
+							 page_to_netmem(dcb_buf->data.page));
 		}
 
 		clear = true;
@@ -537,7 +539,7 @@ static struct sk_buff *lan966x_fdma_rx_get_frame(struct lan966x_rx *rx,
 	return skb;
 
 free_page:
-	page_pool_recycle_direct(rx->page_pool, page);
+	page_pool_recycle_direct(rx->page_pool, page_to_netmem(page));
 
 	return NULL;
 }
@@ -765,7 +767,7 @@ int lan966x_fdma_xmit_xdpf(struct lan966x_port *port, void *ptr, u32 len)
 		lan966x_ifh_set_bypass(ifh, 1);
 		lan966x_ifh_set_port(ifh, BIT_ULL(port->chip_port));
 
-		dma_addr = page_pool_get_dma_addr(page);
+		dma_addr = page_pool_get_dma_addr(page_to_netmem(page));
 		dma_sync_single_for_device(lan966x->dev,
 					   dma_addr + XDP_PACKET_HEADROOM,
 					   len + IFH_LEN_BYTES,
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index cb7b9d8ef618..7172041076d8 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1587,7 +1587,7 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 drop:
 	if (from_pool) {
 		page_pool_recycle_direct(rxq->page_pool,
-					 virt_to_head_page(buf_va));
+					 page_to_netmem(virt_to_head_page(buf_va)));
 	} else {
 		WARN_ON_ONCE(rxq->xdp_save_va);
 		/* Save for reuse */
@@ -1627,7 +1627,7 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
 			return NULL;
 		}
 	} else {
-		page = page_pool_dev_alloc_pages(rxq->page_pool);
+		page = netmem_to_page(page_pool_dev_alloc_pages(rxq->page_pool));
 		if (!page)
 			return NULL;
 
@@ -1639,7 +1639,8 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
 			     DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, *da)) {
 		if (*from_pool)
-			page_pool_put_full_page(rxq->page_pool, page, false);
+			page_pool_put_full_page(rxq->page_pool,
+						page_to_netmem(page), false);
 		else
 			put_page(virt_to_head_page(va));
 
@@ -2027,7 +2028,8 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 		page = virt_to_head_page(rx_oob->buf_va);
 
 		if (rx_oob->from_pool)
-			page_pool_put_full_page(rxq->page_pool, page, false);
+			page_pool_put_full_page(rxq->page_pool,
+						page_to_netmem(page), false);
 		else
 			put_page(page);
 
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 5ab8b81b84e6..a573d1dead67 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -739,7 +739,7 @@ static void *netsec_alloc_rx_data(struct netsec_priv *priv,
 	struct netsec_desc_ring *dring = &priv->desc_ring[NETSEC_RING_RX];
 	struct page *page;
 
-	page = page_pool_dev_alloc_pages(dring->page_pool);
+	page = netmem_to_page(page_pool_dev_alloc_pages(dring->page_pool));
 	if (!page)
 		return NULL;
 
@@ -747,7 +747,8 @@ static void *netsec_alloc_rx_data(struct netsec_priv *priv,
 	 * page_pool API will map the whole page, skip what's needed for
 	 * network payloads and/or XDP
 	 */
-	*dma_handle = page_pool_get_dma_addr(page) + NETSEC_RXBUF_HEADROOM;
+	*dma_handle = page_pool_get_dma_addr(page_to_netmem(page)) +
+		      NETSEC_RXBUF_HEADROOM;
 	/* Make sure the incoming payload fits in the page for XDP and non-XDP
 	 * cases and reserve enough space for headroom + skb_shared_info
 	 */
@@ -862,8 +863,8 @@ static u32 netsec_xdp_queue_one(struct netsec_priv *priv,
 		enum dma_data_direction dma_dir =
 			page_pool_get_dma_dir(rx_ring->page_pool);
 
-		dma_handle = page_pool_get_dma_addr(page) + xdpf->headroom +
-			sizeof(*xdpf);
+		dma_handle = page_pool_get_dma_addr(page_to_netmem(page)) +
+			     xdpf->headroom + sizeof(*xdpf);
 		dma_sync_single_for_device(priv->dev, dma_handle, xdpf->len,
 					   dma_dir);
 		tx_desc.buf_type = TYPE_NETSEC_XDP_TX;
@@ -919,7 +920,8 @@ static u32 netsec_run_xdp(struct netsec_priv *priv, struct bpf_prog *prog,
 		ret = netsec_xdp_xmit_back(priv, xdp);
 		if (ret != NETSEC_XDP_TX) {
 			page = virt_to_head_page(xdp->data);
-			page_pool_put_page(dring->page_pool, page, sync, true);
+			page_pool_put_page(dring->page_pool,
+					   page_to_netmem(page), sync, true);
 		}
 		break;
 	case XDP_REDIRECT:
@@ -929,7 +931,8 @@ static u32 netsec_run_xdp(struct netsec_priv *priv, struct bpf_prog *prog,
 		} else {
 			ret = NETSEC_XDP_CONSUMED;
 			page = virt_to_head_page(xdp->data);
-			page_pool_put_page(dring->page_pool, page, sync, true);
+			page_pool_put_page(dring->page_pool,
+					   page_to_netmem(page), sync, true);
 		}
 		break;
 	default:
@@ -941,7 +944,8 @@ static u32 netsec_run_xdp(struct netsec_priv *priv, struct bpf_prog *prog,
 	case XDP_DROP:
 		ret = NETSEC_XDP_CONSUMED;
 		page = virt_to_head_page(xdp->data);
-		page_pool_put_page(dring->page_pool, page, sync, true);
+		page_pool_put_page(dring->page_pool, page_to_netmem(page), sync,
+				   true);
 		break;
 	}
 
@@ -1038,8 +1042,8 @@ static int netsec_process_rx(struct netsec_priv *priv, int budget)
 			 * cache state. Since we paid the allocation cost if
 			 * building an skb fails try to put the page into cache
 			 */
-			page_pool_put_page(dring->page_pool, page, pkt_len,
-					   true);
+			page_pool_put_page(dring->page_pool,
+					   page_to_netmem(page), pkt_len, true);
 			netif_err(priv, drv, priv->ndev,
 				  "rx failed to build skb\n");
 			break;
@@ -1212,7 +1216,8 @@ static void netsec_uninit_pkt_dring(struct netsec_priv *priv, int id)
 		if (id == NETSEC_RING_RX) {
 			struct page *page = virt_to_page(desc->addr);
 
-			page_pool_put_full_page(dring->page_pool, page, false);
+			page_pool_put_full_page(dring->page_pool,
+						page_to_netmem(page), false);
 		} else if (id == NETSEC_RING_TX) {
 			dma_unmap_single(priv->dev, desc->dma_addr, desc->len,
 					 DMA_TO_DEVICE);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 47de466e432c..7680db4b54b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1455,25 +1455,29 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
 		gfp |= GFP_DMA32;
 
 	if (!buf->page) {
-		buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
+		buf->page = netmem_to_page(page_pool_alloc_pages(rx_q->page_pool,
+								 gfp));
 		if (!buf->page)
 			return -ENOMEM;
 		buf->page_offset = stmmac_rx_offset(priv);
 	}
 
 	if (priv->sph && !buf->sec_page) {
-		buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
+		buf->sec_page = netmem_to_page(page_pool_alloc_pages(rx_q->page_pool,
+								     gfp));
 		if (!buf->sec_page)
 			return -ENOMEM;
 
-		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
+		buf->sec_addr =
+			page_pool_get_dma_addr(page_to_netmem(buf->sec_page));
 		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
 	} else {
 		buf->sec_page = NULL;
 		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
 	}
 
-	buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
+	buf->addr = page_pool_get_dma_addr(page_to_netmem(buf->page)) +
+		    buf->page_offset;
 
 	stmmac_set_desc_addr(priv, p, buf->addr);
 	if (dma_conf->dma_buf_sz == BUF_SIZE_16KiB)
@@ -1495,11 +1499,13 @@ static void stmmac_free_rx_buffer(struct stmmac_priv *priv,
 	struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
 
 	if (buf->page)
-		page_pool_put_full_page(rx_q->page_pool, buf->page, false);
+		page_pool_put_full_page(rx_q->page_pool,
+					page_to_netmem(buf->page), false);
 	buf->page = NULL;
 
 	if (buf->sec_page)
-		page_pool_put_full_page(rx_q->page_pool, buf->sec_page, false);
+		page_pool_put_full_page(rx_q->page_pool,
+					page_to_netmem(buf->sec_page), false);
 	buf->sec_page = NULL;
 }
 
@@ -4739,20 +4745,23 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 			p = rx_q->dma_rx + entry;
 
 		if (!buf->page) {
-			buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
+			buf->page = netmem_to_page(page_pool_alloc_pages(rx_q->page_pool,
+									 gfp));
 			if (!buf->page)
 				break;
 		}
 
 		if (priv->sph && !buf->sec_page) {
-			buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
+			buf->sec_page = netmem_to_page(page_pool_alloc_pages(rx_q->page_pool,
+									     gfp));
 			if (!buf->sec_page)
 				break;
 
-			buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
+			buf->sec_addr = page_pool_get_dma_addr(page_to_netmem(buf->sec_page));
 		}
 
-		buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
+		buf->addr = page_pool_get_dma_addr(page_to_netmem(buf->page)) +
+			    buf->page_offset;
 
 		stmmac_set_desc_addr(priv, p, buf->addr);
 		if (priv->sph)
@@ -4861,8 +4870,8 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	} else {
 		struct page *page = virt_to_page(xdpf->data);
 
-		dma_addr = page_pool_get_dma_addr(page) + sizeof(*xdpf) +
-			   xdpf->headroom;
+		dma_addr = page_pool_get_dma_addr(page_to_netmem(page)) +
+			   sizeof(*xdpf) + xdpf->headroom;
 		dma_sync_single_for_device(priv->device, dma_addr,
 					   xdpf->len, DMA_BIDIRECTIONAL);
 
@@ -5432,7 +5441,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
 		if (unlikely(status == discard_frame)) {
-			page_pool_recycle_direct(rx_q->page_pool, buf->page);
+			page_pool_recycle_direct(rx_q->page_pool,
+						 page_to_netmem(buf->page));
 			buf->page = NULL;
 			error = 1;
 			if (!priv->hwts_rx_en)
@@ -5500,9 +5510,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 				unsigned int xdp_res = -PTR_ERR(skb);
 
 				if (xdp_res & STMMAC_XDP_CONSUMED) {
-					page_pool_put_page(rx_q->page_pool,
-							   virt_to_head_page(ctx.xdp.data),
-							   sync_len, true);
+					page_pool_put_page(
+						rx_q->page_pool,
+						page_to_netmem(
+							virt_to_head_page(
+								ctx.xdp.data)),
+						sync_len, true);
 					buf->page = NULL;
 					rx_dropped++;
 
@@ -5543,7 +5556,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			skb_put(skb, buf1_len);
 
 			/* Data payload copied into SKB, page ready for recycle */
-			page_pool_recycle_direct(rx_q->page_pool, buf->page);
+			page_pool_recycle_direct(rx_q->page_pool,
+						 page_to_netmem(buf->page));
 			buf->page = NULL;
 		} else if (buf1_len) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index ea85c6dd5484..ea9f1fe492e6 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -380,11 +380,11 @@ static void cpsw_rx_handler(void *token, int len, int status)
 		}
 
 		/* the interface is going down, pages are purged */
-		page_pool_recycle_direct(pool, page);
+		page_pool_recycle_direct(pool, page_to_netmem(page));
 		return;
 	}
 
-	new_page = page_pool_dev_alloc_pages(pool);
+	new_page = netmem_to_page(page_pool_dev_alloc_pages(pool));
 	if (unlikely(!new_page)) {
 		new_page = page;
 		ndev->stats.rx_dropped++;
@@ -417,7 +417,7 @@ static void cpsw_rx_handler(void *token, int len, int status)
 	skb = build_skb(pa, cpsw_rxbuf_total_len(pkt_size));
 	if (!skb) {
 		ndev->stats.rx_dropped++;
-		page_pool_recycle_direct(pool, page);
+		page_pool_recycle_direct(pool, page_to_netmem(page));
 		goto requeue;
 	}
 
@@ -442,12 +442,13 @@ static void cpsw_rx_handler(void *token, int len, int status)
 	xmeta->ndev = ndev;
 	xmeta->ch = ch;
 
-	dma = page_pool_get_dma_addr(new_page) + CPSW_HEADROOM_NA;
+	dma = page_pool_get_dma_addr(page_to_netmem(new_page)) +
+	      CPSW_HEADROOM_NA;
 	ret = cpdma_chan_submit_mapped(cpsw->rxv[ch].ch, new_page, dma,
 				       pkt_size, 0);
 	if (ret < 0) {
 		WARN_ON(ret == -ENOMEM);
-		page_pool_recycle_direct(pool, new_page);
+		page_pool_recycle_direct(pool, page_to_netmem(new_page));
 	}
 }
 
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 498c50c6d1a7..d02b29aedddf 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -325,11 +325,11 @@ static void cpsw_rx_handler(void *token, int len, int status)
 		}
 
 		/* the interface is going down, pages are purged */
-		page_pool_recycle_direct(pool, page);
+		page_pool_recycle_direct(pool, page_to_netmem(page));
 		return;
 	}
 
-	new_page = page_pool_dev_alloc_pages(pool);
+	new_page = netmem_to_page(page_pool_dev_alloc_pages(pool));
 	if (unlikely(!new_page)) {
 		new_page = page;
 		ndev->stats.rx_dropped++;
@@ -361,7 +361,7 @@ static void cpsw_rx_handler(void *token, int len, int status)
 	skb = build_skb(pa, cpsw_rxbuf_total_len(pkt_size));
 	if (!skb) {
 		ndev->stats.rx_dropped++;
-		page_pool_recycle_direct(pool, page);
+		page_pool_recycle_direct(pool, page_to_netmem(page));
 		goto requeue;
 	}
 
@@ -387,12 +387,13 @@ static void cpsw_rx_handler(void *token, int len, int status)
 	xmeta->ndev = ndev;
 	xmeta->ch = ch;
 
-	dma = page_pool_get_dma_addr(new_page) + CPSW_HEADROOM_NA;
+	dma = page_pool_get_dma_addr(page_to_netmem(new_page)) +
+	      CPSW_HEADROOM_NA;
 	ret = cpdma_chan_submit_mapped(cpsw->rxv[ch].ch, new_page, dma,
 				       pkt_size, 0);
 	if (ret < 0) {
 		WARN_ON(ret == -ENOMEM);
-		page_pool_recycle_direct(pool, new_page);
+		page_pool_recycle_direct(pool, page_to_netmem(new_page));
 	}
 }
 
diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index 764ed298b570..222b2bd3dc47 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -1113,7 +1113,7 @@ int cpsw_fill_rx_channels(struct cpsw_priv *priv)
 		pool = cpsw->page_pool[ch];
 		ch_buf_num = cpdma_chan_get_rx_buf_num(cpsw->rxv[ch].ch);
 		for (i = 0; i < ch_buf_num; i++) {
-			page = page_pool_dev_alloc_pages(pool);
+			page = netmem_to_page(page_pool_dev_alloc_pages(pool));
 			if (!page) {
 				cpsw_err(priv, ifup, "allocate rx page err\n");
 				return -ENOMEM;
@@ -1123,7 +1123,8 @@ int cpsw_fill_rx_channels(struct cpsw_priv *priv)
 			xmeta->ndev = priv->ndev;
 			xmeta->ch = ch;
 
-			dma = page_pool_get_dma_addr(page) + CPSW_HEADROOM_NA;
+			dma = page_pool_get_dma_addr(page_to_netmem(page)) +
+			      CPSW_HEADROOM_NA;
 			ret = cpdma_chan_idle_submit_mapped(cpsw->rxv[ch].ch,
 							    page, dma,
 							    cpsw->rx_packet_max,
@@ -1132,7 +1133,8 @@ int cpsw_fill_rx_channels(struct cpsw_priv *priv)
 				cpsw_err(priv, ifup,
 					 "cannot submit page to channel %d rx, error %d\n",
 					 ch, ret);
-				page_pool_recycle_direct(pool, page);
+				page_pool_recycle_direct(pool,
+							 page_to_netmem(page));
 				return ret;
 			}
 		}
@@ -1303,7 +1305,7 @@ int cpsw_xdp_tx_frame(struct cpsw_priv *priv, struct xdp_frame *xdpf,
 	txch = cpsw->txv[0].ch;
 
 	if (page) {
-		dma = page_pool_get_dma_addr(page);
+		dma = page_pool_get_dma_addr(page_to_netmem(page));
 		dma += xdpf->headroom + sizeof(struct xdp_frame);
 		ret = cpdma_chan_submit_mapped(txch, cpsw_xdpf_to_handle(xdpf),
 					       dma, xdpf->len, port);
@@ -1379,7 +1381,7 @@ int cpsw_run_xdp(struct cpsw_priv *priv, int ch, struct xdp_buff *xdp,
 out:
 	return ret;
 drop:
-	page_pool_recycle_direct(cpsw->page_pool[ch], page);
+	page_pool_recycle_direct(cpsw->page_pool[ch], page_to_netmem(page));
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index a5a50b5a8816..57291cbf774b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -228,7 +228,8 @@ static void wx_dma_sync_frag(struct wx_ring *rx_ring,
 
 	/* If the page was released, just unmap it. */
 	if (unlikely(WX_CB(skb)->page_released))
-		page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
+		page_pool_put_full_page(rx_ring->page_pool,
+					page_to_netmem(rx_buffer->page), false);
 }
 
 static struct wx_rx_buffer *wx_get_rx_buffer(struct wx_ring *rx_ring,
@@ -288,7 +289,9 @@ static void wx_put_rx_buffer(struct wx_ring *rx_ring,
 			/* the page has been released from the ring */
 			WX_CB(skb)->page_released = true;
 		else
-			page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
+			page_pool_put_full_page(rx_ring->page_pool,
+						page_to_netmem(rx_buffer->page),
+						false);
 
 		__page_frag_cache_drain(rx_buffer->page,
 					rx_buffer->pagecnt_bias);
@@ -375,9 +378,9 @@ static bool wx_alloc_mapped_page(struct wx_ring *rx_ring,
 	if (likely(page))
 		return true;
 
-	page = page_pool_dev_alloc_pages(rx_ring->page_pool);
+	page = netmem_to_page(page_pool_dev_alloc_pages(rx_ring->page_pool));
 	WARN_ON(!page);
-	dma = page_pool_get_dma_addr(page);
+	dma = page_pool_get_dma_addr(page_to_netmem(page));
 
 	bi->page_dma = dma;
 	bi->page = page;
@@ -2232,7 +2235,9 @@ static void wx_clean_rx_ring(struct wx_ring *rx_ring)
 			struct sk_buff *skb = rx_buffer->skb;
 
 			if (WX_CB(skb)->page_released)
-				page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
+				page_pool_put_full_page(rx_ring->page_pool,
+							page_to_netmem(rx_buffer->page),
+							false);
 
 			dev_kfree_skb(skb);
 		}
@@ -2247,7 +2252,8 @@ static void wx_clean_rx_ring(struct wx_ring *rx_ring)
 					      DMA_FROM_DEVICE);
 
 		/* free resources associated with mapping */
-		page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
+		page_pool_put_full_page(rx_ring->page_pool,
+					page_to_netmem(rx_buffer->page), false);
 		__page_frag_cache_drain(rx_buffer->page,
 					rx_buffer->pagecnt_bias);
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 977861c46b1f..c93c199224da 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -781,8 +781,9 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 			size = min_t(u32, len, PAGE_SIZE);
 			truesize = size;
 
-			page = page_pool_dev_alloc(rq->page_pool, &page_offset,
-						   &truesize);
+			page = netmem_to_page(page_pool_dev_alloc(rq->page_pool,
+								  &page_offset,
+								  &truesize));
 			if (!page) {
 				consume_skb(nskb);
 				goto drop;
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 0578864792b6..063a5c2c948d 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1349,11 +1349,12 @@ vmxnet3_pp_get_buff(struct page_pool *pp, dma_addr_t *dma_addr,
 {
 	struct page *page;
 
-	page = page_pool_alloc_pages(pp, gfp_mask | __GFP_NOWARN);
+	page = netmem_to_page(page_pool_alloc_pages(pp,
+						    gfp_mask | __GFP_NOWARN));
 	if (unlikely(!page))
 		return NULL;
 
-	*dma_addr = page_pool_get_dma_addr(page) + pp->p.offset;
+	*dma_addr = page_pool_get_dma_addr(page_to_netmem(page)) + pp->p.offset;
 
 	return page_address(page);
 }
@@ -1931,7 +1932,7 @@ vmxnet3_rq_cleanup(struct vmxnet3_rx_queue *rq,
 			if (rxd->btype == VMXNET3_RXD_BTYPE_HEAD &&
 			    rbi->page && rbi->buf_type == VMXNET3_RX_BUF_XDP) {
 				page_pool_recycle_direct(rq->page_pool,
-							 rbi->page);
+							 page_to_netmem(rbi->page));
 				rbi->page = NULL;
 			} else if (rxd->btype == VMXNET3_RXD_BTYPE_HEAD &&
 				   rbi->skb) {
diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet3_xdp.c
index 80ddaff759d4..71f3c278a960 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -147,7 +147,7 @@ vmxnet3_xdp_xmit_frame(struct vmxnet3_adapter *adapter,
 		tbi->map_type |= VMXNET3_MAP_SINGLE;
 	} else { /* XDP buffer from page pool */
 		page = virt_to_page(xdpf->data);
-		tbi->dma_addr = page_pool_get_dma_addr(page) +
+		tbi->dma_addr = page_pool_get_dma_addr(page_to_netmem(page)) +
 				VMXNET3_XDP_HEADROOM;
 		dma_sync_single_for_device(&adapter->pdev->dev,
 					   tbi->dma_addr, buf_size,
@@ -269,7 +269,8 @@ vmxnet3_run_xdp(struct vmxnet3_rx_queue *rq, struct xdp_buff *xdp,
 			rq->stats.xdp_redirects++;
 		} else {
 			rq->stats.xdp_drops++;
-			page_pool_recycle_direct(rq->page_pool, page);
+			page_pool_recycle_direct(rq->page_pool,
+						 page_to_netmem(page));
 		}
 		return act;
 	case XDP_TX:
@@ -277,7 +278,8 @@ vmxnet3_run_xdp(struct vmxnet3_rx_queue *rq, struct xdp_buff *xdp,
 		if (unlikely(!xdpf ||
 			     vmxnet3_xdp_xmit_back(rq->adapter, xdpf))) {
 			rq->stats.xdp_drops++;
-			page_pool_recycle_direct(rq->page_pool, page);
+			page_pool_recycle_direct(rq->page_pool,
+						 page_to_netmem(page));
 		} else {
 			rq->stats.xdp_tx++;
 		}
@@ -294,7 +296,7 @@ vmxnet3_run_xdp(struct vmxnet3_rx_queue *rq, struct xdp_buff *xdp,
 		break;
 	}
 
-	page_pool_recycle_direct(rq->page_pool, page);
+	page_pool_recycle_direct(rq->page_pool, page_to_netmem(page));
 
 	return act;
 }
@@ -307,7 +309,7 @@ vmxnet3_build_skb(struct vmxnet3_rx_queue *rq, struct page *page,
 
 	skb = build_skb(page_address(page), PAGE_SIZE);
 	if (unlikely(!skb)) {
-		page_pool_recycle_direct(rq->page_pool, page);
+		page_pool_recycle_direct(rq->page_pool, page_to_netmem(page));
 		rq->stats.rx_buf_alloc_failure++;
 		return NULL;
 	}
@@ -332,7 +334,7 @@ vmxnet3_process_xdp_small(struct vmxnet3_adapter *adapter,
 	struct page *page;
 	int act;
 
-	page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
+	page = netmem_to_page(page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC));
 	if (unlikely(!page)) {
 		rq->stats.rx_buf_alloc_failure++;
 		return XDP_DROP;
@@ -381,9 +383,9 @@ vmxnet3_process_xdp(struct vmxnet3_adapter *adapter,
 
 	page = rbi->page;
 	dma_sync_single_for_cpu(&adapter->pdev->dev,
-				page_pool_get_dma_addr(page) +
-				rq->page_pool->p.offset, rcd->len,
-				page_pool_get_dma_dir(rq->page_pool));
+				page_pool_get_dma_addr(page_to_netmem(page)) +
+					rq->page_pool->p.offset,
+				rcd->len, page_pool_get_dma_dir(rq->page_pool));
 
 	xdp_init_buff(&xdp, rbi->len, &rq->xdp_rxq);
 	xdp_prepare_buff(&xdp, page_address(page), rq->page_pool->p.offset,
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 511fe7e6e744..64972792fa4b 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -616,7 +616,9 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 		if (!buf)
 			break;
 
-		addr = page_pool_get_dma_addr(virt_to_head_page(buf)) + offset;
+		addr = page_pool_get_dma_addr(
+			       page_to_netmem(virt_to_head_page(buf))) +
+		       offset;
 		dir = page_pool_get_dma_dir(q->page_pool);
 		dma_sync_single_for_device(dev->dma_dev, addr, len, dir);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ea828ba0b83a..a559d870312a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1565,7 +1565,7 @@ static inline void mt76_put_page_pool_buf(void *buf, bool allow_direct)
 {
 	struct page *page = virt_to_head_page(buf);
 
-	page_pool_put_full_page(page->pp, page, allow_direct);
+	page_pool_put_full_page(page->pp, page_to_netmem(page), allow_direct);
 }
 
 static inline void *
@@ -1573,7 +1573,8 @@ mt76_get_page_pool_buf(struct mt76_queue *q, u32 *offset, u32 size)
 {
 	struct page *page;
 
-	page = page_pool_dev_alloc_frag(q->page_pool, offset, size);
+	page = netmem_to_page(
+		page_pool_dev_alloc_frag(q->page_pool, offset, size));
 	if (!page)
 		return NULL;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index e7d8e03f826f..452d3018adc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -616,7 +616,9 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 		if (!buf)
 			goto unmap;
 
-		addr = page_pool_get_dma_addr(virt_to_head_page(buf)) + offset;
+		addr = page_pool_get_dma_addr(
+			       page_to_netmem(virt_to_head_page(buf))) +
+		       offset;
 		dir = page_pool_get_dma_dir(q->page_pool);
 		dma_sync_single_for_device(dev->mt76.dma_dev, addr, len, dir);
 
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index ad29f370034e..2b07b56fde54 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -278,8 +278,8 @@ static struct sk_buff *xennet_alloc_one_rx_buffer(struct netfront_queue *queue)
 	if (unlikely(!skb))
 		return NULL;
 
-	page = page_pool_alloc_pages(queue->page_pool,
-				     GFP_ATOMIC | __GFP_NOWARN | __GFP_ZERO);
+	page = netmem_to_page(page_pool_alloc_pages(
+		queue->page_pool, GFP_ATOMIC | __GFP_NOWARN | __GFP_ZERO));
 	if (unlikely(!page)) {
 		kfree_skb(skb);
 		return NULL;
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 7dc65774cde5..153a3313562c 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -85,7 +85,7 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
  *
  * Get a page from the page allocator or page_pool caches.
  */
-static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
+static inline struct netmem *page_pool_dev_alloc_pages(struct page_pool *pool)
 {
 	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
 
@@ -103,18 +103,18 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
  * Return:
  * Return allocated page fragment, otherwise return NULL.
  */
-static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
-						    unsigned int *offset,
-						    unsigned int size)
+static inline struct netmem *page_pool_dev_alloc_frag(struct page_pool *pool,
+						 unsigned int *offset,
+						 unsigned int size)
 {
 	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
 
 	return page_pool_alloc_frag(pool, offset, size, gfp);
 }
 
-static inline struct page *page_pool_alloc(struct page_pool *pool,
-					   unsigned int *offset,
-					   unsigned int *size, gfp_t gfp)
+static inline struct netmem *page_pool_alloc(struct page_pool *pool,
+					unsigned int *offset,
+					unsigned int *size, gfp_t gfp)
 {
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
 	struct page *page;
@@ -125,7 +125,7 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
 		return page_pool_alloc_pages(pool, gfp);
 	}
 
-	page = page_pool_alloc_frag(pool, offset, *size, gfp);
+	page = netmem_to_page(page_pool_alloc_frag(pool, offset, *size, gfp));
 	if (unlikely(!page))
 		return NULL;
 
@@ -138,7 +138,7 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
 		pool->frag_offset = max_size;
 	}
 
-	return page;
+	return page_to_netmem(page);
 }
 
 /**
@@ -154,9 +154,9 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
  * Return:
  * Return allocated page or page fragment, otherwise return NULL.
  */
-static inline struct page *page_pool_dev_alloc(struct page_pool *pool,
-					       unsigned int *offset,
-					       unsigned int *size)
+static inline struct netmem *page_pool_dev_alloc(struct page_pool *pool,
+					    unsigned int *offset,
+					    unsigned int *size)
 {
 	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
 
@@ -170,7 +170,8 @@ static inline void *page_pool_alloc_va(struct page_pool *pool,
 	struct page *page;
 
 	/* Mask off __GFP_HIGHMEM to ensure we can use page_address() */
-	page = page_pool_alloc(pool, &offset, size, gfp & ~__GFP_HIGHMEM);
+	page = netmem_to_page(
+		page_pool_alloc(pool, &offset, size, gfp & ~__GFP_HIGHMEM));
 	if (unlikely(!page))
 		return NULL;
 
@@ -220,13 +221,14 @@ inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
  * refcnt is 1 or return it back to the memory allocator and destroy any
  * mappings we have.
  */
-static inline void page_pool_fragment_page(struct page *page, long nr)
+static inline void page_pool_fragment_page(struct netmem *netmem, long nr)
 {
-	atomic_long_set(&page->pp_frag_count, nr);
+	atomic_long_set(&netmem_to_page(netmem)->pp_frag_count, nr);
 }
 
-static inline long page_pool_defrag_page(struct page *page, long nr)
+static inline long page_pool_defrag_page(struct netmem *netmem, long nr)
 {
+	struct page *page = netmem_to_page(netmem);
 	long ret;
 
 	/* If nr == pp_frag_count then we have cleared all remaining
@@ -269,16 +271,16 @@ static inline long page_pool_defrag_page(struct page *page, long nr)
 	return ret;
 }
 
-static inline bool page_pool_is_last_frag(struct page *page)
+static inline bool page_pool_is_last_frag(struct netmem *netmem)
 {
 	/* If page_pool_defrag_page() returns 0, we were the last user */
-	return page_pool_defrag_page(page, 1) == 0;
+	return page_pool_defrag_page(netmem, 1) == 0;
 }
 
 /**
  * page_pool_put_page() - release a reference to a page pool page
  * @pool:	pool from which page was allocated
- * @page:	page to release a reference on
+ * @netmem:	netmem to release a reference on
  * @dma_sync_size: how much of the page may have been touched by the device
  * @allow_direct: released by the consumer, allow lockless caching
  *
@@ -288,8 +290,7 @@ static inline bool page_pool_is_last_frag(struct page *page)
  * caches. If PP_FLAG_DMA_SYNC_DEV is set, the page will be synced for_device
  * using dma_sync_single_range_for_device().
  */
-static inline void page_pool_put_page(struct page_pool *pool,
-				      struct page *page,
+static inline void page_pool_put_page(struct page_pool *pool, struct netmem *netmem,
 				      unsigned int dma_sync_size,
 				      bool allow_direct)
 {
@@ -297,40 +298,40 @@ static inline void page_pool_put_page(struct page_pool *pool,
 	 * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
 	 */
 #ifdef CONFIG_PAGE_POOL
-	if (!page_pool_is_last_frag(page))
+	if (!page_pool_is_last_frag(netmem))
 		return;
 
-	page_pool_put_defragged_page(pool, page, dma_sync_size, allow_direct);
+	page_pool_put_defragged_page(pool, netmem, dma_sync_size, allow_direct);
 #endif
 }
 
 /**
  * page_pool_put_full_page() - release a reference on a page pool page
  * @pool:	pool from which page was allocated
- * @page:	page to release a reference on
+ * @netmem:	netmem to release a reference on
  * @allow_direct: released by the consumer, allow lockless caching
  *
  * Similar to page_pool_put_page(), but will DMA sync the entire memory area
  * as configured in &page_pool_params.max_len.
  */
 static inline void page_pool_put_full_page(struct page_pool *pool,
-					   struct page *page, bool allow_direct)
+					   struct netmem *netmem, bool allow_direct)
 {
-	page_pool_put_page(pool, page, -1, allow_direct);
+	page_pool_put_page(pool, netmem, -1, allow_direct);
 }
 
 /**
  * page_pool_recycle_direct() - release a reference on a page pool page
  * @pool:	pool from which page was allocated
- * @page:	page to release a reference on
+ * @netmem:	netmem to release a reference on
  *
  * Similar to page_pool_put_full_page() but caller must guarantee safe context
  * (e.g NAPI), since it will recycle the page directly into the pool fast cache.
  */
 static inline void page_pool_recycle_direct(struct page_pool *pool,
-					    struct page *page)
+					    struct netmem *netmem)
 {
-	page_pool_put_full_page(pool, page, true);
+	page_pool_put_full_page(pool, netmem, true);
 }
 
 #define PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA	\
@@ -347,19 +348,20 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
 static inline void page_pool_free_va(struct page_pool *pool, void *va,
 				     bool allow_direct)
 {
-	page_pool_put_page(pool, virt_to_head_page(va), -1, allow_direct);
+	page_pool_put_page(pool, page_to_netmem(virt_to_head_page(va)), -1,
+			   allow_direct);
 }
 
 /**
  * page_pool_get_dma_addr() - Retrieve the stored DMA address.
- * @page:	page allocated from a page pool
+ * @netmem:	netmem allocated from a page pool
  *
  * Fetch the DMA address of the page. The page pool to which the page belongs
  * must had been created with PP_FLAG_DMA_MAP.
  */
-static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
+static inline dma_addr_t page_pool_get_dma_addr(struct netmem *netmem)
 {
-	dma_addr_t ret = page->dma_addr;
+	dma_addr_t ret = netmem_to_page(netmem)->dma_addr;
 
 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
 		ret <<= PAGE_SHIFT;
@@ -367,8 +369,10 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
 	return ret;
 }
 
-static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
+static inline bool page_pool_set_dma_addr(struct netmem *netmem, dma_addr_t addr)
 {
+	struct page *page = netmem_to_page(netmem);
+
 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
 		page->dma_addr = addr >> PAGE_SHIFT;
 
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index ac286ea8ce2d..0faa5207a394 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -6,6 +6,7 @@
 #include <linux/dma-direction.h>
 #include <linux/ptr_ring.h>
 #include <linux/types.h>
+#include <net/netmem.h>
 
 #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
 					* map/unmap
@@ -199,9 +200,9 @@ struct page_pool {
 	} user;
 };
 
-struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
-struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
-				  unsigned int size, gfp_t gfp);
+struct netmem *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
+struct netmem *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
+			       unsigned int size, gfp_t gfp);
 struct page_pool *page_pool_create(const struct page_pool_params *params);
 
 struct xdp_mem_info;
@@ -234,7 +235,7 @@ static inline void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 }
 #endif
 
-void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
+void page_pool_put_defragged_page(struct page_pool *pool, struct netmem *netmem,
 				  unsigned int dma_sync_size,
 				  bool allow_direct);
 
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 711cf5d59816..32e3fbc17e65 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -296,7 +296,7 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 	xdp_set_return_frame_no_direct();
 
 	for (i = 0; i < batch_sz; i++) {
-		page = page_pool_dev_alloc_pages(xdp->pp);
+		page = netmem_to_page(page_pool_dev_alloc_pages(xdp->pp));
 		if (!page) {
 			err = -ENOMEM;
 			goto out;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index c2e7c9a6efbe..e8ab7944e291 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -360,7 +360,7 @@ static void page_pool_dma_sync_for_device(struct page_pool *pool,
 					  struct page *page,
 					  unsigned int dma_sync_size)
 {
-	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
+	dma_addr_t dma_addr = page_pool_get_dma_addr(page_to_netmem(page));
 
 	dma_sync_size = min(dma_sync_size, pool->p.max_len);
 	dma_sync_single_range_for_device(pool->p.dev, dma_addr,
@@ -384,7 +384,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	if (dma_mapping_error(pool->p.dev, dma))
 		return false;
 
-	if (page_pool_set_dma_addr(page, dma))
+	if (page_pool_set_dma_addr(page_to_netmem(page), dma))
 		goto unmap_failed;
 
 	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
@@ -412,7 +412,7 @@ static void page_pool_set_pp_info(struct page_pool *pool,
 	 * is dirtying the same cache line as the page->pp_magic above, so
 	 * the overhead is negligible.
 	 */
-	page_pool_fragment_page(page, 1);
+	page_pool_fragment_page(page_to_netmem(page), 1);
 	if (pool->has_init_callback)
 		pool->slow.init_callback(page, pool->slow.init_arg);
 }
@@ -509,18 +509,18 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
 /* For using page_pool replace: alloc_pages() API calls, but provide
  * synchronization guarantee for allocation side.
  */
-struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
+struct netmem *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
 {
 	struct page *page;
 
 	/* Fast-path: Get a page from cache */
 	page = __page_pool_get_cached(pool);
 	if (page)
-		return page;
+		return page_to_netmem(page);
 
 	/* Slow-path: cache empty, do real allocation */
 	page = __page_pool_alloc_pages_slow(pool, gfp);
-	return page;
+	return page_to_netmem(page);
 }
 EXPORT_SYMBOL(page_pool_alloc_pages);
 
@@ -564,13 +564,13 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
 		 */
 		goto skip_dma_unmap;
 
-	dma = page_pool_get_dma_addr(page);
+	dma = page_pool_get_dma_addr(page_to_netmem(page));
 
 	/* When page is unmapped, it cannot be returned to our pool */
 	dma_unmap_page_attrs(pool->p.dev, dma,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
-	page_pool_set_dma_addr(page, 0);
+	page_pool_set_dma_addr(page_to_netmem(page), 0);
 skip_dma_unmap:
 	page_pool_clear_pp_info(page);
 
@@ -677,9 +677,11 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	return NULL;
 }
 
-void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
+void page_pool_put_defragged_page(struct page_pool *pool, struct netmem *netmem,
 				  unsigned int dma_sync_size, bool allow_direct)
 {
+	struct page *page = netmem_to_page(netmem);
+
 	page = __page_pool_put_page(pool, page, dma_sync_size, allow_direct);
 	if (page && !page_pool_recycle_in_ring(pool, page)) {
 		/* Cache full, fallback to free pages */
@@ -714,7 +716,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 		struct page *page = virt_to_head_page(data[i]);
 
 		/* It is not the last user for the page frag case */
-		if (!page_pool_is_last_frag(page))
+		if (!page_pool_is_last_frag(page_to_netmem(page)))
 			continue;
 
 		page = __page_pool_put_page(pool, page, -1, false);
@@ -756,7 +758,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 	long drain_count = BIAS_MAX - pool->frag_users;
 
 	/* Some user is still using the page frag */
-	if (likely(page_pool_defrag_page(page, drain_count)))
+	if (likely(page_pool_defrag_page(page_to_netmem(page), drain_count)))
 		return NULL;
 
 	if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
@@ -777,15 +779,14 @@ static void page_pool_free_frag(struct page_pool *pool)
 
 	pool->frag_page = NULL;
 
-	if (!page || page_pool_defrag_page(page, drain_count))
+	if (!page || page_pool_defrag_page(page_to_netmem(page), drain_count))
 		return;
 
 	page_pool_return_page(pool, page);
 }
 
-struct page *page_pool_alloc_frag(struct page_pool *pool,
-				  unsigned int *offset,
-				  unsigned int size, gfp_t gfp)
+struct netmem *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
+			       unsigned int size, gfp_t gfp)
 {
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
 	struct page *page = pool->frag_page;
@@ -805,7 +806,7 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
 	}
 
 	if (!page) {
-		page = page_pool_alloc_pages(pool, gfp);
+		page = netmem_to_page(page_pool_alloc_pages(pool, gfp));
 		if (unlikely(!page)) {
 			pool->frag_page = NULL;
 			return NULL;
@@ -817,14 +818,14 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
 		pool->frag_users = 1;
 		*offset = 0;
 		pool->frag_offset = size;
-		page_pool_fragment_page(page, BIAS_MAX);
-		return page;
+		page_pool_fragment_page(page_to_netmem(page), BIAS_MAX);
+		return page_to_netmem(page);
 	}
 
 	pool->frag_users++;
 	pool->frag_offset = *offset + size;
 	alloc_stat_inc(pool, fast);
-	return page;
+	return page_to_netmem(page);
 }
 EXPORT_SYMBOL(page_pool_alloc_frag);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b157efea5dea..01509728a753 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -928,7 +928,7 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
 	 * The page will be returned to the pool here regardless of the
 	 * 'flipped' fragment being in use or not.
 	 */
-	page_pool_put_full_page(pp, page, allow_direct);
+	page_pool_put_full_page(pp, page_to_netmem(page), allow_direct);
 
 	return true;
 }
diff --git a/net/core/xdp.c b/net/core/xdp.c
index b6f1d6dab3f2..681294eee763 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -387,7 +387,8 @@ void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
 		/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
 		 * as mem->type knows this a page_pool page
 		 */
-		page_pool_put_full_page(page->pp, page, napi_direct);
+		page_pool_put_full_page(page->pp, page_to_netmem(page),
+					napi_direct);
 		break;
 	case MEM_TYPE_PAGE_SHARED:
 		page_frag_free(data);
-- 
2.43.0.472.g3155946c3a-goog


