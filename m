Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2334841D8D4
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 13:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350303AbhI3Lfp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 07:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350447AbhI3Lfp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 07:35:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89185C06176A
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 04:34:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so9555293wri.1
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 04:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C6sdHrUdi9BDM1rYxYocEEgrTC9SSamTyBYNfJp2XuY=;
        b=HQQJsRvkgb6Nho7VlDDEr0s/2xa9K4xns8qQGU8nQ0Z3fndm/vijX+UfgYkzYxPO7Y
         AGJOkxnxIgeA+0hr7wGgWLE3ZGsQSHaBDDc3bGbaB23AFZpVWnA2Ob1Y/P+0kpm079e8
         uZq2CEafCecf1t3bJpvJ/yn9VcparKPneN6Bd8LncVRMcMABowLwn4AHx59buN1ea4KE
         9Ugv6oCMHA+Yx89j+D5wIw+FhIlV/fPpdWwXtFy+6aOEwyC3oFjHdZf8HJfqzuWfzwfY
         cPpoL8d7xHiiYsy/77CWt7fY7rT6JMsWaXYyYm3FwxgTZD9HCdcnWwZO0HlPgFEoTwlH
         I3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C6sdHrUdi9BDM1rYxYocEEgrTC9SSamTyBYNfJp2XuY=;
        b=om35mITLvKz3YjwKXFdQXouBFpyQwgGWmPkRFNZsfnh+8dlehSrZ7qpX2d4H93Awsq
         yagr0al9aZ5RijUPqUMrnRRd7OaUWF2EjXvl2zR9ow3Em6x/U0631Irp6oPRmNYxmPmj
         Ndo9l3JBA2iqd/ngkrI5uYsRSN2Mvg3UDktkt0ur7WXgFNmiEzIksB0xwMT04iAKPPBF
         h1RyAIOQktNuVz0gRGFSzLDa+/gMP2dbVdieArUke9jEd1NTPBDPEtt8XNO1TwaorrJN
         kD1smgHB/7esPLGZPiBw6IeIVh2lri/FCMdqaMO6ixeH6WRGbTOQYyKCk/1I93Wf7tMd
         djNA==
X-Gm-Message-State: AOAM530GjCKaUkTHVXWee10BodaWfloJNkwkIF6jC87rVe1y/W7sBCCL
        HqTn0/g/OFo0YAkOe+crSF/UXA==
X-Google-Smtp-Source: ABdhPJzlRCuX9U4Yk5LIsQEyE1nFTW9uM2c1M9gGK1wgIP5H1uHE7MoWWH1Wfn6wmR87yBt6JqYnXg==
X-Received: by 2002:adf:a745:: with SMTP id e5mr5476842wrd.406.1633001641176;
        Thu, 30 Sep 2021 04:34:01 -0700 (PDT)
Received: from localhost.localdomain ([149.86.91.95])
        by smtp.gmail.com with ESMTPSA id v10sm2904660wrm.71.2021.09.30.04.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:34:00 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 1/9] tools: bpftool: remove unused includes to <bpf/bpf_gen_internal.h>
Date:   Thu, 30 Sep 2021 12:32:58 +0100
Message-Id: <20210930113306.14950-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930113306.14950-1-quentin@isovalent.com>
References: <20210930113306.14950-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It seems that the header file was never necessary to compile bpftool,
and it is not part of the headers exported from libbpf. Let's remove the
includes from prog.c and gen.c.

Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/gen.c  | 1 -
 tools/bpf/bpftool/prog.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index cc835859465b..b2ffc18eafc1 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -18,7 +18,6 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <bpf/btf.h>
-#include <bpf/bpf_gen_internal.h>
 
 #include "json_writer.h"
 #include "main.h"
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9c3e343b7d87..7323dd490873 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -25,7 +25,6 @@
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
-#include <bpf/bpf_gen_internal.h>
 #include <bpf/skel_internal.h>
 
 #include "cfg.h"
-- 
2.30.2

