Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09730374669
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 19:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbhEERQ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 13:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236683AbhEEQ6J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 12:58:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A056619A8;
        Wed,  5 May 2021 16:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620232776;
        bh=hRkWyVwECxJrACDvgrt+TQxmgiORLhFnvePP7UIObDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=duiIkXNocQ8r9Q3vXPxll2yqda78pkZT/zdGzcOuEC5TepxFeCXY4hw42iZT6Rto2
         93jN9BGiqHpAcVmQBvg/eVrKKQewLRgOS2byb4hmNaqe0Xwe/8xmGprtdRHaAjqdkY
         5WhCx5UfO2JHszHAqsqtr6D+q2ECAr7TPmFT9SvEr62zGMlakGKZ9ndQiVAi9JOFCy
         pA7L7BphYx69QnQDBEIusW6fcOL4Z30LfcCOlVsqpZ430C5kAgbTskeXinzwepe5Hs
         RKqlgBDhRy8UE8scSpjuLmQJyETOVOwRkU1zvFKl0KrnqssRPZDWxHd8kyXPFnU/Vt
         bGsHa59o3KTIw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.4 27/46] selftests: Set CC to clang in lib.mk if LLVM is set
Date:   Wed,  5 May 2021 12:38:37 -0400
Message-Id: <20210505163856.3463279-27-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163856.3463279-1-sashal@kernel.org>
References: <20210505163856.3463279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

[ Upstream commit 26e6dd1072763cd5696b75994c03982dde952ad9 ]

selftests/bpf/Makefile includes lib.mk. With the following command
  make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
  make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1 V=1
some files are still compiled with gcc. This patch
fixed lib.mk issue which sets CC to gcc in all cases.

Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20210413153413.3027426-1-yhs@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/lib.mk | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 3ed0134a764d..67386aa3f31d 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -1,6 +1,10 @@
 # This mimics the top-level Makefile. We do it explicitly here so that this
 # Makefile can operate with or without the kbuild infrastructure.
+ifneq ($(LLVM),)
+CC := clang
+else
 CC := $(CROSS_COMPILE)gcc
+endif
 
 ifeq (0,$(MAKELEVEL))
     ifeq ($(OUTPUT),)
-- 
2.30.2

