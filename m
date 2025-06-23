Return-Path: <bpf+bounces-61298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67302AE49EA
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 18:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B8918843D8
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A426028DF3B;
	Mon, 23 Jun 2025 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HZR9Cz4d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D961C84A1
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694804; cv=none; b=MUtbHS7J6BibhzPyQJv3Ah7aOUMSeCcEWl20rqji5LFifFPBspj2PMCMDf3s3j7CxRO7VchXy0odoLYYj3gdO36t4rZMipBE83hC5T8nzfX1xcJ0A3L/EK0OXjh2/23yrA0bgtjy4MmedBcujImbA8rEYgerP8z6easIe8gZfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694804; c=relaxed/simple;
	bh=Mi/60CA7Ydz3R+PY7UFNgNc1KYMFHge7mElfLwWKOr8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J5rnC+rDio/l+yHRjhXmsrGg5d3Hc87Q9k7B2fi9fbRFWzA1SFUNTCW4xGjXbU9FC4TF8idYZSHUv4oEMWl4+GiOZajX3WCVk2z6rwBjU3YkW1/osNHiBEmy9kdYkIK5qcEG3DpGan5W+yc782dZZnDRRlcmUQW3lXB5NUaCzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HZR9Cz4d; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a585dc5f4aso52779821cf.2
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1750694801; x=1751299601; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ktC6cfOVZ/76Z0Ijy6OOpcQ17JdhB2dNNAa6r8b5k90=;
        b=HZR9Cz4dpBF6zvt6bbVFA/8QW+qOjnBv3pj+SgGnlEerrAmoSn1JrfXxWlLHAA2Ogs
         Lr2pzCKYHLt5GwFCBh201FMKxDBjqofdtwJLOnl+wdgGfRauyg3Ucc49hB1dusnp/RBh
         pOeDEW5iN9rkXSDGaeNH1po0ohysR3fqh6fLaofVHr5Jcw86OpaR5xXh3jbXAak81GaF
         oDzn3c5NsiMt2zrtuz+JymjMXYXPwssnzrj3Gb9UiW2EhvinEKCcPrWUZ54VPNPxjz6c
         OupEzcCi9HswQdllA0QIVvzV51HvsbYyk2KyxECpepv4uoKU4dmbE8aMgRWbn00mFOUz
         x+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750694801; x=1751299601;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktC6cfOVZ/76Z0Ijy6OOpcQ17JdhB2dNNAa6r8b5k90=;
        b=Wg6CLXkh/YoQeAvoPlBtazvMj8E6j8/DoirrwU2dJQAJrzS+PGqLWEZIOTG8JTqI7V
         F0zCN2IRDU7mVwUWuWIwalJtE74QR9fwycDTW9FfOg+78Dah6W/EuModm5R3mdoTaCL5
         XV80wlPtLSZ96+apVqnxMav4TDzqhRcmy6AtmPjWcwIeHlCP9H+7S8NCxW69VzCjGT0G
         +ZMrtv/bFh1kD/RvbW+g4iBmUoyD2LBGRPBOeQyOYpqFYB7faQ0C08U2T1fgE0FBgFlJ
         yWhE6te65FOZOQ9NX5iF2ei+S6eP4UTT80Fv8nAMLfPsViTCDrY+tKNaZE0pMwmpU2mc
         xI0w==
X-Forwarded-Encrypted: i=1; AJvYcCUKENlLzH1t7Yhh23SnqI7Dp83qy2XsdVS+drFKZboIdBTc8Xo0uUS4pt9117hll6TyWBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZMEe+XYNErvgtdM1/VfK3Uo1bFWw33B3i8o+Sy6x3Xx+s2Dz
	IqN+qsuj37zgb3h+qQwarh5+EwJxOfyXtMA8UQE/HzKGlTgS3TYmxHCdpvkU5gRuXu8=
X-Gm-Gg: ASbGncta5nojQ7INp5FaOzDO4eXNmko0psh7uNU1XLwKia1gIPdr2ANVzqZREwJPDwD
	TR9rYsErnc1cC+GBwfdn1DqBhGceeInExPo1gJk4SRH50gX0dBdOf6t2FYHYueKfO/ABNH6tb/B
	qgIESZPPu2422P0pSFmroM3UGYpDvEIcFRsZvTFggjhQMF7Kinx8QKDXPcMVXej3uFCAMGbIdzN
	1L90VXaUnnFdRijP8rFNXuUraQGLm837zrh/UfzQWt2JlguTYU2lJEHJCConXKNQg8VU3fpGODa
	9rkNo+IUJxxKzLsRk34TSTHeL8Dtcv9HXWdeuivuTodGpOEygys=
X-Google-Smtp-Source: AGHT+IGoR8ANNdKqeXSB6QUjUR7YL2sWmX6fZq3ocRFUEgh9F0Tx0iW7Wm2+7Ic1YaQV1+hJP8HI+A==
X-Received: by 2002:a05:620a:319b:b0:7d3:9ba1:a044 with SMTP id af79cd13be357-7d3f9923097mr1677605985a.33.1750694801144;
        Mon, 23 Jun 2025 09:06:41 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:1cd2::2df:3a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3ffdb190esm349258785a.86.2025.06.23.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:06:40 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:06:38 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH net] bnxt: properly flush XDP redirect lists
Message-ID: <aFl7jpCNzscumuN2@debian.debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We encountered following crash when testing a XDP_REDIRECT feature
in production:

[56251.579676] list_add corruption. next->prev should be prev (ffff93120dd40f30), but was ffffb301ef3a6740. (next=ffff93120dd
40f30).
[56251.601413] ------------[ cut here ]------------
[56251.611357] kernel BUG at lib/list_debug.c:29!
[56251.621082] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[56251.632073] CPU: 111 UID: 0 PID: 0 Comm: swapper/111 Kdump: loaded Tainted: P           O       6.12.33-cloudflare-2025.6.
3 #1
[56251.653155] Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE
[56251.663877] Hardware name: MiTAC GC68B-B8032-G11P6-GPU/S8032GM-HE-CFR, BIOS V7.020.B10-sig 01/22/2025
[56251.682626] RIP: 0010:__list_add_valid_or_report+0x4b/0xa0
[56251.693203] Code: 0e 48 c7 c7 68 e7 d9 97 e8 42 16 fe ff 0f 0b 48 8b 52 08 48 39 c2 74 14 48 89 f1 48 c7 c7 90 e7 d9 97 48
 89 c6 e8 25 16 fe ff <0f> 0b 4c 8b 02 49 39 f0 74 14 48 89 d1 48 c7 c7 e8 e7 d9 97 4c 89
[56251.725811] RSP: 0018:ffff93120dd40b80 EFLAGS: 00010246
[56251.736094] RAX: 0000000000000075 RBX: ffffb301e6bba9d8 RCX: 0000000000000000
[56251.748260] RDX: 0000000000000000 RSI: ffff9149afda0b80 RDI: ffff9149afda0b80
[56251.760349] RBP: ffff9131e49c8000 R08: 0000000000000000 R09: ffff93120dd40a18
[56251.772382] R10: ffff9159cf2ce1a8 R11: 0000000000000003 R12: ffff911a80850000
[56251.784364] R13: ffff93120fbc7000 R14: 0000000000000010 R15: ffff9139e7510e40
[56251.796278] FS:  0000000000000000(0000) GS:ffff9149afd80000(0000) knlGS:0000000000000000
[56251.809133] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[56251.819561] CR2: 00007f5e85e6f300 CR3: 00000038b85e2006 CR4: 0000000000770ef0
[56251.831365] PKRU: 55555554
[56251.838653] Call Trace:
[56251.845560]  <IRQ>
[56251.851943]  cpu_map_enqueue.cold+0x5/0xa
[56251.860243]  xdp_do_redirect+0x2d9/0x480
[56251.868388]  bnxt_rx_xdp+0x1d8/0x4c0 [bnxt_en]
[56251.877028]  bnxt_rx_pkt+0x5f7/0x19b0 [bnxt_en]
[56251.885665]  ? cpu_max_write+0x1e/0x100
[56251.893510]  ? srso_alias_return_thunk+0x5/0xfbef5
[56251.902276]  __bnxt_poll_work+0x190/0x340 [bnxt_en]
[56251.911058]  bnxt_poll+0xab/0x1b0 [bnxt_en]
[56251.919041]  ? srso_alias_return_thunk+0x5/0xfbef5
[56251.927568]  ? srso_alias_return_thunk+0x5/0xfbef5
[56251.935958]  ? srso_alias_return_thunk+0x5/0xfbef5
[56251.944250]  __napi_poll+0x2b/0x160
[56251.951155]  bpf_trampoline_6442548651+0x79/0x123
[56251.959262]  __napi_poll+0x5/0x160
[56251.966037]  net_rx_action+0x3d2/0x880
[56251.973133]  ? srso_alias_return_thunk+0x5/0xfbef5
[56251.981265]  ? srso_alias_return_thunk+0x5/0xfbef5
[56251.989262]  ? __hrtimer_run_queues+0x162/0x2a0
[56251.996967]  ? srso_alias_return_thunk+0x5/0xfbef5
[56252.004875]  ? srso_alias_return_thunk+0x5/0xfbef5
[56252.012673]  ? bnxt_msix+0x62/0x70 [bnxt_en]
[56252.019903]  handle_softirqs+0xcf/0x270
[56252.026650]  irq_exit_rcu+0x67/0x90
[56252.032933]  common_interrupt+0x85/0xa0
[56252.039498]  </IRQ>
[56252.044246]  <TASK>
[56252.048935]  asm_common_interrupt+0x26/0x40
[56252.055727] RIP: 0010:cpuidle_enter_state+0xb8/0x420
[56252.063305] Code: dc 01 00 00 e8 f9 79 3b ff e8 64 f7 ff ff 49 89 c5 0f 1f 44 00 00 31 ff e8 a5 32 3a ff 45 84 ff 0f 85 ae
 01 00 00 fb 45 85 f6 <0f> 88 88 01 00 00 48 8b 04 24 49 63 ce 4c 89 ea 48 6b f1 68 48 29
[56252.088911] RSP: 0018:ffff93120c97fe98 EFLAGS: 00000202
[56252.096912] RAX: ffff9149afd80000 RBX: ffff9141d3a72800 RCX: 0000000000000000
[56252.106844] RDX: 00003329176c6b98 RSI: ffffffe36db3fdc7 RDI: 0000000000000000
[56252.116733] RBP: 0000000000000002 R08: 0000000000000002 R09: 000000000000004e
[56252.126652] R10: ffff9149afdb30c4 R11: 071c71c71c71c71c R12: ffffffff985ff860
[56252.136637] R13: 00003329176c6b98 R14: 0000000000000002 R15: 0000000000000000
[56252.146667]  ? cpuidle_enter_state+0xab/0x420
[56252.153909]  cpuidle_enter+0x2d/0x40
[56252.160360]  do_idle+0x176/0x1c0
[56252.166456]  cpu_startup_entry+0x29/0x30
[56252.173248]  start_secondary+0xf7/0x100
[56252.179941]  common_startup_64+0x13e/0x141
[56252.186886]  </TASK>

From the crash dump, we found that the cpu_map_flush_list inside
redirect info is partially corrupted: its list_head->next points to
itself, but list_head->prev points to a valid list of unflushed bq
entries.

This turned out to be a result of missed XDP flush on redirect lists. By
digging in the actual source code, we found that
commit 7f0a168b0441 ("bnxt_en: Add completion ring pointer in TX and RX
ring structures") incorrectly overwrites the event mask for XDP_REDIRECT
in bnxt_rx_xdp. We can stably reproduce this crash by returning XDP_TX
and XDP_REDIRECT randomly for incoming packets in a naive XDP program.
Properly propagate the XDP_REDIRECT events back fixes the crash.

Fixes: 7f0a168b0441 ("bnxt_en: Add completion ring pointer in TX and RX ring structures")
Tested-by: Andrew Rzeznik <arzeznik@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2cb3185c442c..ae89a981e052 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2989,6 +2989,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 {
 	struct bnxt_napi *bnapi = cpr->bnapi;
 	u32 raw_cons = cpr->cp_raw_cons;
+	bool flush_xdp = false;
 	u32 cons;
 	int rx_pkts = 0;
 	u8 event = 0;
@@ -3042,6 +3043,8 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			else
 				rc = bnxt_force_rx_discard(bp, cpr, &raw_cons,
 							   &event);
+			if (event & BNXT_REDIRECT_EVENT)
+				flush_xdp = true;
 			if (likely(rc >= 0))
 				rx_pkts += rc;
 			/* Increment rx_pkts when rc is -ENOMEM to count towards
@@ -3066,7 +3069,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		}
 	}
 
-	if (event & BNXT_REDIRECT_EVENT) {
+	if (flush_xdp) {
 		xdp_do_flush();
 		event &= ~BNXT_REDIRECT_EVENT;
 	}
-- 
2.39.5



