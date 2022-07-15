Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A39576381
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 16:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiGOOSy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 10:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGOOSx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 10:18:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535A52251B
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 07:18:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so3110863wmj.1
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5aCoev41wv5bdFBznp8UfPLpySgXLd9jFM8dilXTwx0=;
        b=hzB+NaviM/IfrtKHVyTqWEvZ6NPAebcnbDM8DWP61/XPgUeclPInQId3l+L67QyTIq
         N+jksbudeN0TGJkxl+ZH7HsLh28CFd3B6xl01/fcmZMnCOESwEnYDNQhhevEVehn79NR
         URv/Hh9nY+C0ZKwMvi8BSNGxEYdnrCRtDXS+LW4BKssp9nna2jvn9szJZgOEfMuiIHsm
         GeAFmZ4EWUMWolIsD0X9MB37KoUIc6KlNT9XKTi7k0uC2sr7Bz/StwsAfzdbMeE5B2xK
         VBb38q1KSTrj3GZHbp401eI+GRJqWZpM4kVjRBTibm6sm8o+3XXIMS5APWz0WphjC+Xa
         uhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5aCoev41wv5bdFBznp8UfPLpySgXLd9jFM8dilXTwx0=;
        b=dbVrhq8q0JC1B2/g9tISYu/oQeBCLP+uf+q7K6PVAdVvjGtmXjZm+jrLHeH7P859cm
         XweiI0WcF2j5usx2NlC4mY6OHDJrdjKxWH3iH5ey2bwydOqhm8R+d4NptNVctxa09jX4
         k+P3T2RneemlmSfydZeHI/6MKENmT8EVxE4GDdQPIiH7x5P7H87GQpWzOn9/M3Ks4ELa
         Sf5jlcNSQL/rW36TtuACy+k9Wp8XLN3Y496shT2ABs5Cfdw7RnxjqpV3wvuEDTtEwwlQ
         +puW+CVDpsdUsdud85TEE3Wcv1ywWmtgfhtJal+xvoP4jGBRLGtxYgpDJgP6sLglV+1C
         7HRA==
X-Gm-Message-State: AJIora9XHhqg0/gEIMg9PophJ07EdENtAmCgAJdbaoKwGLPhjmRDyURa
        UEldB049ivTB9PKDjpf33kLS7ZGUasc=
X-Google-Smtp-Source: AGRyM1v4nY//RX0l6XqEGPmdksUk/JjxZZB4cHcyzFCKvtMl0am+L1wViWG+GXEPu+WGdAmDNhRDLg==
X-Received: by 2002:a05:600c:5108:b0:3a1:a0c2:ba47 with SMTP id o8-20020a05600c510800b003a1a0c2ba47mr15410532wms.68.1657894729649;
        Fri, 15 Jul 2022 07:18:49 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c2e4700b003a03be171b1sm5006315wmf.43.2022.07.15.07.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 07:18:48 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH bpf-next v3 0/1] libbpf: perfbuf expose ring buffer
Date:   Fri, 15 Jul 2022 17:18:34 +0300
Message-Id: <20220715141835.93513-1-arilou@gmail.com>
X-Mailer: git-send-email 2.36.1
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

From: Jon Doron <jond@wiz.io>

Add support for writing a custom event reader, by exposing the ring
buffer.

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
  libbpf: perfbuf: Add API to get the ring buffer

 tools/lib/bpf/libbpf.c   | 26 ++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 29 insertions(+)

-- 
2.36.1

