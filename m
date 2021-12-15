Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE214750F8
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 03:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhLOCbw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 21:31:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50968 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbhLOCbv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 21:31:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 837886179F
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 02:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2545C3460B;
        Wed, 15 Dec 2021 02:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639535510;
        bh=iitfXktrLNP9o39lllAFXBBikGwWFAaW2/MflXzJ6i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oaQrsHG37pIPsrM4rPdaC8Vda6jNFx9BFQG0IeRAdZD5yZH3lb12BpyQ9MtL6IunD
         NG1R2nOK1gwRrqljF7gyIh65qDKvUEj8bMzzwHqYVqLy+qmfTNsAAn1W3BfVu9WnF6
         AJU7dzIisxKWJuZVnzV+b7/KCOadlAyNmH7z+OETOcHxflXyg/KvGbhUjNeiGsWAqd
         MUxcMJ7GpQQnE4BHPKTF8ayiTPqB6oUZR6PfyXzTTQScDmIhpHtnt0isXGrpCmuzll
         sOPAn+gyjePcWr9DXEVlxmTONVUOu7WmbiwC+kJDKcGUUG3cmlodkf2pvN1UNuokkW
         Tr+6S+KxDE4yQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v2 4/4] bpf: remove the cgroup -> bpf header dependecy
Date:   Tue, 14 Dec 2021 18:31:26 -0800
Message-Id: <20211215023126.659200-5-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211215023126.659200-1-kuba@kernel.org>
References: <20211215023126.659200-1-kuba@kernel.org>
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

