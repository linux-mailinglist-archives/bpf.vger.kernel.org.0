Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACC22DF34F
	for <lists+bpf@lfdr.de>; Sun, 20 Dec 2020 04:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgLTDho (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Dec 2020 22:37:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbgLTDgi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Dec 2020 22:36:38 -0500
From:   Sasha Levin <sashal@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dongdong Wang <wangdongdong.6@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <cong.wang@bytedance.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/10] lwt: Disable BH too in run_lwt_bpf()
Date:   Sat, 19 Dec 2020 22:34:51 -0500
Message-Id: <20201220033457.2728519-4-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201220033457.2728519-1-sashal@kernel.org>
References: <20201220033457.2728519-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Dongdong Wang <wangdongdong.6@bytedance.com>

[ Upstream commit d9054a1ff585ba01029584ab730efc794603d68f ]

The per-cpu bpf_redirect_info is shared among all skb_do_redirect()
and BPF redirect helpers. Callers on RX path are all in BH context,
disabling preemption is not sufficient to prevent BH interruption.

In production, we observed strange packet drops because of the race
condition between LWT xmit and TC ingress, and we verified this issue
is fixed after we disable BH.

Although this bug was technically introduced from the beginning, that
is commit 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure"),
at that time call_rcu() had to be call_rcu_bh() to match the RCU context.
So this patch may not work well before RCU flavor consolidation has been
completed around v5.0.

Update the comments above the code too, as call_rcu() is now BH friendly.

Signed-off-by: Dongdong Wang <wangdongdong.6@bytedance.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>
Link: https://lore.kernel.org/bpf/20201205075946.497763-1-xiyou.wangcong@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/lwt_bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 99a6de52b21da..a5502c5aa44e7 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -39,12 +39,11 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 {
 	int ret;
 
-	/* Preempt disable is needed to protect per-cpu redirect_info between
-	 * BPF prog and skb_do_redirect(). The call_rcu in bpf_prog_put() and
-	 * access to maps strictly require a rcu_read_lock() for protection,
-	 * mixing with BH RCU lock doesn't work.
+	/* Preempt disable and BH disable are needed to protect per-cpu
+	 * redirect_info between BPF prog and skb_do_redirect().
 	 */
 	preempt_disable();
+	local_bh_disable();
 	bpf_compute_data_pointers(skb);
 	ret = bpf_prog_run_save_cb(lwt->prog, skb);
 
@@ -78,6 +77,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		break;
 	}
 
+	local_bh_enable();
 	preempt_enable();
 
 	return ret;
-- 
2.27.0

