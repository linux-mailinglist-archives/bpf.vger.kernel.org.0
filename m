Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122D05FAE33
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 10:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJKINY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 04:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJKINO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 04:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A5089CDC
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 01:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665475991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wd2uHcBEj1+0Ib8C2XV8f8kpv5GXpAIa7u+xFyKcdgM=;
        b=d2U6L/lECTzgk7u4Dh9sg8sy8jOgGq3xR26I53fYdisQCS9BnHhSKDbKTOoeX/U5XddP9p
        F8uOKLx0kOvbL7S6qmBjOb2YJZLfrBXXcOr6oDFtakU48rShLGWzjHWW4xWIwGn0/odJLM
        7tLmsQxUTVLLWyfcg4w1rUd8wTrIw9I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-K0Oc9en3P1S856EpjOkOvQ-1; Tue, 11 Oct 2022 04:13:09 -0400
X-MC-Unique: K0Oc9en3P1S856EpjOkOvQ-1
Received: by mail-qv1-f71.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso7500985qvr.0
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 01:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wd2uHcBEj1+0Ib8C2XV8f8kpv5GXpAIa7u+xFyKcdgM=;
        b=5HfIoA2WB8dZFbI0u6q6wQaSQYPLhDkPPH7Zi1lFqCVQ3tkP6IkUNFOQOIRQAGDhL3
         u1+Q0Ijaf0CbrzPqtFwHAm7KuhQ+Pw/LZSmPZBROKVzzi30qd9Bobl+Z7sBEVrlVpMVV
         w34GEbPmH3YYGf2KHA3owB5+egyyp22iy7LPgO79h4nYb5Mljx6e3MUV8ZkSsBlGffjN
         QbWK4ObMimhifWz23tevKZQHymXHv/f6PwSwWb327NcKq+KRCUnm3ofbw/tr6DDneMkX
         GxB1dp84ny8zhQbA/faJt9IchN6HdNWsvKHpZgxNzVA/taVLH6vikHKrFfTYo9itFuab
         z1fg==
X-Gm-Message-State: ACrzQf3V+UBkIv3mJ6G4G2zAancIprIeTpcQuuOjaT1Z0l8IHCIgkAHz
        RzKnQPoDkFO/iA9lb+ZItSvANpKcf6ChenfQcq5eLohygkV9lvNjniS4Ve7pZjooC/b+aEDHEKu
        RSiXeFjFJEK5nFAqzRVNUDVYieiUIF+QGXG7hbJPhrnHmVJstJjwOamigvT+rLS8=
X-Received: by 2002:ad4:5be7:0:b0:4b3:fe6c:904b with SMTP id k7-20020ad45be7000000b004b3fe6c904bmr7864987qvc.42.1665475989055;
        Tue, 11 Oct 2022 01:13:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Z50e2zMuPNcTPzKxsIS/IJz6E3Nr+YvNDrK/sslRe4t7ajiwFhtGqot/3OLS2Z/iHAsBzzw==
X-Received: by 2002:ad4:5be7:0:b0:4b3:fe6c:904b with SMTP id k7-20020ad45be7000000b004b3fe6c904bmr7864978qvc.42.1665475988879;
        Tue, 11 Oct 2022 01:13:08 -0700 (PDT)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006bb82221013sm12383261qkl.0.2022.10.11.01.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 01:13:08 -0700 (PDT)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH v1 0/1] doc: BPF_MAP_TYPE_DEVMAP, BPF_MAP_TYPE_DEVMAP_HASH
Date:   Tue, 11 Oct 2022 05:08:45 -0400
Message-Id: <20221011090846.752622-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maryam Tahhan <mtahhan@redhat.com>

Add documentation for BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_DEVMAP_HASH
including kernel version introduced, usage and examples.

Maryam Tahhan (1):
  doc: BPF_MAP_TYPE_DEVMAP, BPF_MAP_TYPE_DEVMAP_HASH

 Documentation/bpf/map_devmap.rst | 231 +++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)
 create mode 100644 Documentation/bpf/map_devmap.rst

-- 
2.35.3

