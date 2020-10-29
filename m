Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674E729EF63
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 16:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgJ2PMf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 11:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728150AbgJ2PMe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Oct 2020 11:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603984353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=es+GSQz2MU3igYX62Y5g10wVw6Q1DpGz8rOsY1uqmXw=;
        b=bD7IfCQvyduI3bbso8Vn0p4EeV+h9io+793jV40QKt8x4cGc5KlMglXERTO0XyK+vj71qZ
        JsGWEsvA6rTZNBbRJpXof4om4VsE2Rmai4GONv9ubAm2bZUlX1QYLgg8hbphMr/WXsmb//
        ynUipQnyiGoE8xxD4R7M7LMsO8B+qes=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-qyaMri6AOxWU6bWIS49fQA-1; Thu, 29 Oct 2020 11:12:31 -0400
X-MC-Unique: qyaMri6AOxWU6bWIS49fQA-1
Received: by mail-pl1-f198.google.com with SMTP id v4so2224492ply.7
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 08:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=es+GSQz2MU3igYX62Y5g10wVw6Q1DpGz8rOsY1uqmXw=;
        b=KUgnlnWHtF1gGyTzXrib/XLM5cjzantkEDb2mHcco/xVBFvxg0R1Iw3gRMfpCynbPt
         aCAmvw3vdUtOrlPuthZCBgI4XYNdc75poA/fm0kTcdVkBuoM8CgFvWD9qdK7AeqO0Hhc
         JnPYUV3XsHbwNZxdl5UQbDVZaOcpfju03Iyxp4Kf868ARp7MUBFxREF3CRmPRHGIvPWD
         yGnS0KVgaJ4WQLVrT5b6KoMTgMzIgo7Xlc8LDYLsSFyjfTkp2DmkQUkFQuV5ddgNkHPY
         buggQ5Mr2Omvu7jSRaVJcLE/7wxz9TP0IGjaqsarYZIt9J0HttPy5BTsvAMCngmloeYr
         VxFA==
X-Gm-Message-State: AOAM532fumW7RVacIzjAp0hsn9FXRxQJ+rlJu7+TvJ+8TGrc5rhZ/KqT
        6yCYWsDJYXHcfWJLSWiJ/TtbpUoQmY0bZhjwSeraEnGU5cXflPzw03K0tEH37K5AnMarIAhmh9B
        0L6XmjrZE+NE=
X-Received: by 2002:a62:585:0:b029:163:b618:92c1 with SMTP id 127-20020a6205850000b0290163b61892c1mr4841629pff.41.1603984349883;
        Thu, 29 Oct 2020 08:12:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/5Kb+4uI6WiCTVSisrCpREodAXzCjRu4dUoWp0BaRpwM+frtkiJ9tiClFBReOaejIeHWWCQ==
X-Received: by 2002:a62:585:0:b029:163:b618:92c1 with SMTP id 127-20020a6205850000b0290163b61892c1mr4841571pff.41.1603984349219;
        Thu, 29 Oct 2020 08:12:29 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 3sm3305435pfv.92.2020.10.29.08.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:12:28 -0700 (PDT)
From:   Hangbin Liu <haliu@redhat.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Hangbin Liu <haliu@redhat.com>
Subject: [PATCHv3 iproute2-next 4/5] examples/bpf: move struct bpf_elf_map defined maps to legacy folder
Date:   Thu, 29 Oct 2020 23:11:45 +0800
Message-Id: <20201029151146.3810859-5-haliu@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201029151146.3810859-1-haliu@redhat.com>
References: <20201028132529.3763875-1-haliu@redhat.com>
 <20201029151146.3810859-1-haliu@redhat.com>
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

