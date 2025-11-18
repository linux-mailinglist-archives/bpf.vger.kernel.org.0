Return-Path: <bpf+bounces-74943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B151DC69245
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5B66368A2F
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 11:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C865E355037;
	Tue, 18 Nov 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyUt7bx2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E93563C6
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465541; cv=none; b=AzwFJeWCBVGiGvhGm1Zgy5F4sixWIXlz64gHZ5EJpBmo60DRykPBGxIsY1Za1uvXU5eWFfN5P5MjwwVJPlroWyPGWzOyP9llUU7A8qC9TICk0yC4kfJslMzzkl67eNEdPAXVostV1+O6e998Wx5Hff8e9Lr1boex7QJuGkyDdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465541; c=relaxed/simple;
	bh=K8Wyd2To1BmAKFVUmUbQOinghXJ6DrKZBtPEPb4ilFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBjfs1iIGtghlZ6Q85H808ZmJt2BooXEUAGHgE0zqCWXJ+6xTMsNzZvuj0qzzwH4gzztSQSHkQTwn1rWZrjgkfc+amkteRupgSHb4O0T99pTm5kDIS357uNizj9QEzrt5N8tN7Yqzs9XfRtPiLcugA2TjTVCjVKkplqCr0gd/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyUt7bx2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-340ba29d518so3786737a91.3
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 03:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763465539; x=1764070339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U36EJ4GyvUj1c+KWVQBGEQGDIxcP9pTwbj0Nc88XDlE=;
        b=DyUt7bx2GXMi8+9f09ff1Db3Ptbgbilvu41PK7cNugTb8O4Slv7rpO18YVhSWSs/3b
         w1Vc8G8u/PofGGeQE1W+zJpZz4ddZU07S2XvTHhGf6ZNW2l1F0AWvFJZmtYZCLnu+42Y
         1lgAmniLcS41LWTB400k3bSYfqredbE/aPdXyiURjtXadGgxay5k4IC6ybuXfZa/qTV4
         y/cv2MN+uODKjX7uZnmpJZR+diqThGndYdnISGWCQ3q5MdA7r+gSU3lx7n5RB2/1Hra2
         fIf6Db3txOL1jRjGBL9cnGCNNyUlLZJ+y1e2oOz51JZO8lZOfm6spwib89uDMP5sVWj7
         9BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763465539; x=1764070339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U36EJ4GyvUj1c+KWVQBGEQGDIxcP9pTwbj0Nc88XDlE=;
        b=s6I5X9JMiWVMakhofuRqC7Xdiqw4+1ZOu2ze8WD3GSayRH8zl2rApXqYF9vIUowY/0
         F0vaPlBzXoTfzuBUQ5q9f67wv7pO+h60NC2ExpmmxlMhOXI3dkb0k4X/8VVjs9ky91di
         ZNDJLhRWhEqQ7fwaicDLzbzEEes5sgxgqbZwKtbG7uR/0aSelqgtCRApEbYybYpiRRFa
         EFEfuqJv9IHZ55zXdJkSst2lovTAMLxMwaqLCwoyAGIlnsj4kmhdn6eq4y+9Pe+sSF+A
         vEIbuDoZrztH06xXZ9LdpKXOqFO+dNqxfT3YIE4clMksbsujNuClb9equOJy261vRtS0
         /nmg==
X-Forwarded-Encrypted: i=1; AJvYcCWgauJ54Uz4KuFinJZ32BywrB6MmZRg0hGHU1bXHSW+UrFlByiTN/L5tdP90VDy8xHnWmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRJ9FVwDyju4g9c1ekmJPGqOYq5HCoNc2LUMXIRBXO2aqnt8qW
	dX8eDRexeGpytZ8LQB662UVlDiPQF1XtYnQrscNBU5u7QWRF8FTsCx3z
X-Gm-Gg: ASbGncs7IEzhPecgRxmA8Cc2PIPjZ+cy4PwayeCEmVXKqDoVVRkuBTIHMo/ETCk7UmD
	xY4DxqdVsSEEBkp6buYNNwXPriSlBOWnigq5lJSJlKeQMhD8K720tfCp+QSJorKrq6eRmX4Dvjk
	2BVei5QcphYo0BTlJnQXwOHGuMXHBZWI+mm2tpzpRsCM7gLxgSIVXgxlIOfPjLcovDUUMBmtgIg
	rJDXiPkTwqzJvfgKtWyHjxnCkJXnsh4UeAs9114r3u7LD+vncKEPyuCBJ+zzMIRJzIMWdVbw45U
	J9WxL943XQbQz6bljxEzwOf6szPK6pZrXtfamER3wgS3V1hglER72tLwjfNjKMjrBkSCBDNGMP6
	ftZcRy1zLrTQn6bJrIDr0lA7CSZI5Is4CCnrNk45IWWdmdgFahoYY3jBxJHG7P8uQBcnW/d9gtD
	FV2lCjnJYJrftgDOiXWZXYGRe5S+EbbN4dUliHIgCWXSC4qu60hA==
X-Google-Smtp-Source: AGHT+IEXgXhQS/PPrYJbpAo06A+LbwNc11z1gcGQgtP5bDqE6cvj/3xMoRUdO7/TieS5wkj2K+854Q==
X-Received: by 2002:a17:90b:2552:b0:340:ec8f:82d8 with SMTP id 98e67ed59e1d1-343f9ea40c1mr19277977a91.12.1763465538566;
        Tue, 18 Nov 2025 03:32:18 -0800 (PST)
Received: from localhost.localdomain ([103.246.102.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456516d4a9sm12583736a91.11.2025.11.18.03.32.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Nov 2025 03:32:18 -0800 (PST)
From: Alessandro Decina <alessandro.d@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Alessandro Decina <alessandro.d@gmail.com>
Subject: [PATCH net v4 1/1] i40e: xsk: advance next_to_clean on status descriptors
Date: Tue, 18 Nov 2025 22:31:17 +1100
Message-Id: <20251118113117.11567-2-alessandro.d@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251118113117.11567-1-alessandro.d@gmail.com>
References: <20251118113117.11567-1-alessandro.d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever a status descriptor is received, i40e processes and skips over
it, correctly updating next_to_process but forgetting to update
next_to_clean. In the next iteration this accidentally causes the
creation of an invalid multi-buffer xdp_buff where the first fragment
is the status descriptor.

If then a skb is constructed from such an invalid buffer - because the
eBPF program returns XDP_PASS - a panic occurs:

[ 5866.367317] BUG: unable to handle page fault for address: ffd31c37eab1c980
[ 5866.375050] #PF: supervisor read access in kernel mode
[ 5866.380825] #PF: error_code(0x0000) - not-present page
[ 5866.386602] PGD 0
[ 5866.388867] Oops: Oops: 0000 [#1] SMP NOPTI
[ 5866.393575] CPU: 34 UID: 0 PID: 0 Comm: swapper/34 Not tainted 6.17.0-custom #1 PREEMPT(voluntary)
[ 5866.403740] Hardware name: Supermicro AS -2115GT-HNTR/H13SST-G, BIOS 3.2 03/20/2025
[ 5866.412339] RIP: 0010:memcpy+0x8/0x10
[ 5866.416454] Code: cc cc 90 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 d1 <f3> a4 e9 fc 26 c0 fe 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[ 5866.437538] RSP: 0018:ff428d9ec0bb0ca8 EFLAGS: 00010286
[ 5866.443415] RAX: ff2dd26dbd8f0000 RBX: ff2dd265ad161400 RCX: 00000000000004e1
[ 5866.451435] RDX: 00000000000004e1 RSI: ffd31c37eab1c980 RDI: ff2dd26dbd8f0000
[ 5866.459454] RBP: ff428d9ec0bb0d40 R08: 0000000000000000 R09: 0000000000000000
[ 5866.467470] R10: 0000000000000000 R11: 0000000000000000 R12: ff428d9eec726ef8
[ 5866.475490] R13: ff2dd26dbd8f0000 R14: ff2dd265ca2f9fc0 R15: ff2dd26548548b80
[ 5866.483509] FS:  0000000000000000(0000) GS:ff2dd2c363592000(0000) knlGS:0000000000000000
[ 5866.492600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5866.499060] CR2: ffd31c37eab1c980 CR3: 0000000178d7b040 CR4: 0000000000f71ef0
[ 5866.507079] PKRU: 55555554
[ 5866.510125] Call Trace:
[ 5866.512867]  <IRQ>
[ 5866.515132]  ? i40e_clean_rx_irq_zc+0xc50/0xe60 [i40e]
[ 5866.520921]  i40e_napi_poll+0x2d8/0x1890 [i40e]
[ 5866.526022]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 5866.531408]  ? raise_softirq+0x24/0x70
[ 5866.535623]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 5866.541011]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 5866.546397]  ? rcu_sched_clock_irq+0x225/0x1800
[ 5866.551493]  __napi_poll+0x30/0x230
[ 5866.555423]  net_rx_action+0x20b/0x3f0
[ 5866.559643]  handle_softirqs+0xe4/0x340
[ 5866.563962]  __irq_exit_rcu+0x10e/0x130
[ 5866.568283]  irq_exit_rcu+0xe/0x20
[ 5866.572110]  common_interrupt+0xb6/0xe0
[ 5866.576425]  </IRQ>
[ 5866.578791]  <TASK>

Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.

Move the common logic to i40e_clean_programming_status and update both
i40e_clean_rx_irq and i40e_clean_rx_irq_zc accordingly.

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 59 +++++++++++--------
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  5 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 14 ++---
 3 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index cc0b9efc2637..fe2190f4b9bc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1386,22 +1386,36 @@ static void i40e_reuse_rx_page(struct i40e_ring *rx_ring,
  * @rx_ring: the rx ring that has this descriptor
  * @qword0_raw: qword0
  * @qword1: qword1 representing status_error_len in CPU ordering
+ * @next_to_process: pointer to next_to_process index
+ * @next_to_clean: pointer to next_to_clean index
  *
  * Flow director should handle FD_FILTER_STATUS to check its filter programming
  * status being successful or not and take actions accordingly. FCoE should
  * handle its context/filter programming/invalidation status and take actions.
  *
- * Returns an i40e_rx_buffer to reuse if the cleanup occurred, otherwise NULL.
+ * Returns false if what is passed is not a status descriptor.
  **/
-void i40e_clean_programming_status(struct i40e_ring *rx_ring, u64 qword0_raw,
-				   u64 qword1)
+bool i40e_clean_programming_status(struct i40e_ring *rx_ring, u64 qword0_raw,
+				   u64 qword1, u16 *next_to_process,
+				   u16 *next_to_clean)
 {
+	u16 ntp = *next_to_process;
 	u8 id;
 
+	if (!i40e_rx_is_programming_status(qword1))
+		return false;
+
 	id = FIELD_GET(I40E_RX_PROG_STATUS_DESC_QW1_PROGID_MASK, qword1);
 
 	if (id == I40E_RX_PROG_STATUS_DESC_FD_FILTER_STATUS)
 		i40e_fd_handle_status(rx_ring, qword0_raw, qword1, id);
+
+	if (++*next_to_process == rx_ring->count)
+		*next_to_process = 0;
+	if (ntp == *next_to_clean)
+		*next_to_clean = *next_to_process;
+
+	return true;
 }
 
 /**
@@ -1971,19 +1985,18 @@ static void i40e_rx_buffer_flip(struct i40e_rx_buffer *rx_buffer,
 }
 
 /**
- * i40e_get_rx_buffer - Fetch Rx buffer and synchronize data for use
+ * i40e_prepare_rx_buffer - Synchronize the buffer for use by the CPU
  * @rx_ring: rx descriptor ring to transact packets on
+ * @rx_buffer: the rx buffer
  * @size: size of buffer to add to skb
  *
- * This function will pull an Rx buffer from the ring and synchronize it
- * for use by the CPU.
+ * This function will synchronize the given buffer for use by the CPU.
  */
-static struct i40e_rx_buffer *i40e_get_rx_buffer(struct i40e_ring *rx_ring,
-						 const unsigned int size)
+static struct i40e_rx_buffer *
+i40e_prepare_rx_buffer(struct i40e_ring *rx_ring,
+		       struct i40e_rx_buffer *rx_buffer,
+		       const unsigned int size)
 {
-	struct i40e_rx_buffer *rx_buffer;
-
-	rx_buffer = i40e_rx_bi(rx_ring, rx_ring->next_to_process);
 	rx_buffer->page_count =
 #if (PAGE_SIZE < 8192)
 		page_count(rx_buffer->page);
@@ -2450,6 +2463,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
 		u16 ntp = rx_ring->next_to_process;
+		u16 ntc = rx_ring->next_to_clean;
 		struct i40e_rx_buffer *rx_buffer;
 		union i40e_rx_desc *rx_desc;
 		struct sk_buff *skb;
@@ -2480,21 +2494,15 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 		 */
 		dma_rmb();
 
-		if (i40e_rx_is_programming_status(qword)) {
-			i40e_clean_programming_status(rx_ring,
-						      rx_desc->raw.qword[0],
-						      qword);
-			rx_buffer = i40e_rx_bi(rx_ring, ntp);
-			i40e_inc_ntp(rx_ring);
+		rx_buffer = i40e_rx_bi(rx_ring, ntp);
+
+		if (i40e_clean_programming_status(rx_ring,
+						  rx_desc->raw.qword[0], qword,
+						  &rx_ring->next_to_process,
+						  &rx_ring->next_to_clean)) {
 			i40e_reuse_rx_page(rx_ring, rx_buffer);
-			/* Update ntc and bump cleaned count if not in the
-			 * middle of mb packet.
-			 */
-			if (rx_ring->next_to_clean == ntp) {
-				rx_ring->next_to_clean =
-					rx_ring->next_to_process;
+			if (ntc != rx_ring->next_to_clean)
 				cleaned_count++;
-			}
 			continue;
 		}
 
@@ -2503,8 +2511,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 			break;
 
 		i40e_trace(clean_rx_irq, rx_ring, rx_desc, xdp);
-		/* retrieve a buffer from the ring */
-		rx_buffer = i40e_get_rx_buffer(rx_ring, size);
+		i40e_prepare_rx_buffer(rx_ring, rx_buffer, size);
 
 		neop = i40e_is_non_eop(rx_ring, rx_desc);
 		i40e_inc_ntp(rx_ring);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
index e26807fd2123..21d9ed878bf0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
@@ -7,8 +7,9 @@
 #include "i40e.h"
 
 int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp, struct i40e_ring *xdp_ring);
-void i40e_clean_programming_status(struct i40e_ring *rx_ring, u64 qword0_raw,
-				   u64 qword1);
+bool i40e_clean_programming_status(struct i40e_ring *rx_ring, u64 qword0_raw,
+				   u64 qword1, u16 *next_to_clean,
+				   u16 *next_to_process);
 void i40e_process_skb_fields(struct i40e_ring *rx_ring,
 			     union i40e_rx_desc *rx_desc, struct sk_buff *skb);
 void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..f8accc266c2c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -440,14 +440,13 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		 */
 		dma_rmb();
 
-		if (i40e_rx_is_programming_status(qword)) {
-			i40e_clean_programming_status(rx_ring,
-						      rx_desc->raw.qword[0],
-						      qword);
-			bi = *i40e_rx_bi(rx_ring, next_to_process);
+		bi = *i40e_rx_bi(rx_ring, next_to_process);
+
+		if (i40e_clean_programming_status(rx_ring,
+						  rx_desc->raw.qword[0],
+						  qword, &next_to_process,
+						  &next_to_clean)) {
 			xsk_buff_free(bi);
-			if (++next_to_process == count)
-				next_to_process = 0;
 			continue;
 		}
 
@@ -455,7 +454,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		if (!size)
 			break;
 
-		bi = *i40e_rx_bi(rx_ring, next_to_process);
 		xsk_buff_set_size(bi, size);
 		xsk_buff_dma_sync_for_cpu(bi);
 
-- 
2.43.0


