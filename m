Return-Path: <bpf+bounces-5897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305CB7627FE
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 03:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FF51C2101F
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 01:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851E71119;
	Wed, 26 Jul 2023 01:08:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF337C
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 01:08:29 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49D3268F
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 18:08:21 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-765ae938b1bso539422985a.0
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 18:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690333700; x=1690938500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n0NtF3U2QeP9UCLELIDDLvHXTMrNEAe+2WmgLDwewEc=;
        b=Zwegie/aBtxLm5/hxoycUPRg/LkQ/+bpJIJPBs1adCSZnU6/M4XYi77KAHIkaUYFf5
         5oiYrj8pSZiGiUIiSLGeDdPFyg85hpidIdlmu7QljlEKcwguPf2CD4c2jD2M9HiJpHkh
         c0rIWHce8o8oUAI6BuBWP529MRjgnrlaI7qpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690333700; x=1690938500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0NtF3U2QeP9UCLELIDDLvHXTMrNEAe+2WmgLDwewEc=;
        b=LMrEpiAOjZbbrKD9qLzdJWcoskaBiWDqRsSF1JoV7ZBbPXi64/YUHps2ujGK2XujcZ
         Hxe25TssTRzDe6sCP/YmNw1CNj3FEMaeLHUQ6lrLDYdyBzfujqULAh5b+S87dzfocK0V
         +zx4TC6Tg4d65jSaTSUCfaPJTRpWMk30JF2J6dGebh6X8FtUzLcj4w67+JK4xRzXy/wg
         EMyWhfoPwvngRwfrFVtMuR1CeZQZzBsvVvei1xQImhYQZyNSkL+Yy3EUappYDNFkWxg/
         qZMSD+QIy2Y5J3B2Bi/JTjkbJFUZfUUwAc7VZr1nxIdXK0nvjyCXgSiycjLPBrflbDH6
         96eQ==
X-Gm-Message-State: ABy/qLb97w7A0ka+vPahNlQdVFg2FkIDpAChc5bgWOa9nCZJ+G5Z2P0R
	qly0fSQ4wErCedaUC0f1oF235BGUCmKkFngyeMQ7Ww==
X-Google-Smtp-Source: APBJJlHootmHuQIc4Y64hnKm0eyRKTB4o0UGbqOkUA0SaKNL39yvmtLcwTImM1JUwqGGiCQBoMf6wA==
X-Received: by 2002:a05:620a:e1e:b0:768:2472:d4ac with SMTP id y30-20020a05620a0e1e00b007682472d4acmr643965qkm.4.1690333700214;
        Tue, 25 Jul 2023 18:08:20 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id t4-20020a05620a004400b00767c8308329sm812377qkt.25.2023.07.25.18.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 18:08:19 -0700 (PDT)
Date: Tue, 25 Jul 2023 18:08:17 -0700
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yan Zhai <yan@cloudflare.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com, Jordan Griege <jgriege@cloudflare.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
Message-ID: <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
References: <cover.1690332693.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690332693.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

skb_do_redirect returns various of values: error code (negative),
0 (success), and some positive status code, e.g. NET_XMIT_CN,
NET_RX_DROP. Commit 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel
infrastructure") didn't check the return code correctly, so positive
values are propagated back along call chain:

  ip_finish_output2
    -> bpf_xmit
      -> run_lwt_bpf
        -> skb_do_redirect

Inside ip_finish_output2, redirected skb will continue to neighbor
subsystem as if LWTUNNEL_XMIT_CONTINUE is returned, despite that this
skb could have been freed. The bug can trigger use-after-free warning
and crashes kernel afterwards:

https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48

Convert positive statuses from skb_do_redirect eliminates this issue.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
Suggested-by: Markus Elfring <Markus.Elfring@web.de>
Suggested-by: Stanislav Fomichev <sdf@google.com>
Reported-by: Jordan Griege <jgriege@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 include/linux/netdevice.h | 2 ++
 net/core/filter.c         | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b828c7a75be2..520d808eec15 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -87,6 +87,8 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev);
 #define NET_RX_SUCCESS		0	/* keep 'em coming, baby */
 #define NET_RX_DROP		1	/* packet dropped */
 
+#define net_rx_errno(e)		((e) == NET_RX_DROP ? -ENOBUFS : (e))
+
 #define MAX_NEST_DEV 8
 
 /*
diff --git a/net/core/filter.c b/net/core/filter.c
index 06ba0e56e369..564104543737 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2095,7 +2095,9 @@ static const struct bpf_func_proto bpf_csum_level_proto = {
 
 static inline int __bpf_rx_skb(struct net_device *dev, struct sk_buff *skb)
 {
-	return dev_forward_skb_nomtu(dev, skb);
+	int ret = dev_forward_skb_nomtu(dev, skb);
+
+	return net_rx_errno(ret);
 }
 
 static inline int __bpf_rx_skb_no_mac(struct net_device *dev,
@@ -2108,7 +2110,7 @@ static inline int __bpf_rx_skb_no_mac(struct net_device *dev,
 		ret = netif_rx(skb);
 	}
 
-	return ret;
+	return net_rx_errno(ret);
 }
 
 static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
@@ -2129,6 +2131,9 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
 	ret = dev_queue_xmit(skb);
 	dev_xmit_recursion_dec();
 
+	if (unlikely(ret > 0))
+		ret = net_xmit_errno(ret);
+
 	return ret;
 }
 
-- 
2.30.2


