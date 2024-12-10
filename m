Return-Path: <bpf+bounces-46484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730969EA715
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D370288C91
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCFF226160;
	Tue, 10 Dec 2024 04:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5oTZDTU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444592248B3
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 04:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803877; cv=none; b=rDBhAmN0fdsmwMWYPfTv3fqtZAxfjTHBsv4H4FstkAzYnqJCQSgTEP24f9e2/Qqdy9sam8a95x25GpebFTgmFfFgRsDlukKi0sxtdKay595UZHaQiCOMFKOyp5G0T6zR1HBUBqvnSRg8aCp5JYY0OfI9+2fdXU03yJiWiO5StsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803877; c=relaxed/simple;
	bh=a9a5bDwU6ShIZlOC+79WCuNVJCFXLQBDM/WxaKA1E5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ot0shQDLLtmKKaCvKgfXqKL7rnFF/HatIG6cpY15Hes1M6P+GUQEd9/hy5UXyyElq8SAN+7EHRBPsaWsKzmkC+LsFAxAt+9yjsLmx4MwgGshmttkkhgiFZuctmaZbcwOYI6/qQxoaaQ0liDEgWu2JVGl93rPn5U6vkiZou38Sas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5oTZDTU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166f1e589cso6795045ad.3
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 20:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733803875; x=1734408675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF6MVln4LC9hUMsccdpl2mvsSb4BSYKAburlVkwvkJQ=;
        b=H5oTZDTUXOTx3M/0IVucOHOKRZWM1KORhOGRltdt/ek6saByXVcJvPeji/8kGoYqw5
         mYAIMyaysSOBHV9Elap2YHYChi+nDxvPsNCcV/gjTcyDlZ5tETKO2f6mx0t+xgzMiU4c
         9WRansBRHIupkIUhdzMQOB3iYFY0rJ/Ns54RwedRYWlFNjF89QfEdiYZ8q8h7CuntLtR
         CU1K40wBX0y5JfOMli/8xXo5TVdYACwEvc5mI/KcPErH41OIFJgjmHDudOYHOOTGnodK
         CiRoP0Y5hmlmC4na3KuIGMoF6612zaqCwQGwK8ODhMpEjHdJG6Pqnf+Nz+BLDkkNx2Sw
         KIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733803875; x=1734408675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aF6MVln4LC9hUMsccdpl2mvsSb4BSYKAburlVkwvkJQ=;
        b=wvvrgz8zm6vtOZHKgAKzpl53Ik7b6aNQHTQ623U8EwOxzdqalfwCfjKAnZf41oA9Jd
         mMa98qG30Lb2NfSNnSwsy6B2Fdd8YVsSbbDL7G34PAcYTl/gHwfJYt9d/fYGpAaTjuRT
         LVlAuk8WPfDBB38TbnDUpbGQ0+MWF67PksxXgb4wd5KZhwKcm/sQglEteGCj5bGJu3km
         o8IU1uQyt9W8+qDXCc8h1AsgEHlvYGE3DFC4GoLqz5QGwUGVe22DIJ3IVban7qWCZ+/x
         vgZYXqVPeRkbRyL7ESciMFdoh1PD8kPN3Ozqwgxrm3ztG0qs1MyZxwXODil18DyjLL9j
         kYZA==
X-Gm-Message-State: AOJu0YxGJLPq64+VuSQcJdCPUXru4Fk5/bpZCVm3eTqRDnQc+nfmGgkh
	qi3ekoWGlsGrkW8I9bnIoxPtrRCRaN0YyeCRx3ePQmsigX5mUoF/MPS0pw==
X-Gm-Gg: ASbGnctvAXO0wMtzi99PQ8R8uxg8iLbdWULNgR3IQPj7xh84+yFB1OGiZE6SnHSiog5
	AWc6KOcK7moVvDL9jWkKifOF7Nq9F6EAsxOiJUhkKQUkfHUe3L6XEtAzjHjrU2WQ44dVVll8IMa
	WQ8LdJKHyRYpIhuldvnPalRAkMOX+tRg1xV/+5qdqDeQJpPquXubAEbmdHeoB8dsTuAZ5UQ9Ljj
	CVbu3B9lUOJ5Cs9DgFwhFLUJZHdugJ2TXCxZYb6Pt7ZMBpASQ==
X-Google-Smtp-Source: AGHT+IEB23VYOpDKLG7g1xmwR+pEpqAmiQxzNr3Pdm01XXnc8+KEdkB47MsvNy0KAWc4gPdwgHR5cg==
X-Received: by 2002:a17:902:f60c:b0:215:75a5:f72b with SMTP id d9443c01a7336-2166a0ba37emr49888855ad.53.1733803875203;
        Mon, 09 Dec 2024 20:11:15 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21631d6b3b8sm44296265ad.136.2024.12.09.20.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:11:14 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	mejedi@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v2 2/8] bpf: refactor bpf_helper_changes_pkt_data to use helper number
Date: Mon,  9 Dec 2024 20:10:54 -0800
Message-ID: <20241210041100.1898468-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210041100.1898468-1-eddyz87@gmail.com>
References: <20241210041100.1898468-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use BPF helper number instead of function pointer in
bpf_helper_changes_pkt_data(). This would simplify usage of this
function in verifier.c:check_cfg() (in a follow-up patch),
where only helper number is easily available and there is no real need
to lookup helper proto.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/filter.h |  2 +-
 kernel/bpf/core.c      |  2 +-
 kernel/bpf/verifier.c  |  2 +-
 net/core/filter.c      | 63 +++++++++++++++++++-----------------------
 4 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 3a21947f2fd4..0477254bc2d3 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1122,7 +1122,7 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 bool bpf_jit_supports_private_stack(void);
 u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
-bool bpf_helper_changes_pkt_data(void *func);
+bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id);
 
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
 {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a2327c4fdc8b..6fa8041d4831 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2936,7 +2936,7 @@ void __weak bpf_jit_compile(struct bpf_prog *prog)
 {
 }
 
-bool __weak bpf_helper_changes_pkt_data(void *func)
+bool __weak bpf_helper_changes_pkt_data(enum bpf_func_id func_id)
 {
 	return false;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 277c1892bb9a..ad3f6d28e8e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10728,7 +10728,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 
 	/* With LD_ABS/IND some JITs save/restore skb from r1. */
-	changes_data = bpf_helper_changes_pkt_data(fn->func);
+	changes_data = bpf_helper_changes_pkt_data(func_id);
 	if (changes_data && fn->arg1_type != ARG_PTR_TO_CTX) {
 		verbose(env, "kernel subsystem misconfigured func %s#%d: r1 != ctx\n",
 			func_id_name(func_id), func_id);
diff --git a/net/core/filter.c b/net/core/filter.c
index 6625b3f563a4..efb75eed2e35 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7899,42 +7899,35 @@ static const struct bpf_func_proto bpf_tcp_raw_check_syncookie_ipv6_proto = {
 
 #endif /* CONFIG_INET */
 
-bool bpf_helper_changes_pkt_data(void *func)
-{
-	if (func == bpf_skb_vlan_push ||
-	    func == bpf_skb_vlan_pop ||
-	    func == bpf_skb_store_bytes ||
-	    func == bpf_skb_change_proto ||
-	    func == bpf_skb_change_head ||
-	    func == sk_skb_change_head ||
-	    func == bpf_skb_change_tail ||
-	    func == sk_skb_change_tail ||
-	    func == bpf_skb_adjust_room ||
-	    func == sk_skb_adjust_room ||
-	    func == bpf_skb_pull_data ||
-	    func == sk_skb_pull_data ||
-	    func == bpf_clone_redirect ||
-	    func == bpf_l3_csum_replace ||
-	    func == bpf_l4_csum_replace ||
-	    func == bpf_xdp_adjust_head ||
-	    func == bpf_xdp_adjust_meta ||
-	    func == bpf_msg_pull_data ||
-	    func == bpf_msg_push_data ||
-	    func == bpf_msg_pop_data ||
-	    func == bpf_xdp_adjust_tail ||
-#if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
-	    func == bpf_lwt_seg6_store_bytes ||
-	    func == bpf_lwt_seg6_adjust_srh ||
-	    func == bpf_lwt_seg6_action ||
-#endif
-#ifdef CONFIG_INET
-	    func == bpf_sock_ops_store_hdr_opt ||
-#endif
-	    func == bpf_lwt_in_push_encap ||
-	    func == bpf_lwt_xmit_push_encap)
+bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id)
+{
+	switch (func_id) {
+	case BPF_FUNC_clone_redirect:
+	case BPF_FUNC_l3_csum_replace:
+	case BPF_FUNC_l4_csum_replace:
+	case BPF_FUNC_lwt_push_encap:
+	case BPF_FUNC_lwt_seg6_action:
+	case BPF_FUNC_lwt_seg6_adjust_srh:
+	case BPF_FUNC_lwt_seg6_store_bytes:
+	case BPF_FUNC_msg_pop_data:
+	case BPF_FUNC_msg_pull_data:
+	case BPF_FUNC_msg_push_data:
+	case BPF_FUNC_skb_adjust_room:
+	case BPF_FUNC_skb_change_head:
+	case BPF_FUNC_skb_change_proto:
+	case BPF_FUNC_skb_change_tail:
+	case BPF_FUNC_skb_pull_data:
+	case BPF_FUNC_skb_store_bytes:
+	case BPF_FUNC_skb_vlan_pop:
+	case BPF_FUNC_skb_vlan_push:
+	case BPF_FUNC_store_hdr_opt:
+	case BPF_FUNC_xdp_adjust_head:
+	case BPF_FUNC_xdp_adjust_meta:
+	case BPF_FUNC_xdp_adjust_tail:
 		return true;
-
-	return false;
+	default:
+		return false;
+	}
 }
 
 const struct bpf_func_proto bpf_event_output_data_proto __weak;
-- 
2.47.0


