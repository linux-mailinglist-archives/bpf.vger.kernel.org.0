Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E62456B280
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 08:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiGHGEd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 02:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbiGHGEd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 02:04:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6EECF5
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 23:04:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s1so29102964wra.9
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 23:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSo5faC3cCkKcmP7jRnqu+siIZ2mETbAgnbYK+zPSes=;
        b=d9dqMmietztIQ6WK9U5ngnT/S5AhH6Gfw395PK2YDPbiZty+p/PsJS1eJuwxUT/N13
         xRWI41obqxYlA1PkeOVz+NIm6NNMYf03OiwcFRbp0Td3NoPQFUBOyDqIb8li3KZ1T2ON
         8gJ7YMnFrsYAJ33CeXwZoz2hxI3Z7xKOv9oNN/yllu2PFMQP54rwOuvRknFSwuV6rMWG
         //bBUbGe5qEg12A5SsZXtxuN1sSFkqe823RtkCFlsJhGal6ebhPAp3fz4UA2hTS1gsdZ
         5Fb7MYk7jhfPVXYSkG5BW/vCorxtIqPyGKuP+SHE2c3RJ5wBq5u6OM/OpV8tE79BeMb5
         NPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSo5faC3cCkKcmP7jRnqu+siIZ2mETbAgnbYK+zPSes=;
        b=SqVHdnHGn1kyF5JYSElRy5iETHe1a8SZYYbv59n/Nmtd3AQ/uBHXYwMDcvIzrbj2kh
         SShRT8jUyXQPaQBpZ5oFieB4gbgvz2fGQ6zFyWPIFDqxUvgjUMssEq7LlVc5BUAcWuux
         +3RTAMcpf+3epfipJMmrbPur3pcLRbGrMsJf889W6IZMgjhCQt7WMUOkZXxRgSLTMDhR
         UI+yTuuxkzRnM8pqIE5UvMjSF4hNS2KOUsF2M3Y6sHP7VuFn+/Tyi5TjiZbvDsoYM5B5
         HEgjnOp2/3bSw04fueKx3MWqnUO8RJ3YEHgNfgFuorcu8TLsSD0+998Ni9aGE5luw90Q
         sx+A==
X-Gm-Message-State: AJIora9z1VON134K6arj3eMhxQ9Kmsus9Hyqmq6vvO0FViwPTeWDTG+W
        muojiN3jHaHopkFDNHIW2em0XR2Xx+o=
X-Google-Smtp-Source: AGRyM1uRziGYBnjpUv/uDTj6evuQpKyDXjiabZXMp4OYeQT3z5eOi5nNMjKDVsBa71Pa69FdfpfIag==
X-Received: by 2002:a05:6000:15c1:b0:21b:ad5d:64dd with SMTP id y1-20020a05600015c100b0021bad5d64ddmr1555585wry.642.1657260270422;
        Thu, 07 Jul 2022 23:04:30 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id r41-20020a05600c322900b003a032c88877sm1004858wmp.15.2022.07.07.23.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 23:04:29 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH bpf-next v2 0/1] libbpf: perfbuf custom event reader
Date:   Fri,  8 Jul 2022 09:04:15 +0300
Message-Id: <20220708060416.1788789-1-arilou@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jon Doron <jond@wiz.io>

Add support for writing a custom event reader, by exposing the ring
buffer state, and allowing to set it's tail.

Few simple examples where this type of needed:
1. perf_event_read_simple is allocating using malloc, perhaps you want
   to handle the wrap-around in some other way.
2. Since perf buf is per-cpu then the order of the events is not
   guarnteed, for example:
   Given 3 events where each event has a timestamp t0 < t1 < t2,
   and the events are spread on more than 1 CPU, then we can end
   up with the following state in the ring buf:
   CPU[0] => [t0, t2]
   CPU[1] => [t1]
   When you consume the events from CPU[0], you could know there is
   a t1 missing, (assuming there are no drops, and your event data
   contains a sequential index).
   So now one can simply do the following, for CPU[0], you can store
   the address of t0 and t2 in an array (without moving the tail, so
   there data is not perished) then move on the CPU[1] and set the
   address of t1 in the same array.
   So you end up with something like:
   void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
   and move the tails as you process in order.
3. Assuming there are multiple CPUs and we want to start draining the
   messages from them, then we can "pick" with which one to start with
   according to the remaining free space in the ring buffer.

Jon Doron (1):
  libbpf: perfbuf: allow raw access to buffers

 tools/lib/bpf/libbpf.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 25 +++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 67 insertions(+)

-- 
2.36.1

