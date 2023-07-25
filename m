Return-Path: <bpf+bounces-5790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29F3760714
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 06:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38DB1C20D9D
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 04:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423216D1B;
	Tue, 25 Jul 2023 04:13:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6E563AD
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 04:13:17 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226B519A2
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 21:13:15 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63cf40716ffso19475056d6.2
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 21:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690258394; x=1690863194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dExAqqjX2sAceHiZkTjWc7ytvlJ4THivNCeY471el6A=;
        b=a7JHbgZ44jJD9d5BBzwGMElBDFTGmE6VPiSm37KRstnL6yyrYlU04Jyxj8DJlTLI0k
         1GmawVpW5PeKff+kV0qUwqnxLNbVXOXAJSJ/D7TPQnkWacQb7Z1ntVAdH+WW/s/Wxgkv
         Gz1dvEr/HcdiSu3pizPxhZC03nzUjhgq5jOHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258394; x=1690863194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dExAqqjX2sAceHiZkTjWc7ytvlJ4THivNCeY471el6A=;
        b=ZatPqn5zUfmzlj6QfRsN5nXVM9AMcqLNeBg5/UedmgUAbPadOcHJj5wQp3ceMgGMsO
         42M6YEgm4To9yUWHyw6cNv0u/o7w70Q0YvOPORdQy+0KRG0PtUPka0BfEpPmVbvIhAq2
         wjtVy2eMXnDYZaOs75MhYtIxIdNOroAtrXg/UWIIZ80xjzZIgTwvJb65mJ8Wn+6IpQxm
         ODR0X6UlOvNDnOX8jP+iRJ2KIh57+pVxp+Adme9ajzspz9Z9atZa5rl9gt8Ym+HM7JxD
         q80V83KQzt8wq1eQ5SvHUhsY+Z+2ScSpzJABwhj59MqVx/0eD0RhaWmvLza/BVtIe7it
         LO8A==
X-Gm-Message-State: ABy/qLbNl7+AFznqJXXLkzF4xVES0RGyuIS64tRjzqLPv2AHaXZXlFpv
	GiCOXPmCnt0T8DhWKkjS4LlnzoAUS1gUDrC/ea7VAQ==
X-Google-Smtp-Source: APBJJlElpMFRA5wQX8bBctiucU9VqeMb9/lq+C7HP3dKR1bxEmkzSliV3j65wJVUuW3WBDafCxB8+w==
X-Received: by 2002:a05:6214:184d:b0:63d:a05:256a with SMTP id d13-20020a056214184d00b0063d0a05256amr1596951qvy.8.1690258393862;
        Mon, 24 Jul 2023 21:13:13 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id j8-20020a0cf308000000b0063cdbe73a05sm833186qvl.97.2023.07.24.21.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:13:13 -0700 (PDT)
Date: Mon, 24 Jul 2023 21:13:10 -0700
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
	kernel-team@cloudflare.com, Jordan Griege <jgriege@cloudflare.com>
Subject: [PATCH v3 bpf 1/2] bpf: fix skb_do_redirect return values
Message-ID: <cdbbc9df16044b568448ed9cd828d406f0851bfb.1690255889.git.yan@cloudflare.com>
References: <cover.1690255889.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690255889.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

skb_do_redirect returns various of values: error code (negative), 0
(success), and some positive status code, e.g. NET_XMIT_CN, NET_RX_DROP.
Such code are not handled at lwt xmit hook in function ip_finish_output2
and ip6_finish_output, which can cause unexpected problems. This change
converts the positive status code to proper error code.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Reported-by: Jordan Griege <jgriege@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>

---
v3: converts also RX side return value in addition to TX values
v2: code style change suggested by Stanislav Fomichev
---
 net/core/filter.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 06ba0e56e369..3e232ce11ca0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2095,7 +2095,12 @@ static const struct bpf_func_proto bpf_csum_level_proto = {
 
 static inline int __bpf_rx_skb(struct net_device *dev, struct sk_buff *skb)
 {
-	return dev_forward_skb_nomtu(dev, skb);
+	int ret = dev_forward_skb_nomtu(dev, skb);
+
+	if (unlikely(ret > 0))
+		return -ENETDOWN;
+
+	return 0;
 }
 
 static inline int __bpf_rx_skb_no_mac(struct net_device *dev,
@@ -2106,6 +2111,8 @@ static inline int __bpf_rx_skb_no_mac(struct net_device *dev,
 	if (likely(!ret)) {
 		skb->dev = dev;
 		ret = netif_rx(skb);
+	} else if (ret > 0) {
+		return -ENETDOWN;
 	}
 
 	return ret;
@@ -2129,6 +2136,9 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
 	ret = dev_queue_xmit(skb);
 	dev_xmit_recursion_dec();
 
+	if (unlikely(ret > 0))
+		ret = net_xmit_errno(ret);
+
 	return ret;
 }
 
-- 
2.30.2


