Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921FD6149DC
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 12:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiKALuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 07:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiKALtj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 07:49:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D2F1A201;
        Tue,  1 Nov 2022 04:45:48 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so9795109wma.3;
        Tue, 01 Nov 2022 04:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ehJcrERPzOEcWmqIGsgO65htzSJcd+ZTmsquI+FkRLE=;
        b=nTp6CS7Qp14dWvZtV/0jAo5ouds0QY08loXSS895oZUf0dlLUK6ansiCPW7zKyPEy4
         1ZarNcWZe7hI3JexCC/2K292E0cTvc7ZZKEwrvDtiBP4WXfSAQzaCHpNKjAsbKIlgzWf
         qAGVgIhHsIOCGv+9y8jcr2uSk9BMOuMKZwUpq5BG9jJB4/qWrotnR1PqPHk4euKnNkwe
         T56YwzhuFcBOh5XNCSgBOsY7bbJKUoAICT8eqSTIWvmc+ke9pnihPz3JUv1eWA05OVnE
         1Cwf/nu6treU58W+JmhYjclPmnuhDtKZJcv4k5TSOiA/GPztK9usuCNnAaTevlUkythi
         3mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehJcrERPzOEcWmqIGsgO65htzSJcd+ZTmsquI+FkRLE=;
        b=qSaKc01Modyng4E2No9nu6dd+gmiob71DU8N/6h2YxNfJ94581iFKfcd2nAXHqtU2d
         oG1AVexBI1ygy9zKndxxsh2P2aokmXOcYFIgJJSzcTm3NwPKWO5jcK44dZVvIUPnpq1l
         DAGhfXGkmErtbf1RwGsc/QmiAcDSCcpkG0AbeJkxFzmA0GVdcOBTFkV0yRt0NtmcjphT
         mHbxD5VgnaeGOdctg/UaSH/RP7Mt5EQG02MJzktWGhIDhPduxKhep3nr8XcgYEn0RthU
         CFzI3dO8BoS2ug81xVyU0MiUX3rVlrVK71/pPbE1Nme2gcnLoa9HiNDLn/j3Jt0OnXxx
         U3PQ==
X-Gm-Message-State: ACrzQf24TRED5hvZ6t4LMio2XquZrE1Az/+Vwb0IuIwK0kmUhO3X3OjW
        xi1cLVuyDv/tvXLhUvH8WjR01AZld9qSFg==
X-Google-Smtp-Source: AMsMyM4V14zjltMHT+Cwt4uiXsXiP69ygUo2erIfjWP7sRfB6CO1jn6U5UrCNRcd/V9FFYIK5RnC6Q==
X-Received: by 2002:a05:600c:2212:b0:3cf:6068:3c40 with SMTP id z18-20020a05600c221200b003cf60683c40mr11665436wml.57.1667303146635;
        Tue, 01 Nov 2022 04:45:46 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:1575:dcd7:a83c:38b])
        by smtp.gmail.com with ESMTPSA id f18-20020a1cc912000000b003cf5ec79bf9sm10279291wmb.40.2022.11.01.04.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:45:45 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v2 0/1] Document BPF_MAP_TYPE_LPM_TRIE
Date:   Tue,  1 Nov 2022 11:45:41 +0000
Message-Id: <20221101114542.24481-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Add documentation for BPF_MAP_TYPE_LPM_TRIE including kernel
BPF helper usage, userspace usage and examples.

v1->v2:
- Point to code in tools/testing/selftests/... as requested
  by John Fastabend
- Clean up some wording

Donald Hunter (1):
  Document BPF_MAP_TYPE_LPM_TRIE

 Documentation/bpf/map_lpm_trie.rst | 181 +++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 Documentation/bpf/map_lpm_trie.rst

-- 
2.35.1

