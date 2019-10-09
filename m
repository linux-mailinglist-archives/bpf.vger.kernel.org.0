Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A89D19E5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 22:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbfJIUmE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 16:42:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38716 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732199AbfJIUmD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 16:42:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id u28so2674170lfc.5
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 13:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ECSs+mjX4lDFe4jfV4JTbgbugRRkkd9F4zfelRgHKxE=;
        b=gUjn/S2efuOPXmg3rQVYqpqdFW0SwsiG98P30JRwuBNr6WxKw3KU9N6YZ+brp2Q7Rd
         yfWuTtm1rFWLipf/NFrIMqUZi4qgcP+w1Za6uCOhZZC5hfk1Ocy1Dq1gZnWHceFsFoOV
         9qnp8T9CUpAj/ngzQcF64dHtvm0D5vxtMtGczAS+nruCR1F5UdNIjKIHnqsNXMuUyL7X
         K0QH97/eIi6y08cd85YikZx/iA7vIJqNUxY4yUr038zamFrjak8kxDXCndocS12+8DxD
         Wkkc7pgTqA7D3wWX2Tw4zrquutTsCaQZwnk0E0M4UyigdMPQ2UtbWvf/0YdkBRBagiOB
         LeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ECSs+mjX4lDFe4jfV4JTbgbugRRkkd9F4zfelRgHKxE=;
        b=NcMaKZAOgTytNqQ+GmeNrgp1z9KBQLeyEeY+WP/rfaXgrhpicEDCP/bOlmIWAR+uDJ
         F0+l3T4MtGGtCZFEKf8a9YnQIrqLuvznslzOgzWVrRWZh2AlWppGqVYeV26OBNelhW9X
         YoBIGMp4DsUQYUe+iCgAR5AnPsQIMxiYe5Kx6YqfxNRGz4vOGtD1GxF4HxNerAlmfJRF
         KTTMQbf2PgPWLh0aclSr8LXaW35sR8biExgTOHDtytef5sJvSWJOtmEWzweNEQ+cof6M
         20GPoAXB3ZPxRuoSvJJkV6mThVUM1y7TiuGHzo1sWt0diSBOlSU5ZcdYoarNrc1K5hh7
         j93w==
X-Gm-Message-State: APjAAAU7EcbLPzEzrkczWDtHDqCOQDckv2/qC5kG3J09AWufWweky+f1
        VcY4xs5SxNwsZTUtcVaJOEeM/w==
X-Google-Smtp-Source: APXvYqxemhdjS6iiJmRG8axkCDMNxDJpIzxqKSgxZS/Hg9GWCN7Oewpb7RM9aQmAbB9f47y/ECq1Tw==
X-Received: by 2002:ac2:533c:: with SMTP id f28mr3247351lfh.77.1570653720287;
        Wed, 09 Oct 2019 13:42:00 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:59 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 15/15] samples/bpf: add preparation steps and sysroot info to readme
Date:   Wed,  9 Oct 2019 23:41:34 +0300
Message-Id: <20191009204134.26960-16-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add couple preparation steps: clean and configuration. Also add newly
added sysroot support info to cross-compile section.
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

