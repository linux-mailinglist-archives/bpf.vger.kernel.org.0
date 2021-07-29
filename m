Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5882E3DA913
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 18:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhG2Q34 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 12:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhG2Q3w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 12:29:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3661C061765
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 09:29:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n28-20020a05600c3b9cb02902552e60df56so4431522wms.0
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fc+7RwYnjdQczVrAOaEk6yAXkkOw0SL9ZR500UN4OHs=;
        b=cZqx4pfCSl2Qs6vBSXYE07eN7BXk6chw5uIrB8P6F9qFok+hHRcoch0p51SaVLm8lS
         6uf8KUrM48BVocBLvXzQAuIPa93keLBjcbTrlgqSRQyX7qAY57s05P1hos9N3RyweanJ
         Z3H1k+MfvwTJqysS3h1jMlo+DgTss2FqluqMVplRBv44XZEZkrLtT+ZDNjHjpVKNWHmv
         SeaE5kxukgiNkNcskdG8Z7zkABbpFoNukAm4jZruQciVDBxzEbNfn4XFGF55lvkrYNZ5
         EYe2Zb8Q8k17eMvdYkKEPheaSuJj2lf8qCJs1DPQVjfg/nvxb/FRYEoZV3nQCGUSCXtf
         GZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fc+7RwYnjdQczVrAOaEk6yAXkkOw0SL9ZR500UN4OHs=;
        b=kiUujDaLfFE9t1Gc3dYPEqNOEebWRwBJj2NxazDvbbTR5XsfB0HtDGjqY9mtNU71/D
         eyAMmW7dJW1B+ay6dc2p5k/J2AvQCBcR6hnmGVkuRlOJSq7Wz4bDc60bxTdgWrEQ5du+
         lMFjGlUrvFvEVwp7aUloBHd4BXcsuBmGAnEO+GkzGRmFkJmz8PMBnxKTAEexky7EdFDC
         9KwWxTjZHeCX4Ke/a4NcDIIyrePxYJykmE19ut4HV/XFMvtRAOCzDqm8GtSUbUtnxYUe
         QS0Uqxo4rsjHYA5wDZb+AZTU84YnIMuS1Ka2DKsl0U5nLfFGs9OnSobplb8T28KxC8oz
         dTmw==
X-Gm-Message-State: AOAM532emvX4P95KcpkB/m/liox7SafQHRjWVurXcjG4RG/3+K20uFqw
        lOHegiwpNCNIjYdgf8Qq8dqyXA==
X-Google-Smtp-Source: ABdhPJwAs/gG6cf6c5K+lCBTXUDkoXxJXh99JfX3r0FFJo4HxQdJzDqMt1VSGXiciqEC2nFC47uAgg==
X-Received: by 2002:a7b:c84e:: with SMTP id c14mr2585105wml.94.1627576187540;
        Thu, 29 Jul 2021 09:29:47 -0700 (PDT)
Received: from localhost.localdomain ([149.86.75.13])
        by smtp.gmail.com with ESMTPSA id 140sm3859331wmb.43.2021.07.29.09.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:29:46 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 7/7] tools: bpftool: complete metrics list in "bpftool prog profile" doc
Date:   Thu, 29 Jul 2021 17:29:32 +0100
Message-Id: <20210729162932.30365-8-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729162932.30365-1-quentin@isovalent.com>
References: <20210729162932.30365-1-quentin@isovalent.com>
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
index d33b8f308a4c..17a5032b7325 100644
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

