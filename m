Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937EE26CFDE
	for <lists+bpf@lfdr.de>; Thu, 17 Sep 2020 02:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgIQASB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 20:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIQASA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 20:18:00 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:18:00 EDT
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8836EC061788;
        Wed, 16 Sep 2020 17:08:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so278752pgl.10;
        Wed, 16 Sep 2020 17:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Na9A930XnJjifMT8ZHNAvuKYoJPnmdw7X5EjcY4GoqM=;
        b=RmJlwLrTYhvd51TSGpjqRixx9s+/rFs3rOKnJtMPoG5DNNUh6Z++hIYiRWVMqrHsU0
         ZlYBR/I4v8f6JQsGCMyLg/tZ98oiVf3aMVGYNIO/XqlrVmbUvPGyeO5YHCnpY7BDZkiJ
         SBhG7dB+7Ogp5Bf7JyvOK6gRPB78H28J35zqfJYVHsbT4NrJ9Jq4syr+Pw28i2bonZkj
         nDEKRKolvVvPOjTkZFstsLB4uNumBC+Hjy0jRnnZPMDDxWrSBFtH02UvlNeb2sgNo42Y
         my+AKtRpfgMx52z5VfePbVNCQga2wAy2jq/TLJarcmwTh66Mx4EvF5I7f67yG2QKnqHa
         JIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Na9A930XnJjifMT8ZHNAvuKYoJPnmdw7X5EjcY4GoqM=;
        b=Xohd0ZHQ/LcK+HmYCP3RiiTsPCJo9dOIs14+/RGPSEbroFlPUzstlBET3+oocT8yk9
         HIqZX1oKbM4HGc0dPcn5lQBV+9ciqm3RYwEuieM64bEk8Lfz/qbf9pcsa+BeDOuDZU/U
         1A2luA+lB/kTum60vc2FAIsDNwhkXpp6xu8fB6zlVx/OZqJlODtzG3O0TtX5FWWw7tJW
         REyEUug1D2OyN7sESmm68095kTlUcjVGxpBUyh8ilNFL//h6KN2lvk6Dbs3Co6Jfco6I
         rFnEPF/qRv93Ywqm15Xby1TrcNgZ2DUdAp99Cz6c0dU4nxmI/xbFi+Y5xv35YvAvXzzx
         Irpg==
X-Gm-Message-State: AOAM533hpYtzkZTx6FXUpbzs9RDEFcZe9IuhkWlBJcbHcFGpTYzee80T
        wXv+8uLgqC02+1C0aRXXiO4=
X-Google-Smtp-Source: ABdhPJz1qpB9CoFcw5mzJ0L2g1fQqPftTDPav38YlicRSdcMy4AS+soddUEEi9bBAkBrY8QxF8Cq8w==
X-Received: by 2002:a65:6888:: with SMTP id e8mr3241834pgt.375.1600301298990;
        Wed, 16 Sep 2020 17:08:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:e92d:10:68d8:fab6:907:5cf6])
        by smtp.gmail.com with ESMTPSA id a13sm14300343pfl.184.2020.09.16.17.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 17:08:18 -0700 (PDT)
From:   Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Tony Ambardar <Tony.Ambardar@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Subject: [PATCH v2] powerpc: fix EDEADLOCK redefinition error in uapi/asm/errno.h
Date:   Wed, 16 Sep 2020 17:07:57 -0700
Message-Id: <20200917000757.1232850-1-Tony.Ambardar@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916074214.995128-1-Tony.Ambardar@gmail.com>
References: <20200916074214.995128-1-Tony.Ambardar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A few archs like powerpc have different errno.h values for macros
EDEADLOCK and EDEADLK. In code including both libc and linux versions of
errno.h, this can result in multiple definitions of EDEADLOCK in the
include chain. Definitions to the same value (e.g. seen with mips) do
not raise warnings, but on powerpc there are redefinitions changing the
value, which raise warnings and errors (if using "-Werror").

Guard against these redefinitions to avoid build errors like the following,
first seen cross-compiling libbpf v5.8.9 for powerpc using GCC 8.4.0 with
musl 1.1.24:

  In file included from ../../arch/powerpc/include/uapi/asm/errno.h:5,
                   from ../../include/linux/err.h:8,
                   from libbpf.c:29:
  ../../include/uapi/asm-generic/errno.h:40: error: "EDEADLOCK" redefined [-Werror]
   #define EDEADLOCK EDEADLK

  In file included from toolchain-powerpc_8540_gcc-8.4.0_musl/include/errno.h:10,
                   from libbpf.c:26:
  toolchain-powerpc_8540_gcc-8.4.0_musl/include/bits/errno.h:58: note: this is the location of the previous definition
   #define EDEADLOCK       58

  cc1: all warnings being treated as errors

Fixes: 95f28190aa01 ("tools include arch: Grab a copy of errno.h for arch's supported by perf")
Fixes: c3617f72036c ("UAPI: (Scripted) Disintegrate arch/powerpc/include/asm")
Reported-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
---
v1 -> v2:
 * clean up commit description formatting
---
 arch/powerpc/include/uapi/asm/errno.h       | 1 +
 tools/arch/powerpc/include/uapi/asm/errno.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/errno.h b/arch/powerpc/include/uapi/asm/errno.h
index cc79856896a1..4ba87de32be0 100644
--- a/arch/powerpc/include/uapi/asm/errno.h
+++ b/arch/powerpc/include/uapi/asm/errno.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_POWERPC_ERRNO_H
 #define _ASM_POWERPC_ERRNO_H
 
+#undef	EDEADLOCK
 #include <asm-generic/errno.h>
 
 #undef	EDEADLOCK
diff --git a/tools/arch/powerpc/include/uapi/asm/errno.h b/tools/arch/powerpc/include/uapi/asm/errno.h
index cc79856896a1..4ba87de32be0 100644
--- a/tools/arch/powerpc/include/uapi/asm/errno.h
+++ b/tools/arch/powerpc/include/uapi/asm/errno.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_POWERPC_ERRNO_H
 #define _ASM_POWERPC_ERRNO_H
 
+#undef	EDEADLOCK
 #include <asm-generic/errno.h>
 
 #undef	EDEADLOCK
-- 
2.25.1

