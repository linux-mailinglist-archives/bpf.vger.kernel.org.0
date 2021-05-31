Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78043396891
	for <lists+bpf@lfdr.de>; Mon, 31 May 2021 21:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhEaT5x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 May 2021 15:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhEaT5w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 May 2021 15:57:52 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE10C061574;
        Mon, 31 May 2021 12:56:11 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id m13so8605916qtk.13;
        Mon, 31 May 2021 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CgVBqkQLZmOYqPkge4g0jcqhV/Khxx+58SBmawGWouA=;
        b=AaVt4mkEetpGQ/YDrne8rVrkdxgcLFaCcuqa2pUcjTewMqFwyyZeI3SY0T0RrYtmQP
         1y2kNQ8bzSEPhTp1qjdbtjIgpETUH7hV4h6TM03iVwy+obHyh+SrAcD7YVGTOnfuvk62
         FBdXLObEgGd5zZr9fT9/S3m6iLu/6ddkiknGcsvq0VMhfchzkEwhbBXdnu2akeMFf9V2
         xezfBqo4E9/O6GWrK5Ys3xDY7v5O7BLR2uW7GdhQEhLGL1QjAfvgpdjr47FPD6FKEf35
         o6In377vVYEC5nEysyzrFo9w7TYxa8r8Yk5Ka0fW9ZIrEB1pxu9O6GMnUFSovgSCEkZs
         X8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CgVBqkQLZmOYqPkge4g0jcqhV/Khxx+58SBmawGWouA=;
        b=X83zDBRQPnx/5bT7ABZoE9gIlXfDQ5oES0ll0bXalakHRh4lyClBUZgviVoACI5esz
         M6oMl6PYCPjgImQQrx2VTMeK8+I9uvVdlFkj6HZBGV3bpmAsEQTw97tbJmleVcMLzKn9
         EVcIskLraiyGeRM+UndjD8TBIZpKHkDuWZZ1fwKocaTb5BzGgKxV4QoF9YFN+UHE1CX2
         94Qj41IKuRQ5oBlX8LVELgE3dVXhReNFaSghufeinf9Ppf7u89XwlCyZ/fZ9UrPq9AqO
         ZzNoIrklhClebJPBpJ5nJWwoJinLZPoIP9WU/13nmNlDCf59HmXwWCqKwTajGhxWAtpW
         fOPQ==
X-Gm-Message-State: AOAM532iIMAKQkTUXJRJLBayf174y3ZfQ3rDXCZgmfRsH5HXGzRgRBKP
        FhSsJgd8PF6a/us6b6R+zwUmqDofsdUaiQxz
X-Google-Smtp-Source: ABdhPJxnnTX9v6s/AghcsXuakbSWvaFzCo2NeHxn03hMexmFROnoVK+PRmrMFVhsN0Ct03xtXU3MEQ==
X-Received: by 2002:ac8:4ccb:: with SMTP id l11mr11402701qtv.127.1622490970809;
        Mon, 31 May 2021 12:56:10 -0700 (PDT)
Received: from localhost.localdomain (pool-108-54-205-133.nycmny.fios.verizon.net. [108.54.205.133])
        by smtp.gmail.com with ESMTPSA id d18sm9939549qkc.28.2021.05.31.12.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:56:10 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org, daniel@iogearbox.net, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, grantseltzer@gmail.com,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/2] Autogenerating libbpf API documentation
Date:   Mon, 31 May 2021 19:55:51 +0000
Message-Id: <20210531195553.168298-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.29.2
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

The perhaps large disadvantage of this approach is that libbpf versions
independently from the kernel. If it's possible to version libbpf
separately without having duplicates that would be the ideal scenario.

grantseltzer (2):
  Add documentation for libbpf including API autogen
  Remove duplicate README doc from libbpf

 Documentation/bpf/index.rst                   | 13 +++++++
 Documentation/bpf/libbpf.rst                  | 14 +++++++
 Documentation/bpf/libbpf_api.rst              | 18 +++++++++
 Documentation/bpf/libbpf_build.rst            | 37 +++++++++++++++++++
 .../bpf/libbpf_naming_convention.rst          | 20 +++++-----
 5 files changed, 93 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/bpf/libbpf.rst
 create mode 100644 Documentation/bpf/libbpf_api.rst
 create mode 100644 Documentation/bpf/libbpf_build.rst
 rename tools/lib/bpf/README.rst => Documentation/bpf/libbpf_naming_convention.rst (96%)

-- 
2.29.2

