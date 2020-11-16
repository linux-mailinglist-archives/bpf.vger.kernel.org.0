Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE51D2B5276
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 21:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbgKPUZj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 16 Nov 2020 15:25:39 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:53505 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732463AbgKPUZi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 15:25:38 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-kRS3QUdkMO6OSXSA4vULTg-1; Mon, 16 Nov 2020 15:25:33 -0500
X-MC-Unique: kRS3QUdkMO6OSXSA4vULTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5C6781EE9E;
        Mon, 16 Nov 2020 20:25:01 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F232F5D9D3;
        Mon, 16 Nov 2020 20:24:59 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH] btf_encoder: Use better fallback message
Date:   Mon, 16 Nov 2020 21:24:58 +0100
Message-Id: <20201116202458.1228654-1-jolsa@kernel.org>
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

Using more suitable fallback message for the case when the
ftrace filter can't be used because of missing symbols.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 4f856cfd5577..592b31e2cdc9 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -510,7 +510,7 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 			printf("Found %d functions!\n", functions_cnt);
 	} else {
 		if (btf_elf__verbose)
-			printf("vmlinux not detected, falling back to dwarf data\n");
+			printf("ftrace symbols not detected, falling back to DWARF data\n");
 		delete_functions();
 	}
 
-- 
2.26.2

