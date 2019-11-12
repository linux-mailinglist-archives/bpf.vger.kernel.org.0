Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93CAF9479
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2019 16:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfKLPgT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Nov 2019 10:36:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44444 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfKLPgS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Nov 2019 10:36:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id f2so18982961wrs.11
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2019 07:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k17G4/k14hbg33i0y5emKB2JxsbyP5lZINIA3GVR6Ac=;
        b=vNZK49hL08luZcKZcNcKfN1l0ymztc0UsMX8ackvR3mqdcw+Pv2JwSJmkt96MtfoEi
         dyy0MAniEffSDa2q+7Zy/98OJfySrJOc8dYsqobLW392O8eJyuXPbnzdXQQTJEIScITd
         9DW+mV/22nfs3qdoy9Cuuh5VdhElFTDHORRig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k17G4/k14hbg33i0y5emKB2JxsbyP5lZINIA3GVR6Ac=;
        b=Q7+PlWWFwn0A3qD82PNlmsdQkpazaMEfSkB5PAcHTBVVtHeTe1VPmDKfjZsp3MwkOw
         WgzyyF+rbHapD1tAe9aI6yMTmqz7nPn0ry80Qmt3m73a7RykJpzeWanK++X4g/n4DkNm
         BPI/wYmi17xgZipDnkpHuhry5ynJ0RI+LDkrDVCbQq0bGu6u4ciYe5kWYNzQXPxS09uS
         dBMsNqFlPaCS375a8IT7/1CrNv4TuooiAbBwSQqpQoT3+YomeWnIpDtlNH22mEyk+vZc
         2p2AKn11hmMC5BICsU/lI9h5AFtwYfrBuwnyauJyKpBs8NiGJhfQgeQilU6vLjWBmh8P
         oiVg==
X-Gm-Message-State: APjAAAVr8PGAHdbIICCQul2UQj0A3VBRwhoGxK0U7OdjC40Nh6hPwSCK
        GqGLZTJ6Gr5DHtjI1NvQG5dokQ==
X-Google-Smtp-Source: APXvYqzwUrXvfa2S84jmvkf+1VHxA7jW0AXBWdIpOIYr1V07/+IUjlgLUHUcp7h5W4FRHudbPBwvRg==
X-Received: by 2002:a5d:5227:: with SMTP id i7mr7311556wra.277.1573572975840;
        Tue, 12 Nov 2019 07:36:15 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:6be3:785e:4546:dd8f])
        by smtp.gmail.com with ESMTPSA id f19sm35887935wrf.23.2019.11.12.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 07:36:14 -0800 (PST)
From:   Arthur Fabre <afabre@cloudflare.com>
To:     Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Charles McLachlan <cmclachlan@solarflare.com>,
        Martin Habets <mhabets@solarflare.com>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     kernel-team@cloudflare.com, Arthur Fabre <afabre@cloudflare.com>
Subject: [PATCH v2 net-next] sfc: trace_xdp_exception on XDP failure
Date:   Tue, 12 Nov 2019 15:36:01 +0000
Message-Id: <20191112153601.5849-1-afabre@cloudflare.com>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The sfc driver can drop packets processed with XDP, notably when running
out of buffer space on XDP_TX, or returning an unknown XDP action.
This increments the rx_xdp_bad_drops ethtool counter.

Call trace_xdp_exception everywhere rx_xdp_bad_drops is incremented,
except for fragmented RX packets as the XDP program hasn't run yet.
This allows it to easily be monitored from userspace.

This mirrors the behavior of other drivers.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---

Changes since v1:
- Removed trace_xdp_exception from receive fragements check, as XDP
  program hasn't been run yet

 drivers/net/ethernet/sfc/rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index a7d9841105d8..bec261905530 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -724,6 +724,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 				netif_err(efx, rx_err, efx->net_dev,
 					  "XDP TX failed (%d)\n", err);
 			channel->n_rx_xdp_bad_drops++;
+			trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
 		} else {
 			channel->n_rx_xdp_tx++;
 		}
@@ -737,6 +738,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 				netif_err(efx, rx_err, efx->net_dev,
 					  "XDP redirect failed (%d)\n", err);
 			channel->n_rx_xdp_bad_drops++;
+			trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
 		} else {
 			channel->n_rx_xdp_redirect++;
 		}
@@ -746,6 +748,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 		bpf_warn_invalid_xdp_action(xdp_act);
 		efx_free_rx_buffers(rx_queue, rx_buf, 1);
 		channel->n_rx_xdp_bad_drops++;
+		trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
 		break;
 
 	case XDP_ABORTED:
-- 
2.24.0.rc2

