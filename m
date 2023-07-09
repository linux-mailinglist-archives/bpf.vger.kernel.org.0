Return-Path: <bpf+bounces-4514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E98A74C07B
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5E71C208F5
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48971C27;
	Sun,  9 Jul 2023 02:56:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844BC185C
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:56:50 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8928E45;
	Sat,  8 Jul 2023 19:56:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6687446eaccso2779823b3a.3;
        Sat, 08 Jul 2023 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871408; x=1691463408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWxrV694AlLIixWXAfmrG3HSaTkxSy5l+ke+2+sklSc=;
        b=hs6ElFthAc98uUsH7l8TZUw0D9dEzkkupZKRnMrMnJrfCz0IIDT8pNRySGPkfC9OKn
         O+SVMhpAwidnu1xrKPn8TncUhwyvMagSYQrZ+/Q8CQYrr8HHprkXFcE6hvp33oespEei
         b+LwzWl1jOkQ5UaF1Se6ER4hR7qBtUHOYsRL3CS6bsP4skVakpoPWgbUn0tCLTXSpBNv
         iLgneKXdiCwL7hSXtHtG4M9ubhgPfx7r2bUEsfZyzspdlcbDngZDj0WxqdNoSJo/v8Fg
         n+9zN8Gl9ay/yO6533v87BXPaabs1wp8cPJUI6QSP6aMXrzUXMLNO5sUbtbZNgFcYqCI
         TIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871408; x=1691463408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWxrV694AlLIixWXAfmrG3HSaTkxSy5l+ke+2+sklSc=;
        b=TnED6UOmPAxJCHxwYS4khI0B8rj4S5Rd91jjyeStVsdpt8oSgXPQOA0aCqDAGJMz9O
         tVStKmcTXN/XKRpuh7/iK/m3qtztN2NhqFogRQwTYviNSqSs2Lkpcu+gkNAqSdVuZebO
         784DnTjJ6lb3MMphuvaFjP+u71IzbFib2klSJUyNVbk0oueWCgaCI5KY9aT4cH72NTBH
         2D/1GvIPCQrqXUgOAuvHQ0C4VRcdpsnh9Ke2CWtEDVyRlUwcr2NwLjkqzMJLIycvtdi+
         Vc6wCfaGCcxmIOYLT7TFvifc5oCobAycTVLLNkLSHT1Fz+6YdolLUvbsjuW3jzPJUwMP
         48rw==
X-Gm-Message-State: ABy/qLZ2JUK99edDMSvAIMfNFP9i+3VdHqWGev1xpE9g2937/rZQptzw
	7PRtHAbgLUxFfuh4E4C+sJE=
X-Google-Smtp-Source: APBJJlHoZpT3NgWZh1RUKWDcJcD2ZT5M74+IIXOKRN01WugpwAHvGg4Y7Z5PUmS88BbL9wsTr9YFyw==
X-Received: by 2002:a05:6a21:6da6:b0:12e:3394:e2bb with SMTP id wl38-20020a056a216da600b0012e3394e2bbmr11678841pzb.43.1688871408348;
        Sat, 08 Jul 2023 19:56:48 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00682ad247e5fsm5043421pfn.179.2023.07.08.19.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:56:47 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 03/10] bpftool: Show kprobe_multi link info
Date: Sun,  9 Jul 2023 02:56:23 +0000
Message-Id: <20230709025630.3735-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230709025630.3735-1-laoar.shao@gmail.com>
References: <20230709025630.3735-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Show the already expose kprobe_multi link info in bpftool. The result as
follows,

$ tools/bpf/bpftool/bpftool link show
91: kprobe_multi  prog 244
        kprobe.multi  func_cnt 7
        addr             func [module]
        ffffffff98c44f20 schedule_timeout_interruptible
        ffffffff98c44f60 schedule_timeout_killable
        ffffffff98c44fa0 schedule_timeout_uninterruptible
        ffffffff98c44fe0 schedule_timeout_idle
        ffffffffc075b8d0 xfs_trans_get_efd [xfs]
        ffffffffc0768a10 xfs_trans_get_buf_map [xfs]
        ffffffffc076c320 xfs_trans_get_dqtrx [xfs]
        pids kprobe_multi(188367)
92: kprobe_multi  prog 244
        kretprobe.multi  func_cnt 7
        addr             func [module]
        ffffffff98c44f20 schedule_timeout_interruptible
        ffffffff98c44f60 schedule_timeout_killable
        ffffffff98c44fa0 schedule_timeout_uninterruptible
        ffffffff98c44fe0 schedule_timeout_idle
        ffffffffc075b8d0 xfs_trans_get_efd [xfs]
        ffffffffc0768a10 xfs_trans_get_buf_map [xfs]
        ffffffffc076c320 xfs_trans_get_dqtrx [xfs]
        pids kprobe_multi(188367)

$ tools/bpf/bpftool/bpftool link show -j
[{"id":91,"type":"kprobe_multi","prog_id":244,"retprobe":false,"func_cnt":7=
,"funcs":[{"addr":18446744071977586464,"func":"schedule_timeout_interruptib=
le","module":null},{"addr":18446744071977586528,"func":"schedule_timeout_ki=
llable","module":null},{"addr":18446744071977586592,"func":"schedule_timeou=
t_uninterruptible","module":null},{"addr":18446744071977586656,"func":"sche=
dule_timeout_idle","module":null},{"addr":18446744072643524816,"func":"xfs_=
trans_get_efd","module":"xfs"},{"addr":18446744072643578384,"func":"xfs_tra=
ns_get_buf_map","module":"xfs"},{"addr":18446744072643592992,"func":"xfs_tr=
ans_get_dqtrx","module":"xfs"}],"pids":[{"pid":188367,"comm":"kprobe_multi"=
}]},{"id":92,"type":"kprobe_multi","prog_id":244,"retprobe":true,"func_cnt"=
:7,"funcs":[{"addr":18446744071977586464,"func":"schedule_timeout_interrupt=
ible","module":null},{"addr":18446744071977586528,"func":"schedule_timeout_=
killable","module":null},{"addr":18446744071977586592,"func":"schedule_time=
out_uninterruptible","module":null},{"addr":18446744071977586656,"func":"sc=
hedule_timeout_idle","module":null},{"addr":18446744072643524816,"func":"xf=
s_trans_get_efd","module":"xfs"},{"addr":18446744072643578384,"func":"xfs_t=
rans_get_buf_map","module":"xfs"},{"addr":18446744072643592992,"func":"xfs_=
trans_get_dqtrx","module":"xfs"}],"pids":[{"pid":188367,"comm":"kprobe_mult=
i"}]}]

When kptr_restrict is 2, the result is,

$ tools/bpf/bpftool/bpftool link show
91: kprobe_multi  prog 244
        kprobe.multi  func_cnt 7
92: kprobe_multi  prog 244
        kretprobe.multi  func_cnt 7

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/link.c | 118 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 2d786072ed0d..a4f5a436777f 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -14,8 +14,10 @@
=20
 #include "json_writer.h"
 #include "main.h"
+#include "xlated_dumper.h"
=20
 static struct hashmap *link_table;
+static struct dump_data dd;
=20
 static int link_parse_fd(int *argc, char ***argv)
 {
@@ -166,6 +168,50 @@ static int get_prog_info(int prog_id, struct bpf_prog_=
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
+	addrs =3D u64_to_ptr(info->kprobe_multi.addrs);
+	qsort(addrs, info->kprobe_multi.count, sizeof(addrs[0]), cmp_u64);
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
+		/* Print null if it is vmlinux */
+		if (dd.sym_mapping[i].module[0] =3D=3D '\0') {
+			jsonw_name(json_wtr, "module");
+			jsonw_null(json_wtr);
+		} else {
+			jsonw_string_field(json_wtr, "module", dd.sym_mapping[i].module);
+		}
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
@@ -218,6 +264,9 @@ static int show_link_close_json(int fd, struct bpf_link=
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
@@ -351,6 +400,44 @@ void netfilter_dump_plain(const struct bpf_link_info *=
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
+	qsort(addrs, info->kprobe_multi.count, sizeof(__u64), cmp_u64);
+
+	/* Load it once for all. */
+	if (!dd.sym_count)
+		kernel_syms_load(&dd);
+	if (!dd.sym_count)
+		return;
+
+	printf("\n\t%-16s %s", "addr", "func [module]");
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
@@ -396,6 +483,9 @@ static int show_link_close_plain(int fd, struct bpf_lin=
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
@@ -417,7 +507,9 @@ static int do_show_link(int fd)
 {
 	struct bpf_link_info info;
 	__u32 len =3D sizeof(info);
+	__u64 *addrs =3D NULL;
 	char buf[256];
+	int count;
 	int err;
=20
 	memset(&info, 0, sizeof(info));
@@ -431,22 +523,38 @@ static int do_show_link(int fd)
 	}
 	if (info.type =3D=3D BPF_LINK_TYPE_RAW_TRACEPOINT &&
 	    !info.raw_tracepoint.tp_name) {
-		info.raw_tracepoint.tp_name =3D (unsigned long)&buf;
+		info.raw_tracepoint.tp_name =3D ptr_to_u64(&buf);
 		info.raw_tracepoint.tp_name_len =3D sizeof(buf);
 		goto again;
 	}
 	if (info.type =3D=3D BPF_LINK_TYPE_ITER &&
 	    !info.iter.target_name) {
-		info.iter.target_name =3D (unsigned long)&buf;
+		info.iter.target_name =3D ptr_to_u64(&buf);
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
+				return -ENOMEM;
+			}
+			info.kprobe_multi.addrs =3D ptr_to_u64(addrs);
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
@@ -471,7 +579,8 @@ static int do_show(int argc, char **argv)
 		fd =3D link_parse_fd(&argc, &argv);
 		if (fd < 0)
 			return fd;
-		return do_show_link(fd);
+		do_show_link(fd);
+		goto out;
 	}
=20
 	if (argc)
@@ -510,6 +619,9 @@ static int do_show(int argc, char **argv)
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
2.30.1 (Apple Git-130)


