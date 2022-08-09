Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CF858E1C9
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 23:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiHIVbF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 17:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiHIVaj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 17:30:39 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062F74C625
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 14:30:39 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t5so16683708edc.11
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=5E4qhUZwyWQN6r4I0XbV158Se7hXfc7uDd55MXly8W8=;
        b=SwjOIuxPH6jx0YYde65E4otsBg/5KQXb3eBH+S6Ub7fwO6W+avxLMp7TrhP4DmNVfW
         YmaO03LfBtHXSl1mzsGZPsLsR7vg0rVi/xJh7ax95lp1zNnblO9hXUXWL8a/+oa9x/pD
         8N37Cvp4/NJpOPNAmvE11M93pnUMOhCkgxnD+f4W0H/G9FOnQjRD/4sd2/dncwFzvDIU
         ZEQuL8Z+W5chJM8zpcFcHZ1MyIT2f2PB1s37pUzHNLe+++ZaXyNji72K8Bz6NO2xcp0M
         mSvg11L7cml9ZD68pzOPROBqG2J3SpGlT7mYUQv+f3RFa49wVeeCxN+hPV55s03VS7OK
         RYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5E4qhUZwyWQN6r4I0XbV158Se7hXfc7uDd55MXly8W8=;
        b=kF6jQwUek4heMs4poURBzjHkOQjjLbwLgW5OBARb2EN5+EFmUrtbrhMYqjLgBxBmw+
         C9kV0XOAIzlHCmLDSmL5T9fQpu562WpzBeF07jrdZ6wGB4sw9pY//IB4bDThla5FDTHH
         9dXAsZD89ERAKS/tAHrm8ObTkiUhHHxO5I5R0DznIOd8XTnjE+O5Sl9c1eTx/doeI2gy
         FEd70tdkUZ3JPUz9QZKgt60waizC+/hQAHsm+ZBHd9NJUvLnIl81eTULtW6kYZpCdWs6
         n5Z3u6maevK1x8ShSI+msNEkuhsaN38VRc+mjVVArHXb/Xz217CiwtV1jAXvcsHMP65q
         EU3A==
X-Gm-Message-State: ACgBeo1Sp6HteEn2InyciGMtirjDMmmlheGcJquZIB829hf+gK8fHHqg
        bOvQYRRWUAbhoUU6LUV4KtQ5XvX18Pc=
X-Google-Smtp-Source: AA6agR7fiBxcfC5EWdK1ir0ekXHcBVFjvowXmtIfj9MQ2TTE7HzSwsiiI0e4kON9ue8eL41R2qcjMA==
X-Received: by 2002:aa7:d657:0:b0:43e:7fe2:95d4 with SMTP id v23-20020aa7d657000000b0043e7fe295d4mr23834957edr.60.1660080637239;
        Tue, 09 Aug 2022 14:30:37 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id q35-20020a05640224a300b00440a1888e00sm4229199eda.59.2022.08.09.14.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:30:36 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v3 0/3] Don't reinit map value in prealloc_lru_pop
Date:   Tue,  9 Aug 2022 23:30:30 +0200
Message-Id: <20220809213033.24147-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=memxor@gmail.com; h=from:subject; bh=HMdcphfBArZmyHHtQYN2js1GmIqzwzXYBoDIf9U5kB8=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi8tHv78RFcLys1A09bgpleKARIYFlp71y35/FBO7K jiT/uqaJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYvLR7wAKCRBM4MiGSL8RytuiEA C9ch9SlGg+TPmNp++ooFLz+GMzegRgOEFes+mvgM+uls8C5jgUd0AsdbZXCr3R77sA8vDkq8n8CZMY J9H+8ZkythJMoCZyj3eBq569Sni5jEm3jTMvEk3zEdhCYet3LuxjIUBKvoWlDAbZ5/64m3M8A+JfHx w1FTQehv99ViD3G8Dg+woaJW6Elbhtw9vWoMy2pyqgpDY5Fw7D7NgpHh7LvSpWvL6z0eJ4jx1Cw5E0 AjSJ+jWL2G0jkIfwrGqS8f9ncUpKqEufZXy59zDQDpawvmUM5E+NLMNKyunjL9NQ5Bgpp6Wk6dD4tU 1IJp6rkI3LxX0cL+EUbV6ijgoMYWrhxdJMq2YbQwv1kOu9mnyfG4Ag7/gHvNHhKi+wB4vtwYE0PBjK oRKomybFYnuqLx8+MgVc/5Jg8NjjAWU/piK22Ms08w5cwFruIRlc7ckSKu1Rmazlm1hZTZRuARio8d ZXL44DulB/gclZHW9ncZl5GLOOKjpT+vearproJ/lPcxNvlRqf2ueZF7bfAMRk5tiYcfaHuwc4oFBm f1b+/nL09w3UiqML18LVF8P0B4Lqic3W8axW0xbOUoj7rK/N7s6BJ4lH/8el1+3qepTp+xECLwuAvL Q8mTLDHzIo+b3tP0HLhfFizuvlUCpOYGT3CJnvtNtPFczSdprkUbtaGuWg+g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Fix for a bug in prealloc_lru_pop spotted while reading the code, then a test +
example that checks whether it is fixed.

Changelog:
----------
v2 -> v3:
v2: https://lore.kernel.org/bpf/20220809140615.21231-1-memxor@gmail.com

 * Switch test to use kptr instead of kptr_ref to stabilize test runs
 * Fix missing lru_bug__destroy (Yonghong)
 * Collect Acks

v1 -> v2:
v1: https://lore.kernel.org/bpf/20220806014603.1771-1-memxor@gmail.com

 * Expand commit log to include summary of the discussion with Yonghong
 * Make lru_bug selftest serial to not mess up refcount for map_kptr test

Kumar Kartikeya Dwivedi (3):
  bpf: Allow calling bpf_prog_test kfuncs in tracing programs
  bpf: Don't reinit map value in prealloc_lru_pop
  selftests/bpf: Add test for prealloc_lru_pop bug

 kernel/bpf/hashtab.c                          |  6 +--
 net/bpf/test_run.c                            |  1 +
 .../selftests/bpf/prog_tests/lru_bug.c        | 21 ++++++++
 tools/testing/selftests/bpf/progs/lru_bug.c   | 49 +++++++++++++++++++
 4 files changed, 72 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lru_bug.c
 create mode 100644 tools/testing/selftests/bpf/progs/lru_bug.c

-- 
2.34.1

