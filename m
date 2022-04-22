Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E56450AE6A
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 05:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443668AbiDVDOE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 23:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242898AbiDVDOD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 23:14:03 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7E4CD48
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 20:11:11 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id d19so5009836qko.3
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 20:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UP7eVIExEEfaRhLhpONtmVu0RSfn20yvLqZWzX1qWBg=;
        b=IBqlftPpofyM8JdwFQx00/xA8PfrkESAHeCL0an0pcLls1wMgRSDek29gqbWi4fmeI
         BDqGZQ8i5Q2bFpz7GTjtCNqSOguTr6jBfnfgu80RVriUB+w2y/PObrKEfjSPT7WT8M/2
         K+Rff3NhrSVm6RdoJ41aMLp0WttS/s5/Y8zEk3qh+SGMtkJGupnU8Massas442PZQklZ
         EDGZazeQ/ET/CheKWUnEHqIFaG9HBCTh2WUaHcF1uhASubBgtH7L5nv1dGxe0Eera6fi
         WWJd6KBZntNn6emY4a6XwVrlVl7pp1Ub1SxyyRFBNLoxTWsbF0gSHNQz7ZSQLbFJYxpF
         aT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UP7eVIExEEfaRhLhpONtmVu0RSfn20yvLqZWzX1qWBg=;
        b=CjuL++gj6/9XtoY3Ddv3AVuaVYAVPJzKBrKPpFu+xwx6K7QEpvnX3ixGbvEGdgL6tR
         l0v3vooqUkJsTrsT1/Xh/FYNXlBaSNorYWcEPl2M0OvQhTY4v5JKXe34Zk9kJO9QiZtq
         T76YexQGC3Kmrw3vTROBOfvlhZwTyF8mJq/qMTkdwzDXfauVXFF08OmaLGc/iaAIniVY
         AwVvl7DGqvD/UPHehL2HmgdfHT3y2EdJ7xo1OIPFBvKu7xkrGyGG5UsQfvIdHlbUAoko
         IkxXzYD2C6MckvjHXEY/BmttaLJRg2mt/NFIks+jsxvSfbDBgTox+th/z2CzdjT4XepR
         FeqA==
X-Gm-Message-State: AOAM532ANvoqjWR+32LfVvZmJwp3wBiFlnTX5gENQCqfVoupQZfMnCrC
        S8yK/KlT9XBGAgPwLz/mLPD4pb74kumeMA==
X-Google-Smtp-Source: ABdhPJyyUTfa4edINYgayYRZ4DE+dpTJ0//uE5rWE4f0G//2fWSB0iBA67X7JVvdGQhQu51YBtr9LA==
X-Received: by 2002:a05:620a:4096:b0:69e:abde:b316 with SMTP id f22-20020a05620a409600b0069eabdeb316mr1498867qko.50.1650597070617;
        Thu, 21 Apr 2022 20:11:10 -0700 (PDT)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id p17-20020a37a611000000b0069ee79a16e3sm396679qke.0.2022.04.21.20.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 20:11:10 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, Grant Seltzer <grantseltzer@gmail.com>
Subject: [PATCH] Improve libbpf API documentation link position
Date:   Thu, 21 Apr 2022 23:10:50 -0400
Message-Id: <20220422031050.303984-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Grant Seltzer <grantseltzer@gmail.com>

This puts the link for libbpf API documentation into
the sidebar for much easier navigation.

You can preview this change at:

https://libbpf-test.readthedocs.io/en/latest/

Note that the link is hardcoded to the production version,
so you can see that it self references itself here for now:

https://libbpf-test.readthedocs.io/en/latest/api.html

This will need to make its way into the libbpf mirror, before
being deployed to libbpf.readthedocs.org

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 Documentation/bpf/libbpf/index.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/bpf/libbpf/index.rst b/Documentation/bpf/libbpf/index.rst
index 4e8c656b539a..3722537d1384 100644
--- a/Documentation/bpf/libbpf/index.rst
+++ b/Documentation/bpf/libbpf/index.rst
@@ -6,14 +6,13 @@ libbpf
 .. toctree::
    :maxdepth: 1
 
+   API Documentation <https://libbpf.readthedocs.io/en/latest/api.html>
    libbpf_naming_convention
    libbpf_build
 
 This is documentation for libbpf, a userspace library for loading and
 interacting with bpf programs.
 
-For API documentation see the `versioned API documentation site <https://libbpf.readthedocs.io/en/latest/api.html>`_.
-
 All general BPF questions, including kernel functionality, libbpf APIs and
 their application, should be sent to bpf@vger.kernel.org mailing list.
 You can `subscribe <http://vger.kernel.org/vger-lists.html#bpf>`_ to the
-- 
2.34.1

