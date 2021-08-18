Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BFC3F07A2
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239837AbhHRPO3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbhHRPO3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Aug 2021 11:14:29 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48075C0617AD;
        Wed, 18 Aug 2021 08:13:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l24so1811273qtj.4;
        Wed, 18 Aug 2021 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVCKykayEvXKVpNVfN4++L+SwCZYLayULNX7RQmbrok=;
        b=oFN+Xg1BFqxHLaDXI3RvACmAAxzJAWNUJUkVNGUIDUmWy14DvyzCtds/hhqC+jda65
         2MueVwL4IHg0PXBYigkmQeCoNSsf6dUAKz6SMpI34QIaeBx1qZ6lv33HkYM50f1fwrFd
         UcfkVwkiLopgPONHy9CR+FlWTDtctU9HM6b03V1vGtcqcEsXLO7NlDgA+r2kjtQjLTY6
         2i+yfbdllkzoBfNDBZuKn1Zb7Pi3JQ5WETID8qnVBr0ijo5KQIjSvocmqhhJNQ6+uluP
         9mfpO45OF7WrDpxakuQdTfH3FNJUoNmzFnP9OS/KFoJ4FcgzpEWbGgl89pY0mCt4A1Ko
         OgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVCKykayEvXKVpNVfN4++L+SwCZYLayULNX7RQmbrok=;
        b=F2ImFBd65ngwtGnydXZbGOFiWG93oRbD3hNp2eEeKSo/IDMthtKH5YIPung+lmNLJM
         /ECDH9NwBEZAywVaby5/Iplhpv6vkRQg7uT9s7NNnYQdjsvhFU9+VSw5gpLhYmqbbokC
         ItHqbWXdY+xtAUggy+l/cT/ug4f558UWNMz0ks8nm9eXQRoq2SCnJniwlu55KlaJc8Zj
         qtqQ8SUaFOBOsz51G6svgGUR5w1dh6DNdb0uHSSwB18BbtwoL55xmwfFCLq8ePunj/rL
         TQx6guem45/UPaH4iuwLUuMOJetQbafx5FoQCOotViFug0X6ED761s5aVSEpzCG0wkEY
         tdwg==
X-Gm-Message-State: AOAM532FRiTCciM5CQDGLKze3csb0o9VqFzstRB+Y8/15S9nGcORCZkK
        g8KZKU3ee8fBDPb6x2Se8q8=
X-Google-Smtp-Source: ABdhPJyUdBH95XtiwZdV00IvNbeDrREQM77UQzy9t2JMppv6Pw/P7HvQn2y6HP/KedPEVWLuTgVjiA==
X-Received: by 2002:ac8:53d6:: with SMTP id c22mr1287772qtq.38.1629299633413;
        Wed, 18 Aug 2021 08:13:53 -0700 (PDT)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id g12sm111556qtq.92.2021.08.18.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 08:13:52 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        grantseltzer@gmail.com
Subject: [PATCH] Rename libbpf documentation index file
Date:   Wed, 18 Aug 2021 11:13:13 -0400
Message-Id: <20210818151313.49992-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Grant Seltzer <grantseltzer@gmail.com>

This patch renames a documentation libbpf.rst to index.rst. In order
for readthedocs to pick this file up and properly build the
documentation site.

It also changes the title type of the ABI subsection in the
naming convention doc. This is so that readthedocs doesn't treat this
section as a seperate document.

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 Documentation/bpf/libbpf/{libbpf.rst => index.rst}    | 8 ++++++++
 Documentation/bpf/libbpf/libbpf_naming_convention.rst | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)
 rename Documentation/bpf/libbpf/{libbpf.rst => index.rst} (75%)

diff --git a/Documentation/bpf/libbpf/libbpf.rst b/Documentation/bpf/libbpf/index.rst
similarity index 75%
rename from Documentation/bpf/libbpf/libbpf.rst
rename to Documentation/bpf/libbpf/index.rst
index 1b1e61d5ead1..4f8adfc3ab83 100644
--- a/Documentation/bpf/libbpf/libbpf.rst
+++ b/Documentation/bpf/libbpf/index.rst
@@ -3,6 +3,14 @@
 libbpf
 ======
 
+For API documentation see the `versioned API documentation site <https://libbpf.readthedocs.io/en/latest/api.html>`_.
+
+.. toctree::
+   :maxdepth: 1
+
+   libbpf_naming_convention
+   libbpf_build
+
 This is documentation for libbpf, a userspace library for loading and
 interacting with bpf programs.
 
diff --git a/Documentation/bpf/libbpf/libbpf_naming_convention.rst b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
index 6bf9c5ac7576..9c68d5014ff1 100644
--- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst
+++ b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
@@ -69,7 +69,7 @@ functions. These can be mixed and matched. Note that these functions
 are not reentrant for performance reasons.
 
 ABI
-==========
+---
 
 libbpf can be both linked statically or used as DSO. To avoid possible
 conflicts with other libraries an application is linked with, all
-- 
2.31.1

