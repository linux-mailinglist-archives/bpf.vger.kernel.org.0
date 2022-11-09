Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC286227C2
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 10:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiKIJ6I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 04:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKIJ6H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 04:58:07 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2594248E7
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 01:58:03 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3697bd55974so159641637b3.15
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 01:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3spuZlEnOs7qncONbbcgqarNn7F7PonMgqZr4zU5sFU=;
        b=V4kxf/ertdZhaptEv+ypWmELqe+JPfbZn11WzdbLM/amfR/8klvOJduplgilwr0BFM
         ZbTzkVhcD2Q/OSZ5AOAwkCBViKEuL6ojJp86lUU/O9oJ5O0pKeyftf4oO8Q6pUXVEvye
         bMVXSUXOWWA34O3PF6AIM94fmOG0nsw+7iY8u6dIlvppcVb3FK/u9T1fcd6ED6pzw1jr
         7lvXw3kq9ZFxkBQugVP2SrlGnAghTsCi1qF67kjdFYN3+d1O+7bj44u/LhCFnH7Sds2R
         +J2CpEVLAEHpLYCS0JOkgg3R3Qd2dBMyBlH0yQU84eyzJiyqnQDxobBY1epjJ7uPlUum
         DcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3spuZlEnOs7qncONbbcgqarNn7F7PonMgqZr4zU5sFU=;
        b=V8Bv2wgtZ2Dc4TcqVbMm6ZuZF1xZnmFBo9Zy1HaZ9X/TCtWt3/Uy5Tx2XvBuTphTHj
         BsBvH52Id+m1EYADC3D54PPPUBvoElaYLCvAJ1FHJvsWhI+EzUgCMrTHWhGVRK3V7EPb
         lu6NxjYUVjoFWGRmRx7qLqGoyARCyZvbnSnQ/9oWfnzsOVxTaJVXYF5CSHZ6ai2tZhGe
         43IMqQp4bV8iKolXdaY2PDdiDHt+d/3KLtnrZr4IyxsoZsCrajoD/jSkfNkPdoyH+oem
         dDW75G4ZJ1WZD111wAltvZSBeW6uNwgu55hyLB/xH02HLRDUTPbr45EsCgwXBiynoRe1
         Skgw==
X-Gm-Message-State: ACrzQf3E2nsLunb1CwyFbkOLJ3J1PMfRSBJ/uCO2m/yz0Cw5vaxZA3TO
        YRwDsOEwLpDCBKkSYMKUZItBjYT4UXGAmQ==
X-Google-Smtp-Source: AMsMyM5GhTvSUDMKIW9o2zPl7PS95N/a2UaFqVw3jbs/GAN2AY1LGoBcPaXYjNu/E+YoSLDwsPRFnsZuA0cLFw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:3f07:0:b0:6bc:f68b:da0d with SMTP id
 m7-20020a253f07000000b006bcf68bda0dmr55793772yba.227.1667987882029; Wed, 09
 Nov 2022 01:58:02 -0800 (PST)
Date:   Wed,  9 Nov 2022 09:57:57 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221109095759.1874969-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] net: vlan: claim one bit from sk_buff
From:   Eric Dumazet <edumazet@google.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First patch claims skb->vlan_present.
This means some bpf changes, eg for sparc32 that I could not test.

Second patch removes one conditional test in gro_list_prepare().

Eric Dumazet (2):
  net: remove skb->vlan_present
  net: gro: no longer use skb_vlan_tag_present()

 arch/sparc/net/bpf_jit_comp_32.c              | 10 ++++-----
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  2 +-
 include/linux/if_vlan.h                       |  9 +++-----
 include/linux/skbuff.h                        | 18 ++++++++-------
 lib/test_bpf.c                                |  1 -
 net/core/filter.c                             | 22 +++++++++----------
 net/core/gro.c                                |  4 +---
 7 files changed, 30 insertions(+), 36 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

