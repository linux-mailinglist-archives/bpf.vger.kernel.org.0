Return-Path: <bpf+bounces-52082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE533A3DB9B
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 14:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94E61892472
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E651FAC54;
	Thu, 20 Feb 2025 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Moi3UME0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2853C1509A0;
	Thu, 20 Feb 2025 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059126; cv=none; b=hOIPP+jmdW4gg+LrucO0EVX3MIjz5hGMTTIMXMc4Lbfi79TS9UsfB2zSFVh+NQDFYgiP6Aee4yiHhmPzzYa20LxJyer2/lcW7Iq/kzJIRAlbljS5GwrJwGj+mo04JlDhZll/Fc9Na/Zv+uWDvBxLX2LJ/LUhCSp8pokJP/xCd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059126; c=relaxed/simple;
	bh=JI/Wwd8A4e4sWUCVqMbNoPp92TuHqN3f9dGGdJsEg04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WUTcS9EgKdG7osYBGA05yOldXGYt1kP/yz5IVxQdp7FQBSwhkVE0/LS8Pkuem2SR+nxyNOonimArXQeCenexBuYlg0N5AZusNzBRBx47os6jJEUL+BtdE602DZWsZph2EbExIgASOCftzNB3211kzqDOWP0gAm5HqxMAYm0fs4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Moi3UME0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740059125; x=1771595125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JI/Wwd8A4e4sWUCVqMbNoPp92TuHqN3f9dGGdJsEg04=;
  b=Moi3UME0+sl5sv59iBUN9OBNfC4lSbMkeAQCZk2PKD95s2Y45GppURuh
   89bgA0kH/VWNw4CBqrk9tZYyWOAKPeq+Xe9JZUOtmk/SRN+kIsR1m5T4g
   EY8m6YD4JAXJoYfa7ygTmq7h7mNi9IfztnzFHi3ZpDxjCIYhI09FcksOb
   SrDUw/rPK6HfZ8B4jJRbOI8rj0hw/WWt1QhA8eM5OxXXZwd1G41sQuVsl
   hCuWXuxISadG27vzru83v7EUCPkjnCIgdXOe0S7KP5t+GQi70c5W3Pieo
   R+mndOt74404DDq6vXIFndNfERPGU+DakoHt+azdBNVOiGSuIlBcTu3Tf
   g==;
X-CSE-ConnectionGUID: Srn4ZhbGSf2GpiKvyNfBdA==
X-CSE-MsgGUID: OTxskq0KTh2tnQAWzK41Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51479224"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="51479224"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 05:45:25 -0800
X-CSE-ConnectionGUID: skcWtEYTRLO8DjTiMiMjtg==
X-CSE-MsgGUID: 0bq/geJlSsG3kpYVmbIR2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119146263"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 20 Feb 2025 05:45:23 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	martin.lau@linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next 2/3] bpf: add kfunc for skb refcounting
Date: Thu, 20 Feb 2025 14:45:02 +0100
Message-Id: <20250220134503.835224-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
References: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These have been mostly taken from Amery Hung's work related to bpf qdisc
implementation. bpf_skb_{acquire,release}() are for increment/decrement
sk_buff::users whereas bpf_skb_destroy() is called for map entries that
have not been released and map is being wiped out from system.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/core/filter.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c4..9bd2701be088 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12064,6 +12064,56 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 
 __bpf_kfunc_end_defs();
 
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+/* bpf_skb_acquire - Acquire a reference to an skb. An skb acquired by this
+ * kfunc which is not stored in a map as a kptr, must be released by calling
+ * bpf_skb_release().
+ * @skb: The skb on which a reference is being acquired.
+ */
+__bpf_kfunc struct sk_buff *bpf_skb_acquire(struct sk_buff *skb)
+{
+	if (refcount_inc_not_zero(&skb->users))
+		return skb;
+	return NULL;
+}
+
+/* bpf_skb_release - Release the reference acquired on an skb.
+ * @skb: The skb on which a reference is being released.
+ */
+__bpf_kfunc void bpf_skb_release(struct sk_buff *skb)
+{
+	skb_unref(skb);
+}
+
+/* bpf_skb_destroy - Release an skb reference acquired and exchanged into
+ * an allocated object or a map.
+ * @skb: The skb on which a reference is being released.
+ */
+__bpf_kfunc void bpf_skb_destroy(struct sk_buff *skb)
+{
+	(void)skb_unref(skb);
+	consume_skb(skb);
+}
+
+__diag_pop();
+
+BTF_KFUNCS_START(skb_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_skb_acquire, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
+BTF_KFUNCS_END(skb_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set skb_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &skb_kfunc_btf_ids,
+};
+
+BTF_ID_LIST(skb_kfunc_dtor_ids)
+BTF_ID(struct, sk_buff)
+BTF_ID_FLAGS(func, bpf_skb_destroy, KF_RELEASE)
+
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 			       struct bpf_dynptr *ptr__uninit)
 {
@@ -12117,6 +12167,13 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
 
 static int __init bpf_kfunc_init(void)
 {
+	const struct btf_id_dtor_kfunc skb_kfunc_dtors[] = {
+		{
+			.btf_id       = skb_kfunc_dtor_ids[0],
+			.kfunc_btf_id = skb_kfunc_dtor_ids[1]
+		},
+	};
+
 	int ret;
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb);
@@ -12133,6 +12190,11 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &skb_kfunc_set);
+
+	ret = ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
+						 ARRAY_SIZE(skb_kfunc_dtors),
+						 THIS_MODULE);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
 }
 late_initcall(bpf_kfunc_init);
-- 
2.43.0


