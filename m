Return-Path: <bpf+bounces-6738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6632B76D6C7
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 20:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AFD1C210CF
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AA3101F5;
	Wed,  2 Aug 2023 18:22:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B476100BE
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 18:22:29 +0000 (UTC)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851A21FEE
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 11:22:26 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-44775f7c9c2so18453137.1
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691000545; x=1691605345;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gPPFT121vNHDU/pM1ani47mySS3aZCCRCK106rYkS1M=;
        b=GaUtIMxcKbGYKf9TW+9bWC6yWsXUK/WGpYXWlTZLqKpJFn+f+Wh1/51JobGqvSG2Gc
         KvkkpkbE9yEWy4fX3gcurm28G9G7QUZXcsh1XM0jR3qiRsFGhIbpTV9H4y/P+qmssOzS
         wTEBBtd/r3a3WcSAzNrRPDflLOj5mwJr6Fns8Tf6qzjhnCXL9wRV1J2uEDfmBQtXTWMl
         nmgJW+nh34GaETNMhIr7s2lCu9vzU+NbcePuzRNHqsdrokTCbc+s+RPSskcdtZoms25X
         KmqRsKBkiLvAkEvK3oVqg72bcLq/QSM7a9V+iBIRvguj6Ed0MBxorohVXGpDQHBwLR7q
         HVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691000545; x=1691605345;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPPFT121vNHDU/pM1ani47mySS3aZCCRCK106rYkS1M=;
        b=Za4DRHqY26Xf/RzYIUXXEXwhqfa600lL1RZH3wOAHD/yopL7Y+iatkExjeMKqE2JR3
         fUmqoq+YxY/SZWChwsB8JjJ2IQ5VkFKVieyxoJUqDjYRPTOvRkumtPROSrVgLfOhZN2l
         uIYDe6rLSv5gmD4+52dLP64pMgz/li6FRhAoPEDjb1SG2DQbthlq9pRPcHEf65+s1FFD
         wmc1td6qfglxGb+mj/qFxZBLqwl9pB4Aflu0z71D4qE9SYz/cWLOZVAJcnEgsPylVvP3
         T0bHmnRMIMk8REeHbjlplK26Op/PaaY3Hl+1Lcbbzwbqqn3xa4DpAuM1xAJRPPqMfRpV
         HscA==
X-Gm-Message-State: ABy/qLbGM/VYkBbo2JwXzeAXMVAN9A1G64XswNUl1EZCZV0orRZS88Hu
	VFdiQdksjiFwF2w34VaCmZxiM6JiSoRL1RoaDKg4HiY/cqKh1A==
X-Google-Smtp-Source: APBJJlHDxG4863faAOjhkGMS+4KkLp+DAggrgcAAfvMqzR80Vnyf33mUdViXySaet70su1Ql6Lln799o6HVVT6LqNj0=
X-Received: by 2002:a05:6102:3134:b0:440:b763:a69d with SMTP id
 f20-20020a056102313400b00440b763a69dmr5988261vsh.2.1691000545454; Wed, 02 Aug
 2023 11:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sergey Kacheev <s.kacheev@gmail.com>
Date: Wed, 2 Aug 2023 21:22:14 +0300
Message-ID: <CAJVhQqUg6OKq6CpVJP5ng04Dg+z=igevPpmuxTqhsR3dKvd9+Q@mail.gmail.com>
Subject: [PATCH v3 bpf-next] libbpf: Use local includes inside the library
To: bpf@vger.kernel.org, yonghong.song@linux.dev, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In our monrepo, we try to minimize special processing when importing
(aka vendor) third-party source code. Ideally, we try to import
directly from the repositories with the code without changing it, we
try to stick to the source code dependency instead of the artifact
dependency. In the current situation, a patch has to be made for
libbpf to fix the includes in bpf headers so that they work directly
from libbpf/src.

Signed-off-by: Sergey Kacheev <s.kacheev@gmail.com>
---
Changes from v2:
- add commit message
Reference:
- v2: https://lore.kernel.org/bpf/CAJVhQqW6nvWFozMOVQ=_sUTRwVjsQL+G2yCyd91c0bjsc7PcGA@mail.gmail.com/
---
 tools/lib/bpf/bpf_tracing.h | 2 +-
 tools/lib/bpf/usdt.bpf.h    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index be076a404..3803479db 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -2,7 +2,7 @@
 #ifndef __BPF_TRACING_H__
 #define __BPF_TRACING_H__

-#include <bpf/bpf_helpers.h>
+#include "bpf_helpers.h"

 /* Scan the ARCH passed in from ARCH env variable (see Makefile) */
 #if defined(__TARGET_ARCH_x86)
diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 0bd4c135a..f6763300b 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -4,8 +4,8 @@
 #define __USDT_BPF_H__

 #include <linux/errno.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
+#include "bpf_helpers.h"
+#include "bpf_tracing.h"

 /* Below types and maps are internal implementation details of libbpf's USDT
  * support and are subjects to change. Also, bpf_usdt_xxx() API helpers should
--
2.39.2

