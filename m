Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A70219A171
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 23:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbgCaV46 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 17:56:58 -0400
Received: from pub.regulars.win ([89.163.144.234]:47040 "EHLO pub.regulars.win"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgCaV46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 17:56:58 -0400
From:   Slava Bacherikov <slava@bacher09.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bacher09.org;
        s=reg; t=1585691814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YT3MtOxItDdm7TWprAjBs6HigHaG9iwHyVl+Qij+P7Q=;
        b=sA0E+eeYQDfev3TzgMOUJL7ighcMggnMl5MnYXjtYSA9nOlaYPPtalbXpF4MzDd1DK1Vdm
        x9LhwSZ9OPigKOjS6GPiXHp22dMJnDFWcDwsykFS9EgBoQ0b4MR4M2VaLVcMgp9mGJc54R
        eyVOhTIXjHKjZ2LUSGqtAE4Ltsspl1Q=
To:     andriin@fb.com
Cc:     keescook@chromium.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, jannh@google.com,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        kernel-hardening@lists.openwall.com,
        Slava Bacherikov <slava@bacher09.org>,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Subject: [PATCH v2 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
Date:   Wed,  1 Apr 2020 00:55:37 +0300
Message-Id: <20200331215536.34162-1-slava@bacher09.org>
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
Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f61d834e02fe..9ae288e2a6c0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -223,6 +223,7 @@ config DEBUG_INFO_DWARF4
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
 	depends on DEBUG_INFO
+	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED && !GCC_PLUGIN_RANDSTRUCT
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert
-- 
2.24.1

