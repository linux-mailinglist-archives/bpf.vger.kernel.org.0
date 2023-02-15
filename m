Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31B8697BC8
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 13:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjBOMdG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 07:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBOMdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 07:33:05 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804A036446;
        Wed, 15 Feb 2023 04:33:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o13so18043021pjg.2;
        Wed, 15 Feb 2023 04:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfufL2R00gIT5+p6ohoSf68FEJlxpyChqygBx8E3+7Y=;
        b=T59RF1pqTWpYk9Y9uHmTFoauRukdIcU8prVrThhLMybqY6KszWBGH8SgtvUNDNK8EU
         bHmJ4luWdBhxgaAQurXBtrSBC9YmBnhFUqgiAphj2aEYcbTlNPnglt0GZXIt3G2PF+3R
         tlbVq/qLMcM7kUaz9+X0vztifbBQ0pDaX8QPSSL8E0zwai47qozYtR94F0Ok9fDWwbkS
         9Bh2SbSttlM3LkH72pBLDESfORBpQ4BTkD8LvQcpjo+QGTunWVl4wy+vuSLKtWFxhi3X
         g6w6U3cLe7RGZbUjuETUJ79BEpoE3SInvFOegR+VA5iVNDgRYm+HAx8Bq2rCl6gyUbrU
         a04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfufL2R00gIT5+p6ohoSf68FEJlxpyChqygBx8E3+7Y=;
        b=eSDLJ33FKWLYKfnWAZKxWHOfim/4O+hURlwF+Ooet4fotzk2BzjtHcX9+kV/SM915/
         ckXCAr8FrFNr2D0wVd8Xd5UTBe3xQLztcwkirnqjb7+f0BAfbFSHuWeCcw4CdUuxUHfb
         EJTlmdXejGBVpSmPilZG4s+ob8hOmeptacwqSyE7WkLbjSEnUQD3GPgicjtyU8cVGwG5
         a/7mxyZHZkV8dL8G4OyQKkYMjW9XFSS3GV3eeJZE2QI73nDWIuKNLmylkka6wm6+ZWql
         KlA+sN32x0zIa1/mfrWoPj63/jzVaBmOpi6U39GFi1jwp8iTB34puoSM2X0N2ox8iHwE
         7RkQ==
X-Gm-Message-State: AO0yUKUQSFztp/rVmxVFpC2kJd/uW0Bs+fo6zaP7oSJMNLKLZLs0QW1T
        RXLpRE4EbLWF/vfjAajRxVQ=
X-Google-Smtp-Source: AK7set86xq2Sn0OOELW7RYGHYtfVd1abYLUVPIgDLx0XQUQ8eURN5r+38OuRvluu6r4nEiZIXIQUzA==
X-Received: by 2002:a17:90a:5e:b0:233:e1e6:33dc with SMTP id 30-20020a17090a005e00b00233e1e633dcmr2463233pjb.48.1676464383937;
        Wed, 15 Feb 2023 04:33:03 -0800 (PST)
Received: from debian.me (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id nn9-20020a17090b38c900b00233cde36909sm1361116pjb.21.2023.02.15.04.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 04:33:03 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id EB8BC105499; Wed, 15 Feb 2023 19:32:59 +0700 (WIB)
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
        oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: [PATCH 3/3] Documentation: amd-pstate: disambiguate user space sections
Date:   Wed, 15 Feb 2023 19:32:53 +0700
Message-Id: <20230215123253.41552-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215123253.41552-1-bagasdotme@gmail.com>
References: <20230215123253.41552-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075; i=bagasdotme@gmail.com; h=from:subject; bh=fHPohjK/K4qEW5HlKhcOAQGypSB2hKRI2mFU/Af9yJ0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMlvLnypFeHJP9U//ZjaFwfFUEO5TL2iD6n7ZjXtdt++xeDk u+cqHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjI6RSG36zXw4WPvT4wU21n1MzThQ 1NrRue5ibYmTPztAkrFj0qXcrIsOPQBrut18W+FQR/Sk56Paf7WmjUptzYRV4pbtdeOf7YyQUA
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

kernel test robot reported htmldocs warning:

Documentation/admin-guide/pm/amd-pstate.rst:343: WARNING: duplicate label admin-guide/pm/amd-pstate:user space interface in ``sysfs``, other instance in Documentation/admin-guide/pm/amd-pstate.rst

The documentation contains two sections with the same "User Space Interface
in ``sysfs``" title. The first one deals with per-policy sysfs and the
second one is about general attributes (currently only global attributes
are documented).

Disambiguate title text of both sections to fix the warning.

Link: https://lore.kernel.org/linux-doc/202302151041.0SWs1RHK-lkp@intel.com/
Fixes: b9e6a2d47b2565 ("Documentation: amd-pstate: introduce new global sysfs attributes")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index bca9a0ebee3ed8..6e5298b521b18b 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -230,8 +230,8 @@ with :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond
 to the request from AMD P-States.
 
 
-User Space Interface in ``sysfs``
-==================================
+User Space Interface in ``sysfs`` - Per-policy control
+======================================================
 
 ``amd-pstate`` exposes several global attributes (files) in ``sysfs`` to
 control its functionality at the system level. They are located in the
@@ -339,8 +339,8 @@ processor must provide at least nominal performance requested and go higher if c
 operating conditions allow.
 
 
-User Space Interface in ``sysfs``
-=================================
+User Space Interface in ``sysfs`` - General
+===========================================
 
 Global Attributes
 -----------------
-- 
An old man doll... just what I always wanted! - Clara

