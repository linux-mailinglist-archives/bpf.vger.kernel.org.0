Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A759DA8E1
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2019 11:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392518AbfJQJoV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 05:44:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44404 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfJQJoU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 05:44:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id q12so1314719lfc.11
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2019 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gjRLh3ZcHVbp8CVYzPr5W3pE+xU7QVAz8dPx2MfpQLA=;
        b=WNSOU3TA99ip8tshnEjHz2ZPUgB9sJwDX90ocoyj8ueZfUfavv3urILdXBdX2IlLsk
         /lLcCEz9vZX2W0lBFQueDHLzaGE1oADcgXEcUbk1Dn0DXEaP+5pAd12bJINYMvYarKpc
         i6CGG3sAN5y6NoSgMDn19gwmuKKQTSO9NDdL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gjRLh3ZcHVbp8CVYzPr5W3pE+xU7QVAz8dPx2MfpQLA=;
        b=Vs90P8xI4E+zxRVxA634xV0QH4XUc+i62TmGLJFsrAU94GPwjxp2jI/Ky4/XWyu7h5
         7JQ8W6gtIwsVfAGaVIC4c4NA3LNlDL1lBSV/L2Q1NwVMEfHxUt6z3dA3Vw4y4GU2SY7s
         2aZrAGaQ48oSVC+/V1a352iAigg39+ochxGLkBe8cBXQ98SaSfadbJOCpBPXl/Vyx5VU
         oKrpiocmyuZ54XaLRGosynJfcJ5ipl75yXkkdRVoZWnGsm9KJa6CnKsA+IYuqifC8oe9
         DommjNFwiLsjueYc/Iv2webAgxb6EjquLl8Lrtsw/6hegTOmWxf7xBEsAv35YTWKMZq6
         ki9Q==
X-Gm-Message-State: APjAAAW4dp1vz096iEZL/cGvYWsbdfvUG8EVifv33DpKb8X8yC413n+Z
        kUW7qcObhOH51/VGuqZlHDdG1Y5Xh6Z2oA==
X-Google-Smtp-Source: APXvYqyhs15euRvXnpel0la1SCD2VD/Py1HLu2uTVDba4Arg/jNVmKOthPwqGvlha8JObrOd8Sra5g==
X-Received: by 2002:ac2:410e:: with SMTP id b14mr1652775lfi.110.1571305458093;
        Thu, 17 Oct 2019 02:44:18 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id s27sm687616lfc.43.2019.10.17.02.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 02:44:17 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next] scripts/bpf: Print an error when known types list needs updating
Date:   Thu, 17 Oct 2019 11:44:16 +0200
Message-Id: <20191017094416.7688-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't generate a broken bpf_helper_defs.h header if the helper script needs
updating because it doesn't recognize a newly added type. Instead print an
error that explains why the build is failing and stop.

Fixes: 456a513bb5d4 ("scripts/bpf: Emit an #error directive known types list needs updating")
Suggested-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 scripts/bpf_helpers_doc.py | 4 ++--
 tools/lib/bpf/Makefile     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

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
index 75b538577c17..26c202261c5f 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -169,7 +169,8 @@ $(BPF_IN): force elfdep bpfdep bpf_helper_defs.h
 
 bpf_helper_defs.h: $(srctree)/include/uapi/linux/bpf.h
 	$(Q)$(srctree)/scripts/bpf_helpers_doc.py --header 		\
-		--file $(srctree)/include/uapi/linux/bpf.h > bpf_helper_defs.h
+		--file $(srctree)/include/uapi/linux/bpf.h > $@.tmp
+	@mv $@.tmp $@
 
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
-- 
2.20.1

