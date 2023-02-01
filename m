Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328D568649A
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 11:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjBAKnx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 05:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBAKnw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 05:43:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B595340CC;
        Wed,  1 Feb 2023 02:43:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1049362wms.4;
        Wed, 01 Feb 2023 02:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4J3W/Vk7hR3hc7IECf638sW1Lrd77ONrObsDlT06fU=;
        b=CCa7qi7neQdpecvXa48s7mUwQkApP2K2rD9cGzCnl5/pI6RZxDMf79GVHOh8i/PxSm
         b0Vlxl0rkUL0el+rgQlWUoHz459Rxt6VCFQVuD1QHEOP1DoRt7oVPTUOQ/zqkpjy10ii
         5vMEbpuA56IGMugXNVJr5eJKNR2Fn9uaTAfSXR3yuU/c4rdW9gscjSYEFjM59T2aZd68
         L/meFv8EQbwawF8zWXOvnLCHQK12GZ6J/4pFNYINxUVdc9nQEzhmp8Y2dHRjDli4B7rh
         g6psUMsP9RXQR3z5wTrVwGrX1oVhNU+UGaPlE81B0uVUF0rSqFQZ3Q5oE4isye4UOGoO
         vw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4J3W/Vk7hR3hc7IECf638sW1Lrd77ONrObsDlT06fU=;
        b=aGR3B4kQK2LLMGwef9D9BEx2kco5tab88Zpgw4yMdTV3ORQ5N2J0LGwY5h8yIcAsdS
         8ai3F7/jhZqhDSBS6VsL46Cu/zw5/DZusg+K3+co3fLeAqEiKOh+uIFqcTgkavIX1/6m
         4uU1FrL1mzVZnVuWmhVwdq936kO0aG6Ah3zHNepTBtzlfwqKcZfpcWtj+1cacTdFA9xy
         2pwQBToIWzg03wQWVVo1AKNCUvUqtDGRkZYVltr3tEekfjj3quGsI0ahGsrnKBVVDRfb
         PS61JAlgtyayTysPm3ZQmGy/uZ0aedIb8g7C/wXA24q3N/Ia343BYizvJPBslQK8XO9X
         24KQ==
X-Gm-Message-State: AO0yUKUqNCpptv+I2IvGxYmV+hqpwT321Jd+ia1Rg9biqsyry6HCtDoT
        ogAEg3M9EesDnaXAiM4Bv7KYz4LsLzsaJuBp
X-Google-Smtp-Source: AK7set+jlzrE392ZNo9BC/UXjUkwmm4686MvT5jkjzkPgS7ROezGjK8qHtB7XUcE2+CHjdJzunfPtw==
X-Received: by 2002:a05:600c:3b14:b0:3dc:5c86:12f3 with SMTP id m20-20020a05600c3b1400b003dc5c8612f3mr1835646wms.1.1675248229219;
        Wed, 01 Feb 2023 02:43:49 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c43d400b003daf681d05dsm1289578wmn.26.2023.02.01.02.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 02:43:48 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 1 Feb 2023 11:43:47 +0100
To:     Ian Rogers <irogers@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tools/resolve_btfids: Tidy host CFLAGS forcing
Message-ID: <Y9pCY5IcYEqfNgBX@krava>
References: <20230201015015.359535-1-irogers@google.com>
 <Y9o4H61YmbOSCDOG@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9o4H61YmbOSCDOG@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 01, 2023 at 11:00:02AM +0100, Jiri Olsa wrote:
> On Tue, Jan 31, 2023 at 05:50:15PM -0800, Ian Rogers wrote:
> > Avoid passing CROSS_COMPILE to submakes and ensure CFLAGS is forced to
> > HOSTCFLAGS for submake builds. This fixes problems with cross
> > compilation.
> > 
> > Tidy to not unnecessarily modify/export CFLAGS, make the override for
> > prepare and build clearer.
> > 
> > Fixes: 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> hum, that seems to build just the fixdep and skip the resolve_btfids binary
> 
> make[1]: Entering directory '/home/jolsa/kernel/linux-qemu/build'
>   GEN     Makefile
>   CALL    ../scripts/checksyscalls.sh
>   DESCEND bpf/resolve_btfids
>   HOSTCC  /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep.o
>   HOSTLD  /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep-in.o
>   LINK    /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep
>   UPD     include/generated/utsversion.h
>   CC      init/version-timestamp.o
>   LD      .tmp_vmlinux.btf
>   BTF     .btf.vmlinux.bin.o
> die__process_unit: DW_TAG_label (0xa) @ <0x4f0d4> not handled!
> 
>   ...
> 
> die__process_unit: DW_TAG_label (0xa) @ <0xaf91cc3> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0xb032fa7> not handled!
>   LD      .tmp_vmlinux.kallsyms1
>   NM      .tmp_vmlinux.kallsyms1.syms
>   KSYMS   .tmp_vmlinux.kallsyms1.S
>   AS      .tmp_vmlinux.kallsyms1.S
>   LD      .tmp_vmlinux.kallsyms2
>   NM      .tmp_vmlinux.kallsyms2.syms
>   KSYMS   .tmp_vmlinux.kallsyms2.S
>   AS      .tmp_vmlinux.kallsyms2.S
>   LD      .tmp_vmlinux.kallsyms3
>   NM      .tmp_vmlinux.kallsyms3.syms
>   KSYMS   .tmp_vmlinux.kallsyms3.S
>   AS      .tmp_vmlinux.kallsyms3.S
>   LD      vmlinux
>   BTFIDS  vmlinux
> ../scripts/link-vmlinux.sh: line 277: ./tools/bpf/resolve_btfids/resolve_btfids: No such file or directory
> make[2]: *** [../scripts/Makefile.vmlinux:35: vmlinux] Error 127
> make[2]: *** Deleting file 'vmlinux'
> make[1]: *** [/home/jolsa/kernel/linux-qemu/Makefile:1264: vmlinux] Error 2
> make[1]: Leaving directory '/home/jolsa/kernel/linux-qemu/build'
> make: *** [Makefile:242: __sub-make] Error 2
> 
> we actually have the hostprogs support in tools/build and we use it for
> fixdep, I think we should use it also here, I'll check

it doesn't look that bad.. the change below fixes the build for me,
perhaps we should do that for all the host tools

jirka


---
diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
index ae82da03f9bf..077de3829c72 100644
--- a/tools/bpf/resolve_btfids/Build
+++ b/tools/bpf/resolve_btfids/Build
@@ -1,3 +1,5 @@
+hostprogs := resolve_btfids
+
 resolve_btfids-y += main.o
 resolve_btfids-y += rbtree.o
 resolve_btfids-y += zalloc.o
@@ -7,4 +9,4 @@ resolve_btfids-y += str_error_r.o
 
 $(OUTPUT)%.o: ../../lib/%.c FORCE
 	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
+	$(call if_changed_dep,host_cc_o_c)
diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index daed388aa5d7..de513fd08535 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -22,6 +22,9 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
 		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
 
 RM      ?= rm
+HOSTCC  ?= gcc
+HOSTLD  ?= ld
+HOSTAR  ?= ar
 CROSS_COMPILE =
 
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
@@ -64,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
 LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
 LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
-CFLAGS += -g \
+HOSTCFLAGS += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
@@ -73,7 +76,7 @@ CFLAGS += -g \
 
 LIBS = $(LIBELF_LIBS) -lz
 
-export srctree OUTPUT CFLAGS Q
+export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
 include $(srctree)/tools/build/Makefile.include
 
 $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
