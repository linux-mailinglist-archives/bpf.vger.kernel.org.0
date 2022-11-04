Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA0F61965E
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 13:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiKDMkH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 08:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiKDMjr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 08:39:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADB5A1BC;
        Fri,  4 Nov 2022 05:39:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k15so4430405pfg.2;
        Fri, 04 Nov 2022 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/TTs+SQ3730sftInldiJIc3c0U0T3PiqOZZn4XJKbTc=;
        b=pMDidnAt8xhkHG6jwMe8yC27eQxhm11xGQeS5bipl/LYmQFfMD+TYXs8rsleS076oe
         7iQ5oQPvzqllPSIJuoe4ZYRLrh/49FetUiUqmkfvintVSYAjiy7pNahD93uTHmVxyULz
         SKXj4p0LtikpNZiGqcpoNCVYxLYMibaO56eiyv+Z0y2TxnXg6Rk5NeQ5TfuTfThjgAtq
         TjDaK83G/YQYhadkwjg/uxo5FvEWC4/iqPd940lUMIxX+VWGciiXTMKiuPQrFtgfxqxP
         dEoFTx6APSO5cnuXrQO/rfsTHHns3a9rDb+x3EfBSyU9cYdkLvrgh4LDxf3Y8JemacKE
         fbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TTs+SQ3730sftInldiJIc3c0U0T3PiqOZZn4XJKbTc=;
        b=y6SGJNsqQdEYN2JZFdq3WZm6WUP8k0q/j33uTb8Srz8j3lohjRyo34XNRok+9/bf34
         gWJh0RB1NJT91EZfL7vpcpNED8IhXL6hYi9R8g/lR4rft1xtVKEbZliohpcWEAkU79Pu
         J2PmJ0AHQzrtD1FIgw8FUMgZjdyHp7RGBmZUpFvzbJWXvmFhAEdk/6jJB947jCCKKmRt
         +Wfr5GHXUns0oI2Lh08uZEFhxJO1XOEqsbXpSMveVlL9sVpmAfxKyReufCMSjyw+Vk9t
         mgKTWCf1konN/4vL9EvP2wadOi6Vvx5XN2r+K6PiY85OGlDKRNm8JicZhlcE7nbxGkOa
         Uy1g==
X-Gm-Message-State: ACrzQf3UJd8KBeBvePdOFhU8WQmWJFRBEeGpcQ4RbK3iNznpuWpu13CU
        PP8HwHhG4CrjX0bLQrhQIrvKBsJLr+MRjmbJ
X-Google-Smtp-Source: AMsMyM7pLqX6RGGlLZQ28jcGph6DjfzlBDsurtfYnyvWlXa0OKmKlyGysgSd3AzigrRmD0oxC6QfjA==
X-Received: by 2002:a65:49c9:0:b0:462:9ce1:3f58 with SMTP id t9-20020a6549c9000000b004629ce13f58mr30209189pgs.200.1667565584901;
        Fri, 04 Nov 2022 05:39:44 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id w14-20020a627b0e000000b0056bd4ec964csm2603180pfc.194.2022.11.04.05.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 05:39:44 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
        David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH bpf-next] Documentation: bpf: escape underscore in BPF type name prefix
Date:   Fri,  4 Nov 2022 19:39:14 +0700
Message-Id: <20221104123913.50610-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1956; i=bagasdotme@gmail.com; h=from:subject; bh=RWnD3wD39wBwhPhnOTT0S+Ljuw5X7oF+YsnsA+fSFlU=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmp7K+XeAbM1mn5tLAjt+Wgmqn3Uzf910snXncP/+4utdLm oc20jlIWBjEOBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzkTgEjw8vIv5uPXWubEHi81+DiPf f7+meXm8xdu85hxfWoTwvNvt1iZJjZynj/zzv3/WUp5cFV726nhd6/y1xwqeTA9Rs3l3gv38oLAA==
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

Sphinx reported unknown target warning:

Documentation/bpf/bpf_design_QA.rst:329: WARNING: Unknown target name: "bpf".

The warning is caused by BPF type name prefix ("bpf_") which is written
without escaping the trailing underscore.

Escape the underscore to fix the warning. While at it, wrap the
containing paragraph in less than 80 characters.

Fixes: 9805af8d8a5b17 ("bpf: Document UAPI details for special BPF types")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/bpf/bpf_design_QA.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index 4e4af398607b58..17e774d96c5e4b 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -326,11 +326,11 @@ size, type, and alignment, or any other user visible API or ABI detail across
 kernel releases. The users must adapt their BPF programs to the new changes and
 update them to make sure their programs continue to work correctly.
 
-NOTE: BPF subsystem specially reserves the 'bpf_' prefix for type names, in
+NOTE: BPF subsystem specially reserves the 'bpf\_' prefix for type names, in
 order to introduce more special fields in the future. Hence, user programs must
-avoid defining types with 'bpf_' prefix to not be broken in future releases. In
-other words, no backwards compatibility is guaranteed if one using a type in BTF
-with 'bpf_' prefix.
+avoid defining types with 'bpf\_' prefix to not be broken in future releases.
+In other words, no backwards compatibility is guaranteed if one using a type
+in BTF with 'bpf\_' prefix.
 
 Q: What is the compatibility story for special BPF types in local kptrs?
 ------------------------------------------------------------------------

base-commit: f71b2f64177a199d5b1d2047e155d45fd98f564a
-- 
An old man doll... just what I always wanted! - Clara

