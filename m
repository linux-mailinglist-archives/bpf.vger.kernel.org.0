Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F882B38C2
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2019 12:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfIPKzH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 06:55:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46679 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732585AbfIPKzC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 06:55:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so27019134lfc.13
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2019 03:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sLN8PEIzdXJ4vyRQJpg4LVfYYRixS2x0Ts7jhtzHOWM=;
        b=MhheypW2XDysOKktHNsxSG7LxAVuj81gvn1nIXQCjY3ZjEOWVw64CWPx+TsC7e8i/L
         N3aTKRxdyURBfnZY8cnxzthB0q06sfJEdgrJndGnTTm5DkQ05sqC18szpQVvwPI205JM
         FD5UbVZfrw17pax6P2aNxvYr0kPjRThua9mL+vYGNNZLqWM5aAc2R1FBXyERvpvxhH9Y
         sO3McigyojSgOHI03jFVLTIjTnYlbMcahGt86azSZyWWNsHChJFWikNBqpHmK10qnbhD
         MUjWVDOpY59AA0cDjDtsDASxXF5BF6kAI1VLiq/RWUSorKaA/C3Pq9jt+rQKiEq3xjlk
         8fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sLN8PEIzdXJ4vyRQJpg4LVfYYRixS2x0Ts7jhtzHOWM=;
        b=EdKTInn+iQxSQkxrgr+FGZDeihYHAsxJgvtGdWbINaVKJdz4FnBf8H9wkMOXBsJU/6
         BRrhpiU/cujl2M5CPST3bm16NeW9f3Rmm7PbLIM8p6H3wE5PdoAhwWB7LaP1vzFsor3/
         w17DSWC93Nmf5bSBhxD7hOedSZ2WvffYDchX7Ye0Bp5JrbBnRmH1K1lYcViK34XRlPhF
         jrol/queTdiXB6Vtn0jE8f8nbwGwZjEfZAt+f78MwzxbI/K3B6GHP967RjEwaa5dIYMV
         rS9zr7Y/1gNYZM079h32mRsA5nifO/eCLyNvjLZ69LCF8GQOTzNpx2wOrpjxL0UkCm/N
         ZUfA==
X-Gm-Message-State: APjAAAX1ZZqxozAnfCVp3XY7FebIAs1x7d5MLAn08MPh/zY0nXw22FGr
        qwiyKaDZukUoIY4VqAhNeKbd8A==
X-Google-Smtp-Source: APXvYqy4XqmgKre21JjPHCrnRIiHAk6YzQKm/zoD14WloikJ/3u32TM1a02cS68ct/GlCIZU/MCNQQ==
X-Received: by 2002:a19:4f5a:: with SMTP id a26mr37493210lfk.116.1568631298482;
        Mon, 16 Sep 2019 03:54:58 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:57 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 14/14] samples: bpf: README: add preparation steps and sysroot info
Date:   Mon, 16 Sep 2019 13:54:33 +0300
Message-Id: <20190916105433.11404-15-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
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
index 5f27e4faca50..d5845d73ab7d 100644
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
+Headers can be also installed on RFC of target board if need to keep them in
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

