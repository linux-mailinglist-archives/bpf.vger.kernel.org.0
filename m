Return-Path: <bpf+bounces-2112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1825727CFD
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 12:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C661C20B89
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBBA1096A;
	Thu,  8 Jun 2023 10:35:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DFC8FD
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:35:48 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82432103
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:35:46 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-75d46c7cd6cso32593685a.3
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220546; x=1688812546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNt3akaJPIthWai2WuzrVMbK68Et2Ndbp/y1XO2NjqU=;
        b=ndjYNjM9wpPXop6hCh2JTLL8KroL7lHFqK5UwiGUbPvSUYsqlnVTuxoHU9+XSh7YZr
         DmdFVNukq67bps1BHuniveLUqto3K+6nanejOs6D1xD9gTCfNULJ1gbQVWFwKV4X6++/
         +9g3Bz7DDoJqb8s9DMsKLYVykPRJGfS01nWYU/3MC5s1V5numdvsa5LOtR4A4STsmwPG
         +RlK3IEsx2Bla6nQd99aeq1J9kaeGvjr+4gzSBU/5Sj3Hy/RPVZpJjyvRRsJDoXjNJR2
         yQDUOe9UghgNnFbLvm3SqElcXtK+oaZLJdkq+yPBC+PcQonppuKOqgmJEjGKjeOii9UV
         8pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220546; x=1688812546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNt3akaJPIthWai2WuzrVMbK68Et2Ndbp/y1XO2NjqU=;
        b=az/oR6p6Q21eWGLpZKJfwJKouMpmOfb+b3G6uBK/7XU8HOYxO/6omRduf0e1qh1KxT
         NIg288iVo7OtlMu4H3j3SgLUjNqIeXwWNMTESC0HROvn3V6FZTDn8y73Y2XL2OCn/CJ9
         OEBlhnddPZUIR7m9k44tPqFyTKyqqLqEk0tDUEgOV+e8A0rbDn6S+FoGevXZsDy7VTfJ
         0VnNaFSLlAmNwY+tkXQZgOycdoFGGBAjDxT49lfVrzVu61tLI4k3gOpt/8XcvVyIT3EV
         OvF8CJPH863KQbAZrd80HpudhyZiF6NYcm6A0HREuOe+AYeiNfV64+0RfW0BYfBpLcbd
         3pMA==
X-Gm-Message-State: AC+VfDw23t1UbRmuX6cf2JX1Ew+DfiUcpqI+KZy/I/2GQdKVlkOS2VTz
	CyHkm8rnHZXQn3A3bMbJReY=
X-Google-Smtp-Source: ACHHUZ5tYM5H1ThLinatloRJU9vuukTVS6serqx49OOw0zl/z0/M1CQFaes9vXO9IKYTdTlnPb2yoA==
X-Received: by 2002:a05:6214:d0a:b0:626:2e07:c080 with SMTP id 10-20020a0562140d0a00b006262e07c080mr1006917qvh.15.1686220545741;
        Thu, 08 Jun 2023 03:35:45 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:2418:5400:4ff:fe77:b548])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cf550000000b0062839fc6e36sm302714qvm.70.2023.06.08.03.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:35:45 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 11/11] bpftool: Show probed function in perf_event link info
Date: Thu,  8 Jun 2023 10:35:23 +0000
Message-Id: <20230608103523.102267-12-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230608103523.102267-1-laoar.shao@gmail.com>
References: <20230608103523.102267-1-laoar.shao@gmail.com>
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
4: perf_event  prog 22
        retprobe 0  name kernel_clone  addr ffffffff940a9660
        bpf_cookie 0
        pids kprobe(133008)
5: perf_event  prog 28
        tp_name sched_switch
        bpf_cookie 0
        pids tracepoint(133199)
7: perf_event  prog 42
        type software  config cpu_clock
        bpf_cookie 0
        pids perf_event(134187)
8: perf_event  prog 42
        type hw_cache  config ll-read-miss
        bpf_cookie 0
        pids perf_event(134187)
9: perf_event  prog 42
        type hardware  config cpu_cycles
        bpf_cookie 0
        pids perf_event(134187)
13: perf_event  prog 72
        retprobe 0  name /home/waken/bpf/uprobe/a.out  offset 0x1338
        bpf_cookie 0
        pids uprobe(164506)
14: perf_event  prog 73
        retprobe 1  name /home/waken/bpf/uprobe/a.out  offset 0x1338
        bpf_cookie 0
        pids uprobe(164506)

$ tools/bpf/bpftool/bpftool link show -j
[{"id":4,"type":"perf_event","prog_id":22,"retprobe":0,"name":"kernel_clone=
","offset":0,"addr":18446744071898306144,"bpf_cookie":0,"pids":[{"pid":1330=
08,"comm":"kprobe"}]},{"id":5,"type":"perf_event","prog_id":28,"tp_name":"s=
ched_switch","bpf_cookie":0,"pids":[{"pid":133199,"comm":"tracepoint"}]},{"=
id":7,"type":"perf_event","prog_id":42,"type":"software","config":"cpu_cloc=
k","bpf_cookie":0,"pids":[{"pid":134187,"comm":"perf_event"}]},{"id":8,"typ=
e":"perf_event","prog_id":42,"type":"hw_cache","config":"ll-read-miss","bpf=
_cookie":0,"pids":[{"pid":134187,"comm":"perf_event"}]},{"id":9,"type":"per=
f_event","prog_id":42,"type":"hardware","config":"cpu_cycles","bpf_cookie":=
0,"pids":[{"pid":134187,"comm":"perf_event"}]},{"id":13,"type":"perf_event"=
,"prog_id":72,"retprobe":0,"name":"/home/waken/bpf/uprobe/a.out","offset":4=
920,"addr":0,"bpf_cookie":0,"pids":[{"pid":164506,"comm":"uprobe"}]},{"id":=
14,"type":"perf_event","prog_id":73,"retprobe":1,"name":"/home/waken/bpf/up=
robe/a.out","offset":4920,"addr":0,"bpf_cookie":0,"pids":[{"pid":164506,"co=
mm":"uprobe"}]}]

For generic perf events, the displayed information in bpftool is limited to
the type and configuration, while other attributes such as sample_period,
sample_freq, etc., are not included.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 178 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 178 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index a2b75f4..7c02540 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -195,6 +195,100 @@ static int get_prog_info(int prog_id, struct bpf_prog=
_info *info)
 	kernel_syms_destroy(&dd);
 }
=20
+static void
+show_perf_event_probe_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	jsonw_uint_field(wtr, "retprobe", info->perf_event.probe.retprobe);
+	jsonw_string_field(wtr, "name",
+			   u64_to_ptr(info->perf_event.probe.name));
+	jsonw_uint_field(wtr, "offset", info->perf_event.probe.offset);
+	jsonw_uint_field(wtr, "addr", info->perf_event.probe.addr);
+}
+
+static void
+show_perf_event_tp_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	jsonw_string_field(wtr, "tp_name",
+			   u64_to_ptr(info->perf_event.tp.tp_name));
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
+	hw_cache =3D libbpf_perf_hw_cache_str(config & 0xff);
+	if (hw_cache)
+		snprintf(str, PERF_HW_CACHE_LEN, "%s-", hw_cache);
+	else
+		snprintf(str, PERF_HW_CACHE_LEN, "%lld-", config & 0xff);
+	op =3D libbpf_perf_hw_cache_op_str((config >> 8) & 0xff);
+	if (op)
+		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
+			 "%s-", op);
+	else
+		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
+			 "%lld-", (config >> 8) & 0xff);
+	result =3D libbpf_perf_hw_cache_op_result_str(config >> 16);
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
+		perf_config =3D libbpf_perf_hw_str(config);
+		break;
+	case PERF_TYPE_SOFTWARE:
+		perf_config =3D libbpf_perf_sw_str(config);
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
+	perf_type =3D libbpf_perf_type_str(type);
+	if (perf_type)
+		jsonw_string_field(wtr, "type", perf_type);
+	else
+		jsonw_uint_field(wtr, "type", type);
+
+	perf_config =3D perf_config_str(type, config);
+	if (perf_config)
+		jsonw_string_field(wtr, "config", perf_config);
+	else
+		jsonw_uint_field(wtr, "config", config);
+
+	if (type =3D=3D PERF_TYPE_HW_CACHE && perf_config)
+		free((void *)perf_config);
+}
+
 static int show_link_close_json(int fd, struct bpf_link_info *info,
 				const struct bpf_prog_info *prog_info)
 {
@@ -245,6 +339,14 @@ static int show_link_close_json(int fd, struct bpf_lin=
k_info *info,
 	case BPF_LINK_TYPE_KPROBE_MULTI:
 		show_kprobe_multi_json(info, json_wtr);
 		break;
+	case BPF_LINK_TYPE_PERF_EVENT:
+		if (prog_info->type =3D=3D BPF_PROG_TYPE_PERF_EVENT)
+			show_perf_event_event_json(info, json_wtr);
+		else if (prog_info->type =3D=3D BPF_PROG_TYPE_TRACEPOINT)
+			show_perf_event_tp_json(info, json_wtr);
+		else
+			show_perf_event_probe_json(info, json_wtr);
+		break;
 	default:
 		break;
 	}
@@ -407,6 +509,56 @@ static void show_kprobe_multi_plain(struct bpf_link_in=
fo *info)
 	kernel_syms_destroy(&dd);
 }
=20
+static void show_perf_event_probe_plain(struct bpf_link_info *info)
+{
+	const char *buf;
+	__u32 retprobe;
+
+	buf =3D (const char *)u64_to_ptr(info->perf_event.probe.name);
+	if (buf[0] =3D=3D '\0' && !info->perf_event.probe.addr)
+		return;
+
+	retprobe =3D info->perf_event.probe.retprobe;
+	printf("\n\tretprobe %u  name %s  ", retprobe, buf);
+	if (info->perf_event.probe.offset)
+		printf("offset %#x  ", info->perf_event.probe.offset);
+	if (info->perf_event.probe.addr)
+		printf("addr %llx  ", info->perf_event.probe.addr);
+}
+
+static void show_perf_event_tp_plain(struct bpf_link_info *info)
+{
+	const char *buf;
+
+	buf =3D (const char *)u64_to_ptr(info->perf_event.tp.tp_name);
+	if (buf[0] =3D=3D '\0')
+		return;
+
+	printf("\n\ttp_name %s  ", buf);
+}
+
+static void show_perf_event_event_plain(struct bpf_link_info *info)
+{
+	__u64 config =3D info->perf_event.event.config;
+	__u32 type =3D info->perf_event.event.type;
+	const char *perf_type, *perf_config;
+
+	perf_type =3D libbpf_perf_type_str(type);
+	if (perf_type)
+		printf("\n\ttype %s  ", perf_type);
+	else
+		printf("\n\ttype %u  ", type);
+
+	perf_config =3D perf_config_str(type, config);
+	if (perf_config)
+		printf("config %s  ", perf_config);
+	else
+		printf("config %llu  ", config);
+
+	if (type =3D=3D PERF_TYPE_HW_CACHE && perf_config)
+		free((void *)perf_config);
+}
+
 static int show_link_close_plain(int fd, struct bpf_link_info *info,
 				 const struct bpf_prog_info *prog_info)
 {
@@ -450,6 +602,14 @@ static int show_link_close_plain(int fd, struct bpf_li=
nk_info *info,
 	case BPF_LINK_TYPE_KPROBE_MULTI:
 		show_kprobe_multi_plain(info);
 		break;
+	case BPF_LINK_TYPE_PERF_EVENT:
+		if (prog_info->type =3D=3D BPF_PROG_TYPE_PERF_EVENT)
+			show_perf_event_event_plain(info);
+		else if (prog_info->type =3D=3D BPF_PROG_TYPE_TRACEPOINT)
+			show_perf_event_tp_plain(info);
+		else
+			show_perf_event_probe_plain(info);
+		break;
 	default:
 		break;
 	}
@@ -479,6 +639,7 @@ static int do_show_link(int fd)
=20
 	memset(&prog_info, 0, sizeof(info));
 	memset(&info, 0, sizeof(info));
+	buf[0] =3D '\0';
 again:
 	err =3D bpf_link_get_info_by_fd(fd, &info, &len);
 	if (err) {
@@ -520,7 +681,24 @@ static int do_show_link(int fd)
 			goto again;
 		}
 	}
+	if (info.type =3D=3D BPF_LINK_TYPE_PERF_EVENT) {
+		if (prog_info.type =3D=3D BPF_PROG_TYPE_PERF_EVENT)
+			goto out;
+		if (prog_info.type =3D=3D BPF_PROG_TYPE_TRACEPOINT &&
+		    !info.perf_event.tp.tp_name) {
+			info.perf_event.tp.tp_name =3D (unsigned long)&buf;
+			info.perf_event.tp.name_len =3D sizeof(buf);
+			goto again;
+		}
+		if (prog_info.type =3D=3D BPF_PROG_TYPE_KPROBE &&
+		    !info.perf_event.probe.name) {
+			info.perf_event.probe.name =3D (unsigned long)&buf;
+			info.perf_event.probe.name_len =3D sizeof(buf);
+			goto again;
+		}
+	}
=20
+out:
 	if (json_output)
 		show_link_close_json(fd, &info, &prog_info);
 	else
--=20
1.8.3.1


