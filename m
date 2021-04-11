Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CEC35B479
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbhDKNAz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 11 Apr 2021 09:00:55 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:48969 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235641AbhDKNAz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 11 Apr 2021 09:00:55 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-LzoibjDuPJqC8VfkZK9xBQ-1; Sun, 11 Apr 2021 09:00:35 -0400
X-MC-Unique: LzoibjDuPJqC8VfkZK9xBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7F9D18397A0;
        Sun, 11 Apr 2021 13:00:33 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D886101E24A;
        Sun, 11 Apr 2021 13:00:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCHv3 bpf-next 5/5] selftests/bpf: Test that module can't be unloaded with attached trampoline
Date:   Sun, 11 Apr 2021 15:00:10 +0200
Message-Id: <20210411130010.1337650-6-jolsa@kernel.org>
In-Reply-To: <20210411130010.1337650-1-jolsa@kernel.org>
References: <20210411130010.1337650-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding test to verify that once we attach module's trampoline,
the module can't be unloaded.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/module_attach.c  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
index 5bc53d53d86e..d85a69b7ce44 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
@@ -45,12 +45,18 @@ static int trigger_module_test_write(int write_sz)
 	return 0;
 }
 
+static int delete_module(const char *name, int flags)
+{
+	return syscall(__NR_delete_module, name, flags);
+}
+
 void test_module_attach(void)
 {
 	const int READ_SZ = 456;
 	const int WRITE_SZ = 457;
 	struct test_module_attach* skel;
 	struct test_module_attach__bss *bss;
+	struct bpf_link *link;
 	int err;
 
 	skel = test_module_attach__open();
@@ -84,6 +90,23 @@ void test_module_attach(void)
 	ASSERT_EQ(bss->fexit_ret, -EIO, "fexit_tet");
 	ASSERT_EQ(bss->fmod_ret_read_sz, READ_SZ, "fmod_ret");
 
+	test_module_attach__detach(skel);
+
+	/* attach fentry/fexit and make sure it get's module reference */
+	link = bpf_program__attach(skel->progs.handle_fentry);
+	if (!ASSERT_OK_PTR(link, "attach_fentry"))
+		goto cleanup;
+
+	ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
+	bpf_link__destroy(link);
+
+	link = bpf_program__attach(skel->progs.handle_fexit);
+	if (!ASSERT_OK_PTR(link, "attach_fexit"))
+		goto cleanup;
+
+	ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
+	bpf_link__destroy(link);
+
 cleanup:
 	test_module_attach__destroy(skel);
 }
-- 
2.30.2

