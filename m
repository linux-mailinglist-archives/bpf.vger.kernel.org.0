Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E102F57AA
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 04:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbhANCET (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jan 2021 21:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbhAMWg6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jan 2021 17:36:58 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADFDC061794
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 14:36:17 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id w4so2346290pgc.7
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 14:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=RvmtRhkONMmfhKRRv0A/mu12QKo6Pw33tPGzPMsnY7U=;
        b=eNg+TgZVgGKOKdnt+s9s+B/MNQiswvTMCwgmo8Ii3RPSXI63/n0z2lZa0uLfn6edAe
         CqelYSNlg/KPvUyYhf+1H/U2Ulf9zF+gH256Rntm3+MEw48hdJACm34mL+qcU+1QgjSn
         YBhqF6hrnorqu+sZO3j380PcokaYnk0LzyiFjAUBJyuhyOvdf0DCMwsyjKOJ2wMgNroG
         f8AJqhwiK5daTSrJdQskC2X+vFNAX78I7MABZIYr6BguQ6hN/u8GeUpaw4C+v7kWNO1x
         ayhVFWgdpJdPlDacSn3uevpU+Qdpduf0rkz1PDStxciqbonDSVJPOoyXwRVrGRN9xz87
         tg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=RvmtRhkONMmfhKRRv0A/mu12QKo6Pw33tPGzPMsnY7U=;
        b=CfThVc3PGbvmRSTPIkT1NAiAkw1sHfoMpowK2OpZ+wcz/F2fkH9qa1kIaO8aSjY4vk
         UCpf6iXFgCHbAkQ2+IoSImzaxuRRv/9/2OIWfCaXuHXTytYV+ZnoPAfJla0oH3czGmSH
         7mpWFDZWrwUzKkPvF4tHgmttEpq/QRPm7WUbKsXYjGIEwSb08XVIKqmOvY4rt+sjlK5t
         F6bf9g1lhBlO7dimQrjNRylYsvLkp8ejiysVnta2nuJ3XPCtVeUObftN842TYwjeXPpH
         U0OQW/3z4be5omtLg4Kb4zlmOmzaiO2/y9eLq+nqTC/9NGfHKrpWaPUMjTsLDmMDKAkz
         5RMg==
X-Gm-Message-State: AOAM531sZ2lDoHs9XUS95+8u/I08+4AiiZ5ri+XDE41wgV5Tx4s1VUMQ
        CnhZ+vvzrr2rMzqiE50LGewLGPJB8Dsx
X-Google-Smtp-Source: ABdhPJxuT5GN8uIB0Yk80LlDAp87gi4fAKPUBt19+DQuoK0Q2qZEJ//A/7To9qS2YuaQflTY45diDpaAilnm
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:902:12c:b029:da:e63c:dc92 with SMTP id
 41-20020a170902012cb02900dae63cdc92mr4528156plb.71.1610577376422; Wed, 13 Jan
 2021 14:36:16 -0800 (PST)
Date:   Wed, 13 Jan 2021 14:36:08 -0800
Message-Id: <20210113223609.3358812-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/2] bpf, libbpf: Avoid unused function warning on bpf_tail_call_static
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Ilya Leoshkevich <iii@linux.ibm.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add inline to __always_inline making it match the linux/compiler.h.
Adding this avoids an unused function warning on bpf_tail_call_static
when compining with -Wall.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/bpf_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 72b251110c4d..ae6c975e0b87 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -30,7 +30,7 @@
 #define SEC(NAME) __attribute__((section(NAME), used))
 
 #ifndef __always_inline
-#define __always_inline __attribute__((always_inline))
+#define __always_inline inline __attribute__((always_inline))
 #endif
 #ifndef __noinline
 #define __noinline __attribute__((noinline))
-- 
2.30.0.284.gd98b1dd5eaa7-goog

