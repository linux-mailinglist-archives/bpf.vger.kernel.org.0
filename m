Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F461F815
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 16:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiKGP6t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 10:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKGP6s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 10:58:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02111A3BA
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 07:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667836665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BTJbY9Wr/+q8C2Vju1/W3nu3nFbvK1UE5CikMYHFAaE=;
        b=LrKZ3uXZ1B3J4hQ22KYdTGwHuS+K5Mwr7xcRtWql0twIoOgq1BUfiB7nRmRTFEi29QnyCY
        9tjhRqXKE74wSID8Yidu0GSvawj3jSpwuXs/bHnrDXBoazw+z8pEYMkZGVYnS+wFYRV07g
        8fC5MNiZPUk8Q1vwZz39yFjsfGAz9Ho=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-214-iW0Wor8_NTmIaA0-4swKdQ-1; Mon, 07 Nov 2022 10:57:44 -0500
X-MC-Unique: iW0Wor8_NTmIaA0-4swKdQ-1
Received: by mail-qt1-f200.google.com with SMTP id ew11-20020a05622a514b00b003a524196d31so8309588qtb.2
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 07:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTJbY9Wr/+q8C2Vju1/W3nu3nFbvK1UE5CikMYHFAaE=;
        b=MQgcdPxpBoaHCsMy1y+ydWzBOJcOkigPFyfc6gOABPwihSz2Jre/puhe/jR37OQone
         uVHz4w/3I9Mr0v6ET/MRWrunGb4sG+Xl0pnr794YV2ivpwtukRMr1Uj6Z5PmGPgaChm+
         ukpKQgBxpjLt1gLTczLhbUm3gyTuAgY5coAZNQlQz+7Gj3AsPW7z3/pHyCOqzFFEaRNK
         WiqbuxOwgt6wp8BBFiaaL8ZV66z6AHjMcyiz9i2O6EHwIxvrdNhBMjsbxVEeaymHnjUs
         1/WdlN62+zzPCtqsnTBP+2w29RUvEC87QiPI2CGv8IcEjHgMdMThmIbXAmxnQ12eZZwB
         8Y4w==
X-Gm-Message-State: ANoB5pnOBQfEe4ZLo81OrRHTaCUfkk+p/+7hswRrAvxSJakFPh9ri8MO
        eVCB54M5gXrgC473HnR9QcakrUqRCYGpjHZT0/tLYcTfWRXBC9f81oy36BSE/Mluc3AZrR3lxaZ
        h7IPGCAew1qIQxfuDdf+uB+H8DaeU8BWZO9CJw7dMlcbHetkbu0hihUlXL06Ohu4=
X-Received: by 2002:ae9:ea05:0:b0:6fa:f6fa:45ab with SMTP id f5-20020ae9ea05000000b006faf6fa45abmr1265724qkg.224.1667836663798;
        Mon, 07 Nov 2022 07:57:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6GAuKKTW/5tSVjEgebzrJCMTocCIgaWGBSGVpcjPLiW95dcK0iRUc3GTN2cHgzmbrlj2UIqA==
X-Received: by 2002:ae9:ea05:0:b0:6fa:f6fa:45ab with SMTP id f5-20020ae9ea05000000b006faf6fa45abmr1265703qkg.224.1667836663521;
        Mon, 07 Nov 2022 07:57:43 -0800 (PST)
Received: from nfvsdn-06.redhat.com (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id q16-20020ac84510000000b00398df095cf5sm6248889qtn.34.2022.11.07.07.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:57:43 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        Maryam Tahhan <mtahhan@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next v3 0/1] docs: BPF_MAP_TYPE_CPUMAP
Date:   Mon,  7 Nov 2022 11:52:06 -0500
Message-Id: <20221107165207.2682075-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maryam Tahhan <mtahhan@redhat.com>

Add documentation for BPF_MAP_TYPE_CPUMAP including
kernel version introduced, usage and examples.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>

v3:
- Updated introduction to use cpumap definition from kernel/bpf/cpumap.c
- Separated examples and APIs under Kernel and Userspace headings.
- Updated Userspace function signatures.
- Fixed typos.
- Migrated the use of u32 types to __u32.

v2:
- Removed TMI.
- Updated example to use a round robin scheme.

Maryam Tahhan (1):
  docs: BPF_MAP_TYPE_CPUMAP

 Documentation/bpf/map_cpumap.rst | 166 +++++++++++++++++++++++++++++++
 kernel/bpf/cpumap.c              |   9 +-
 2 files changed, 172 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/bpf/map_cpumap.rst

-- 
2.35.3

