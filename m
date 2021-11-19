Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9949B4576B5
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 19:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbhKSSx5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 13:53:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235285AbhKSSxv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 13:53:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CEEF61B1B;
        Fri, 19 Nov 2021 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637347849;
        bh=ObM+DPxauL3aoCOROfGo45d7GC/v0aHKnJhgv0atH2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvuerhLDwUTMmQgEiJ9OoJy25NDWswPnNY3Q4vYkq7WtxHbsob41sHphJ2f36JokE
         mCzFegfLCr8znxBYOLUxU5RPhzW7FiQ92IOxNEirXISf6IakgK45OgDE/bkw3AN/fe
         Hxw25RRdLvP1VxRPhkBuOPF0SzU1PChTJOn9us5EoV8YVb7hrQP7XpKy88J8kfTr1Y
         VHGVCaB7Jp/QtsBV44rtpLWWKPayDch1x1oQAf+6WXHI/SZwN5swle6AQ7+mr2e4Wt
         LUAVOqBZxK4nQOMibVNTdXDeURGPdWTwkGhHhE+JmHxnnlZORkmGTM+jCflW3aAHrl
         0ghwnfnyOSGGA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [RFC bpf-next 6/6] bpf: push down the bpf-link include
Date:   Fri, 19 Nov 2021 10:50:43 -0800
Message-Id: <20211119185043.3937836-7-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119185043.3937836-1-kuba@kernel.org>
References: <20211119185043.3937836-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Turns out bpf_link is not dereferenced or embedded much.
Since we have separated it out to its own header why not
drop the include from bpf.h completely...

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/bpf.h   | 2 +-
 kernel/bpf/bpf_iter.c | 1 +
 kernel/bpf/syscall.c  | 1 +
 net/core/dev.c        | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1302e0737699..114fd9ced5da 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -23,12 +23,12 @@
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/bpf-cgroup-types.h>
-#include <linux/bpf-link.h>
 #include <linux/bpfptr.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
 struct perf_event;
+struct bpf_link;
 struct bpf_prog;
 struct bpf_prog_aux;
 struct bpf_map;
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b2ee45064e06..219eb181bc2c 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -5,6 +5,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/bpf-link.h>
 
 struct bpf_iter_target_info {
 	struct list_head list;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 50f96ea4452a..d5be38f8ce41 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5,6 +5,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/bpf_lirc.h>
 #include <linux/bpf_verifier.h>
+#include <linux/bpf-link.h>
 #include <linux/btf.h>
 #include <linux/syscalls.h>
 #include <linux/slab.h>
diff --git a/net/core/dev.c b/net/core/dev.c
index 15ac064b5562..c29accce8319 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -93,6 +93,7 @@
 #include <linux/skbuff.h>
 #include <linux/kthread.h>
 #include <linux/bpf.h>
+#include <linux/bpf-link.h>
 #include <linux/bpf_trace.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
-- 
2.31.1

