Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A8136698
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2019 23:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFEVQk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jun 2019 17:16:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41533 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfFEVQk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jun 2019 17:16:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id s57so237449qte.8
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2019 14:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQDQdQt/dl3y/E4Izk8HfsFlcdAzXtXAnj1WW7SvLwY=;
        b=BNZrrin/+TQEnNIcTOWY5uiFGb4IUKe4z8entXuKHupDcxf4/1zK1bM0tlfwNUSM6K
         /w2R3u+9bXtL1pj9U5fmppGsvi5BMiRmGtZUNBy6sTtzSX2FZZNdPPbd+0HFbf/y9T2k
         Ai0hC8pHNywILUOE1+XvEtTABX9j581eyOVxfd9Htl2mvQRn02/7Mv+GugY0cwO1gO1N
         HBxuaW+LxSodaTqlca0aXdDZXiy1XcQGpP4XNFgOKU7IfziuutZ+kxlhAlFgQzmtrWsU
         H6LHxvdm/y02xv8xC6VtBDQur5EbuY/kiusNBn4v0K8Z5U7VCZFgrlTPAoz0xbrPUqUh
         omXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQDQdQt/dl3y/E4Izk8HfsFlcdAzXtXAnj1WW7SvLwY=;
        b=TLJriVK9aZUU4MlI9d5F4mlXTW1D1EcTdq9jI7smr5AcNw3bM7wGgfcZGZH9sXYlGJ
         k3fahIXGL0RCe0rRBM1PP4gj+fKLENHuAv8KwwE1ddpu5fcEAIgn/EF3pPXDw6UjYVTr
         1gjMxOKC36sO1Fa862eo6G0JwNkkfRb9z2bRGxHnhU6h90+PXh+4LqX4iW39GeWChBuZ
         y7qytT86zkjnofO9+cqnPSYLbEK3+GLdwFaQJx/48NDGSKkCPBYUixVUwjweVb5VUb7/
         AX2byW1rz4L4m/peD6af4NmsPyKSzqBiNLr3J8JyVTMV6K57d/3F+0c3T7o2rM4oHxQn
         nKVQ==
X-Gm-Message-State: APjAAAVYXKP5iTOIEotAGp+etGU04++BttXDBDpyLA08zuhkGws1pQz4
        M2ZdpJhEproufhH/u2fo79ZAdA==
X-Google-Smtp-Source: APXvYqxZQaSmgDb+ycV/QJeVR92vZl25SrwxWgGWFzwsc8ES55419LNs26De+1tI6rUfaQ82pVqfFA==
X-Received: by 2002:aed:2a85:: with SMTP id t5mr16430044qtd.26.1559769398467;
        Wed, 05 Jun 2019 14:16:38 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m66sm12680610qkb.12.2019.06.05.14.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 14:16:37 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next] samples: bpf: print a warning about headers_install
Date:   Wed,  5 Jun 2019 14:16:31 -0700
Message-Id: <20190605211631.32387-1-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It seems like periodically someone posts patches to "fix"
header includes.  The issue is that samples expect the
include path to have the uAPI headers (from usr/) first,
and then tools/ headers, so that locally installed uAPI
headers take precedence.  This means that if users didn't
run headers_install they will see all sort of strange
compilation errors, e.g.:

  HOSTCC  samples/bpf/test_lru_dist
  samples/bpf/test_lru_dist.c:39:8: error: redefinition of ‘struct list_head’
   struct list_head {
          ^~~~~~~~~
   In file included from samples/bpf/test_lru_dist.c:9:0:
   ../tools/include/linux/types.h:69:8: note: originally defined here
    struct list_head {
           ^~~~~~~~~

Try to detect this situation, and print a helpful warning.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
---
This has been rotting in my tree, time to take it or leave it :)
---
 samples/bpf/Makefile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 253e5a2856be..9d5e50d24806 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -206,6 +206,17 @@ HOSTCC = $(CROSS_COMPILE)gcc
 CLANG_ARCH_ARGS = -target $(ARCH)
 endif
 
+CC ?= gcc
+
+HDR_PROBE := $(shell echo "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
+	$(CC) $(KBUILD_HOSTCFLAGS) -x c - -o /dev/null 2>/dev/null && \
+	echo okay)
+
+ifeq ($(HDR_PROBE),)
+$(warning WARNING: Detected possible issues with include path.)
+$(warning WARNING: Please install kernel headers locally (make headers_install).)
+endif
+
 BTF_LLC_PROBE := $(shell $(LLC) -march=bpf -mattr=help 2>&1 | grep dwarfris)
 BTF_PAHOLE_PROBE := $(shell $(BTF_PAHOLE) --help 2>&1 | grep BTF)
 BTF_OBJCOPY_PROBE := $(shell $(LLVM_OBJCOPY) --help 2>&1 | grep -i 'usage.*llvm')
-- 
2.21.0

