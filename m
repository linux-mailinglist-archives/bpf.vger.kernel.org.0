Return-Path: <bpf+bounces-5959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD8B7637CB
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5BB1C21129
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4256D134CC;
	Wed, 26 Jul 2023 13:39:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC90BA43
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 13:39:18 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9102B2132
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 06:39:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so99322461fa.3
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690378753; x=1690983553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sHorn2FTxwc0GDGivshkp6+VTJEJlE83QxVA+vKmjNE=;
        b=QtqNqfpE1x1/0/UDSxEqRIfyyVp5wMDHWM4K+MqdPWDXaWnPNZ23aDH1w4ey7rt3fq
         koE1R4PoykZZ3WtvdpH0gebC9FGFI9CXVLTgrq0zRjQwNHeQjzB6sGSnUA6pSZLgdGvi
         ndrD70cwEd3c+e1nYlS73PNkpzS0qpTV5ymUqdqDkKTK0QNTgZF3SdRrffaJ0z8t7pdc
         k9jryvlx+EusM3TCaspE7FiJ7Z8v1y/03sg1uiguZMdRO1tbyNP/HcHIOzmF+I9a9Uf2
         p6fluw7tX1PoZnlRruOJWB0AdgDobaaHWUb8uKlih3Iz823NB0HZJXAPVUZQqfSvqA0x
         mSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690378753; x=1690983553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHorn2FTxwc0GDGivshkp6+VTJEJlE83QxVA+vKmjNE=;
        b=GozpuUvL0kbZtnjJYNzmMjZ40+5S16Ro+dzU6PkUkPqKXJmQhtqrHAA8Dc1+Q+ArqJ
         5wv5JtvTZijPvKsJpir3cp+ElSsE1YQnpN+2Oj+S2EQYSs9PW3C8M2oLb2PnGw3LrAPe
         STb//F6j0TvV7bMjcfDMIkoySIPmu1scGY/Xmv1cgHcgqlhNSdLTQXS+05M/8jb/aMc+
         iMXORWz5NFNXJ9D3g3GlsHmMMcJ+Ali8qEOl4ndn7WZjmE6DppiVVwj5Fjp1LHbD5VL1
         s1QoSiZeoEZdY+CJndKmwFvjJgz6rj1QkB7HMrA2Ujqa5PhzUTzOfA2SjJjChKvzzQd+
         Banw==
X-Gm-Message-State: ABy/qLbasSS7L+lCdNS6piLD+b57Q8au1M6ovlM4D9vdKHCsGgd4CP6Y
	TVOroBGZqhlxfeGPBIJnS10RNgqIKjARWQt6pEg=
X-Google-Smtp-Source: APBJJlGW/Eo+ksZ3sdIvRgAMD3SNfOzhdacCr9UTiIET+4QsoqSNOu4fp37X+OSa0YBrEyJX2Nzdpw==
X-Received: by 2002:a2e:2e16:0:b0:2b6:c818:a9bc with SMTP id u22-20020a2e2e16000000b002b6c818a9bcmr1560633lju.23.1690378752781;
        Wed, 26 Jul 2023 06:39:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n12-20020a7bcbcc000000b003fbb346279dsm1986398wmi.38.2023.07.26.06.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:39:12 -0700 (PDT)
Date: Wed, 26 Jul 2023 16:39:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
	Jordan Griege <jgriege@cloudflare.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
Message-ID: <a76b300a-e472-4568-b734-37115927621d@moroto.mountain>
References: <cover.1690332693.git.yan@cloudflare.com>
 <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I'm not positive I understand the code in ip_finish_output2().  I think
instead of looking for LWTUNNEL_XMIT_DONE it should instead look for
!= LWTUNNEL_XMIT_CONTINUE.  It's unfortunate that NET_XMIT_DROP and
LWTUNNEL_XMIT_CONTINUE are the both 0x1.  Why don't we just change that
instead?

Also there seems to be a leak in lwtunnel_xmit().  Should that return
LWTUNNEL_XMIT_CONTINUE or should it call kfree_skb() before returning?

Something like the following?

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 11652e464f5d..375790b672bc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -112,6 +112,9 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev);
 #define NET_XMIT_CN		0x02	/* congestion notification	*/
 #define NET_XMIT_MASK		0x0f	/* qdisc flags in net/sch_generic.h */
 
+#define LWTUNNEL_XMIT_DONE NET_XMIT_SUCCESS
+#define LWTUNNEL_XMIT_CONTINUE 0x3
+
 /* NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
  * indicates that the device will soon be dropping packets, or already drops
  * some packets of the same priority; prompting us to send less aggressively. */
diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 6f15e6fa154e..8ab032ee04d0 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -16,12 +16,6 @@
 #define LWTUNNEL_STATE_INPUT_REDIRECT	BIT(1)
 #define LWTUNNEL_STATE_XMIT_REDIRECT	BIT(2)
 
-enum {
-	LWTUNNEL_XMIT_DONE,
-	LWTUNNEL_XMIT_CONTINUE,
-};
-
-
 struct lwtunnel_state {
 	__u16		type;
 	__u16		flags;
diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index 711cd3b4347a..732415d1287d 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -371,7 +371,7 @@ int lwtunnel_xmit(struct sk_buff *skb)
 
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
 	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
-		return 0;
+		return LWTUNNEL_XMIT_CONTINUE;
 
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6e70839257f7..4be50a211b14 100644
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
 

