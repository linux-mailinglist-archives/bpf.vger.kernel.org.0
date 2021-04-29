Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D7E36F230
	for <lists+bpf@lfdr.de>; Thu, 29 Apr 2021 23:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbhD2Vlr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Apr 2021 17:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbhD2Vlq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Apr 2021 17:41:46 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BA3C06138B
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 14:40:58 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id q127so9612323qkb.1
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rn0CmnefdhrS2EmYI8qB4KGZJ2aWwAPzSLVHIcPUm4Y=;
        b=hQ45zGMt2zyS8dM6KsO4c13sO1V9/9cFuwpEJSjh1WSNej4KjKEg5QwvIDG67iXlBm
         HBBQf/Jr6RZIiAMrmwfQy/Ja1UJ7bx5+d8eh5KOnjPwc6GOVEhxFYQUljA45Dw2gJHRM
         z3GvyFkdMVpxCef8lGbEBByGrdha26yCGD63cF/dXbpaSAFA+N3JmSn0UPgm5LWtiQWb
         rhsQiYyCf5jNmJ7B8etg3f+9GzCRFuPAUjwpx2kmJFItD55MqqIzeKxELxbR2rMVfK5p
         slRlST8QYOEB2PLzmWbXG+RyildEbTWbOmYgmnwfgs6WIqi+s3YAIwMMUXCj2ZD20x/+
         PJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rn0CmnefdhrS2EmYI8qB4KGZJ2aWwAPzSLVHIcPUm4Y=;
        b=CDBXl+Abxk37ypYGFfcXlq8QCQ9GnqFFhjB1zYcnt0JlPcMWGPmGC0hESdMU9UBNv8
         KUZx7+7cVNKw3PVTiidPP28KpBH8VslxRZRcePfdoUs7yOEONOhWvhg8azv/9sEK8M5C
         NMyxcY7j1dD8aQfm8aeZVvxSP/ksqFJPYHv+8mgo92nT3EBfHeLBSLNKW1GznQx495TZ
         NLtRrRhmOnqiUfBV1A/nFggSF2fvBiMXSPRx7AxyJRTqnPjy8lhZn4ksCngXoWOvDmEX
         JXyuYHYS6cdKnSL9n9F7GVuHTBlPYwrfXuKfAabDCY+3d+TEPnobXDd66YtIuy/q9d9y
         qFPA==
X-Gm-Message-State: AOAM530Z4fwhTMbO6qJiP3RdyBDvzJzjE9dAAGzuL3VNazWwIbugDoqF
        i3GVkyRLWGGdLsBpD01hlhE=
X-Google-Smtp-Source: ABdhPJxOe/1w5v/uAQSTzw/bSep6kOy5aHAgZIZ8MTiMincZ55G7+tLs+Z0OgEqnBY/6E8fw5Qii7w==
X-Received: by 2002:a37:7701:: with SMTP id s1mr1902755qkc.291.1619732457991;
        Thu, 29 Apr 2021 14:40:57 -0700 (PDT)
Received: from localhost.localdomain (pool-100-33-2-40.nycmny.fios.verizon.net. [100.33.2.40])
        by smtp.gmail.com with ESMTPSA id m16sm2993869qkm.100.2021.04.29.14.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 14:40:57 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org, daniel@iogearbox.net
Cc:     grantseltzer@gmail.com, bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/3] Autogenerating API documentation
Date:   Thu, 29 Apr 2021 05:47:31 +0000
Message-Id: <20210429054734.53264-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series of patches is meant to start the initiative to document libbpf.
It includes .rst files which are text documentation describing building, 
API naming convention, as well as an index to generated API documentation.

The generated API documentation is enabled by Doxygen, which actually 
parses the code for documentation comment strings and generates XML.
A tool called Sphinx then reads this XML with the help of the breathe
plugin, as well as the above mentioned .rst files and generates beautiful
HTML output.

The goal of this is for readthedocs.io to be able to pick up that generated
documentation which will be made possible with the help of readthedoc's 
github integration and libbpf's official github mirror. Minor setup 
is required in that mirror once this patch series is merged.

grantseltzer (3):
  bpf: Add sphinx documentation build files
  bpf: Add doxygen configuration file
  bpf: Add rst docs for libbpf

 tools/lib/bpf/docs/api.rst                    |  60 ++++
 tools/lib/bpf/docs/build.rst                  |  39 +++
 tools/lib/bpf/docs/conf.py                    |  38 +++
 tools/lib/bpf/docs/index.rst                  |  21 ++
 .../naming_convention.rst}                    |  18 +-
 tools/lib/bpf/docs/sphinx/Makefile            |   9 +
 tools/lib/bpf/docs/sphinx/doxygen/Doxyfile    | 320 ++++++++++++++++++
 tools/lib/bpf/docs/sphinx/requirements.txt    |   1 +
 8 files changed, 499 insertions(+), 7 deletions(-)
 create mode 100644 tools/lib/bpf/docs/api.rst
 create mode 100644 tools/lib/bpf/docs/build.rst
 create mode 100644 tools/lib/bpf/docs/conf.py
 create mode 100644 tools/lib/bpf/docs/index.rst
 rename tools/lib/bpf/{README.rst => docs/naming_convention.rst} (97%)
 create mode 100644 tools/lib/bpf/docs/sphinx/Makefile
 create mode 100644 tools/lib/bpf/docs/sphinx/doxygen/Doxyfile
 create mode 100644 tools/lib/bpf/docs/sphinx/requirements.txt

-- 
2.29.2

