Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0B5D35E7
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 02:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfJKA2v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 20:28:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44933 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfJKA2m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so7990330ljj.11
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 17:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pOlOkzzU0bwqDGQkGWa87uAZFQ6B6XzFeEn3c66o8lU=;
        b=QHN9i8ukUhuJBaTW1UkwsHCf7J5j7HE4qIMcwKRdrirpcaAonzp03YiEqPSRwe3zx/
         xA0MoKbGih4p4DFXZwDwFBVobJyP2faVBo7sSRFrH+xMkpC/PIjgjau5tDOW+sFmwLwz
         g1hsnFO0QNDJkY3FkwUuMwhUKVchwkKKVMSTy0IBQDH2rghXK2Kb+YMjb+e9v4KFDu0l
         5++1qegXGXuL7utw193IWXAe67LN2wicnj/KIR+LUI+F5L2i9Y7eBDqDrS+Yn4GQu+Dy
         0MUQU2rjtqKV6psnZKCzGon4ksn3ln70MKD8EGIAdfYhyEuOTccCJajTz1HJ7wxhCkN3
         Ez7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pOlOkzzU0bwqDGQkGWa87uAZFQ6B6XzFeEn3c66o8lU=;
        b=FNPj/TRBP2gnsZkS3uDci9NWDJXwowLgyMuJr2z5Hpjiyte+2hEDPpifycOmYyBl3k
         in4yabrHksEBdU9N3+stp0KA4gYitHCX+Gd+x7rikMNcej+TvusO4ifv0gQairoGJ66p
         DnDt7K+8cudsTMPq/dY4FpTvo+a4LTew2UVszBSuoHwmrCUKc/G302sRBjs1ICbfWJ/i
         z+Vq5iSyY0wr2eX/vs+yajTdJLJIePbhhvndnDcVAPX3TIQrpzb30ycU94/lL6UTV5yD
         q1p1u5Mr9Yv7PpBuhz+NlkFKhU9zgIOzj4kjF3LLTanQVQWjlKSNA+pglmD/VsjaP8oC
         FphA==
X-Gm-Message-State: APjAAAXrPYA4C2cWwvobcjvLhEevgp6ylqs0zzU7q+Jl139OFxzxWMZR
        USgZOelEmf3jzNpjspdYpPGerg==
X-Google-Smtp-Source: APXvYqx/hZhkYlHMDs/0fYgLREAPdm0Rklj16fXnm+aBEBcqoa/exgzworlTmmiIrWj0rsP8Zh/sXw==
X-Received: by 2002:a2e:a0ca:: with SMTP id f10mr7479171ljm.83.1570753721062;
        Thu, 10 Oct 2019 17:28:41 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:40 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 15/15] samples/bpf: add preparation steps and sysroot info to readme
Date:   Fri, 11 Oct 2019 03:28:08 +0300
Message-Id: <20191011002808.28206-16-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add couple preparation steps: clean and configuration. Also add newly
added sysroot support info to cross-compile section.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/README.rst | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
index 5f27e4faca50..cc1f00a1ee06 100644
--- a/samples/bpf/README.rst
+++ b/samples/bpf/README.rst
@@ -14,6 +14,20 @@ Compiling requires having installed:
 Note that LLVM's tool 'llc' must support target 'bpf', list version
 and supported targets with command: ``llc --version``
 
+Clean and configuration
+-----------------------
+
+It can be needed to clean tools, samples or kernel before trying new arch or
+after some changes (on demand)::
+
+ make -C tools clean
+ make -C samples/bpf clean
+ make clean
+
+Configure kernel, defconfig for instance::
+
+ make defconfig
+
 Kernel headers
 --------------
 
@@ -68,9 +82,26 @@ It is also possible to point make to the newly compiled 'llc' or
 Cross compiling samples
 -----------------------
 In order to cross-compile, say for arm64 targets, export CROSS_COMPILE and ARCH
-environment variables before calling make. This will direct make to build
-samples for the cross target.
+environment variables before calling make. But do this before clean,
+cofiguration and header install steps described above. This will direct make to
+build samples for the cross target::
+
+ export ARCH=arm64
+ export CROSS_COMPILE="aarch64-linux-gnu-"
+
+Headers can be also installed on RFS of target board if need to keep them in
+sync (not necessarily and it creates a local "usr/include" directory also)::
+
+ make INSTALL_HDR_PATH=~/some_sysroot/usr headers_install
+
+Pointing LLC and CLANG is not necessarily if it's installed on HOST and have
+in its targets appropriate arm64 arch (usually it has several arches).
+Build samples::
+
+ make samples/bpf/
+
+Or build samples with SYSROOT if some header or library is absent in toolchain,
+say libelf, providing address to file system containing headers and libs,
+can be RFS of target board::
 
-export ARCH=arm64
-export CROSS_COMPILE="aarch64-linux-gnu-"
-make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
+ make samples/bpf/ SYSROOT=~/some_sysroot
-- 
2.17.1

