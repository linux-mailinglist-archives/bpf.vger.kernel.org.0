Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6C21F48E9
	for <lists+bpf@lfdr.de>; Tue,  9 Jun 2020 23:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgFIVfO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jun 2020 17:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgFIVfN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jun 2020 17:35:13 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFFAC05BD1E
        for <bpf@vger.kernel.org>; Tue,  9 Jun 2020 14:35:13 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id er17so88500qvb.8
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2020 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oeLvh20/38kPMU06wHKDJOD0PAxc5JqCCn0SDTWIRwU=;
        b=JN2s7HvpSTWbdFEEdzxY1aC+JnIAozpu0zknCryRSW5cdt/FXNK0+vWJf0lN8B+qoa
         LrmWSTONhTPD1c8IJx1juVwVE3mF5J2ZnhCpdGNHhy0vfxp+rGFE+y1IkRLv+3AYa6w/
         WHAwszDthySFdRUN9dY0KCKZv42G+ruOcwrNK0E5x8pPudis/DXnNU4rXoiPXa1eXv6Q
         7iLMieIoQlfw9mxHH3kJtYSFiwyJPmQtF/YOQfqk9oz7PiRvpz2c77mmrzEFVt2nwnwd
         Wavx+3WaofuVlccoenCNxHHvG6fUqz558hLSGRvrowSKS6ZYONkdLC+gITZwz8qnGha3
         PQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oeLvh20/38kPMU06wHKDJOD0PAxc5JqCCn0SDTWIRwU=;
        b=idlv3FumXAMTfLabEllabcpLPL+K2A36kPi++ZXRqWxEqutG4ncKg1UIeMwr+h5wcP
         PGV0dEdjWFbNCRUuYA+AWQYOlfQ5FdqZWre1Czn96FT1pduM0KEUDJPm3hJzPHZRwpkG
         KnSZg89BiYrDChsxvpSuCDa9vxs6SK5/Rd7KSoGRV/dtAUiqss5mZVbS6vDnIqLw4mp+
         T0g4lQyjq0PBuSPg6m2WbrVD5uKRomKqVsMKlhg/ofWLx83WnUUCBAXFPNcz2TElqXlg
         bQUQFFDzn+ax7zqM9WSQ/riYSTpwUI6/oRR/XT8//lfCNIlxIybVXrnVZnDxMhDC+xE3
         wigw==
X-Gm-Message-State: AOAM532Iohq1U6ZYtAPWYEjmfI0/lfQEOu7qCdPdyzaCzLdQKFZDgX6/
        A5CfrH8IKjw27jBg7sRg+yljKTAr
X-Google-Smtp-Source: ABdhPJyWgfy0Plu9zRN40MndppoD8ELJGKvllYhVnmolJmW2XpAMoPjT9zjYnJkVpPDp0n8E4MdbgQ==
X-Received: by 2002:ad4:5668:: with SMTP id bm8mr143549qvb.248.1591738512493;
        Tue, 09 Jun 2020 14:35:12 -0700 (PDT)
Received: from osboxes.example.com (cpe-74-136-86-203.kya.res.rr.com. [74.136.86.203])
        by smtp.gmail.com with ESMTPSA id p185sm10799798qkd.128.2020.06.09.14.35.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 14:35:11 -0700 (PDT)
From:   Brett Mastbergen <brett.mastbergen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     brett.mastbergen@gmail.com
Subject: [PATCH] tools: bpf: Do not force gcc as CC
Date:   Tue,  9 Jun 2020 17:35:06 -0400
Message-Id: <20200609213506.3299-1-brett.mastbergen@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This allows transparent cross-compilation with CROSS_COMPILE by
relying on 7ed1c1901fe5 ("tools: fix cross-compile var clobbering").

Same change was applied to tools/bpf/bpftool/Makefile in
9e88b9312acb ("tools: bpftool: do not force gcc as CC").

Signed-off-by: Brett Mastbergen <brett.mastbergen@gmail.com>
---
 tools/bpf/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index f897eeeb0b4f..50ef68749d4a 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -3,7 +3,6 @@ include ../scripts/Makefile.include
 
 prefix ?= /usr/local
 
-CC = gcc
 LEX = flex
 YACC = bison
 MAKE = make
-- 
2.11.0

