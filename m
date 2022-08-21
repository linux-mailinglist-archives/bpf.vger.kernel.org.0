Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250F859B359
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 13:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiHULfw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 07:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHULft (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 07:35:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FE918349
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 04:35:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h5so9254350wru.7
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 04:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Wg6mAAkilMI/2+ZXuROZzAW1qEHdMe6H3hCymOv9/wE=;
        b=dkS0XhHfSTXmCyKcjadMqINCLEjxnhInzD69JxyEebiC8lOmeIIqY+LSMSGTdFQwwK
         Z5nXAJffPZnrXz5bTwH14baJT8maJsElPVp6XDUexXJGlOy5SpiVRTumyEGTlKWpo0KA
         tYU0I1+USlY4dzlE0avdMfrpkT1kHZN/9HmBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Wg6mAAkilMI/2+ZXuROZzAW1qEHdMe6H3hCymOv9/wE=;
        b=6r+Iq/j/DxNDHYsilTrPRSti9KoBKcrO4NMoxvsBEOyItVRjs8603ua2RuQIUUTeVA
         EN/ELZP8k53D/9iGKvWBkbkHz0MfVTnlDRmNfo29qYeLZXiZw/iK6ufIfu2nAGhs+rRl
         Sg6IIBXkJdenRou7qBeVdgk201efDCEQ47EQEs5VWtOxibYPJZUTrvmbtPl17yDes6d0
         uZUzep9+TRfIVOY2dDfJSwtJDLIKkIJMT8DvBpV7yRjkkimBLqoPcKSn3JA39A16fCA5
         JBApLwMa5YmRbNchcQDjG1iSst/m39LV44rbYycyny7kKmb+RUskfwIB5P4p4ZD1ueAB
         6hDQ==
X-Gm-Message-State: ACgBeo38crQWQ11NpYUFCvrxdZE6oi/GMeLgYzlC+Sf4ONXtc4IOLFeA
        NK/q0IBkcPyGhEbnGz44Cmi4ikwxsihIAPvkXH75J0ZNDAeiR6OuPcsYuENUg3F0t0e2T8wTiq7
        HqJt2RFoQwGdIbujVECjJOGWmHEMbI22TJ61si2aIfKBNzUFkH1CiimbkHQq16H7oKYiEYjD9
X-Google-Smtp-Source: AA6agR48zxLlD862jPyQ+ZrOMnQDqAjf+tLxZ2W1XWrC1VLmp9h2DWtfzVK9qVSWE7ED9SZ0n9WZEw==
X-Received: by 2002:a5d:5a9b:0:b0:225:3fa0:f9ca with SMTP id bp27-20020a5d5a9b000000b002253fa0f9camr4757832wrb.204.1661081746885;
        Sun, 21 Aug 2022 04:35:46 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c2cc800b003a6632fe925sm1067178wmc.13.2022.08.21.04.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:35:46 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v2 bpf-next 1/4] flow_dissector: Make 'bpf_flow_dissect' return the bpf program retcode
Date:   Sun, 21 Aug 2022 14:35:16 +0300
Message-Id: <20220821113519.116765-2-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
References: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
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

Let 'bpf_flow_dissect' callers know the bpf program's retcode and act
accordingly.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
 include/linux/skbuff.h    |  4 ++--
 net/bpf/test_run.c        |  2 +-
 net/core/flow_dissector.c | 13 +++++++------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ca8afa382bf2..87921996175c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1460,8 +1460,8 @@ void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
 			     unsigned int key_count);
 
 struct bpf_flow_dissector;
-bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
-		      __be16 proto, int nhoff, int hlen, unsigned int flags);
+u32 bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
+		     __be16 proto, int nhoff, int hlen, unsigned int flags);
 
 bool __skb_flow_dissect(const struct net *net,
 			const struct sk_buff *skb,
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 25d8ecf105aa..51c479433517 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1445,7 +1445,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	bpf_test_timer_enter(&t);
 	do {
 		retval = bpf_flow_dissect(prog, &ctx, eth->h_proto, ETH_HLEN,
-					  size, flags);
+					  size, flags) == BPF_OK;
 	} while (bpf_test_timer_continue(&t, 1, repeat, &ret, &duration));
 	bpf_test_timer_leave(&t);
 
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 764c4cb3fe8f..a01817fb4ef4 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -866,8 +866,8 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 	}
 }
 
-bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
-		      __be16 proto, int nhoff, int hlen, unsigned int flags)
+u32 bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
+		     __be16 proto, int nhoff, int hlen, unsigned int flags)
 {
 	struct bpf_flow_keys *flow_keys = ctx->flow_keys;
 	u32 result;
@@ -892,7 +892,7 @@ bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
 				   flow_keys->nhoff, hlen);
 
-	return result == BPF_OK;
+	return result;
 }
 
 static bool is_pppoe_ses_hdr_valid(const struct pppoe_hdr *hdr)
@@ -1008,6 +1008,7 @@ bool __skb_flow_dissect(const struct net *net,
 			};
 			__be16 n_proto = proto;
 			struct bpf_prog *prog;
+			u32 result;
 
 			if (skb) {
 				ctx.skb = skb;
@@ -1019,12 +1020,12 @@ bool __skb_flow_dissect(const struct net *net,
 			}
 
 			prog = READ_ONCE(run_array->items[0].prog);
-			ret = bpf_flow_dissect(prog, &ctx, n_proto, nhoff,
-					       hlen, flags);
+			result = bpf_flow_dissect(prog, &ctx, n_proto, nhoff,
+						  hlen, flags);
 			__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
 						 target_container);
 			rcu_read_unlock();
-			return ret;
+			return result == BPF_OK;
 		}
 		rcu_read_unlock();
 	}
-- 
2.37.2

