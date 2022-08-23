Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E75759E855
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbiHWQ74 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 12:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343560AbiHWQ73 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 12:59:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E223814CAC8
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 06:30:42 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u5so9213294wrt.11
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=10PDRhn4F3my8zVIsQ09j340gbFrNOpjbWkUgvpRj7M=;
        b=Ffk/NMqgiBkdyLphqpPOVg8cMVKI8RvRggHzLbLrWIbaU0wAQzgO+Q34cWthMKV9PR
         QHUFT+TA+BqBmj2COH6Gn5NYysEqJ5mPijwTk/UJXVSG5TCDvP8QFMHR0ZggHThUXO3l
         JbZe1oE3VxIloUoJMGC8DVTeYyapNMNiMLKAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=10PDRhn4F3my8zVIsQ09j340gbFrNOpjbWkUgvpRj7M=;
        b=a7Bwb4HDdayIxN/U8kFt5grZq32pvumCZBZhhyXTlqQrJQRLZ+ib1xrvorIWh6+/fd
         KISNt9FdmXRhUY7efsKJunFxkX7mugt+kogIS458phGN/U0QUhXhg826OipdJHOIN2lp
         Heq+GbwvZGEXW2/S5zvZrdidg4AJU9khQz0RIRxihfTi1Ddu7flhniQhMytRiENuDDgV
         qFj4zHivHs9TC2qJmcLUCNK5dP56/d2BzV7ypCN9GvVSQuFf7Mswng3n7bRPjrk+dGox
         y32sAroWs+eCtIy2YJMEpbvDEM5CccMqyC8Zp5i8ane/Y4CbRXPCc9UmLBQ529PWT8Ft
         Av/A==
X-Gm-Message-State: ACgBeo3kfavexUIpnsXpnyr1fhVscGLtg0GNHh9HX02sicZ9w8mlhgOG
        MDqmKqR1tmHiVZRlf3zYCUm+W8Do5hLpn6Yx+jOkEYTViUgpAlfbh140j0DaRohpWHthXbLRP5L
        ZO1FxvBLVmElIf3Y5GM3V8u/fD7rtYgumXbtpJXiQ0HhV6SPWYxrYGUvrAXGytH3Cy24gLRI5
X-Google-Smtp-Source: AA6agR6KJh9QcLqzsoFPxQVog3j/NAfwlFixMGXFc9SJ0uabckvyHUnaPjCVq9jSsHdbSwf2SPI45Q==
X-Received: by 2002:adf:e18b:0:b0:225:644c:59c2 with SMTP id az11-20020adfe18b000000b00225644c59c2mr2676449wrb.673.1661261440968;
        Tue, 23 Aug 2022 06:30:40 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003a4efb794d7sm19264891wmq.36.2022.08.23.06.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:30:40 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v4 bpf-next 2/4] bpf: Support setting variable-length tunnel options
Date:   Tue, 23 Aug 2022 16:30:18 +0300
Message-Id: <20220823133020.73872-3-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823133020.73872-1-shmulik.ladkani@gmail.com>
References: <20220823133020.73872-1-shmulik.ladkani@gmail.com>
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
an option buffer (ARG_PTR_TO_MEM) and the compile-time fixed buffer
size (ARG_CONST_SIZE).

However, in certain cases we wish to set tunnel options of dynamic
length.

For example, we have an ebpf program that gets geneve options on
incoming packets, stores them into a map (using a key representing
the incoming flow), and later needs to assign *same* options to
reply packets (belonging to same flow).

This is currently imposssible without knowing sender's exact geneve
options length, which unfortunately is dymamic.

Introduce 'bpf_skb_set_tunnel_opt_dynptr'.

This is a variant of 'bpf_skb_set_tunnel_opt' which gets a bpf dynamic
pointer (ARG_PTR_TO_DYNPTR) parameter 'ptr' whose data points to the
options buffer, and 'len', the byte length of options data caller wishes
to copy into ip_tunnnel_info.
'len' must never exceed the dynptr's internal size, o/w EINVAL is
returned.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
v3: Avoid 'inline' for the __bpf_skb_set_tunopt helper function
v4: change API to be based on bpf_dynptr, suggested by John Fastabend <john.fastabend@gmail.com>
---
 include/uapi/linux/bpf.h       | 12 ++++++++++++
 net/core/filter.c              | 36 ++++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h | 12 ++++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 934a2a8beb87..6d7eedf3644e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5355,6 +5355,17 @@ union bpf_attr {
  *	Return
  *		Current *ktime*.
  *
+ * long bpf_skb_set_tunnel_opt_dynptr(struct sk_buff *skb, struct bpf_dynptr *opt, u32 len)
+ *	Description
+ *		Set tunnel options metadata for the packet associated to *skb*
+ *		to the variable length *len* bytes of option data pointed to
+ *		by the *opts* dynptr.
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
+	FN(skb_set_tunnel_opt_dynptr),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/net/core/filter.c b/net/core/filter.c
index 1acfaffeaf32..406ed0c50149 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4669,8 +4669,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_key_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_skb_set_tunnel_opt, struct sk_buff *, skb,
-	   const u8 *, from, u32, size)
+static u64 __bpf_skb_set_tunopt(struct sk_buff *skb, const u8 *from, u32 size)
 {
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	const struct metadata_dst *md = this_cpu_ptr(md_dst);
@@ -4685,6 +4684,26 @@ BPF_CALL_3(bpf_skb_set_tunnel_opt, struct sk_buff *, skb,
 	return 0;
 }
 
+BPF_CALL_3(bpf_skb_set_tunnel_opt, struct sk_buff *, skb,
+	   const u8 *, from, u32, size)
+{
+	return __bpf_skb_set_tunopt(skb, from, size);
+}
+
+BPF_CALL_3(bpf_skb_set_tunnel_opt_dynptr, struct sk_buff *, skb,
+	   struct bpf_dynptr_kern *, ptr, u32, len)
+{
+	const u8 *from;
+	u32 avail;
+
+	from = bpf_dynptr_get_data(ptr, &avail);
+	if (unlikely(!from))
+		return -EFAULT;
+	if (unlikely(len > avail))
+		return -EINVAL;
+	return __bpf_skb_set_tunopt(skb, from, len);
+}
+
 static const struct bpf_func_proto bpf_skb_set_tunnel_opt_proto = {
 	.func		= bpf_skb_set_tunnel_opt,
 	.gpl_only	= false,
@@ -4694,6 +4713,15 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_opt_proto = {
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
+static const struct bpf_func_proto bpf_skb_set_tunnel_opt_dynptr_proto = {
+	.func		= bpf_skb_set_tunnel_opt_dynptr,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL,
+	.arg3_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 bpf_get_skb_set_tunnel_proto(enum bpf_func_id which)
 {
@@ -4714,6 +4742,8 @@ bpf_get_skb_set_tunnel_proto(enum bpf_func_id which)
 		return &bpf_skb_set_tunnel_key_proto;
 	case BPF_FUNC_skb_set_tunnel_opt:
 		return &bpf_skb_set_tunnel_opt_proto;
+	case BPF_FUNC_skb_set_tunnel_opt_dynptr:
+		return &bpf_skb_set_tunnel_opt_dynptr_proto;
 	default:
 		return NULL;
 	}
@@ -7826,6 +7856,7 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_skb_get_tunnel_opt:
 		return &bpf_skb_get_tunnel_opt_proto;
 	case BPF_FUNC_skb_set_tunnel_opt:
+	case BPF_FUNC_skb_set_tunnel_opt_dynptr:
 		return bpf_get_skb_set_tunnel_proto(func_id);
 	case BPF_FUNC_redirect:
 		return &bpf_redirect_proto;
@@ -8169,6 +8200,7 @@ lwt_xmit_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_skb_get_tunnel_opt:
 		return &bpf_skb_get_tunnel_opt_proto;
 	case BPF_FUNC_skb_set_tunnel_opt:
+	case BPF_FUNC_skb_set_tunnel_opt_dynptr:
 		return bpf_get_skb_set_tunnel_proto(func_id);
 	case BPF_FUNC_redirect:
 		return &bpf_redirect_proto;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1d6085e15fc8..b9bbccd1e5fa 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5355,6 +5355,17 @@ union bpf_attr {
  *	Return
  *		Current *ktime*.
  *
+ * long bpf_skb_set_tunnel_opt_dynptr(struct sk_buff *skb, struct bpf_dynptr *opt, u32 len)
+ *	Description
+ *		Set tunnel options metadata for the packet associated to *skb*
+ *		to the variable length *len* bytes of option data pointed to
+ *		by the *opts* dynptr.
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
+	FN(skb_set_tunnel_opt_dynptr),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.37.2

