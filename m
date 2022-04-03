Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC34F0B13
	for <lists+bpf@lfdr.de>; Sun,  3 Apr 2022 18:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiDCQKJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Apr 2022 12:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiDCQKI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Apr 2022 12:10:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC2B3982F
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 09:08:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id f18so3283108edc.5
        for <bpf@vger.kernel.org>; Sun, 03 Apr 2022 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hanYBf6ntGMX8alKY8GpfKVwvT1p2AjZMh65KWY/3eM=;
        b=A3HKQNEL6HQvcnybDBS/8S9A7QB5fA0jDSBFyHyPsmTxz+c9U2JREf8vlx+Pq6/QvJ
         tt2FHCkfIclqsUg8ekVtapVlTkr5FzSSXeoBz1RCDP8PtsFbQaVlWAAH3bSLunUUe9jZ
         41u6yCIlpyrH1h2vooKzOy9v20WLJv+86drzT4QN+HUOX8gQ0PR+iCv6JbuJjzVRvSDK
         Vrfga0UlRPu5dWNUGThE60IgweCs2qSE+maVBFcDsUiC5hFqwfhGGJj2HxgFXTtywFU+
         v0qzZXrfhg0GIslLkjKdg/s4xRQPy6TUsFesDDAuuYy6BWDqyGlb5bpXAuC2PXlLg+/1
         zOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hanYBf6ntGMX8alKY8GpfKVwvT1p2AjZMh65KWY/3eM=;
        b=rXNW+TW81A02DA41JCRB82tZMd3ifAYpiIST8+S59X8VaoaTbpCYFUlzxZPy3KPCZz
         K/i91xJjtvzkSfalGTWyWzx7a+taEMLEtZ+OePE6b5wd7YgrRnJSGOjCPtU9gBnPZL8l
         Gqn5nTJi0Q7CSRC2WWPjAym+eByHna4hjZy0ZnK0vF1ceb5Dq6MziijqqWl/lpEoSbs/
         YDaaMbxLaOeiAg0WpKEe4LaspOPYDyw8lEsgMgcsQ38gwuLldvxf/4PHn9dj4NYcaTx+
         Z8p2k58Unf93Oei/7UQis/ovblhC4ZxtZt+lA0MUwweTLw9nP1LXIrr9efYKx7sufhmZ
         RPhQ==
X-Gm-Message-State: AOAM532DhACZcSwMr7GOm7ZN1rL9z6J+o/EAwloJbgVml2ptpgNU4rjn
        oyVAtZgWox7iEUbpGEPYO+oNYkAnjkPMeg==
X-Google-Smtp-Source: ABdhPJxuDEqT9bqL+5jF6yyusPb1+dKVn4p68yB4Srs57n6iZbvYUgqecRGiMeUkZStui9LstV4k6w==
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id n9-20020aa7c789000000b00413605d8d17mr29306819eds.100.1649002089553;
        Sun, 03 Apr 2022 09:08:09 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-030-091.094.222.pools.vodafone-ip.de. [94.222.30.91])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090674cc00b006df9afdda91sm3332053ejl.185.2022.04.03.09.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:08:09 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, yhs@fb.com,
        songliubraving@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH bpf-next 0/2] Priorities for bpf progs attached to the same tracepoint
Date:   Sun,  3 Apr 2022 18:07:16 +0200
Message-Id: <20220403160718.13730-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With growing number of various products and tools using BPF it could
easily happen that multiple BPF programs from different processes will
be attached to the same tracepoint. It seems that in such case there is
no way to specify a custom order in which those programs may want to be
executed -- it will depend on the order in which they were attached.

Consider an example when the BPF program A is attached to tracepoint T,
the BFP program B needs to be attached to the T as well and start
before/end after the A (e.g. to monitor the whole process of A +
tracepoint in some way).  If the program A could not be changed and is
attached before B, the order specified above will not be possible.

One way to address this in a limited, but less invasive way is to
utilize link options structure to pass the desired priority to
perf_event_set_bpf_prog, and add new bpf_prog into the bpf_prog_array
based on its value. This will allow to specify the priority value via
bpf_tracepoint_opts when attaching a new prog.

Does this make sense? There maybe a better way to achieve this, I would
be glad to hear any feedback on it.

Dmitrii Dolgov (2):
  bpf: tracing: Introduce prio field for bpf_prog
  libbpf: Allow setting bpf_prog priority

 drivers/media/rc/bpf-lirc.c    |  4 ++--
 include/linux/bpf.h            |  3 ++-
 include/linux/trace_events.h   |  7 ++++---
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/core.c              | 19 +++++++++++++++++--
 kernel/bpf/syscall.c           |  3 ++-
 kernel/events/core.c           |  8 ++++----
 kernel/trace/bpf_trace.c       |  8 +++++---
 tools/include/uapi/linux/bpf.h |  1 +
 tools/lib/bpf/bpf.c            |  1 +
 tools/lib/bpf/bpf.h            |  1 +
 tools/lib/bpf/libbpf.c         |  4 +++-
 tools/lib/bpf/libbpf.h         |  6 ++++--
 13 files changed, 47 insertions(+), 19 deletions(-)

-- 
2.32.0

