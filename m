Return-Path: <bpf+bounces-8038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B05578040E
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 04:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C27D282209
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 02:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A57100D2;
	Fri, 18 Aug 2023 02:58:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2966100B5
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 02:58:18 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F9A2698
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 19:58:17 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6459a5919cdso2310946d6.3
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 19:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692327496; x=1692932296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1rveI8qZCR4C4wEbefcxj73KFhEoSnYcRQTDwgiQK4=;
        b=WQimjvM94ux9B2GBJcDjxNN5CkfPSEt71Ija0YYQ3vdFMYAD9FTBOwEw7+LGPn2WXw
         /jP2CNqXbUtqXqJ6bDq/sqomHkPUSAde1yqm7ATlWBGqpYwyKtBBhUy0dbwBVKp6erAL
         Jzn59/doHMy+T6peWT9DJZLX+CC4ogZgBYM9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692327496; x=1692932296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1rveI8qZCR4C4wEbefcxj73KFhEoSnYcRQTDwgiQK4=;
        b=h2Y5FkB9WVpuVQGAGSKI5Cp01rwekwxVBkNWxwZK1hGsCuhWk9cwJinmKoBr4NKi65
         d+am/0K+9eP5r43vP8Phs11jrRf2wwZ8KzqwEBPKyiY13fpcALYFA7Nyv1aWKJUxnZkQ
         O16zFmtbUuBNyt3TH6TLXzDKjNO+vL/jNrEWRm1n3ponqEnuVsiJnWA1NH4FFGKqgrtM
         whAf9YLmfXGccG3MlQY6bpIzz3bG5isPwCo5Re4PBS+7mFT4nfzv1zMgLmvHSOWMzgL2
         WAOeEF7g9TpPsLSsZEKsso8BuTvLGwRpV6R+6IgdiXGfi5FqMWduOIEoRxEvKUsno+ju
         HyKg==
X-Gm-Message-State: AOJu0Yz3AyaSBbXldVS8qye/OzwQWfi3PDh1w9Y2h4Xfo9pGp36hnaip
	8M8q1yzFnxU89DnQEz+5puRr8zA9GvGAGKBdJq4T+w==
X-Google-Smtp-Source: AGHT+IE/X2UwchhA+IgpKCTMnMGUnKCh5ViUxP8U7VUsaqTciMUXsTSkymEdxNhNHL25ffS47NYOiA==
X-Received: by 2002:ad4:4ba4:0:b0:64a:bff7:90e6 with SMTP id i4-20020ad44ba4000000b0064abff790e6mr1258205qvw.65.1692327496080;
        Thu, 17 Aug 2023 19:58:16 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id w14-20020a0ce10e000000b006427145590csm347998qvk.48.2023.08.17.19.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 19:58:15 -0700 (PDT)
Date: Thu, 17 Aug 2023 19:58:14 -0700
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yan Zhai <yan@cloudflare.com>, Thomas Graf <tgraf@suug.ch>,
	Jordan Griege <jgriege@cloudflare.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 bpf 2/4] lwt: check LWTUNNEL_XMIT_CONTINUE strictly
Message-ID: <96b939b85eda00e8df4f7c080f770970a4c5f698.1692326837.git.yan@cloudflare.com>
References: <cover.1692326837.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692326837.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

LWTUNNEL_XMIT_CONTINUE is implicitly assumed in ip(6)_finish_output2,
such that any positive return value from a xmit hook could cause
unexpected continue behavior, despite that related skb may have been
freed. This could be error-prone for future xmit hook ops. One of the
possible errors is to return statuses of dst_output directly.

To make the code safer, redefine LWTUNNEL_XMIT_CONTINUE value to
distinguish from dst_output statuses and check the continue
condition explicitly.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 include/net/lwtunnel.h | 5 ++++-
 net/ipv4/ip_output.c   | 2 +-
 net/ipv6/ip6_output.c  | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 6f15e6fa154e..53bd2d02a4f0 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -16,9 +16,12 @@
 #define LWTUNNEL_STATE_INPUT_REDIRECT	BIT(1)
 #define LWTUNNEL_STATE_XMIT_REDIRECT	BIT(2)
 
+/* LWTUNNEL_XMIT_CONTINUE should be distinguishable from dst_output return
+ * values (NET_XMIT_xxx and NETDEV_TX_xxx in linux/netdevice.h) for safety.
+ */
 enum {
 	LWTUNNEL_XMIT_DONE,
-	LWTUNNEL_XMIT_CONTINUE,
+	LWTUNNEL_XMIT_CONTINUE = 0x100,
 };
 
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6ba1a0fafbaa..a6e4c82615d7 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -216,7 +216,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 
-		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
+		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
 	}
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 1e8c90e97608..016b0a513259 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -113,7 +113,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 
-		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
+		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
 	}
 
-- 
2.30.2



