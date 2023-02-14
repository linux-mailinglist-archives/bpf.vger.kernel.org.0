Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281B16970C6
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 23:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjBNWgM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 17:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBNWgM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 17:36:12 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED29A2CFDA;
        Tue, 14 Feb 2023 14:36:09 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id w3so19983655qts.7;
        Tue, 14 Feb 2023 14:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vGjUQ59EfGjLqRgg6jS2wqMF93HXolMygmoqFHWJzw=;
        b=oQu5B+v1eMRgdn3j6apmgf1z+RPgELsORHLpuzfxxMYZsDU1KTd4YSJdc9Ul59k+vQ
         +ihfsbeeanIFN8N3THgo35PxWMrsK5ZH27w9z5dxYsYJ9mN96JpzlUdrvmZ8mSruKwDd
         ivdpl/u9xapUHs0+xy1dDxXJo1orQjosH9vHPnZK1+hEmdOabxP4zvIL9wIvmjph4zbd
         uU91kvhVFfbNlNgIoIyuL39PvQyjkCJjdJZMuy8J97kLZew0OBah5UEYe6sviDH/eR2a
         kZndjJzqGuZuVZsj782TpYqQmt/LdMJrCuoPhwtxlvUdoyHhclGN2IJlP2UyG4inSM9e
         pYSA==
X-Gm-Message-State: AO0yUKXdW/rPSkyMxQ8YhiYP5s9WGThCzuje1k4Z0T1oXFctezPUjgx5
        byT5HxrKdolxRoHNMkOs+1y7XWaQYai4BrSR
X-Google-Smtp-Source: AK7set+o4nIe77K7DFKKg4pLzvRk33gV29eRVzn9xTJrN7IUeNWnYgfmYSeun9uI66NQ87HI413Vkw==
X-Received: by 2002:ac8:7943:0:b0:3b9:bc8c:c208 with SMTP id r3-20020ac87943000000b003b9bc8cc208mr1788350qtt.19.1676414168677;
        Tue, 14 Feb 2023 14:36:08 -0800 (PST)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id x129-20020a376387000000b006bb82221013sm12831205qkb.0.2023.02.14.14.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:36:07 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org, bpf@ietf.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, dthaler@microsoft.com
Subject: [PATCH bpf-next] bpf, docs: Add myself to BPF docs MAINTAINERS entry
Date:   Tue, 14 Feb 2023 16:35:53 -0600
Message-Id: <20230214223553.78353-1-void@manifault.com>
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

In commit 7e2a9ebe8126 ("docs, bpf: Ensure IETF's BPF mailing list gets
copied for ISA doc changes"), a new MAINTAINERS entry was added for any
BPF IETF documentation updates for the ongoing standardization process.
I've been making it a point to try and review as many BPF documentation
patches as possible, and have made a committment to Alexei to
consistently review BPF standardization patches going forward. This
patch adds my name as a reviewer to the MAINTAINERS entry for the
standardization effort.

Signed-off-by: David Vernet <void@manifault.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5e8a37d8b68..a416be19f8db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4024,6 +4024,7 @@ S:	Maintained
 F:	tools/testing/selftests/bpf/
 
 BPF [DOCUMENTATION] (Related to Standardization)
+R:	David Vernet <void@manifault.com>
 L:	bpf@vger.kernel.org
 L:	bpf@ietf.org
 S:	Maintained
-- 
2.39.0

