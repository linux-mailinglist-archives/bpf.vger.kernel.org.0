Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3EB23FEE6
	for <lists+bpf@lfdr.de>; Sun,  9 Aug 2020 17:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgHIPEN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 9 Aug 2020 11:04:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36437 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726478AbgHIPEK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 9 Aug 2020 11:04:10 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-VOgdpMACM6qGM10Jov_YPw-1; Sun, 09 Aug 2020 11:04:05 -0400
X-MC-Unique: VOgdpMACM6qGM10Jov_YPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A75B18FF68C;
        Sun,  9 Aug 2020 15:04:03 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 277935F1EA;
        Sun,  9 Aug 2020 15:03:59 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH v11 bpf-next 14/14] selftests/bpf: Add set test to resolve_btfids
Date:   Sun,  9 Aug 2020 17:03:02 +0200
Message-Id: <20200809150302.686149-15-jolsa@kernel.org>
In-Reply-To: <20200809150302.686149-1-jolsa@kernel.org>
References: <20200809150302.686149-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding test to for sets resolve_btfids. We're checking that
testing set gets properly resolved and sorted.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/resolve_btfids.c | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 3b127cab4864..8826c652adad 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -47,6 +47,15 @@ BTF_ID(struct,  S)
 BTF_ID(union,   U)
 BTF_ID(func,    func)
 
+BTF_SET_START(test_set)
+BTF_ID(typedef, S)
+BTF_ID(typedef, T)
+BTF_ID(typedef, U)
+BTF_ID(struct,  S)
+BTF_ID(union,   U)
+BTF_ID(func,    func)
+BTF_SET_END(test_set)
+
 static int
 __resolve_symbol(struct btf *btf, int type_id)
 {
@@ -116,12 +125,40 @@ int test_resolve_btfids(void)
 	 */
 	for (j = 0; j < ARRAY_SIZE(test_lists); j++) {
 		test_list = test_lists[j];
-		for (i = 0; i < ARRAY_SIZE(test_symbols) && !ret; i++) {
+		for (i = 0; i < ARRAY_SIZE(test_symbols); i++) {
 			ret = CHECK(test_list[i] != test_symbols[i].id,
 				    "id_check",
 				    "wrong ID for %s (%d != %d)\n",
 				    test_symbols[i].name,
 				    test_list[i], test_symbols[i].id);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/* Check BTF_SET_START(test_set) IDs */
+	for (i = 0; i < test_set.cnt; i++) {
+		bool found = false;
+
+		for (j = 0; j < ARRAY_SIZE(test_symbols); j++) {
+			if (test_symbols[j].id != test_set.ids[i])
+				continue;
+			found = true;
+			break;
+		}
+
+		ret = CHECK(!found, "id_check",
+			    "ID %d not found in test_symbols\n",
+			    test_set.ids[i]);
+		if (ret)
+			break;
+
+		if (i > 0) {
+			ret = CHECK(test_set.ids[i - 1] > test_set.ids[i],
+				    "sort_check",
+				    "test_set is not sorted\n");
+			if (ret)
+				break;
 		}
 	}
 
-- 
2.25.4

