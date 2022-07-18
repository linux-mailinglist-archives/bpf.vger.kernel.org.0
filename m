Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504B45786C7
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 17:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiGRPyL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiGRPyL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 11:54:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A4FB1E2
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 08:54:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk26so17673372wrb.11
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jNOFWD6EWX/ilMsSDswwTAqMX/p75CHGacwLg212UIA=;
        b=pKtudd//N5O7taLzY08jZ7HXjO6PCiCDHPliOFecVIv+sDNVX+AyJXAt/6nVGWR3is
         h+5RS73wR/3i/YG9yUJP4MlWwILmmRLvFGYsbvV1bGEVmLsgG0dFPiTivgqQbrA5J/dj
         vz9nobADF59If0/0wLD3+bRNzsmUzoHY4tVVK6axeQEeWRnB29unNbiCvT6LRjrg4/XD
         r2Qmp+8Y3xniLm5gUt15YoYUdCMKzD4Q5Wv6Ypijmx2hfxFKFjfE9QKTGTxlV5II4ISs
         IGrp3E0Kud1q2XcoPE1EkOvofIn7GSpKJu83K6sxd/w3JMrHHHGGXOw2PChNqqDO1Ysz
         95tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jNOFWD6EWX/ilMsSDswwTAqMX/p75CHGacwLg212UIA=;
        b=XpCYW22afWnqw6DFQ7bCrBylG2v4IfbDoEIpMuiwvrm4cJ5sX/qkrm4F1eNa96uBrA
         PA3KLVjkTaguy31UR09MwagmUqs30mv+/7KnuLItMFDv2OlM6zhMvDc6Kum7rBeUh18n
         t3S68PrU4KbALtO1MVec26LTdiI55+Z/bsNf2UBLhNMi+P8XcgmaoPKyW531WZMEs3Ji
         g6/NDj8+c1JQMR3pktAe7fvzHjdAxRg+pHgdmy8yiBqU4JeAuXx7vu8jsfOLY93dqeY4
         4T4zF5fZ8ugua5CZXQpG7K1Eyg3rMqbjdC8d3XZyNCffENivYsFJfJYuHiaFtdT5/xPp
         bTuw==
X-Gm-Message-State: AJIora/K5T5K/2zfjQmJhettZS3ZecCpfiVjkto/njLPeRxfXp0KfQ1s
        qVnVCI0DyI1xj3K4HdKUDtgA
X-Google-Smtp-Source: AGRyM1tuUbXkTHmwSeQpNvkpX+9RV2rNX0WnzUhlbbdeXGqZ5TcgzBxdsITPDnCaw3Rv47uHxqm1Rw==
X-Received: by 2002:a05:6000:1446:b0:21d:cfe1:67a0 with SMTP id v6-20020a056000144600b0021dcfe167a0mr13565811wrx.91.1658159646328;
        Mon, 18 Jul 2022 08:54:06 -0700 (PDT)
Received: from Mem (2a01cb088160fc006422ad4f4c265774.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:6422:ad4f:4c26:5774])
        by smtp.gmail.com with ESMTPSA id h7-20020adffd47000000b0021d650e4df4sm11230963wrs.87.2022.07.18.08.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 08:54:06 -0700 (PDT)
Date:   Mon, 18 Jul 2022 17:54:04 +0200
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Kaixi Fan <fankaixi.li@bytedance.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf v2 1/5] ip_tunnels: Add new flow flags field to
 ip_tunnel_key
Message-ID: <457f79e53a6b9f0921561bc796a49e917d131635.1658159533.git.paul@isovalent.com>
References: <cover.1658159533.git.paul@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658159533.git.paul@isovalent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit extends the ip_tunnel_key struct with a new field for the
flow flags, to pass them to the route lookups. This new field will be
populated and used in subsequent commits.

Signed-off-by: Paul Chaignon <paul@isovalent.com>
---
 include/net/ip_tunnels.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index c24fa934221d..20f60d9da741 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -54,6 +54,7 @@ struct ip_tunnel_key {
 	__be32			label;		/* Flow Label for IPv6 */
 	__be16			tp_src;
 	__be16			tp_dst;
+	__u8			flow_flags;
 };
 
 /* Flags for ip_tunnel_info mode. */
-- 
2.25.1

