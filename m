Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC406A5BF1
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 16:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjB1PaT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 10:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjB1PaO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 10:30:14 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF1A301BD;
        Tue, 28 Feb 2023 07:29:56 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id y12so7084632qvt.8;
        Tue, 28 Feb 2023 07:29:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CZR9XbBI+jqJTXVWOqR0qlxDlUyuDkgVxI59AK61bU=;
        b=KALTBPFdPRPg4gKJWprDLh3/aIlzmk0yVB5hJslVmPFFQo72Pc4TMJ4e3Jff0p385A
         JWshMpYuLglUl5u9OQpErZ+LmP/7MtEz/9a1+dZAKOm7L5GRDHk2lG3IIDv0cFA8FTv7
         iHUVXyjGT1jh6/HGziezB0eAGTPHSxSy42eYexnJ3T9Oxg7zeiK4K/mF/ENqYkhRoY8y
         47VJkM1N9cObJaJIZWlmX6NO8ZCBmFl/cA/10LF3BpOTrt6oPOAER/699cd5jzFZBQ7d
         kbxJWWVD7HDMQIpMxdx4inUYrnSfN2W8SB8QR2U65TgElNDkP+MRMnn8UWbJpPwhgyk7
         luEQ==
X-Gm-Message-State: AO0yUKVWuqm6Lz1rc/htze/zZ1+QVzJ2LRzD/q47cItziMCEXFpcxHmL
        Loaqln7sAptbz/8WqLQ447BGNVDMQU+D36xY
X-Google-Smtp-Source: AK7set8/R4LdhtyIOF5KDjcZNfgIpBYR2wP41EFrskVZ12EeUAjNJs8PrEpxMlQREJOZ78izfR385Q==
X-Received: by 2002:ad4:5de8:0:b0:56e:f4e0:a4ec with SMTP id jn8-20020ad45de8000000b0056ef4e0a4ecmr5808218qvb.46.1677598147781;
        Tue, 28 Feb 2023 07:29:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:f172])
        by smtp.gmail.com with ESMTPSA id bl32-20020a05620a1aa000b007423e52f9d2sm7006503qkb.71.2023.02.28.07.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:29:07 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next] bpf: Fix bpf_cgroup_from_id() doxygen header
Date:   Tue, 28 Feb 2023 09:28:45 -0600
Message-Id: <20230228152845.294695-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In commit 332ea1f697be ("bpf: Add bpf_cgroup_from_id() kfunc"), a new
bpf_cgroup_from_id() kfunc was added which allows a BPF program to
lookup and acquire a reference to a cgroup from a cgroup id. The
commit's doxygen comment seems to have copy-pasted fields, which causes
BPF kfunc helper documentation to fail to render:

<snip>/helpers.c:2114: warning: Excess function parameter 'cgrp'...
<snip>/helpers.c:2114: warning: Excess function parameter 'level'...

<snip>

<snip>/helpers.c:2114: warning: Excess function parameter 'level'...

This patch fixes the doxygen header.

Fixes: 332ea1f697be ("bpf: Add bpf_cgroup_from_id() kfunc")
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a784be6f8bac..abdcc52f90a6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2106,8 +2106,7 @@ __bpf_kfunc struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
  * bpf_cgroup_from_id - Find a cgroup from its ID. A cgroup returned by this
  * kfunc which is not subsequently stored in a map, must be released by calling
  * bpf_cgroup_release().
- * @cgrp: The cgroup for which we're performing a lookup.
- * @level: The level of ancestor to look up.
+ * @cgid: cgroup id.
  */
 __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
 {
-- 
2.39.0

