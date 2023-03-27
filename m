Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9906CA219
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 13:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjC0LHJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 07:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjC0LHJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 07:07:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5E13C3F
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 04:07:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h17so8303777wrt.8
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679915220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNsP+L/+XR0RhI6lVzczdxo5OkXdY2EmjBH8/8NxDV4=;
        b=gML9eSDLALzd0cfzhFP//ToAvVGB2XEfgn2QTdHpRSFFhRVsdTzeQ+g8qnvM4VsJf0
         DlntUmy/F8wB4LsEwaVEahCB6Qfs4VS0zKSDjlCzf/qYAm03UuwJqpLFNAUNhSbU4K8+
         02eTuSEJWxyKmrGZ784mPewbQ99ec7tB6ZT6zpC2M0cX1tI6ZFMNdNEUH1K0f9Ea5ztE
         uG0Bi7CRz+ABofEhePguAYeHnC3O0W+qIV5spWAX1wmjCtismJVJiKTitKpNH+ieiPAF
         Lvntmurz+e1yWHaliNfzuNcdH2qd9RZc18NhEzQJ6QFJvN2oxcSxmBJgjdkeRsQ1ZdFI
         LKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679915220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNsP+L/+XR0RhI6lVzczdxo5OkXdY2EmjBH8/8NxDV4=;
        b=WjUPdBeiR4jGkT7u3k0ntxFT4lPx+9Mx01yapdVZKpMPO1nmlw9ji8qnJlERO3dPSA
         jkkUSXiNSu3YlQMhMckjddkzNkXi2OluqIS6iM3gNp//oDfbHGQ1UAvXm7K/L0o8l+2w
         lQHa4pbF4TkSjr2Quvn0iq4IzYitVcuXLgf7AlKWZmk0SizJzZ/h0F8MPo4g1Um/tXt7
         OY12LdQOCoUz+NBPOaZ6nnkmXouAeDJuiYFJd0iJ4fd8DoJXoN84ykWoqny0Do2sckH1
         StyNS9/vwYsp+2gRnxZKFqqH8is2nASWylV0Y7bN0Y/y/KgywieqvrxmAKfc6RTGRNVO
         mhaw==
X-Gm-Message-State: AAQBX9e0o02hUasIglU+3dmlGpw8XS2WvdlJAjshp2OyJUgmyMqzTvrr
        zGDpcPj8kEL1jKu7usFjI74Gsg==
X-Google-Smtp-Source: AKy350b6UBQBCZ2OAP6lhcKyEZ2FDlgQnX5562j6hEwrCw+a77jcVSyh63lTrc+jGU+k4l8T89qXgg==
X-Received: by 2002:a5d:51c8:0:b0:2d4:53d7:ea7f with SMTP id n8-20020a5d51c8000000b002d453d7ea7fmr9092353wrv.3.1679915219987;
        Mon, 27 Mar 2023 04:06:59 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:61cd:634a:c75b:ba10])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d6e8a000000b002d1daafea30sm24772958wrz.34.2023.03.27.04.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:06:59 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 0/5] bpftool: Add inline annotations when dumping program CFGs
Date:   Mon, 27 Mar 2023 12:06:50 +0100
Message-Id: <20230327110655.58363-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set contains some improvements for bpftool's "visual" program dump
option, which produces the control flow graph in a DOT format. The main
objective is to add support for inline annotations on such graphs, so that
we can have the C source code for the program showing up alongside the
instructions, when available. The last commits also make it possible to
display the line numbers or the bare opcodes in the graph, as supported by
regular program dumps.

v2: Replace fputc(..., stdout) with putchar(...) in dotlabel_puts().

Quentin Monnet (5):
  bpftool: Fix documentation about line info display for prog dumps
  bpftool: Fix bug for long instructions in program CFG dumps
  bpftool: Support inline annotations when dumping the CFG of a program
  bpftool: Support "opcodes", "linum", "visual" simultaneously
  bpftool: Support printing opcodes and source file references in CFG

 .../bpftool/Documentation/bpftool-prog.rst    | 18 ++---
 tools/bpf/bpftool/bash-completion/bpftool     | 18 +++--
 tools/bpf/bpftool/btf_dumper.c                | 49 ++++++++++++
 tools/bpf/bpftool/cfg.c                       | 29 +++----
 tools/bpf/bpftool/cfg.h                       |  5 +-
 tools/bpf/bpftool/main.h                      |  2 +
 tools/bpf/bpftool/prog.c                      | 78 ++++++++++---------
 tools/bpf/bpftool/xlated_dumper.c             | 52 ++++++++++++-
 tools/bpf/bpftool/xlated_dumper.h             |  3 +-
 9 files changed, 182 insertions(+), 72 deletions(-)

-- 
2.34.1

