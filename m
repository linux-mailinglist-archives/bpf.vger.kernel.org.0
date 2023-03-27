Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B876CAC80
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 19:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjC0R45 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjC0R4o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 13:56:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B646D448E
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 10:56:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id er18so28367709edb.9
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 10:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679939767;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f0E97xBZv8JewlbFYefdb9y8+bHQH31iwl3vKE5KB2M=;
        b=emOLWgPAE5E269wTyiHiWOE8Kdz0QIcAB5tfBaq/uWyAb0Lh/BguxQySwhzi9ABVVg
         RCHePQPf54ScFHJkNMOiVO1xfhPD4+zEsAiQBGsy0S6sdqdnUqoPKOOHKMz67Yxyyou1
         SuTBj4z6c9mYYCbI+aaGB+FmtyCP8evPQJ2m2FR1Jv34Ry0kzJRElBW29DsOlNHY6Jfi
         vYZyJh5oyK32AH8zODysTJPzhXlMVqg9LjW6VJ89cIUC7hHVOC+5KOyJTUm2ZvZLf12H
         c/s1rqOfXycrhS3wb7fqJ+s3jV/GloONY+aUZ3Ld0+/e/83Ge8j7arUpGG5NHusQnpX6
         vcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679939767;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0E97xBZv8JewlbFYefdb9y8+bHQH31iwl3vKE5KB2M=;
        b=pwVH5MzZ+JmTpWKxqXYXTXkMWuevHONJ+Bzxe15dXByMprzRGhsIBml506HKl+dqaW
         jprpQ/GV0tolJHOWMrQtUjvO//iLg+/n/NJe7qEea7BHhey9jfctqbvZKUATOO1WvCWr
         VowhtNiAFB7H7EfVx7bxMkvYjvH8BtCIAPnkhEysW5UJxbOFkyzr3qRdBeUy7x++gJNi
         LGFIlEZOartcOgh2Txy9sHRQ9IrmIkEBJvKCjonTwtDYgwYghX488hrwIZ8VdUWTUC1r
         FbhaD4qpOxn6GdCFCFTzhsv7dhzd4pULgAwZ/GnJT4oiW+kE6Dax2S88/2rysSnIZFF2
         jiZQ==
X-Gm-Message-State: AAQBX9faaaQGbX3A/wntDQ2PCVbEmv3+AUqUrfMD6AOS75HqAmtz3r5+
        EA+yxoCWCn0oUlxeZE8tCvo=
X-Google-Smtp-Source: AKy350a9q/R1kZR/wtsNdjk+YVYgyupLse2OmaIObXc+WUvxrtgjOFRhX8anYTWSAjgH1zKJ33Ptyw==
X-Received: by 2002:a17:906:3988:b0:8b0:f277:5cde with SMTP id h8-20020a170906398800b008b0f2775cdemr13169532eje.32.1679939767215;
        Mon, 27 Mar 2023 10:56:07 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h23-20020a50cdd7000000b004fe924d16cfsm15056343edj.31.2023.03.27.10.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:56:06 -0700 (PDT)
Message-ID: <cdd67fd11f71210b75e48a848ade42f545cddf8f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] bpftool: Add inline annotations when
 dumping program CFGs
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
Date:   Mon, 27 Mar 2023 20:56:03 +0300
In-Reply-To: <20230327110655.58363-1-quentin@isovalent.com>
References: <20230327110655.58363-1-quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-03-27 at 12:06 +0100, Quentin Monnet wrote:
> This set contains some improvements for bpftool's "visual" program dump
> option, which produces the control flow graph in a DOT format. The main
> objective is to add support for inline annotations on such graphs, so tha=
t
> we can have the C source code for the program showing up alongside the
> instructions, when available. The last commits also make it possible to
> display the line numbers or the bare opcodes in the graph, as supported b=
y
> regular program dumps.
>=20
> v2: Replace fputc(..., stdout) with putchar(...) in dotlabel_puts().

Hi Quentin,

It looks like currently there are no test cases for bpftool prog dump.
Borrowing an idea to mix bpf program with comments parsed by awk from
prog_tests/btf_dump.c it is possible to put together something like
below (although, would be much simpler as a bash script). Is it worth
the effort or dump format is too unstable?

Thanks,
Eduard

---

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_cfg.c b/tools/t=
esting/selftests/bpf/prog_tests/bpftool_cfg.c
new file mode 100644
index 000000000000..f582a93b5ee9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_cfg.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#include "bpf/libbpf.h"
+#include "bpftool_cfg.skel.h"
+
+static int system_to_tmp(char *tmp_template, char *cmd)
+{
+	char buf[1024];
+	int fd, err;
+
+	fd =3D mkstemp(tmp_template);
+	if (!ASSERT_GE(fd, 0, "mkstemp"))
+		return fd;
+
+	snprintf(buf, sizeof(buf), "%s > %s", cmd, tmp_template);
+	err =3D system(buf);
+	if (err) {
+		PRINT_FAIL("Command %s failed: err %d\n", cmd, err);
+		remove(tmp_template);
+		return err;
+	}
+
+	return 0;
+}
+
+void test_bpftool_cfg(void)
+{
+	const char *prog_pin_path =3D "/sys/fs/bpf/bpftool_cfg_test_pin";
+	const char *bpftool =3D "./tools/build/bpftool/bpftool";
+	char bpftool_tmp[256] =3D "/tmp/bpftool_test_cfg.XXXXXX";
+	char awk_tmp[256] =3D "/tmp/bpftool_test_awk.XXXXXX";
+	struct bpftool_cfg *skel;
+	const char *test_file;
+	char cmd_buf[1024];
+	FILE *cmd;
+	int err;
+
+	skel =3D bpftool_cfg__open_and_load();
+	if (!skel) {
+		PRINT_FAIL("failed to load bpftool_cfg program: %d (%s)\n",
+			   errno, strerror(errno));
+		return;
+	}
+
+	err =3D bpf_program__pin(skel->progs.bpftool_cfg_nanosleep, prog_pin_path=
);
+	if (err) {
+		PRINT_FAIL("failed to pin bpftool_cfg program: err %d, errno =3D %d (%s)=
\n",
+			   err, errno, strerror(errno));
+		goto out;
+	}
+
+	/* When the test is run with O=3D, kselftest copies TEST_FILES
+	 * without preserving the directory structure.
+	 */
+	if (access("progs/bpftool_cfg.c", R_OK) =3D=3D 0)
+		test_file =3D "progs/bpftool_cfg.c";
+	else if (access("bpftool_cfg.c", R_OK) =3D=3D 0)
+		test_file =3D "bpftool_cfg.c";
+	else {
+		PRINT_FAIL("Can't find bpftool_cfg.c\n");
+		goto out_unpin;
+	}
+
+	cmd =3D fmemopen(cmd_buf, sizeof(cmd_buf), "w");
+	fprintf(cmd, "awk '");
+	fprintf(cmd, "    /END-BPFTOOL-CFG/   { out=3D0 } ");
+	fprintf(cmd, "    out                 { print $0 } ");
+	fprintf(cmd, "    /START-BPFTOOL-CFG/ { out=3D1 } ");
+	fprintf(cmd, "' '%s' > '%s'", test_file, awk_tmp);
+	fclose(cmd);
+	err =3D system_to_tmp(awk_tmp, cmd_buf);
+	if (!ASSERT_OK(err, "awk"))
+		goto out_unpin;
+
+	cmd =3D fmemopen(cmd_buf, sizeof(cmd_buf), "w");
+	fprintf(cmd, "%s prog dump xlated pinned %s visual", bpftool, prog_pin_pa=
th);
+	fclose(cmd);
+	err =3D system_to_tmp(bpftool_tmp, cmd_buf);
+	if (!ASSERT_OK(err, "bpftool"))
+		goto out_delete;
+
+	cmd =3D fmemopen(cmd_buf, sizeof(cmd_buf), "w");
+	fprintf(cmd, "diff -u %s %s", awk_tmp, bpftool_tmp);
+	fclose(cmd);
+	err =3D system(cmd_buf);
+	if (!ASSERT_OK(err, "diff"))
+		goto out_delete;
+
+out_delete:
+	if (awk_tmp[0])
+		remove(awk_tmp);
+	if (bpftool_tmp[0])
+		remove(bpftool_tmp);
+out_unpin:
+	bpf_program__unpin(skel->progs.bpftool_cfg_nanosleep, prog_pin_path);
+out:
+	bpftool_cfg__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpftool_cfg.c b/tools/testin=
g/selftests/bpf/progs/bpftool_cfg.c
new file mode 100644
index 000000000000..d10c4e2cecbd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpftool_cfg.c
@@ -0,0 +1,36 @@
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+/*
+START-BPFTOOL-CFG
+digraph "DOT graph for eBPF program" {
+subgraph "cluster_0" {
+	style=3D"dashed";
+	color=3D"black";
+	label=3D"func_0 ()";
+	fn_0_bb_0 [shape=3DMdiamond,style=3Dfilled,label=3D"ENTRY"];
+
+	fn_0_bb_2 [shape=3Drecord,style=3Dfilled,label=3D"{\
+; int bpftool_cfg_nanosleep(void * ctx):\l\
+; return 0;\l\
+0: (b4) w0 =3D 0\l\
+ | 1: (95) exit\l\
+}"];
+
+	fn_0_bb_1 [shape=3DMdiamond,style=3Dfilled,label=3D"EXIT"];
+
+	fn_0_bb_0:s -> fn_0_bb_2:n [style=3D"solid,bold", color=3Dblack, weight=
=3D10, constraint=3Dtrue];
+	fn_0_bb_2:s -> fn_0_bb_1:n [style=3D"solid,bold", color=3Dblack, weight=
=3D10, constraint=3Dtrue];
+	fn_0_bb_0:s -> fn_0_bb_1:n [style=3D"invis", constraint=3Dtrue];
+}
+}
+END-BPFTOOL-CFG
+*/
+
+SEC("tp/syscalls/sys_enter_getpid")
+int bpftool_cfg_nanosleep(void *ctx)
+{
+	return 0;
+}
