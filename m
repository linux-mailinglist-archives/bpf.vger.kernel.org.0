Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DF959B357
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 13:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiHULfi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 07:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHULfh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 07:35:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1947418349
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 04:35:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bs25so10068620wrb.2
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 04:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=tYznORPkQKLxNTFRVqFfVnAr2bpdNMByP5uRzFSaye4=;
        b=O6Nfd/B607fm4qSm/7cZ4VAqkcrLT8oHhe6+Xx8KAQskKiWcrB6BHcUaINYOdj/UNr
         yCZfGl8JnEDOVXz2yEWPFPydytraRjbsOqHF3xRXd3vG5JPQ3TIclP/i076Ll0jMONCz
         xhYaWnHvKGReu2q+TRRV1BNABmtsatMmZontU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=tYznORPkQKLxNTFRVqFfVnAr2bpdNMByP5uRzFSaye4=;
        b=xdY7FUyUu3xnyAOiQqkkK1UUFVWsr18kZjChryJUPGFnMAn83T7Z5V6CoQopdUichv
         rZA2meNh1tVCHKyIUBx/qIBwEKO6IcGCcyqi15yt/vybllAxDovSxZmmVyAXZsCT1pT1
         VSHIwVcOujlm6ANNi/dEk+V0trOWs5YK2SzOFoc8BnG9iBeqmM/pB1MhFGRveIwrkdJm
         0Cf8PlnQTYvcArNjY9vhXI8tSKr7uHSiUYwUfsffamxnJs+hkU/y4VPNd1Z+DuQzfchD
         EHL2ChRFA7fa5pY2M/YMJgKuny2QJrYHRhzldwGeJZ5/5BG1MrhPM5/22iv5buMO/elx
         b7AQ==
X-Gm-Message-State: ACgBeo1dw3b8AKvwi9kf+UJh0JWdyqbifJFuWx/Uxcx4uCR9EiOZrK+E
        3riYv+tvCuDVePNneftU6SXKdLEUj3e4O81GzjsEBtPtrKJGJ3BJdW1A/4VMgmxj9zxmewGOANX
        QL/AtW/uTe0wHbsi+Dn+3Aq7f02VKAVVnJx1t54qaptvRa2a7xInDHNeqzbHzPtpVdw9Uisax
X-Google-Smtp-Source: AA6agR66l5bTWGK4hNsN/vrGTDJWkgnv2qjRlTOHCfg+I1u3JU+CyMVm162kkcxUMI2sQn69ldhIMA==
X-Received: by 2002:a05:6000:547:b0:218:5f6a:f5db with SMTP id b7-20020a056000054700b002185f6af5dbmr8560996wrf.480.1661081734245;
        Sun, 21 Aug 2022 04:35:34 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c2cc800b003a6632fe925sm1067178wmc.13.2022.08.21.04.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:35:33 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v2 bpf-next 0/4] flow_dissector: Allow bpf flow-dissector progs to request fallback to normal dissection
Date:   Sun, 21 Aug 2022 14:35:15 +0300
Message-Id: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, attaching BPF_PROG_TYPE_FLOW_DISSECTOR programs completely
replaces the flow-dissector logic with custom dissection logic.
This forces implementors to write programs that handle dissection for
any flows expected in the namespace.

It makes sense for flow-dissector bpf programs to just augment the
dissector with custom logic (e.g. dissecting certain flows or custom
protocols), while enjoying the broad capabilities of the standard
dissector for any other traffic.

v2:
- Extend selftests/bpf/progs/bpf_flow.c to exercise new ret code

Shmulik Ladkani (4):
  flow_dissector: Make 'bpf_flow_dissect' return the bpf program retcode
  bpf/flow_dissector: Introduce BPF_FLOW_DISSECTOR_CONTINUE retcode for
    flow-dissector bpf progs
  bpf: test_run: Propagate bpf_flow_dissect's retval to user's
    bpf_attr.test.retval
  selftests/bpf: test BPF_FLOW_DISSECTOR_CONTINUE

 include/linux/skbuff.h                        |  4 +-
 include/uapi/linux/bpf.h                      |  5 +++
 net/core/flow_dissector.c                     | 16 ++++---
 tools/include/uapi/linux/bpf.h                |  5 +++
 .../selftests/bpf/prog_tests/flow_dissector.c | 44 ++++++++++++++++++-
 .../prog_tests/flow_dissector_load_bytes.c    |  2 +-
 tools/testing/selftests/bpf/progs/bpf_flow.c  | 15 +++++++
 .../selftests/bpf/test_flow_dissector.sh      |  8 ++++
 8 files changed, 89 insertions(+), 10 deletions(-)

-- 
2.37.2

