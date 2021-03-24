Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97352346F6C
	for <lists+bpf@lfdr.de>; Wed, 24 Mar 2021 03:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhCXCXV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 22:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbhCXCXH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 22:23:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94076C061765
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 19:23:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x16so22822089wrn.4
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 19:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GlAt918dYBhXNqQsdpfiZm5SFHF6YcLaM76BqophvBo=;
        b=iBlOPlmFjwUJ45qvXmVJI46UJhVeQhGq7uuGobBbOYdIuJAbTTi9271QoMSLRxrLD2
         NFqiFjo8Sr3N1JSTHv8erxgWrmHYnXR7CRrRVCjj2yX5KTlNiRK3JINlP5xKvevbUKt4
         Jq/aAma1rsYUvclWJKkunDsqbhs51zSdyLPCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GlAt918dYBhXNqQsdpfiZm5SFHF6YcLaM76BqophvBo=;
        b=cI1qJRvcjnqa5PeD9bkZ9do6kmxUiXOqXR6Gkea1LlhlVlHZBA7Ynm/wmXhamR8rn3
         X7STogwgKrWDq8ikGvXRSAY5DklBT1JHX5r13D71oE6Fl+40qoAyUDCmxlDjxhciSfKa
         tWzpCoevgqsIamYDOM34+DfHM5a3ZYKdpq74D0KONqonH2dYIUkXZuJW7Sp+4XcM/Noo
         i/wZICw8AOO0yEWWd53LOEv62D7V1axb/lHJcd7Xv4Nd7GZSQeDGsTBK1QQnRcs21pw4
         blfRJqFa4Q8JimOSldX6zBZA9VyJbaA8qBBwGE8a1yPhWNI2HFCSPOkmzzUT0xLIq7LV
         wxTQ==
X-Gm-Message-State: AOAM5310Q1MJO1YwxOqP+6T3vX6qZFcMWCa3tNdgt6/hBS7imLaww41I
        0FwVcKQoYxVxdMaZadaujPYyQXYoZN2YTw==
X-Google-Smtp-Source: ABdhPJzpCwTlEMnTmUyyLuZknrjY58xEMKkuuwTXHw1gcdBj7Q91awx7eR1x0Uqlc8H9BUObjrS3Dg==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr871617wrd.132.1616552585041;
        Tue, 23 Mar 2021 19:23:05 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:ccba:9601:929c:dbcb])
        by smtp.gmail.com with ESMTPSA id n9sm74219wrx.46.2021.03.23.19.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:23:04 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2 0/6] Add a snprintf eBPF helper
Date:   Wed, 24 Mar 2021 03:22:05 +0100
Message-Id: <20210324022211.1718762-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We have a usecase where we want to audit symbol names (if available) in
callback registration hooks. (ex: fentry/nf_register_net_hook)

A few months back, I proposed a bpf_kallsyms_lookup series but it was
decided in the reviews that a more generic helper, bpf_snprintf, would
be more useful.

This series implements the helper according to the feedback received in
https://lore.kernel.org/bpf/20201126165748.1748417-1-revest@google.com/T/#u

- A new arg type guarantees the NULL-termination of string arguments and
  lets us pass format strings in only one arg
- A new helper is implemented using that guarantee. Because the format
  string is known at verification time, the format string validation is
  done by the verifier
- To implement a series of tests for bpf_snprintf, the logic for
  marshalling variadic args in a fixed-size array is reworked as per:
https://lore.kernel.org/bpf/20210310015455.1095207-1-revest@chromium.org/T/#u

---
Changes in v2:
- Extracted the format validation/argument sanitization in a generic way
  for all printf-like helpers.
- bpf_snprintf's str_size can now be 0
- bpf_snprintf is now exposed to all BPF program types
- We now preempt_disable when using a per-cpu temporary buffer
- Addressed a few cosmetic changes

Florent Revest (6):
  bpf: Factorize bpf_trace_printk and bpf_seq_printf
  bpf: Add a ARG_PTR_TO_CONST_STR argument type
  bpf: Add a bpf_snprintf helper
  libbpf: Initialize the bpf_seq_printf parameters array field by field
  libbpf: Introduce a BPF_SNPRINTF helper macro
  selftests/bpf: Add a series of tests for bpf_snprintf

 include/linux/bpf.h                           |   7 +
 include/uapi/linux/bpf.h                      |  28 +
 kernel/bpf/helpers.c                          |   2 +
 kernel/bpf/verifier.c                         |  79 +++
 kernel/trace/bpf_trace.c                      | 581 +++++++++---------
 tools/include/uapi/linux/bpf.h                |  28 +
 tools/lib/bpf/bpf_tracing.h                   |  44 +-
 .../selftests/bpf/prog_tests/snprintf.c       |  65 ++
 .../selftests/bpf/progs/test_snprintf.c       |  59 ++
 9 files changed, 604 insertions(+), 289 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c

-- 
2.31.0.291.g576ba9dcdaf-goog

