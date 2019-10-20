Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD18DDE3D
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2019 13:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfJTLXt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Oct 2019 07:23:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39335 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfJTLXt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Oct 2019 07:23:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so10394710ljj.6
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2019 04:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bI7fDg3piH2PEA50mu43QODUSb3zs/BzZxjL1mHMsMU=;
        b=DevZ/X0upiiR3NhcJancDyO/V58XLVA5TODsrIigL6DwdwJYybr1uXBJLt9NjCC1He
         xe437BCKrfQ8kJbBYQ/xIwVML595ff1SqouiiTLQOaxZDGrLUPlaenoLYjzL4bYHJijl
         u8sN1Kh3Ta1FFMb0uqwENfDRqNWa+HvDKOw9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bI7fDg3piH2PEA50mu43QODUSb3zs/BzZxjL1mHMsMU=;
        b=HcslC82PD5hi6rLb3vf6RD5WhlF+9anYiIAF0hQ7RVL9SKJ7CeNBKrJnzdWqUc45Y+
         B5jbTAD9Ruqu4tjakIwEGarE/qYa3HSErYjErGUOAdzXnTCdT0QkbTA+duOKIGRmGSU5
         Z+rVOF9LvCqylIC93Z1NsgIpV6aWgv0d/czYhBAq753eh2LptVtCGXHRGhmdWUfaWrOq
         uiabW2j9m152P0IBLOs8Effj9rizJmYpMUU8S2JmFh/e+uA8iTmHOKXaKjAinElArANU
         wwJtVPMLqcMD+ipuyl2qNNQURB/FCKyDf6of0OLB5vXfi5ZQFVTPa9YdDcFwUbiX6Q/y
         tSFw==
X-Gm-Message-State: APjAAAXhC/mnwNHxNLyEdZAsGaey5KGeudkS90gdyM6p5A3rGDUGb4/7
        EjBczNoswBXqfvuWropfMyBsbNQJdrOzKQ==
X-Google-Smtp-Source: APXvYqyDPkoVlT/3odGDLg6saAfhUXeEKNO40Jur9V2PZPvGP7JqXGohlGLQ9cDmLcB3zNIU+uHwnA==
X-Received: by 2002:a2e:5354:: with SMTP id t20mr11547356ljd.227.1571570626932;
        Sun, 20 Oct 2019 04:23:46 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id n28sm5000749lfi.58.2019.10.20.04.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 04:23:46 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v2] scripts/bpf: Print an error when known types list needs updating
Date:   Sun, 20 Oct 2019 13:23:44 +0200
Message-Id: <20191020112344.19395-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't generate a broken bpf_helper_defs.h header if the helper script needs
updating because it doesn't recognize a newly added type. Instead print an
error that explains why the build is failing, clean up the partially
generated header and stop.

v1->v2:
- Switched from temporary file to .DELETE_ON_ERROR.

Fixes: 456a513bb5d4 ("scripts/bpf: Emit an #error directive known types list needs updating")
Suggested-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 scripts/bpf_helpers_doc.py | 4 ++--
 tools/lib/bpf/Makefile     | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 08300bc024da..7548569e8076 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -488,8 +488,8 @@ class PrinterHelpers(Printer):
             return t
         if t in self.mapped_types:
             return self.mapped_types[t]
-        print("")
-        print("#error \"Unrecognized type '%s', please add it to known types!\"" % t)
+        print("Unrecognized type '%s', please add it to known types!" % t,
+              file=sys.stderr)
         sys.exit(1)
 
     seen_helpers = set()
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 75b538577c17..54ff80faa8df 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -286,3 +286,6 @@ tags:
 # Declare the contents of the .PHONY variable as phony.  We keep that
 # information in a variable so we can use it in if_changed and friends.
 .PHONY: $(PHONY)
+
+# Delete partially updated (corrupted) files on error
+.DELETE_ON_ERROR:
-- 
2.20.1

