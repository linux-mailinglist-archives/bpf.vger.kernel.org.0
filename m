Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578D559B8B5
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 07:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiHVFWM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 01:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiHVFWL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 01:22:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102CE25596
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 22:22:10 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b5so7485125wrr.5
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 22:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ovk2dLdgVovDMaKK+ISMk7hpEgxuG91JBtNJ8DlajTw=;
        b=WP0D+b7WSX/ulcWOPq47UzRWx/7BWTbbQCfLnxGAUQsuf1ic6X+3Zt/2rnYpB5UvTD
         X4e98+4ibJBZJ5ATNKXuN/PSKCqqjGxNKEQa+ciZT+6xNpY9JxSVRwVzUG5r3IWLyTNF
         6ksBc9gg3P+38xQxbvff2isTepcC6KoG8fKME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ovk2dLdgVovDMaKK+ISMk7hpEgxuG91JBtNJ8DlajTw=;
        b=U992TzskCfMOJ9USSQCdl4yqppBf78GTa3xDe4mckT2HjEvIVjF80rdYgpROteaoKt
         SSbsuNulrxMpSElp4nat9kQk9vSO5QpphourZeslvuy2VUml1CLZC6u6e2vCx6u4OVUF
         oWrtG0V961wP+VOZeEtS6AehT7dJH/Rqe19So22dyL6uLDQQhFbdc/Kv6ThqcXqrTu9y
         2MMvEKwaetDrvD3cQ8kEIbkuYq2QWhtV7g5SRpYnRTdS6pJy0UR1mTfZB5RTZXbf/wJ0
         Uo6W83Op6vn+pcHWk7MIZ5JHEM25aA/RLsPeJi0dX9JLKR+4nMhskxFOGP8KG9ScY1f0
         j1fw==
X-Gm-Message-State: ACgBeo3Bz3jk5xgmyROyeLnkg95sxOc6CkovdQ7GIA3/9pep9ffSNzuW
        J0PtAFlmuL+HWlEpWRqYnxer07xkr4NQz/GE5pY5ZHfb+8qOtrriqMP8yAG4sCCPyX46+g8OZHg
        n/LZlIjbNVOLlW0p1ehFO7X4EuRvBgrxHCjDre7qCsyIOiua9qUsAN+OrSoKvA6hmISFl+b3B
X-Google-Smtp-Source: AA6agR7cbRbKONXug9k0v9kUJEbJd9etEKh6wuY7xlCl6MKbzJQhlfKdZk82YcGwhegEH4fLb8EZ+A==
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id c14-20020adffb0e000000b0021a34a25ca9mr9902486wrr.472.1661145728179;
        Sun, 21 Aug 2022 22:22:08 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id z24-20020a1cf418000000b003a5dadcf1a8sm13163173wma.19.2022.08.21.22.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 22:22:07 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v3 bpf-next 1/3] bpf: Support setting variable-length tunnel options
Date:   Mon, 22 Aug 2022 08:21:50 +0300
Message-Id: <20220822052152.378622-2-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822052152.378622-1-shmulik.ladkani@gmail.com>
References: <20220822052152.378622-1-shmulik.ladkani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Existing 'bpf_skb_set_tunnel_opt' allows setting tunnel options given
an option buffer (ARG_PTR_TO_MEM|MEM_RDONLY) and the compile-time
fixed buffer size (ARG_CONST_SIZE).

However, in certain cases we wish to set tunnel options of dynamic
length.

For example, we have an ebpf program that gets geneve options on
incoming packets, stores them into a map (using a key representing
the incoming flow), and later needs to assign *same* options to
reply packets (belonging to same flow).

This is currently imposssibly without knowing sender's exact geneve
options length, which unfortunately is dymamic.

Introduce 'skb_set_var_tunnel_opt'. This is a variant of
'bpf_skb_set_tunnel_opt' which gets an *additional* parameter 'len',
which is the byte length from 'opt' buffer to copy into ip_tunnnel_info.

The 'size' parameter is kept ARG_CONST_SIZE. This way, verifier can still
safe-guard buffer access. 'len' must never exceed 'size', o/w EINVAL is
returned.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
v3: Avoid 'inline' for the __bpf_skb_set_tunopt helper function
---
 include/uapi/linux/bpf.h       | 12 ++++++++++++
 net/core/filter.c              | 34 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h | 12 ++++++++++++
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 934a2a8beb87..1b965dfd0c80 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5355,6 +5355,17 @@ union bpf_attr {
  *	Return
  *		Current *ktime*.
  *
+ * long bpf_skb_set_var_tunnel_opt(struct sk_buff *skb, void *opt, u32 size, u32 len)
+ *	Description
+ *		Set tunnel options metadata for the packet associated to *skb*
+ *		to the variable length *len* bytes of option data contained in
+ *		the raw buffer *opt* sized *size*.
+ *
+ *		See also the description of the **bpf_skb_get_tunnel_opt**\ ()
+ *		helper for additional information.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5566,6 +5577,7 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(ktime_get_tai_ns),		\
+	FN(skb_set_var_tunnel_opt),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/net/core/filter.c b/net/core/filter.c
index 1acfaffeaf32..02161a3344fd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4669,8 +4669,8 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_key_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_skb_set_tunnel_opt, struct sk_buff *, skb,
-	   const u8 *, from, u32, size)
+static u64 __bpf_skb_set_tunopt(struct sk_buff *skb,
+				const u8 *from, u32 size, u32 len)
 {
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	const struct metadata_dst *md = this_cpu_ptr(md_dst);
@@ -4679,12 +4679,26 @@ BPF_CALL_3(bpf_skb_set_tunnel_opt, struct sk_buff *, skb,
 		return -EINVAL;
 	if (unlikely(size > IP_TUNNEL_OPTS_MAX))
 		return -ENOMEM;
+	if (unlikely(len > size))
+		return -EINVAL;
 
-	ip_tunnel_info_opts_set(info, from, size, TUNNEL_OPTIONS_PRESENT);
+	ip_tunnel_info_opts_set(info, from, len, TUNNEL_OPTIONS_PRESENT);
 
 	return 0;
 }
 
+BPF_CALL_3(bpf_skb_set_tunnel_opt, struct sk_buff *, skb,
+	   const u8 *, from, u32, size)
+{
+	return __bpf_skb_set_tunopt(skb, from, size, size);
+}
+
+BPF_CALL_4(bpf_skb_set_var_tunnel_opt, struct sk_buff *, skb,
+	   const u8 *, from, u32, size, u32, len)
+{
+	return __bpf_skb_set_tunopt(skb, from, size, len);
+}
+
 static const struct bpf_func_proto bpf_skb_set_tunnel_opt_proto = {
 	.func		= bpf_skb_set_tunnel_opt,
 	.gpl_only	= false,
@@ -4694,6 +4708,16 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_opt_proto = {
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
+static const struct bpf_func_proto bpf_skb_set_var_tunnel_opt_proto = {
+	.func		= bpf_skb_set_var_tunnel_opt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 bpf_get_skb_set_tunnel_proto(enum bpf_func_id which)
 {
@@ -4714,6 +4738,8 @@ bpf_get_skb_set_tunnel_proto(enum bpf_func_id which)
 		return &bpf_skb_set_tunnel_key_proto;
 	case BPF_FUNC_skb_set_tunnel_opt:
 		return &bpf_skb_set_tunnel_opt_proto;
+	case BPF_FUNC_skb_set_var_tunnel_opt:
+		return &bpf_skb_set_var_tunnel_opt_proto;
 	default:
 		return NULL;
 	}
@@ -7826,6 +7852,7 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_skb_get_tunnel_opt:
 		return &bpf_skb_get_tunnel_opt_proto;
 	case BPF_FUNC_skb_set_tunnel_opt:
+	case BPF_FUNC_skb_set_var_tunnel_opt:
 		return bpf_get_skb_set_tunnel_proto(func_id);
 	case BPF_FUNC_redirect:
 		return &bpf_redirect_proto;
@@ -8169,6 +8196,7 @@ lwt_xmit_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_skb_get_tunnel_opt:
 		return &bpf_skb_get_tunnel_opt_proto;
 	case BPF_FUNC_skb_set_tunnel_opt:
+	case BPF_FUNC_skb_set_var_tunnel_opt:
 		return bpf_get_skb_set_tunnel_proto(func_id);
 	case BPF_FUNC_redirect:
 		return &bpf_redirect_proto;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1d6085e15fc8..1a1083db5b7a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5355,6 +5355,17 @@ union bpf_attr {
  *	Return
  *		Current *ktime*.
  *
+ * long bpf_skb_set_var_tunnel_opt(struct sk_buff *skb, void *opt, u32 size, u32 len)
+ *	Description
+ *		Set tunnel options metadata for the packet associated to *skb*
+ *		to the variable length *len* bytes of option data contained in
+ *		the raw buffer *opt* sized *size*.
+ *
+ *		See also the description of the **bpf_skb_get_tunnel_opt**\ ()
+ *		helper for additional information.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5566,6 +5577,7 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(ktime_get_tai_ns),		\
+	FN(skb_set_var_tunnel_opt),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.37.2

