Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A49559C057
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiHVNTa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiHVNT3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 09:19:29 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697413F55
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 06:19:28 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e21so9025217edc.7
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JVktCRFlggE5xvUjcdqUUHUkXRdrKq9V8XDCa455a2o=;
        b=NVOnDrkhg8tI/HwhMyI5vm9SVLlN3s9EvPR48fijnAqNHz5xz7LrgQGg7BhhcaMqQm
         W7wsgWv0l/sZUv1RcnQwcDuhKdH6loaJti5emXwt6WnmYSGmC/0mrZRw1I5OL/siEKS2
         kTKBWlhRz06SuEH4elRFjNpe6G5suSjjeVXAb3DNsWnuP6L5zySgzUtGuOYyrhWpvmtX
         pxvloI1vassUWTKbqTxM/9n9Irmsce1Uk05OF0fFIDJE1stgJAJ7uOoemA7L3IjqJ/vj
         K17AFG479vIJWLswoWLuLJ5eBSMRmPscitgUQGSHhamYOs1Wg0jZ0cfPIJ+VSK3MKkhq
         Qa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JVktCRFlggE5xvUjcdqUUHUkXRdrKq9V8XDCa455a2o=;
        b=0WmN9OSU0qXsX9RgEnFLnn0yC0yOg4D+PA3ACiVF1x5nOLcgRCBx44xl0im0n22pNG
         oY30n3QBLdZaRhQEGMmVN7C6zz4F1PoT3/pI0uRXxGb7nfEqzFs1EkQAQ2KKtOhDeK/S
         +sX87cIDRXsMEl7XRk0k8L4VqpvAnnGBP8bbFasxIljKDLvVR72Y+e555sBdBZFnqXQb
         wkI3zpCdONCYpABy0lDE+hKAlM5uAU6yioY0oKck+U0nYEpg70ZvOuWV0YVV0CBERgZW
         KQ2SBxwjUgE1QPm7TeygQCmCG/hisvugKi9gjsHp9Rxal82XRUVI3BWYZswP3v4MMG9x
         9W3g==
X-Gm-Message-State: ACgBeo1OfuAYZH5rtknp1oUB4KeBGd3QoPi1ZB1vdF7PO3/VUXmeGilH
        +WOJx2xVRM70lyGQqDg6uS2bzGmlaN0=
X-Google-Smtp-Source: AA6agR4ZqV0aWvl0zVczj83vi3dpLvRq4pemqOzypLj1gog9kfuICsAC3U91ZWpXws6bEyYTVmhfmg==
X-Received: by 2002:aa7:cb92:0:b0:443:98d6:20da with SMTP id r18-20020aa7cb92000000b0044398d620damr16108090edt.399.1661174366171;
        Mon, 22 Aug 2022 06:19:26 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id en19-20020a056402529300b00446783d4d02sm4405363edb.30.2022.08.22.06.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 06:19:25 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 0/3] Fix reference state management for synchronous callbacks
Date:   Mon, 22 Aug 2022 15:19:20 +0200
Message-Id: <20220822131923.21476-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186; i=memxor@gmail.com; h=from:subject; bh=sZfXyLGzZxmooSIslOruIWP23CSnZ2HtZ1frT7eI+Zk=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjA4GovBgUahDVrdUG+Q10Xr3Vex5PquGXVnG8FZBC C+0mE/CJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYwOBqAAKCRBM4MiGSL8RyryiEA CxN4YoElXsySE4XDmfbvKhJKzm4qjqCeCyPsSEUjnZnne9b2PIkBWzQpnf1teGqkTzY6OZYSLCIWeg sedRnFoP9juAyn7AiHBWKSEMnoGDkPcjCX359msNsPRELKwjcOyXpbPPOjarycud0Iny6gU/hPltBP GPQSZVyKRqWMJ4vvFdNqUc4ze3nOr8k9SMWOhSNXP/cFQyKn+UDqEkEi7k75WjaQV7hIW2S4thj69m WsUw1oNOQO8Q1XEbFB6qLHG64FDk0EgkUQM3bOFShFtVvptmZKnd69k3vnVgHT2d58nnClnUh/yj0j 8TW1ApxoloR54jE8fgQU3of1sB/0Nzo4lFIbfiT29/Ob8CfdW5iPXQ0Oj+tdGSXKJkuwudaUAflVvS B10GhGqnmY8GbG5n4OyxKz3PeqpDq9NgW6TQ1GAZRotUG5yjpm7EDk+qAfv7gsB2tGw/fH8q9MHlkN SPkxiwLAWRt2k6iBYsbsVMLsOVxk8/z1mGWTJwdiL2V+LXllFbY1Y+sSqfVo4Afb1SjN48on/5z3Ig zwecU5WjCHisKQQbycnGLRvDnx8Ukc60M776R8mqOO8k4nBr8WfiLMD+2zYV8HnGQEfc845xg2Qymm AkuVy8pasPXErnr6iglTThQmVw/rwIu+nBtccWUM12Y+zgxm8aH1LMVlBpLQ==
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

This is patch 1, 2 + their individual tests split into a separate series from
the RFC, so that these can be taken in, while we continue working towards a fix
for handling stack access inside the callback.

Changelog:
----------
RFC v1 -> v1:
RFC v1: https://lore.kernel.org/bpf/20220815051540.18791-1-memxor@gmail.com

  * Fix up commit log to add more explanation (Alexei)
  * Split reference state fix out into a separate series

Kumar Kartikeya Dwivedi (3):
  bpf: Move bpf_loop and bpf_for_each_map_elem under CAP_BPF
  bpf: Fix reference state management for synchronous callbacks
  selftests/bpf: Add tests for reference state fixes for callbacks

 include/linux/bpf_verifier.h                  |  11 ++
 kernel/bpf/helpers.c                          |   8 +-
 kernel/bpf/verifier.c                         |  42 +++++--
 .../selftests/bpf/prog_tests/cb_refs.c        |  48 +++++++
 tools/testing/selftests/bpf/progs/cb_refs.c   | 118 ++++++++++++++++++
 5 files changed, 214 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cb_refs.c
 create mode 100644 tools/testing/selftests/bpf/progs/cb_refs.c

-- 
2.34.1

