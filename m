Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368DC3F86FB
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 14:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhHZMKF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 08:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhHZMKE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 08:10:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C75BC061757
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 05:09:17 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so6442253pjr.1
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1peXTtmSrcQ3dL48f3CYybJCQz0USIg581c+9mV1CRU=;
        b=G16eHd3R7rvucEYQZP1BQMHUBUjrcaPqVG64i5Dwg6lf/sH1Oe6sx63YuFcL94xdyo
         TkoT3CeMd+XTHVivi5Fi4vmJft4Pe0PyKXgAAu4fFcD9LsqJLABVKTG3VrQCPLelZyD2
         7auLy77cxFWmdy/jLWjW/hhBHG3tV6CZBD1gjR5dbFFvtSt23HFoJEbv9iPVrX4eNLzT
         +UZZtrVbO4fhDQ0huI8rbfcgcrImheITqBbhtGzN7QCQur7caalCW7zLZDIJsgPPHx9V
         QOm3X+Hh6XtXAEGHHoPrXOlRF2uVtwtNJSnJAED08wVcFwYco+3Rb56gJOon5Ep9biPs
         Hs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1peXTtmSrcQ3dL48f3CYybJCQz0USIg581c+9mV1CRU=;
        b=pSXJ9OQjrrcMg5o183kxV6KuFRmw5YLAo3txfUPvzKjEshtxtKdh8EeXcf5YMu+jSA
         0wBQ07dRYhXJ0I4nPeMmEPvFkfFb8GfbMIWPa0pjxrHIC5t4yH+QF3yImTl31Hbd37au
         91t4UvTG/LSl4gjIjP9P8A4x4ERPceRlFvb9SB1iIgNdf17lPdht2RJ+XJbYqpaZaymk
         cc+NRbfxP/dG9HGGPMFJS5Dd7nQQQ6h+RoMtZHzoQ12aieAvFDWJ94zIQtpwZi+ZwcvN
         MWqwJKGi0p1/NSpZCvtZrce0hj/+qGEHVzSC+T4QSyo0tjJRut4yyg9Egk/5Y2t4H2Ri
         565g==
X-Gm-Message-State: AOAM533Jb02VMCnL+wCy1AHuOO7WnE1L4YRSqVXtroS+myt263LxOsfM
        pMAxi+cUliu26Cj0cWFokps6Qky5nE8=
X-Google-Smtp-Source: ABdhPJxitaOxAsryeMVvp1RroP6gdCDRkaiA4E4ty7dOq55o6oaRSPSwkVwUFIvrX2eBA+/KJpMqfg==
X-Received: by 2002:a17:90a:5147:: with SMTP id k7mr16597436pjm.73.1629979756662;
        Thu, 26 Aug 2021 05:09:16 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id e21sm992980pfl.188.2021.08.26.05.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 05:09:16 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH] samples: bpf: Fix uninitialized variable in xdp_redirect_cpu
Date:   Thu, 26 Aug 2021 17:39:10 +0530
Message-Id: <20210826120910.454081-1-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While at it, also improve help output when CPU number is greater than
possible.

Fixes: e531a220cc59 ("samples: bpf: Convert xdp_redirect_cpu to XDP samples helper")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 samples/bpf/xdp_redirect_cpu_user.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/xdp_redirect_cpu_user.c b/samples/bpf/xdp_redirect_cpu_user.c
index 631700aef69c..6e25fba64c72 100644
--- a/samples/bpf/xdp_redirect_cpu_user.c
+++ b/samples/bpf/xdp_redirect_cpu_user.c
@@ -141,7 +141,7 @@ static int create_cpu_entry(__u32 cpu, struct bpf_cpumap_val *value,
 static int mark_cpus_unavailable(void)
 {
 	int ret, i, n_cpus = libbpf_num_possible_cpus();
-	__u32 invalid_cpu;
+	__u32 invalid_cpu = n_cpus;
 
 	for (i = 0; i < n_cpus; i++) {
 		ret = bpf_map_update_elem(avail_fd, &i,
@@ -449,8 +449,9 @@ int main(int argc, char **argv)
 			add_cpu = strtoul(optarg, NULL, 0);
 			if (add_cpu >= n_cpus) {
 				fprintf(stderr,
-				"--cpu nr too large for cpumap err(%d):%s\n",
+				"--cpu nr too large for cpumap err (%d):%s\n",
 					errno, strerror(errno));
+				usage(argv, long_options, __doc__, mask, true, skel->obj);
 				goto end_cpu;
 			}
 			cpu[added_cpus++] = add_cpu;
-- 
2.33.0

