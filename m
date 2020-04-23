Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CEC1B564D
	for <lists+bpf@lfdr.de>; Thu, 23 Apr 2020 09:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgDWHoh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Apr 2020 03:44:37 -0400
Received: from condef-07.nifty.com ([202.248.20.72]:21497 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgDWHoh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Apr 2020 03:44:37 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-07.nifty.com with ESMTP id 03N7eoE2004502
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 16:40:50 +0900
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 03N7dV9M000368;
        Thu, 23 Apr 2020 16:39:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 03N7dV9M000368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587627574;
        bh=etjXsdFQORx4gLL7yHfpFDxgLm5eIEPJc35auHNsBS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OdG1U0mvDU6Qg+Q8reUgMxjQsLczKGy3gDu4zS7XBoirXDmmxluhW75bZldtxGt7k
         /syvDaNTqoK9lFdDISe7PNckoqZgaxz7VY+HZzXULU/lWOtp0o83sKPtIkRJqEf1et
         /YgAye82oOT2JJeqVBoApqqB4JB7SleqV8rjo2QBl8xy5q3f2ht+J/vPYx7irwD1Xp
         4wHrQTkcYKTN9P1Jcmj7eMWYpMs4kGuA3AVP26rMjAx1GLeAH8IvsMXN+7njpFEGLg
         6zx4FM+MTczpSfBw9pJGfuVj7rreHECcgqYPk+8pM3CWPvdR285WM5uCZUWlF1CrYM
         dWo7XwdI0iNIw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/16] Documentation: kbuild: fix the section title format
Date:   Thu, 23 Apr 2020 16:39:14 +0900
Message-Id: <20200423073929.127521-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200423073929.127521-1-masahiroy@kernel.org>
References: <20200423073929.127521-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make it consistent with the other sections.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/kbuild/makefiles.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 04d5c01a2e99..b80257a03830 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -1241,7 +1241,8 @@ When kbuild executes, the following steps are followed (roughly):
 	will be displayed with "make KBUILD_VERBOSE=0".
 
 
---- 6.9 Preprocessing linker scripts
+6.9 Preprocessing linker scripts
+--------------------------------
 
 	When the vmlinux image is built, the linker script
 	arch/$(ARCH)/kernel/vmlinux.lds is used.
-- 
2.25.1

