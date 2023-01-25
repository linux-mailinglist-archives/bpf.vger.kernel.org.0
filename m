Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4713367BDE9
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjAYVPE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbjAYVOr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:14:47 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A1C1E9F0
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:14:41 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 430193FDAF
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 21:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674681279;
        bh=ThPASxkQPa8akyDheX0+gKydQu/0488KOg7wyMg90UM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=B+fmEPVuruQRN+j7SD7H2831vp1TkBBrD7jHiSC0FpTyFnnAzfuGtAUdF6ntk/2B0
         V9AygTpNnXO7O9llsz9rRPIO45wHx3UjdOBaceVPZIiRqZnhGWJXTSptG20lyj0g6i
         oEaE8RBDYkgFpyvR6locEX8K7in5ayInM0Q0D4xwmbJTmkQ/RlEEPtTWuN7fN2wzBJ
         ZNlYGbmLChk5YltoZJehJmepTcci6WtaPUhKNI+xBV4S+Rf9U/zr95Ain1NRRlbqBI
         ZRHiQg26yf8wQXT8Tohbf9WzhDwgut0Z530f/F9v1wMzJjw5mY+SnsQO2yeRAdEd25
         ea4pW4T5Tt/bg==
Received: by mail-wm1-f72.google.com with SMTP id k20-20020a05600c1c9400b003db2e916b3aso1713460wms.6
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThPASxkQPa8akyDheX0+gKydQu/0488KOg7wyMg90UM=;
        b=J9JcKe4iWhiTf07uuqeUC+WizJFmNt06Vv6gdtC+nTGHDd11+lNoTqXFUbvcpBwQy9
         3wSvgOsPUoWsXlysb39dl+1fMsJak7nweGWP/ikrOr9fU/dJqJ9lZiIjQD7Sh5y63EPy
         YER48NikDcS9R8tq0k3t5IPy4enqnC8NFFFz/NlDksdn0uGEq0TP9IyHbeTYU9JUfkz1
         rkVwFvzSzoBN+OuOeK7D67xkHRpgEaJZvHIWXNVA+YfFpQjwzQ51TF2g2hyx+H+COA94
         HZedCViVZKYLX+i0HYyaTLLxwGYVNFxZs8IrbJL9TA8llEXdQ36otQfiaz89XldOF47E
         4e1g==
X-Gm-Message-State: AO0yUKU427YZSnmGZCfnwktqOgilVq1TtkZDF4i7UQx/47br0IUYUfRi
        SCQQvrvmYRpXEPIlcozNkamm9tm+1LGAUvu5sXjwILxAbMb4a7ZweQZtCks/ZHrMkwUNbfkCqpN
        nHvKOpgPziFUIU/BDBpYsMW5ayoC5mA==
X-Received: by 2002:adf:a493:0:b0:2bf:b5c0:f157 with SMTP id g19-20020adfa493000000b002bfb5c0f157mr5175452wrb.39.1674681278936;
        Wed, 25 Jan 2023 13:14:38 -0800 (PST)
X-Google-Smtp-Source: AK7set+YG1U/BehDKtOLtFbxMC++ML3k7K+wehcNVLO5HFEq/vSitr9BPNZZqRj5SWCdU9q0dHX8wg==
X-Received: by 2002:adf:a493:0:b0:2bf:b5c0:f157 with SMTP id g19-20020adfa493000000b002bfb5c0f157mr5175441wrb.39.1674681278787;
        Wed, 25 Jan 2023 13:14:38 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600012ca00b002bfb02153d1sm5738146wrx.45.2023.01.25.13.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:14:38 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2 2/2] selftests: net: .gitignore the scratch directory of bpf
Date:   Wed, 25 Jan 2023 21:13:50 +0000
Message-Id: <20230125211350.113855-2-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125211350.113855-1-andrei.gherzan@canonical.com>
References: <20230125211350.113855-1-andrei.gherzan@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The net/bpf Makefile uses a similar build infrastructure to BPF[1] while
building libbpf as a dependency of nat6to4. This change adds a .gitignore
entry for SCRATCH_DIR where libbpf and its headers end up built/installed.

[1] Introduced in commit 837a3d66d698 ("selftests: net: Add
cross-compilation support for BPF programs")

Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index a6911cae368c..0d07dd13c973 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -40,6 +40,7 @@ test_unix_oob
 timestamping
 tls
 toeplitz
+/tools
 tun
 txring_overwrite
 txtimestamp
-- 
2.34.1

