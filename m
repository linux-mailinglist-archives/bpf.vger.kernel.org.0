Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5CB2D3597
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 22:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgLHVtr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 16:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgLHVtr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 16:49:47 -0500
From:   KP Singh <kpsingh@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf] bpf, doc: Update KP's email in MAINTAINERS
Date:   Tue,  8 Dec 2020 22:49:00 +0100
Message-Id: <20201208214900.80684-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Helps me use a single account to sign off and send patches use
appropriate email redirection without needing to update MAINTAINERS.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 061e64b2423a..2a6e1d409524 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3239,7 +3239,7 @@ R:	Martin KaFai Lau <kafai@fb.com>
 R:	Song Liu <songliubraving@fb.com>
 R:	Yonghong Song <yhs@fb.com>
 R:	John Fastabend <john.fastabend@gmail.com>
-R:	KP Singh <kpsingh@chromium.org>
+R:	KP Singh <kpsingh@kernel.org>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Supported
@@ -3358,7 +3358,7 @@ F:	arch/x86/net/
 X:	arch/x86/net/bpf_jit_comp32.c
 
 BPF LSM (Security Audit and Enforcement using BPF)
-M:	KP Singh <kpsingh@chromium.org>
+M:	KP Singh <kpsingh@kernel.org>
 R:	Florent Revest <revest@chromium.org>
 R:	Brendan Jackman <jackmanb@chromium.org>
 L:	bpf@vger.kernel.org
-- 
2.27.0

