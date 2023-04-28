Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEDB6F10AA
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 05:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344932AbjD1DKo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 23:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345218AbjD1DKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 23:10:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A427A30D2;
        Thu, 27 Apr 2023 20:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HPYgfypTw1vIYU6R0OqK5IQj1qxUl03tjuR1IIa/a8c=; b=j/v0+ju9xbMPnDp2E4/bEYP8IT
        gyhT7SrJOmn5lNnQjR/Xx/G161RjDzXwX7wcW4qyxN7GYDlVppbqBvuYrkHuje0yYnUuRevKNLCwk
        7O/Pq/qWplbwui5hkzJWZ07klRcQgWjqTAyt3E9N0CD9NgCaXM0XaMiBs+NFjbFEjM4SICSgyD48J
        z0rvQP01xtWEvrCe03kRJH6ZIvBXqrUWxMXTqd0R8G0b6TnMG0eRnuh9r7IoUt1ENLvYLTnqD+qV+
        +lwSR0G9J0prR+hMb+DK8XiU23oIMM8GGM8R7QZ5qlfM7Nynw+zYwoPV/T2g/3MD1yIsGfneEDa7s
        q8NTHZ8g==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1psEU1-0082Yk-34;
        Fri, 28 Apr 2023 03:09:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Subject: [PATCH] lsm: move hook comments docs to security/security.c
Date:   Thu, 27 Apr 2023 20:09:16 -0700
Message-Id: <20230428030916.2966-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix one kernel-doc warning, but invesigating that led to other
kernel-doc movement (lsm_hooks.h to security.c) that needs to be
fixed also.

include/linux/lsm_hooks.h:1: warning: no structured comments found

Fixes: e261301c851a ("lsm: move the remaining LSM hook comments to security/security.c")
Fixes: 1cd2aca64a5d ("lsm: move the io_uring hook comments to security/security.c")
Fixes: 452b670c7222 ("lsm: move the perf hook comments to security/security.c")
Fixes: 55e853201a9e ("lsm: move the bpf hook comments to security/security.c")
Fixes: b14faf9c94a6 ("lsm: move the audit hook comments to security/security.c")
Fixes: 1427ddbe5cc1 ("lsm: move the binder hook comments to security/security.c")
Fixes: 43fad2821876 ("lsm: move the sysv hook comments to security/security.c")
Fixes: ecc419a44535 ("lsm: move the key hook comments to security/security.c")
Fixes: 742b99456e86 ("lsm: move the xfrm hook comments to security/security.c")
Fixes: ac318aed5498 ("lsm: move the Infiniband hook comments to security/security.c")
Fixes: 4a49f592e931 ("lsm: move the SCTP hook comments to security/security.c")
Fixes: 6b6bbe8c02a1 ("lsm: move the socket hook comments to security/security.c")
Fixes: 2c2442fd46cd ("lsm: move the AF_UNIX hook comments to security/security.c")
Fixes: 2bcf51bf2f03 ("lsm: move the netlink hook comments to security/security.c")
Fixes: 130c53bfee4b ("lsm: move the task hook comments to security/security.c")
Fixes: a0fd6480de48 ("lsm: move the file hook comments to security/security.c")
Fixes: 9348944b775d ("lsm: move the kernfs hook comments to security/security.c")
Fixes: 916e32584dfa ("lsm: move the inode hook comments to security/security.c")
Fixes: 08526a902cc4 ("lsm: move the filesystem hook comments to security/security.c")
Fixes: 36819f185590 ("lsm: move the fs_context hook comments to security/security.c")
Fixes: 1661372c912d ("lsm: move the program execution hook comments to security/security.c")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org
---
 Documentation/bpf/prog_lsm.rst             |    2 +-
 Documentation/security/lsm-development.rst |    6 +++---
 Documentation/security/lsm.rst             |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff -- a/Documentation/bpf/prog_lsm.rst b/Documentation/bpf/prog_lsm.rst
--- a/Documentation/bpf/prog_lsm.rst
+++ b/Documentation/bpf/prog_lsm.rst
@@ -18,7 +18,7 @@ LSM hook:
 .. c:function:: int file_mprotect(struct vm_area_struct *vma, unsigned long reqprot, unsigned long prot);
 
 Other LSM hooks which can be instrumented can be found in
-``include/linux/lsm_hooks.h``.
+``security/security.c``.
 
 eBPF programs that use Documentation/bpf/btf.rst do not need to include kernel
 headers for accessing information from the attached eBPF program's context.
diff -- a/Documentation/security/lsm-development.rst b/Documentation/security/lsm-development.rst
--- a/Documentation/security/lsm-development.rst
+++ b/Documentation/security/lsm-development.rst
@@ -11,7 +11,7 @@ that end users and distros can make a mo
 LSMs suit their requirements.
 
 For extensive documentation on the available LSM hook interfaces, please
-see ``include/linux/lsm_hooks.h`` and associated structures:
+see ``security/security.c`` and associated structures:
 
-.. kernel-doc:: include/linux/lsm_hooks.h
-   :internal:
+.. kernel-doc:: security/security.c
+   :export:
diff -- a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -98,7 +98,7 @@ associate these values with real securit
 LSM hooks are maintained in lists. A list is maintained for each
 hook, and the hooks are called in the order specified by CONFIG_LSM.
 Detailed documentation for each hook is
-included in the `include/linux/lsm_hooks.h` header file.
+included in the `security/security.c` source file.
 
 The LSM framework provides for a close approximation of
 general security module stacking. It defines
