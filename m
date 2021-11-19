Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA084576B6
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 19:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhKSSx5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 13:53:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233265AbhKSSxv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 13:53:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09FA761AEC;
        Fri, 19 Nov 2021 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637347849;
        bh=3aS64+IIhxPXg0oySVZy2bidCseJI4O7XC4cfXPiIB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0QwUh7DT5O03Sia2suW8YMnbQXOP1+OTxODp9uZjJjhLefbgUZ65yhNuoqnlARqp
         okegBLPiC/UJm3cGTr0bBa4kqSjp+F4m9QXQMaTdK/S7D/x66FzqsLRTDljUOf4bg4
         9z/DqtMWmoSLsNxQOSjlhNo0E6V9F1SIrWTXUPzSCA4L208KD7Q41p+rbJVnBXcu+C
         oSlpa1qB93YCkzGMIV3D+YasyBbrYOPfRsPH7LgrzhwLp2QVdCgNWIC2a8mclO2/Zu
         NLdZpCe50qyXHv+OtJ+MN6fIP9C+LjZ5khGyTozsz6EfKzVfMIkUhRRnGxUu1T0lxH
         bgVsmfb6JOgmA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [RFC bpf-next 5/6] bpf: remove the cgroup -> bpf header dependecy
Date:   Fri, 19 Nov 2021 10:50:42 -0800
Message-Id: <20211119185043.3937836-6-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119185043.3937836-1-kuba@kernel.org>
References: <20211119185043.3937836-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that the stage has been set and actors are in place
remove the header dependency between cgroup and bpf.h.

This reduces the incremental build size of x86 allmodconfig
after bpf.h was touched from ~17k objects rebuilt to ~5k objects.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/bpf-cgroup.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 12474516e0be..4c932d47e7f2 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -2,7 +2,8 @@
 #ifndef _BPF_CGROUP_H
 #define _BPF_CGROUP_H
 
-#include <linux/bpf.h>
+#include <linux/bpf-cgroup-types.h>
+#include <linux/bpf-link.h>
 #include <linux/errno.h>
 #include <linux/jump_label.h>
 #include <linux/percpu.h>
@@ -16,6 +17,7 @@ struct cgroup;
 struct sk_buff;
 struct bpf_map;
 struct bpf_prog;
+struct bpf_prog_aux;
 struct bpf_sock_ops_kern;
 struct bpf_cgroup_storage;
 struct ctl_table;
-- 
2.31.1

