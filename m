Return-Path: <bpf+bounces-4521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB63874C082
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C672811F4
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B67C258D;
	Sun,  9 Jul 2023 02:57:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F035257F
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:57:00 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B736E45;
	Sat,  8 Jul 2023 19:56:58 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e3b15370so1861871b3a.0;
        Sat, 08 Jul 2023 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871418; x=1691463418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDiTcoxEuP3tsWikt6nyrGdnJR4rSZmciRiyjiYHmkc=;
        b=dVhgmO/wyVo0UW9iLsIpk7os8t2Mxx8mDCeVeev5ua1ViO5Kd13CrI/cXIQ0WGb+Hc
         kU6HvszpNkiuAlnEZfO2pJj46RqcFAEILaltNbvDkFpE7/vSs3ariOCFecoMeM8A51zo
         i2OM1+eGAYHRxk2I+EtVKtC3qT8E8U/+U9FR4ojHbInjU63lQlPuMu3xliNMUq9IrV9y
         LG4ZmgSF8cdkicv9NBThZ2TE4ExQpRsyrNQFo2eyizrqlCopaDaI3yLMI3+d8QUUcK/U
         VoA3btGCDmqUDCSbS7edZDEN7m3786clURtJgBQE1uMY2YMdPSziyb0ezkz9vZZJncGh
         yXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871418; x=1691463418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDiTcoxEuP3tsWikt6nyrGdnJR4rSZmciRiyjiYHmkc=;
        b=E9jXOjUBUzpUmuk8wP24s6TD5Gk4BVvX4ckMTUwGcr2/fbcp+ENjd9N7l6eRpfA+ib
         1RwpX3q/E2pH1G6jaE1ehjw3OvQwx5oQI1rqObylfrBEz2lHEbnibKEWVVvj6/4QmF8+
         vC+C9duqGeLL7lVk9e3nKNwRUsaVLG77jqgVcd3iMmm8PmbcTBvuHC+Y8HsMsPyfo0J9
         8GLWXPG5dvqIE78+9DCYdPErn2YH4zH2iAOegktISKgI6aop0BXOMPATY4aGOoFxny4M
         sHtT3srnr4iWd/dQ+aRIkOJKg+uAJkHsD8aanU2+Vrp0vu5JEHshz3lZ31xJcgyAgrjf
         6Ymw==
X-Gm-Message-State: ABy/qLZmQEWS/K5pzmHKk5y3VlMKI+BKOIju9yVUOT8RbkS2BXL/RY9L
	ml3o3zLcWrA/ViGwiPpDDIM=
X-Google-Smtp-Source: APBJJlFZkAQkvEyRvvlXuk3dwRSmwTbA0lpv8rkxrgKF2/9xCaVVYj/xOQtkdwto9AkqJYhx5pKXhg==
X-Received: by 2002:a05:6a20:7f99:b0:131:39cc:4c21 with SMTP id d25-20020a056a207f9900b0013139cc4c21mr2371027pzj.56.1688871418075;
        Sat, 08 Jul 2023 19:56:58 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00682ad247e5fsm5043421pfn.179.2023.07.08.19.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:56:57 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 10/10] bpftool: Show perf link info
Date: Sun,  9 Jul 2023 02:56:30 +0000
Message-Id: <20230709025630.3735-11-laoar.shao@gmail.com>
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

Enhance bpftool to display comprehensive information about exposed
perf_event links, covering uprobe, kprobe, tracepoint, and generic perf
event. The resulting output will include the following details:

$ tools/bpf/bpftool/bpftool link show
3: perf_event  prog 14
        event software:cpu-clock
        bpf_cookie 0
        pids perf_event(19483)
4: perf_event  prog 14
        event hw-cache:LLC-load-misses
        bpf_cookie 0
        pids perf_event(19483)
5: perf_event  prog 14
        event hardware:cpu-cycles
        bpf_cookie 0
        pids perf_event(19483)
6: perf_event  prog 19
        tracepoint sched_switch
        bpf_cookie 0
        pids tracepoint(20947)
7: perf_event  prog 26
        uprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
        bpf_cookie 0
        pids uprobe(21973)
8: perf_event  prog 27
        uretprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
        bpf_cookie 0
        pids uprobe(21973)
10: perf_event  prog 43
        kprobe ffffffffb70a9660 kernel_clone
        bpf_cookie 0
        pids kprobe(35275)
11: perf_event  prog 41
        kretprobe ffffffffb70a9660 kernel_clone
        bpf_cookie 0
        pids kprobe(35275)

$ tools/bpf/bpftool/bpftool link show -j
[{"id":3,"type":"perf_event","prog_id":14,"event_type":"software","event_co=
nfig":"cpu-clock","bpf_cookie":0,"pids":[{"pid":19483,"comm":"perf_event"}]=
},{"id":4,"type":"perf_event","prog_id":14,"event_type":"hw-cache","event_c=
onfig":"LLC-load-misses","bpf_cookie":0,"pids":[{"pid":19483,"comm":"perf_e=
vent"}]},{"id":5,"type":"perf_event","prog_id":14,"event_type":"hardware","=
event_config":"cpu-cycles","bpf_cookie":0,"pids":[{"pid":19483,"comm":"perf=
_event"}]},{"id":6,"type":"perf_event","prog_id":19,"tracepoint":"sched_swi=
tch","bpf_cookie":0,"pids":[{"pid":20947,"comm":"tracepoint"}]},{"id":7,"ty=
pe":"perf_event","prog_id":26,"retprobe":false,"file":"/home/dev/waken/bpf/=
uprobe/a.out","offset":4920,"bpf_cookie":0,"pids":[{"pid":21973,"comm":"upr=
obe"}]},{"id":8,"type":"perf_event","prog_id":27,"retprobe":true,"file":"/h=
ome/dev/waken/bpf/uprobe/a.out","offset":4920,"bpf_cookie":0,"pids":[{"pid"=
:21973,"comm":"uprobe"}]},{"id":10,"type":"perf_event","prog_id":43,"retpro=
be":false,"addr":18446744072485508704,"func":"kernel_clone","offset":0,"bpf=
_cookie":0,"pids":[{"pid":35275,"comm":"kprobe"}]},{"id":11,"type":"perf_ev=
ent","prog_id":41,"retprobe":true,"addr":18446744072485508704,"func":"kerne=
l_clone","offset":0,"bpf_cookie":0,"pids":[{"pid":35275,"comm":"kprobe"}]}]

For generic perf events, the displayed information in bpftool is limited to
the type and configuration, while other attributes such as sample_period,
sample_freq, etc., are not included.

The kernel function address won't be exposed if it is not permitted by
kptr_restrict. The result as follows when kptr_restrict is 2.

$ tools/bpf/bpftool/bpftool link show
3: perf_event  prog 14
        event software:cpu-clock
4: perf_event  prog 14
        event hw-cache:LLC-load-misses
5: perf_event  prog 14
        event hardware:cpu-cycles
6: perf_event  prog 19
        tracepoint sched_switch
7: perf_event  prog 26
        uprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
8: perf_event  prog 27
        uretprobe /home/dev/waken/bpf/uprobe/a.out+0x1338
10: perf_event  prog 43
        kprobe kernel_clone
11: perf_event  prog 41
        kretprobe kernel_clone

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/link.c | 247 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 246 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 8e4d9176a6e8..65a168df63bc 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -17,6 +17,8 @@
 #include "main.h"
 #include "xlated_dumper.h"
=20
+#define PERF_HW_CACHE_LEN 128
+
 static struct hashmap *link_table;
 static struct dump_data dd;
=20
@@ -279,6 +281,110 @@ show_kprobe_multi_json(struct bpf_link_info *info, js=
on_writer_t *wtr)
 	jsonw_end_array(json_wtr);
 }
=20
+static void
+show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	jsonw_bool_field(wtr, "retprobe", info->perf_event.type =3D=3D BPF_PERF_E=
VENT_KRETPROBE);
+	jsonw_uint_field(wtr, "addr", info->perf_event.kprobe.addr);
+	jsonw_string_field(wtr, "func",
+			   u64_to_ptr(info->perf_event.kprobe.func_name));
+	jsonw_uint_field(wtr, "offset", info->perf_event.kprobe.offset);
+}
+
+static void
+show_perf_event_uprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	jsonw_bool_field(wtr, "retprobe", info->perf_event.type =3D=3D BPF_PERF_E=
VENT_URETPROBE);
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
@@ -334,6 +440,26 @@ static int show_link_close_json(int fd, struct bpf_lin=
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
+		case BPF_PERF_EVENT_KRETPROBE:
+			show_perf_event_kprobe_json(info, json_wtr);
+			break;
+		case BPF_PERF_EVENT_UPROBE:
+		case BPF_PERF_EVENT_URETPROBE:
+			show_perf_event_uprobe_json(info, json_wtr);
+			break;
+		default:
+			break;
+		}
+		break;
 	default:
 		break;
 	}
@@ -505,6 +631,75 @@ static void show_kprobe_multi_plain(struct bpf_link_in=
fo *info)
 	}
 }
=20
+static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
+{
+	const char *buf;
+
+	buf =3D u64_to_ptr(info->perf_event.kprobe.func_name);
+	if (buf[0] =3D=3D '\0' && !info->perf_event.kprobe.addr)
+		return;
+
+	if (info->perf_event.type =3D=3D BPF_PERF_EVENT_KRETPROBE)
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
+	buf =3D u64_to_ptr(info->perf_event.uprobe.file_name);
+	if (buf[0] =3D=3D '\0')
+		return;
+
+	if (info->perf_event.type =3D=3D BPF_PERF_EVENT_URETPROBE)
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
+	buf =3D u64_to_ptr(info->perf_event.tracepoint.tp_name);
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
@@ -553,6 +748,26 @@ static int show_link_close_plain(int fd, struct bpf_li=
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
+		case BPF_PERF_EVENT_KRETPROBE:
+			show_perf_event_kprobe_plain(info);
+			break;
+		case BPF_PERF_EVENT_UPROBE:
+		case BPF_PERF_EVENT_URETPROBE:
+			show_perf_event_uprobe_plain(info);
+			break;
+		default:
+			break;
+		}
+		break;
 	default:
 		break;
 	}
@@ -575,11 +790,12 @@ static int do_show_link(int fd)
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
@@ -614,6 +830,35 @@ static int do_show_link(int fd)
 			goto again;
 		}
 	}
+	if (info.type =3D=3D BPF_LINK_TYPE_PERF_EVENT) {
+		switch (info.perf_event.type) {
+		case BPF_PERF_EVENT_TRACEPOINT:
+			if (!info.perf_event.tracepoint.tp_name) {
+				info.perf_event.tracepoint.tp_name =3D ptr_to_u64(&buf);
+				info.perf_event.tracepoint.name_len =3D sizeof(buf);
+				goto again;
+			}
+			break;
+		case BPF_PERF_EVENT_KPROBE:
+		case BPF_PERF_EVENT_KRETPROBE:
+			if (!info.perf_event.kprobe.func_name) {
+				info.perf_event.kprobe.func_name =3D ptr_to_u64(&buf);
+				info.perf_event.kprobe.name_len =3D sizeof(buf);
+				goto again;
+			}
+			break;
+		case BPF_PERF_EVENT_UPROBE:
+		case BPF_PERF_EVENT_URETPROBE:
+			if (!info.perf_event.uprobe.file_name) {
+				info.perf_event.uprobe.file_name =3D ptr_to_u64(&buf);
+				info.perf_event.uprobe.name_len =3D sizeof(buf);
+				goto again;
+			}
+			break;
+		default:
+			break;
+		}
+	}
=20
 	if (json_output)
 		show_link_close_json(fd, &info);
--=20
2.30.1 (Apple Git-130)


