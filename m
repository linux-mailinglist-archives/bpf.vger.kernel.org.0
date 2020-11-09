Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969942AB62C
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 12:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgKILKc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 06:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKILKc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 06:10:32 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC673C0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Nov 2020 03:10:31 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id a15so8302833edy.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 03:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yh+/Hu7gDTPOX4Zmw0h0I/OdkJbbGbMJSCphKz8g8mA=;
        b=QZK180KcGWSnY8fKgd6Oax4JfCZPhSe3hszK8HRPSlffbOa1jcxNAy3d+llNfrRctj
         bF4cvZpQL5CNvJJfz9xuqZMP4hk9DTtosMCqJVgi9kWwqa39gf3481sg4PS9n+hy3mmi
         AQ6eQm1S7uK1WlYthW5diblNhpuzfNDOYD08ztc28W9t2w+XwAIGdnTsXj9XYmnPxtDQ
         TzmxULY8/Seofnz3AXXdr5F5XOXuxqHWAeVtROZI0ulGlPREZc5ytD/uydeUq4ihQ1js
         iQjddkxFti8EOv2FHW4Fhs9RmqletLoxSX5h0FC7vKPt4P55pCirD1zfQBByxdgnRwx9
         BnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yh+/Hu7gDTPOX4Zmw0h0I/OdkJbbGbMJSCphKz8g8mA=;
        b=frErBka5IlTcxEspLebpq+z3e+YTSQPhauEUMEs9L8HgpLE5zf2tTA931xiMEk8Xb8
         CLlGoMPCji6Xd+w5tFhtaZR6KJwPHZu22jtatmmSyyjExm82c+7ABhYVfPMT/fR3v6uR
         mYogJTdMYGoBxBqYxWMiA0wld1RpUr/Rx13G8/BCzKeR26ykGT4c+BSHGoYQztKVnMAg
         hhc7fqa0CgAl+NABbLNoMK1228gqhJtU7ZCWsxtXiEMwKNJ4IWok4Z4HRfZ+QWUyBcpB
         bo7p5Xq1tvd3ID8BKvGfjfrMNcfKdxEzthzeVUhlOFq1ZcpWulxrNUfpdK3CdTv3EHey
         EZHg==
X-Gm-Message-State: AOAM530sUOA+pQMjA0XAVdk5VYRyqO9gQFi8eJbtZKoeL6II4Zv8E6/Q
        YzbyZPvHHSjfum9ArLyjmJLByA==
X-Google-Smtp-Source: ABdhPJwyD2WjRV7VwkwRG4galmOrZYplpV0yqhfkru5uNZL+aAo3E6HNu6/7YBUT5Q9m2MOvLimxXQ==
X-Received: by 2002:a05:6402:553:: with SMTP id i19mr14508523edx.194.1604920230569;
        Mon, 09 Nov 2020 03:10:30 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s21sm8768064edc.42.2020.11.09.03.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:10:29 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 0/6] tools/bpftool: Fix cross and out-of-tree builds
Date:   Mon,  9 Nov 2020 12:09:24 +0100
Message-Id: <20201109110929.1223538-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A few fixes for cross and out-of-tree build of bpftool and runqslower.
These changes allow to build for different target architectures, using
the same source tree.

I sent [v1] ages ago but haven't found time to resend. No change except
rebasing on the latest bpf-next/master.

[v1] https://lore.kernel.org/bpf/20200827153629.3820891-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (6):
  tools: Factor HOSTCC, HOSTLD, HOSTAR definitions
  tools/bpftool: Force clean of out-of-tree build
  tools/bpftool: Fix cross-build
  tools/runqslower: Use Makefile.include
  tools/runqslower: Enable out-of-tree build
  tools/runqslower: Build bpftool using HOSTCC

 tools/bpf/bpftool/Makefile        | 38 +++++++++++++----
 tools/bpf/resolve_btfids/Makefile |  9 ----
 tools/bpf/runqslower/Makefile     | 68 ++++++++++++++++++-------------
 tools/build/Makefile              |  4 --
 tools/objtool/Makefile            |  9 ----
 tools/perf/Makefile.perf          |  4 --
 tools/power/acpi/Makefile.config  |  1 -
 tools/scripts/Makefile.include    | 10 +++++
 8 files changed, 78 insertions(+), 65 deletions(-)

-- 
2.29.1

