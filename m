Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA51569B55
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 09:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiGGHOB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 03:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiGGHOA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 03:14:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8540A2FFC3
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 00:13:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id cl1so24993181wrb.4
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 00:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HLxLWxhNiTdxzSgDapF/kBRRPUSBbQrFO/DxexhjuJo=;
        b=DSMnQB2+Z9eMkvJmyJJs19whP0ALJ6PVtnlvOWe679s6ROsk1DbL1hTbYH3f6yUnhQ
         butAW3mTmzD1VoJtTb3UXUTwAaSwLnLMaA34ZNDNL3p8hS0+Nls10Iz5jDbRmdtlVh3v
         pcs+RyCzSM1zkti90iSqbVyGoQxNtSLX6YIkwUbc5Qp9w3rui01z5k0mC7BGdFUY1y0Q
         oOxjxKf1dPraFYG2fLPfDEgQHlSBTTMZeAJrsVFVh+vpGMi42myWRsjKWpvS6I2KLolB
         o/B50KUdClxeP5s0q7wdQ5ZOcpzeLak5cSpfcJwri/fM2QpHfDxveglg3n80eBsalSRJ
         Si8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HLxLWxhNiTdxzSgDapF/kBRRPUSBbQrFO/DxexhjuJo=;
        b=u3TRXv4B8cRIY4GX/SQ1Ts6DstgpHcG4WPJ7EsA9NgFu79BH0igGqbkDORwZ4kiMTU
         NwdxcnJMIKNYgLJFr2QNBNErbluX42cPbZieyZRLsQTzKeoKQtilqdWTHCyKjgf6ARBE
         TUcaQnhsDwa0tTszncW+kMgFm8rkOE06AV3oyvdIwJUUqUb8N80sMYYY08gpuGrBbccO
         JillILaJhw1ms6DHisPC+VdTEqok50boPTO22xm8ob8NNWnw1BopkvMm57vVLESbojx4
         sudybwMoPJ3Si0g/RHy/v5+4wgLmgiVsYyjRWfQdwvpuRKAtGpRas9qYZkCwK7c0TY8A
         Ruyg==
X-Gm-Message-State: AJIora/1qBAuGPV4nFvsfVga3jQABhAUmhhSsa2dq8n9TGaRrGYwEvZP
        T1UOAfgw/TjrB4C0Y/OJPrh27nLXyI0=
X-Google-Smtp-Source: AGRyM1sOjI4XDFh5ToO6WPpkDuEcz/65/30gNcu5jsWiW9AZnqShh4rTjKLWj+ncKhQT6cqWWHNVAw==
X-Received: by 2002:a5d:5505:0:b0:21d:6549:70bd with SMTP id b5-20020a5d5505000000b0021d654970bdmr23299275wrv.612.1657178037729;
        Thu, 07 Jul 2022 00:13:57 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id g14-20020a7bc4ce000000b003a2cf1ba9e2sm855604wmk.6.2022.07.07.00.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:13:57 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH v1 0/1] libbpf: perfbuf custom event reader
Date:   Thu,  7 Jul 2022 10:13:38 +0300
Message-Id: <20220707071339.1486742-1-arilou@gmail.com>
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

Jon Doron (1):
  libbpf: perfbuf: allow raw access to buffers

 tools/lib/bpf/libbpf.c | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h |  6 ++++++
 2 files changed, 46 insertions(+)

-- 
2.36.1

