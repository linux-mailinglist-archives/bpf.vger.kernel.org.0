Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262CA5786D0
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 17:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiGRPzd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiGRPzd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 11:55:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A17D2A25C
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 08:55:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bu1so17687660wrb.9
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XUUk00/TjPArZ0mXnxJW0zloRPmWlYco9FTFKH+pLFQ=;
        b=EXxkakBYHHMmV1resyEvWwZDbmjWsWVlSMwrmJMu+fyaOY1DJWzFfwrcxGt7evNn8T
         TkZYQPcBY4yXz6LWrNgh/tctKwzhj9EOrq2o58NA+f7fPwH/IAYkmw8uFCbRLLmqC36L
         afBwLwG9CTtHVVS6eG46ogvGj4yYjIcG/Wv4vddlurYvfEvM2v0MiLXoAj71GHjfPIqv
         ZDDGYrK1PGil1TBCkdYnFADTu7+opZpKg+aEKjFRSPynGkG+8zjpw7pm+jc54/73g5CS
         b0tvbSGoTslNE8gcOvqAMhYpLs1Igmml6RJEv6pm1utpg7tn8xROxqr5eWSLWRBDyEwE
         BElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XUUk00/TjPArZ0mXnxJW0zloRPmWlYco9FTFKH+pLFQ=;
        b=Fe2tURzh/OXhq/SAtCnGxq+HuNZeUiylnPACRaM1uiDBqhdfnQGVPTQJlpH4Acrmbl
         VCktoHpytO6QOIIhYb8McdzHkhv+yr3WWiXAMadHcg9d0ALNMt+eG35jyC6PeZStn76f
         PR+zTPj1iSheArTrytJLqgiNVoqbsYtQseOsN+TbZM2AnyAwvyBR4/ECqK9DMa1lmLRD
         GoCWoW9F/JTH8i3kvKUzT3DawImYya7lm36tKKeqfIpZCvNb9zwFx8XUFmO4B/YJnEDt
         utvUdr2B/0a8qQtRnZ87pwVri/MOoRkY9a3W2OkddQtCp3kOGkmYsKUafXd37UOaJj+f
         +OOQ==
X-Gm-Message-State: AJIora9VTqbAzNyOCSUBIB5/LGYopOuIfYW5IqZwZV8RtIgISgyRhbdQ
        nWJ9yM2rQwTLBdGkkSunKD1u
X-Google-Smtp-Source: AGRyM1vwtfQ8ITTvIIUj9bCMNXMi61TsMC6zmPCQEUqTOUydZvpfUpu6N3bpglzrpzFDX+fvgOdHsA==
X-Received: by 2002:adf:e6c1:0:b0:21d:6497:f819 with SMTP id y1-20020adfe6c1000000b0021d6497f819mr22250931wrm.243.1658159730971;
        Mon, 18 Jul 2022 08:55:30 -0700 (PDT)
Received: from Mem (2a01cb088160fc006422ad4f4c265774.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:6422:ad4f:4c26:5774])
        by smtp.gmail.com with ESMTPSA id d14-20020adffd8e000000b0021d6a23fdf3sm11214824wrr.15.2022.07.18.08.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 08:55:30 -0700 (PDT)
Date:   Mon, 18 Jul 2022 17:55:28 +0200
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
Subject: [PATCH bpf v2 5/5] selftests/bpf: Don't assign outer source IP to
 host
Message-ID: <3509b3fb239bdb56d420f49f0abf8343d0063f83.1658159533.git.paul@isovalent.com>
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

