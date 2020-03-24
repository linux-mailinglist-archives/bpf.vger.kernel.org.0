Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 232581918B2
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 19:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgCXSNH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 14:13:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55001 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727672AbgCXSNE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Mar 2020 14:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585073583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3Wa07YAd+zFovCvokyH5i/22yVWoZ1gMGqsMWsRY8s=;
        b=QX0jNF+FsuYf1JIYegpbHkV0jP8+bp91Z2VC1ezU5wFKqaSU4wdKKMwd1GazQkjJKLFjo3
        ve/0XpFm8YG/QkGfo7OImBCeto9oYmZKsyNyR3pF40jToQoO4qO8H10zMnMvLC/DQxQb6/
        A4+lXQoO9wrYYONPXHL+G5Z+A/gLk/E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-TQEtcRN0O2aDI_7hvLv7Hg-1; Tue, 24 Mar 2020 14:13:02 -0400
X-MC-Unique: TQEtcRN0O2aDI_7hvLv7Hg-1
Received: by mail-wr1-f69.google.com with SMTP id v6so9513631wrg.22
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2020 11:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=R3Wa07YAd+zFovCvokyH5i/22yVWoZ1gMGqsMWsRY8s=;
        b=ihduuBfjhQ9lCs33BjcQwNTwSB+W1nZrH9NeR6m2lGF0kWur6fM/FxLvBGwEyK4DkL
         2t+4SuT0qjObiBgMwfP+qq9YsYWYzLN1ARsvJArAash4OqwaZiRKKNTRkoWDrQHe3hC9
         tYv+cKLZrcAkl0Fk7h0P4A0UH+TES8S6Oasgp42+jACxi7c7C2VAdRmNmW5rismwFJEP
         nHPGFkMg/VAhTGJ9YaxBVneWv8Im3psdcsLuyEguhBMG4OL6LbTTUsbS0Y2FcrQXzYO7
         SuDfR3lNc0Y0Aa4688Ar+DxXF2rpa4jM9QJlb2BZdi9P0auN8dNp6V6/MKpIxBUoLs4O
         61uA==
X-Gm-Message-State: ANhLgQ32txm2a0dpGf1mMQZr3y30Lmuv1wIn7cu/Wwt1aZHGBbkDWiW+
        gGHHDF6+Q3n/2ge+t+b0wQ6XImSjoU4kD7/2JNL7LyCuPbqkwe55nx/rM49b6snOptpEtQLTuZ5
        K3GFsLU0G2qwM
X-Received: by 2002:a05:600c:2101:: with SMTP id u1mr7012071wml.177.1585073581084;
        Tue, 24 Mar 2020 11:13:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvpNYRWpV6uRP+NqVy6W9zqRQjKTec8plOaPvuVG45PE92D30xfQiDfaCz8oZmdrLiInBErZw==
X-Received: by 2002:a05:600c:2101:: with SMTP id u1mr7012049wml.177.1585073580838;
        Tue, 24 Mar 2020 11:13:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j2sm13308840wrs.64.2020.03.24.11.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:12:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5C64118158B; Tue, 24 Mar 2020 19:12:56 +0100 (CET)
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Add tests for attaching XDP
 programs
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, Andrey Ignatov <rdna@fb.com>
Date:   Tue, 24 Mar 2020 19:12:56 +0100
Message-ID: <158507357632.6925.5524660251258919856.stgit@toke.dk>
In-Reply-To: <158507357205.6925.17804771242752938867.stgit@toke.dk>
References: <158507357205.6925.17804771242752938867.stgit@toke.dk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds tests for the various replacement operations using
IFLA_XDP_EXPECTED_ID.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../testing/selftests/bpf/prog_tests/xdp_attach.c  |   74 ++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_attach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
new file mode 100644
index 000000000000..190df7599107
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#define IFINDEX_LO 1
+#define XDP_FLAGS_EXPECT_ID		(1U << 4)
+
+void test_xdp_attach(void)
+{
+	struct bpf_object *obj1, *obj2, *obj3;
+	const char *file = "./test_xdp.o";
+	struct bpf_prog_info info = {};
+	__u32 duration = 0, id1, id2;
+	__u32 len = sizeof(info);
+	int err, fd1, fd2, fd3;
+	DECLARE_LIBBPF_OPTS(bpf_xdp_set_link_opts, opts);
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj1, &fd1);
+	if (CHECK_FAIL(err))
+		return;
+	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj2, &fd2);
+	if (CHECK_FAIL(err))
+		goto out_1;
+	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj3, &fd3);
+	if (CHECK_FAIL(err))
+		goto out_2;
+
+	err = bpf_obj_get_info_by_fd(fd1, &info, &len);
+	if (CHECK_FAIL(err))
+		goto out_2;
+	id1 = info.id;
+
+	memset(&info, 0, sizeof(info));
+	err = bpf_obj_get_info_by_fd(fd2, &info, &len);
+	if (CHECK_FAIL(err))
+		goto out_2;
+	id2 = info.id;
+
+	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, fd1, XDP_FLAGS_EXPECT_ID,
+				       &opts);
+	if (CHECK(err, "load_ok", "initial load failed"))
+		goto out_close;
+
+	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, fd2, XDP_FLAGS_EXPECT_ID,
+				       &opts);
+	if (CHECK(!err, "load_fail", "load with expected id didn't fail"))
+		goto out;
+
+	opts.old_id = id1;
+	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, fd2, 0, &opts);
+	if (CHECK(err, "replace_ok", "replace valid old_id failed"))
+		goto out;
+
+	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, fd3, 0, &opts);
+	if (CHECK(!err, "replace_fail", "replace invalid old_id didn't fail"))
+		goto out;
+
+	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, -1, 0, &opts);
+	if (CHECK(!err, "remove_fail", "remove invalid old_id didn't fail"))
+		goto out;
+
+	opts.old_id = id2;
+	err = bpf_set_link_xdp_fd_opts(IFINDEX_LO, -1, 0, &opts);
+	if (CHECK(err, "remove_ok", "remove valid old_id failed"))
+		goto out;
+
+out:
+	bpf_set_link_xdp_fd(IFINDEX_LO, -1, 0);
+out_close:
+	bpf_object__close(obj3);
+out_2:
+	bpf_object__close(obj2);
+out_1:
+	bpf_object__close(obj1);
+}

