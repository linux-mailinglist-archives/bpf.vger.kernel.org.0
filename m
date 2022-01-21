Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E53B4965CE
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 20:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiAUTkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 14:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiAUTkW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 14:40:22 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C3DC06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:40:22 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v13so1505843wrv.10
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vdt29elNTd9QX3xaK0P0+9Vhq8E/x+4rZg+yPbH5zyw=;
        b=DQaY+x8DX7HV5/NW4H4gpVnHijUgHDhcfhORJzGnHdYwA8i4RiBdLD3zGpDUg5HGOI
         kMYRciSZdIuSjkWPJH3V2YI7QqZYE3Sk5GMW5cigpcj18Tg2KPig9GnVKno1j+y2nKlw
         swAtaXmWTEc/S48dFQFTe1ROFZ/eVLKfPKw7uGjoxeOS1H8OjjCH1ZZxs1quJOCBsfK+
         NpWAmAEf3M3ON2rGQ/VpYMEECBL3dIYp18m6m/30KjdHwr6nHxRaRZbRerUBk2APxaoA
         ZqkkQkV9E4x+uXoo19wN1hfeUKgsmNeWAHVSG7N4zaYETeSvlXX4zpHloixWb8MSs4A4
         9SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vdt29elNTd9QX3xaK0P0+9Vhq8E/x+4rZg+yPbH5zyw=;
        b=eSA9UEiM/ODc+3f88DLSp71eUWUcH4y6a6VPTtPEgChCojcHPDs1gzWQNCuE33Vyok
         sH4PBDo/KKfPk2VSpCfrMzpDsYw7uGS9yoKkSdU2HEVKxXBBQtLDXRx6/Ji7vr1T9n9Q
         6EGhLy8lwZXrqF/A8u9g8zqdtpz3i7zhCdx2PW38S56l95vcSgiy/SfmZerENlPpw3RM
         uXaXOqq1vLjrojsLTM/evl+CZx3tr/KqDr4FG1lxmGB9Zm2V15KGb6DHaFD41wGfqed2
         zu2YME8X6b+dmleK7HCGu/B2bSlaU1cWgHhkUWWOHm+ys7YZHmAh+RErrmPhzheuKraL
         wS/g==
X-Gm-Message-State: AOAM533VTD9HD+am/vMJRwzDOcpoqtbQ9CKjk53R6zMUDP4I8HW+z9iB
        HxbNwFpfDNg82ncg25E8ZAWi4ScoVfwxWg==
X-Google-Smtp-Source: ABdhPJwYQGZvmMxOSz0eNl8YwCtUai7GXftQyPuzEtL5yDuv91PbpumQ04uIdQMrkEwASMtjFql65A==
X-Received: by 2002:a05:6000:1a8e:: with SMTP id f14mr5139698wry.518.1642794020698;
        Fri, 21 Jan 2022 11:40:20 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:575f:679d:7c2f:fa19])
        by smtp.gmail.com with ESMTPSA id n14sm6988059wri.101.2022.01.21.11.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:40:20 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com
Cc:     fam.zheng@bytedance.com, cong.wang@bytedance.com, song@kernel.org,
        Usama Arif <usama.arif@bytedance.com>
Subject: [RFC bpf-next 2/3] bpf: add support for module helpers in verifier
Date:   Fri, 21 Jan 2022 19:39:55 +0000
Message-Id: <20220121193956.198120-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121193956.198120-1-usama.arif@bytedance.com>
References: <20220121193956.198120-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After the kernel module registers the helper, its BTF id
and func_proto are available during verification. During
verification, it is checked to see if insn->imm is available
in the list of module helper btf ids. If it is,
check_helper_call is called, otherwise check_kfunc_call.
The module helper function proto is obtained in check_helper_call
via get_mod_helper_proto function.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c5a46d41f28..bf7605664b95 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6532,19 +6532,39 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	int insn_idx = *insn_idx_p;
 	bool changes_data;
 	int i, err, func_id;
+	const struct btf_type *func;
+	const char *func_name;
+	struct btf *desc_btf;
 
 	/* find function prototype */
 	func_id = insn->imm;
-	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID) {
-		verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
-			func_id);
-		return -EINVAL;
-	}
 
 	if (env->ops->get_func_proto)
 		fn = env->ops->get_func_proto(func_id, env->prog);
-	if (!fn) {
-		verbose(env, "unknown func %s#%d\n", func_id_name(func_id),
+
+	if (func_id >= __BPF_FUNC_MAX_ID) {
+		desc_btf = find_kfunc_desc_btf(env, insn->imm, insn->off);
+		if (IS_ERR(desc_btf))
+			return PTR_ERR(desc_btf);
+
+		fn = get_mod_helper_proto(desc_btf, func_id);
+		if (!fn) {
+			func = btf_type_by_id(desc_btf, func_id);
+			func_name = btf_name_by_offset(desc_btf, func->name_off);
+			verbose(env, "unknown module helper func %s#%d\n", func_name,
+				func_id);
+			return -EACCES;
+		}
+	} else if (func_id >= 0) {
+		if (env->ops->get_func_proto)
+			fn = env->ops->get_func_proto(func_id, env->prog);
+		if (!fn) {
+			verbose(env, "unknown in-kernel helper func %s#%d\n", func_id_name(func_id),
+				func_id);
+			return -EINVAL;
+		}
+	} else {
+		verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
 			func_id);
 		return -EINVAL;
 	}
@@ -11351,6 +11371,7 @@ static int do_check(struct bpf_verifier_env *env)
 	int insn_cnt = env->prog->len;
 	bool do_print_state = false;
 	int prev_insn_idx = -1;
+	struct btf *desc_btf;
 
 	for (;;) {
 		struct bpf_insn *insn;
@@ -11579,10 +11600,17 @@ static int do_check(struct bpf_verifier_env *env)
 				}
 				if (insn->src_reg == BPF_PSEUDO_CALL)
 					err = check_func_call(env, insn, &env->insn_idx);
-				else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL)
-					err = check_kfunc_call(env, insn, &env->insn_idx);
-				else
-					err = check_helper_call(env, insn, &env->insn_idx);
+				else {
+					desc_btf = find_kfunc_desc_btf(env, insn->imm, insn->off);
+					if (IS_ERR(desc_btf))
+						return PTR_ERR(desc_btf);
+
+					if (insn->src_reg == BPF_K ||
+					   get_mod_helper_proto(desc_btf, insn->imm))
+						err = check_helper_call(env, insn, &env->insn_idx);
+					else
+						err = check_kfunc_call(env, insn, &env->insn_idx);
+				}
 				if (err)
 					return err;
 			} else if (opcode == BPF_JA) {
-- 
2.25.1

