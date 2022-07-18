Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0B55786CB
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiGRPzB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiGRPzB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 11:55:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C63186C7
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 08:55:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bk26so17677080wrb.11
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mDb9whvWU3aIAljsROfD3VS/LVSIYuoUZ7vz5yEj+JA=;
        b=vOh9tiz7pU4joZzaooEQdjB/tWxraeC9px8ydo+Zmqpu/svNVGMX7YsCes47OzRRpe
         MoHVCNTEsMkKLATfWDJyvqRSMaJ1ZfoygRUs5DJw9n8MvrWfwM3pAL4PqLzmCoXNkzNW
         dNfQ5GdyogB/IqLOlemx6p1HUfbd51hZaA8Or4FAy7TU94zPc1bCstusDDDOKTS18Cee
         d0sErCsr7tqf2Uw/o5erWjR0F/czk5GrC220XYMUEok+z6OicSZESu+SUHJncmY5aNKi
         l5+t86zRFgYCLcFVnmZjC5mCD9K2sA160v62MRBYQTqpfz8ogIC8iSIvtZdFsWB0gOPX
         1MNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mDb9whvWU3aIAljsROfD3VS/LVSIYuoUZ7vz5yEj+JA=;
        b=hP3a1eePyiS4THeSEcH0toKyPxgG2+qjx7ztNR2n4LNSu0KnDMaUxVw6MbgQQyWIk0
         0UzHVsleTqBFaUB5q6uZd1qxn/WucFK0oFivHWpebMY932jqr/qzS/I+0JFTuDYa5P4g
         ZHA9Mpg3CeaubwZBbKI3kF2n1DnBrdbV1/j6p8Ek6OJehQ/+KU+RJpnCb68wl0IQFfpZ
         YuYxwSNBuf/cmk6MvwHKBKuexfxkVZooKGUaVmL/UXLy5LiDtJEHzaOv8M9JTfNklYqG
         fZmAW8qHSyL+nz+iXVLCLV2W6YiJzS19O6o7ujZXm77D/VcH3Od4IMfoQQFE9fZluejw
         gBWA==
X-Gm-Message-State: AJIora9sQf8vRvwQyVBXHWj5zV2GBz/O6BELlxyyaiKQvlR7CQZHqYUO
        gK1mFjdLVOUgKXx1sncjT0ts
X-Google-Smtp-Source: AGRyM1twMDtcUqhsDm1D5PjPfYTk8J48S6lNCSgyxg6Bi/vBvQgWfob+8o0q1du/jnuOupvJ6cWY0A==
X-Received: by 2002:a5d:5451:0:b0:21d:2295:6a05 with SMTP id w17-20020a5d5451000000b0021d22956a05mr23098167wrv.302.1658159698730;
        Mon, 18 Jul 2022 08:54:58 -0700 (PDT)
Received: from Mem (2a01cb088160fc006422ad4f4c265774.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:6422:ad4f:4c26:5774])
        by smtp.gmail.com with ESMTPSA id h7-20020adffd47000000b0021d650e4df4sm11232724wrs.87.2022.07.18.08.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 08:54:58 -0700 (PDT)
Date:   Mon, 18 Jul 2022 17:54:56 +0200
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
Subject: [PATCH bpf v2 3/5] geneve: Use ip_tunnel_key flow flags in route
 lookups
Message-ID: <500695e5e5cfbfd94f37959c250e194aff88c7e1.1658159533.git.paul@isovalent.com>
References: <cover.1658159533.git.paul@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658159533.git.paul@isovalent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the new ip_tunnel_key field with the flow flags in the IPv4 route
lookups for the encapsulated packet. This will be used by the
bpf_skb_set_tunnel_key helper in the subsequent commit.

Signed-off-by: Paul Chaignon <paul@isovalent.com>
---
 drivers/net/geneve.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 2495a5719e1c..018d365f9deb 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -815,6 +815,7 @@ static struct rtable *geneve_get_v4_rt(struct sk_buff *skb,
 	fl4->saddr = info->key.u.ipv4.src;
 	fl4->fl4_dport = dport;
 	fl4->fl4_sport = sport;
+	fl4->flowi4_flags = info->key.flow_flags;
 
 	tos = info->key.tos;
 	if ((tos == 1) && !geneve->cfg.collect_md) {
-- 
2.25.1

