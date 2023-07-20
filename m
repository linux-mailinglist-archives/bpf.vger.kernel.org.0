Return-Path: <bpf+bounces-5482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF15E75B2B7
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3507E1C2147B
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E818C00;
	Thu, 20 Jul 2023 15:30:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BEA18C20
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:30:59 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9056E1BC1
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 08:30:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9922d6f003cso163914166b.0
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689867046; x=1690471846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1OV/Gg5jhKvjIdebEVDtlHxi2P2tNv/5e7W2/lf1TY=;
        b=KWmNNkPnYi34ViccPyP9omB6g3VYjIC+P5a6s3R9Zq6u27XIBTylnYDqSE/6QzsjTs
         c4BQNfgoTfurzpxPfd+rTn8+sHF5/3hals0R+SfDgHzqypyxIwn0CyQAwa6wASPY7dSC
         WSX3KiL+jD5rkhWpQMmdogXbeTaV6xpxCCb/PGp1nh+pz2q964TKvIrh7nu7of1oRsXy
         GyokRYBn9+JOIGMBjRK6HARA3XRPpt0CL69CznvVLzKRg4eurPEZWNCW6mGcXNy8BcxP
         qeOP6TwWpCx5xNk4BvN6p0tCYRY9XEUP5dePoU5V+TfZgVQ8xZyRgzGTYdxMXMg4bXSB
         JC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867046; x=1690471846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1OV/Gg5jhKvjIdebEVDtlHxi2P2tNv/5e7W2/lf1TY=;
        b=TRBqFCmHO6YgyXYqTku4awafj24rD1jlxKQaix0JPFJiHvX3l+NSQ/jGCzncucmb+R
         GTnYxoPRiaXfqLehUkXjo2/JttrODqRghZVCFIwHJtLevr8z6KRzipBlRlk+/O0rbbv6
         0aBh+1fxipQfb3VyF5Xa2kXAiEHfBx4gGKj8LXMV46FwZm5Rp/EKOytq3WXQXuLg79Hm
         aR+ZE4qiPMCb7LLds90a+gkwRgihlATl/jAF+FUNqV6QumZRs3dJvs+H7WpP67JljN6W
         pmjfFzNoerjX464DpEKSODREoVWdrrPvP8ktnTj0yq6NieCs5Zzwu96FKc0js2ZEvYaB
         l9bQ==
X-Gm-Message-State: ABy/qLYNeZfaRFOKLvGJoDhYaenKXhncuX54idCV4yYHAPegDihJu1pn
	/cUTleNDIt6qpEgBMoGM+4aeHA==
X-Google-Smtp-Source: APBJJlHARYpaFcrWesfr6JAczLs2z5T8X3ITGbp+DNZ36FmzOiZ0OW8gxonsvS3TpieAIL8VbM3a0w==
X-Received: by 2002:a17:907:7888:b0:99b:5b07:64aa with SMTP id ku8-20020a170907788800b0099b5b0764aamr1054958ejc.35.1689867045943;
        Thu, 20 Jul 2023 08:30:45 -0700 (PDT)
Received: from [192.168.188.151] (p200300c1c7176000b788d2ebe49c4b82.dip0.t-ipconnect.de. [2003:c1:c717:6000:b788:d2eb:e49c:4b82])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906804a00b009893b06e9e3sm851007ejw.225.2023.07.20.08.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:30:45 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 20 Jul 2023 17:30:05 +0200
Subject: [PATCH bpf-next v6 1/8] udp: re-score reuseport groups when
 connected sockets are present
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-so-reuseport-v6-1-7021b683cdae@isovalent.com>
References: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
In-Reply-To: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Joe Stringer <joe@wand.net.nz>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Contrary to TCP, UDP reuseport groups can contain TCP_ESTABLISHED
sockets. To support these properly we remember whether a group has
a connected socket and skip the fast reuseport early-return. In
effect we continue scoring all reuseport sockets and then choose the
one with the highest score.

The current code fails to re-calculate the score for the result of
lookup_reuseport. According to Kuniyuki Iwashima:

    1) SO_INCOMING_CPU is set
       -> selected sk might have +1 score

    2) BPF prog returns ESTABLISHED and/or SO_INCOMING_CPU sk
       -> selected sk will have more than 8

  Using the old score could trigger more lookups depending on the
  order that sockets are created.

    sk -> sk (SO_INCOMING_CPU) -> sk (ESTABLISHED)
    |     |
    `-> select the next SO_INCOMING_CPU sk
          |
          `-> select itself (We should save this lookup)

Fixes: efc6b6f6c311 ("udp: Improve load balancing for SO_REUSEPORT.")
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 net/ipv4/udp.c | 20 +++++++++++++++-----
 net/ipv6/udp.c | 19 ++++++++++++++-----
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 42a96b3547c9..c62d5e1c6675 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -451,14 +451,24 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
-			result = lookup_reuseport(net, sk, skb,
-						  saddr, sport, daddr, hnum);
+			badness = score;
+			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+			if (!result) {
+				result = sk;
+				continue;
+			}
+
 			/* Fall back to scoring if group has connections */
-			if (result && !reuseport_has_conns(sk))
+			if (!reuseport_has_conns(sk))
 				return result;
 
-			result = result ? : sk;
-			badness = score;
+			/* Reuseport logic returned an error, keep original score. */
+			if (IS_ERR(result))
+				continue;
+
+			badness = compute_score(result, net, saddr, sport,
+						daddr, hnum, dif, sdif);
+
 		}
 	}
 	return result;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index b7c972aa09a7..dec69f0379e9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -194,14 +194,23 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
-			result = lookup_reuseport(net, sk, skb,
-						  saddr, sport, daddr, hnum);
+			badness = score;
+			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+			if (!result) {
+				result = sk;
+				continue;
+			}
+
 			/* Fall back to scoring if group has connections */
-			if (result && !reuseport_has_conns(sk))
+			if (!reuseport_has_conns(sk))
 				return result;
 
-			result = result ? : sk;
-			badness = score;
+			/* Reuseport logic returned an error, keep original score. */
+			if (IS_ERR(result))
+				continue;
+
+			badness = compute_score(sk, net, saddr, sport,
+						daddr, hnum, dif, sdif);
 		}
 	}
 	return result;

-- 
2.41.0


