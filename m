Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF48919ADBA
	for <lists+bpf@lfdr.de>; Wed,  1 Apr 2020 16:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbgDAOWU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Apr 2020 10:22:20 -0400
Received: from pub.regulars.win ([89.163.144.234]:60018 "EHLO pub.regulars.win"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732205AbgDAOWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Apr 2020 10:22:20 -0400
From:   Slava Bacherikov <slava@bacher09.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bacher09.org;
        s=reg; t=1585750936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6PA6evFBA3OhoMmMTkr0x/OR3XEpPNK02N3kYgs/0fY=;
        b=WHb2HyAqpVVozuh8wufIBqW+oj9uTdjbGnGsyEXPc7/TaCXQjFjLlFvyjWIWzbUeFHxjMJ
        MS+CV9sKgxO+0GYdsxZts5OAsRg+ujd1m5PkErXUf9f4ii1JfPdjUbg2Do8Z+tw3C35aCe
        C07xU6daqkxWfDHWpYGCzu4ZwMVyA+Q=
To:     keescook@chromium.org
Cc:     andriin@fb.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        jannh@google.com, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, kernel-hardening@lists.openwall.com,
        liuyd.fnst@cn.fujitsu.com, Slava Bacherikov <slava@bacher09.org>,
        KP Singh <kpsingh@google.com>
Subject: [PATCH v3 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
Date:   Wed,  1 Apr 2020 17:20:58 +0300
Message-Id: <20200401142057.453892-1-slava@bacher09.org>
In-Reply-To: <202004010033.A1523890@keescook>
References: <202004010033.A1523890@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
enabled will produce invalid btf file, since gen_btf function in
link-vmlinux.sh script doesn't handle *.dwo files.

Enabling DEBUG_INFO_REDUCED will also produce invalid btf file, and
using GCC_PLUGIN_RANDSTRUCT with BTF makes no sense.

Signed-off-by: Slava Bacherikov <slava@bacher09.org>
Reported-by: Jann Horn <jannh@google.com>
Reported-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Acked-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
---
 lib/Kconfig.debug | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f61d834e02fe..b94227be2d62 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -222,7 +222,9 @@ config DEBUG_INFO_DWARF4
 
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
-	depends on DEBUG_INFO
+	depends on DEBUG_INFO || COMPILE_TEST
+	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
+	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert
