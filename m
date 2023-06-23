Return-Path: <bpf+bounces-3267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F52773B9B9
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A39280E30
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628E7AD3F;
	Fri, 23 Jun 2023 14:16:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB54AD3B
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 14:16:23 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475731FE3;
	Fri, 23 Jun 2023 07:16:21 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b720fe3431so620703a34.3;
        Fri, 23 Jun 2023 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687529780; x=1690121780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x89rCGzIlm3iq2VodxuXVFQMkLYGEL2HattOp/c5i4Y=;
        b=X36zRlsPLIZqSY9xMSkGTq/s+H7v5WlTi0Yd2b/RraDtiiz0Gkn7lu86yAhWhNeJlC
         fFhRUW2G8ao4U4+NOvxSycaZ0PVCfFMJuAbz2AdFt9+EOKmTZ5dGhnIa6Pz+iEUFqiHM
         XoyRVicQ7nvJD7mGPOaHyt9rMHaD0BTelvFpNEFsvONlHTo54nGN3cuoaxFmQ3NVWpxu
         5hS71BIH4QdCH2Kmcc7uV6+1/WoechSXBbImRgfGaa5zh9RZz4zJj4mjYdF2Xq3DNIG6
         vkLy58V1SIwwUSuK0EOvRfuC+TnmDyuUvtgC/q4SlUyZ62f6xAJGkWa+8kNFuKMy9XOA
         wfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529780; x=1690121780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x89rCGzIlm3iq2VodxuXVFQMkLYGEL2HattOp/c5i4Y=;
        b=iYmKdKpXtWy0tvTuLW30edJE7OCeYnUeMJCs9z+vQSQxbAtF1tCSdm5ikHviqEaRB2
         2cVVvd5JwDz8+C44ZkK4dAS7WDV7143EbseIne/FZvMiuWcyRFxEM1nXsxH3GZvzFcBh
         hjonJOzBLVk+T8E3EFHKL2BqjCF+0l0mOF19T/kilAdHCeid/0F06XWk50i3RNROjgPE
         D1oZrrR43s+6QHZFrLW92TdsB1MuqxyQ0YgEiMd9zPt/I3eoTBvWhLi0qPlncqslGrag
         sAFchSEqY1y9ZUgeMfpuJyYqpUS05nvKMAtOGSkGoAEtP+XQrsaYooAssPRJIYXGFP7p
         XktQ==
X-Gm-Message-State: AC+VfDyvOwF6C//i+Murqg8TFF6c8+toA4XjlJ69wpHNS+C2lp2Pre9K
	4p7qI/7tMeO6DL5y30P0IQ0=
X-Google-Smtp-Source: ACHHUZ54zTdupKNg/2XT9HU+SXhAIaJsk3+jnYSbwkYSEExJvJm5XZ9avCTE6uKiKVtGO06wcaFOug==
X-Received: by 2002:a05:6830:1182:b0:6b5:8be9:3b8d with SMTP id u2-20020a056830118200b006b58be93b8dmr13146854otq.17.1687529780457;
        Fri, 23 Jun 2023 07:16:20 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1058:5400:4ff:fe7c:972])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005533c53f550sm6505942pgj.45.2023.06.23.07.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:16:19 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 03/11] bpftool: Show kprobe_multi link info
Date: Fri, 23 Jun 2023 14:15:38 +0000
Message-Id: <20230623141546.3751-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230623141546.3751-1-laoar.shao@gmail.com>
References: <20230623141546.3751-1-laoar.shao@gmail.com>
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
4: kprobe_multi  prog 22
        kprobe.multi  func_cnt 7
        addr             func [module]
        ffffffffbbc44f20 schedule_timeout_interruptible
        ffffffffbbc44f60 schedule_timeout_killable
        ffffffffbbc44fa0 schedule_timeout_uninterruptible
        ffffffffbbc44fe0 schedule_timeout_idle
        ffffffffc08028d0 xfs_trans_get_efd [xfs]
        ffffffffc080fa10 xfs_trans_get_buf_map [xfs]
        ffffffffc0813320 xfs_trans_get_dqtrx [xfs]
        pids kprobe_multi(1434978)
5: kprobe_multi  prog 22
        kretprobe.multi  func_cnt 7
        addr             func [module]
        ffffffffbbc44f20 schedule_timeout_interruptible
        ffffffffbbc44f60 schedule_timeout_killable
        ffffffffbbc44fa0 schedule_timeout_uninterruptible
        ffffffffbbc44fe0 schedule_timeout_idle
        ffffffffc08028d0 xfs_trans_get_efd [xfs]
        ffffffffc080fa10 xfs_trans_get_buf_map [xfs]
        ffffffffc0813320 xfs_trans_get_dqtrx [xfs]
        pids kprobe_multi(1434978)

$ tools/bpf/bpftool/bpftool link show -j
[{"id":4,"type":"kprobe_multi","prog_id":22,"retprobe":false,"func_cnt":7,"=
funcs":[{"addr":18446744072564789024,"func":"schedule_timeout_interruptible=
","module":""},{"addr":18446744072564789088,"func":"schedule_timeout_killab=
le","module":""},{"addr":18446744072564789152,"func":"schedule_timeout_unin=
terruptible","module":""},{"addr":18446744072564789216,"func":"schedule_tim=
eout_idle","module":""},{"addr":18446744072644208848,"func":"xfs_trans_get_=
efd","module":"xfs"},{"addr":18446744072644262416,"func":"xfs_trans_get_buf=
_map","module":"xfs"},{"addr":18446744072644277024,"func":"xfs_trans_get_dq=
trx","module":"xfs"}],"pids":[{"pid":1434978,"comm":"kprobe_multi"}]},{"id"=
:5,"type":"kprobe_multi","prog_id":22,"retprobe":true,"func_cnt":7,"funcs":=
[{"addr":18446744072564789024,"func":"schedule_timeout_interruptible","modu=
le":""},{"addr":18446744072564789088,"func":"schedule_timeout_killable","mo=
dule":""},{"addr":18446744072564789152,"func":"schedule_timeout_uninterrupt=
ible","module":""},{"addr":18446744072564789216,"func":"schedule_timeout_id=
le","module":""},{"addr":18446744072644208848,"func":"xfs_trans_get_efd","m=
odule":"xfs"},{"addr":18446744072644262416,"func":"xfs_trans_get_buf_map","=
module":"xfs"},{"addr":18446744072644277024,"func":"xfs_trans_get_dqtrx","m=
odule":"xfs"}],"pids":[{"pid":1434978,"comm":"kprobe_multi"}]}]

When kptr_restrict is 2, the result is,

$ tools/bpf/bpftool/bpftool link show
4: kprobe_multi  prog 22
        kprobe.multi  func_cnt 7
5: kprobe_multi  prog 22
        kretprobe.multi  func_cnt 7

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 109 +++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 2d78607..8461e6d 100644
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


