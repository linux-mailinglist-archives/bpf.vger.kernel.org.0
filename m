Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160404F1114
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 10:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiDDIkQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 04:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiDDIkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 04:40:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FEF3615E
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 01:38:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D654D1F37F;
        Mon,  4 Apr 2022 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649061498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5SASgVU2tKlDoPTOgSm8ybQ/b2IEozHXtZMIMiua7V4=;
        b=VtqZtazbAYAApJUqa1uEZk93a77IYagJ6zDkhUb/2qDueb/AxCuVKbAuWTUKb4WEYapJFf
        84aRmcOJjQcsNWmrwLJJnGRyFM9nUNeTFzBXV0APrTNUAH6uJz7rZAjGjGxVpWcxoozZGo
        t1jyLQBWnuwBoSoBLfLLQQNYpEH6FCw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7ADA713216;
        Mon,  4 Apr 2022 08:38:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gEnuGnquSmKuBQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 04 Apr 2022 08:38:18 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [RFC PATCH 2/2] libbpf: Add btf__field_exists
Date:   Mon,  4 Apr 2022 11:38:16 +0300
Message-Id: <20220404083816.1560501-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404083816.1560501-1-nborisov@suse.com>
References: <20220404083816.1560501-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There isn't currently a convenience function to check if a particular
kernel version is running similar to bpf_core_field_exists. There can be
cases where based on the actual kernel being run different kprobes has
to be used when tracing the kernel. One example is the change introduced
in 4c5b47997521 ("vfs: add fileattr ops"). Before this commit if one
wants to trace fileattr changes this has to be done by a distinct kprobe
on every filesystem as there was no common code where fileattr changes
when through. Post this commit this can be performed by a single kprobe
on the common vfs_fileattr_set function.

To accommodate such use cases simply add a libbpf api btf__field_exists
which can be used to check for the running kernel version and act
appropriately.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tools/lib/bpf/btf.c      | 28 ++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 31 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9aa19c89f758..890a2071bd00 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -697,6 +697,34 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
+bool btf__field_exists(const struct btf *btf, const char *struct_name,
+		       const char *field_name)
+{
+	const struct btf_type *t;
+	struct btf_member *m;
+	int i;
+	__s32 type_id = btf__find_by_name(btf, struct_name);
+
+	if (type_id < 0)
+		return false;
+
+	t = btf__type_by_id(btf, type_id);
+	if (!t)
+		return false;
+
+	if (!btf_is_composite(t))
+		return false;
+
+	for_each_member(i, t, m) {
+		const char *n = btf__name_by_offset(btf, m->name_off);
+
+		if (strcmp(n, field_name) == 0)
+			return true;
+	}
+
+	return false;
+}
+
 __s32 btf__find_by_name(const struct btf *btf, const char *type_name)
 {
 	__u32 i, nr_types = btf__type_cnt(btf);
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 74039f8afc63..1eb8d840b46b 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -144,6 +144,8 @@ LIBBPF_API enum btf_endianness btf__endianness(const struct btf *btf);
 LIBBPF_API int btf__set_endianness(struct btf *btf, enum btf_endianness endian);
 LIBBPF_API __s64 btf__resolve_size(const struct btf *btf, __u32 type_id);
 LIBBPF_API int btf__resolve_type(const struct btf *btf, __u32 type_id);
+LIBBPF_API bool btf__field_exists(const struct btf *btf, const char *struct_name,
+				 const char *field_name);
 LIBBPF_API int btf__align_of(const struct btf *btf, __u32 id);
 LIBBPF_API int btf__fd(const struct btf *btf);
 LIBBPF_API void btf__set_fd(struct btf *btf, int fd);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 529783967793..9a0d50604cca 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -427,6 +427,7 @@ LIBBPF_0.7.0 {
 		bpf_program__log_level;
 		bpf_program__set_log_buf;
 		bpf_program__set_log_level;
+		btf__field_exists;
 		libbpf_probe_bpf_helper;
 		libbpf_probe_bpf_map_type;
 		libbpf_probe_bpf_prog_type;
-- 
2.25.1

