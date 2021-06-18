Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729EB3ACD0D
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 16:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhFROHf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 10:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFROHe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 10:07:34 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198ABC061574;
        Fri, 18 Jun 2021 07:05:23 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id q190so8560993qkd.2;
        Fri, 18 Jun 2021 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBxgz/GuZ4v3xbEkFc5a7GzQZl5BNKTGt4qwAs7tMuY=;
        b=WGlOAVwZE5ZRI9DLLeKO/CiuAkZeoi7Zy1IYdctoq5xw/6v8+CrNtcWPjrtJBqWT8G
         LDZOpk2S+ba3XYT13awNywd8R+1Hjt3bMeCIshnd0SVF/y0Whx2IIBpHH+5lIJFrm4sh
         cZdoJsjKgRlMT3vsiEIqRMG4uQY18Iavy1aJ0Bh8+Dl0G19WeFZu+cv0TD9oKBoTSeaU
         lWAiX6sugWE5NjWLo1KMrLfaYLw60PmCiDni4VC8BYQEwcAE+0tUj9Tvg3YjIsycDJpB
         7eq2FlEaj4aZBbnrEeEJ2LtKSMUTSyAjVXAgOpUJ1J9GS2WiKTMBJuzYPZxOyS4Y1yED
         4hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBxgz/GuZ4v3xbEkFc5a7GzQZl5BNKTGt4qwAs7tMuY=;
        b=R4fcyftqtiNCS0jgEgYPgoEDSuVD5bWBaQ1ChYCHExV+5pLLYkbLcx4O44fv9Ahpo2
         SdI+138WcPM+7BrIc2cGdVD6ekM+meHZb8BOFxURmZEaWn3zcavZLoN+l6Z41f0dZiwk
         0UZ2O9wlqlEbxfM3unntmWaA8VlRS+Y0Oq5YoZJLIt+nxwHmLfdAilBQ/fsWTa+Z1kfD
         w8dptY34YYdQEIbW9exKxK41WJgFizUB4rDdrShpom7SyMu4YhztIOUAnT+LPZXrryJi
         3rmIPtHPJhtY7HXBJrrxX2uvVJzvoBZzy1xChsUGrhCpsD4XJOmQhBktj9hZ6rh9c/IW
         Dq8g==
X-Gm-Message-State: AOAM531d9+aSsfiveacDMRgd5Ieb8Rx0S3yGTmU8Pyl80AeXVUxQjo/5
        rrqeaTZp3AR0y30tNApusNdiEtP19o28iPwVpzQ=
X-Google-Smtp-Source: ABdhPJw/VZ/YNksO6xymoUGBpH5aJjOItmHxS8DWW04GSD4Ntqdevm5uMmXw4lI0l0zEkN1w5Cojgw==
X-Received: by 2002:a37:a90f:: with SMTP id s15mr9552326qke.192.1624025122264;
        Fri, 18 Jun 2021 07:05:22 -0700 (PDT)
Received: from localhost.localdomain (pool-108-54-205-133.nycmny.fios.verizon.net. [108.54.205.133])
        by smtp.gmail.com with ESMTPSA id t30sm3974078qkm.11.2021.06.18.07.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 07:05:21 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     andrii@kernel.org, daniel@iogearbox.net, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, grantseltzer@gmail.com,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 0/1] Autogenerating libbpf API documentation
Date:   Fri, 18 Jun 2021 14:04:58 +0000
Message-Id: <20210618140459.9887-1-grantseltzer@gmail.com>
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
 Documentation/bpf/libbpf/libbpf.rst           | 14 +++++++
 Documentation/bpf/libbpf/libbpf_api.rst       | 27 ++++++++++++++
 Documentation/bpf/libbpf/libbpf_build.rst     | 37 +++++++++++++++++++
 .../bpf/libbpf/libbpf_naming_convention.rst   | 30 ++++++---------
 5 files changed, 103 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/bpf/libbpf/libbpf.rst
 create mode 100644 Documentation/bpf/libbpf/libbpf_api.rst
 create mode 100644 Documentation/bpf/libbpf/libbpf_build.rst
 rename tools/lib/bpf/README.rst => Documentation/bpf/libbpf/libbpf_naming_convention.rst (90%)

-- 
2.31.1

