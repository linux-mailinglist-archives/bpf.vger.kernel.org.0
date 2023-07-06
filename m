Return-Path: <bpf+bounces-4274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6B774A0E3
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4B01C20D9E
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F32A953;
	Thu,  6 Jul 2023 15:26:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F460A934
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 15:26:04 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9A21BD3
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 08:26:03 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-55b66ce047cso502140a12.0
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688657163; x=1691249163;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naq3nXH3JnI0iCRMysYX4z2gUezeFgxv5TLSzOREpHo=;
        b=hT0Hir0ihbJbkAxVAiZkTCGWQRr1oVvRH8qwo0fc9hcBbCsC9i+bYM2rfu+eoIjDPP
         2U9IKhnIur5G2BIPFKPrZjX7zFWM4NE6Xvy+ajOoR/p6eYL/zHbsSIyaN/ihgs82eEih
         bVgkw0Y1kOYdg3VXQMJz/O9fQE9ZWIiDABPBw0KNRVLD9l4RTHrplgPFeAJh4WRXTXKb
         u56qTayTALvfhbcDvVVQeasp70iAuBgQfEaPEwvfW0YZlMOP9fQBg2VTgRjYd0u6jKUM
         1/SxoqU8o0ehFCalFirLTcSgZyBsJQ36K7yMsx8Q1K3lS74URqLw5aN2KiTQl91Ag7F7
         h7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688657163; x=1691249163;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=naq3nXH3JnI0iCRMysYX4z2gUezeFgxv5TLSzOREpHo=;
        b=IR7C6anNFjrjNK9hqHVRO2/oVWhE0LGAopL7Ca2TC76Qt+2rMHdqk7IqA0xcpfjVEx
         g1VDfm5smpO0oaKjP4gN5GE6XvI7R2CKNCHjHPM4gr/XOe3eO3a/jr9tcFqSOBf0nScg
         JMUTIr/fEhhLYGfDCWOUowBBp4CWyr377gSUvFyd8WaZxT3/LwYlQXDBsDqakDPiWQWA
         XitRQxlSdB2Ta/s1ZgkFI06N6fQaFuocHCT4CeZe1rkLoPj7L86iFxNqGQaLQoxRMySI
         9nhl9LWpnWZKGPtp20N63oM4wy0se42bIioAyOkIyr24HuLBdtmGOPak1GY1uIjXyB70
         3B7g==
X-Gm-Message-State: ABy/qLbpRhLmjS+l0GOjn/NrD+bur5DHSV3TFJVQSpWgr4rynRVYIWa2
	cA/kyJkGxo0bnSTXzGBs3Qzd7PolM3Sdh638
X-Google-Smtp-Source: APBJJlGv0ZAt5DVFFDjDjatFYonNjvshPg4oV9Pm7JqRungl0a78MrsHHUmiqYRYZOuJ+X8nQXiHjA==
X-Received: by 2002:a05:6a20:1050:b0:12e:ba2:7283 with SMTP id gt16-20020a056a20105000b0012e0ba27283mr1483332pzc.24.1688657162429;
        Thu, 06 Jul 2023 08:26:02 -0700 (PDT)
Received: from [192.168.1.9] ([14.238.228.104])
        by smtp.gmail.com with ESMTPSA id z15-20020a65610f000000b0052871962579sm1315340pgu.63.2023.07.06.08.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 08:26:02 -0700 (PDT)
Message-ID: <67bec6a9-af59-d6f9-2630-17280479a1f7@gmail.com>
Date: Thu, 6 Jul 2023 22:25:58 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
From: Anh Tuan Phan <tuananhlfc@gmail.com>
Subject: [PATCH v1] samples/bpf: Fix build out of source tree
To: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit fixes a few compilation issues when building out of source
tree. The command that I used to build samples/bpf:

export KBUILD_OUTPUT=/tmp
make V=1 M=samples/bpf

The compilation failed since it tried to find the header files in the
wrong places between output directory and source tree directory

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
 samples/bpf/Makefile        | 8 ++++----
 samples/bpf/Makefile.target | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 615f24ebc49c..32469aaa82d5 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
 # TPROGS_CFLAGS causes conflicts
 XDP_SAMPLE_CFLAGS += -Wall -O2 \
-		     -I$(src)/../../tools/include \
+		     -I$(srctree)/tools/include \
 		     -I$(src)/../../tools/include/uapi \
 		     -I$(LIBBPF_INCLUDE) \
-		     -I$(src)/../../tools/testing/selftests/bpf
+		     -I$(srctree)/tools/testing/selftests/bpf

 $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
 $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
@@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h
$(src)/xdp_sample_shared.h
 	@echo "  CLANG-BPF " $@
 	$(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
-		-Wno-compare-distinct-pointer-types -I$(srctree)/include \
+		-Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)/include \
 		-I$(srctree)/samples/bpf -I$(srctree)/tools/include \
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-c $(filter %.bpf.c,$^) -o $@
@@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o
xdp_sample.bpf.o

 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach
skel,$(LINKED_SKELS),$($(skel)-deps)))

-BPF_SRCS_LINKED := $(notdir $(wildcard $(src)/*.bpf.c))
+BPF_SRCS_LINKED := $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
 BPF_OBJS_LINKED := $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LINKED))
 BPF_SKELS_LINKED := $(addprefix $(obj)/,$(LINKED_SKELS))

diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
index 7621f55e2947..86a454cfb080 100644
--- a/samples/bpf/Makefile.target
+++ b/samples/bpf/Makefile.target
@@ -41,7 +41,7 @@ _tprogc_flags   = $(TPROGS_CFLAGS) \
                  $(TPROGCFLAGS_$(basetarget).o)

 # $(objtree)/$(obj) for including generated headers from checkin source
files
-ifeq ($(KBUILD_EXTMOD),)
+ifneq ($(KBUILD_EXTMOD),)
 ifdef building_out_of_srctree
 _tprogc_flags   += -I $(objtree)/$(obj)
 endif
-- 
2.34.1

