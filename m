Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA904DC551
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 13:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiCQMBe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 08:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiCQMBc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 08:01:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C68413D5B
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mm4-20020a17090b358400b001c68e836fa6so823020pjb.3
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VVGW695k2bQR/34ISjGMABXY2NYsUrhuxKwJRWKKln8=;
        b=fkMuYBp+z1E1H7tGUmmfLxzxyW54MMhf3RepZXSE/i+d8gnnC2Xa7YhbQH+RC424NA
         JPcVaWEoNNKsSirMQ1wNWYMPjnatPIKhOBhWoX4YyfLufRmQyU/BsJjw3puH/iT/C9fV
         q43c/lqNYNgtBMY9l8GqkiSNDs8yk6ys6mcuqUPV/wHBUiBbrOdranUaS0HVCW0RlhBe
         FcgX7YkZpdech9M4SOnj+BSwviB5A9+O7HNIEv+KSoVasIkn2Wu0zZL28Mg795iMDkDP
         SkuZp9rB4DyPtHAVon/u7zfGxpsnGha/cO4STC2QRpZPphH5jh99AeCWwZQ8z7v9CAd6
         ZmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVGW695k2bQR/34ISjGMABXY2NYsUrhuxKwJRWKKln8=;
        b=OYoY8t1PWHRy7eucXoVS9FJt/5LGDffzrSuHsttJqfK6hAZ2Pj2x4ttH62beE0qTlU
         OBVwum6CRZIyA03qmFNaInSFF5hsT8FQoP5JNA0iej0dm8aEwh8YfONgY5mmtdiJ+JG9
         BfxzKvlOUUGv6/2cS47k+Wy6o/qCpDIxfes+fBVPqdFJaGAJntKYCLgpX5X5HyrCNmZU
         I6rpiuZ8lwkuUU6R12FweZlWtvgMapoB3R1phog/XrtvKPmpEgR+edAXYWgzxb+g8Sa8
         /W/88LdzoTd5QB/HDzlZN4NtoOE3Ys1hWl+VLyL6D4a+G+zBmZvsz3E7RIUT3kKsue0u
         OOTQ==
X-Gm-Message-State: AOAM532/oJ2gnNKLTCcO0cdAydLE6Q1tAFecX+eQexTZQjo/mJSNLv+0
        TAqSDQgIMl4vF02EeVGJfpNqm+jSawc=
X-Google-Smtp-Source: ABdhPJwCJcH1q5XwOL2OWmCSH4k4ScS8+qV3rSOvzZUzhaMUL+l5s5gFxvQH180i7NmLaLdKPK6skA==
X-Received: by 2002:a17:902:a40d:b0:153:7213:1584 with SMTP id p13-20020a170902a40d00b0015372131584mr4300291plq.56.1647518405419;
        Thu, 17 Mar 2022 05:00:05 -0700 (PDT)
Received: from localhost ([157.51.20.101])
        by smtp.gmail.com with ESMTPSA id s12-20020a056a00194c00b004f7c1da7dd5sm7021696pfk.1.2022.03.17.05.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:00:05 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 01/15] bpf: Factor out fd returning from bpf_btf_find_by_name_kind
Date:   Thu, 17 Mar 2022 17:29:43 +0530
Message-Id: <20220317115957.3193097-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317115957.3193097-1-memxor@gmail.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4065; h=from:subject; bh=mEucVWjysFRwDDL2pGu0jaQ8Nu+5PARelACOeyG3/LQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiMyKj0I8Pz4STHL5jon2GahPTQ03JM0SO8OY0N0Ec BCoG8fOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjMiowAKCRBM4MiGSL8RyrrZEA Cg9u5R+QvXbJHPQi4dVBkaB4/0jkPOPbGgsB95wa4ibQpHFEhnoVS3ikOUhvPs/m+zWPQXAVOnVk79 SBV6QhYabJjryL+BMVF1TfJyZdCWC7j6p2IdOKhbvDmL0NrNPsN36Tl0IHLOR79rzkzNw6kXZel5BA Az0gQC5lZqR4G5p7Rr+xvKdd6ox9Cu5ouTyj7A7QDJW2+WONL5+XZrPkIB6kMRTLsOEV2T6zZLeP8S XecU0dFcc5/S5bV6Z05mWFbC33RA1aMzBFn0jtlxo2xd6lLzMBiG1xDY1Bow/OVXZeCqRj4dFq6PYW DLlVXXdpP78rmSl2MpCgTr2iEG6zZmtUKvSjwwq5yWjQqFzrmR/Sw5Enx8mh0sbpUsqF8Igher1te1 HKIbnLR/XuUULAj7KIoFtbPCtu0aWMgGPst+IuQm0giKA9IWlcmzYqM8YCj41yf9TQuS4Wy1hYq6GU ybiKDasuXUR4FZKm823YHlHDt+ElRJ9w3SAzEc1ZGeRpA7K2MDBsH95ZjhQgxQyReKRFxQnHVQiTET UMDz264WNZj+0YJAgMirwEMG43Q4J05tU5VCpghUUxobo9tvUmLjh3tfS63AzADN8S3V1mOH35x68A DPybiOcht0VxNPtAX8O+RXyae2m7w4eXK8WeqbfsWDw/ykqmB8iEqzxLg8sw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In next few patches, we need a helper that searches all kernel BTFs
(vmlinux and module BTFs), and finds the type denoted by 'name' and
'kind'. Turns out bpf_btf_find_by_name_kind already does the same thing,
but it instead returns a BTF ID and optionally fd (if module BTF). This
is used for relocating ksyms in BPF loader code (bpftool gen skel -L).

We extract the core code out into a new helper bpf_find_btf_id, which
returns the BTF ID in the return value, and BTF pointer in an out
parameter. The reference for the returned BTF pointer is always raised,
hence user must either transfer it (e.g. to a fd), or release it after
use.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 90 ++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 37 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8b34563a832e..17b9adcd88d3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -525,6 +525,48 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 	return -ENOENT;
 }
 
+static s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
+{
+	struct btf *btf;
+	s32 ret;
+	int id;
+
+	btf = bpf_get_btf_vmlinux();
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+
+	ret = btf_find_by_name_kind(btf, name, kind);
+	/* ret is never zero, since btf_find_by_name_kind returns
+	 * positive btf_id or negative error.
+	 */
+	if (ret > 0) {
+		btf_get(btf);
+		*btf_p = btf;
+		return ret;
+	}
+
+	/* If name is not found in vmlinux's BTF then search in module's BTFs */
+	spin_lock_bh(&btf_idr_lock);
+	idr_for_each_entry(&btf_idr, btf, id) {
+		if (!btf_is_module(btf))
+			continue;
+		/* linear search could be slow hence unlock/lock
+		 * the IDR to avoiding holding it for too long
+		 */
+		btf_get(btf);
+		spin_unlock_bh(&btf_idr_lock);
+		ret = btf_find_by_name_kind(btf, name, kind);
+		if (ret > 0) {
+			*btf_p = btf;
+			return ret;
+		}
+		spin_lock_bh(&btf_idr_lock);
+		btf_put(btf);
+	}
+	spin_unlock_bh(&btf_idr_lock);
+	return ret;
+}
+
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
 					       u32 id, u32 *res_id)
 {
@@ -6562,7 +6604,8 @@ static struct btf *btf_get_module_btf(const struct module *module)
 
 BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int, flags)
 {
-	struct btf *btf;
+	struct btf *btf = NULL;
+	int btf_obj_fd = 0;
 	long ret;
 
 	if (flags)
@@ -6571,44 +6614,17 @@ BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int
 	if (name_sz <= 1 || name[name_sz - 1])
 		return -EINVAL;
 
-	btf = bpf_get_btf_vmlinux();
-	if (IS_ERR(btf))
-		return PTR_ERR(btf);
-
-	ret = btf_find_by_name_kind(btf, name, kind);
-	/* ret is never zero, since btf_find_by_name_kind returns
-	 * positive btf_id or negative error.
-	 */
-	if (ret < 0) {
-		struct btf *mod_btf;
-		int id;
-
-		/* If name is not found in vmlinux's BTF then search in module's BTFs */
-		spin_lock_bh(&btf_idr_lock);
-		idr_for_each_entry(&btf_idr, mod_btf, id) {
-			if (!btf_is_module(mod_btf))
-				continue;
-			/* linear search could be slow hence unlock/lock
-			 * the IDR to avoiding holding it for too long
-			 */
-			btf_get(mod_btf);
-			spin_unlock_bh(&btf_idr_lock);
-			ret = btf_find_by_name_kind(mod_btf, name, kind);
-			if (ret > 0) {
-				int btf_obj_fd;
-
-				btf_obj_fd = __btf_new_fd(mod_btf);
-				if (btf_obj_fd < 0) {
-					btf_put(mod_btf);
-					return btf_obj_fd;
-				}
-				return ret | (((u64)btf_obj_fd) << 32);
-			}
-			spin_lock_bh(&btf_idr_lock);
-			btf_put(mod_btf);
+	ret = bpf_find_btf_id(name, kind, &btf);
+	if (ret > 0 && btf_is_module(btf)) {
+		btf_obj_fd = __btf_new_fd(btf);
+		if (btf_obj_fd < 0) {
+			btf_put(btf);
+			return btf_obj_fd;
 		}
-		spin_unlock_bh(&btf_idr_lock);
+		return ret | (((u64)btf_obj_fd) << 32);
 	}
+	if (ret > 0)
+		btf_put(btf);
 	return ret;
 }
 
-- 
2.35.1

