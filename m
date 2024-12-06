Return-Path: <bpf+bounces-46239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB119E653E
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 05:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D35281A6C
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 04:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8C51940B2;
	Fri,  6 Dec 2024 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIKHbirg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F409175BF
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733457807; cv=none; b=UVFaB86S6aO3xNVbmDNCp2alKKbmM75shNdqwq0jpkXlS8IKSJVC4DziheuUh+Ll82i081bJzaoa15KU8Zy0N/4QT3Dik8uP4SHFPCe7lndR0dKxCO8FDBPVpTatenUjkFbsJVRVS1TMXX0ynJhKSkY/XQ11YPoKU+0ucs5b7Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733457807; c=relaxed/simple;
	bh=a9a5bDwU6ShIZlOC+79WCuNVJCFXLQBDM/WxaKA1E5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXkUZgc1k/RNKwlTUZhY/0rMB8rk41zDsTAbXpVnPyKpE1//tPS/bk7WCdgySYvJHR7XXIZ43f7O8/6LWsUXK8aDo4VtJPkiYfeYYtBoC39N9qiywBKcmUgjvS00MS+LAo1SbkZdRkkoCsfILGW6dUhwY+0coM2zP53YcjX5M3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIKHbirg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef6af22ea8so328049a91.0
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 20:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733457805; x=1734062605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF6MVln4LC9hUMsccdpl2mvsSb4BSYKAburlVkwvkJQ=;
        b=RIKHbirg5abHWSgwckgxT6yW1UyvKeJpYvZx+ZcidlgCPYlxLO/Fi6wqyc3iTd7hwO
         8Iagscydl8w3CjkdDCcF/fC/ho4q7qVbtmkPiUZ3WMHwj/mOIW4jsmRmGiemcNW2hiOl
         SLG15DJqW+L8AvR/TcYnz375aOjw4HvPhRIjGDcy7ajAGhJCtVWoZtcRLBne0ug1H1l2
         49grlqfkU4onVgX7eCpl4l7ZjdTtN8/icZGl73VxbQVabIedFoyvIaaQnHA0WyhabFfc
         QgQ2DIdK2KvHnokab4aUw0DlK8j4bQ6QJpZX+DoJYvxcTYlUJMGELj6x2wxwI+vsBA0O
         0YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733457805; x=1734062605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aF6MVln4LC9hUMsccdpl2mvsSb4BSYKAburlVkwvkJQ=;
        b=IEZW4w45FO30+tJF7bb1E296h+frU/T/nYIzQroQwrjMaU5BSMLL+XWGg6TXL7QOAY
         aXKAsTDrZzh6sxSCHDpg11QUkp3EdXoP2wPGx6etJCsaALHQiNcQDW8oyelj0kf7VbSy
         btHa9mzs2x50e5C9VuID5BOegdB05/ZAmU2r/Q9oIjNCVwVss12ozzNW7fd+VOv/ZnOh
         egQbIwRBjQ6m8TIjsmPxzgNguppMZr512oXgmsBYvczaDRw8Ahd+OKhxkQhUyk3eiN9Z
         dOmEW6WRIAkXDNwJrlYqcW/WU4CJIzLhduOV+mq/M9H05G+2WbAn7pTVdlveOY3dgrn1
         NaSw==
X-Gm-Message-State: AOJu0YzLIIZH5klpJ8S4xHEVaTTdJCQ0swQP/0j126Hhw0APwpv6bMss
	FfvRZl5GYrFnqTBjCqaZv739Ci3z2ZdvS5p7oi4RH/zWOplhhYhFvV0Mzg==
X-Gm-Gg: ASbGncszXp4xJuxg3EZM3YJoYHmi7xCrGdCuQf1shfTRPSJw3SHt8Na3ovuZxZZHfaV
	nhTQ8/vPHIQXQWlb8v/bv7boCeKji2e+bcUgcZFwKEdegTJdau2L8CepX73cDYyjakErKlB3XB5
	67uuDNfocAKLqGPsLep9Jyadzm48CO34N/8vlgAE3HyuAzuMB3OvGAI6a+KUTMHKz9fpJnHlpCW
	sjkykkPn3qGeWhCspquJalgJND00vhlGYt0224ZuwTyhQ==
X-Google-Smtp-Source: AGHT+IF6dEn3GMKxbEVCLY+KzpwHP1Mxs6tvHjhXddFterPX+t1UzIKtZPerYepfGfZdAACr2ldA9A==
X-Received: by 2002:a17:90b:1a86:b0:2ee:c291:7674 with SMTP id 98e67ed59e1d1-2ef69b3594amr2876799a91.14.1733457805248;
        Thu, 05 Dec 2024 20:03:25 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ff97ffsm4101846a91.10.2024.12.05.20.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:03:24 -0800 (PST)
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
Subject: [PATCH bpf 2/4] bpf: refactor bpf_helper_changes_pkt_data to use helper number
Date: Thu,  5 Dec 2024 20:03:05 -0800
Message-ID: <20241206040307.568065-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206040307.568065-1-eddyz87@gmail.com>
References: <20241206040307.568065-1-eddyz87@gmail.com>
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


