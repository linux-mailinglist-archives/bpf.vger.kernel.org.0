Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10ECD27A2BD
	for <lists+bpf@lfdr.de>; Sun, 27 Sep 2020 21:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgI0Ta0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Sep 2020 15:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbgI0Ta0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 27 Sep 2020 15:30:26 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601235025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F8YPfe0pB7pttwaqfzziE+JMy4Da3EM0z4SpEHDuX4c=;
        b=WpVFPyqWzPEW6+KElUFG6zcwhVFtPC6w6aY0clmdqY60yntEveb6KWdvfIEbqtZxa6LWT4
        H4FjhHddktLV1GAm3zcuofWmawfWa40Px84RuuhnL1fhjGgH7ZfqEShnL0X6M2RzWhgEte
        +0EOs0lKOAkJMemKVLD/XC6ZGEeMoDc=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-HK6mlBFCMY6PyHJr6-cu0A-1; Sun, 27 Sep 2020 15:30:20 -0400
X-MC-Unique: HK6mlBFCMY6PyHJr6-cu0A-1
Received: by mail-oo1-f72.google.com with SMTP id p6so4476192ooo.0
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2020 12:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8YPfe0pB7pttwaqfzziE+JMy4Da3EM0z4SpEHDuX4c=;
        b=hy+7cz3Jxa0f+f+eGlw+lR2vPkQm3fFOW6oaT8rEE6NCNEXo+K73QM8/HbR9QlsPR6
         FnspraPQykKEIT5bw0ltw0ZlqUO2lINdes5yO6D4P4MIn4PM+NA0wm64+JcvKFaXM06A
         gvX7Ftak66G8zVOFZKFVQVYPkJZvLITeitA8bYHfVU2jcTBLldkZ4cry2wYw4D0kcz5o
         LtmkCyVIeT9di3cafewlX/5auc1cI+CdF3RzjMsRjSWIa57v5tse+g3Pga6TQ2uI+CC6
         SYYIwojW3x15QTIrSdX/sKXKC1RiT6J7LNqXWOVzRia6gWwk7x9eXZLXwmiZKumtE+TY
         hw5w==
X-Gm-Message-State: AOAM5338Hn63/gZBrPNahdkLmsqzImEsrCIg3C6ARoOqT8CnzKj/yeSG
        uVa6zKjqg0Z31yognEoUHxVVSWp3vNed/7b5r5sr8O1MKn3TXqPg+vAUd9T7dyZ/W4PBUEKGX8j
        5MtrN3OIyH7tr
X-Received: by 2002:a54:4413:: with SMTP id k19mr3870979oiw.99.1601235019958;
        Sun, 27 Sep 2020 12:30:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhMfHlnktI/H8l8W2NHAHbIzvYQaA+JpsCtebgm3/8addT7JwxOQ6O7iu1zQlgZBClObCubA==
X-Received: by 2002:a54:4413:: with SMTP id k19mr3870966oiw.99.1601235019591;
        Sun, 27 Sep 2020 12:30:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w20sm2323387otk.24.2020.09.27.12.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:30:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 02EED183C5B; Sun, 27 Sep 2020 21:30:16 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next] bpf/preload: make sure Makefile cleans up after itself, and add .gitignore
Date:   Sun, 27 Sep 2020 21:30:05 +0200
Message-Id: <20200927193005.8459-1-toke@redhat.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The Makefile in bpf/preload builds a local copy of libbpf, but does not
properly clean up after itself. This can lead to subsequent compilation
failures, since the feature detection cache is kept around which can lead
subsequent detection to fail.

Fix this by properly setting clean-files, and while we're at it, also add a
.gitignore for the directory to ignore the build artifacts.

Fixes: d71fa5c9763c ("bpf: Add kernel module with user mode driver that populates bpffs.")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/preload/.gitignore | 4 ++++
 kernel/bpf/preload/Makefile   | 2 ++
 2 files changed, 6 insertions(+)
 create mode 100644 kernel/bpf/preload/.gitignore

diff --git a/kernel/bpf/preload/.gitignore b/kernel/bpf/preload/.gitignore
new file mode 100644
index 000000000000..856a4c5ad0dd
--- /dev/null
+++ b/kernel/bpf/preload/.gitignore
@@ -0,0 +1,4 @@
+/FEATURE-DUMP.libbpf
+/bpf_helper_defs.h
+/feature
+/bpf_preload_umd
diff --git a/kernel/bpf/preload/Makefile b/kernel/bpf/preload/Makefile
index 12c7b62b9b6e..23ee310b6eb4 100644
--- a/kernel/bpf/preload/Makefile
+++ b/kernel/bpf/preload/Makefile
@@ -12,6 +12,8 @@ userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
 
 userprogs := bpf_preload_umd
 
+clean-files := $(userprogs) bpf_helper_defs.h FEATURE-DUMP.libbpf staticobjs/ feature/
+
 bpf_preload_umd-objs := iterators/iterators.o
 bpf_preload_umd-userldlibs := $(LIBBPF_A) -lelf -lz
 
-- 
2.28.0

