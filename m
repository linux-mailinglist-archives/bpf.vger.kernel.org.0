Return-Path: <bpf+bounces-3654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C08741075
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5111C203D8
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0BEC127;
	Wed, 28 Jun 2023 11:53:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37609BA32
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:53:42 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFA930D1;
	Wed, 28 Jun 2023 04:53:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2633b669f5fso504820a91.2;
        Wed, 28 Jun 2023 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953220; x=1690545220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHioNMPGGrAFDPad37M0xQlWMvq9ePwwReawsanh/z8=;
        b=J0NoJMck6fAQKNyniICz/+jNYeYLuAxDS8Nho1EV6ZsnxjYUn+M+Cx4VQu67q/7d8B
         l6j4yHcRpyBjE7flAex9WNgQIcZw/1cTAncwQnf2doF5YfRqtR9CaJBz6QDh/iCg+53h
         JmtFRAdIUhLt/0O2MVL3/GIZSJZynMDQn1IJvTK0Uyk7XHZfraNqOCl68mvDgo668gAy
         OE++bAi5fLBrs5wK/zdTiUb65rOxAJYk9MYfmPEXytmkBUrKmiuTLchVlI4LmOLkAW7/
         8aKw8P+C7xXa0ORvBv+bkEhgHSiAu026HONysdrdpvlehtNQElkj9ZVouaj79VBwODJP
         Tw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953220; x=1690545220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHioNMPGGrAFDPad37M0xQlWMvq9ePwwReawsanh/z8=;
        b=fhIsuhW+mkT/0+OoOmU4+IzSgRLUpkwjCUVCkxa53pnPSgRztkueSJcuXJPjYsAzmY
         saqjjLxA2fiEuOrx3XvBp2sv19PdnEcgFVtWiDMH0j09kfYMdvA/EU4MIrFKUT691D3Z
         zcNMGgeidvilq8TAlXV+VrXRaOVSmxFDE7NNzV5W7oBQrbM60HnhYOyCUUmh4cwZyixR
         f51uVmTNkyDwzZlFytgTn3fbWXZMB/PtxwgWRwNWgQtnDP38lK7OMUk0Z7NrnzJaKbXb
         uaLs7UNMbN6nyYat9r4zdmyLDDIfDbz2dmP7Nws0wYNkbpK7oTbVd6AwG93xskrEwoya
         7i0A==
X-Gm-Message-State: AC+VfDy201s1SdXv6A04ZnXTat31LaBLqqmqYhYosNWLhkQ+cZNA0kvI
	V12NBswobra+2r05jLTP5eU=
X-Google-Smtp-Source: ACHHUZ7PD/US0MJr0LI2QJjYxxelylDmIDIowluAo/bPh7TSulljaqjnNy04HbI5IxdR/Yp9y/hBpQ==
X-Received: by 2002:a17:90a:3d82:b0:263:41ae:8163 with SMTP id i2-20020a17090a3d8200b0026341ae8163mr1002405pjc.12.1687953220108;
        Wed, 28 Jun 2023 04:53:40 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm8000504pji.6.2023.06.28.04.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:53:39 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 03/11] bpftool: Show kprobe_multi link info
Date: Wed, 28 Jun 2023 11:53:21 +0000
Message-Id: <20230628115329.248450-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628115329.248450-1-laoar.shao@gmail.com>
References: <20230628115329.248450-1-laoar.shao@gmail.com>
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
---
 tools/bpf/bpftool/link.c | 114 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 2d786072ed0d..34fa17cd9d2a 100644
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
+	qsort((void *)addrs, info->kprobe_multi.count, sizeof(__u64), cmp_u64);
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
@@ -441,12 +533,28 @@ static int do_show_link(int fd)
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
2.39.3


