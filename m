Return-Path: <bpf+bounces-2408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD6272C998
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D214B2810C5
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5421D2CF;
	Mon, 12 Jun 2023 15:16:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638319511
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:16:22 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A9DE7E;
	Mon, 12 Jun 2023 08:16:20 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-62de1a3e354so11409256d6.3;
        Mon, 12 Jun 2023 08:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582979; x=1689174979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8l7b5rq3eSLprlEi3xdXeP4h4jMB/EYIkVxo2L3a3jU=;
        b=nCKBAmq1X5cFQGJE35tTaTXsbcw0BbKgWBUviilansHhDb3Ek1becaiWeg0iw3PnHV
         KDjppXU+qtRlNEfUaMt44GMbeIVQjNOcSHzPFmm1dAWXICIxLihgF6UYTE0cXvk5Ycwf
         8cCRq7Eq1YSWF1H6ELedhmpg4UNz01aw7fg3ihfi20OVf9tJUqSLr2H8EORmI0JoDUGx
         zq1B+FbL04WjhizZSWS7slUW9O+nP9PugRqO3483lLh9yWUaxClker7W1SkFXzUEe2cR
         3EdeFry6ZnHIF/I728dUH1lJuIq64p33BOvx/mdw+1Gcm0MB51Wc5XTf0Nsgdtuqja1j
         XEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582979; x=1689174979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8l7b5rq3eSLprlEi3xdXeP4h4jMB/EYIkVxo2L3a3jU=;
        b=c3nVfKisaQrOpEUe4rJ9saDJZnCvcEls4vSJYMKguPpTdViLRoZV+MymGagCYTI6WQ
         rXgZuWwYnAryv3Zn2fGARt8UeA6qIWN0NkmZ1a7EndtmEAZ0ckNl/SAWgl1/eRaXH2wB
         qWhzUBFNHDqMMn0N1vsaz+tf2KJFDBaoNb6QvX0QQw8npeCwuVgYiYvCph4CiOUdoers
         tODzOLci4TJWc6pA6+Q3TkQiHd8cJyfZLKenS2XFHamZA5Gb8ENR5Qpn6cGCY4rsoY7L
         l6l6+X+/t2uSYD4la64s7EELyog8s6M2L4smIBIRx0Lt3dRxn5waS2rLJNhQsagB0Coi
         J0bg==
X-Gm-Message-State: AC+VfDysqOnxbudPhaflqiMqbKiSD72GNLZmlho6Zk7kSZmDRgsOMsxK
	4nDWIo842nEy7nrbu8n2TPE=
X-Google-Smtp-Source: ACHHUZ7FlQpBDj5TzocpiybhF7zTRou0gS6GHMTj5lNL3PW+Oj5TUDNQ+rKGPdKiw4Hte1tOgVF8bA==
X-Received: by 2002:a05:6214:27ce:b0:5f1:6892:7437 with SMTP id ge14-20020a05621427ce00b005f168927437mr10405139qvb.26.1686582979339;
        Mon, 12 Jun 2023 08:16:19 -0700 (PDT)
Received: from vultr.guest ([108.61.23.146])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0062de0dde008sm1533953qvm.64.2023.06.12.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:16:18 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 03/10] bpftool: Show probed function in kprobe_multi link info
Date: Mon, 12 Jun 2023 15:16:01 +0000
Message-Id: <20230612151608.99661-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230612151608.99661-1-laoar.shao@gmail.com>
References: <20230612151608.99661-1-laoar.shao@gmail.com>
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

52: kprobe_multi  prog 381
        retprobe 0  func_cnt 7
        addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
              ffffffff9ec44f60        schedule_timeout_killable
              ffffffff9ec44fa0        schedule_timeout_uninterruptible
              ffffffff9ec44fe0        schedule_timeout_idle
              ffffffffc09468d0        xfs_trans_get_efd [xfs]
              ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
              ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
        pids kprobe_multi(559862)
53: kprobe_multi  prog 381
        retprobe 1  func_cnt 7
        addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
              ffffffff9ec44f60        schedule_timeout_killable
              ffffffff9ec44fa0        schedule_timeout_uninterruptible
              ffffffff9ec44fe0        schedule_timeout_idle
              ffffffffc09468d0        xfs_trans_get_efd [xfs]
              ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
              ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
        pids kprobe_multi(559862)

$ tools/bpf/bpftool/bpftool link show -j
[{"id":52,"type":"kprobe_multi","prog_id":381,"retprobe":0,"func_cnt":7,"fu=
ncs":[{"addr":18446744072078249760,"func":"schedule_timeout_interruptible",=
"module":""},{"addr":18446744072078249824,"func":"schedule_timeout_killable=
","module":""},{"addr":18446744072078249888,"func":"schedule_timeout_uninte=
rruptible","module":""},{"addr":18446744072078249952,"func":"schedule_timeo=
ut_idle","module":""},{"addr":18446744072645535952,"func":"xfs_trans_get_ef=
d","module":"[xfs]"},{"addr":18446744072645589520,"func":"xfs_trans_get_buf=
_map","module":"[xfs]"},{"addr":18446744072645604128,"func":"xfs_trans_get_=
dqtrx","module":"[xfs]"}],"pids":[{"pid":559862,"comm":"kprobe_multi"}]},{"=
id":53,"type":"kprobe_multi","prog_id":381,"retprobe":1,"func_cnt":7,"funcs=
":[{"addr":18446744072078249760,"func":"schedule_timeout_interruptible","mo=
dule":""},{"addr":18446744072078249824,"func":"schedule_timeout_killable","=
module":""},{"addr":18446744072078249888,"func":"schedule_timeout_uninterru=
ptible","module":""},{"addr":18446744072078249952,"func":"schedule_timeout_=
idle","module":""},{"addr":18446744072645535952,"func":"xfs_trans_get_efd",=
"module":"[xfs]"},{"addr":18446744072645589520,"func":"xfs_trans_get_buf_ma=
p","module":"[xfs]"},{"addr":18446744072645604128,"func":"xfs_trans_get_dqt=
rx","module":"[xfs]"}],"pids":[{"pid":559862,"comm":"kprobe_multi"}]}]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 109 +++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 2d78607..0015582 100644
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
+	jsonw_uint_field(json_wtr, "retprobe",
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
+	printf("\n\tretprobe %d  func_cnt %u  ",
+	       info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN,
+	       info->kprobe_multi.count);
+	addrs =3D (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
+	qsort((void *)addrs, info->kprobe_multi.count, sizeof(__u64), cmp_u64);
+
+	/* Load it once for all. */
+	if (!dd.sym_count)
+		kernel_syms_load(&dd);
+	for (i =3D 0; i < dd.sym_count; i++) {
+		if (dd.sym_mapping[i].address !=3D addrs[j])
+			continue;
+		if (!j)
+			printf("\n\taddrs %016lx  funcs %s",
+			       dd.sym_mapping[i].address,
+			       dd.sym_mapping[i].name);
+		else
+			printf("\n\t      %016lx        %s",
+			       dd.sym_mapping[i].address,
+			       dd.sym_mapping[i].name);
+		if (dd.sym_mapping[i].module[0] !=3D '\0')
+			printf(" %s  ", dd.sym_mapping[i].module);
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


