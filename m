Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1383199C48
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 18:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbgCaQ4n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 12:56:43 -0400
Received: from pub.regulars.win ([89.163.144.234]:60628 "EHLO pub.regulars.win"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbgCaQ4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 12:56:42 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2020 12:56:42 EDT
From:   Slava Bacherikov <slava@bacher09.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bacher09.org;
        s=reg; t=1585673336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DmSQ2UIhT0odCb3E+9iqnV1wCWPiNesSH1XLAgRS7Jw=;
        b=Re0+pc4fcZ/9lLyWQmpJEiEuwkWiA/rcf3G5Ovd+qNiPmIJAMU0s0l2zzXj/Xo1ahMPieK
        WBTPVVN2hgx0dtCM96KcbSPr7bvID3Gnjcl4/tzhZZoQUSsk7JwhwmCzhj/p4nMIYH7aiJ
        Ao/cP94gY1ZNlL/CFxY1dNgqV6s7MHo=
To:     yamada.masahiro@socionext.com
Cc:     andriin@fb.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net,
        Slava Bacherikov <slava@bacher09.org>
Subject: [PATCH] kbuild: disable DEBUG_INFO_SPLIT when BTF is on
Date:   Tue, 31 Mar 2020 19:47:20 +0300
Message-Id: <20200331164719.15930-1-slava@bacher09.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
enabled will produce invalid btf file, since gen_btf function in
link-vmlinux.sh script doesn't handle *.dwo files.

Signed-off-by: Slava Bacherikov <slava@bacher09.org>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f61d834e02fe..a9429ef5eec8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -223,6 +223,7 @@ config DEBUG_INFO_DWARF4
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
 	depends on DEBUG_INFO
+	depends on !DEBUG_INFO_SPLIT
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert
-- 
2.24.1

