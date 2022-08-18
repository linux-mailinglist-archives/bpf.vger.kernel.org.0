Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA128597E92
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 08:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbiHRGYm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 02:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243636AbiHRGYl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 02:24:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D28A1A69
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 23:24:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id j8so1411429ejx.9
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 23:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XAxUKVHlHlHMdV7s1IZzGePm3YenchXaTvcpHyTG7Bg=;
        b=fUKJguNOxz4NKbINUysQgzdT75E9r3wKVXsfiJxhI4vT2qLsWpSrz5Gdn0tmqYbYxz
         pKHSy4Y8UetFNfoV1q7mCIzf3G6PRz6a5VfHsL9Gi7AITZhXRz6XsbIIzuR06m1sTJSd
         9AkZzTsqkRzqteFvKcVN5gUItNC/92klNPvA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XAxUKVHlHlHMdV7s1IZzGePm3YenchXaTvcpHyTG7Bg=;
        b=qCXGAgIgrek3VhaOMAf0vgajKifsSuGmQvFI7FwfL278nyNuAYSiJchE6dZVNp0Pn3
         2UIDIzM1LxJvvi9jlAK09cKcJilrQy1mpEYdLZfJ6dy2uMwmJhelfDx3GTF5xvMpW0m6
         jum0cRx4qADGwgs7QfjM4kzbsq/2cLUPt+em6Q5Z51mTSqcVtUJTABpmI76tNU0hFya2
         yFvcYxlQhwTKcideaav+o7HXBapsx0A95k+Ya0ZXX4Av/cUYYNFuY314h74iGZoDdPw0
         zqy/us/W62z5ZRUsgGdIG39tANQ2bvfxtbQpjAyRiU2O6lBosvKC1LoofnLf5DQcLHDo
         E2TA==
X-Gm-Message-State: ACgBeo0z4ZNZTPw8Y99IiHf7ocGnua9moGm6t8YOSIizxY7spS+hdVGj
        dHUY4rL0oYRowE/K03oqGAJiSkbIqBm/M7ByhUgulFTqZ0+BMr7idpUxhI8AjSQlu1inw9WBKhc
        +P0ruPBAaM5jZ5+mTl+EEkmKeNpI/Gbii5CPey08j/N0DwC+w3XBydrbhR5/claCgQicfYaB0
X-Google-Smtp-Source: AA6agR7gntaVTx3g+mmlY4egZJDg1wWMJ20GVIgTJlKZNslvW7UvYVSPjIol6lOqNLzuK9Bcq0gmGA==
X-Received: by 2002:a17:907:75ee:b0:730:b801:614 with SMTP id jz14-20020a17090775ee00b00730b8010614mr944785ejc.698.1660803878532;
        Wed, 17 Aug 2022 23:24:38 -0700 (PDT)
Received: from localhost.localdomain ([141.226.169.165])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7cf0b000000b0043bc19efc15sm535263edy.28.2022.08.17.23.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 23:24:38 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH bpf-next 1/2] flow_dissector: Make 'bpf_flow_dissect' return the bpf program retcode
Date:   Thu, 18 Aug 2022 09:24:04 +0300
Message-Id: <20220818062405.947643-2-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818062405.947643-1-shmulik.ladkani@gmail.com>
References: <20220818062405.947643-1-shmulik.ladkani@gmail.com>
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
index d11209367dd0..401b807a08d2 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1440,7 +1440,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
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
2.37.1

