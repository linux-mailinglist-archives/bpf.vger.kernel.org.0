Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8AC3C9D73
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 13:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhGOLJN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 07:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241755AbhGOLJH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 07:09:07 -0400
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BACAC061765
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 04:06:13 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4GQWl54QQlzvjfm; Thu, 15 Jul 2021 13:06:09 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH bpf-next] bpftool: Check malloc return value in mount_bpffs_for_pin
Date:   Thu, 15 Jul 2021 13:06:09 +0200
Message-Id: <20210715110609.29364-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes: 49a086c201a9 ("bpftool: implement prog load command")
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/bpf/bpftool/common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 1828bba19020..dc6daa193557 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -222,6 +222,11 @@ int mount_bpffs_for_pin(const char *name)
 	int err = 0;
 
 	file = malloc(strlen(name) + 1);
+	if (!file) {
+		p_err("mem alloc failed");
+		return -1;
+	}
+
 	strcpy(file, name);
 	dir = dirname(file);
 
-- 
2.31.1

