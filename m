Return-Path: <bpf+bounces-3275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F19173B9C4
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25C3281BBE
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64920C2FF;
	Fri, 23 Jun 2023 14:16:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222419441
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 14:16:36 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58032135;
	Fri, 23 Jun 2023 07:16:33 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1ad10ad65f1so449397fac.1;
        Fri, 23 Jun 2023 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687529793; x=1690121793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJ6T5kwycyurskhmS9zj3bwZSicgtrlBOojL4fycfgc=;
        b=k/4ZxUlrglsqz73krpHvkxhCK5A/rz4XF1t9/Oqzh5EGBij/ZMkUwnN+N4nrIwydSu
         3a9bh29R4glmmQzCIQMi29Pu70RHnSbr37sWyN/OCCq3RLnSkKo4QZOte0LQVP//fvX3
         OSojQQcSFx3ZvOFbYEMnIzUL8Ofbsq1/FS6rk9W+6skYcyLtzwvyyofiQgkuB9TOeAjC
         RRvjIe3JFq5nvpHJvF2iE0MbrsSZ1SaKm1AVd39OMlX1s1DAh2Jde101vhQB92eSz+u7
         XuLffyd1/quAG23DjXD6CLI3pY51ZCAHhsJ88hTu3gqT5+Yg52iTj7LjWHlVRhreDqYD
         8B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529793; x=1690121793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJ6T5kwycyurskhmS9zj3bwZSicgtrlBOojL4fycfgc=;
        b=LWruusy64zC7wIEN3SSFmEbQG+vjImcr7K5qkM703Ti3rfel+3BPmqwYhv1Mtkc04k
         qYSYu8EtNUo6SPZCOKVYznVCBGjkiylsJmJUb9f8+U99GUj6n7vdi3UAtM7oGRqStDJY
         baJxQIvBca0klxmyG47uq/0lduuqkcQQ/oINPs7+3kbBlhPRC1OBNkoUiUvymvGVT+EF
         LJe49HYc3f89rNDbcP1S0X00N6lvysKHFl+RO6XZNs62l4O1lHEClH1u2Gp6Em+sBa+M
         cFWiQrxEr5V2O1RbMHI1jahb3ntG9U+dvJhU7qHkZkq4YaEWCpsCVZcV78GypNtTB4J6
         13Ww==
X-Gm-Message-State: AC+VfDzJ5oI0n9TZb9IwPH0qJ/WaQIvozWKNZszI2tojHI8ULyf+zFx8
	bSbMCdV1IEHJE+nC68atk+0=
X-Google-Smtp-Source: ACHHUZ5GJ+VVnmgFB9yXlUrABi2709l51cNIcBp9ZaCrWwJil7lcvcKzpN7RJi9ziYY+QmwRvNrDYA==
X-Received: by 2002:a05:6870:9885:b0:19a:695:15a5 with SMTP id eg5-20020a056870988500b0019a069515a5mr13606405oab.25.1687529793063;
        Fri, 23 Jun 2023 07:16:33 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1058:5400:4ff:fe7c:972])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005533c53f550sm6505942pgj.45.2023.06.23.07.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:16:32 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 11/11] bpftool: Show perf link info
Date: Fri, 23 Jun 2023 14:15:46 +0000
Message-Id: <20230623141546.3751-12-laoar.shao@gmail.com>
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

Enhance bpftool to display comprehensive information about exposed
perf_event links, covering uprobe, kprobe, tracepoint, and generic perf
event. The resulting output will include the following details:

$ tools/bpf/bpftool/bpftool link show
4: perf_event  prog 23
        uprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
        bpf_cookie 0
        pids uprobe(27503)
5: perf_event  prog 24
        uretprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
        bpf_cookie 0
        pids uprobe(27503)
6: perf_event  prog 31
        kprobe ffffffffa90a9660 kernel_clone
        bpf_cookie 0
        pids kprobe(27777)
7: perf_event  prog 30
        kretprobe ffffffffa90a9660 kernel_clone
        bpf_cookie 0
        pids kprobe(27777)
8: perf_event  prog 37
        tracepoint sched_switch
        bpf_cookie 0
        pids tracepoint(28036)
9: perf_event  prog 43
        event software:cpu-clock
        bpf_cookie 0
        pids perf_event(28261)
10: perf_event  prog 43
        event hw-cache:LLC-load-misses
        bpf_cookie 0
        pids perf_event(28261)
11: perf_event  prog 43
        event hardware:cpu-cycles
        bpf_cookie 0
        pids perf_event(28261)

$ tools/bpf/bpftool/bpftool link show -j
[{"id":4,"type":"perf_event","prog_id":23,"retprobe":false,"file":"/home/de=
v/waken/bpf/uprobe/a.out","offset":4920,"bpf_cookie":0,"pids":[{"pid":27503=
,"comm":"uprobe"}]},{"id":5,"type":"perf_event","prog_id":24,"retprobe":tru=
e,"file":"/home/dev/waken/bpf/uprobe/a.out","offset":4920,"bpf_cookie":0,"p=
ids":[{"pid":27503,"comm":"uprobe"}]},{"id":6,"type":"perf_event","prog_id"=
:31,"retprobe":false,"addr":18446744072250627680,"func":"kernel_clone","off=
set":0,"bpf_cookie":0,"pids":[{"pid":27777,"comm":"kprobe"}]},{"id":7,"type=
":"perf_event","prog_id":30,"retprobe":true,"addr":18446744072250627680,"fu=
nc":"kernel_clone","offset":0,"bpf_cookie":0,"pids":[{"pid":27777,"comm":"k=
probe"}]},{"id":8,"type":"perf_event","prog_id":37,"tracepoint":"sched_swit=
ch","bpf_cookie":0,"pids":[{"pid":28036,"comm":"tracepoint"}]},{"id":9,"typ=
e":"perf_event","prog_id":43,"event_type":"software","event_config":"cpu-cl=
ock","bpf_cookie":0,"pids":[{"pid":28261,"comm":"perf_event"}]},{"id":10,"t=
ype":"perf_event","prog_id":43,"event_type":"hw-cache","event_config":"LLC-=
load-misses","bpf_cookie":0,"pids":[{"pid":28261,"comm":"perf_event"}]},{"i=
d":11,"type":"perf_event","prog_id":43,"event_type":"hardware","event_confi=
g":"cpu-cycles","bpf_cookie":0,"pids":[{"pid":28261,"comm":"perf_event"}]}]

For generic perf events, the displayed information in bpftool is limited to
the type and configuration, while other attributes such as sample_period,
sample_freq, etc., are not included.

The kernel function address won't be exposed if it is not permitted by
kptr_restrict. The result as follows when kptr_restrict is 2.

$ tools/bpf/bpftool/bpftool link show
4: perf_event  prog 23
        uprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
5: perf_event  prog 24
        uretprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
6: perf_event  prog 31
        kprobe kernel_clone
7: perf_event  prog 30
        kretprobe kernel_clone
8: perf_event  prog 37
        tracepoint sched_switch
9: perf_event  prog 43
        event software:cpu-clock
10: perf_event  prog 43
        event hw-cache:LLC-load-misses
11: perf_event  prog 43
        event hardware:cpu-cycles

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 237 +++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 236 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index e5aeee3..31bee95 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -17,6 +17,8 @@
 #include "main.h"
 #include "xlated_dumper.h"
=20
+#define PERF_HW_CACHE_LEN 128
+
 static struct hashmap *link_table;
 static struct dump_data dd =3D {};
=20
@@ -274,6 +276,110 @@ static int cmp_u64(const void *A, const void *B)
 	jsonw_end_array(json_wtr);
 }
=20
+static void
+show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	jsonw_bool_field(wtr, "retprobe", info->perf_event.kprobe.flags & 0x1);
+	jsonw_uint_field(wtr, "addr", info->perf_event.kprobe.addr);
+	jsonw_string_field(wtr, "func",
+			   u64_to_ptr(info->perf_event.kprobe.func_name));
+	jsonw_uint_field(wtr, "offset", info->perf_event.kprobe.offset);
+}
+
+static void
+show_perf_event_uprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	jsonw_bool_field(wtr, "retprobe", info->perf_event.uprobe.flags & 0x1);
+	jsonw_string_field(wtr, "file",
+			   u64_to_ptr(info->perf_event.uprobe.file_name));
+	jsonw_uint_field(wtr, "offset", info->perf_event.uprobe.offset);
+}
+
+static void
+show_perf_event_tracepoint_json(struct bpf_link_info *info, json_writer_t =
*wtr)
+{
+	jsonw_string_field(wtr, "tracepoint",
+			   u64_to_ptr(info->perf_event.tracepoint.tp_name));
+}
+
+static char *perf_config_hw_cache_str(__u64 config)
+{
+	const char *hw_cache, *result, *op;
+	char *str =3D malloc(PERF_HW_CACHE_LEN);
+
+	if (!str) {
+		p_err("mem alloc failed");
+		return NULL;
+	}
+
+	hw_cache =3D perf_event_name(evsel__hw_cache, config & 0xff);
+	if (hw_cache)
+		snprintf(str, PERF_HW_CACHE_LEN, "%s-", hw_cache);
+	else
+		snprintf(str, PERF_HW_CACHE_LEN, "%lld-", config & 0xff);
+
+	op =3D perf_event_name(evsel__hw_cache_op, (config >> 8) & 0xff);
+	if (op)
+		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
+			 "%s-", op);
+	else
+		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
+			 "%lld-", (config >> 8) & 0xff);
+
+	result =3D perf_event_name(evsel__hw_cache_result, config >> 16);
+	if (result)
+		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
+			 "%s", result);
+	else
+		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
+			 "%lld", config >> 16);
+	return str;
+}
+
+static const char *perf_config_str(__u32 type, __u64 config)
+{
+	const char *perf_config;
+
+	switch (type) {
+	case PERF_TYPE_HARDWARE:
+		perf_config =3D perf_event_name(event_symbols_hw, config);
+		break;
+	case PERF_TYPE_SOFTWARE:
+		perf_config =3D perf_event_name(event_symbols_sw, config);
+		break;
+	case PERF_TYPE_HW_CACHE:
+		perf_config =3D perf_config_hw_cache_str(config);
+		break;
+	default:
+		perf_config =3D NULL;
+		break;
+	}
+	return perf_config;
+}
+
+static void
+show_perf_event_event_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	__u64 config =3D info->perf_event.event.config;
+	__u32 type =3D info->perf_event.event.type;
+	const char *perf_type, *perf_config;
+
+	perf_type =3D perf_event_name(perf_type_name, type);
+	if (perf_type)
+		jsonw_string_field(wtr, "event_type", perf_type);
+	else
+		jsonw_uint_field(wtr, "event_type", type);
+
+	perf_config =3D perf_config_str(type, config);
+	if (perf_config)
+		jsonw_string_field(wtr, "event_config", perf_config);
+	else
+		jsonw_uint_field(wtr, "event_config", config);
+
+	if (type =3D=3D PERF_TYPE_HW_CACHE && perf_config)
+		free((void *)perf_config);
+}
+
 static int show_link_close_json(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
@@ -329,6 +435,24 @@ static int show_link_close_json(int fd, struct bpf_lin=
k_info *info)
 	case BPF_LINK_TYPE_KPROBE_MULTI:
 		show_kprobe_multi_json(info, json_wtr);
 		break;
+	case BPF_LINK_TYPE_PERF_EVENT:
+		switch (info->perf_event.type) {
+		case BPF_PERF_EVENT_EVENT:
+			show_perf_event_event_json(info, json_wtr);
+			break;
+		case BPF_PERF_EVENT_TRACEPOINT:
+			show_perf_event_tracepoint_json(info, json_wtr);
+			break;
+		case BPF_PERF_EVENT_KPROBE:
+			show_perf_event_kprobe_json(info, json_wtr);
+			break;
+		case BPF_PERF_EVENT_UPROBE:
+			show_perf_event_uprobe_json(info, json_wtr);
+			break;
+		default:
+			break;
+		}
+		break;
 	default:
 		break;
 	}
@@ -500,6 +624,75 @@ static void show_kprobe_multi_plain(struct bpf_link_in=
fo *info)
 	}
 }
=20
+static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
+{
+	const char *buf;
+
+	buf =3D (const char *)u64_to_ptr(info->perf_event.kprobe.func_name);
+	if (buf[0] =3D=3D '\0' && !info->perf_event.kprobe.addr)
+		return;
+
+	if (info->perf_event.kprobe.flags & 0x1)
+		printf("\n\tkretprobe ");
+	else
+		printf("\n\tkprobe ");
+	if (info->perf_event.kprobe.addr)
+		printf("%llx ", info->perf_event.kprobe.addr);
+	printf("%s", buf);
+	if (info->perf_event.kprobe.offset)
+		printf("+%#x", info->perf_event.kprobe.offset);
+	printf("  ");
+}
+
+static void show_perf_event_uprobe_plain(struct bpf_link_info *info)
+{
+	const char *buf;
+
+	buf =3D (const char *)u64_to_ptr(info->perf_event.uprobe.file_name);
+	if (buf[0] =3D=3D '\0')
+		return;
+
+	if (info->perf_event.uprobe.flags & 0x1)
+		printf("\n\turetprobe ");
+	else
+		printf("\n\tuprobe ");
+	printf("%s+%#x  ", buf, info->perf_event.uprobe.offset);
+}
+
+static void show_perf_event_tracepoint_plain(struct bpf_link_info *info)
+{
+	const char *buf;
+
+	buf =3D (const char *)u64_to_ptr(info->perf_event.tracepoint.tp_name);
+	if (buf[0] =3D=3D '\0')
+		return;
+
+	printf("\n\ttracepoint %s  ", buf);
+}
+
+static void show_perf_event_event_plain(struct bpf_link_info *info)
+{
+	__u64 config =3D info->perf_event.event.config;
+	__u32 type =3D info->perf_event.event.type;
+	const char *perf_type, *perf_config;
+
+	printf("\n\tevent ");
+	perf_type =3D perf_event_name(perf_type_name, type);
+	if (perf_type)
+		printf("%s:", perf_type);
+	else
+		printf("%u :", type);
+
+	perf_config =3D perf_config_str(type, config);
+	if (perf_config)
+		printf("%s  ", perf_config);
+	else
+		printf("%llu  ", config);
+
+	if (type =3D=3D PERF_TYPE_HW_CACHE && perf_config)
+		free((void *)perf_config);
+}
+
 static int show_link_close_plain(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
@@ -548,6 +741,24 @@ static int show_link_close_plain(int fd, struct bpf_li=
nk_info *info)
 	case BPF_LINK_TYPE_KPROBE_MULTI:
 		show_kprobe_multi_plain(info);
 		break;
+	case BPF_LINK_TYPE_PERF_EVENT:
+		switch (info->perf_event.type) {
+		case BPF_PERF_EVENT_EVENT:
+			show_perf_event_event_plain(info);
+			break;
+		case BPF_PERF_EVENT_TRACEPOINT:
+			show_perf_event_tracepoint_plain(info);
+			break;
+		case BPF_PERF_EVENT_KPROBE:
+			show_perf_event_kprobe_plain(info);
+			break;
+		case BPF_PERF_EVENT_UPROBE:
+			show_perf_event_uprobe_plain(info);
+			break;
+		default:
+			break;
+		}
+		break;
 	default:
 		break;
 	}
@@ -570,11 +781,12 @@ static int do_show_link(int fd)
 	struct bpf_link_info info;
 	__u32 len =3D sizeof(info);
 	__u64 *addrs =3D NULL;
-	char buf[256];
+	char buf[PATH_MAX];
 	int count;
 	int err;
=20
 	memset(&info, 0, sizeof(info));
+	buf[0] =3D '\0';
 again:
 	err =3D bpf_link_get_info_by_fd(fd, &info, &len);
 	if (err) {
@@ -609,7 +821,30 @@ static int do_show_link(int fd)
 			goto again;
 		}
 	}
+	if (info.type =3D=3D BPF_LINK_TYPE_PERF_EVENT) {
+		if (info.perf_event.type =3D=3D BPF_PERF_EVENT_EVENT)
+			goto out;
+		if (info.perf_event.type =3D=3D BPF_PERF_EVENT_TRACEPOINT &&
+		    !info.perf_event.tracepoint.tp_name) {
+			info.perf_event.tracepoint.tp_name =3D (unsigned long)&buf;
+			info.perf_event.tracepoint.name_len =3D sizeof(buf);
+			goto again;
+		}
+		if (info.perf_event.type =3D=3D BPF_PERF_EVENT_KPROBE &&
+		    !info.perf_event.kprobe.func_name) {
+			info.perf_event.kprobe.func_name =3D (unsigned long)&buf;
+			info.perf_event.kprobe.name_len =3D sizeof(buf);
+			goto again;
+		}
+		if (info.perf_event.type =3D=3D BPF_PERF_EVENT_UPROBE &&
+		    !info.perf_event.uprobe.file_name) {
+			info.perf_event.uprobe.file_name =3D (unsigned long)&buf;
+			info.perf_event.uprobe.name_len =3D sizeof(buf);
+			goto again;
+		}
+	}
=20
+out:
 	if (json_output)
 		show_link_close_json(fd, &info);
 	else
--=20
1.8.3.1


