Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1645F475E
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 18:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJDQTz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 12:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJDQTx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 12:19:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BF91115F;
        Tue,  4 Oct 2022 09:19:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y23-20020a1c4b17000000b003bd336914f9so1125055wma.4;
        Tue, 04 Oct 2022 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fATZ5d7C23ZPWTLH3+94U+unkH32QkI5WQTe9RMwP3g=;
        b=EYRTcmpGfata6QdKyGEUKjnDlJZ1otJT+55qi0J3d3K8HzamjYgsRY7frl3HYcLufn
         aucySkg/WKZoL1td2aRdcpic7lRJBzxRkUkodmhYzBpXFUCr71XaeMBqfWeYLuoep5G6
         Dtfkpy0m/Yws2pnb/KO26KuCyi8gXAfBVle2rGoFx2eFEklUhNV21XikGxm8XvLOppOS
         qFdOrlDXjtnwhFci1T7P9/sE0b6mIC5sjTJjWayh+8NJq7dQ+iXl08HvLg8lMCSL2Fxh
         Xob8gwPgMAryWY7pTyzD5ozHf2C3hqB8pbae5ee6q/9ZzEaL1uN7k+ZfRCBxoDT26GNB
         rU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fATZ5d7C23ZPWTLH3+94U+unkH32QkI5WQTe9RMwP3g=;
        b=5EnWbYPJk6p1w4+SH40tDKcy2oEZTpz9/seIAo1hKsALf9/3ZJRg3eP3+7RANqVTct
         Gz7w0fJGEpSUGdYQylBbg/hy8itK9WsZL666rCL054TDLEwNebFi5iaOYoD8sQPWzN7v
         gZReqr8+T5AD7hpT0eW/KKljs2x1QpxnZfnf80qW3FtY3jy4WClWWLM0fQsPYsQIVoUb
         CzH61pFtKWFUx2cBtyqIta/bajMzpLwHipAVtPmkSQqwzWCsr8mZ9tdtXrX5vx5JP2vt
         PyWQHUX/OxrIwRYNGorTYTZBzHacHaRQxIrMhNgx1VZqI9LGb+Di4xsm0cMTBojke/+M
         Wg9w==
X-Gm-Message-State: ACrzQf0a6koRKpXCyJ9xzE3kiRSafmqRvmklXZLQw+GlWU87pDSyD/pH
        kl0X5E3N/IOlXacpbZ3wiWnUM3DvcrCYsg==
X-Google-Smtp-Source: AMsMyM7yPH2OfYzjrMcExHyWXpzKmDgb1Qgy3E6z+u4KG0WWt3NT9/AYQgrP57ByX4RFGsNz+Tq/DQ==
X-Received: by 2002:a7b:c051:0:b0:3a6:36fc:8429 with SMTP id u17-20020a7bc051000000b003a636fc8429mr398578wmc.78.1664900389519;
        Tue, 04 Oct 2022 09:19:49 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:80f3:87e5:ec43:c70c])
        by smtp.gmail.com with ESMTPSA id p26-20020a7bcc9a000000b003bd83d8c0f2sm1245191wma.16.2022.10.04.09.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:19:49 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     dave@dtucker.co.uk, Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v5 0/1] Document BPF_MAP_TYPE_ARRAY
Date:   Tue,  4 Oct 2022 17:19:28 +0100
Message-Id: <20221004161929.52609-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Add documentation for BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
variant, including kernel version introduced, usage and examples.

v4->v5:
- Use formatting consistent with *_TYPE_HASH docs
- Dropped cgroup doc patch from this set
- Fix grammar and typos reported by Bagas Sanjaya
- Fix typo and version reported by Donald Hunter
- Update examples to be libbpf v1 compatible

v3->v4:
- fix doctest failure due to missing newline

v2->v3:
- wrap text to 80 chars and add newline at end of file

v1->v2:
- point to selftests for functional examples
- update examples to follow kernel style
- add docs for BPF_F_MMAPABLE

Dave Tucker (1):
  bpf, docs: document BPF_MAP_TYPE_ARRAY

 Documentation/bpf/map_array.rst | 217 ++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

-- 
2.35.1

