Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F076782B0
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 18:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjAWRPX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 12:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjAWRPW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 12:15:22 -0500
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679D62B61D;
        Mon, 23 Jan 2023 09:15:14 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5018be4ae8eso118714857b3.4;
        Mon, 23 Jan 2023 09:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djMttWP8H+SD4ars1bQbsyOamvB+lZJqMHXQTcE3dBE=;
        b=jmBygRUcVExwdypVh2uFa3rX4HMqvXCf+zSGnQZD60AJt5WN7MqsWK8KPnLU9EbU+e
         xlwFblip9Qopg3HLGYqqfMkbeDhUdcp6nrt5W0LlP+2HdTOKhoUDNcunmQn+VKlx0Nnf
         6EAibvbmSugWuf6xb3ES1hYj/0mlfbmJAKbSeuZUubw6ARLGhYasN/sxcM8CtlXDzWl7
         GfA522uamaXo5XOgzFIfnXKynoFy1guTbx+YuycBplQRJhxRBiMAc3nTVu0GtIwggoAK
         iPR1WZQaxD1WCV48EFgXI3xZs+j6HUjRMKBv2fcnLw9VJKfCq7YsNMY9TFFh5O1l7USn
         0zKA==
X-Gm-Message-State: AFqh2kqgzjRhTSnWWwpgSRd0OSJrXhM3OY91oxYqn9052xTBHvVGQTBk
        T/ATvPZ0HgbK66lyTr5dpowrtz0DmEBfH6cZ
X-Google-Smtp-Source: AMrXdXvco7dMfK2HQNrs2AiDwDTvLP2EKFXhgiX3FjsUKnR5bVqTjj2Rtc7zLkx7mx3BnHyehEdNzA==
X-Received: by 2002:a81:a54c:0:b0:4e1:54e4:532d with SMTP id v12-20020a81a54c000000b004e154e4532dmr16974163ywg.27.1674494113250;
        Mon, 23 Jan 2023 09:15:13 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id ay30-20020a05620a179e00b007090cad77c1sm7791399qkb.3.2023.01.23.09.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:15:12 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: [PATCH bpf-next v2 0/3] Add BPF_KFUNC macro for kfunc definitions
Date:   Mon, 23 Jan 2023 11:15:03 -0600
Message-Id: <20230123171506.71995-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v2 of the patchset [0]

[0]: https://lore.kernel.org/bpf/Y7kCsjBZ%2FFrsWW%2Fe@maniforge.lan/T/

Changelog:
----------
v1 -> v2:
- Wrap entire function signature in BPF_KFUNC macro instead of using
  __bpf_kfunc tag (Kumar)
- Update all kfunc definitions to use this macro.
- Update kfuncs.rst documentation to describe and illustrate the macro.
- Also clean up a few small parts of kfuncs.rst, e.g. some grammar, and
  in general making it a bit tighter.

David Vernet (3):
  bpf: Add BPF_KFUNC macro for defining kfuncs
  bpf: Document usage of the new BPF_KFUNC macro
  bpf: Use BPF_KFUNC macro at all kfunc definitions

 Documentation/bpf/kfuncs.rst                  | 93 ++++++++++---------
 include/linux/btf.h                           | 10 ++
 kernel/bpf/helpers.c                          | 44 ++++-----
 kernel/cgroup/rstat.c                         |  4 +-
 kernel/kexec_core.c                           |  3 +-
 kernel/trace/bpf_trace.c                      | 18 ++--
 net/bpf/test_run.c                            | 64 ++++++-------
 net/ipv4/tcp_bbr.c                            | 16 ++--
 net/ipv4/tcp_cong.c                           | 10 +-
 net/ipv4/tcp_cubic.c                          | 12 +--
 net/ipv4/tcp_dctcp.c                          | 12 +--
 net/netfilter/nf_conntrack_bpf.c              | 34 +++----
 net/netfilter/nf_nat_bpf.c                    | 12 +--
 net/xfrm/xfrm_interface_bpf.c                 | 14 +--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  3 +-
 15 files changed, 165 insertions(+), 184 deletions(-)

-- 
2.39.0

