Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4C06075FB
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 13:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJULUx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 07:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJULUw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 07:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB15E3DF38
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 04:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666351250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ReqbEj8BqOln93pvlV1AGFFDODx76Z1OSm0u26Ew1ZQ=;
        b=Fs+M1IfkX8ArVNFZIBXynk6MfoNvLpj8g48Xd8vtgYXsDl1ddE1Y52KBz1SJKd64WZ327V
        uh/krXpoMv99I7VFXGeB1jcVorOF6DHeaHVwjfMPPOUemBbfNasxYd0kkTG1Uvk4nE2m8X
        mbnKLaB2NJA5E5PFe5XLIP3qArNVd/E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-McTtlbZfNb20owuSD_wyBQ-1; Fri, 21 Oct 2022 07:20:49 -0400
X-MC-Unique: McTtlbZfNb20owuSD_wyBQ-1
Received: by mail-qk1-f198.google.com with SMTP id i11-20020a05620a404b00b006eeb0791c1aso3281049qko.10
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 04:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReqbEj8BqOln93pvlV1AGFFDODx76Z1OSm0u26Ew1ZQ=;
        b=sp0ZAsF3NVnZyaJIpehWHWpAqjwwY2eduDi3pHVmhkvxwGJzAPtjcSLbZcrwE7a0vX
         hwzq5dWaoh44mDVlO9rCUzRjNfhmKix9L6/AIvwYpHssu4W2S965mbqBrcg3wkbHTDGj
         FAnlxXnZdAVmcKvuw5LDQIorGboYI1IXXhVrbMpsoK4r8CLJ1ZlNgJaANamtZtBUCA3g
         1LUeWiYkuzpYwbfObdUQLvp3K7n79Zg+ThiXvJ5DlPSAe1m1++xHt3gDuaixjPZleEya
         F3b1tfS6BKJG0iEMn3KHztYTApcn17UxypyjuWpxTpH0iGypmDCEBTjrxvwfxFruLxmJ
         1BOA==
X-Gm-Message-State: ACrzQf34E9jZl4CGS9PWcEB2KrWWzzWiKNKxmI+EgbfYLNhbrQEUAppk
        d0WT9ekYLOTOpo2Gel619YbDIGD8mibVeFv3OBsdSPT2bWXhOep87ATuvd5CvxulhHAdqp/xOwr
        z5kSA2c7LxPb+BtMyJBgbzLoV8S+P8BLybnJG8cZrol/kyzY21Ar4jBEW2rMYZG4=
X-Received: by 2002:a05:620a:16d5:b0:6ec:52ab:e8bd with SMTP id a21-20020a05620a16d500b006ec52abe8bdmr12849031qkn.424.1666351248779;
        Fri, 21 Oct 2022 04:20:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6P8dlyWGTrZobZd3w5ieHLYuNRCnqoDjXom734aeT3HyS1kvD7hNbry43KHSZ1JgSdyY/NOw==
X-Received: by 2002:a05:620a:16d5:b0:6ec:52ab:e8bd with SMTP id a21-20020a05620a16d500b006ec52abe8bdmr12849007qkn.424.1666351248493;
        Fri, 21 Oct 2022 04:20:48 -0700 (PDT)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id c25-20020ac81119000000b003996aa171b9sm7766604qtj.97.2022.10.21.04.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 04:20:47 -0700 (PDT)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v3 0/1] doc: DEVMAPs and XDP_REDIRECT 
Date:   Fri, 21 Oct 2022 08:15:56 -0400
Message-Id: <20221021121557.3486894-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maryam Tahhan <mtahhan@redhat.com>

Add documentation for BPF_MAP_TYPE_DEVMAP and
BPF_MAP_TYPE_DEVMAP_HASH including kernel version
introduced, usage and examples.

Add documentation that describes XDP_REDIRECT. 

v2->v3:
- Update examples in DEVMAPs documentation for broadcast scenario.
- Update key reference for BPF_MAP_TYPE_DEVMAP_HASH (doesn't have to be
  ifindex).
- Remove information re xdp_redirect internals.

v1->v2:
- Separate xdp_redirect documentation to its own file.
- Clean up and simplify examples and usage function descriptions.

Maryam Tahhan (1):
  doc: DEVMAPs and XDP_REDIRECT

 Documentation/bpf/index.rst      |   1 +
 Documentation/bpf/map_devmap.rst | 208 +++++++++++++++++++++++++++++++
 Documentation/bpf/redirect.rst   |  41 ++++++
 3 files changed, 250 insertions(+)
 create mode 100644 Documentation/bpf/map_devmap.rst
 create mode 100644 Documentation/bpf/redirect.rst

-- 
2.35.3

