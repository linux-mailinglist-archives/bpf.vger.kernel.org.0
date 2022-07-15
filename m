Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3FA5763F8
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 17:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiGOPBH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 11:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGOPBH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 11:01:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA9C7AC1C
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 08:01:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h17so7146792wrx.0
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jNOFWD6EWX/ilMsSDswwTAqMX/p75CHGacwLg212UIA=;
        b=3x+YM7a1x4GZKfTQerXh3xdV/n3rhT4J5GK1vUMPEnBz8iShqUsnZix5jhRQLVemDW
         PtzfIeTHN3t0aobVk6DmRqbgXa7XCulj6gnPCuQ7NFokMqFtakrrQtYw6K6gFvzgF9nE
         cktRwa6/5neoX9aJtW90I4ck10X5JTmNLLnxcCnp8fQKfgL2PGzEoYuoycrw8L32Yhaj
         Uw4p7Y2CVNgzDippCnh7YAeNdIP71drh3G8qwU2EaU31Nsax4nNe45CgctIbjR5/NUWY
         CoMGiWfzeFpbEuaAhpzYCjq6VK6ALa8Uxbk1Uf+PW9hEWlJGNS8fcvq4b6FPcIY2Q4dV
         RN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jNOFWD6EWX/ilMsSDswwTAqMX/p75CHGacwLg212UIA=;
        b=rFjR8SO1i/NMZCm4lKFw9d5Vj1Q6UOdRjaZVaLSmXhS6NYJI4XyUr89pJGAu7WDwfc
         G5ZQ/z+uGP+cXXwU/a+eBvH+Ta6BA4zJsSzzF3tYke+jlPm3fcOg9dRbTQGJPWzpy6hZ
         N/Lm6fNTXccaolz0lSVLGNmmcrNLFiu0OnJymj4h+quXF2lwIAqtgezz230Rwcmo82Ss
         F5IbA7959LwwTCORsTlEQ6fDvvnEMtv6+sY2KjSgV0CabrZqpJ6JeXSPT4VQcqiHHeZE
         ++DA/jUL/tvE0Cg4ZHwJ1tW7gbrk5cv3jYaAgZXVisYX7ghkicuf0eyK9gpxFHzEta6N
         4yXg==
X-Gm-Message-State: AJIora/NFhEthHolStQpvj2Q817ZZfgQSB3JrN4zIaCh6nrLcU6gtYwy
        sGHoV7ml/j8qZ6PLBz0/FdVj
X-Google-Smtp-Source: AGRyM1srnY/B9l9X6av7ND4wDeY38iSSKSh/7xiN/bXpISRK3guMjtmraKsZ8m5U0xWzZ7mfsCyioQ==
X-Received: by 2002:adf:e702:0:b0:21d:6900:ea1c with SMTP id c2-20020adfe702000000b0021d6900ea1cmr12563421wrm.620.1657897264879;
        Fri, 15 Jul 2022 08:01:04 -0700 (PDT)
Received: from Mem (2a01cb088160fc0095dc955fbebd15a0.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:95dc:955f:bebd:15a0])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c425500b003a2cf5eb900sm5292466wmm.40.2022.07.15.08.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 08:01:04 -0700 (PDT)
Date:   Fri, 15 Jul 2022 17:01:02 +0200
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Kaixi Fan <fankaixi.li@bytedance.com>,
        Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH bpf 1/5] ip_tunnels: Add new flow flags field to ip_tunnel_key
Message-ID: <457f79e53a6b9f0921561bc796a49e917d131635.1657895526.git.paul@isovalent.com>
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

