Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4605E242D5B
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 18:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgHLQdS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 12:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgHLQdR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 12:33:17 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D99AC061386;
        Wed, 12 Aug 2020 09:33:17 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j23so1409890vsq.7;
        Wed, 12 Aug 2020 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zVIJDDFQTLQ+d3i+TnZGWfN6fBF17Z8BnHl3szZTvM=;
        b=Fw1fncLs9N0kOhyZ+y18hlRkHqKcJsry/P/47v6+jAjql6/8ZUL4A4Se0c3lf2xwOx
         eimAsYjEyPSpGcPJ5kxovhXZbLs2rcCSUsf3LeyYgQyAKHfiIqJcTKMOSaqz/cl+Ox03
         Qgar/Wi6fPaUpyQoFHmg/GMMDbgdmSG5NWMX7v6dXFiMKWtiqKeB2E7gS+PDqHe3Y5pn
         Nsm137JZeHulxYD8gDcHeaLiyQ7Iuf4wu9MCq5tyVQ7RxaJUoCWGUuKdcNY658yZlVJe
         J2AwGaxihGAF0XAdsgIkPDIlnPPgv2Lxo3SxaYZdNi8z4xmkf79y8R0uYIvV7TkwW3Iu
         jRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zVIJDDFQTLQ+d3i+TnZGWfN6fBF17Z8BnHl3szZTvM=;
        b=NXdnMLn1JjGqixJHby0oJ0aK20q+vKN6FHXIQaNqc30wZksGucgLH/r81gaQ1vHmDx
         yX60sAI7+p81XfuXhsdm5pSuhYfMI0PGs0G3aBqU2dcpjq5xLMImLAXUzDO7nxn2lRnq
         zR59u4OvP0OaHH8fYJ6df0t+j1n4JKPvmcUufTIZrmdJ88lAKoCtpk773/VheWPR2IvS
         3Lf+TPelFmlrhCl4PK8wBHF0Wd8HkNuJmQZ4EENaN9eIB5/nYkgaQjenbitRsYysXNLB
         54n+zowOxnZA09YHqYp68k+dlpaalllYWzF6ohVRp8fA49yN9Vdjxif2l6D9ABOvaIyq
         ySrg==
X-Gm-Message-State: AOAM530ZMJkBggVQt2RskrB/zwhwJdp4fA52EGcPCtr5++SvarIo2VZT
        lwz0+IR7mtg/ZhigODvY0dcCceGHt5M=
X-Google-Smtp-Source: ABdhPJymvgvpqfjRrlFIKo2KP4YxXOKSnw/sjxNdmdQJWAB+l5ralqX/jDuM9CNmYwdU+sQ0ZKTn3g==
X-Received: by 2002:a67:ce12:: with SMTP id s18mr981167vsl.116.1597249996383;
        Wed, 12 Aug 2020 09:33:16 -0700 (PDT)
Received: from ebpf-cloudtop.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.googlemail.com with ESMTPSA id e8sm245374uar.11.2020.08.12.09.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:33:16 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     bpf@vger.kernel.org, linux-block@vger.kernel.org
Cc:     leah.rumancik@gmail.com, orbekk@google.com, harshads@google.com,
        jasiu@google.com, saranyamohan@google.com, tytso@google.com,
        bvanassche@google.com
Subject: [RFC PATCH 3/4] bpf: add eBPF IO filter documentation
Date:   Wed, 12 Aug 2020 16:33:04 +0000
Message-Id: <20200812163305.545447-4-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
In-Reply-To: <20200812163305.545447-1-leah.rumancik@gmail.com>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add page in Documentation/block describing overview of IO filter

Signed-off-by: Kjetil Ørbekk <orbekk@google.com>
Signed-off-by: Harshad Shirwadkar <harshads@google.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 Documentation/block/bpf_io_filter.rst | 28 +++++++++++++++++++++++++++
 Documentation/block/index.rst         |  1 +
 2 files changed, 29 insertions(+)
 create mode 100644 Documentation/block/bpf_io_filter.rst

diff --git a/Documentation/block/bpf_io_filter.rst b/Documentation/block/bpf_io_filter.rst
new file mode 100644
index 000000000000..956997576ae5
--- /dev/null
+++ b/Documentation/block/bpf_io_filter.rst
@@ -0,0 +1,28 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+IO Filtering with eBPF
+======================
+
+Bio requests can be filtered with the eBPF IO filter program type (BPF_PROG_TYPE_IO_FILTER). To use this program type, the kernel must be compiled with CONFIG_BPF_IO_FILTER.
+
+Attachment
+==========
+
+IO filter programs can be attached to disks using the  BPF_BIO_SUBMIT attach type. Up to 64 filter programs can be attached to a single disk. References to the attached programs are stored in the gendisk struct as a bpf_prog_array.
+
+API
+===
+
+Data is passed between the userspace and kernel eBPF code via a new struct bpf_io_request. This struct contains three fields: sector_start (starting sector of the bio request), sector_cnt (size of the request in sectors), and opf (operation information, opf field from the bio).
+
+Hook
+====
+
+The eBPF programs for a given disk are run whenever a bio request is submitted to that disk. The eBPF programs return IO_BLOCK or IO_ALLOW. If any of the programs return IO_BLOCK, the bio request is blocked. Because of the placement of the hook in submit_bio, as of this version, mechanisms which bypass submit_bio, such as SG_IO and NVMe passthrough, are not able to be filtered.
+
+Example
+=======
+
+An example, protect_gpt, is provided in the /samples/bpf/ folder. This sample uses an IO filter program to protect the GUID partition table by preventing writes to the first 34 sectors.
+
diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index 026addfc69bc..145930622a92 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -24,3 +24,4 @@ Block
    stat
    switching-sched
    writeback_cache_control
+   bpf-io-filter
-- 
2.28.0.236.gb10cc79966-goog

