Return-Path: <bpf+bounces-2415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B5872C9A4
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87DA2810DB
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCEC1DDFA;
	Mon, 12 Jun 2023 15:16:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA319511
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:16:34 +0000 (UTC)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E92E63;
	Mon, 12 Jun 2023 08:16:27 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4635c158e2aso1218375e0c.3;
        Mon, 12 Jun 2023 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582987; x=1689174987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipOtOLH0eCoqdtlt4P3S4Nuxsk5nZTTtOt/GxTeUjs8=;
        b=CHtHcUWeBWcutxQa80MWMJ2lA2Gxm8IJLN0dsqKweKUfslEJ5q8VY4d3td+/lY+hzh
         h+8XiIaxX9lVtXee2DFhBUGmGAMnf7wgy2KK3CXHNMj/W3Ev+TMOlvCl03VWhGJwPgSg
         GnLOwl1Q81kG96tDbaqlL7vkDCA2GjIqIeypKHQe16axaSbQp8iyW7lsTI8Tm61gVydv
         aZPtT2CtxRkO640cDjWZEi8bHFe8u6ROGIIwTVel6Nu1oPSeYeuEgxVkJf+LZBF0D8Xr
         /jNQZ8t4T4RTzb4lLpcl7h0F0eZc2BVdLw3cJZjQEykpCeLNyE6Vxy5nuD2wpumCen9G
         6D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582987; x=1689174987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipOtOLH0eCoqdtlt4P3S4Nuxsk5nZTTtOt/GxTeUjs8=;
        b=UsmivWSNywN1qA15POgZlqQ+H+m++jtYMT/9JMSzl3I9XtXzeO05kC7pT3xosiM3/B
         yAek2JaL3t4QBBTtAAgnQc3DTU8u8sfBGeglXJSp5Q5oflK94II7stBYJ+1E6mOAQTIk
         XkmZlkADB3LVjQx1+5v4HuFzZR7VLJ3iGoqPSGDKkSWZSvTnXkXYwKDnTM+7L1yx1L79
         i6O8V9ttOiIYov9XWar6WzPo+XJfecm7jkRA8ZVulf8qD7Hj60HKkZYhG48xKGtxEUze
         LfzudMZ/TZNrqptkDGL2yPZw7s9JyVeB/luVI4BQBcmN1ati68Xp92X3ZF7dvc4yPTqb
         Ee2A==
X-Gm-Message-State: AC+VfDxyZcLKawp9cgS0t8pzV9/k64IrrmbARDXshd/Ez7YF5t+Ao+Gr
	9Qwuiyv9pmEGYDQYZ7Fmgh8=
X-Google-Smtp-Source: ACHHUZ4wcRSYDYhtp4x0qNwiAiDt5y0y7uLIBXM4hjsOVnTBdWj+5IXeliZLFS6VJAIgLLxTk8a7PA==
X-Received: by 2002:a67:e418:0:b0:439:5904:6f6d with SMTP id d24-20020a67e418000000b0043959046f6dmr2893417vsf.33.1686582986757;
        Mon, 12 Jun 2023 08:16:26 -0700 (PDT)
Received: from vultr.guest ([108.61.23.146])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0062de0dde008sm1533953qvm.64.2023.06.12.08.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:16:26 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 10/10] bpftool: Show probed function in perf_event link info
Date: Mon, 12 Jun 2023 15:16:08 +0000
Message-Id: <20230612151608.99661-11-laoar.shao@gmail.com>
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

Enhance bpftool to display comprehensive information about exposed
perf_event links, covering uprobe, kprobe, tracepoint, and generic perf
event. The resulting output will include the following details:

$ tools/bpf/bpftool/bpftool link show
3: perf_event  prog 14
        event_type software  event_config cpu-clock
        bpf_cookie 0
        pids perf_event(1379330)
4: perf_event  prog 14
        event_type hw-cache  event_config LLC-load-misses
        bpf_cookie 0
        pids perf_event(1379330)
5: perf_event  prog 14
        event_type hardware  event_config cpu-cycles
        bpf_cookie 0
        pids perf_event(1379330)
6: perf_event  prog 20
        retprobe 0  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1338
        bpf_cookie 0
        pids uprobe(1379706)
7: perf_event  prog 21
        retprobe 1  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1338
        bpf_cookie 0
        pids uprobe(1379706)
8: perf_event  prog 27
        tp_name sched_switch
        bpf_cookie 0
        pids tracepoint(1381734)
10: perf_event  prog 43
        retprobe 0  func_name kernel_clone  addr ffffffffad0a9660
        bpf_cookie 0
        pids kprobe(1384186)
11: perf_event  prog 41
        retprobe 1  func_name kernel_clone  addr ffffffffad0a9660
        bpf_cookie 0
        pids kprobe(1384186)

$ tools/bpf/bpftool/bpftool link show -j
[{"id":3,"type":"perf_event","prog_id":14,"event_type":"software","event_co=
nfig":"cpu-clock","bpf_cookie":0,"pids":[{"pid":1379330,"comm":"perf_event"=
}]},{"id":4,"type":"perf_event","prog_id":14,"event_type":"hw-cache","event=
_config":"LLC-load-misses","bpf_cookie":0,"pids":[{"pid":1379330,"comm":"pe=
rf_event"}]},{"id":5,"type":"perf_event","prog_id":14,"event_type":"hardwar=
e","event_config":"cpu-cycles","bpf_cookie":0,"pids":[{"pid":1379330,"comm"=
:"perf_event"}]},{"id":6,"type":"perf_event","prog_id":20,"retprobe":0,"fil=
e_name":"/home/yafang/bpf/uprobe/a.out","offset":4920,"bpf_cookie":0,"pids"=
:[{"pid":1379706,"comm":"uprobe"}]},{"id":7,"type":"perf_event","prog_id":2=
1,"retprobe":1,"file_name":"/home/yafang/bpf/uprobe/a.out","offset":4920,"b=
pf_cookie":0,"pids":[{"pid":1379706,"comm":"uprobe"}]},{"id":8,"type":"perf=
_event","prog_id":27,"tp_name":"sched_switch","bpf_cookie":0,"pids":[{"pid"=
:1381734,"comm":"tracepoint"}]},{"id":10,"type":"perf_event","prog_id":43,"=
retprobe":0,"func_name":"kernel_clone","offset":0,"addr":184467440723177365=
44,"bpf_cookie":0,"pids":[{"pid":1384186,"comm":"kprobe"}]},{"id":11,"type"=
:"perf_event","prog_id":41,"retprobe":1,"func_name":"kernel_clone","offset"=
:0,"addr":18446744072317736544,"bpf_cookie":0,"pids":[{"pid":1384186,"comm"=
:"kprobe"}]}]

For generic perf events, the displayed information in bpftool is limited to
the type and configuration, while other attributes such as sample_period,
sample_freq, etc., are not included.

The kernel function address won't be exposed if it is not permitted by
kptr_restrict. The result as follows when kptr_restrict is 2.

$ tools/bpf/bpftool/bpftool link show
3: perf_event  prog 14
        event_type software  event_config cpu-clock
4: perf_event  prog 14
        event_type hw-cache  event_config LLC-load-misses
5: perf_event  prog 14
        event_type hardware  event_config cpu-cycles
6: perf_event  prog 20
        retprobe 0  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1338
7: perf_event  prog 21
        retprobe 1  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1338
8: perf_event  prog 27
        tp_name sched_switch
10: perf_event  prog 43
        retprobe 0  func_name kernel_clone
11: perf_event  prog 41
        retprobe 1  func_name kernel_clone

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 213 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 213 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 0015582..c16f71d 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -15,6 +15,7 @@
 #include "json_writer.h"
 #include "main.h"
 #include "xlated_dumper.h"
+#include "perf.h"
=20
 static struct hashmap *link_table;
 static struct dump_data dd =3D {};
@@ -207,6 +208,109 @@ static int cmp_u64(const void *A, const void *B)
 	jsonw_end_array(json_wtr);
 }
=20
+static void
+show_perf_event_kprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	jsonw_uint_field(wtr, "retprobe", info->kprobe.flags & 0x1);
+	jsonw_string_field(wtr, "func_name",
+			   u64_to_ptr(info->kprobe.func_name));
+	jsonw_uint_field(wtr, "offset", info->kprobe.offset);
+	jsonw_uint_field(wtr, "addr", info->kprobe.addr);
+}
+
+static void
+show_perf_event_uprobe_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	jsonw_uint_field(wtr, "retprobe", info->uprobe.flags & 0x1);
+	jsonw_string_field(wtr, "file_name",
+			   u64_to_ptr(info->uprobe.file_name));
+	jsonw_uint_field(wtr, "offset", info->uprobe.offset);
+}
+
+static void
+show_perf_event_tp_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	jsonw_string_field(wtr, "tp_name",
+			   u64_to_ptr(info->tracepoint.tp_name));
+}
+
+static const char *perf_config_hw_cache_str(__u64 config)
+{
+#define PERF_HW_CACHE_LEN 128
+	const char *hw_cache, *result, *op;
+	char *str =3D malloc(PERF_HW_CACHE_LEN);
+
+	if (!str) {
+		p_err("mem alloc failed");
+		return NULL;
+	}
+	hw_cache =3D perf_hw_cache_str(config & 0xff);
+	if (hw_cache)
+		snprintf(str, PERF_HW_CACHE_LEN, "%s-", hw_cache);
+	else
+		snprintf(str, PERF_HW_CACHE_LEN, "%lld-", config & 0xff);
+	op =3D perf_hw_cache_op_str((config >> 8) & 0xff);
+	if (op)
+		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
+			 "%s-", op);
+	else
+		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
+			 "%lld-", (config >> 8) & 0xff);
+	result =3D perf_hw_cache_op_result_str(config >> 16);
+	if (result)
+		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
+			 "%s", result);
+	else
+		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
+			 "%lld", config >> 16);
+
+	return str;
+}
+
+static const char *perf_config_str(__u32 type, __u64 config)
+{
+	const char *perf_config;
+
+	switch (type) {
+	case PERF_TYPE_HARDWARE:
+		perf_config =3D perf_hw_str(config);
+		break;
+	case PERF_TYPE_SOFTWARE:
+		perf_config =3D perf_sw_str(config);
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
+	__u64 config =3D info->perf_event.config;
+	__u32 type =3D info->perf_event.type;
+	const char *perf_type, *perf_config;
+
+	perf_type =3D perf_type_str(type);
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
@@ -262,6 +366,16 @@ static int show_link_close_json(int fd, struct bpf_lin=
k_info *info)
 	case BPF_LINK_TYPE_KPROBE_MULTI:
 		show_kprobe_multi_json(info, json_wtr);
 		break;
+	case BPF_LINK_TYPE_PERF_EVENT:
+		if (info->perf_link_type =3D=3D BPF_PERF_LINK_PERF_EVENT)
+			show_perf_event_event_json(info, json_wtr);
+		else if (info->perf_link_type =3D=3D BPF_PERF_LINK_TRACEPOINT)
+			show_perf_event_tp_json(info, json_wtr);
+		else if (info->perf_link_type =3D=3D BPF_PERF_LINK_KPROBE)
+			show_perf_event_kprobe_json(info, json_wtr);
+		else if (info->perf_link_type =3D=3D BPF_PERF_LINK_UPROBE)
+			show_perf_event_uprobe_json(info, json_wtr);
+		break;
 	default:
 		break;
 	}
@@ -433,6 +547,71 @@ static void show_kprobe_multi_plain(struct bpf_link_in=
fo *info)
 	}
 }
=20
+static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
+{
+	const char *buf;
+	__u32 retprobe;
+
+	buf =3D (const char *)u64_to_ptr(info->kprobe.func_name);
+	if (buf[0] =3D=3D '\0' && !info->kprobe.addr)
+		return;
+
+	retprobe =3D info->kprobe.flags & 0x1;
+	printf("\n\tretprobe %u  func_name %s  ", retprobe, buf);
+	if (info->kprobe.offset)
+		printf("offset %#x  ", info->kprobe.offset);
+	if (info->kprobe.addr)
+		printf("addr %llx  ", info->kprobe.addr);
+}
+
+static void show_perf_event_uprobe_plain(struct bpf_link_info *info)
+{
+	const char *buf;
+	__u32 retprobe;
+
+	buf =3D (const char *)u64_to_ptr(info->uprobe.file_name);
+	if (buf[0] =3D=3D '\0')
+		return;
+
+	retprobe =3D info->uprobe.flags & 0x1;
+	printf("\n\tretprobe %u  file_name %s  ", retprobe, buf);
+	if (info->uprobe.offset)
+		printf("offset %#x  ", info->kprobe.offset);
+}
+
+static void show_perf_event_tp_plain(struct bpf_link_info *info)
+{
+	const char *buf;
+
+	buf =3D (const char *)u64_to_ptr(info->tracepoint.tp_name);
+	if (buf[0] =3D=3D '\0')
+		return;
+
+	printf("\n\ttp_name %s  ", buf);
+}
+
+static void show_perf_event_event_plain(struct bpf_link_info *info)
+{
+	__u64 config =3D info->perf_event.config;
+	__u32 type =3D info->perf_event.type;
+	const char *perf_type, *perf_config;
+
+	perf_type =3D perf_type_str(type);
+	if (perf_type)
+		printf("\n\tevent_type %s  ", perf_type);
+	else
+		printf("\n\tevent_type %u  ", type);
+
+	perf_config =3D perf_config_str(type, config);
+	if (perf_config)
+		printf("event_config %s  ", perf_config);
+	else
+		printf("event_config %llu  ", config);
+
+	if (type =3D=3D PERF_TYPE_HW_CACHE && perf_config)
+		free((void *)perf_config);
+}
+
 static int show_link_close_plain(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
@@ -481,6 +660,16 @@ static int show_link_close_plain(int fd, struct bpf_li=
nk_info *info)
 	case BPF_LINK_TYPE_KPROBE_MULTI:
 		show_kprobe_multi_plain(info);
 		break;
+	case BPF_LINK_TYPE_PERF_EVENT:
+		if (info->perf_link_type =3D=3D BPF_PERF_LINK_PERF_EVENT)
+			show_perf_event_event_plain(info);
+		else if (info->perf_link_type =3D=3D BPF_PERF_LINK_TRACEPOINT)
+			show_perf_event_tp_plain(info);
+		else if (info->perf_link_type =3D=3D BPF_PERF_LINK_KPROBE)
+			show_perf_event_kprobe_plain(info);
+		else if (info->perf_link_type =3D=3D BPF_PERF_LINK_UPROBE)
+			show_perf_event_uprobe_plain(info);
+		break;
 	default:
 		break;
 	}
@@ -508,6 +697,7 @@ static int do_show_link(int fd)
 	int err;
=20
 	memset(&info, 0, sizeof(info));
+	buf[0] =3D '\0';
 again:
 	err =3D bpf_link_get_info_by_fd(fd, &info, &len);
 	if (err) {
@@ -542,7 +732,30 @@ static int do_show_link(int fd)
 			goto again;
 		}
 	}
+	if (info.type =3D=3D BPF_LINK_TYPE_PERF_EVENT) {
+		if (info.perf_link_type =3D=3D BPF_PERF_LINK_PERF_EVENT)
+			goto out;
+		if (info.perf_link_type =3D=3D BPF_PERF_LINK_TRACEPOINT &&
+		    !info.tracepoint.tp_name) {
+			info.tracepoint.tp_name =3D (unsigned long)&buf;
+			info.tracepoint.name_len =3D sizeof(buf);
+			goto again;
+		}
+		if (info.perf_link_type =3D=3D BPF_PERF_LINK_KPROBE &&
+		    !info.kprobe.func_name) {
+			info.kprobe.func_name =3D (unsigned long)&buf;
+			info.kprobe.name_len =3D sizeof(buf);
+			goto again;
+		}
+		if (info.perf_link_type =3D=3D BPF_PERF_LINK_UPROBE &&
+		    !info.uprobe.file_name) {
+			info.uprobe.file_name =3D (unsigned long)&buf;
+			info.uprobe.name_len =3D sizeof(buf);
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


