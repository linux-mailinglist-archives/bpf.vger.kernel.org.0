Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD183DC086
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 23:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhG3V4F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 17:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbhG3VzH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 17:55:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB097C0613D3
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 14:55:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j2so13004727wrx.9
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dDDdCBezO0q2xn1HrTWdc82ZrINOyLuTt9BwXTZEhF8=;
        b=G2DzobJSvCw3qqqzH9OqjS0dIjT5X/cnrYNLGB9hnoEevR048BZUjdhz/Otb+x6l5N
         2nVZ4CNVh0qnNtjK2DQvi1/4ebJP6pw4UD6jSasYV8QzL/OL6Zk61zfc4jkbFnc8t9tB
         pIJTJGg5iZcPYmbka1/bpR718p8fSbZMfadwkp7nGtMDxOW/y1MduA/p+pste+Vjx9aR
         pjWe+zaP7r2AeAJX6667fIgdbZF6ZJIr84SE9Lr9GcHALwQXFrTW9znGfo+9W4AhTwNt
         BH7xD4+o0nFfuxmAn9YLM9rhDnaWh/XcVg6pPD7O4aYgZncfv/vujzxBA0/+Pm5jddUk
         ECHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dDDdCBezO0q2xn1HrTWdc82ZrINOyLuTt9BwXTZEhF8=;
        b=qEbRV7BVFCpYHqzek/teT8LZjyYpw4jUIAz+pyuMEr64c2WqQE81fNj4GyJrYM6Ttg
         EFS+f9yUs8OQzU/b0pQz86sdh0cO3PYQrPliVutUIgP0Y1VrN9e5jAszM1KiKfBg2tdB
         qv6KGhTr4nailn8JTvYn/NYD4ue19kw9gL8xV+pr4r1bGqq6tEvQarMkcjMeeobMez1W
         I/ldbR5k082fERIMNesbmW9D8D4bfJd4pjMYERdP0jx6azh9pIOTYWFkJH1P8JbeXS8F
         DHAQqaRS91N3roSGVycgr9JDlDgoYxa3mdGd5TTpaTXZ3zeclla70dBTUVvr+xOCkYpi
         4INA==
X-Gm-Message-State: AOAM533leDdHdruWCDnmwCjuS4VAPSum3+/60T9MCL2c5J9ifv1CKz8P
        EWRPaDGlJWN+H7+sd1TU0YNCAw==
X-Google-Smtp-Source: ABdhPJyMaZADHSkB2SRMrAKV4ybbQTJjpoepbt4GCUENVaYGrfRPnW1130OXjldpwmoVaQIk0ag6TA==
X-Received: by 2002:a05:6000:18c2:: with SMTP id w2mr5297081wrq.282.1627682100501;
        Fri, 30 Jul 2021 14:55:00 -0700 (PDT)
Received: from localhost.localdomain ([149.86.78.245])
        by smtp.gmail.com with ESMTPSA id v15sm3210871wmj.39.2021.07.30.14.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 14:55:00 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 7/7] tools: bpftool: complete metrics list in "bpftool prog profile" doc
Date:   Fri, 30 Jul 2021 22:54:35 +0100
Message-Id: <20210730215435.7095-8-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730215435.7095-1-quentin@isovalent.com>
References: <20210730215435.7095-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Profiling programs with bpftool was extended some time ago to support
two new metrics, namely itlb_misses and dtlb_misses (misses for the
instruction/data translation lookaside buffer). Update the manual page
and bash completion accordingly.

Fixes: 450d060e8f75 ("bpftool: Add {i,d}tlb_misses support for bpftool profile")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 3 ++-
 tools/bpf/bpftool/bash-completion/bpftool        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 2ea5df30ff21..91608cb7e44a 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -53,7 +53,8 @@ PROG COMMANDS
 |		**msg_verdict** | **skb_verdict** | **stream_verdict** | **stream_parser** | **flow_dissector**
 |	}
 |	*METRICs* := {
-|		**cycles** | **instructions** | **l1d_loads** | **llc_misses**
+|		**cycles** | **instructions** | **l1d_loads** | **llc_misses** |
+|		**itlb_misses** | **dtlb_misses**
 |	}
 
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 134135424e7f..88e2bcf16cca 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -345,7 +345,8 @@ _bpftool()
 
             local PROG_TYPE='id pinned tag name'
             local MAP_TYPE='id pinned name'
-            local METRIC_TYPE='cycles instructions l1d_loads llc_misses'
+            local METRIC_TYPE='cycles instructions l1d_loads llc_misses \
+                itlb_misses dtlb_misses'
             case $command in
                 show|list)
                     [[ $prev != "$command" ]] && return 0
-- 
2.30.2

