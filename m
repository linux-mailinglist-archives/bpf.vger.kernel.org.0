Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B73576405
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 17:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiGOPDH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 11:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiGOPDF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 11:03:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E297BE31
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 08:03:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so3031773wmb.3
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XUUk00/TjPArZ0mXnxJW0zloRPmWlYco9FTFKH+pLFQ=;
        b=OM2veA4WKKocg94uSF1SEQfSTNA2LhJAJG65r9TwBUUYIPrVGS9bTbmlVBq5H8Chs6
         q4zE4j7bhIOMv8M78iqzAh/JOFCYkXOXJdqXgjRI0r4WMsMJHIFvPNRKfVsid2nCc1ZY
         xGicVm29OW9IcyMdD1qZFCU7kvIqCC12fmFuZEyNXKp0coqQr4GuMSy5cyn5Y3vlZ6M4
         Agt+3OPG7swX/WCCdz+oqaY6AKdYEy39dCsOZlJ/miyoO3LR8DE6+zB9QxI+3sGMW3DT
         ACfb1wE6Cw23H89K7LdAO/tu8GQkgq1lrITaWmnGdoKOrUXt+iybOmRKXQ5/Tv0FOhal
         rfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XUUk00/TjPArZ0mXnxJW0zloRPmWlYco9FTFKH+pLFQ=;
        b=2AILJLE2afLjjTOotLyEqufCAmNU37Udl+JCaL3Bzwnx4remsMQFsboRWqos8pzY/4
         iWE25EHF0+OamS8wsxXvp0yk2Yo3Eg59lb51kUPhpte1m6IgqwaatVemKAXgpssfzvej
         jMb0Bc6kUfGLVOQ/XCSHMme1k2FiSNclwLsrshJ3xbw2o954ViOdzv9z0bfykhe1V8wk
         0tU5oOzpP/82RFTy7RxMavTEr7Nfa7RtL2sS15bsvszAj2QMVWiUb3h5oVnlvOaYKF/g
         TVglW9YjMCyLIyTCIojSt8pUy2cKeosAFPDRm5Ha5ZH43wVxMol3ILiRJE+uIoUMWzis
         nCFA==
X-Gm-Message-State: AJIora/HwW8ytLb+9wURr+qmq9OXAfnFy902L3BcUaI4S1THU8QW4DJP
        h0B5r9YAQGdFztdTHZbu8FSu
X-Google-Smtp-Source: AGRyM1t9wJGmJtM3O73qbYDljCQWWCeJf3IDtfzo9kGuSiJRxvBVzfsLxAqqe6SEHC36NaBUyAquOQ==
X-Received: by 2002:a05:600c:a03:b0:39e:4f0c:938c with SMTP id z3-20020a05600c0a0300b0039e4f0c938cmr14406450wmp.145.1657897383819;
        Fri, 15 Jul 2022 08:03:03 -0700 (PDT)
Received: from Mem (2a01cb088160fc0095dc955fbebd15a0.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:95dc:955f:bebd:15a0])
        by smtp.gmail.com with ESMTPSA id d16-20020a05600c049000b0039c96b97359sm5355917wme.37.2022.07.15.08.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 08:03:03 -0700 (PDT)
Date:   Fri, 15 Jul 2022 17:03:01 +0200
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Kaixi Fan <fankaixi.li@bytedance.com>,
        Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH bpf 5/5] selftests/bpf: Don't assign outer source IP to host
Message-ID: <8f04b8e911fcb8166ed964d4eb154a2e0586ca92.1657895526.git.paul@isovalent.com>
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

The previous commit fixed a bug in the bpf_skb_set_tunnel_key helper to
avoid dropping packets whose outer source IP address isn't assigned to a
host interface. This commit changes the corresponding selftest to not
assign the outer source IP address to an interface.

With this change and without the bugfix, the ICMP echo packets sent as
part of the test are dropped.

Signed-off-by: Paul Chaignon <paul@isovalent.com>
---
 tools/testing/selftests/bpf/prog_tests/test_tunnel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 3bba4a2a0530..14ccb41a9f59 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -111,7 +111,6 @@ static int config_device(void)
 	SYS("ip link add veth0 type veth peer name veth1");
 	SYS("ip link set veth0 netns at_ns0");
 	SYS("ip addr add " IP4_ADDR1_VETH1 "/24 dev veth1");
-	SYS("ip addr add " IP4_ADDR2_VETH1 "/24 dev veth1");
 	SYS("ip link set dev veth1 up mtu 1500");
 	SYS("ip netns exec at_ns0 ip addr add " IP4_ADDR_VETH0 "/24 dev veth0");
 	SYS("ip netns exec at_ns0 ip link set dev veth0 up mtu 1500");
-- 
2.25.1

