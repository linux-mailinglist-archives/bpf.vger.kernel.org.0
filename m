Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A545FCED7
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 01:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJLXU2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 19:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJLXU1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 19:20:27 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E5911874D;
        Wed, 12 Oct 2022 16:20:26 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id jr1so93511qtb.0;
        Wed, 12 Oct 2022 16:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umsGjcBN6QksXSLCVDPXpbAiW/8nZ3+jo6ikYymXFQ0=;
        b=flv1N2uCk3bB9Id9Bj+ec9Eu4QmlQSp+BFD0FechfDt/xL+mPXF6VpLaFCAtbXq3kW
         mzI+9LvNVL3xTlfgKmWSHlLsgToDEuZXqtJ+B0i81qMEn05T0znEHXsZXgUpJ2chuCQo
         MfuJJcG0IPChWWWoeAUH4Iw51hO6H+EPaD1BfG7Ck2kzBoxsE75TZ/9bhJYrGPzMht3N
         9DrxDbsun7fDOmzm0tKPEo9VmkB/Sgzpx3zcRCdZtOETIrCTRo2VqHP2qp2yJj/4cfyT
         xH6MT0HRGXQa7zxApSZO1Kc+luovcI1f7g4+tRPJ40GTh2YFgZNXJkFpp0itdXJ7wwqf
         gKHA==
X-Gm-Message-State: ACrzQf1lHzvaPOS7dvqQ4zpHCaT5gQG1nxSFnfyPY+z21sro+Rs1Nc83
        4fmrVkppIfddXR+IITfhryNnVLURxBRczw==
X-Google-Smtp-Source: AMsMyM50/R9kYCDg+oGdSYSJ1BWx/mQCNvph0L0wN0j2S/CTOjEn0MNJi4KLpCn5WmkHRoZpwMkqpQ==
X-Received: by 2002:a05:622a:40f:b0:394:57eb:ced0 with SMTP id n15-20020a05622a040f00b0039457ebced0mr25467529qtx.225.1665616825518;
        Wed, 12 Oct 2022 16:20:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1a0b])
        by smtp.gmail.com with ESMTPSA id br14-20020a05620a460e00b006bbb07ebd83sm6347520qkb.108.2022.10.12.16.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 16:20:25 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, martin.lau@linux.dev,
        daniel@iogearbox.net, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/2] Allow bpf_user_ringbuf_drain() callbacks to return 1
Date:   Wed, 12 Oct 2022 18:20:13 -0500
Message-Id: <20221012232015.1510043-1-void@manifault.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_user_ringbuf_drain() helper function allows a BPF program to
specify a callback that is invoked when draining entries from a
BPF_MAP_TYPE_USER_RINGBUF ring buffer map. The API is meant to allow the
callback to return 0 if it wants to continue draining samples, and 1 if
it's done draining. Unfortunately, bpf_user_ringbuf_drain() landed shortly
after commit 1bfe26fb0827 ("bpf: Add verifier support for custom
callback return range"), which changed the default behavior of callbacks
to only support returning 0, and the corresponding necessary change to
bpf_user_ringbuf_drain() callbacks was missed.

This patch set fixes this oversight, and updates the user_ringbuf
selftests to return 1 in a callback to catch future instances of
regression.

This patch set should be merged to the bpf tree.

David Vernet (2):
  bpf: Allow bpf_user_ringbuf_drain() callbacks to return 1
  selftests/bpf: Make bpf_user_ringbuf_drain() selftest callback return
    1

 kernel/bpf/verifier.c                                    | 1 +
 tools/testing/selftests/bpf/progs/user_ringbuf_success.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.38.0

