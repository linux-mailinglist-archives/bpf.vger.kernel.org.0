Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E28C9A31
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2019 10:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfJCIoE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Oct 2019 04:44:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfJCIoE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Oct 2019 04:44:04 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E805A89AC0
        for <bpf@vger.kernel.org>; Thu,  3 Oct 2019 08:44:03 +0000 (UTC)
Received: by mail-lj1-f199.google.com with SMTP id y12so614687ljc.8
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2019 01:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PzHNU38txAalUSBk1bXYsOjn6NQRGTI31cw8NynxL64=;
        b=s8WEYxy/Q1ykX8tABL8xvXOP2dP91IxTLsjEHKgTkXmdsRPFtFYMOedAbA95te04aA
         8qMXMsgLj2B4FFvyfHL3hsgDJAwamxjBF6yzySQj+NvtXqXvxmD6aUHRJAnd8ae1XLSy
         iZ6+GROS4dWLy9BB64fjlt1fitG9lMwxur7OoK4HvxLd0vWAPUuuPL9mueQUwrKoNeFY
         afie2aMQejqbF4tgb4JcDwmEXO8Wurajsg0ocqw3+Ohjk5Q5p6cud61ePpDuWg32D7B5
         Mj7kNeD3o41xQOYVm23Y2xNEColLJfGGPHFF79SBqb6J7OgbfpwqAepCKUqqJTrcmeYZ
         hpXw==
X-Gm-Message-State: APjAAAXUbw8cWjcD0wUezZvvlULChUHPPwkn5DjSg0m3wTEzSp6tRsI4
        bLISvLQqqP/Cv0v+czbpHcWZ/X8rjEUZV7XjDqlvJJZ3Cv6eVH7zeAWXenvp72gD0pmRCUc3O4T
        nq7adOkfKW5+p
X-Received: by 2002:ac2:554e:: with SMTP id l14mr5402763lfk.32.1570092242528;
        Thu, 03 Oct 2019 01:44:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzymPFpuHFhKyn5oDKRe5DTDqE/dYm4jA2UMZk2t+bMfLInhNq6QEEiptCNN8oaPdEOGvNveQ==
X-Received: by 2002:ac2:554e:: with SMTP id l14mr5402755lfk.32.1570092242360;
        Thu, 03 Oct 2019 01:44:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id w30sm308525lfn.82.2019.10.03.01.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 01:44:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4D69018063D; Thu,  3 Oct 2019 10:44:00 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        andriin@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Add cscope and TAGS targets to Makefile
Date:   Thu,  3 Oct 2019 10:43:21 +0200
Message-Id: <20191003084321.1431906-1-toke@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using cscope and/or TAGS files for navigating the source code is useful.
Add simple targets to the Makefile to generate the index files for both
tools.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/.gitignore |  2 ++
 tools/lib/bpf/Makefile   | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/.gitignore b/tools/lib/bpf/.gitignore
index d9e9dec04605..c1057c01223e 100644
--- a/tools/lib/bpf/.gitignore
+++ b/tools/lib/bpf/.gitignore
@@ -3,3 +3,5 @@ libbpf.pc
 FEATURE-DUMP.libbpf
 test_libbpf
 libbpf.so.*
+TAGS
+cscope.*
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index c6f94cffe06e..57df6b933196 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -262,7 +262,7 @@ clean:
 
 
 
-PHONY += force elfdep bpfdep
+PHONY += force elfdep bpfdep cscope TAGS
 force:
 
 elfdep:
@@ -271,6 +271,14 @@ elfdep:
 bpfdep:
 	@if [ "$(feature-bpf)" != "1" ]; then echo "BPF API too old"; exit 1 ; fi
 
+cscope:
+	(echo \-k; echo \-q; for f in *.c *.h; do echo $$f; done) > cscope.files
+	cscope -b -f cscope.out
+
+TAGS:
+	rm -f TAGS
+	echo *.c *.h | xargs etags -a
+
 # Declare the contents of the .PHONY variable as phony.  We keep that
 # information in a variable so we can use it in if_changed and friends.
 .PHONY: $(PHONY)
-- 
2.23.0

