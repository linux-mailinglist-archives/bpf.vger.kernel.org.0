Return-Path: <bpf+bounces-5242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D2D758C1E
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 05:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EE01C20282
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 03:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B2E3D61;
	Wed, 19 Jul 2023 03:30:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3C1C06
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 03:30:54 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537AE1993
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 20:30:52 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7680e39103bso372379485a.3
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 20:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689737451; x=1692329451;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q5ViIa9kIWhKpjXcZBtYO65UsTVYeK9sG8XIg7UKsWY=;
        b=OOFAVLqjATrStPvjkz6NnW62pm2cGNMLe4dpM6cNDeB5rP5Y5izGVnDiI3Uhjykxg+
         TTCC+ei8wan7SyFu5F4yF2GdKBEDzEoSQUphmNFPuNgTmBHea1PmRR2qP//KG9JFVMF1
         0Br/DjzwQRdgd9lFNRolxIY1vwdZ9kfaueXA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689737451; x=1692329451;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5ViIa9kIWhKpjXcZBtYO65UsTVYeK9sG8XIg7UKsWY=;
        b=DFHwaNdZVF/3t8nUpDrsIxdwVjPyAkQIr6tNF69miUTc1AES3O7gnHeQwd5CKJM4rl
         SfQefJAF5MMN8jAFZ/UE2kPGXsMwCBoDIimc3lVyCgYwJmEpVDsrMPJ7SmP372LCOojh
         jKVk/c4QVrGnCGfeVR5gbVqJgfbZNYBHcVZF8tsHenE/aQgkFlCRqC0tr11jBJtD6jg8
         MJIZY/uxml/Ha3PP+9I5ah9cytTJKy+Blbr3WCxxxY13LTEH0C6bpbmxvBaCwFL73+OC
         DWldqYQtdrzcWwtugvnUf89HW9O3etdmjw7X9uObFKtuJ65N1w2AIZV1NlGrJiT95o2h
         Bf6w==
X-Gm-Message-State: ABy/qLZBoQ+LahRdB8KnDEA44x2A7v5lrtQDlIj+bZzAVaj5WcV3poXr
	F8F7De9SogMLBSWBg7vIoDsLZA==
X-Google-Smtp-Source: APBJJlEDtuDMnxxA73PfvNz3FCIl2UrlOG+E4Uu71tzJs2uiJ2IVYZ5Pm2FW7nVh9jL+ddXoNlHHPQ==
X-Received: by 2002:a05:620a:8287:b0:768:14ee:2467 with SMTP id ox7-20020a05620a828700b0076814ee2467mr1485529qkn.66.1689737451232;
        Tue, 18 Jul 2023 20:30:51 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id u1-20020ae9c001000000b00767d203ed84sm1028074qkk.24.2023.07.18.20.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 20:30:50 -0700 (PDT)
Date: Tue, 18 Jul 2023 20:30:48 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jordan Griege <jgriege@cloudflare.com>
Subject: [PATCH v2 net] bpf: do not return NET_XMIT_xxx values on bpf_redirect
Message-ID: <ZLdY6JkWRccunvu0@debian.debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

skb_do_redirect handles returns error code from both rx and tx path. The
tx path codes are special, e.g. NET_XMIT_CN: they are non-negative, and
can conflict with LWTUNNEL_XMIT_xxx values. Directly returning such code
can cause unexpected behavior. We found at least one bug that will panic
the kernel through KASAN report when we are redirecting packets to a
down or carrier-down device at lwt xmit hook:

https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48

Above bug is hit because NET_XMIT_CN is returned by noop_qdisc of the
down device, and it propagates from dev_queue_xmit all way to the lwt
logic. The result is skb that has been freed by the qdisc continues to
neighbor subsystem and triggers the bug.

This change converts the tx code to proper errors that lwt can consume.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Reported-by: Jordan Griege <jgriege@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v2: coding style fix; sent to netdev instead of bpf for bug fixing.

---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 06ba0e56e369..8738c7a4701d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2129,6 +2129,9 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
 	ret = dev_queue_xmit(skb);
 	dev_xmit_recursion_dec();
 
+	if (unlikely(ret > 0))
+		ret = net_xmit_errno(ret);
+
 	return ret;
 }
 
-- 
2.30.2


