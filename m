Return-Path: <bpf+bounces-6117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973267660DB
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 02:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF5728255F
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 00:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A24015A7;
	Fri, 28 Jul 2023 00:44:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347537C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 00:43:59 +0000 (UTC)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198BA30D3
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:43:51 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3465bd756afso6551495ab.3
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690505030; x=1691109830;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y32l4Yp6o/svzuu2S4wlIEwwbL+0m62Hx+SdOq+tyJg=;
        b=REo0Il8UUkeLZKfo1guIi8uAcDiwqksio9C9/MayFrie4HZhBnsiD4WKHC+Y8prXOj
         cnc3jk/dKAXtzhrMVBeY4AnjfDlObg08DvgnLFjjkCySP5R21FqJ4HbJZnppxBryDh3i
         Lh8wB6rQk17nwxnpBB+UFpB5tLF3iF6nUiAZb6jdjXZOwDeRxQNurYR/mm/xkdIUvp5h
         UvfziVVrJ/kxbnKjeA8xV/BBFHjA2bFBVUXdqlbzojRTaaN2HGs6bq0UVQuPUkvKkXSK
         wOPzvj2gMcr+AA9TlwqIoa9BpwiphX87fY+4okjoAcxJDI5D4lgLL6d5vY533HoNXZEv
         Na5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690505030; x=1691109830;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y32l4Yp6o/svzuu2S4wlIEwwbL+0m62Hx+SdOq+tyJg=;
        b=jT0a2cnatWHpl7+ZBLXDU9iCkqRHtWfGRZR6iYn2exRTtCYY37vzX1Equi/4uVSjJJ
         LWey8cHF9ER/l8tZRvzRCP9xcoWkfJFTHIgWj+EmrtiRNNBjGMCYRm1Dk7QWewROkYPL
         5hZD/cA0oitPKlYxEdITHM8Og1zN2ZcV2eC4Wm7wrgn2qNd6p9iJihdTTC4TFq6zq7RT
         xtC1vZIB+qRJ1tey5+z+S33Kkaqg8xvuyPo2wyRdtzJTOBuel3MQ1CyxIUNsJrswia5Y
         rKem7/ScLS7HMnmayZlTNyRkw6+BGWFUyi+51VhqRJFB7cT3F7Kn0smVzZ/MfuA8ILHP
         +pew==
X-Gm-Message-State: ABy/qLZLA97krRAtEqCQasgamJWfiBqH6i7RgHSy37773WeKfLcL0Fkj
	Wvy4GM020ch7Q6E7OJbr9R4=
X-Google-Smtp-Source: APBJJlERbUurb1xofj6Y+TRIiqdjmEszz5BPXqdlVcxQWyZOK1JKo3y+20C3ypefHiLOQ+sJSA/tqw==
X-Received: by 2002:a05:6e02:1a05:b0:348:d52a:8f8 with SMTP id s5-20020a056e021a0500b00348d52a08f8mr1329011ild.25.1690505030234;
        Thu, 27 Jul 2023 17:43:50 -0700 (PDT)
Received: from [192.168.1.9] ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id q16-20020a62e110000000b00686eeaab7ecsm2011029pfh.215.2023.07.27.17.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 17:43:49 -0700 (PDT)
Message-ID: <2ba1c076-f5bf-432f-50c1-72c845403167@gmail.com>
Date: Fri, 28 Jul 2023 07:43:46 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, ast <ast@kernel.org>,
 daniel <daniel@iogearbox.net>, andrii <andrii@kernel.org>,
 "martin.lau" <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>,
 linux-kernel-mentees <linux-kernel-mentees@lists.linuxfoundation.org>
From: Anh Tuan Phan <tuananhlfc@gmail.com>
Subject: [PATCH v2] samples/bpf: Fix build out of source tree
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Changes from v1:
- Unconditionally add "-I $(objtree)/$(obj)" to _tprogc_flags and drop
  unnecessary part
Reference:
- v1:
https://lore.kernel.org/all/67bec6a9-af59-d6f9-2630-17280479a1f7@gmail.com/
---
 samples/bpf/Makefile        | 10 +++++-----
 samples/bpf/Makefile.target |  9 +--------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 615f24ebc49c..cfc960b3713a 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
 # TPROGS_CFLAGS causes conflicts
 XDP_SAMPLE_CFLAGS += -Wall -O2 \
-		     -I$(src)/../../tools/include \
-		     -I$(src)/../../tools/include/uapi \
+		     -I$(srctree)/tools/include \
+		     -I$(srctree)/tools/include/uapi \
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
index 7621f55e2947..d2fab959652e 100644
--- a/samples/bpf/Makefile.target
+++ b/samples/bpf/Makefile.target
@@ -38,14 +38,7 @@ tprog-cobjs	:= $(addprefix $(obj)/,$(tprog-cobjs))
 # Handle options to gcc. Support building with separate output directory

 _tprogc_flags   = $(TPROGS_CFLAGS) \
-                 $(TPROGCFLAGS_$(basetarget).o)
-
-# $(objtree)/$(obj) for including generated headers from checkin source
files
-ifeq ($(KBUILD_EXTMOD),)
-ifdef building_out_of_srctree
-_tprogc_flags   += -I $(objtree)/$(obj)
-endif
-endif
+                 -I $(objtree)/$(obj)

 tprogc_flags    = -Wp,-MD,$(depfile) $(_tprogc_flags)

-- 
2.34.1

