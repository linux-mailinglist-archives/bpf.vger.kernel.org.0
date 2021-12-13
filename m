Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6558F4738AC
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 00:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244240AbhLMXmj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 18:42:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57526 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbhLMXmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 18:42:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E193612CA
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 23:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764D8C34611;
        Mon, 13 Dec 2021 23:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639438958;
        bh=iitfXktrLNP9o39lllAFXBBikGwWFAaW2/MflXzJ6i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U05GdQ0SpmvdxZ/XnTKqTwMvpeWgWgN8DngcufvA7tm38VMnQPD1Kfz3zlyPR9K8G
         2ulc6Ofn5JoTJBX9z5hn6Pwi4nZ5c+lXrVtOTBOA/i2svScRrnrULPg/oHwpBcZnPG
         oBoo3BBWxsnEuGc02dZ0UN8b5VAprH73SYHOw8uZ3gaeyriB+xi/sRxs6FOElLXm8h
         jUtD3KXzkGrsv94M8WOXhREkYA9VXB0hnPTgxf07V6QYbY1w8fDE9BfYxEtkaWZF+s
         pjeNeEVELEd5OktNCv3oYIQuq5WlOwdUDEyQC4b5Tpvp5HTnDuSVng9aD1SLSfRO+/
         CesW3Ue/0FZFw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next 4/5] bpf: remove the cgroup -> bpf header dependecy
Date:   Mon, 13 Dec 2021 15:42:22 -0800
Message-Id: <20211213234223.356977-5-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234223.356977-1-kuba@kernel.org>
References: <20211213234223.356977-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that the stage has been set and actors are in place
remove the header dependency between cgroup and bpf.h.

This reduces the incremental build size of x86 allmodconfig
after bpf.h was touched from ~17k objects rebuilt to ~5k objects.
bpf.h is 2.2kLoC and is modified relatively often.

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

