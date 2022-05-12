Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94A4524734
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 09:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351119AbiELHnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 03:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351134AbiELHne (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 03:43:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37D11A15E7
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:32 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BMwXVt001493
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6PzZtwtkyGw1OymYz5QIx2ffqoI45o6QapmsF74wml0=;
 b=KxcpH/ilOKlo7oCmcNK0VSPBeCZRnzZ3lxxzXcw1PQtsoNXfJOhM/LC13L90+vuqHJrt
 LAbJaZKMeOwVhX5502ToyCeujFhHGLRAL6slTqrFa0BAGQg1wtQTu8yVkZa9X2amHCH7
 ud0ZUj+4dBnOWuyYU+pYVW+EOw+jYLr/WQg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fymp4qjn3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 00:43:32 -0700
Received: from twshared25848.02.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 00:43:31 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id B4C7278F7CC5; Thu, 12 May 2022 00:43:27 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 1/5] x86/fpu: Move context.h to include/asm
Date:   Thu, 12 May 2022 00:43:17 -0700
Message-ID: <20220512074321.2090073-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220512074321.2090073-1-davemarchevsky@fb.com>
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: XaYxzZUPieh5ap9br9GTHOd7Orc66jAH
X-Proofpoint-ORIG-GUID: XaYxzZUPieh5ap9br9GTHOd7Orc66jAH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_01,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The file's fpregs_state_valid function is useful outside of
arch/x86/kernel/fpu dir. Further commits in this series use
fpregs_state_valid to determine whether a BPF helper should fetch
fpu reg value from xsave'd memory or register.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 arch/x86/{kernel =3D> include/asm}/fpu/context.h | 2 ++
 arch/x86/kernel/fpu/core.c                     | 2 +-
 arch/x86/kernel/fpu/regset.c                   | 2 +-
 arch/x86/kernel/fpu/signal.c                   | 2 +-
 arch/x86/kernel/fpu/xstate.c                   | 2 +-
 5 files changed, 6 insertions(+), 4 deletions(-)
 rename arch/x86/{kernel =3D> include/asm}/fpu/context.h (96%)

diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/include/asm/fpu/con=
text.h
similarity index 96%
rename from arch/x86/kernel/fpu/context.h
rename to arch/x86/include/asm/fpu/context.h
index 958accf2ccf0..39dac18cd22c 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/include/asm/fpu/context.h
@@ -51,6 +51,8 @@ static inline void fpregs_activate(struct fpu *fpu)
 	trace_x86_fpu_regs_activated(fpu);
 }
=20
+extern void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mas=
k);
+
 /* Internal helper for switch_fpu_return() and signal frame setup */
 static inline void fpregs_restore_userregs(void)
 {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index c049561f373a..5296112d4273 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -7,6 +7,7 @@
  *	Gareth Hughes <gareth@valinux.com>, May 2000
  */
 #include <asm/fpu/api.h>
+#include <asm/fpu/context.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/sched.h>
 #include <asm/fpu/signal.h>
@@ -18,7 +19,6 @@
 #include <linux/pkeys.h>
 #include <linux/vmalloc.h>
=20
-#include "context.h"
 #include "internal.h"
 #include "legacy.h"
 #include "xstate.h"
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 75ffaef8c299..f93336f332e3 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -6,10 +6,10 @@
 #include <linux/vmalloc.h>
=20
 #include <asm/fpu/api.h>
+#include <asm/fpu/context.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
=20
-#include "context.h"
 #include "internal.h"
 #include "legacy.h"
 #include "xstate.h"
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 91d4b6de58ab..f099a56c9a93 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/pagemap.h>
=20
+#include <asm/fpu/context.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/xstate.h>
@@ -15,7 +16,6 @@
 #include <asm/trapnr.h>
 #include <asm/trace/fpu.h>
=20
-#include "context.h"
 #include "internal.h"
 #include "legacy.h"
 #include "xstate.h"
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 39e1c8626ab9..ab5e26075716 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -15,6 +15,7 @@
 #include <linux/vmalloc.h>
=20
 #include <asm/fpu/api.h>
+#include <asm/fpu/context.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/xcr.h>
@@ -23,7 +24,6 @@
 #include <asm/prctl.h>
 #include <asm/elf.h>
=20
-#include "context.h"
 #include "internal.h"
 #include "legacy.h"
 #include "xstate.h"
--=20
2.30.2

