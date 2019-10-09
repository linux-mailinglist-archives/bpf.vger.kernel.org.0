Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F34D19C4
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 22:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfJIUlr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 16:41:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33083 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731978AbfJIUlr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so3917269ljd.0
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 13:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j9oehlPvbpQ/3mUr7ILsjkWG9P4RuU3Cq2akh+BGeG4=;
        b=u9WblPuD1rsm0jyX6rOP8LRDXId4vkuFAucoTNQKldbU28hMIlJ4Ye49sY+S9r4GVw
         FZlnYg+q4HiKAE96sVNakxmBf34Y9mWy3RWPbEpycFz6xT78/mZDLFsz7FEXaIXy1EXt
         XrgaMdZhH+hP/js5F/dJ3Em5ta0eRVre0FAswR5FWcDfAnxpFAk1mWdRFBtU+/IJF0Ty
         TBQ4ItMejqowBuKLezbZXsMP0uNYRa5YzBKTB7STXrYiiISY8jmZs0OxMlAXJTxMw2Uo
         ah+j28+8X6x/K5OMYVKofwMOJqb+8KuBfI6BQFyAyyrKkwdciKWqLYwXUnPM8odBEyds
         lLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j9oehlPvbpQ/3mUr7ILsjkWG9P4RuU3Cq2akh+BGeG4=;
        b=UabebmZdNpv4rGcwKx7m0g+OusbtZCu1g4Zb4OcfssqzswRyXWBXHY9ONCZc5kRtIV
         1boWanOwuHeZ5e3xER3DNffBDih374od6j+L1mLsLcgZ5Apv8Q4FkbiqQ8mrPxV/lTyX
         uMk/I+OZkGXoWHnGozBleofApKW/WfgaZ7M1tindMRSTpjsssSgYiZ1i4pvZSGHsMsRd
         8zPHiFvYj4kRnMYIFY3QSjFc0G2iGwHLb3hkgvZFV6WoRtnJTeQr/rjQ61Cb2ipn8FYT
         aqGjpGIvm5sfVM+AgKsJcWOpiBen7CUEx0GAKqv6M2DkLGAU2LsFarfb2W/bpksCGbmg
         xIuQ==
X-Gm-Message-State: APjAAAUuRGU5s3yGTgRZkwvqH9rpTG4TwSVhLcO9cBMeoErxITpE7pwH
        RGO3TF3WBDDJfCtAmt8N0kM6qQ==
X-Google-Smtp-Source: APXvYqymIdgfyxgRoHuT7kBxL0jS3aNb/nX8NZ5SezJ6vkjCDt5qlasTpcF9WFmXN/+gsv58UvFtuw==
X-Received: by 2002:a2e:9b12:: with SMTP id u18mr3696925lji.142.1570653705253;
        Wed, 09 Oct 2019 13:41:45 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:44 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 04/15] samples/bpf: use own EXTRA_CFLAGS for clang commands
Date:   Wed,  9 Oct 2019 23:41:23 +0300
Message-Id: <20191009204134.26960-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It can overlap with CFLAGS used for libraries built with gcc if
not now then in next patches. Correct it here for simplicity.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 9c8c9872004d..cf882e43648a 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -218,10 +218,10 @@ BTF_LLVM_PROBE := $(shell echo "int main() { return 0; }" | \
 			  /bin/rm -f ./llvm_btf_verify.o)
 
 ifneq ($(BTF_LLVM_PROBE),)
-	EXTRA_CFLAGS += -g
+	BPF_EXTRA_CFLAGS += -g
 else
 ifneq ($(and $(BTF_LLC_PROBE),$(BTF_PAHOLE_PROBE),$(BTF_OBJCOPY_PROBE)),)
-	EXTRA_CFLAGS += -g
+	BPF_EXTRA_CFLAGS += -g
 	LLC_FLAGS += -mattr=dwarfris
 	DWARF2BTF = y
 endif
@@ -280,8 +280,9 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 # useless for BPF samples.
 $(obj)/%.o: $(src)/%.c
 	@echo "  CLANG-bpf " $@
-	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) -I$(obj) \
-		-I$(srctree)/tools/testing/selftests/bpf/ -I$(srctree)/tools/lib/bpf/ \
+	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
+		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
+		-I$(srctree)/tools/lib/bpf/ \
 		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
-- 
2.17.1

