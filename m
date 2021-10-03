Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C3F42039A
	for <lists+bpf@lfdr.de>; Sun,  3 Oct 2021 21:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhJCTYJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Oct 2021 15:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhJCTYI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Oct 2021 15:24:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FDDC061780
        for <bpf@vger.kernel.org>; Sun,  3 Oct 2021 12:22:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s21so26298320wra.7
        for <bpf@vger.kernel.org>; Sun, 03 Oct 2021 12:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C6sdHrUdi9BDM1rYxYocEEgrTC9SSamTyBYNfJp2XuY=;
        b=17QgwXsEgUib0iUwtVD1HzJ5lK0MncYQOh/snOkZX1ALHJ4aHPz9eYSYjnf1swtE1U
         VOpnxqVo9hT9YDoOC+Dg5jX/qe2AePrbaQAngACdn4AEDEY16oAq7OGHzr+xEQlZgjHL
         NfyY5Z94qGnW3mF0aMrzchCtqPKseeqwWw2DI8+WH1466bqvU0w70REfVXjwSKnEcHcF
         XIN5oe7SLCVCFMIyaUTiphC8mg+e4rOZjCxlG//reedC6CUNMkF6saSR32K5ROzodMzB
         KotyzHIlV8kEtQpoH0GJT/W6IZvj8jIWHqQVBH3BaibGs7xHVO/Ic/BOHk+MfgJkyk1C
         8Yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C6sdHrUdi9BDM1rYxYocEEgrTC9SSamTyBYNfJp2XuY=;
        b=dfggeiiel2Mw+5lMa/X3tt1wvVd4JwIg7ACVXh755Qt8jDDGWXX+E2DRmmoKGwCBO2
         3FUMu55M3UkXKxoQQfrfoEHRvcGGGCP/ypxNpunh3Z3mi6FPTk6fVXepldUaUFQzhE9B
         h4COydwUI7hI29T5KWFLH2XD9BuNniPM/uE8BpH3faQjhP7BA63SaglX+YRv7WXoZ018
         oH2SEI+0yQv/MUAfeFM+KiVpxld9lQR75ed1g/ny63/Zyrh5qV2m+cNrYUEOszuPNH/W
         BE5RryzPtuqHJHSCpS5iAU4vk3eyHCgTJuYJJKV6a66WV6os7s6QgVytD7Pp1JN3lMZ7
         sK/A==
X-Gm-Message-State: AOAM532VgXUSdu9wVKOAG9Z99KYBr3PmoAkwPXL+0GHmfPWOI6o10JPc
        ObDJ6GkSciC+R7JoEzpGEsKe3w==
X-Google-Smtp-Source: ABdhPJywRrUo+T1Rjsp9/FrEmgfy3oEm1JvV76AlHEcy7m+4a0GMbHZHdEBvVk7QwUFLFlnxvWch2Q==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr9952771wrp.159.1633288939602;
        Sun, 03 Oct 2021 12:22:19 -0700 (PDT)
Received: from localhost.localdomain ([149.86.88.77])
        by smtp.gmail.com with ESMTPSA id d3sm14124642wrb.36.2021.10.03.12.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 12:22:19 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 01/10] tools: bpftool: remove unused includes to <bpf/bpf_gen_internal.h>
Date:   Sun,  3 Oct 2021 20:21:59 +0100
Message-Id: <20211003192208.6297-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211003192208.6297-1-quentin@isovalent.com>
References: <20211003192208.6297-1-quentin@isovalent.com>
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

