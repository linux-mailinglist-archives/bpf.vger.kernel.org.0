Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B280697BCD
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 13:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjBOMdI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 07:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjBOMdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 07:33:05 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411C928841;
        Wed, 15 Feb 2023 04:33:05 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id i18so11660778pli.3;
        Wed, 15 Feb 2023 04:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRYLFMN4nFfXhPgoEELUJ9OsPT49XxcunYWNJLqgHSE=;
        b=WenDNGndpb/OSq3BzcF6AU3IZXn+RPN86YMLQ1QAjyzlmWKFtjKkKO2TlGZgVAYCpo
         UAkXUeUz+Idqs0+U8qIe5aPdJLTHoopwAPoUY2CB9/2J7JKNdtZAGmSZ5KgMYG9sd1Ct
         5YvE92DdHS95Ri6z93aJzRFBtJc/eshbltJ7LjHz5oiPaeMp/GEj/+3lOAQBFumZLU2w
         T03SoIBlOxlx2tWBZoZYhG/hhVZ0HiiwYUY+jxmRVK7yIALJtxLH3ULmnW8RQNwKlwi2
         KXE3BijWsSpgsFOEOGJ+xICM8nKaCvs/CHek3MVct7wyJ2fuZeKrsKmTpcTypmnt9M+/
         E5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRYLFMN4nFfXhPgoEELUJ9OsPT49XxcunYWNJLqgHSE=;
        b=v+OcgYQWVI1gwhHv4tPx4HgOXpzgV86moNFv5JM4a1+uPCataVJJTynqLdBaTz4Dvj
         BhlE0Tb5KAVtShuazkvC/F9vlyEg2kwAaCRBuCXofpFTi/zPHcf46LKOZbF9Jfki+Hgi
         Uu4m87yOVoUJbW+SOP4mkffAwBuVTLEd1FO6TFjWkbTehl+zY7ArgcvAgXaNF4gRi98U
         que3mtDgkz6FWOsadZTfxSycFQ6T53fuyqBhX0c7cztLwa6HCXb7DwcpP7VYA75F+Zc3
         tYgpwUSZjVpeSeTyTxDlzRYDCuRTXG844qdhnNkBwixVlQhgZ9PMZbibLb1lZN9G15R/
         Dnbg==
X-Gm-Message-State: AO0yUKUgfmk7ZDszNo6ynLDDR0Pl6usu0UQGlyKPYKvMX6j9NZbbnu1d
        0peuRJ4/2odhb2mHJPvLekU=
X-Google-Smtp-Source: AK7set9faJsxJ1uXq3wGy4JnDCcAdhfoq2C2lUxY6bVSO3jdVojAZu8HlLQSLCp/vIoEWCICqX7MgQ==
X-Received: by 2002:a17:90b:3909:b0:234:13a3:6e67 with SMTP id ob9-20020a17090b390900b0023413a36e67mr2715633pjb.12.1676464384730;
        Wed, 15 Feb 2023 04:33:04 -0800 (PST)
Received: from debian.me (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id fv21-20020a17090b0e9500b00230b8431323sm1384004pjb.30.2023.02.15.04.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 04:33:03 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id DAECA105484; Wed, 15 Feb 2023 19:32:59 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux BPF Development <bpf@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Huang Rui <ray.huang@amd.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Perry Yuan <perry.yuan@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        oe-kbuild-all@lists.linux.dev,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] Documentation: bpf: Add missing line break separator in node_data struct code block
Date:   Wed, 15 Feb 2023 19:32:52 +0700
Message-Id: <20230215123253.41552-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215123253.41552-1-bagasdotme@gmail.com>
References: <20230215123253.41552-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=bagasdotme@gmail.com; h=from:subject; bh=62NwC64cjyAWhaFrYFce2C+F3brashgF6x6NuyaIXGQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMlvLnxJDvu8+uerssOvXIurX3etDJp9S391wButPqOtN0M+ pAiJd5SyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAivs4M/6vD4+0UbR96/M7N/mkr0l oXynWj6JXZT9Vvqzev/St1xYzhr1jpisvCG8X+nek/Zj3dkLPM62Btja/vu8uT+mN7I46sZQcA
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

Stephen Rothwell reported htmldocs warning when merging bpf-next tree,
which was the same warning as reported by kernel test robot:

Documentation/bpf/graph_ds_impl.rst:62: ERROR: Error in "code-block" directive:
maximum 1 argument(s) allowed, 12 supplied.

The error is due to Sphinx confuses node_data struct declaration with
code-block directive option.

Fix the warning by separating the code-block marker with node_data struct
declaration.

Link: https://lore.kernel.org/linux-next/20230215144505.4751d823@canb.auug.org.au/
Link: https://lore.kernel.org/linux-doc/202302151123.wUE5FYFx-lkp@intel.com/
Fixes: c31315c3aa0929 ("bpf, documentation: Add graph documentation for non-owning refs")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/bpf/graph_ds_impl.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/bpf/graph_ds_impl.rst b/Documentation/bpf/graph_ds_impl.rst
index 8bbf1815efe784..61274622b71d85 100644
--- a/Documentation/bpf/graph_ds_impl.rst
+++ b/Documentation/bpf/graph_ds_impl.rst
@@ -60,6 +60,7 @@ The new-style data structures are intrusive and are defined similarly to their
 vanilla kernel counterparts:
 
 .. code-block:: c
+
         struct node_data {
           long key;
           long data;
-- 
An old man doll... just what I always wanted! - Clara

