Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDEA6A53D4
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 08:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjB1Hpe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 02:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1Hpd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 02:45:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD51EBFD;
        Mon, 27 Feb 2023 23:45:30 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id ky4so9531486plb.3;
        Mon, 27 Feb 2023 23:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677570330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHy6ab7agGyazZ8+IkAKFCiyzz2TR79Tj1aCMW8RwZ4=;
        b=fkzvyPvOHz0gnamBcxDCmV+b18IalVtgGEInyXc4m4qVedBXqvGEPoERYo0QPEOW8o
         dV5If1SuoXkPThIxxZjLp9c0Sc72lH3wakUn7gAey9rnEmjbxv4ErIRYX8cjujyXbz6M
         DIPmgUWP4aPa0Co+XGi9ZO2E7inAW2y88lWb82nwY0SldwGdKBZTX2CQgQj93BcRvG8R
         wY2Tdj4fQ13aGowWvrJ6ptSIbX37gPUO3Z8to/n0mf7Mmmh1HJi3Qiyxoms7ZeCz5t7K
         YIcMxSJfKntbPCfBRKCzA1RwChBlsBxiMClKZ7Wf+jWx/8SjZwXEeQ6gdiykW3dwUp+n
         eYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677570330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHy6ab7agGyazZ8+IkAKFCiyzz2TR79Tj1aCMW8RwZ4=;
        b=IJjLgmgz41ZVNxW1WDeciM/IpRk6MaKAcv2PoodatoeakeY5FwI1usEiBXaKocK59W
         FBGF1Ogi7y2Pgu2Sd7NndP/UNd6JUdCgnI4/GXKxdHpaecUga4CzXx/N4HNK4fOxIz2y
         migsz2NBsDuIAv3JCm44VIoz1ruMFiP+w27bnrbWAK8ul4ZeIHHhbUosZsM5CkseS4Jq
         j3RVM344XY+RVJ1YBc30X2wNoTnW8JQYvnpSNVWDb+H+JFM5LnY07Sf+ek5i+azm7Wfp
         won3X6qy1Gjmio7mqsWuMUyBkYFP8zduxpJ0uEU4vd4eq1nndh2GZ4KyZbHa0n5rwhto
         HijQ==
X-Gm-Message-State: AO0yUKVlCXSDwlZ3hec6JmgV/c1qYCyU8gCH/xrezalGfoLyEFX9bznS
        amJJF3IObaLf8/uHTvtKgN8=
X-Google-Smtp-Source: AK7set8vVDbK/53GDNTnafGGAjtyPe5GuRyKPuh0gmf4Rr7HNx+GUlD0cjgQCT+szwQwTpNBRVgFFQ==
X-Received: by 2002:a17:902:ce8f:b0:19a:9434:af30 with SMTP id f15-20020a170902ce8f00b0019a9434af30mr2363001plg.18.1677570330349;
        Mon, 27 Feb 2023 23:45:30 -0800 (PST)
Received: from debian.me (subs02-180-214-232-86.three.co.id. [180.214.232.86])
        by smtp.gmail.com with ESMTPSA id jn9-20020a170903050900b0019cc3d0e1basm5873829plb.112.2023.02.27.23.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 23:45:29 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 5AD5A106575; Tue, 28 Feb 2023 14:45:25 +0700 (WIB)
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
Subject: [PATCH 1/2] Documentation: bpf: Do not link to docs.kernel.org for kselftest link
Date:   Tue, 28 Feb 2023 14:45:22 +0700
Message-Id: <20230228074523.11493-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228074523.11493-1-bagasdotme@gmail.com>
References: <20230228074523.11493-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=bagasdotme@gmail.com; h=from:subject; bh=yWxliHf0f0vpYKAwhnAwEeu8mJhvpwvbMoeq0P63UQA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMl/Nwotn5u7fZEe85mOhrz94TrGiikmzywvPG8887yivnme et39jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEykJ5GR4SafXavTKbPlt9fY5qjM3v yw832v+t15t10reb9kHw/n9Wf4X5r2w/2mxLd8H8WCN8WreqZ/rfu+6bHastkdmX0nOau+cAAA
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

The question on how to run BPF selftests have a reference link to kernel
selftest documentation (Documentation/dev-tools/kselftest.rst). However,
it uses external link to the documentation at kernel.org/docs (aka
docs.kernel.org) instead, which requires Internet access.

Replace the link with internal linking, by using :doc: directive
while keeping the anchor text.

Fixes: b7a27c3aafa252 ("bpf, doc: howto use/run the BPF selftests")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/bpf/bpf_devel_QA.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 715f7321020f27..eb087c599ffa44 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -461,8 +461,8 @@ needed::
 
   $ sudo make run_tests
 
-See the kernels selftest `Documentation/dev-tools/kselftest.rst`_
-document for further documentation.
+See :doc:`kernel selftest documentation </dev-tools/kselftest>`
+for details.
 
 To maximize the number of tests passing, the .config of the kernel
 under test should match the config file fragment in
@@ -688,7 +688,5 @@ when:
 .. _netdev-FAQ: Documentation/process/maintainer-netdev.rst
 .. _selftests:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/
-.. _Documentation/dev-tools/kselftest.rst:
-   https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
 
 Happy BPF hacking!
-- 
An old man doll... just what I always wanted! - Clara

