Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DED64291F
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 14:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiLENRI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 08:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiLENQy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 08:16:54 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC991C10D
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 05:16:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h7so12504099wrs.6
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 05:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRPlxzNUmLNbfqV3ex/lSNbvwuzx+Tg8V9xFc0/6+1A=;
        b=himf13Uv9yZhelo5O1yL4w5w12deKiSWMLPv41KgbdBSdnK8F7kplDtKYHdic+nmSV
         34bfLiw47fG00JChZ0TAcjn2/DwXfGlTUjROw9tTpmxQv30+sBQNH4Dv3UJahOu5Nwtg
         eaN3m35QBrNrIF8LZP1JpfJCPNDMeCrvhemQPz7YxBv94D9Y/hUx3Q1XaOoqe9iTBdja
         5hxMcrcBTlMg78nSoYfXLpklJYjr7eSdkM2h32KRSQnDCWgpQA9bel/1kPMbKlhW9NAj
         EiZjpT3RuqsLtRNUdcTS0uMgD6YPQ8RRlbDmBcFHaVgdR93iFiPhJy0Y4oTHZGogp71v
         h97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRPlxzNUmLNbfqV3ex/lSNbvwuzx+Tg8V9xFc0/6+1A=;
        b=2k7qxiDj4MeprE/KwezPtTtk1EjVxUryvtRf8otAfvNbJ3T47Jmi4IkPx/m8VPaykm
         fc0HK3cKqD3al0lpIzd8kxa8OElKGPAUGt2b5XLQA8+LKA0lAA03qbHvnqE0VBVlcQxg
         2T6rvrpXzwcg4GvEsmIfhE127Azp9hMSkt5r3+dfjAQVt5n85u1RYHGzhWYSg2EJcE73
         +1Xwaw5QVtq4Z1eB46gNBo3GnE+duaIzymbg/BdXjsptvVnaY2niLBjLYrxw4+vsIxj7
         9KPe5SVtQ084kzJdskT2A/Mvkts2Ca1S0we4rbN/ahQ/gysJ/BeHSropLJasF9g4VNLu
         BrUw==
X-Gm-Message-State: ANoB5pk/nI+gr7jsVEsy8xxTl2Baci1AJWwHY8RIXT67PnLj0T/dbnhw
        Jw3eEew1pedqn13IHHr2ykrCIMWStHbBYhy6
X-Google-Smtp-Source: AA0mqf4O/QuexrRbo8JEmihsYEkj7AYXuqHbZpA1LeeDjUam5R9FPyJTGeO+zfxpkP8e1TXmMGvzkg==
X-Received: by 2002:a5d:5187:0:b0:242:5ef:ce32 with SMTP id k7-20020a5d5187000000b0024205efce32mr28942793wrv.260.1670246205944;
        Mon, 05 Dec 2022 05:16:45 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:48e0])
        by smtp.googlemail.com with ESMTPSA id fc13-20020a05600c524d00b003d04e4ed873sm24710492wmb.22.2022.12.05.05.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 05:16:45 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Use CONFIG_TEST_BPF=m instead of CONFIG_TEST_BPF=y
Date:   Mon,  5 Dec 2022 14:16:18 +0100
Message-Id: <20221205131618.1524337-4-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205131618.1524337-1-daan.j.demeyer@gmail.com>
References: <20221205131618.1524337-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

CONFIG_TEST_BPF can only be a module, so let's indicate it as such in
the selftests config.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 tools/testing/selftests/bpf/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 3cbdbf57a403..75895bee8cb6 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -70,7 +70,7 @@ CONFIG_NF_NAT=y
 CONFIG_RC_CORE=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
-CONFIG_TEST_BPF=y
+CONFIG_TEST_BPF=m
 CONFIG_USERFAULTFD=y
 CONFIG_VXLAN=y
 CONFIG_XDP_SOCKETS=y
-- 
2.38.1

