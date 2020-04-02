Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0D4A19CBC8
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 22:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbgDBUmm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 16:42:42 -0400
Received: from pub.regulars.win ([89.163.144.234]:50514 "EHLO pub.regulars.win"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgDBUmm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 16:42:42 -0400
From:   Slava Bacherikov <slava@bacher09.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bacher09.org;
        s=reg; t=1585860159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FjEUUecMFmSmjNvMMdOE00B64A4ZBeK571WEZ1itbTo=;
        b=vpyvacP4IlEQAZZTqSLxAxWKl1ADfLPJ4lur44nnd4UAiN6TqY5XLfICXUQhElx58DN4/F
        VZ9EmZ9StR/86gGMuuu8ucf+W+sM3/hT+blRRXxoNsndkZhqNTdVksavxWpmqEIaBN3a9P
        NrZtSC8erogUojOk08ONx4mHH+pr3FE=
To:     andriin@fb.com
Cc:     keescook@chromium.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, jannh@google.com,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        kernel-hardening@lists.openwall.com, liuyd.fnst@cn.fujitsu.com,
        kpsingh@google.com, Slava Bacherikov <slava@bacher09.org>
Subject: [PATCH v5 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
Date:   Thu,  2 Apr 2020 23:41:39 +0300
Message-Id: <20200402204138.408021-1-slava@bacher09.org>
In-Reply-To: <202004021328.E6161480@keescook>
References: <202004021328.E6161480@keescook>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
---
 lib/Kconfig.debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f61d834e02fe..6118d99117da 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -223,6 +223,8 @@ config DEBUG_INFO_DWARF4
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
 	depends on DEBUG_INFO
+	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
+	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert
