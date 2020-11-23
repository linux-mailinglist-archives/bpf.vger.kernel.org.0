Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9F12C09E8
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 14:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbgKWNOB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 08:14:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388559AbgKWNNk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Nov 2020 08:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606137218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=es+GSQz2MU3igYX62Y5g10wVw6Q1DpGz8rOsY1uqmXw=;
        b=gKcdZHjO1TnH0QLzjU0TGg6XEr+x+n6fbczfVuzTNa4DK/GW2hSgn6/BQjR4FemsXCklgS
        GAITmsKNBqhylV7/KBtJH4vLMjwiug1RNTv8pGcmhSMNeXqX7Wf+tmeRpXFIjxZYBayAEA
        k5TuFlfZWocJl5iYy+mwcIyimkSHCMw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-HIq93tSdOO2P065KEbX7pg-1; Mon, 23 Nov 2020 08:13:36 -0500
X-MC-Unique: HIq93tSdOO2P065KEbX7pg-1
Received: by mail-pf1-f199.google.com with SMTP id v2so12703908pfi.11
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 05:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=es+GSQz2MU3igYX62Y5g10wVw6Q1DpGz8rOsY1uqmXw=;
        b=EFnkOe9hJzazYxrRggTabeL8bR1t3MUy/1VQJkmZZnetTc2bprxePAyGww/KwaWKUB
         S0blRmXi3tcqnY8UFeAiKSD7Y4ncgOC7qST1pF6rPeLV3GvRl8CKCpKJN2EfOEo0fOMG
         MB32TVe8QPSja+0hCLd1w+095HEaTqsCJY1/RYzhizdJiqOFzlkXuuI0Wdt9tuDKGFcT
         vgfSma3ly2feaGzAcnwaWhQReRvmA+hZD3/OSQ0/aZFRiE+jRUEh9OyI6icIvmVjOR97
         ZHXYjy42ZS7/HniHPSo1nChjgVoTXBAbdnaFSRtSdJrkduGtkNo9Jtp3xnWOneqdK4S8
         WsmQ==
X-Gm-Message-State: AOAM533DQOXh9C1N8ZGqF8hGCKL/dSRpup9Jh/EvEGNpBqvrJvotm9r8
        Rj6yacgQq3+LNEE3FLPgyo3QxQ1Ecbgx2+cijK/HR8LJCiY72Us/k3MQ8MMRWPLXg4Ql0D1dief
        A0MNVlJylU1U=
X-Received: by 2002:a65:5588:: with SMTP id j8mr27014282pgs.245.1606137214553;
        Mon, 23 Nov 2020 05:13:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNAS1DOyVHPl2ZmtTO7x07AfiymOEs/m9uJIgk9I9nSJ7qXj5gIpYpa9FRA6tsXohvYHNqXQ==
X-Received: by 2002:a65:5588:: with SMTP id j8mr27014271pgs.245.1606137214318;
        Mon, 23 Nov 2020 05:13:34 -0800 (PST)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 84sm12075505pfu.53.2020.11.23.05.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 05:13:33 -0800 (PST)
From:   Hangbin Liu <haliu@redhat.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        David Ahern <dsahern@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hangbin Liu <haliu@redhat.com>
Subject: [PATCHv6 iproute2-next 4/5] examples/bpf: move struct bpf_elf_map defined maps to legacy folder
Date:   Mon, 23 Nov 2020 21:12:00 +0800
Message-Id: <20201123131201.4108483-5-haliu@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201123131201.4108483-1-haliu@redhat.com>
References: <20201116065305.1010651-1-haliu@redhat.com>
 <20201123131201.4108483-1-haliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Hangbin Liu <haliu@redhat.com>
---
 examples/bpf/README                        | 14 +++++++++-----
 examples/bpf/{ => legacy}/bpf_cyclic.c     |  2 +-
 examples/bpf/{ => legacy}/bpf_graft.c      |  2 +-
 examples/bpf/{ => legacy}/bpf_map_in_map.c |  2 +-
 examples/bpf/{ => legacy}/bpf_shared.c     |  2 +-
 examples/bpf/{ => legacy}/bpf_tailcall.c   |  2 +-
 6 files changed, 14 insertions(+), 10 deletions(-)
 rename examples/bpf/{ => legacy}/bpf_cyclic.c (95%)
 rename examples/bpf/{ => legacy}/bpf_graft.c (97%)
 rename examples/bpf/{ => legacy}/bpf_map_in_map.c (96%)
 rename examples/bpf/{ => legacy}/bpf_shared.c (97%)
 rename examples/bpf/{ => legacy}/bpf_tailcall.c (98%)

diff --git a/examples/bpf/README b/examples/bpf/README
index 1bbdda3f..732bcc83 100644
--- a/examples/bpf/README
+++ b/examples/bpf/README
@@ -1,8 +1,12 @@
 eBPF toy code examples (running in kernel) to familiarize yourself
 with syntax and features:
 
- - bpf_shared.c		-> Ingress/egress map sharing example
- - bpf_tailcall.c	-> Using tail call chains
- - bpf_cyclic.c		-> Simple cycle as tail calls
- - bpf_graft.c		-> Demo on altering runtime behaviour
- - bpf_map_in_map.c     -> Using map in map example
+ - legacy/bpf_shared.c		-> Ingress/egress map sharing example
+ - legacy/bpf_tailcall.c	-> Using tail call chains
+ - legacy/bpf_cyclic.c		-> Simple cycle as tail calls
+ - legacy/bpf_graft.c		-> Demo on altering runtime behaviour
+ - legacy/bpf_map_in_map.c	-> Using map in map example
+
+Note: Users should use new BTF way to defined the maps, the examples
+in legacy folder which is using struct bpf_elf_map defined maps is not
+recommanded.
diff --git a/examples/bpf/bpf_cyclic.c b/examples/bpf/legacy/bpf_cyclic.c
similarity index 95%
rename from examples/bpf/bpf_cyclic.c
rename to examples/bpf/legacy/bpf_cyclic.c
index 11d1c061..33590730 100644
--- a/examples/bpf/bpf_cyclic.c
+++ b/examples/bpf/legacy/bpf_cyclic.c
@@ -1,4 +1,4 @@
-#include "../../include/bpf_api.h"
+#include "../../../include/bpf_api.h"
 
 /* Cyclic dependency example to test the kernel's runtime upper
  * bound on loops. Also demonstrates on how to use direct-actions,
diff --git a/examples/bpf/bpf_graft.c b/examples/bpf/legacy/bpf_graft.c
similarity index 97%
rename from examples/bpf/bpf_graft.c
rename to examples/bpf/legacy/bpf_graft.c
index 07113d4a..f4c920cc 100644
--- a/examples/bpf/bpf_graft.c
+++ b/examples/bpf/legacy/bpf_graft.c
@@ -1,4 +1,4 @@
-#include "../../include/bpf_api.h"
+#include "../../../include/bpf_api.h"
 
 /* This example demonstrates how classifier run-time behaviour
  * can be altered with tail calls. We start out with an empty
diff --git a/examples/bpf/bpf_map_in_map.c b/examples/bpf/legacy/bpf_map_in_map.c
similarity index 96%
rename from examples/bpf/bpf_map_in_map.c
rename to examples/bpf/legacy/bpf_map_in_map.c
index ff0e623a..575f8812 100644
--- a/examples/bpf/bpf_map_in_map.c
+++ b/examples/bpf/legacy/bpf_map_in_map.c
@@ -1,4 +1,4 @@
-#include "../../include/bpf_api.h"
+#include "../../../include/bpf_api.h"
 
 #define MAP_INNER_ID	42
 
diff --git a/examples/bpf/bpf_shared.c b/examples/bpf/legacy/bpf_shared.c
similarity index 97%
rename from examples/bpf/bpf_shared.c
rename to examples/bpf/legacy/bpf_shared.c
index 21fe6f1e..05b2b9ef 100644
--- a/examples/bpf/bpf_shared.c
+++ b/examples/bpf/legacy/bpf_shared.c
@@ -1,4 +1,4 @@
-#include "../../include/bpf_api.h"
+#include "../../../include/bpf_api.h"
 
 /* Minimal, stand-alone toy map pinning example:
  *
diff --git a/examples/bpf/bpf_tailcall.c b/examples/bpf/legacy/bpf_tailcall.c
similarity index 98%
rename from examples/bpf/bpf_tailcall.c
rename to examples/bpf/legacy/bpf_tailcall.c
index 161eb606..8ebc554c 100644
--- a/examples/bpf/bpf_tailcall.c
+++ b/examples/bpf/legacy/bpf_tailcall.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include "../../include/bpf_api.h"
+#include "../../../include/bpf_api.h"
 
 #define ENTRY_INIT	3
 #define ENTRY_0		0
-- 
2.25.4

