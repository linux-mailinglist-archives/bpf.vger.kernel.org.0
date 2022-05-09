Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86565205FC
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 22:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiEIUka (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 16:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiEIUk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 16:40:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F8F6424;
        Mon,  9 May 2022 13:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DJvkssOcF8+m+Ove9gLIwYNOA7vpMPRTcC342WLSizg=; b=KpKgCLBfutwIM6QfTn7oZ1fOI0
        4JX2oo2OGp9VpO65yNS70YWgPPl2q/IFttVJGj0CVQFLyhmV1r+2gRtv3HAV4S+u0CieG/zjo4P8Y
        blDSX62zTFAlDAlkTZl1CXE76IQNtzkrL8JC1JDgk1I8+07hYV8aCE9RrwvmXf9QfYwDimhRsbaxd
        dHtm5sw3m9ASqeh+A5Hv0sN6/00XJwItWJE1lM24uaQDGHjwGved8yQHp36+JaJlyc9RQBG15TYBt
        G1a4Q0yOaTaqh3CT2r8O6Srku4lEE7Knihuq5qMwcSIXCyy6CczW3ujT39EfdcMYxuATc+Z6yyy1V
        j2SOz2YA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noA7F-00GBNP-Uk; Mon, 09 May 2022 20:36:25 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     songliubraving@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        mcgrof@kernel.org
Subject: [PATCH] bpf.h: fix clang compiler warning with unpriv_ebpf_notify()
Date:   Mon,  9 May 2022 13:36:23 -0700
Message-Id: <20220509203623.3856965-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The recent commit "bpf: Move BPF sysctls from kernel/sysctl.c to BPF core"
triggered 0-day to issue an email for what seems to have been an old
clang warning. So this issue should have existed before as well, from
what I can tell. The issue is that clang expects a forward declaration
for routines declared as weak while gcc does not.

This can be reproduced with 0-day's x86_64-randconfig-c007
https://download.01.org/0day-ci/archive/20220424/202204240008.JDntM9cU-lkp@intel.com/config

And using:

COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 SHELL=/bin/bash kernel/bpf/syscall.o
Compiler will be installed in /home/mcgrof/0day
make --keep-going HOSTCC=/home/mcgrof/0day/clang/bin/clang CC=/home/mcgrof/0day/clang/bin/clang LD=/home/mcgrof/0day/clang/bin/ld.lld HOSTLD=/home/mcgrof/0day/clang/bin/ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-size READELF=llvm-readelf HOSTCXX=clang++ HOSTAR=llvm-ar CROSS_COMPILE=x86_64-linux-gnu- --jobs=24 W=1 ARCH=x86_64 SHELL=/bin/bash kernel/bpf/syscall.o
  DESCEND objtool
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CC      kernel/bpf/syscall.o
kernel/bpf/syscall.c:4944:13: warning: no previous prototype for function 'unpriv_ebpf_notify' [-Wmissing-prototypes]
void __weak unpriv_ebpf_notify(int new_state)
            ^
kernel/bpf/syscall.c:4944:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void __weak unpriv_ebpf_notify(int new_state)
^
static

Fixes: 2900005ea287 ("bpf: Move BPF sysctls from kernel/sysctl.c to BPF core")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Daniel,

Given what we did fore 2900005ea287 ("bpf: Move BPF sysctls from
kernel/sysctl.c to BPF core") where I had pulled pr/bpf-sysctl a
while ago into sysctl-next and then merged the patch in question,
should I just safely carry this patch onto sysctl-next? Let me know
how you'd like to proceed.

Also, it wasn't clear if putting this forward declaration on
bpf.h was your ideal preference.

  Luis

 include/linux/bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb5298735ce..bd3e17a9f821 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1551,6 +1551,9 @@ bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
 #endif
 
 extern int sysctl_unprivileged_bpf_disabled;
+#ifdef CONFIG_SYSCTL
+void unpriv_ebpf_notify(int new_state);
+#endif
 
 static inline bool bpf_allow_ptr_leaks(void)
 {
-- 
2.35.1

