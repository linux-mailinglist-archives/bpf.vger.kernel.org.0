Return-Path: <bpf+bounces-1362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E391713A00
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 16:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3491C20953
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4305677;
	Sun, 28 May 2023 14:20:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99308566E
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 14:20:39 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CF5B8
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:38 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6261a25e9b6so3230646d6.0
        for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685283637; x=1687875637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsZic1Ur1WdSbptVgbWV/7Kr8PTZ6BiLFray3Omc+wk=;
        b=D7z/2zPooVWUeIRRKrFUR362pGLXCC+0P4srK+ZruKScFGuSCoNeCEooEj5jxwhYqU
         BG/C/1/T/U1zmq/hKSG49ZzMFK00C1QoBaQfET+3n6wmNMi4yQFYbxKMtcfyi26ooqpA
         ObRrOzLsPQ003S+UXvRWbRVNC2oZVvr63/y0xBhguI+Ga263ThfjsYowyk2qpSO9XDY7
         1K1ei+7gPgLXUFh1OMbN7Bx8FdcWXr+kq7I4pUfc2r0yUsl/4exqbdJ8EkK4EMfrki2B
         hP5P94dboGWlS8WpV67GyoKVp99bvdCkreGLSOvBmZLJy2x0Y2x99rdjGSXRDrE3RIN/
         oPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685283637; x=1687875637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsZic1Ur1WdSbptVgbWV/7Kr8PTZ6BiLFray3Omc+wk=;
        b=ea1CGwB06K37PrBEARK+O1ITrSb9yi2ZBk/iNgF5HcAmhZvUv5FlQHPRrDF8s2mF49
         tWb7HIjLFLd2wpqnygj1irpTznGXG38R0GXbekCSB91unFO3fA27WQO0AyQKo7zhsrqD
         G2rOknOV7+aP11W2WbdCHcUEihK6MFojY4/3KbeDIEACjB/S6lsOMhpINqcywd8X1R7i
         OxEM3Y/7W517X2+w2ry23h7Wsq+5SRCnmg5SuRv5gJtRGpKVN+k12iprBKlSansrSq50
         rDwAEsCmHBnc6ACvsb3YXTnxIu+XI74bWE4OoVgjgCARmaDrycm053hsHT2FrWoBB7H1
         5meQ==
X-Gm-Message-State: AC+VfDyvgsGp0ygpy8K7UJqwDDadKHauaGOKusXzZyomHAY64nCIJeIx
	PFraUMTq/L12cpOC0fPaCAA=
X-Google-Smtp-Source: ACHHUZ6b0nynY/xkM0Rfgho2fx5tBNFR6YMdpw20CQ8PzdLV6pcmgHNxUHh2fz55gthGtecBkb3qgw==
X-Received: by 2002:ad4:4ee7:0:b0:626:9e7:7347 with SMTP id dv7-20020ad44ee7000000b0062609e77347mr7449778qvb.55.1685283637390;
        Sun, 28 May 2023 07:20:37 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5:38f3:5400:4ff:fe74:5668])
        by smtp.gmail.com with ESMTPSA id l11-20020a0cc20b000000b006238dc71f5csm10qvh.144.2023.05.28.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:20:36 -0700 (PDT)
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
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 3/8] bpftool: Show probed function in kprobe_multi link info
Date: Sun, 28 May 2023 14:20:22 +0000
Message-Id: <20230528142027.5585-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230528142027.5585-1-laoar.shao@gmail.com>
References: <20230528142027.5585-1-laoar.shao@gmail.com>
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

$ bpftool link show
2: kprobe_multi  prog 11
        func_cnt 4  addrs ffffffffaad475c0 ffffffffaad47600
                          ffffffffaad47640 ffffffffaad47680
        pids trace(10936)

$ bpftool link show -j
[{"id":1,"type":"perf_event","prog_id":5,"bpf_cookie":0,"pids":[{"pid":10658,"comm":"trace"}]},{"id":2,"type":"kprobe_multi","prog_id":11,"func_cnt":4,"addrs":[18446744072280634816,18446744072280634880,18446744072280634944,18446744072280635008],"pids":[{"pid":10936,"comm":"trace"}]},{"id":120,"type":"iter","prog_id":266,"target_name":"bpf_map"},{"id":121,"type":"iter","prog_id":267,"target_name":"bpf_prog"}]

$ bpftool link show  | grep -A 1 "func_cnt" | \
  awk '{if (NR == 1) {print $4; print $5;} else {print $1; print $2} }' | \
  awk '{"grep " $1 " /proc/kallsyms" | getline f; print f;}'
ffffffffaad475c0 T schedule_timeout_interruptible
ffffffffaad47600 T schedule_timeout_killable
ffffffffaad47640 T schedule_timeout_uninterruptible
ffffffffaad47680 T schedule_timeout_idle

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 2d78607..76f1bb2 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -218,6 +218,20 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 		jsonw_uint_field(json_wtr, "map_id",
 				 info->struct_ops.map_id);
 		break;
+	case BPF_LINK_TYPE_KPROBE_MULTI:
+		const __u64 *addrs;
+		__u32 i;
+
+		jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi.count);
+		if (!info->kprobe_multi.count)
+			break;
+		jsonw_name(json_wtr, "addrs");
+		jsonw_start_array(json_wtr);
+		addrs = (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
+		for (i = 0; i < info->kprobe_multi.count; i++)
+			jsonw_lluint(json_wtr, addrs[i]);
+		jsonw_end_array(json_wtr);
+		break;
 	default:
 		break;
 	}
@@ -396,6 +410,24 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_NETFILTER:
 		netfilter_dump_plain(info);
 		break;
+	case BPF_LINK_TYPE_KPROBE_MULTI:
+		__u32 indent, cnt, i;
+		const __u64 *addrs;
+
+		cnt = info->kprobe_multi.count;
+		if (!cnt)
+			break;
+		printf("\n\tfunc_cnt %d  addrs", cnt);
+		for (i = 0; cnt; i++)
+			cnt /= 10;
+		indent = strlen("func_cnt ") + i + strlen("  addrs");
+		addrs = (const __u64 *)u64_to_ptr(info->kprobe_multi.addrs);
+		for (i = 0; i < info->kprobe_multi.count; i++) {
+			if (i && !(i & 0x1))
+				printf("\n\t%*s", indent, "");
+			printf(" %0*llx", 16, addrs[i]);
+		}
+		break;
 	default:
 		break;
 	}
@@ -417,7 +449,9 @@ static int do_show_link(int fd)
 {
 	struct bpf_link_info info;
 	__u32 len = sizeof(info);
+	__u64 *addrs = NULL;
 	char buf[256];
+	int count;
 	int err;
 
 	memset(&info, 0, sizeof(info));
@@ -441,12 +475,28 @@ static int do_show_link(int fd)
 		info.iter.target_name_len = sizeof(buf);
 		goto again;
 	}
+	if (info.type == BPF_LINK_TYPE_KPROBE_MULTI &&
+	    !info.kprobe_multi.addrs) {
+		count = info.kprobe_multi.count;
+		if (count) {
+			addrs = malloc(count * sizeof(__u64));
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


