Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3651A40BA58
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 23:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhINVhS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 17:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhINVhR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 17:37:17 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E158AC061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 14:35:59 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id w17so410140qta.9
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 14:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5SEEen+81MOlyy5S6eaL8puTL2LLANVIRS/yIcCR6HI=;
        b=XyRHM1DAVEnfF/O+NCdHnXPgV7pizvDnYGa+2APq+RbsielgxjG0xKrt8g2hkr+IHJ
         rNwk1mp0jVAonRPL8xaihfhCYB6j2l1jmzVeQA4BK2jeqdYc4uvkIEus6y/G+FHMkmJx
         XLDvCyWtB+8cM8iJBOyAYjDciidAEPt3UlV+nooqm/DFmu9TSg0Mr0QgsraESn6CbUTu
         11vi/EMESO7h0vZMnrWJSRtBpYo5PGPYemV4A7mf/lyMW7jL7yeCu+6qnVooXzTJxeuw
         rapKadQyNGf4flW0yhLEsLhBRSMV0c+9hpB8T/jLLkNKK2R1zAcKEhmUpDheqE8efDuC
         HQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5SEEen+81MOlyy5S6eaL8puTL2LLANVIRS/yIcCR6HI=;
        b=oB8byx02UvCGmWJtcmbUknXQR6yUk2xx0+hS5b2YS8B5XaFDvhrJ/cLOH+McGkcr4L
         gWzcMIFSrhtubidl4snmTopfB58Ul/uiv0H9ZYucpe5C59EUXPPlVI0rDMegDHIYxgD8
         xlkBtkLhydeFBz3ZDEwOZi7/wUlVn5d4SuVEjQniN+1jyyBewh4mNWwrC8AHKpOOmxMG
         lN0a5TZy9mZLiTmby8nv8px8Ea1mHDJqrhq1FaqpYm7A5oIU6tP2TSJY7LnsJH3NYr1W
         op7pucdBqgnQ/Tzg2btipfH7OVjWV0BmsZqvypXTfwU5nH1SaChiQxmufU9FYorKpYfN
         g0sw==
X-Gm-Message-State: AOAM533ebXpgtFftPiAuClGLJahX3DFyQuRTgsQizQlEFaQNp+t76A5Y
        57CRtJHle+7bdJAZGGXKj5lv/x0KEQ5WxOU=
X-Google-Smtp-Source: ABdhPJwPazPZlTGkVemGkEKan+/YhCPTOcFvhQM78JCnkKc0KvOzy0FODfWDLZfc3e3giM+vTPEuGQ==
X-Received: by 2002:a05:622a:290:: with SMTP id z16mr6939977qtw.123.1631655358995;
        Tue, 14 Sep 2021 14:35:58 -0700 (PDT)
Received: from fujitsu.celeiro.cu ([191.177.175.120])
        by smtp.gmail.com with ESMTPSA id n11sm6661641qtx.45.2021.09.14.14.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 14:35:58 -0700 (PDT)
From:   Rafael David Tinoco <rafaeldtinoco@gmail.com>
To:     rafaeldtinoco@gmail.com
Cc:     andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
        sunyucong@gmail.com, alexei.starovoitov@gmail.com
Subject: [PATCH bpf-next v2] libbpf: fix build error introduced by legacy kprobe feature
Date:   Tue, 14 Sep 2021 18:35:54 -0300
Message-Id: <20210914213554.2338381-1-rafaeldtinoco@gmail.com>
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
index 6ecfdc1fa7ba..d962796024c8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8997,7 +8997,7 @@ static int poke_kprobe_events(bool add, const char *name, bool retprobe, uint64_
 {
 	int fd, ret = 0;
 	pid_t p = getpid();
-	char cmd[192], probename[128], probefunc[128];
+	char cmd[288] = "\0", probename[128] = "\0", probefunc[128] = "\0";
 	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
 
 	if (retprobe)
-- 
2.30.2

