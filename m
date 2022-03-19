Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96144DE817
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 14:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiCSNHV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 09:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiCSNHU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 09:07:20 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1F225EC91
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 06:05:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m22so9538812pja.0
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCVwMfcXcYeakQNhGAeZYhz7Dl4dA1e4fZL5y17wYgk=;
        b=pIXF/9e0vpTi4/6ComkMVdofjTDwKOWLmryt3pFVZT1atkcii5C3Q9bcNnu/QuG3xJ
         fYg2AtJNL1feAXPqgbhvvUB1rLRn1dmGbkoLtGSZr8ppCwsB5vF9uURP3gpo+GKDkheo
         J4XF47vF7TkJZDPukChbBDdzgQtykbtlVtgxkM6BuVQxfQSkmJ3nxP3uSXERvzg39Zow
         /kVPdUE1l5TNtlVozQ+WvYew+uCnnRfgesW86Hp7mwaUmqMslE0ZFGOG/ZDNsgkz6ynX
         OFBOnA3Xp7jkEk/MR6yQJtB+2esSFYl0bS3S8yhdGkQYf+7O57+QYJ31iZ3DoJgnmTnT
         6b9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCVwMfcXcYeakQNhGAeZYhz7Dl4dA1e4fZL5y17wYgk=;
        b=rZu4mT5PJM5a62cEWA/JVQTkDKwgPhe3naH9yloDSqNePzRCrnoqD8KFiB/2Zb2FXV
         FJFZHnvoG8GP+nQNZojcLnhWdHCM0z0D2hPQAoqMmx92uwaOrD7Tlk8mQXvujuQ3sYop
         3Hxp++hLaFHGlnoEAOlGE2g7SNSclM+MWCJt98LIWTFccyCNJ+wVvMtaJjuwY6ieYgla
         DslsrNW3W96o5TnILWmy6nDnfYJSiXh/V8x+APfBzhl2YAPWT2PDrxQ1Z2eQkFrTVRsm
         714SNx4Lf1EqMDmH/+Kt2z1+kz6faIPojGGMPdQur7+2ZXXcbM4ISM9QxQWkGVhU6IaN
         0kPw==
X-Gm-Message-State: AOAM53225uOjRMaLixIXqAX2heNx5IpEh0ZRxIWo8TsQ1uv7trnPNIhJ
        I26012A7KCj6O4DRm6w83cQWJ2YASvSZ5M8r
X-Google-Smtp-Source: ABdhPJwTv+o1HsUfOpYDhKlpOxtMBG190EMUlCtKD744lvSl88CW+9Y3TfcRMtzfp636zrkLCMBOUw==
X-Received: by 2002:a17:90a:ca0f:b0:1bf:b996:38c0 with SMTP id x15-20020a17090aca0f00b001bfb99638c0mr16349720pjt.238.1647695152392;
        Sat, 19 Mar 2022 06:05:52 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:483a:72c0:bdf5:8ebe:6be8:a257])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a000acb00b004f35ee129bbsm14007797pfl.140.2022.03.19.06.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 06:05:51 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     john.fastabend@gmail.com, kafai@fb.com, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        "kaixi.fan" <fankaixi.li@bytedance.com>
Subject: [PATCH bpf-next 0/3] bpf: Add support to set and get tunnel source ip
Date:   Sat, 19 Mar 2022 21:05:35 +0800
Message-Id: <20220319130538.55741-1-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "kaixi.fan" <fankaixi.li@bytedance.com>

Now bpf code could not set tunnel source ip address of ip tunnel. So it
could not support flow based tunnel mode completely. Because flow based
tunnel mode could set tunnel source, destination ip address and tunnel 
key simultaneously.

Flow based tunnel is useful for overlay networks. And by configuring tunnel
source ip address, user could make their networks more elastic.
For example, tunnel source ip could be used to select different egress
nic interface for different flows with same tunnel destination ip. Another
example, user could choose one of multiple ip address of the egress nic
interface as the packet's tunnel source ip.

kaixi.fan (3):
  bpf: Add source ip in "struct bpf_tunnel_key"
  selftests/bpf: add ipv4 vxlan tunnel source testcase
  selftests/bpf: add ipv6 vxlan tunnel source testcase

 include/uapi/linux/bpf.h                      |   4 +
 net/core/filter.c                             |   9 ++
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/progs/test_tunnel_kern.c    | 106 +++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh    | 109 +++++++++++++++---
 5 files changed, 219 insertions(+), 13 deletions(-)

-- 
2.24.3 (Apple Git-128)

