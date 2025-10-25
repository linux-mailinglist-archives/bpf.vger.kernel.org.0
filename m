Return-Path: <bpf+bounces-72190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C728C09644
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 18:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8AD4206CD
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAF2305E10;
	Sat, 25 Oct 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uw5SXbBi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F37725DB1A;
	Sat, 25 Oct 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409053; cv=none; b=T+nhOr9K+GVQdoRI7csfhOrazchznL7o4E4AfJTpkCF437svRk4WwQiYJ4DvMP6oLV/jQnMDVmiMY8J46fWfFnycMW1D4/k2CcGSYKxfl2YaWbJx7Su2Y/1+bO6DqRvnUEd28wNf3s5zfjQGaqmt+lRM0Sy3b3mxYkKcaxKKTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409053; c=relaxed/simple;
	bh=D8G4IjAJAqWB3KeYAjtPUEUlzXJZkrngtoQG2vgZKB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVINhqxJW+O73x21PaYQEs4iuJtyCTG7NWIp6YWjdakS43LP+9KTwarH2KvViM8bNMtv8diXx0ZkASl1C1iNVblTfzlGyJLqnuZFtpJXRVO0dcfV6DJRPZWhJoVhI9wApOcFeIk+8L78rkdXpBf0FTuCHVvmIWcw0K1bknT87Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uw5SXbBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D31EC4CEFB;
	Sat, 25 Oct 2025 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409053;
	bh=D8G4IjAJAqWB3KeYAjtPUEUlzXJZkrngtoQG2vgZKB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uw5SXbBiuIC44hv5UMxhha1tTW4F/h3uNFTjfgZTUTqrRBAZ2orcQT/vV+vSgJYDc
	 NkrHJdghWAKGGy/tF+eLaPZEXoM/uFUK5f+dUWXWWE8g5Jo6JIk8q4avwaLOTwDL0L
	 f9BOpCpQPfvOIMNeGnyrW1gZ5UcCR4Do+nAVj7Sf3+PjU1k2XFA+pIxdgdhVlbyvuX
	 l+ad2CyqUoz+TKmJTjdSi5qTaF9J7BWZWw7US1UWmehYLwOy9TGn1fmFhBYDoyg635
	 AOSPmVLKk+gOKJsNnQiM5ckNCHRjAwI8KlDJn0FVZKoQeUGvf6pT5YuLWaYrSDh937
	 SniUliKLRKrmw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] ice: Don't use %pK through printk or tracepoints
Date: Sat, 25 Oct 2025 11:56:56 -0400
Message-ID: <20251025160905.3857885-185-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit 66ceb45b7d7e9673254116eefe5b6d3a44eba267 ]

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20250811-restricted-pointers-net-v5-1-2e2fdc7d3f2c@linutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What changes: The patch replaces %pK with %p in a single debug printk
  and several tracepoint TP_printk format strings:
  - drivers/net/ethernet/intel/ice/ice_main.c:9112
  - drivers/net/ethernet/intel/ice/ice_trace.h:133, 161, 185, 208, 231

- Why it matters:
  - %p hashing is safe since v4.15: Commit ad67b74d2469 (“printk: hash
    addresses printed with %p”) ensures %p prints hashed addresses by
    default, avoiding raw pointer leaks.
    - See lib/vsprintf.c:837-848 for the %p default hashing path.
  - %pK is problematic in printk/tracepoints:
    - In IRQ/softirq/NMI when kptr_restrict==1 (a common distro
      hardening default), %pK deliberately refuses to operate and emits
      “pK-error” instead of a pointer, degrading trace readability and
      consistency in hot paths like TX/RX cleanups.
      - See lib/vsprintf.c:850 (kptr_restrict) and
        lib/vsprintf.c:864-871 (IRQ/softirq/NMI path to “pK-error”).
    - The restricted-pointer policy was never intended for
      printk/tracepoints; using %pK can also involve capability/cred
      checks that are inappropriate in atomic contexts.
  - ice tracepoints are often hit from NAPI/IRQ context. The current %pK
    usage in:
    - ice_trace.h:133, 161, 185, 208, 231 (ring/desc/buf/skb pointers)
    can produce “pK-error” under kptr_restrict==1 instead of hashed
values, while %p provides consistent, safe hashed output.
  - The dev_dbg change in drivers/net/ethernet/intel/ice/ice_main.c:9112
    similarly aligns with the policy of avoiding %pK in printk; %p
    remains non-leaky (hashed).

- Risk assessment:
  - Minimal and contained: only format strings change; no functional
    logic, state, or ABI changes to tracepoint fields (the field layout
    defined by __field/__string is unchanged; only TP_printk’s human-
    readable text changes).
  - No cross-subsystem dependencies or architectural impact.
  - Improves safety/observability without adding new features.

- Precedent in stable: Multiple similar “Don’t use %pK through printk”
  patches have already been accepted into stable trees, citing the same
  rationale:
  - bpf: b2131336289fa
  - timer_list: 3fb9ee05ec15f
  - spi loopback-test: e0bdc3d17b388
  Each includes a Sasha Levin Signed-off-by indicating stable
backporting.

- Stable policy fit:
  - Fixes a real issue for users who rely on trace readability under
    hardened kptr_restrict settings and removes a misuse of %pK in
    printk/tracepoints.
  - Small, self-contained, low regression risk, no new features,
    confined to a driver.

- Compatibility note: All maintained LTS series (>= v4.19) already
  include %p hashing from v4.15, so this change is safe across active
  stable kernels.

Conclusion: Backporting this patch improves correctness and safety of
diagnostic output in the ice driver with negligible risk and clear
precedent.

 drivers/net/ethernet/intel/ice/ice_main.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_trace.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 77781277aa8e4..92b95d92d5992 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9125,7 +9125,7 @@ static int ice_create_q_channels(struct ice_vsi *vsi)
 		list_add_tail(&ch->list, &vsi->ch_list);
 		vsi->tc_map_vsi[i] = ch->ch_vsi;
 		dev_dbg(ice_pf_to_dev(pf),
-			"successfully created channel: VSI %pK\n", ch->ch_vsi);
+			"successfully created channel: VSI %p\n", ch->ch_vsi);
 	}
 	return 0;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ethernet/intel/ice/ice_trace.h
index 07aab6e130cd5..4f35ef8d6b299 100644
--- a/drivers/net/ethernet/intel/ice/ice_trace.h
+++ b/drivers/net/ethernet/intel/ice/ice_trace.h
@@ -130,7 +130,7 @@ DECLARE_EVENT_CLASS(ice_tx_template,
 				   __entry->buf = buf;
 				   __assign_str(devname);),
 
-		    TP_printk("netdev: %s ring: %pK desc: %pK buf %pK", __get_str(devname),
+		    TP_printk("netdev: %s ring: %p desc: %p buf %p", __get_str(devname),
 			      __entry->ring, __entry->desc, __entry->buf)
 );
 
@@ -158,7 +158,7 @@ DECLARE_EVENT_CLASS(ice_rx_template,
 				   __entry->desc = desc;
 				   __assign_str(devname);),
 
-		    TP_printk("netdev: %s ring: %pK desc: %pK", __get_str(devname),
+		    TP_printk("netdev: %s ring: %p desc: %p", __get_str(devname),
 			      __entry->ring, __entry->desc)
 );
 DEFINE_EVENT(ice_rx_template, ice_clean_rx_irq,
@@ -182,7 +182,7 @@ DECLARE_EVENT_CLASS(ice_rx_indicate_template,
 				   __entry->skb = skb;
 				   __assign_str(devname);),
 
-		    TP_printk("netdev: %s ring: %pK desc: %pK skb %pK", __get_str(devname),
+		    TP_printk("netdev: %s ring: %p desc: %p skb %p", __get_str(devname),
 			      __entry->ring, __entry->desc, __entry->skb)
 );
 
@@ -205,7 +205,7 @@ DECLARE_EVENT_CLASS(ice_xmit_template,
 				   __entry->skb = skb;
 				   __assign_str(devname);),
 
-		    TP_printk("netdev: %s skb: %pK ring: %pK", __get_str(devname),
+		    TP_printk("netdev: %s skb: %p ring: %p", __get_str(devname),
 			      __entry->skb, __entry->ring)
 );
 
@@ -228,7 +228,7 @@ DECLARE_EVENT_CLASS(ice_tx_tstamp_template,
 		    TP_fast_assign(__entry->skb = skb;
 				   __entry->idx = idx;),
 
-		    TP_printk("skb %pK idx %d",
+		    TP_printk("skb %p idx %d",
 			      __entry->skb, __entry->idx)
 );
 #define DEFINE_TX_TSTAMP_OP_EVENT(name) \
-- 
2.51.0


