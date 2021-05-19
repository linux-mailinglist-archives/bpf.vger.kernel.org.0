Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393F93892EE
	for <lists+bpf@lfdr.de>; Wed, 19 May 2021 17:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346727AbhESPtJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 May 2021 11:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhESPtJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 May 2021 11:49:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B1DC06175F
        for <bpf@vger.kernel.org>; Wed, 19 May 2021 08:47:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so3748745wmk.0
        for <bpf@vger.kernel.org>; Wed, 19 May 2021 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aTBUJY+N/o7ifFl7UqC9v292/yzVBDT+R1oIkU+0vXo=;
        b=NeqeimpuSmstQSPg+NYzdBXSGNoX5YHqh9Qv+xbdnJ1ZsRIOHYEE3TuzQKvd5R3oJW
         dcAjyhB1WWZ5SnZt0RMZTKJqpyCKBHB/CaQb9sGekXKXgOtbSWhJhK/xJwYHnG2Y/Eky
         BI/8q8Ff8Jyma6YfHGyl2b/XHIFpzNhxke/6l7k+lRWgyCuch0Ff4bnp6JTftz7XOnxO
         d+GRP5cofmkPCWOLs9a3CkajbAeIWWuWnFnX6H1+h8vxqCFfqezoHdo3RVlnc9M5G+yv
         j1glZlTkmV4rqDqgOMr9nb2MTJbLt1CuQvUoT8hQOPxWak1hicEHYPp8d/jAzzmHNIjD
         tkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aTBUJY+N/o7ifFl7UqC9v292/yzVBDT+R1oIkU+0vXo=;
        b=DiRbAsUxKDLlh0i8e3NRQnZ993xl4eD+4gSEnH/L8w87MdJTbxhSShoGqIP1vcV2VU
         wysdAwG9MJbUREjZWvKiYSjJlVl/+Q+ChAkw11ENBYdlBe+rhqaMIEzgKsIFK9xGdB1p
         puAkrnMKInhhWP/Cm7pLcQ0SAoTKqKUQ8mPGcVK1tgGVytEK7i+kOqZWB4kP4IIpuvAI
         JHE0JbiTCiieqUGpGtcB2bhhOVBb+MTgKjBNfPchz3XrTiIfGywc2hxl6G8nZNR2Yehw
         9/3Fhbrea5r/mbcSO8HDqCJUnCx3zFGnpswUXEX3aikThZh+OzdYu8YWF1uSTL4nIZ5y
         /MFA==
X-Gm-Message-State: AOAM531RO9WaIZ0TLnh2XCzuA+HNG0o/Ryuih/20LGa9IGX5IHTxyk1Z
        sedZtPHvlr1jiebpwc1AllZyPPxrzL6l
X-Google-Smtp-Source: ABdhPJyHAKXlWrtr6McOxWLyeK1dOGlP+x3Lpj8xqVushq33PdzNhhYMuRTQlhY+RDSIkT3C0hiWDQ==
X-Received: by 2002:a1c:2b83:: with SMTP id r125mr6200669wmr.77.1621439266539;
        Wed, 19 May 2021 08:47:46 -0700 (PDT)
Received: from balnab.. ([37.17.237.224])
        by smtp.gmail.com with ESMTPSA id y14sm6103722wmj.37.2021.05.19.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:47:46 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, andrii.nakryiko@gmail.com
Subject: [PATCH bpf v4 0/2] bpf: Fix l3 to l2 use of bpf_skb_change_head
Date:   Wed, 19 May 2021 15:47:41 +0000
Message-Id: <20210519154743.2554771-1-joamaki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210427135550.807355-1-joamaki@gmail.com>
References: <20210427135550.807355-1-joamaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This fixes an issue with using bpf_skb_change_head to redirect
packet from l3 to l2 device. See commit messages for details.

v3->v4:
- Run the tc_redirect test in its own thread to isolate the network and
  mount namespace modifications to the test thread. Fixes the failing CI
  check in v3.

v2->v3:
- Refactor test_tc_redirect_peer_l3 to use BPF for passing packets
  to both directions instead of relying on forwarding on the way back.
- Clean up of tc_redirect test. Setup and tear down namespaces for each
  test case and avoid a more complex cleanup when tearing down the
  namespace is enough.

v1->v2:
- Port the test case to the newly refactored prog_tests/tc_redirect.c.



