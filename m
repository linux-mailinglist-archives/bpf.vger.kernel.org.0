Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1EF31490E
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 07:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhBIGpW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 01:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhBIGpV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 01:45:21 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D61C061786
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 22:44:40 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id w4so1979772wmi.4
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 22:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SktVYdMxv9bzUTWJ4JvcjdVcKaJcnyh51nk3OvQTXqA=;
        b=CubuX92BPcRnz+Msz+HUpjIx/4A3VQUpG8nwzXc3iealgtIltk2V1qWRuU7dogAjhe
         WWq7TsBbTwTTDHIsZyxPEPg4xt2aNOpkn0Vvyt10uPSegy4885KWZBuBMBwoiNjDWWFB
         hM33IcYzsqnsVIBAkwzbDmLIZonz3tRsHSKidrpCTI8BY9HXCX4LvNyuHDWPvaVrM+21
         91OVYnJT/EpLLus8TUzcNBOcTRJn43O+j3WWS2IWZyKOhy8HBG+N4htlEOR5OguasiOK
         lNHO7w801SN6+DgkRi5hND4wgESsCPYav61CM60umZzbLZrok6uwuroGwXYjkgSG5b9B
         Ojew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SktVYdMxv9bzUTWJ4JvcjdVcKaJcnyh51nk3OvQTXqA=;
        b=BN1YKkIskmuzlw/4AWRVzjj4IYP5NF4tDRJEZel2LpsbjzpE/P+PmykGOZ0HqsS6B4
         7Tk277jBa5hnjipTZeCseggfoPIvQK4+fTbSDfQwvfkykDkMAe49CMywhgiGbogS4L7j
         aWnFoCcxBFcZaZqVttuaifoH22CXmee7t60HWav4G8jjEfAYfslzpbwSYRzwEidZ/cCn
         6CDj9l308WufiNQ7hyY2ZSKsSu2BGyIJ1NN13/JfpoagOrpdat4laNbxILqWZDie14Og
         l5AdNd6D02DXMshjbdIKeGyZOvKDGdv7mpGnyBoa4KZO/torysl+ybeQsK1VBEiFQUwa
         uAIw==
X-Gm-Message-State: AOAM533PHbaMRyqPgSItvHEB96cV2E/VfbVErzbDsTDtY2MNTI/hR28f
        pNwgLIc5iEqXcQX1J0cDf3grP2F4+7PinUUFHT0=
X-Google-Smtp-Source: ABdhPJwdZ4bnXrdLYk3X3QFPLrjctPCPrPBabv2uf+UVWT34oMrCaiLK57FFomllGOedLox6lmtH0Q==
X-Received: by 2002:a7b:cb92:: with SMTP id m18mr1864766wmi.35.1612853078619;
        Mon, 08 Feb 2021 22:44:38 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id c62sm2772759wme.16.2021.02.08.22.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 22:44:38 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH v2 bpf-next 0/4] Add support of pointer to struct in global functions
Date:   Tue,  9 Feb 2021 10:44:17 +0400
Message-Id: <20210209064421.15222-1-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds support of pointers to type with known size among
global function arguments.

The motivation is to overcome the limit on the maximum number of allowed
arguments and avoid tricky and unoptimal ways of passing arguments.

A referenced type may contain pointers but access via such pointers
cannot be veirified currently.

v1 -> v2:
 - Allow pointer to any type with known size rather than struct only
 - Allow pointer in global functions only
 - Add more tests
 - Fix wrapping and v1 comments

Dmitrii Banshchikov (4):
  bpf: Rename bpf_reg_state variables
  bpf: Extract nullable reg type conversion into a helper function
  bpf: Support pointers in global func args
  selftests/bpf: Add unit tests for pointers in global functions

 include/linux/bpf_verifier.h                  |   2 +
 kernel/bpf/btf.c                              |  71 +++++++---
 kernel/bpf/verifier.c                         | 113 +++++++++++----
 .../bpf/prog_tests/global_func_args.c         |  56 ++++++++
 .../bpf/prog_tests/test_global_funcs.c        |   8 ++
 .../selftests/bpf/progs/test_global_func10.c  |  29 ++++
 .../selftests/bpf/progs/test_global_func11.c  |  19 +++
 .../selftests/bpf/progs/test_global_func12.c  |  21 +++
 .../selftests/bpf/progs/test_global_func13.c  |  24 ++++
 .../selftests/bpf/progs/test_global_func14.c  |  21 +++
 .../selftests/bpf/progs/test_global_func15.c  |  22 +++
 .../selftests/bpf/progs/test_global_func16.c  |  22 +++
 .../selftests/bpf/progs/test_global_func9.c   | 132 ++++++++++++++++++
 .../bpf/progs/test_global_func_args.c         |  79 +++++++++++
 14 files changed, 572 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_func_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func10.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func11.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func12.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func13.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func14.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func15.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func16.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func9.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_args.c

-- 
2.25.1

