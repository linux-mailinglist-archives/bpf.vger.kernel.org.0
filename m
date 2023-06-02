Return-Path: <bpf+bounces-1733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEDC720979
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 21:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2A91C2119B
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 19:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A9C1DDEE;
	Fri,  2 Jun 2023 19:02:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2B19E45
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 19:02:53 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA851B6;
	Fri,  2 Jun 2023 12:02:48 -0700 (PDT)
Date: Fri, 02 Jun 2023 19:02:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rhysre.net;
	s=protonmail2; t=1685732566; x=1685991766;
	bh=4ec16uhnfS31YjPYD7pz+sF1nQMEnJwmSUYIRDWmsKc=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oa+ilQO0Hz/kxS+6P69EG/R6Efg2aA4N2HNQgDNQnxIBeSrx7D2+S9NFmSiTXXP3b
	 7OdfvU8+elkP7Wjrdait0sQGKrWGfES6FQ6ZPydT60wYdCzFXYmAOHwMA7fX1uF8IM
	 61n9gawXlVdjlFXK+YaK93fomM51ZCCfWELdjGsGHwNgd+fdaPIgQE1KSfSlgi0U1O
	 VgYcHtFo97+rbf0zyj8FHHfmtsA44AN8gyccpzC7AXyicCjBOZ/q9FpLS+NrU3Ke2I
	 TTlaNUh6cO3wMpMbdqqFuJEgPllBafktBsXNdYMgrihsCun07UcI4Th8SSK3ne3VnE
	 UN/yI+9pDqChA==
From: Rhys Rustad-Elliott <me@rhysre.net>
Cc: Rhys Rustad-Elliott <me@rhysre.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add access_inner_map selftest
Message-ID: <20230602190110.47068-3-me@rhysre.net>
In-Reply-To: <20230602190110.47068-1-me@rhysre.net>
References: <20230602190110.47068-1-me@rhysre.net>
Feedback-ID: 51368404:user:proton
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a selftest that accesses a BPF_MAP_TYPE_ARRAY (at a nonzero index)
nested within a BPF_MAP_TYPE_HASH_OF_MAPS to flex a previously buggy
case.

Signed-off-by: Rhys Rustad-Elliott <me@rhysre.net>
---
 .../bpf/prog_tests/inner_array_lookup.c       | 31 +++++++++++++
 .../bpf/progs/test_inner_array_lookup.c       | 45 +++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/inner_array_look=
up.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_inner_array_look=
up.c

diff --git a/tools/testing/selftests/bpf/prog_tests/inner_array_lookup.c b/=
tools/testing/selftests/bpf/prog_tests/inner_array_lookup.c
new file mode 100644
index 000000000000..29d4d0067c60
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/inner_array_lookup.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <test_progs.h>
+
+#include "test_inner_array_lookup.skel.h"
+
+void test_inner_array_lookup(void)
+{
+=09int map1_fd, err;
+=09int key =3D 3;
+=09int val =3D 1;
+=09struct test_inner_array_lookup *skel;
+
+=09skel =3D test_inner_array_lookup__open_and_load();
+=09if (!ASSERT_TRUE(skel !=3D NULL, "open_load_skeleton"))
+=09=09return;
+
+=09err =3D test_inner_array_lookup__attach(skel);
+=09if (!ASSERT_TRUE(err =3D=3D 0, "skeleton_attach"))
+=09=09goto cleanup;
+
+=09map1_fd =3D bpf_map__fd(skel->maps.inner_map1);
+=09bpf_map_update_elem(map1_fd, &key, &val, 0);
+
+=09/* Probe should have set the element at index 3 to 2 */
+=09bpf_map_lookup_elem(map1_fd, &key, &val);
+=09ASSERT_TRUE(val =3D=3D 2, "value_is_2");
+
+cleanup:
+=09test_inner_array_lookup__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_inner_array_lookup.c b/=
tools/testing/selftests/bpf/progs/test_inner_array_lookup.c
new file mode 100644
index 000000000000..c2c8f2fa451d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_inner_array_lookup.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct inner_map {
+=09__uint(type, BPF_MAP_TYPE_ARRAY);
+=09__uint(max_entries, 5);
+=09__type(key, int);
+=09__type(value, int);
+} inner_map1 SEC(".maps");
+
+struct outer_map {
+=09__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+=09__uint(max_entries, 3);
+=09__type(key, int);
+=09__array(values, struct inner_map);
+} outer_map1 SEC(".maps") =3D {
+=09.values =3D {
+=09=09[2] =3D &inner_map1,
+=09},
+};
+
+SEC("raw_tp/sys_enter")
+int handle__sys_enter(void *ctx)
+{
+=09int outer_key =3D 2, inner_key =3D 3;
+=09int *val;
+=09void *map;
+
+=09map =3D bpf_map_lookup_elem(&outer_map1, &outer_key);
+=09if (!map)
+=09=09return 1;
+
+=09val =3D bpf_map_lookup_elem(map, &inner_key);
+=09if (!val)
+=09=09return 1;
+
+=09if (*val =3D=3D 1)
+=09=09*val =3D 2;
+
+=09return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.40.1



