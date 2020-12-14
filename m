Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667ED2DA0E8
	for <lists+bpf@lfdr.de>; Mon, 14 Dec 2020 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502874AbgLNTyQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 14:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502842AbgLNTxy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 14:53:54 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F45C0613D6
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 11:53:13 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id i24so18461984edj.8
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 11:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pm5+Ct9q0C2jv5E5bH/3AvpnKRxf91FLFMlK2cnC5C8=;
        b=V9wav5Likvwd1Q3u0L2i8Su9E0kwAhLUwX+JF18h+i4gB8trJ2pQcwrvImphlSDZMF
         gz6tLHWGlvzIgEAo+dO5WMQhr0a7NsVx/0wTeGI0ZNUcTb28pDR2iJJrFhcQUxLl38QF
         Xr+BGoREkw446f3+pw6nPVqEMocfHPkgosk99tXDXD0ZzfFu/Un4t5sI82bRcvC7wK0K
         gPEhT5/FaGUDaT4nUQvYISFaKLNSl0w+DsDTzhHfWjyth8yYNoLSHwLfjJ8LY+FmVs++
         7kC1hFvWtGi3KnXEDz0cnxQybUnY/CTgsdU/ys58KUNhc23VDUlJeYvDkyH0U0Yjw6P7
         zJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pm5+Ct9q0C2jv5E5bH/3AvpnKRxf91FLFMlK2cnC5C8=;
        b=h08eleHV3xyVWJTueLkfiN3LEnVE63uxMWifZ/xa74EutrQb0aGakLCTiPLsnEoVsv
         XyJbUHI1VkcwmhBN2HJ0gv2MRaZh92wvGXMTLjGfdbe/UlYZfwOU+4V+Z3Yop7OWMNBd
         4o/cXPYN24Oni7td9gHAwrE003cHZeFA6IRYlffJYKoxVFmhfSM8PdjE1DxoAH32BRoD
         zmC5VoLPZDMr2SM9m00//1mB+5sjfOmpQnegGLgoENye1uVwnAKFsdyfLUH0iRphMmPH
         +KAwR1dtahdx7zA4kD7wn9GE3u0ezYdoPWFvawXC10txF/XUvd4eCHRmDJSv5cgZfEF/
         dYaA==
X-Gm-Message-State: AOAM533pXtQTj/HE5MMu7LwuDS+KSLuM1+UitXu5KtrCrvNKNiBTF9Cc
        JSaimbrHsgpHBPEdjoADBA6GdCvRuhsoWgCju14=
X-Google-Smtp-Source: ABdhPJwq8r+E1Y4SPT6quGvUph7cZDtotksCGTwOXIUbxuYJtVmDIiIHUJh6FMvcD14MMIR3jky+Bw==
X-Received: by 2002:a05:6402:129a:: with SMTP id w26mr27315719edv.355.1607975592030;
        Mon, 14 Dec 2020 11:53:12 -0800 (PST)
Received: from localhost (bba163592.alshamil.net.ae. [217.165.22.16])
        by smtp.gmail.com with ESMTPSA id t26sm16595882edt.69.2020.12.14.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:53:11 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH bpf-next 0/3] Add support of pointer to struct in global functions
Date:   Mon, 14 Dec 2020 23:52:47 +0400
Message-Id: <cover.1607973529.git.me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds support of a pointer to struct among global function
arguments.

The motivation is to overcome the limit on the maximum number of allowed
arguments and avoid tricky and unoptimal ways of passing arguments.

The limitation is that used structs may not contain any other pointers.

Dmitrii Banshchikov (3):
  bpf: Factor out nullable reg type conversion
  bpf: Support pointer to struct in global func args
  selftests/bpf: Add unit tests for global functions

 include/linux/bpf_verifier.h                  |   2 +
 kernel/bpf/btf.c                              |  59 ++++++++--
 kernel/bpf/verifier.c                         | 107 ++++++++++++------
 .../bpf/prog_tests/test_global_funcs.c        |   5 +
 .../selftests/bpf/progs/test_global_func10.c  |  29 +++++
 .../selftests/bpf/progs/test_global_func11.c  |  19 ++++
 .../selftests/bpf/progs/test_global_func12.c  |  21 ++++
 .../selftests/bpf/progs/test_global_func13.c  |  24 ++++
 .../selftests/bpf/progs/test_global_func9.c   |  59 ++++++++++
 9 files changed, 284 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func10.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func11.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func12.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func13.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func9.c

-- 
2.25.1

