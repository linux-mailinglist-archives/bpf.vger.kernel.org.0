Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B015B4EBE
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 14:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiIKMXn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 08:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiIKMXm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 08:23:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EFB32A81
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 05:23:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso5262956wmq.1
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=67QEI4hXgBMp+c43AShJsHjhmzhws5ssgTSDAznaz3U=;
        b=Q34IgMRt9g6gizVGVYAetxyTqLpBVIL5Hvcg9Ct4qR0k3XJWlNxSf1vg4ZqTdZ6JdT
         JhE5ULdHPT4APCh63zvTBoqzmAOscZ8Qkka48TehAoDhUzWkCN0w64N3t6fuz8rkXiVm
         xwdM6VVAjYyDJrSbYnmucHXywfcpvQ7zrTclA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=67QEI4hXgBMp+c43AShJsHjhmzhws5ssgTSDAznaz3U=;
        b=Jz1hXNu4uSx9GPQFJNeD/cFxCi94n07QrjA3Y1ECjvYv9AZVbsDQav3Vs6emY2+Nmg
         /4RU9WKj1bzE9rHQTPbsSMiAVozQGSkT8KmZBIM5HIE4cNT2kVKrx2wz4gFihEvAUdua
         9pgq2Ddtn4c6ipT8wEE+uRxvngact6zSXeoQuD1WenYwRTanv0xzncF4TpA7Wish4/Nb
         2IhPmr2s37ct4x/FeSBKyvic3P43U/2iv5ah9upE1Q8enolyn8MctBj5JTwdFiFx5Kbj
         RIowLAHZeC28Hev2OlN0MYw3GjwKZOw6uP4tzsbW3ESYfYL2IsnMU81+NIftALBTa3gP
         C2Qg==
X-Gm-Message-State: ACgBeo2pEoi9Ud859W32vZqc1Pzq+e4kfkthCHgZz5HB3D4TnpNpzbf/
        WWHOu9VnSbHzQkDZ047FFgNhh+ChaI+vB8g74wVdLVOeBaoLOPQN3NOqZTslMl0GDQkKN2xz1xM
        eRmysTu8GXYhGhNM4n1yZBvkefvxPHqWp5AHzKDArvr7LiAdV2aDrq3VOy8K4nYSz2/PFhqb+fz
        A=
X-Google-Smtp-Source: AA6agR6J7tccc1fSwUcYooTxmM+jUxoO//nWqufIXn59lnkEymwch3CONLVnKl8FC9g24apbwQ1nkA==
X-Received: by 2002:a7b:c7d8:0:b0:3b4:5c41:6a6c with SMTP id z24-20020a7bc7d8000000b003b45c416a6cmr6819418wmk.139.1662899018977;
        Sun, 11 Sep 2022 05:23:38 -0700 (PDT)
Received: from blondie.home ([141.226.162.95])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b003a4f08495b7sm6538346wmq.34.2022.09.11.05.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 05:23:38 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v7 bpf-next 2/4] bpf: Support setting variable-length tunnel options
Date:   Sun, 11 Sep 2022 15:23:26 +0300
Message-Id: <20220911122328.306188-3-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911122328.306188-1-shmulik.ladkani@gmail.com>
References: <20220911122328.306188-1-shmulik.ladkani@gmail.com>
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
pointer (ARG_PTR_TO_DYNPTR) parameter whose data points to the options
buffer to set.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>

---
v3: Avoid 'inline' for the __bpf_skb_set_tunopt helper function
v4: change API to be based on bpf_dynptr, suggested by John Fastabend <john.fastabend@gmail.com>
v6: Remove superfluous 'len' from bpf_skb_set_tunnel_opt_dynptr API
    (rely on dynptr's internal size), suggested by Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 include/uapi/linux/bpf.h       | 11 +++++++++++
 net/core/filter.c              | 31 +++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h | 11 +++++++++++
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3df78c56c1bf..ba12f7e1ccb6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5387,6 +5387,16 @@ union bpf_attr {
  *	Return
  *		Current *ktime*.
  *
+ * long bpf_skb_set_tunnel_opt_dynptr(struct sk_buff *skb, struct bpf_dynptr *opt)
+ *	Description
+ *		Set tunnel options metadata for the packet associated to *skb*
+ *		to the option data pointed to by the *opt* dynptr.
+ *
+ *		See also the description of the **bpf_skb_get_tunnel_opt**\ ()
+ *		helper for additional information.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5598,6 +5608,7 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(ktime_get_tai_ns),		\
+	FN(skb_set_tunnel_opt_dynptr),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/net/core/filter.c b/net/core/filter.c
index e872f45399b0..1c652936ef86 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4674,8 +4674,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_key_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_skb_set_tunnel_opt, struct sk_buff *, skb,
-	   const u8 *, from, u32, size)
+static u64 __bpf_skb_set_tunopt(struct sk_buff *skb, const u8 *from, u32 size)
 {
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	const struct metadata_dst *md = this_cpu_ptr(md_dst);
@@ -4690,6 +4689,22 @@ BPF_CALL_3(bpf_skb_set_tunnel_opt, struct sk_buff *, skb,
 	return 0;
 }
 
+BPF_CALL_3(bpf_skb_set_tunnel_opt, struct sk_buff *, skb,
+	   const u8 *, from, u32, size)
+{
+	return __bpf_skb_set_tunopt(skb, from, size);
+}
+
+BPF_CALL_2(bpf_skb_set_tunnel_opt_dynptr, struct sk_buff *, skb,
+	   struct bpf_dynptr_kern *, ptr)
+{
+	const u8 *from = bpf_dynptr_get_data(ptr);
+
+	if (unlikely(!from))
+		return -EFAULT;
+	return __bpf_skb_set_tunopt(skb, from, bpf_dynptr_get_size(ptr));
+}
+
 static const struct bpf_func_proto bpf_skb_set_tunnel_opt_proto = {
 	.func		= bpf_skb_set_tunnel_opt,
 	.gpl_only	= false,
@@ -4699,6 +4714,14 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_opt_proto = {
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
+static const struct bpf_func_proto bpf_skb_set_tunnel_opt_dynptr_proto = {
+	.func		= bpf_skb_set_tunnel_opt_dynptr,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL,
+};
+
 static const struct bpf_func_proto *
 bpf_get_skb_set_tunnel_proto(enum bpf_func_id which)
 {
@@ -4719,6 +4742,8 @@ bpf_get_skb_set_tunnel_proto(enum bpf_func_id which)
 		return &bpf_skb_set_tunnel_key_proto;
 	case BPF_FUNC_skb_set_tunnel_opt:
 		return &bpf_skb_set_tunnel_opt_proto;
+	case BPF_FUNC_skb_set_tunnel_opt_dynptr:
+		return &bpf_skb_set_tunnel_opt_dynptr_proto;
 	default:
 		return NULL;
 	}
@@ -7798,6 +7823,7 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_skb_get_tunnel_opt:
 		return &bpf_skb_get_tunnel_opt_proto;
 	case BPF_FUNC_skb_set_tunnel_opt:
+	case BPF_FUNC_skb_set_tunnel_opt_dynptr:
 		return bpf_get_skb_set_tunnel_proto(func_id);
 	case BPF_FUNC_redirect:
 		return &bpf_redirect_proto;
@@ -8145,6 +8171,7 @@ lwt_xmit_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_skb_get_tunnel_opt:
 		return &bpf_skb_get_tunnel_opt_proto;
 	case BPF_FUNC_skb_set_tunnel_opt:
+	case BPF_FUNC_skb_set_tunnel_opt_dynptr:
 		return bpf_get_skb_set_tunnel_proto(func_id);
 	case BPF_FUNC_redirect:
 		return &bpf_redirect_proto;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3df78c56c1bf..ba12f7e1ccb6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5387,6 +5387,16 @@ union bpf_attr {
  *	Return
  *		Current *ktime*.
  *
+ * long bpf_skb_set_tunnel_opt_dynptr(struct sk_buff *skb, struct bpf_dynptr *opt)
+ *	Description
+ *		Set tunnel options metadata for the packet associated to *skb*
+ *		to the option data pointed to by the *opt* dynptr.
+ *
+ *		See also the description of the **bpf_skb_get_tunnel_opt**\ ()
+ *		helper for additional information.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5598,6 +5608,7 @@ union bpf_attr {
 	FN(tcp_raw_check_syncookie_ipv4),	\
 	FN(tcp_raw_check_syncookie_ipv6),	\
 	FN(ktime_get_tai_ns),		\
+	FN(skb_set_tunnel_opt_dynptr),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.37.3

