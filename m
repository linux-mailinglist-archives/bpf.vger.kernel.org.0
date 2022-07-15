Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C935763FD
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 17:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiGOPCJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 11:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiGOPCJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 11:02:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76A7B362
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 08:02:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z12so7102847wrq.7
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EfG5Vmq+7RCHk9EyoVnjhujw/dAMQt8Collt+KmmvH4=;
        b=QFTfrdiJHFKaAXOA62RvrMQndAbXWdmhfCiB7lsRilaC2qaRf1Vp4LtzBWOzUDZ/6n
         VRIy/bbKukUgrQEf4tx0c5qnbRhq9NtAi/drIdMqv/BuHaBIaOPswUFlFemm+27p6u1J
         r1dMOl6799ROCL1PykQ5V5XRR+EMwgKxAZZQeXrCMxN5f4rNB7mAWZvhgHD4pIxYsyuX
         +GsJ6AuoTTM1xauvpLNHyeA632xbPAu4ZVuQymk8NKT6apkN9xC99w3q+y5G2a1WhsYx
         x36XisUBDiVrjJA1VbdLG2s4F+vkWqLJF9eL2ODTMzHIgK5kBMWxhbHnWxo2ASBbo8vp
         C7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EfG5Vmq+7RCHk9EyoVnjhujw/dAMQt8Collt+KmmvH4=;
        b=F5zdy7n7nMtiHmxrNF2I35UO4pCnhEycyjK4j2hK6uMUfzv8GirEO5Lu0HRuGd+uDw
         ey/mkJMnvW9+ozIW2Bm0DP2rHse934omuiM0yViM+j534VNiu0f1WcVS8g0AAJN/69BK
         WKg2NFCpo+wp+TfCCMbqWs/q9iyaDOiD9E/wmW0i1vPuwEvo+NOJuvF7Gsm154ZR+MzV
         JVNn2WO2OuTSv5YiFhoizAUPL6QMd1Tgc7rIoGwxPID5S+kV1L0U/O2rEq8PUs+Z32i/
         u6Ct949/3PDjqgQ0IIBPFhj/Fy0cQPCqgy2jzHm3Quf2Y987qrDD7u9AIEEzfjrLv7aE
         o1yw==
X-Gm-Message-State: AJIora81PAbFegI+gfi+W+3PE/vmabrzOJf/NwYmYAr0bhaaTT9kUMrF
        8qdNkMELTKPVkmJNxvWbG3Fp
X-Google-Smtp-Source: AGRyM1uiWPsZlqGwGr10aVv9iT+usN6YgVKBc694CkBqReFG1w0nXt6th+MaUgLBF3Wr7GS/eXD9Jg==
X-Received: by 2002:a05:6000:1841:b0:21d:b6ca:2e19 with SMTP id c1-20020a056000184100b0021db6ca2e19mr13219905wri.599.1657897326616;
        Fri, 15 Jul 2022 08:02:06 -0700 (PDT)
Received: from Mem (2a01cb088160fc0095dc955fbebd15a0.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:95dc:955f:bebd:15a0])
        by smtp.gmail.com with ESMTPSA id bw3-20020a0560001f8300b0021d70a871cbsm3915090wrb.32.2022.07.15.08.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 08:02:06 -0700 (PDT)
Date:   Fri, 15 Jul 2022 17:02:04 +0200
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Kaixi Fan <fankaixi.li@bytedance.com>,
        Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH bpf 3/5] geneve: Use ip_tunnel_key flow flags in route lookups
Message-ID: <f9a04d5e7a2b3421385a68e0d5cce29aa796e75b.1657895526.git.paul@isovalent.com>
References: <cover.1657895526.git.paul@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657895526.git.paul@isovalent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the new ip_tunnel_key field with the flow flags in the route lookups
for the encapsulated packet. This will be used by the
bpf_skb_set_tunnel_key helper in the subsequent commit.

Signed-off-by: Paul Chaignon <paul@isovalent.com>
---
 drivers/net/geneve.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 2495a5719e1c..efad129ca8fd 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -815,6 +815,7 @@ static struct rtable *geneve_get_v4_rt(struct sk_buff *skb,
 	fl4->saddr = info->key.u.ipv4.src;
 	fl4->fl4_dport = dport;
 	fl4->fl4_sport = sport;
+	fl4->flowi4_flags = info->key.flow_flags;
 
 	tos = info->key.tos;
 	if ((tos == 1) && !geneve->cfg.collect_md) {
@@ -868,6 +869,7 @@ static struct dst_entry *geneve_get_v6_dst(struct sk_buff *skb,
 	fl6->saddr = info->key.u.ipv6.src;
 	fl6->fl6_dport = dport;
 	fl6->fl6_sport = sport;
+	fl6->flowi6_flags = info->key.flow_flags;
 
 	prio = info->key.tos;
 	if ((prio == 1) && !geneve->cfg.collect_md) {
-- 
2.25.1

