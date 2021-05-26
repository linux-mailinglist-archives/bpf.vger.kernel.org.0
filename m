Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93C839225D
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 23:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhEZVyQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 17:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233839AbhEZVyP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 May 2021 17:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622065963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2ooIrO6+PnLW9RdU2+GIho8vABniPqVAPdMUszZt5uE=;
        b=cj1SZ5pWr8EzGGozjqMn0LwX7m6IMMK/ixyBZThsUvnADTXyfeRDbtr7dboRSWxEP1m0i3
        2YIie27l2s71yvsfdYjCDvw2P3MitVTYSb08m0tjNSoH+rO79OMisy1Ja/16gy+Cc+iQwJ
        WCx+p7/U1gdByU8hvvBTf1n2cOrMC04=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-kDXXuchJOd28yAMjCMo-Lg-1; Wed, 26 May 2021 17:52:41 -0400
X-MC-Unique: kDXXuchJOd28yAMjCMo-Lg-1
Received: by mail-wr1-f72.google.com with SMTP id a9-20020adfc4490000b0290112095ca785so934560wrg.14
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 14:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ooIrO6+PnLW9RdU2+GIho8vABniPqVAPdMUszZt5uE=;
        b=gks6+lGr3gC6Wzm1SAhb69ix2o3sZEqjY7vMOoiNGGF1kyza59LiLDMwPPino13pEE
         HFu7ncpOcV4puMEU8xgvLYcE++Un9ya2jVss7tTJ6wXCbvJfs3AA5jeNQpREwLplOtQZ
         h5u0JuY9RMxdXvHZ2NfCrrEXGApoceHDql/xyXVATc8wIPSZLJZA6mLd54f+BK4TigZX
         ekPW5k96dpMjo72b5NtuUBYTtwck2CUBQEPj20GJjpDVzPY3OjSePhJpL1bW+IPEkr/W
         3IZwylvloGMNxaQDoK9EcfmWsJ7SPVZBbfr8PuXUDoRAuLqAnR5b6JYxhDfhkZsAH3gM
         4KAA==
X-Gm-Message-State: AOAM532gQ21CqxTIgdm2ppEzW2IQrY3hQAwurjNe6DIBoZta2qKUlzly
        qvIaO4M6+tPROvfUyDza6aG/ESvlOJCdVnRzFxfSDLP3/0Vx5X+lvFaEbzWnjTe/9zsIuEcIGMe
        HU0YhK1jpRoNf
X-Received: by 2002:a05:6000:11ce:: with SMTP id i14mr80397wrx.221.1622065960120;
        Wed, 26 May 2021 14:52:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpR2jhnqwvB6Ifd8antV8AzpNPZsvRhuhOfJO+5wlVtFi9SUKlsBy9gkyhhjnjvo1hBm188Q==
X-Received: by 2002:a05:6000:11ce:: with SMTP id i14mr80383wrx.221.1622065959965;
        Wed, 26 May 2021 14:52:39 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q5sm388996wmc.0.2021.05.26.14.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 14:52:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH v2] kbuild: quote OBJCOPY var to avoid a pahole call break the build
Date:   Wed, 26 May 2021 23:52:28 +0200
Message-Id: <20210526215228.3729875-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The ccache tool can be used to speed up cross-compilation, by calling the
compiler and binutils through ccache. For example, following should work:

    $ export ARCH=arm64 CROSS_COMPILE="ccache aarch64-linux-gnu-"

    $ make M=drivers/gpu/drm/rockchip/

but pahole fails to extract the BTF info from DWARF, breaking the build:

      CC [M]  drivers/gpu/drm/rockchip//rockchipdrm.mod.o
      LD [M]  drivers/gpu/drm/rockchip//rockchipdrm.ko
      BTF [M] drivers/gpu/drm/rockchip//rockchipdrm.ko
    aarch64-linux-gnu-objcopy: invalid option -- 'J'
    Usage: aarch64-linux-gnu-objcopy [option(s)] in-file [out-file]
     Copies a binary file, possibly transforming it in the process
    ...
    make[1]: *** [scripts/Makefile.modpost:156: __modpost] Error 2
    make: *** [Makefile:1866: modules] Error 2

this fails because OBJCOPY is set to "ccache aarch64-linux-gnu-copy" and
later pahole is executed with the following command line:

    LLVM_OBJCOPY=$(OBJCOPY) $(PAHOLE) -J --btf_base vmlinux $@

which gets expanded to:

    LLVM_OBJCOPY=ccache aarch64-linux-gnu-objcopy pahole -J ...

instead of:

    LLVM_OBJCOPY="ccache aarch64-linux-gnu-objcopy" pahole -J ...

Fixes: 5f9ae91f7c0 ("kbuild: Build kernel module BTFs if BTF is enabled and pahole supports it")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---

Changes in v2:
- Add collected Acked-by tags.
- Also quote on a similar assignment in scripts/link-vmlinux.sh (masahiroy)

 scripts/Makefile.modfinal | 2 +-
 scripts/link-vmlinux.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index dd87cea9fba..a7883e45529 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -59,7 +59,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
 	if [ -f vmlinux ]; then						\
-		LLVM_OBJCOPY=$(OBJCOPY) $(PAHOLE) -J --btf_base vmlinux $@; \
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J --btf_base vmlinux $@; \
 	else								\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
 	fi;
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index f4de4c97015..0e0f6466b18 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -240,7 +240,7 @@ gen_btf()
 	fi
 
 	info "BTF" ${2}
-	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${extra_paholeopt} ${1}
+	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${extra_paholeopt} ${1}
 
 	# Create ${2} which contains just .BTF section but no symbols. Add
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
-- 
2.31.1

