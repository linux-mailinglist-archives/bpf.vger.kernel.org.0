Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59A464C1A5
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 02:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiLNBGR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 20:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbiLNBGP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 20:06:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E2413CD2
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 17:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670979929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0sMdSWCtKAxrZ2YmHm1FZQ1iSznBAvnVfrNyWuDplzI=;
        b=emyebX9CA7CBAOzxIt0sFaNXwt/dgNe/8InFxgVa1WxcbtGTXEA///3qP5A+4hF7h+ubW6
        cchk3AXB83I98l+INeFhquY9xyPcmp+K62Rg06lW6hv4bhxTE0sxFG+1D92t8FQq8eUDdn
        ITOuuGbCs+HCnV7iRkUci1ztoYAs/dc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-203-e5DK-5H8Pjahc4GFOX5JNQ-1; Tue, 13 Dec 2022 20:05:28 -0500
X-MC-Unique: e5DK-5H8Pjahc4GFOX5JNQ-1
Received: by mail-ed1-f69.google.com with SMTP id v4-20020a056402348400b0046cbbc786bdso8278384edc.7
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 17:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sMdSWCtKAxrZ2YmHm1FZQ1iSznBAvnVfrNyWuDplzI=;
        b=o5sR6GSNpyntITS8+ByBPdfZ1/GjbR6rMwrmYI19EFRdMUW0C7ko568cAfaHZQJlfE
         qvN/VL+HgCJmdz4NuuJUHfHaZaImRa3bdFHc9v082CVCDDBJdaAmrD3m2+e2B26VB4em
         U15KS7a4Bk20+qNzjXbovidDWYOyUlyCovtRk8nwjD9FidqWBe4ttw5iZAnQCEjMfDyw
         qScwrv4Y6mjvy6m0+W+qHU6/thxq5aXDrNpZl+18yUZwQFAbDv/9l0laJYDngTbzmyi6
         V6OHVHG2ufRU9tG0/d+l/cxTYXT7Pxa31Gr7zu2gS8qnmIw2aeEquJqN0+k6J6P6XzEr
         YMhw==
X-Gm-Message-State: ANoB5pk77WW3G1DhxlX3X7mznVnR5C181cdRe+mhFIwLsTu9ccex6F4Y
        hy3Ck+jlTN1BrSO3JNSxvmjs9qRET/yy6LB5pAM9iAO0Y4Lnmw7oy+HjMNLtXzJTWcJARmmGmW3
        ZqJ93Ayih7IZr
X-Received: by 2002:a17:907:3947:b0:7c1:6794:1623 with SMTP id sp7-20020a170907394700b007c167941623mr11443564ejc.58.1670979926741;
        Tue, 13 Dec 2022 17:05:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf58xTOmQSKWGuIw39pbP9BlAE8IZAKd+B/SgRFhjAVmOsvNgS8xzvrMTOzWrJgCqa8zkBY5eg==
X-Received: by 2002:a17:907:3947:b0:7c1:6794:1623 with SMTP id sp7-20020a170907394700b007c167941623mr11443543ejc.58.1670979925866;
        Tue, 13 Dec 2022 17:05:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u17-20020a170906409100b007c0b6e1c7fdsm5096608ejj.104.2022.12.13.17.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 17:05:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 339A482F424; Wed, 14 Dec 2022 02:05:21 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH bpf v4 2/2] selftests/bpf: Add a test for using a cpumap from an freplace-to-XDP program
Date:   Wed, 14 Dec 2022 02:05:16 +0100
Message-Id: <20221214010517.668943-2-toke@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214010517.668943-1-toke@redhat.com>
References: <20221214010517.668943-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a simple test for inserting an XDP program into a cpumap that is
"owned" by an XDP program that was loaded as PROG_TYPE_EXT (as libxdp
does). Prior to the kernel fix this would fail because the map type
ownership would be set to PROG_TYPE_EXT instead of being resolved to
PROG_TYPE_XDP.

v4:
- Use skeletons for selftest
v3:
- Update comment to better explain the cause
- Add Yonghong's ACK

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 54 +++++++++++++++++++
 .../selftests/bpf/progs/freplace_progmap.c    | 24 +++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_progmap.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index d1e32e792536..efa1fc65840d 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -4,6 +4,8 @@
 #include <network_helpers.h>
 #include <bpf/btf.h>
 #include "bind4_prog.skel.h"
+#include "freplace_progmap.skel.h"
+#include "xdp_dummy.skel.h"
 
 typedef int (*test_cb)(struct bpf_object *obj);
 
@@ -500,6 +502,56 @@ static void test_fentry_to_cgroup_bpf(void)
 	bind4_prog__destroy(skel);
 }
 
+static void test_func_replace_progmap(void)
+{
+	struct bpf_cpumap_val value = { .qsize = 1 };
+	struct freplace_progmap *skel = NULL;
+	struct xdp_dummy *tgt_skel = NULL;
+	int err, tgt_fd;
+	__u32 key = 0;
+
+	skel = freplace_progmap__open();
+	if (!ASSERT_OK_PTR(skel, "prog_open"))
+		return;
+
+	tgt_skel = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(tgt_skel, "tgt_prog_load"))
+		goto out;
+
+	tgt_fd = bpf_program__fd(tgt_skel->progs.xdp_dummy_prog);
+
+	/* Change the 'redirect' program type to be a PROG_TYPE_EXT
+	 * with an XDP target
+	 */
+	bpf_program__set_type(skel->progs.xdp_cpumap_prog, BPF_PROG_TYPE_EXT);
+	bpf_program__set_expected_attach_type(skel->progs.xdp_cpumap_prog, 0);
+	err = bpf_program__set_attach_target(skel->progs.xdp_cpumap_prog,
+					     tgt_fd, "xdp_dummy_prog");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = freplace_progmap__load(skel);
+	if (!ASSERT_OK(err, "obj_load"))
+		goto out;
+
+	/* Prior to fixing the kernel, loading the PROG_TYPE_EXT 'redirect'
+	 * program above will cause the map owner type of 'cpumap' to be set to
+	 * PROG_TYPE_EXT. This in turn will cause the bpf_map_update_elem()
+	 * below to fail, because the program we are inserting into the map is
+	 * of PROG_TYPE_XDP. After fixing the kernel, the initial ownership will
+	 * be correctly resolved to the *target* of the PROG_TYPE_EXT program
+	 * (i.e., PROG_TYPE_XDP) and the map update will succeed.
+	 */
+	value.bpf_prog.fd = bpf_program__fd(skel->progs.xdp_drop_prog);
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.cpu_map),
+				  &key, &value, 0);
+	ASSERT_OK(err, "map_update");
+
+out:
+	xdp_dummy__destroy(tgt_skel);
+	freplace_progmap__destroy(skel);
+}
+
 /* NOTE: affect other tests, must run in serial mode */
 void serial_test_fexit_bpf2bpf(void)
 {
@@ -525,4 +577,6 @@ void serial_test_fexit_bpf2bpf(void)
 		test_func_replace_global_func();
 	if (test__start_subtest("fentry_to_cgroup_bpf"))
 		test_fentry_to_cgroup_bpf();
+	if (test__start_subtest("func_replace_progmap"))
+		test_func_replace_progmap();
 }
diff --git a/tools/testing/selftests/bpf/progs/freplace_progmap.c b/tools/testing/selftests/bpf/progs/freplace_progmap.c
new file mode 100644
index 000000000000..68174c3d7b37
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_progmap.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CPUMAP);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_cpumap_val));
+	__uint(max_entries, 1);
+} cpu_map SEC(".maps");
+
+SEC("xdp/cpumap")
+int xdp_drop_prog(struct xdp_md *ctx)
+{
+	return XDP_DROP;
+}
+
+SEC("xdp")
+int xdp_cpumap_prog(struct xdp_md *ctx)
+{
+	return bpf_redirect_map(&cpu_map, 0, XDP_PASS);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.38.1

