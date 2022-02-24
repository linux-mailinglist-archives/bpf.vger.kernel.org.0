Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D4A4C31CD
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 17:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiBXQq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 11:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiBXQqs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 11:46:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DFB1680B5
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 08:46:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j22so529975wrb.13
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 08:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=siTXojcdsHj7A4c6haRamyOZoZQ5GQeAn8ts6RCL5ak=;
        b=ceHF3pfmGshKrlEMA1qVVI2MHcIPocW6avgHtQjZv4MEg3e9+ddcpn94brrFJX6cYR
         XRs4mirN2cTkYduRoyQ6L04n6dCl9GZE/xUMYGeQEFiFA5kYJIPsIgOvB5lIvGqjynnI
         kgjL+vLIuELViQrxyoAtAi4NORH195Lb97QN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=siTXojcdsHj7A4c6haRamyOZoZQ5GQeAn8ts6RCL5ak=;
        b=JBLnEFeBb2cXp3F/g2UUOc4naJB9l9B95Hd7jCAv7KjfqkuSKYBmZLzxp1q8aYw3+y
         7rJmyu1EQSsJzs7dhq30WSu3eYVdn3A2CHA0TpAokUAQR29zu9p59gqMVjYBs4h/v+/w
         iS9n/8uo7nfbeJhdM41FagpL6Xmw16DIosBI8hrvxq96TDHauae5yZSOX3hsJ7+3Kvbt
         EPl9FjXk7rB0TDs3ti8FPxOGNf/BVsS24MRR51iJ07k9uPJjEhs5FXJbu2Ov1mfaGFwK
         NtTNQUcKi5+jjptbkzedvMBQNz0l3LTxM4BX+/jP6ACdx/2fMqqp4c2Frad54jtZFA+M
         u4tg==
X-Gm-Message-State: AOAM531EPvQppQW/snkvmpcwaFzLbe6+2NFMPC9hbzB6CWQiW1cns/KS
        hlYfZjXz8zLpa9vNWZqotRrvnlmPd9yiqQ==
X-Google-Smtp-Source: ABdhPJy0Rj25t9Cg3zHJnMN2SwQ3NA4ViJIycLd/OKDk7wHUjGxz+nnnUmgEbl9+GnUebNlabEA4Tg==
X-Received: by 2002:adf:f94d:0:b0:1e5:5ca1:2b80 with SMTP id q13-20020adff94d000000b001e55ca12b80mr2979593wrr.323.1645721174925;
        Thu, 24 Feb 2022 08:46:14 -0800 (PST)
Received: from altair.lan (5.9.9.6.7.e.5.3.6.4.c.f.d.d.3.9.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:93dd:fc46:35e7:6995])
        by smtp.googlemail.com with ESMTPSA id j5-20020a05600c410500b0037bc3e4b526sm3240973wmi.7.2022.02.24.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:46:14 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH 2/2] mailmap: update Lorenz Bauers address
Date:   Thu, 24 Feb 2022 16:46:03 +0000
Message-Id: <20220224164603.127058-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220222103925.25802-1-lmb@cloudflare.com>
References: <20220222103925.25802-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm leaving my position at Cloudflare, provide an address where
people can reach me.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 8cd44b0c6579..a84aa8c79bfa 100644
--- a/.mailmap
+++ b/.mailmap
@@ -229,6 +229,7 @@ Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
 <linux-hardening@vger.kernel.org> <kernel-hardening@lists.openwall.com>
 Li Yang <leoyang.li@nxp.com> <leoli@freescale.com>
 Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
+Lorenz Bauer <linux@lmb.io> <lmb@cloudflare.com>
 Lukasz Luba <lukasz.luba@arm.com> <l.luba@partner.samsung.com>
 Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
 Maciej W. Rozycki <macro@orcam.me.uk> <macro@linux-mips.org>
-- 
2.32.0

