Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C736A53D6
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 08:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjB1Hpf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 02:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjB1Hpd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 02:45:33 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820801F935;
        Mon, 27 Feb 2023 23:45:31 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id d6so5087137pgu.2;
        Mon, 27 Feb 2023 23:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677570331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3X4A374173liV0Jwi7eRhhAaRAJc6AZ4uOSSuqD7v9o=;
        b=W+5H/OBP7GqSVHDCsUvVXdJzGjc25TkVv2Qns5BYwweBmhGcHLD+RAS+xQHbQzPnyP
         QnWPL3Jymz4BRMmZH48/Zb5qmtGioQJl24BNhRRN73m/qmGklxMPySOOrN/ZXsMccMV/
         20R/JCGaS4rvPjkRKaxBc5z8f6a57/6vt1u/Yocm6BbJzKrX/zeO7g+VoZYNzthrjikG
         2oSMOwMepiGXBLvbTJJzY64vNZw4gU7uTsXGLaaHQWhGkimjEd4PJKAubLbDdhGwHTtD
         WzcY3uQmUu2WfYrwIOEzSIy2BnoEibcGqjZfsI5X1JBBxS/ZItGeWdu/nOPURec0Y8Ds
         rk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677570331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3X4A374173liV0Jwi7eRhhAaRAJc6AZ4uOSSuqD7v9o=;
        b=e8INk7NdcVac5GUyllVyqkz8cthLNPZRNDTcFhnJcy/odwRnc7Lg0AIop7Usi3cMci
         D311UtxVDiF5gcp/D8eVPPd/dUKqYmUwlNL63fqsXu3kn4Jw0EtXgp8r9B3MMNIcnvq6
         fkl5qyxV59rEhyDE9lYXkrpDOcJkJGgD+ZRFWvhKyMRDjwjN3NZcjCfFX2nJj1Xfbgkf
         YwrRtsv9sWCCq6fqt6fmOGiEbuk5o+S7RCw1glOi9RmPvUK22XVPUTFsS+D+ERikfoic
         joAWOTDzXAJc0DgrS/nTz2E/7T+3oa6ExlswH4Dx/WutFMJRZHTNuhqUmbY9kKLiNkf1
         pK2A==
X-Gm-Message-State: AO0yUKUG1I1H/4W9WczVdgw/5zhMBZwmZLnFIv0QDWj3qmGo6S4iqApf
        W1G+7KS3FCHBuDK64hdzwuM=
X-Google-Smtp-Source: AK7set+EAXMD6pz/o9Jph9/dTg7zWzoEx0ronYJSUw/OlVeCPXRPh54DYxCrlLKh8gIUrgibDDTpWQ==
X-Received: by 2002:a62:7b8e:0:b0:5a8:d364:62ab with SMTP id w136-20020a627b8e000000b005a8d36462abmr1519644pfc.17.1677570331004;
        Mon, 27 Feb 2023 23:45:31 -0800 (PST)
Received: from debian.me (subs02-180-214-232-86.three.co.id. [180.214.232.86])
        by smtp.gmail.com with ESMTPSA id y18-20020aa78052000000b005a8aab9ae7esm5387564pfm.216.2023.02.27.23.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 23:45:30 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2F588103270; Tue, 28 Feb 2023 14:45:25 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux BPF <bpf@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/2] Documentation: bpf: Link to submitting-patches.rst for general patch submission info
Date:   Tue, 28 Feb 2023 14:45:23 +0700
Message-Id: <20230228074523.11493-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228074523.11493-1-bagasdotme@gmail.com>
References: <20230228074523.11493-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551; i=bagasdotme@gmail.com; h=from:subject; bh=uHff/L6LJr5vN+l1BAcktM1K58t0ZJTIygdTYpnqMJc=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMl/NwqlFCy55ZJRPeE0+/LA/TIKE926/SN/XdK+7/yfrYj1 5J3PHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIvyxGhpNOK240z6t5E58cIGbjXb XTylYq7dER586Yqen13e6r3jP8D19h9vPPndZblb5tLg6zrQP23q6yXn+EJeqEF6P70l4JRgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The link for patch submission information in general refers to index
page for "Working with the kernel development community" section of
kernel docs, whereas the link should have been
Documentation/process/submitting-patches.rst instead.

Replace the index target with appropriate doc.

Fixes: 542228384888f5 ("bpf, doc: convert bpf_devel_QA.rst to use RST formatting")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/bpf/bpf_devel_QA.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index eb087c599ffa44..b421d94dc9f216 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -7,8 +7,8 @@ workflows related to reporting bugs, submitting patches, and queueing
 patches for stable kernels.
 
 For general information about submitting patches, please refer to
-`Documentation/process/`_. This document only describes additional specifics
-related to BPF.
+Documentation/process/submitting-patches.rst. This document only describes
+additional specifics related to BPF.
 
 .. contents::
     :local:
@@ -684,7 +684,6 @@ when:
 
 
 .. Links
-.. _Documentation/process/: https://www.kernel.org/doc/html/latest/process/
 .. _netdev-FAQ: Documentation/process/maintainer-netdev.rst
 .. _selftests:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/
-- 
An old man doll... just what I always wanted! - Clara

