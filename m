Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070F659912D
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 01:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbiHRX1i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 19:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241562AbiHRX1h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 19:27:37 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E114D7590
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 16:27:36 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d3-20020a170902cec300b0016f04e2e730so1715410plg.1
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=43OvUEjlU4m0CJrQvm1yCAYd+gNT2A30o8em+LOq8/w=;
        b=aN9Wcqje5Je3LKk0q0oyG8wGApGb+9e9Wps2Nm/SsJEhKmNM6UUfHaGA5MikEReva+
         2wMICvEA4FTFRqEg3yMbb0aEXhd2f3NHiWFHLxAdF8PbpfwUM4UWtOLwEGfhmT+mcsXu
         6fYhPDCm74x/ciN3MMh1LtSASA5ByS90gLeiRFkHERcfKxT7e1muDZTSJ2ebF0Nv390f
         g/AMHy+ksNxrd/39T2a+PXdTttUGfSiEWWLsbtDYH/laT8mrs6Z//fqgRm+kOW5b2oG4
         CkEO+9Nb5kPcAH414akKC4hd734ZVeXMAQLSfMgBfV0++BJIFmvGz6PJEt8VqgHnsLcU
         NcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=43OvUEjlU4m0CJrQvm1yCAYd+gNT2A30o8em+LOq8/w=;
        b=0gd1iDAmKZZo5F6sOqUi90bXX7e7VlyZlJ871UXNV7zIfoQa+rUjzBRaQ5hR3lfTHT
         fKXSfApORC85xRreaO6NfayVSuIrWGbYN1T9qJxzv2N4uJtYOrbsP3juvRkr0PL2dTZi
         RngX3NHU83Zz2fYU6ndMEjySsApfqqGmCdXIVFBkLXO9PpfVSh4o5fEkWJ51Z/SYtyND
         BzIeluBpeLCDSsOLqeZ4a0+vIYJU+UODMVHItz70bEyHNqZZ+3aCaEoVCkzcqycAeb6r
         UZJLs2sR06c+A/TBhYB9T6l/w5sk1CXted5kaHkYLj0SkIjyV1NU22XWviVi4FWcNgFX
         uQSg==
X-Gm-Message-State: ACgBeo2cifrgEtIOoCWQm8eIsmdui+H5ZlrZ6VFc/+iW8L3KZaemC6GF
        P3C2fhyf3RGFCpovg/O7x/yIZlu6INn6Wkn4PRJJUVQ9DwvlAjX8jcxZIU2Zwl8SMCgPet1Z7cC
        XKF+OKJKDIsBkSIEfnb4jmxz2AyAPbUll7KRQlsD5+9FSxpvNQA==
X-Google-Smtp-Source: AA6agR5JShQUzD+D0f+DikcBRm8zsBE9+SG3+imvB3baFsRbyvp7j5Wth5FoF4ajS87gW7tKBnEyyRA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:f548:b0:16f:9649:be69 with SMTP id
 h8-20020a170902f54800b0016f9649be69mr4589515plf.134.1660865255888; Thu, 18
 Aug 2022 16:27:35 -0700 (PDT)
Date:   Thu, 18 Aug 2022 16:27:27 -0700
In-Reply-To: <20220818232729.2479330-1-sdf@google.com>
Message-Id: <20220818232729.2479330-4-sdf@google.com>
Mime-Version: 1.0
References: <20220818232729.2479330-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v3 3/5] bpf: expose bpf_strtol and bpf_strtoul to all
 program types
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_strncmp is already exposed everywhere. The motivation is to keep
those helpers in kernel/bpf/helpers.c. Otherwise it's tempting to move
them under kernel/bpf/cgroup.c because they are currently only used
by sysctl prog types.

Suggested-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c  | 4 ----
 kernel/bpf/helpers.c | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 00988312279f..47796280232b 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2187,10 +2187,6 @@ sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return func_proto;
 
 	switch (func_id) {
-	case BPF_FUNC_strtol:
-		return &bpf_strtol_proto;
-	case BPF_FUNC_strtoul:
-		return &bpf_strtoul_proto;
 	case BPF_FUNC_sysctl_get_name:
 		return &bpf_sysctl_get_name_proto;
 	case BPF_FUNC_sysctl_get_current_value:
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 53451ea6721c..8bb78acfe88d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1577,6 +1577,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_loop_proto;
 	case BPF_FUNC_strncmp:
 		return &bpf_strncmp_proto;
+	case BPF_FUNC_strtol:
+		return &bpf_strtol_proto;
+	case BPF_FUNC_strtoul:
+		return &bpf_strtoul_proto;
 	case BPF_FUNC_dynptr_from_mem:
 		return &bpf_dynptr_from_mem_proto;
 	case BPF_FUNC_dynptr_read:
-- 
2.37.1.595.g718a3a8f04-goog

