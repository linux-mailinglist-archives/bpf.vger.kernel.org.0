Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD02243EAE
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 20:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMSIR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 14:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSIR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Aug 2020 14:08:17 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0E1C061757
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 11:08:16 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m34so3196726pgl.11
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 11:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9OTxTnhv+MmIJnpSlGbqd2lqUESFkP194TAlXuIp4c=;
        b=smlkFr+R04KSC7hCaky/lScRar9l/gVRkDchVhwxUEItgndtDbl2xdoDQQ/EzvVI1U
         LJJ4Sf6PtUi8cU6gfJc1rMnXi1UltX74UsW4FQOdrQ9avhAHn0Oa8wtmbFkhKvB43ulV
         wHdO9r58OTtiW9616QCvHDtYNfIs1gvTDJAEcXMrjw9+3TWs7mf3aFju7V4tKc4jCJlH
         8zsgjwvo1kca+dZeKAiH3U4U2QPRPWq5S/++eNPeby0Xz3bGeoHzZu1jjm+61mopNaAi
         2bac3D2ylChU4iOSoieeNZSo9Z5rve9/VQphXdVgNXi+wwcTu/7GQ0at2uvmlko3Vdie
         GHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=j9OTxTnhv+MmIJnpSlGbqd2lqUESFkP194TAlXuIp4c=;
        b=b4uOUYyPq0lYU1n1g5wd9UICOCs074COgBCoCziC/DCjIUl18p9j/OepDefxsXhFYq
         isYCpC5q4aEtUyCR4N3V1dt6dhYS95yQg2tpJ9Smn9qryr81anKah5a/HetGsgnP755e
         b34pSC6Mx5iTtspmLwcw0ICZ2qtRPE11FFmnH4oPYFbwVePXZFSy08C3Sq4boOILbPQ+
         QjNtqr/d1bLLOoRzhYTAojRVzmkS2OUMFhAKxp19nST+axe+l983k6Uvhra70n/gK7th
         +qYuitcv3SpUV+Xk5wnDZkfnDinMlbGKmy6BHHqnXkQfVg4iMrcFIuiyKR9r955Kt0QC
         fp9A==
X-Gm-Message-State: AOAM530G1c+6xr1pDvjtFLdtiDP6UJzzSewBxUS1x8cBGXR/O4pzUaz2
        2hEvYFyUCqbB8T0BbuG5rzrLUot8
X-Google-Smtp-Source: ABdhPJwXRebcOTvNMkZgzmtEyz2Ib772w5mcG1TVawhTRTv3M/C6eP5CxyyFjavOqs2P/FLvGWtKrA==
X-Received: by 2002:a62:8881:: with SMTP id l123mr5332063pfd.186.1597342095419;
        Thu, 13 Aug 2020 11:08:15 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id mh14sm6133348pjb.23.2020.08.13.11.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 11:08:14 -0700 (PDT)
From:   Joe Stringer <joe@wand.net.nz>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org
Subject: [PATCH bpf] doc: Add link to bpf helpers man page
Date:   Thu, 13 Aug 2020 11:08:07 -0700
Message-Id: <20200813180807.2821735-1-joe@wand.net.nz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf-helpers(7) man pages provide an invaluable description of the
functions that an eBPF program can call at runtime. Link them here.

Signed-off-by: Joe Stringer <joe@wand.net.nz>
---
 Documentation/bpf/index.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index d46429be334e..7e76f0705971 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -35,6 +35,10 @@ Two sets of Questions and Answers (Q&A) are maintained.
    bpf_design_QA
    bpf_devel_QA
 
+Helper functions
+================
+
+* `bpf-helpers(7)`_ maintains a list of helpers available to eBPF programs.
 
 Program types
 =============
@@ -79,4 +83,5 @@ Other
 .. _networking-filter: ../networking/filter.rst
 .. _man-pages: https://www.kernel.org/doc/man-pages/
 .. _bpf(2): https://man7.org/linux/man-pages/man2/bpf.2.html
+.. _bpf-helpers(7): https://man7.org/linux/man-pages/man7/bpf-helpers.7.html
 .. _BPF and XDP Reference Guide: https://docs.cilium.io/en/latest/bpf/
-- 
2.25.1

