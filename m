Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0852B513C
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 20:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKPTd5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 16 Nov 2020 14:33:57 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:22831 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbgKPTd5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 14:33:57 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-uOUAOB2MM627mkL4MKt55A-1; Mon, 16 Nov 2020 14:33:53 -0500
X-MC-Unique: uOUAOB2MM627mkL4MKt55A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79A416416B;
        Mon, 16 Nov 2020 19:33:51 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFF866FF01;
        Mon, 16 Nov 2020 19:33:49 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH] btf_encoder: Move btf_elf__verbose/btf_elf__force setup
Date:   Mon, 16 Nov 2020 20:33:48 +0100
Message-Id: <20201116193348.1222960-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With introduction of collect_symbols function, we moved the
percpu variables code before btf_elf__verbose/btf_elf__force
setup, so they don't have any effect in that code anymore.

Also btf_elf__verbose is used in code that prepares ftrace
filter for functions generations, also called within
collect_symbols function.

Moving btf_elf__verbose/btf_elf__force setup early in the
cu__encode_btf function, so we can get verbose messages
and see the effect of the force option.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index f3f6291391ee..4f856cfd5577 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -540,6 +540,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 	struct tag *pos;
 	int err = 0;
 
+	btf_elf__verbose = verbose;
+	btf_elf__force = force;
+
 	if (btfe && strcmp(btfe->filename, cu->filename)) {
 		err = btf_encoder__encode();
 		if (err)
@@ -579,8 +582,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		}
 	}
 
-	btf_elf__verbose = verbose;
-	btf_elf__force = force;
 	type_id_off = btf__get_nr_types(btfe->btf);
 
 	cu__for_each_type(cu, core_id, pos) {
-- 
2.26.2

