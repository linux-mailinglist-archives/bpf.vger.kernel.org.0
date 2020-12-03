Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1552CE154
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 23:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgLCWHb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 3 Dec 2020 17:07:31 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:24861 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728515AbgLCWHb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Dec 2020 17:07:31 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-YKhDhDPcPfOs5_2JwijuGA-1; Thu, 03 Dec 2020 17:06:34 -0500
X-MC-Unique: YKhDhDPcPfOs5_2JwijuGA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 987A0192D785;
        Thu,  3 Dec 2020 22:06:32 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D69C75D9CA;
        Thu,  3 Dec 2020 22:06:30 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH 2/3] btf_encoder: Use address size based on ELF's class
Date:   Thu,  3 Dec 2020 23:06:24 +0100
Message-Id: <20201203220625.3704363-3-jolsa@kernel.org>
In-Reply-To: <20201203220625.3704363-1-jolsa@kernel.org>
References: <20201203220625.3704363-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We can't assume the address size is always size of unsigned
long, we have to use directly the ELF's address size.

Changing addrs array to __u64 and convert 32 bit address
values when copying from ELF section.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 0a33388db675..398be0fbf7c7 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -93,8 +93,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
 
 static int addrs_cmp(const void *_a, const void *_b)
 {
-	const unsigned long *a = _a;
-	const unsigned long *b = _b;
+	const __u64 *a = _a;
+	const __u64 *b = _b;
 
 	if (*a == *b)
 		return 0;
@@ -102,9 +102,10 @@ static int addrs_cmp(const void *_a, const void *_b)
 }
 
 static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
-			     unsigned long **paddrs, unsigned long *pcount)
+			     __u64 **paddrs, __u64 *pcount)
 {
-	unsigned long *addrs, count, offset;
+	__u64 *addrs, count, offset;
+	unsigned int addr_size, i;
 	Elf_Data *data;
 	GElf_Shdr shdr;
 	Elf_Scn *sec;
@@ -128,8 +129,11 @@ static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
 		return -1;
 	}
 
+	/* Get address size from processed file's ELF class. */
+	addr_size = gelf_getclass(btfe->elf) == ELFCLASS32 ? 4 : 8;
+
 	offset = fl->mcount_start - shdr.sh_addr;
-	count  = (fl->mcount_stop - fl->mcount_start) / 8;
+	count  = (fl->mcount_stop - fl->mcount_start) / addr_size;
 
 	data = elf_getdata(sec, 0);
 	if (!data) {
@@ -144,7 +148,13 @@ static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
 		return -1;
 	}
 
-	memcpy(addrs, data->d_buf + offset, count * sizeof(addrs[0]));
+	if (addr_size == sizeof(__u64)) {
+		memcpy(addrs, data->d_buf + offset, count * addr_size);
+	} else {
+		for (i = 0; i < count; i++)
+			addrs[i] = (__u64) *((__u32 *) (data->d_buf + offset + i * addr_size));
+	}
+
 	*paddrs = addrs;
 	*pcount = count;
 	return 0;
@@ -152,7 +162,7 @@ static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
 
 static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
 {
-	unsigned long *addrs, count, i;
+	__u64 *addrs, count, i;
 	int functions_valid = 0;
 
 	/*
-- 
2.26.2

