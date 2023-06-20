Return-Path: <bpf+bounces-2932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC23737199
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 18:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F9D2813D3
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A543218C08;
	Tue, 20 Jun 2023 16:30:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05C18C03
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 16:30:26 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1F8100;
	Tue, 20 Jun 2023 09:30:22 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-54fbcfe65caso3962326a12.1;
        Tue, 20 Jun 2023 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687278622; x=1689870622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gElHMt7ru6hC4YTlAvkaeRJX96aRe9JlJT1poAWmAI=;
        b=DNij9L7w88Hv9sa8c8tYmm8O1Qhi0UXS65+IN2iJxBSOSniQRhPxUBGFSMbGosQ8VN
         NzHsahy7k0Cy4WRicvUpmoEkfwZHPSiy5WjGLKpknq0LG7HE0oq7RO67riyJ7s9BD0MC
         AeCtquX2fjq45xbjy0JADiSfDorUrs8Qr5rSHYj2v3yDnNqXvVQiArbKmsr3Jg08csTa
         pyms5XRes9KUwQyzsXB2tZNaG05BQF7ITjfz4GiPr0b2+KjoQxD+RI7OScxKIoB2aHa1
         HWwnktqnS0zJLJZVe9pZZ9GMGajkmvLMXRekbB9zlczGe3lw6fxg9RUcimedJWMApHYY
         0Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278622; x=1689870622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gElHMt7ru6hC4YTlAvkaeRJX96aRe9JlJT1poAWmAI=;
        b=XlWiXJbIygrdgCequFTyOiEBK7hfqRE6BPXZ1CsY06ulFs3e0vU1kZN+sPUS66WXQf
         +x+dJHh/k96qCS76HBPafSQXKtts3JfNEKXVCT5A3/QpkZ8F9HHn2djE8IYGlw/uDcmT
         TwtgU7uNC/ATAzZuX/4J/tPvhJo6g+834De5+FKDYypAAsJjIHmIVBArTsNiUaqvMo/B
         4pnabopsoRwA2D7ijRoJuaReyEPur8xSh6tWcA/ztoqy5+23n9TwIUSPkk4ucrnX4sw1
         S9VDH0srr1U9OsJCnuFOujudLOr8E9NXdch4rrdhtQ3mtshrKlFm01bBXNew1QugO8Qx
         mCbA==
X-Gm-Message-State: AC+VfDye0NFyo0MMJvahfVw/pt+mYtanJuQyJrqEioT1RQ8snl48wMMt
	WKrRWnXXRTbd9VXqYS9S6YuBlJiNFbqhY3l7oS4=
X-Google-Smtp-Source: ACHHUZ5TZpkQbAB992bJO2WnlzBuCYfCBMrLLUAytxeVr8Pb239IMfVivcyxr8S15/j/NK9fvg4UIA==
X-Received: by 2002:a17:90b:d89:b0:25e:8501:6662 with SMTP id bg9-20020a17090b0d8900b0025e85016662mr24455888pjb.7.1687278622046;
        Tue, 20 Jun 2023 09:30:22 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b96:5400:4ff:fe7b:3b23])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b0025c1cfdb93esm1854286pjf.13.2023.06.20.09.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:21 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 bpf-next 03/11] bpftool: Show kprobe_multi link info
Date: Tue, 20 Jun 2023 16:30:00 +0000
Message-Id: <20230620163008.3718-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230620163008.3718-1-laoar.shao@gmail.com>
References: <20230620163008.3718-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Show the already expose kprobe_multi link info in bpftool. The result as
follows,

$ tools/bpf/bpftool/bpftool link show
11: kprobe_multi  prog 42
        kprobe.multi  func_cnt 7
        addr             func
        ffffffffa2c40f20 schedule_timeout_interruptible
        ffffffffa2c40f60 schedule_timeout_killable
        ffffffffa2c40fa0 schedule_timeout_uninterruptible
        ffffffffa2c40fe0 schedule_timeout_idle
        ffffffffc0fb18d0 xfs_trans_get_efd [xfs]
        ffffffffc0fbea10 xfs_trans_get_buf_map [xfs]
        ffffffffc0fc2320 xfs_trans_get_dqtrx [xfs]
        pids kprobe_multi(25725)
12: kprobe_multi  prog 42
        kretprobe.multi  func_cnt 7
        addr             func
        ffffffffa2c40f20 schedule_timeout_interruptible
        ffffffffa2c40f60 schedule_timeout_killable
        ffffffffa2c40fa0 schedule_timeout_uninterruptible
        ffffffffa2c40fe0 schedule_timeout_idle
        ffffffffc0fb18d0 xfs_trans_get_efd [xfs]
        ffffffffc0fbea10 xfs_trans_get_buf_map [xfs]
        ffffffffc0fc2320 xfs_trans_get_dqtrx [xfs]
        pids kprobe_multi(25725)

$ tools/bpf/bpftool/bpftool link show -j
[{"id":11,"type":"kprobe_multi","prog_id":42,"retprobe":false,"func_cnt":7,=
"funcs":[{"addr":18446744072145342240,"func":"schedule_timeout_interruptibl=
e","module":""},{"addr":18446744072145342304,"func":"schedule_timeout_killa=
ble","module":""},{"addr":18446744072145342368,"func":"schedule_timeout_uni=
nterruptible","module":""},{"addr":18446744072145342432,"func":"schedule_ti=
meout_idle","module":""},{"addr":18446744072652265680,"func":"xfs_trans_get=
_efd","module":"xfs"},{"addr":18446744072652319248,"func":"xfs_trans_get_bu=
f_map","module":"xfs"},{"addr":18446744072652333856,"func":"xfs_trans_get_d=
qtrx","module":"xfs"}],"pids":[{"pid":25725,"comm":"kprobe_multi"}]},{"id":=
12,"type":"kprobe_multi","prog_id":42,"retprobe":true,"func_cnt":7,"funcs":=
[{"addr":18446744072145342240,"func":"schedule_timeout_interruptible","modu=
le":""},{"addr":18446744072145342304,"func":"schedule_timeout_killable","mo=
dule":""},{"addr":18446744072145342368,"func":"schedule_timeout_uninterrupt=
ible","module":""},{"addr":18446744072145342432,"func":"schedule_timeout_id=
le","module":""},{"addr":18446744072652265680,"func":"xfs_trans_get_efd","m=
odule":"xfs"},{"addr":18446744072652319248,"func":"xfs_trans_get_buf_map","=
module":"xfs"},{"addr":18446744072652333856,"func":"xfs_trans_get_dqtrx","m=
odule":"xfs"}],"pids":[{"pid":25725,"comm":"kprobe_multi"}]}]

When kptr_restrict is 2, the result is,

$ tools/bpf/bpftool/bpftool link show
11: kprobe_multi  prog 42
        kprobe.multi  func_cnt 7
12: kprobe_multi  prog 42
        kretprobe.multi  func_cnt 7

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 109 +++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 2d78607..90b51de 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -14,8 +14,10 @@
=20
 #include "json_writer.h"
 #include "main.h"
+#include "xlated_dumper.h"
=20
 static struct hashmap *link_table;
+static struct dump_data dd =3D {};
=20
 static int link_parse_fd(int *argc, char ***argv)
 {
@@ -166,6 +168,45 @@ static int get_prog_info(int prog_id, struct bpf_prog_=
info *info)
 	return err;
 }
=20
+static int cmp_u64(const void *A, const void *B)
+{
+	const __u64 *a =3D A, *b =3D B;
+
+	return *a - *b;
+}
+
+static void
+show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	__u32 i, j =3D 0;
+	__u64 *addrs;
+
+	jsonw_bool_field(json_wtr, "retprobe",
+			 info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN);
+	jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi.count);
+	jsonw_name(json_wtr, "funcs");
+	jsonw_start_array(json_wtr);
+	addrs =3D (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
+	qsort((void *)addrs, info->kprobe_multi.count, sizeof(__u64), cmp_u64);
+
+	/* Load it once for all. */
+	if (!dd.sym_count)
+		kernel_syms_load(&dd);
+	for (i =3D 0; i < dd.sym_count; i++) {
+		if (dd.sym_mapping[i].address !=3D addrs[j])
+			continue;
+		jsonw_start_object(json_wtr);
+		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
+		jsonw_string_field(json_wtr, "func", dd.sym_mapping[i].name);
+		/* Print none if it is vmlinux */
+		jsonw_string_field(json_wtr, "module", dd.sym_mapping[i].module);
+		jsonw_end_object(json_wtr);
+		if (j++ =3D=3D info->kprobe_multi.count)
+			break;
+	}
+	jsonw_end_array(json_wtr);
+}
+
 static int show_link_close_json(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
@@ -218,6 +259,9 @@ static int show_link_close_json(int fd, struct bpf_link=
_info *info)
 		jsonw_uint_field(json_wtr, "map_id",
 				 info->struct_ops.map_id);
 		break;
+	case BPF_LINK_TYPE_KPROBE_MULTI:
+		show_kprobe_multi_json(info, json_wtr);
+		break;
 	default:
 		break;
 	}
@@ -351,6 +395,44 @@ void netfilter_dump_plain(const struct bpf_link_info *=
info)
 		printf(" flags 0x%x", info->netfilter.flags);
 }
=20
+static void show_kprobe_multi_plain(struct bpf_link_info *info)
+{
+	__u32 i, j =3D 0;
+	__u64 *addrs;
+
+	if (!info->kprobe_multi.count)
+		return;
+
+	if (info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN)
+		printf("\n\tkretprobe.multi  ");
+	else
+		printf("\n\tkprobe.multi  ");
+	printf("func_cnt %u  ", info->kprobe_multi.count);
+	addrs =3D (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
+	qsort((void *)addrs, info->kprobe_multi.count, sizeof(__u64), cmp_u64);
+
+	/* Load it once for all. */
+	if (!dd.sym_count)
+		kernel_syms_load(&dd);
+	if (!dd.sym_count)
+		return;
+
+	printf("\n\t%-16s %s", "addr", "func");
+	for (i =3D 0; i < dd.sym_count; i++) {
+		if (dd.sym_mapping[i].address !=3D addrs[j])
+			continue;
+		printf("\n\t%016lx %s",
+		       dd.sym_mapping[i].address, dd.sym_mapping[i].name);
+		if (dd.sym_mapping[i].module[0] !=3D '\0')
+			printf(" [%s]  ", dd.sym_mapping[i].module);
+		else
+			printf("  ");
+
+		if (j++ =3D=3D info->kprobe_multi.count)
+			break;
+	}
+}
+
 static int show_link_close_plain(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
@@ -396,6 +478,9 @@ static int show_link_close_plain(int fd, struct bpf_lin=
k_info *info)
 	case BPF_LINK_TYPE_NETFILTER:
 		netfilter_dump_plain(info);
 		break;
+	case BPF_LINK_TYPE_KPROBE_MULTI:
+		show_kprobe_multi_plain(info);
+		break;
 	default:
 		break;
 	}
@@ -417,7 +502,9 @@ static int do_show_link(int fd)
 {
 	struct bpf_link_info info;
 	__u32 len =3D sizeof(info);
+	__u64 *addrs =3D NULL;
 	char buf[256];
+	int count;
 	int err;
=20
 	memset(&info, 0, sizeof(info));
@@ -441,12 +528,28 @@ static int do_show_link(int fd)
 		info.iter.target_name_len =3D sizeof(buf);
 		goto again;
 	}
+	if (info.type =3D=3D BPF_LINK_TYPE_KPROBE_MULTI &&
+	    !info.kprobe_multi.addrs) {
+		count =3D info.kprobe_multi.count;
+		if (count) {
+			addrs =3D calloc(count, sizeof(__u64));
+			if (!addrs) {
+				p_err("mem alloc failed");
+				close(fd);
+				return -1;
+			}
+			info.kprobe_multi.addrs =3D (unsigned long)addrs;
+			goto again;
+		}
+	}
=20
 	if (json_output)
 		show_link_close_json(fd, &info);
 	else
 		show_link_close_plain(fd, &info);
=20
+	if (addrs)
+		free(addrs);
 	close(fd);
 	return 0;
 }
@@ -471,7 +574,8 @@ static int do_show(int argc, char **argv)
 		fd =3D link_parse_fd(&argc, &argv);
 		if (fd < 0)
 			return fd;
-		return do_show_link(fd);
+		do_show_link(fd);
+		goto out;
 	}
=20
 	if (argc)
@@ -510,6 +614,9 @@ static int do_show(int argc, char **argv)
 	if (show_pinned)
 		delete_pinned_obj_table(link_table);
=20
+out:
+	if (dd.sym_count)
+		kernel_syms_destroy(&dd);
 	return errno =3D=3D ENOENT ? 0 : -1;
 }
=20
--=20
1.8.3.1


