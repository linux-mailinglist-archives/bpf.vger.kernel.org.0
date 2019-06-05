Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A7436855
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 01:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfFEXrd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jun 2019 19:47:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44988 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFEXrc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jun 2019 19:47:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id w187so355460qkb.11
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2019 16:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zDO2mA6fGgwBFEtaCPfqOVF59ce/1l1R+5nsTwEvF18=;
        b=emQP+MAUVJ6jrjNPeievvDvRIuGf83Osn1ssObVjt06c80uJp8BQ46N2dVFJxBuKEd
         RtEihoxVQFt8P5GmInUbcD8qfczNElF5cretS4H97/v7Q0v48aqg4oWcOFT0MiR5dZsD
         +lhRw0mIWwdGF3+HYB0hPYvu/t96ThKrS5LmTv8C3YpGR/0U6jxjTl7w5PWY7nMN8VZW
         SsuvShPepbD51E2Ctd8+x6x/cNrE41tYiouvyggT7yX+ar/LW0wP2O3e7TOR3QseL/fc
         tPs93cWcN+jw/61W/URqlbGT5BB2U0TZoQPdpYsnT2GKhFdWFv5TkwsvrnRkvOJ4HcnI
         Nbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zDO2mA6fGgwBFEtaCPfqOVF59ce/1l1R+5nsTwEvF18=;
        b=ZtuKM0kcOulvCBmg8YJKi95TQJHxbema41xLTyTyXVWRYEyjp61U63pTEoylUuoo8r
         tcHdM+IE2m9s91Ji+TAjdpJ2xHGrOLtEaK5xdI7wn7vMThZwumGBzkysah6eagwy6sAG
         Wa4kcIFxDNy72cogY2MueoJSFZ41ZV+mta4OiG/i/FRPfdUfAAgmsQmc/OGexulAT9hu
         86jFu3nIaTzUzQ11iwsMdKjVdmYb5Thm8RRRimVPpBjUWSXT9dbmpuxqpT6/WzWZd7Jo
         cefSdChpm4NvixggGn5so1v0nawT/5gNWFhj7+Q96ddqv8Hf9S32xGyyienk6mz05OHW
         DytA==
X-Gm-Message-State: APjAAAWuQm7piOcA16sE+XjxYzoU83mqF6NLghPi/xJIBPP3k2ppe7Ps
        nOdQjI7rE1C9PRwaTxiwr3d55g==
X-Google-Smtp-Source: APXvYqye2z2dcXK8nboELfTbsqistA9JDReSMEzQbkON9cN4avYgZ4GqaLSR14phd34dURsPT5RvrA==
X-Received: by 2002:a05:620a:12f8:: with SMTP id f24mr16085988qkl.202.1559778451748;
        Wed, 05 Jun 2019 16:47:31 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o54sm264988qtb.63.2019.06.05.16.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 16:47:30 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next v2] samples: bpf: print a warning about headers_install
Date:   Wed,  5 Jun 2019 16:47:22 -0700
Message-Id: <20190605234722.2291-1-jakub.kicinski@netronome.com>
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

v2: just use HOSTCC (Jiong).

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
---
 samples/bpf/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 253e5a2856be..4074a66a70ca 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -206,6 +206,15 @@ HOSTCC = $(CROSS_COMPILE)gcc
 CLANG_ARCH_ARGS = -target $(ARCH)
 endif
 
+HDR_PROBE := $(shell echo "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
+	$(HOSTCC) $(KBUILD_HOSTCFLAGS) -x c - -o /dev/null 2>/dev/null && \
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

