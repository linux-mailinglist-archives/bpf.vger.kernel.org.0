Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5601A1BDD1D
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 15:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgD2NFt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Apr 2020 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgD2NFs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Apr 2020 09:05:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3AEC03C1AE
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 06:05:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k12so1944295wmj.3
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 06:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/8EkDb+jA4Y7UIYfY/fiveZv70ZqdtTBrbZAqolYyOc=;
        b=ZE68sFJf+zsFIvPysKOINPI+BjjiWzuI6EHne1ZHdZCHscaskebNWizOD/fqN9pwAS
         69t9UiqEiSNzLuIaqs1R8XDW5y1D+NfVypq8LA6I0MJKq+2wImlbH+DqzruiVipXGwyf
         MgWSP/AoFsSu0rH1mIxLyj7LTDeHuyWpEWNiRSxUsSCA1FVlOtRTYw3bRpgrFk8PhTPT
         BaGQQtJDxJWrsxgWU/Q/Uc70K2Eml5rFPuzF/x9YpJ0lTuMefihiCfs8Q9Wnz/z4GXhZ
         qQLcadKtaLRFbOBU68Z91dmcOmMLUI8uwkxOFDnnJsEpPqVm7DuwJZ9Xub8pxKKVvMFe
         ylzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/8EkDb+jA4Y7UIYfY/fiveZv70ZqdtTBrbZAqolYyOc=;
        b=POVoCDx5WBvXq0j/FSiORVyIL/2+apJ+nTUFHStNncIVp14TrysCINim7uvcdKQBvh
         8gQw/WH7w3+gQMt0RLQeItB+Ka+b+1a3y/mlF+19wnxRYLNGz31j4yHGprS7dVvXnOLe
         bVlClJcsSV8k1RT0jxUv/3wl4d51ltH8usrV/fQH5JdQCs5nGPNkRigKRa4GxKkTuraT
         LaftJPJjGYqmivHkqpGtZO1gy+ocgiiFriLAtT+vQqiPinYAFCOvW2k58nP5xSdW2jN3
         jDwiRFZjsVMVWDtYrPrhnXspYhRclRENAapGK9rHsY7lD3lCq225NZv6bh9OohvBqocl
         W4Qw==
X-Gm-Message-State: AGi0PuY2w85NOZ1Z+MPqxcCFl25Mik7tXmyeQS9regkZuQC0BpBWCz+A
        n5tcS2ycLa6XiVfVt1HiC8bKAg==
X-Google-Smtp-Source: APiQypIhAQ6bwmZ4+a+x4PrWnOxLWWWSjcCeelD9uJcXMtpNDreE560JEPOJsntb4w6q+NbB77miWg==
X-Received: by 2002:a1c:f306:: with SMTP id q6mr3139152wmq.169.1588165546975;
        Wed, 29 Apr 2020 06:05:46 -0700 (PDT)
Received: from localhost.localdomain ([194.53.185.38])
        by smtp.gmail.com with ESMTPSA id 74sm31568199wrk.30.2020.04.29.06.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 06:05:46 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH bpf-next v2 0/3] tools: bpftool: probe features for unprivileged users
Date:   Wed, 29 Apr 2020 14:05:31 +0100
Message-Id: <20200429130534.11823-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set allows unprivileged users to probe available features with
bpftool. On Daniel's suggestion, the "unprivileged" keyword must be passed
on the command line to avoid accidentally dumping a subset of the features
supported by the system. When used by root, this keyword makes bpftool drop
the CAP_SYS_ADMIN capability and print the features available to
unprivileged users only.

The first patch makes a variable global in feature.c to avoid piping too
many booleans through the different functions. The second patch introduces
the unprivileged probing, adding a dependency to libcap. Then the third
patch makes this dependency optional, by restoring the initial behaviour
(root only can probe features) if the library is not available.

Cc: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>

Quentin Monnet (3):
  tools: bpftool: for "feature probe" define "full_mode" bool as global
  tools: bpftool: allow unprivileged users to probe features
  tools: bpftool: make libcap dependency optional

 .../bpftool/Documentation/bpftool-feature.rst |  12 +-
 tools/bpf/bpftool/Makefile                    |  13 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/feature.c                   | 141 +++++++++++++++---
 4 files changed, 142 insertions(+), 26 deletions(-)

-- 
2.20.1

