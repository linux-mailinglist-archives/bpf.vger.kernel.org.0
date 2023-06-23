Return-Path: <bpf+bounces-3273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F097D73B9C1
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202631C20F49
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59403C2C7;
	Fri, 23 Jun 2023 14:16:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239319441
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 14:16:32 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899BC2136;
	Fri, 23 Jun 2023 07:16:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-66615629689so454751b3a.2;
        Fri, 23 Jun 2023 07:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687529790; x=1690121790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VooKI3hb6tmxFHhMRTTom+VhnYdoKpXBVCANjBy4MfQ=;
        b=ncUrBjvlwlXmLo+ysV5yWmp16yQuuxKlVXdc5/y+BfRFyRB2t8UM2ywf/sORMnsdNd
         gbLL8MeQH8pyo0eVnlyNb87jLVEauuhxAkHIHsyScqylycxmY5sGGc95SPsLz+ihvGvP
         prUV1hfIR2iMGGorCDzB34Ik9wy4EzJ8wHGu1X217OpZTY6rnV4J2Xwi46HVZIRoID9i
         CNpcMawv6zIsHApcVJbNIaql6XEPvDWuV1LySh2iDkKwx3wKMAg/2SAko0pIY2xS8d9H
         Io1qCKeeJjTKBN3shIZLnYqJEt/IRlTArgb6i0xBr/8zKCpPu152rRJe2Z0MdwqsmpRG
         2Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529790; x=1690121790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VooKI3hb6tmxFHhMRTTom+VhnYdoKpXBVCANjBy4MfQ=;
        b=SVbFZUuKg5udk8a09Rqe/Unt1KPP7PtdVT2ZCAWEfk01Nin/UQ2CXig4EqsNJlEg9g
         YZuBoqYBLNaNWyFOHnMgGVnENvLkIgikpwkn16Nw+W6Y29GdGw5DZJujmHxM7Ry2WQ6W
         Nut4kbEBEs6g9CjfdMil0fdXZMnzPTFSp3Pp+KVqcAihQkmm7YmRQ2OcZHBYhjgx8/uv
         Mnp7XgNV7VecO0/FuB6u66giVZMFaNjgIQGqFy6E2tbXzT7cwrCqEeMjrRJ2GZGMNJbk
         FoyE1b3U66r86zza5qUeP2c4XpYTxZz49yhEJxu8sZsS5nnjv4tNPjzmzgRPuO8UPYRO
         CHag==
X-Gm-Message-State: AC+VfDxfa2v157MOvZ19ZDqlO4Fplp7kLIkzg6Yy+cp6NXYf5Ii5dnDf
	ky44RnbXfrZV0TSgIyxoEew=
X-Google-Smtp-Source: ACHHUZ7Psykz1FdscsIEBVLsfywTaykysuOsf8iIn6OH0aLYc6yAj/nxsShMMYJM+/hTtmOZ1rU3uA==
X-Received: by 2002:a05:6a00:a8a:b0:641:3bf8:6514 with SMTP id b10-20020a056a000a8a00b006413bf86514mr26094155pfl.10.1687529789924;
        Fri, 23 Jun 2023 07:16:29 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1058:5400:4ff:fe7c:972])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005533c53f550sm6505942pgj.45.2023.06.23.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:16:29 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 09/11] bpf: Support ->fill_link_info for perf_event
Date: Fri, 23 Jun 2023 14:15:44 +0000
Message-Id: <20230623141546.3751-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230623141546.3751-1-laoar.shao@gmail.com>
References: <20230623141546.3751-1-laoar.shao@gmail.com>
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

By introducing support for ->fill_link_info to the perf_event link, users
gain the ability to inspect it using `bpftool link show`. While the current
approach involves accessing this information via `bpftool perf show`,
consolidating link information for all link types in one place offers
greater convenience. Additionally, this patch extends support to the
generic perf event, which is not currently accommodated by
`bpftool perf show`. While only the perf type and config are exposed to
userspace, other attributes such as sample_period and sample_freq are
ignored. It's important to note that if kptr_restrict is not permitted, the
probed address will not be exposed, maintaining security measures.

A new enum bpf_perf_event_type is introduced to help the user understand
which struct is relevant.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/bpf.h       |  35 +++++++++++++
 kernel/bpf/syscall.c           | 115 +++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  35 +++++++++++++
 3 files changed, 185 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 23691ea..1c579d5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1056,6 +1056,14 @@ enum bpf_link_type {
 	MAX_BPF_LINK_TYPE,
 };
 
+enum bpf_perf_event_type {
+	BPF_PERF_EVENT_UNSPEC = 0,
+	BPF_PERF_EVENT_UPROBE = 1,
+	BPF_PERF_EVENT_KPROBE = 2,
+	BPF_PERF_EVENT_TRACEPOINT = 3,
+	BPF_PERF_EVENT_EVENT = 4,
+};
+
 /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
  *
  * NONE(default): No further bpf programs allowed in the subtree.
@@ -6443,6 +6451,33 @@ struct bpf_link_info {
 			__u32 count;
 			__u32 flags;
 		} kprobe_multi;
+		struct {
+			__u32 type; /* enum bpf_perf_event_type */
+			__u32 :32;
+			union {
+				struct {
+					__aligned_u64 file_name; /* in/out */
+					__u32 name_len;
+					__u32 offset;/* offset from file_name */
+					__u32 flags;
+				} uprobe; /* BPF_PERF_EVENT_UPROBE */
+				struct {
+					__aligned_u64 func_name; /* in/out */
+					__u32 name_len;
+					__u32 offset;/* offset from func_name */
+					__u64 addr;
+					__u32 flags;
+				} kprobe; /* BPF_PERF_EVENT_KPROBE */
+				struct {
+					__aligned_u64 tp_name;   /* in/out */
+					__u32 name_len;
+				} tracepoint; /* BPF_PERF_EVENT_TRACEPOINT */
+				struct {
+					__u64 config;
+					__u32 type;
+				} event; /* BPF_PERF_EVENT_EVENT */
+			};
+		} perf_event;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c863d39..02dad3c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3394,9 +3394,124 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 	return 0;
 }
 
+#ifdef CONFIG_KPROBE_EVENTS
+static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
+				     struct bpf_link_info *info)
+{
+	char __user *uname;
+	u64 addr, offset;
+	u32 ulen, type;
+	int err;
+
+	uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
+	ulen = info->perf_event.kprobe.name_len;
+	info->perf_event.type = BPF_PERF_EVENT_KPROBE;
+	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+					&type);
+	if (err)
+		return err;
+
+	info->perf_event.kprobe.offset = offset;
+	if (type == BPF_FD_TYPE_KRETPROBE)
+		info->perf_event.kprobe.flags = 1;
+	if (!kallsyms_show_value(current_cred()))
+		return 0;
+	info->perf_event.kprobe.addr = addr;
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_UPROBE_EVENTS
+static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
+				     struct bpf_link_info *info)
+{
+	char __user *uname;
+	u64 addr, offset;
+	u32 ulen, type;
+	int err;
+
+	uname = u64_to_user_ptr(info->perf_event.uprobe.file_name);
+	ulen = info->perf_event.uprobe.name_len;
+	info->perf_event.type = BPF_PERF_EVENT_UPROBE;
+	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+					&type);
+	if (err)
+		return err;
+
+	info->perf_event.uprobe.offset = offset;
+	if (type == BPF_FD_TYPE_URETPROBE)
+		info->perf_event.uprobe.flags = 1;
+	return 0;
+}
+#endif
+
+static int bpf_perf_link_fill_probe(const struct perf_event *event,
+				    struct bpf_link_info *info)
+{
+#ifdef CONFIG_KPROBE_EVENTS
+	if (event->tp_event->flags & TRACE_EVENT_FL_KPROBE)
+		return bpf_perf_link_fill_kprobe(event, info);
+#endif
+#ifdef CONFIG_UPROBE_EVENTS
+	if (event->tp_event->flags & TRACE_EVENT_FL_UPROBE)
+		return bpf_perf_link_fill_uprobe(event, info);
+#endif
+	return -EOPNOTSUPP;
+}
+
+static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
+					 struct bpf_link_info *info)
+{
+	char __user *uname;
+	u64 addr, offset;
+	u32 ulen, type;
+
+	uname = u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
+	ulen = info->perf_event.tracepoint.name_len;
+	info->perf_event.type = BPF_PERF_EVENT_TRACEPOINT;
+	return bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+					 &type);
+}
+
+static int bpf_perf_link_fill_perf_event(const struct perf_event *event,
+					 struct bpf_link_info *info)
+{
+	info->perf_event.event.type = event->attr.type;
+	info->perf_event.event.config = event->attr.config;
+	info->perf_event.type = BPF_PERF_EVENT_EVENT;
+	return 0;
+}
+
+static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
+					struct bpf_link_info *info)
+{
+	struct bpf_perf_link *perf_link;
+	const struct perf_event *event;
+
+	perf_link = container_of(link, struct bpf_perf_link, link);
+	event = perf_get_event(perf_link->perf_file);
+	if (IS_ERR(event))
+		return PTR_ERR(event);
+
+	if (!event->prog)
+		return -EINVAL;
+
+	switch (event->prog->type) {
+	case BPF_PROG_TYPE_PERF_EVENT:
+		return bpf_perf_link_fill_perf_event(event, info);
+	case BPF_PROG_TYPE_TRACEPOINT:
+		return bpf_perf_link_fill_tracepoint(event, info);
+	case BPF_PROG_TYPE_KPROBE:
+		return bpf_perf_link_fill_probe(event, info);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct bpf_link_ops bpf_perf_link_lops = {
 	.release = bpf_perf_link_release,
 	.dealloc = bpf_perf_link_dealloc,
+	.fill_link_info = bpf_perf_link_fill_link_info,
 };
 
 static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 23691ea..1c579d5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1056,6 +1056,14 @@ enum bpf_link_type {
 	MAX_BPF_LINK_TYPE,
 };
 
+enum bpf_perf_event_type {
+	BPF_PERF_EVENT_UNSPEC = 0,
+	BPF_PERF_EVENT_UPROBE = 1,
+	BPF_PERF_EVENT_KPROBE = 2,
+	BPF_PERF_EVENT_TRACEPOINT = 3,
+	BPF_PERF_EVENT_EVENT = 4,
+};
+
 /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
  *
  * NONE(default): No further bpf programs allowed in the subtree.
@@ -6443,6 +6451,33 @@ struct bpf_link_info {
 			__u32 count;
 			__u32 flags;
 		} kprobe_multi;
+		struct {
+			__u32 type; /* enum bpf_perf_event_type */
+			__u32 :32;
+			union {
+				struct {
+					__aligned_u64 file_name; /* in/out */
+					__u32 name_len;
+					__u32 offset;/* offset from file_name */
+					__u32 flags;
+				} uprobe; /* BPF_PERF_EVENT_UPROBE */
+				struct {
+					__aligned_u64 func_name; /* in/out */
+					__u32 name_len;
+					__u32 offset;/* offset from func_name */
+					__u64 addr;
+					__u32 flags;
+				} kprobe; /* BPF_PERF_EVENT_KPROBE */
+				struct {
+					__aligned_u64 tp_name;   /* in/out */
+					__u32 name_len;
+				} tracepoint; /* BPF_PERF_EVENT_TRACEPOINT */
+				struct {
+					__u64 config;
+					__u32 type;
+				} event; /* BPF_PERF_EVENT_EVENT */
+			};
+		} perf_event;
 	};
 } __attribute__((aligned(8)));
 
-- 
1.8.3.1


