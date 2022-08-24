Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6C859F2BC
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 06:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiHXElf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 00:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbiHXEld (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 00:41:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353B08C461
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 21:41:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z16so484800wrh.10
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 21:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=W825PLkD6tqlv7oJQm9o6RpZLdaeGEnTuZlblGJf40I=;
        b=GZbIfr62Cyve9O7jAU0IS1veKMgJg6YXmKcNK8SzczOKLK1lBlu4VZrfSUV8MRDLcf
         r+PZbqzQdDw0gKMXlz+LE8kGbdIQ6CIzDLJv8l3eUlCMxWgKAJEUWiiFvXO6FsPzKC4d
         i8e3f8uYbCIVAjPBjp+fQBkDL8oPEIAOI+vSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=W825PLkD6tqlv7oJQm9o6RpZLdaeGEnTuZlblGJf40I=;
        b=zgga5Vj/Te1EblPJBjCIlKagmDGcBzOtYqAZIfJUMk+AaorMdEnFr8LWOpsoUi7W1s
         8BGhDrvHMzGbldTm+gXQR4cHmsU0un9R1eFUgD1fkdBwBzUp+6qP3tSC3W253IeY08pS
         HH+BNQdMQmNjV8j3mCrMZdxtrii/T2AbWqskFTgrqed77t9PPc60IbGlOwrF5vbbudfq
         7s/7JBaOKctymrZDdh5IRViaLWA8MPPBDaeJPnbSVVUbuNYWMwRLgDNX13OMLvC4dY5V
         PeoRrNbUGIW247ILjOk7SVB9GM7yxwaM0BwgHz1qUeSbXMnjDvk91H803ehttnIFHJH1
         ZEMA==
X-Gm-Message-State: ACgBeo2XWM/AEokoZe0ypc5Mxotxi0jTzMdkHtO3MRUOz1wUVqLM6o+k
        E5mic4jge11YZ2PBURvuTBY52qVRT2a7XKlGO9K3Z+n5ymxYSfIMlMbwgbvEuYs8D3myfRTKc3C
        iHvqmYBye+BhHNqZ78Y+9HATt06D+xSKI9tiHKaeIVEKvefxXpovinRv/KWRDhgli+gg4bVmg
X-Google-Smtp-Source: AA6agR69CAfqnooKRuYJy9+wFPms6D8v4ObTTyyZbV1fCuStdg/JNUtCr3k+gLCio5giPwQSKd30Wg==
X-Received: by 2002:a5d:6d04:0:b0:225:5a6e:7607 with SMTP id e4-20020a5d6d04000000b002255a6e7607mr6850983wrq.336.1661316090331;
        Tue, 23 Aug 2022 21:41:30 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe0c9000000b00225206dd595sm15572735wri.86.2022.08.23.21.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 21:41:29 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v5 bpf-next 2/4] bpf: Support setting variable-length tunnel options
Date:   Wed, 24 Aug 2022 07:41:15 +0300
Message-Id: <20220824044117.137658-3-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824044117.137658-1-shmulik.ladkani@gmail.com>
References: <20220824044117.137658-1-shmulik.ladkani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 644600dbb114..c7b313e30635 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5367,6 +5367,17 @@ union bpf_attr {
  *	Return
  *		Current *ktime*.
  *
+ * long bpf_skb_set_tunnel_opt_dynptr(struct sk_buff *skb, struct bpf_dynptr *opt, u32 len)
+ *	Description
+ *		Set tunnel options metadata for the packet associated to *skb*
+ *		to the variable length *len* bytes of option data pointed to
+ *		by the *opt* dynptr.
+ *
+ *		See also the description of the **bpf_skb_get_tunnel_opt**\ ()
+ *		helper for additional information.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5578,6 +5589,7 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(ktime_get_tai_ns),		\
+	FN(skb_set_tunnel_opt_dynptr),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/net/core/filter.c b/net/core/filter.c
index 63e25d8ce501..1407c87ba6ac 100644
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
@@ -7808,6 +7838,7 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_skb_get_tunnel_opt:
 		return &bpf_skb_get_tunnel_opt_proto;
 	case BPF_FUNC_skb_set_tunnel_opt:
+	case BPF_FUNC_skb_set_tunnel_opt_dynptr:
 		return bpf_get_skb_set_tunnel_proto(func_id);
 	case BPF_FUNC_redirect:
 		return &bpf_redirect_proto;
@@ -8155,6 +8186,7 @@ lwt_xmit_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_skb_get_tunnel_opt:
 		return &bpf_skb_get_tunnel_opt_proto;
 	case BPF_FUNC_skb_set_tunnel_opt:
+	case BPF_FUNC_skb_set_tunnel_opt_dynptr:
 		return bpf_get_skb_set_tunnel_proto(func_id);
 	case BPF_FUNC_redirect:
 		return &bpf_redirect_proto;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4fb685591035..6a032a8a5fef 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5367,6 +5367,17 @@ union bpf_attr {
  *	Return
  *		Current *ktime*.
  *
+ * long bpf_skb_set_tunnel_opt_dynptr(struct sk_buff *skb, struct bpf_dynptr *opt, u32 len)
+ *	Description
+ *		Set tunnel options metadata for the packet associated to *skb*
+ *		to the variable length *len* bytes of option data pointed to
+ *		by the *opt* dynptr.
+ *
+ *		See also the description of the **bpf_skb_get_tunnel_opt**\ ()
+ *		helper for additional information.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5578,6 +5589,7 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(ktime_get_tai_ns),		\
+	FN(skb_set_tunnel_opt_dynptr),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.37.2

