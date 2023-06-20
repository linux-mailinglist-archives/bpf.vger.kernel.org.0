Return-Path: <bpf+bounces-2938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44D57371B4
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 18:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A14E280D91
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441B01D2B6;
	Tue, 20 Jun 2023 16:30:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF0A1D2A1
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 16:30:36 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E9D100;
	Tue, 20 Jun 2023 09:30:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso1994467a12.1;
        Tue, 20 Jun 2023 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687278633; x=1689870633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqvY4jtEfZYloFEPW7IsonK2EHfV4D55HFqHyhzZqMg=;
        b=fbPnzUhB9Swfydfk5XqM3+BdUViF1cTQ5fd3BIrCRnQGvJTRgJ3Ls4HWQ9nnIxTLUi
         ytlbC3aKLUrVrHh23W8GnzPm7navXtjySiP4126iatbd8b5yb9hxrZGoa2r/9w6oXUpP
         AT0akfnFcVVFV4pubbtwswzhVswNGSueW1bDiRgx0+5tIKEcamIS8jcHS+vf42sJto43
         xBSNbDIBeVExPkCdfX4y8JDKoQ1p3+ZtEWjTwK+YqnKpmVLSDr5xpDTA7sJiERL/NJnd
         N6YCdKrqSB6aYeTI0Y7vQDI+7qmTGwVpGoB74GVyGEMqIrcl4wawsu+g+M2J6AjuRfZw
         F6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278633; x=1689870633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqvY4jtEfZYloFEPW7IsonK2EHfV4D55HFqHyhzZqMg=;
        b=lKz7s+NoOCX2b+rf+xkS2fEK/9JzinslAN6mSiSF6Bc8DeHAZSUDvb8EB6kGc5/i5a
         1O6Pi/8o765dZrM7j0RV/VY+3pclIGIM0yasKO/uw9Bwx2shjvG3UogGhwg0R//q1tJF
         O95jlR/wl5ZeP51W5fxSjz9xwEKibpNBDHd+pRd6jtyOUg+e8yQ2EmOUWf25OzVfVYIo
         ZLjMV8n8ulrkUP6WXDP/i8n+eKkfyEINcCaqwdZWqI0Dlx3cnDrGKadfhsYU8yWDaS+g
         +T5QzQizW4Omh1szvZx7LiZQaSs4BtsBDBGLwo8DwLOsZR5eHDpqLE4SlCNSCBLEFR40
         DzAg==
X-Gm-Message-State: AC+VfDyizJgPGsBWtHNgNrv/wgyfDqoA/mxBy7LquVIkpliWY5oH8ygL
	54DfNo58HjWVC/hdziMYcbyy4SOPkYzfMW5YalI=
X-Google-Smtp-Source: ACHHUZ6zN2FE4qcW4XBcsOL7YnoH1yERLmxdsJnyoNkoHN1j6NZysQUhZKF6HHzPl+A/HsDEjOvL4A==
X-Received: by 2002:a17:90b:33c4:b0:25e:b9fc:7e0c with SMTP id lk4-20020a17090b33c400b0025eb9fc7e0cmr9971809pjb.45.1687278633524;
        Tue, 20 Jun 2023 09:30:33 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b96:5400:4ff:fe7b:3b23])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b0025c1cfdb93esm1854286pjf.13.2023.06.20.09.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:32 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 09/11] bpf: Support ->fill_link_info for perf_event
Date: Tue, 20 Jun 2023 16:30:06 +0000
Message-Id: <20230620163008.3718-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230620163008.3718-1-laoar.shao@gmail.com>
References: <20230620163008.3718-1-laoar.shao@gmail.com>
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
 include/uapi/linux/bpf.h       |  36 +++++++++++++
 kernel/bpf/syscall.c           | 115 +++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  36 +++++++++++++
 3 files changed, 187 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 23691ea..56528dd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1056,6 +1056,16 @@ enum bpf_link_type {
 	MAX_BPF_LINK_TYPE,
 };
 
+enum bpf_perf_event_type {
+	BPF_PERF_EVENT_UNSPEC = 0,
+	BPF_PERF_EVENT_UPROBE = 1,
+	BPF_PERF_EVENT_KPROBE = 2,
+	BPF_PERF_EVENT_TRACEPOINT = 3,
+	BPF_PERF_EVENT_EVENT = 4,
+
+	MAX_BPF_PERF_EVENT_TYPE,
+};
+
 /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
  *
  * NONE(default): No further bpf programs allowed in the subtree.
@@ -6443,6 +6453,32 @@ struct bpf_link_info {
 			__u32 count;
 			__u32 flags;
 		} kprobe_multi;
+		struct {
+			__u32 type; /* enum bpf_perf_event_type */
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
index db9b500..9f8d378 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3340,9 +3340,124 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
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
+				    struct bpf_link_info *info)
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
index 23691ea..56528dd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1056,6 +1056,16 @@ enum bpf_link_type {
 	MAX_BPF_LINK_TYPE,
 };
 
+enum bpf_perf_event_type {
+	BPF_PERF_EVENT_UNSPEC = 0,
+	BPF_PERF_EVENT_UPROBE = 1,
+	BPF_PERF_EVENT_KPROBE = 2,
+	BPF_PERF_EVENT_TRACEPOINT = 3,
+	BPF_PERF_EVENT_EVENT = 4,
+
+	MAX_BPF_PERF_EVENT_TYPE,
+};
+
 /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
  *
  * NONE(default): No further bpf programs allowed in the subtree.
@@ -6443,6 +6453,32 @@ struct bpf_link_info {
 			__u32 count;
 			__u32 flags;
 		} kprobe_multi;
+		struct {
+			__u32 type; /* enum bpf_perf_event_type */
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


