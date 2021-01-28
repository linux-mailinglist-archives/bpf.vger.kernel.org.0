Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB253080D6
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 22:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhA1VyG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 16:54:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229658AbhA1Vxx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Jan 2021 16:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611870747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rsyMqC4CGpSrbq8fZHJBPoIuBeLjX3/iwFgMD8raUOc=;
        b=hC0pSkuH5N1S5/jg5X+pWv8uG3cAqvtQCeSq8QzN38guWuLjpt+RM3ULi2w4xusEQ0mkDn
        eUpL09hDwbMG/Eq6EqVYK10RGCFNOQPXP2ffOoH3ya2xpDh7wa8yNaipIW40Z1AvwI0MfB
        qfCdB1T0q5C3AO3Ctk1UfyJXk/NT3w8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-biDN6Do_OoO5uxyDG6bjsw-1; Thu, 28 Jan 2021 16:52:23 -0500
X-MC-Unique: biDN6Do_OoO5uxyDG6bjsw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 265153938B;
        Thu, 28 Jan 2021 21:52:22 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DDEE722C1;
        Thu, 28 Jan 2021 21:52:20 +0000 (UTC)
Date:   Thu, 28 Jan 2021 15:52:19 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Masami Hiramatsu <masami.hiramatsu@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] x86: Disable CET instrumentation in the kernel
Message-ID: <20210128215219.6kct3h2eiustncws@treble>
References: <25cd2608-03c2-94b8-7760-9de9935fde64@suse.com>
 <20210128001353.66e7171b395473ef992d6991@kernel.org>
 <20210128002452.a79714c236b69ab9acfa986c@kernel.org>
 <a35a6f15-9ab1-917c-d443-23d3e78f2d73@suse.com>
 <20210128103415.d90be51ec607bb6123b2843c@kernel.org>
 <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
 <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com>
 <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <20210128165014.xc77qtun6fl2qfun@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128165014.xc77qtun6fl2qfun@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


With retpolines disabled, some configurations of GCC will add Intel CET
instrumentation to the kernel by default.  That breaks certain tracing
scenarios by adding a superfluous ENDBR64 instruction before the fentry
call, for functions which can be called indirectly.

CET instrumentation isn't currently necessary in the kernel, as CET is
only supported in user space.  Disable it unconditionally.

Reported-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Makefile          | 6 ------
 arch/x86/Makefile | 3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index e0af7a4a5598..51c2bf34142d 100644
--- a/Makefile
+++ b/Makefile
@@ -948,12 +948,6 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 
-# ensure -fcf-protection is disabled when using retpoline as it is
-# incompatible with -mindirect-branch=thunk-extern
-ifdef CONFIG_RETPOLINE
-KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
-endif
-
 # include additional Makefiles when needed
 include-y			:= scripts/Makefile.extrawarn
 include-$(CONFIG_KASAN)		+= scripts/Makefile.kasan
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 32dcdddc1089..109c7f86483c 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -120,6 +120,9 @@ else
 
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel
+
+	# Intel CET isn't enabled in the kernel
+	KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
 endif
 
 ifdef CONFIG_X86_X32
-- 
2.29.2

