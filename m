Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDB43ABB4F
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 20:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhFQSWk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 14:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFQSWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 14:22:40 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C3BC061574;
        Thu, 17 Jun 2021 11:20:31 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id o19so5491211qtp.5;
        Thu, 17 Jun 2021 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uYPMz5Mv0J0ymLCQsB4kPRIk/O9U9hLnof6gewldmBU=;
        b=rCqHN6SXOdY4ZINe831Hk6B1hE8bIyKQ4KPB1cwS5oHLt+UvsAnTG9b8YotOr/j/Ud
         9rRQQKk22W9LqZeb1qF5bDIBshNTPRgJuvmPY+TFkTye3e1FPLB0XqmYy8T3IzIouwYk
         csDb3Mvh2f8sQm271mLcV+EOcwuD7KBMoBwB90ZKWsZjbqb9I4eMGAudct0Yh9tBy1NR
         yU8o2WrX3clnCYPja7w2Wxn9FNLmhj29U3ag1HkKjrP8NLxuFRgznvg6YQI6AL99RnGW
         byldVG21mGHKBVXiP1S2Gv/JALw4sNioFocixnkUDXaT6KLMWxmO5FKvZWOHv0KTRE7I
         TKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uYPMz5Mv0J0ymLCQsB4kPRIk/O9U9hLnof6gewldmBU=;
        b=oxgFVsAqIcnoE24nY4SfNnAASzTE1OOHeOKRMd/qS3UiBt/34RUtUaUVdGGDNFvGZI
         8zNxeM5QTvez9ofv8crZN60gj1c/QURxGkqQPMH8VQHdPssz+/PXevAuZk09A0to/Qjs
         siBwmZVXiAQyWt/CwfYG6viBCQgY6S0EQQQL9W037IgdGrWH4GhjMM9cKvfwyyV5byu3
         tNe/QzKbDevwc9NY4xfHcuhaDEwcpS4MZ9sqGqe3cYURNherh0jaXU5iXM/0R4zd9xBT
         2RJY/9e5tr1g9s5NNe7qgZhcFocW8BmKMtFYYC5pnSKM2vrq/2kzsOaCeuDySBSLmxlh
         rVEg==
X-Gm-Message-State: AOAM530jaDEEEb5odVy7PZXGn6Zd8V0rqtR0lNccSVZoT5UtCvjqQKHL
        pxmA5vQvb2eznCavMpSUfJQ=
X-Google-Smtp-Source: ABdhPJx5feXTlnaCYqMCz768vCbDTUw/7quDkDzNnSW/MP8BbzxCerbXxKsYvgT497M/52Qo3+ooyQ==
X-Received: by 2002:a05:622a:1302:: with SMTP id v2mr6407137qtk.70.1623954030592;
        Thu, 17 Jun 2021 11:20:30 -0700 (PDT)
Received: from localhost.localdomain (pool-108-54-205-133.nycmny.fios.verizon.net. [108.54.205.133])
        by smtp.gmail.com with ESMTPSA id v32sm3841624qtc.95.2021.06.17.11.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 11:20:30 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org, daniel@iogearbox.net, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, grantseltzer@gmail.com,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 0/1] Autogenerating libbpf API documentation
Date:   Thu, 17 Jun 2021 18:20:22 +0000
Message-Id: <20210617182023.8137-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series is meant to start the initiative to document libbpf.
It includes .rst files which are text documentation describing building,
API naming convention, as well as an index to generated API documentation.

In this approach the generated API documentation is enabled by the kernels
existing kernel documentation system which uses sphinx. The resulting docs
would then be synced to kernel.org/doc

You can test this by running `make htmldocs` and serving the html in
Documentation/output. Since libbpf does not yet have comments in kernel
doc format, see kernel.org/doc/html/latest/doc-guide/kernel-doc.html for
an example so you can test this.

The advantage of this approach is to use the existing sphinx
infrastructure that the kernel has, and have libbpf docs in
the same place as everything else.

The current plan is to have the libbpf mirror sync the generated docs 
and version them based on the libbpf releases which are cut on github.

grantseltzer (1):
  Add documentation for libbpf including API autogen

 Documentation/bpf/index.rst                   | 13 +++++++
 Documentation/bpf/libbpf.rst                  | 14 +++++++
 Documentation/bpf/libbpf_api.rst              | 27 ++++++++++++++
 Documentation/bpf/libbpf_build.rst            | 37 +++++++++++++++++++
 .../bpf/libbpf_naming_convention.rst          | 32 +++++++---------
 5 files changed, 104 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/bpf/libbpf.rst
 create mode 100644 Documentation/bpf/libbpf_api.rst
 create mode 100644 Documentation/bpf/libbpf_build.rst
 rename tools/lib/bpf/README.rst => Documentation/bpf/libbpf_naming_convention.rst (89%)

-- 
2.31.1
