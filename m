Return-Path: <bpf+bounces-2103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6B4727CE6
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 12:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093882812EC
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 10:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34099BE70;
	Thu,  8 Jun 2023 10:35:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B008495
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:35:43 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5186C2D47
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:35:39 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-5ed99ebe076so4232436d6.2
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220538; x=1688812538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZK2D3AupHIPEtRDmceJilfcB3T0jwDK/RuBEpK2/zo=;
        b=QoCfGIZ9IobBvr4RO4QA7eVVNQGA/IpZgfz4mbzVzxDN17gzezrxnFnMsSHSMM2AH8
         vovSyoLtXVd5pADyGoHcul7OG86b35IH1uNfcyjE78uCpgQ0xM0ppTXWC4AEdVOITalY
         5kJcqjQ7P/gTwxO26QxltauTxrHMXHCGw8pCriZUCJ4YiWcTW7UNyQSLq025EhlZmDHD
         b0ukqddUaeGzEtsG3Xz39sifUh3HcZandpIVaSFD1yrosy7WPpjuUHy6mPQxVOxzXA/S
         fjDqhSAZ1//kWaAWGp8V8RxorVJ53im25gM5OAat37dsrEgbMKKaqoQURcaktEWMSlva
         Q0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220538; x=1688812538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZK2D3AupHIPEtRDmceJilfcB3T0jwDK/RuBEpK2/zo=;
        b=NjdTvY+GhPqdeBjQ33NtE+mRVsb9J4jdBfBr7oHW1nA+lZW7nG/Q2stCcnNQqu+lpL
         TX6iYwks9yDP7nI+Sng8dCD8teaRmN/TOAKkDIGnPIQeALdZsfc3R26HsSBswjgLoGB6
         oKOXFcLb/c7IF21wZXiWUyXucgr75+sgt3GjOT3gTGQu7IEK6uSlq7j+pjJzrQ5X3u0J
         VPLNzcFrQjRRgtTtmpGOgdg0mEdXtW1JL+d0Uz3wo8HKhhysKYxl7l4YGORsGs3f/cjH
         SCGTEF9W5DYnEno1Oe6FlWkWrVr3Xn4YRADjQfUWfKcbf6BPlAZa444vEek1qBLQO3ID
         Y2Jw==
X-Gm-Message-State: AC+VfDyMiDlUP++De4X024YzKLGxHDkggUQ4Fog8iz6uyA3nc9saYbUW
	a+ujgo40BXm1GNQmG0KcS+E=
X-Google-Smtp-Source: ACHHUZ6vAAzHwkxAiVjmyEQq9t/GdrU9CPQ5mN8EpmQg7crFXpBVYWvXoXYRxt5CMezvu86gP1V38A==
X-Received: by 2002:a05:6214:f0a:b0:622:199c:c4d0 with SMTP id gw10-20020a0562140f0a00b00622199cc4d0mr1362667qvb.15.1686220538452;
        Thu, 08 Jun 2023 03:35:38 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:2418:5400:4ff:fe77:b548])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cf550000000b0062839fc6e36sm302714qvm.70.2023.06.08.03.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:35:38 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 03/11] bpftool: Show probed function in kprobe_multi link info
Date: Thu,  8 Jun 2023 10:35:15 +0000
Message-Id: <20230608103523.102267-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230608103523.102267-1-laoar.shao@gmail.com>
References: <20230608103523.102267-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Show the already expose kprobe_multi link info in bpftool. The result as
follows,

$ tools/bpf/bpftool/bpftool link show
4: kprobe_multi  prog 29
        retprobe 0  func_cnt 4
        addrs ffffffffb5d475b0  funcs schedule_timeout_interruptible
              ffffffffb5d475f0        schedule_timeout_killable
              ffffffffb5d47630        schedule_timeout_uninterruptible
              ffffffffb5d47670        schedule_timeout_idle
        pids trace(276245)

$ tools/bpf/bpftool/bpftool link show -j
[{"id":4,"type":"kprobe_multi","prog_id":29,"retprobe":0,"func_cnt":4,"funcs":[{"addr":18446744072465184176,"func":"schedule_timeout_interruptible"},{"addr":18446744072465184240,"func":"schedule_timeout_killable"},{"addr":18446744072465184304,"func":"schedule_timeout_uninterruptible"},{"addr":18446744072465184368,"func":"schedule_timeout_idle"}],"pids":[{"pid":276245,"comm":"trace"}]}]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 2d78607..c8033c3 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -14,6 +14,7 @@
 
 #include "json_writer.h"
 #include "main.h"
+#include "xlated_dumper.h"
 
 static struct hashmap *link_table;
 
@@ -166,6 +167,34 @@ static int get_prog_info(int prog_id, struct bpf_prog_info *info)
 	return err;
 }
 
+static void
+show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
+{
+	struct dump_data dd = {};
+	const __u64 *addrs;
+	__u32 i;
+	int err;
+
+	jsonw_uint_field(json_wtr, "retprobe", info->kprobe_multi.retprobe);
+	jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi.count);
+	jsonw_name(json_wtr, "funcs");
+	jsonw_start_array(json_wtr);
+	addrs = (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
+	err = kernel_syms_load(&dd, addrs, info->kprobe_multi.count);
+	if (err) {
+		jsonw_end_array(json_wtr);
+		return;
+	}
+	for (i = 0; i < dd.sym_count; i++) {
+		jsonw_start_object(json_wtr);
+		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
+		jsonw_string_field(json_wtr, "func", dd.sym_mapping[i].name);
+		jsonw_end_object(json_wtr);
+	}
+	jsonw_end_array(json_wtr);
+	kernel_syms_destroy(&dd);
+}
+
 static int show_link_close_json(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
@@ -218,6 +247,9 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 		jsonw_uint_field(json_wtr, "map_id",
 				 info->struct_ops.map_id);
 		break;
+	case BPF_LINK_TYPE_KPROBE_MULTI:
+		show_kprobe_multi_json(info, json_wtr);
+		break;
 	default:
 		break;
 	}
@@ -351,6 +383,35 @@ void netfilter_dump_plain(const struct bpf_link_info *info)
 		printf(" flags 0x%x", info->netfilter.flags);
 }
 
+static void show_kprobe_multi_plain(struct bpf_link_info *info)
+{
+	struct dump_data dd = {};
+	const __u64 *addrs;
+	__u32 i;
+	int err;
+
+	if (!info->kprobe_multi.count)
+		return;
+
+	printf("\n\tretprobe %d  func_cnt %u  ",
+	       info->kprobe_multi.retprobe, info->kprobe_multi.count);
+	addrs = (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
+	err = kernel_syms_load(&dd, addrs, info->kprobe_multi.count);
+	if (err)
+		return;
+	for (i = 0; i < dd.sym_count; i++) {
+		if (!i)
+			printf("\n\taddrs %016lx  funcs %s  ",
+			       dd.sym_mapping[i].address,
+			       dd.sym_mapping[i].name);
+		else
+			printf("\n\t      %016lx        %s  ",
+			       dd.sym_mapping[i].address,
+			       dd.sym_mapping[i].name);
+	}
+	kernel_syms_destroy(&dd);
+}
+
 static int show_link_close_plain(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
@@ -396,6 +457,9 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_NETFILTER:
 		netfilter_dump_plain(info);
 		break;
+	case BPF_LINK_TYPE_KPROBE_MULTI:
+		show_kprobe_multi_plain(info);
+		break;
 	default:
 		break;
 	}
@@ -417,7 +481,9 @@ static int do_show_link(int fd)
 {
 	struct bpf_link_info info;
 	__u32 len = sizeof(info);
+	__u64 *addrs = NULL;
 	char buf[256];
+	int count;
 	int err;
 
 	memset(&info, 0, sizeof(info));
@@ -441,12 +507,28 @@ static int do_show_link(int fd)
 		info.iter.target_name_len = sizeof(buf);
 		goto again;
 	}
+	if (info.type == BPF_LINK_TYPE_KPROBE_MULTI &&
+	    !info.kprobe_multi.addrs) {
+		count = info.kprobe_multi.count;
+		if (count) {
+			addrs = calloc(count, sizeof(__u64));
+			if (!addrs) {
+				p_err("mem alloc failed");
+				close(fd);
+				return -1;
+			}
+			info.kprobe_multi.addrs = (unsigned long)addrs;
+			goto again;
+		}
+	}
 
 	if (json_output)
 		show_link_close_json(fd, &info);
 	else
 		show_link_close_plain(fd, &info);
 
+	if (addrs)
+		free(addrs);
 	close(fd);
 	return 0;
 }
-- 
1.8.3.1


