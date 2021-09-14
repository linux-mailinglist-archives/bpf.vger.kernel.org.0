Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D487640B955
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 22:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhINUgW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 16:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbhINUgW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 16:36:22 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798ABC061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 13:35:04 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 62so497160qvb.11
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9Eia8e/tEm1S/jtyG5QeEd0kmcS2Msf9RwPbaideHU=;
        b=PnyVz+aTd+Xbz39rYAJGF9Saqz/cqPVeLsR/Yfq4gxbDeFYZS1MnRarcjp7QyUi29T
         PKzXD6+LhEYfPyeTAGSmHNPWySN/qxMfF+TByT1Ribfi9xRsGp1cNFEIUd/5oHcouWJh
         xG+URu/VQWqhw7YKSXhuwf4gM1UoYlMATJum1osp/9kFQrycQehfIib8mgPYpCg9zNSJ
         HZSEc4Xrs1WILsnuwvsCatACCxn74Cp6j/F/Gvte8SvADiv5HGv/uqfJfsClGHQBtxVt
         ME10NrbPWoTWQ7ZI2lF50YhyA9PzArakVJMC40xw7hvL0lwBUOR9QHq4XiQRDsroYPOy
         KkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9Eia8e/tEm1S/jtyG5QeEd0kmcS2Msf9RwPbaideHU=;
        b=CSo36gLoiLFo6dJgKDdMySZMgXjsMSdJ0lWqBHxD00O2zlrQxW0ggIvia0tG+y87Ry
         g3N+csfOChoArXeODcAIUrmCFK7TBpvbcL6A7MQS+ejT/v7I/AQLjz1j4mwyhiVtKGCA
         fhb5iiIerHyPiVwYFJiyQDyy1pwIsbuvRKTUsiCgsc892qQtNPPuSNEbNVqVCqstdWKk
         1t+HzfV0tUOKzQvaiZNwjjJP3iNsKEulduVrAwl8sjlihMyidiHdTaA+lcOIDeL/Y8Uo
         ODhkXL2dGlIr93ESgafABBp7ToCFuv+odf7Z1JnpJSiZqi1/jMSPPcotzTXcx+homk9P
         tBSA==
X-Gm-Message-State: AOAM532erQndhM0h+ickJYo+yidQVuCtJC9dCCip+nV5twhLtNO5MFyB
        TFhWxXXUO9HoFDpxuLDVWyZ7ETYxhWG0GXw=
X-Google-Smtp-Source: ABdhPJzQK/PRRhK3owtSVRozEiWL17b751PFA0UZgNXlVruuZoisrRQC9aVcEeHFHl6yNI1es/vXeQ==
X-Received: by 2002:ad4:4b08:: with SMTP id r8mr6203848qvw.51.1631651703692;
        Tue, 14 Sep 2021 13:35:03 -0700 (PDT)
Received: from fujitsu.celeiro.cu ([191.177.175.120])
        by smtp.gmail.com with ESMTPSA id b19sm8413368qkc.7.2021.09.14.13.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 13:35:03 -0700 (PDT)
From:   Rafael David Tinoco <rafaeldtinoco@gmail.com>
To:     rafaeldtinoco@gmail.com
Cc:     andrii.nakryiko@gmail.com, bpf@vger.kernel.org, sunyucong@gmail.com
Subject: [PATCH bpf-next] libbpf: fix build error introduced by legacy kprobe feature
Date:   Tue, 14 Sep 2021 17:34:58 -0300
Message-Id: <20210914203458.2102503-1-rafaeldtinoco@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7500F71C-79CF-449C-819E-7734B6B62EA5@gmail.com>
References: <7500F71C-79CF-449C-819E-7734B6B62EA5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix commit 467b3225553a ("libbpf: Introduce legacy kprobe events
support") build issue under FORTIFY_SOURCE.

Reported-by: sunyucong@gmail.com
Cc: andrii.nakryiko@gmail.com
Signed-off-by: Rafael David Tinoco <rafaeldtinoco@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6ecfdc1fa7ba..b45eab3d30cd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8997,7 +8997,7 @@ static int poke_kprobe_events(bool add, const char *name, bool retprobe, uint64_
 {
 	int fd, ret = 0;
 	pid_t p = getpid();
-	char cmd[192], probename[128], probefunc[128];
+	char cmd[192] = "\0", probename[128] = "\0", probefunc[128] = "\0";
 	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
 
 	if (retprobe)
-- 
2.30.2

