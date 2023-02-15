Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3AB697BCB
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 13:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBOMdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 07:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBOMdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 07:33:05 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B79B28841;
        Wed, 15 Feb 2023 04:33:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d8-20020a17090ad98800b002344fa17c8bso1752749pjv.5;
        Wed, 15 Feb 2023 04:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfPGdIBUWvYP18MdOLbq0gCotrm0pCwxe1TBwOkQhdo=;
        b=QXb/nWw4b87qF8YSl8JUHd3RCoF1GX7evfWX4ne/L6YJZMVKq+BwxKQcn81ZZUA1X5
         FWydNzPo6iaP3eurDnRSEfgYR/GP5PODttEMiN8SUyZmBWBhMjX0jwDehxn1rwPzstLS
         bhpSauaAXPLF2RBY9x8iM/7r/b/I9eccjYex1k2ywk6EKB4S6MlROzC2joI8nK3B5xsn
         rpkABqzRwQeFmnEfT/wqqbJp3hNgSsHt5D6Z8IpOOoLt1FloqJTwP7j6IAlYlfZbnpbL
         WCQVpEzj3I3cDFMSwsJK7/fWPixWHDLxyryXRBVQF3z03sdD3w44E/h3bQnenj8NXYMw
         StCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfPGdIBUWvYP18MdOLbq0gCotrm0pCwxe1TBwOkQhdo=;
        b=tGAPB4DWfOn/8kFdDwJA8ooHeudE2mW8OAGeaESrDLWQhlsuMmSNUo8KhSSKRi8+1A
         LIHY1dFUNYza3/071son5LZ53aF7ddSCz2v5+EYkEt9NrE+3lqTzXbfTZgQy4my60eJk
         LcE0v+0pQAPAWKmoUAo+vWZT0nAToK6m1yJdKxZcZRzFJVlkpOJ5rloMgIH/NfK+SxBD
         uxGTgHEY4EhhPCg6o7K9TdkSmvSnZQz9xH9RbjGWuU3pUWcU4xFp2FYW4r3fwnnFb0hJ
         /MSWYITmNURBbVucQt2dSAGAYAFnPpOFmhhKjAEbRVcBSMjxrayEPPllFHeD3Gt3w0Aj
         w2ng==
X-Gm-Message-State: AO0yUKWGS8C0WgJP7brQ+VZ8USdrT0vdJHxcufV5D8V8rJTSzpVBDy+o
        2syzJyoY+2/RaftIF3csGlQ=
X-Google-Smtp-Source: AK7set/dr+zE9J2Qf60cfvGWYt1fheRGnO5xCtk/WJ06lcoNPjdrbYIZrpoqwG8gM64yCg0+/o3O5w==
X-Received: by 2002:a17:903:2803:b0:196:1c45:6fc8 with SMTP id kp3-20020a170903280300b001961c456fc8mr1801744plb.60.1676464383516;
        Wed, 15 Feb 2023 04:33:03 -0800 (PST)
Received: from debian.me (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id jh20-20020a170903329400b0019ad6451a67sm108767plb.24.2023.02.15.04.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 04:33:03 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id BF947105177; Wed, 15 Feb 2023 19:32:58 +0700 (WIB)
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
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/3] Documentation: hw-vuln: Wrap mitigate_smt_rsb example in literal code block
Date:   Wed, 15 Feb 2023 19:32:51 +0700
Message-Id: <20230215123253.41552-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215123253.41552-1-bagasdotme@gmail.com>
References: <20230215123253.41552-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453; i=bagasdotme@gmail.com; h=from:subject; bh=NlIucDSsMzvXPzZxHVDpD0xEEtWua/CgvF9JyzYMKNk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMlvLnwJWuIrJ6V+hMMv94SlmvfRDb/TKrprgx8H5B9K+vZ4 f/z8jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEwknofhn4ZpT7iExeyPMeazQwzOnQ 8L3qHXJzNF3TxRr79g20RpaYb/pRNZdLcuyLPbFK+u9OycTqFZ/cfVmWckbvpP2li4aasQOwA=
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

Stephen Rothwell reported htmldocs warning when making htmldocs from
Linus's Tree:

Documentation/admin-guide/hw-vuln/cross-thread-rsb.rst:92: ERROR: Unexpected indentation.

Fix the warning by formatting example of mitigate_smt_rsb module parameter
as literal code block.

Link: https://lore.kernel.org/linux-next/20230215144117.369ffb5f@canb.auug.org.au/
Fixes: 493a2c2d23ca91 ("Documentation/hw-vuln: Add documentation for Cross-Thread Return Predictions")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/hw-vuln/cross-thread-rsb.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/hw-vuln/cross-thread-rsb.rst b/Documentation/admin-guide/hw-vuln/cross-thread-rsb.rst
index ec6e9f5bcf9e89..3593d30ccfde12 100644
--- a/Documentation/admin-guide/hw-vuln/cross-thread-rsb.rst
+++ b/Documentation/admin-guide/hw-vuln/cross-thread-rsb.rst
@@ -88,5 +88,6 @@ capability to override those interceptions, but since this is not common, the
 mitigation that covers this path is not enabled by default.
 
 The mitigation for the KVM_CAP_X86_DISABLE_EXITS capability can be turned on
-using the boolean module parameter mitigate_smt_rsb, e.g.:
+using the boolean module parameter mitigate_smt_rsb, e.g.::
+
         kvm.mitigate_smt_rsb=1
-- 
An old man doll... just what I always wanted! - Clara

