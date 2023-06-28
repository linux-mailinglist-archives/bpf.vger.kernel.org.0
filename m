Return-Path: <bpf+bounces-3660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C304C741081
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BFF1C20503
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5BAC2D9;
	Wed, 28 Jun 2023 11:53:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2A4BA32
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:53:51 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA01D30C7;
	Wed, 28 Jun 2023 04:53:49 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1b06777596cso1318721fac.2;
        Wed, 28 Jun 2023 04:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953229; x=1690545229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fk/OgVSuBVSulryq84Ay+2pCg6rhn1wZZVYD4NzZU2A=;
        b=MxKHaKqnUcTB6iLObqRa+sVfjy4ZksBpxfOuPfyyQl4ZzD6dbfab0EfSo5SE5NxCbs
         SyRm3544wtRwPiwTjJ/KwZY7wcLFGfPTHs9P3Ef1dUVH3/DFbuz/+XG210fp3NiceR8k
         DFI264ulRUhapngpcfiCknrqvPmbd63V+wNPa3gkxSAc7h1NcptcibsFwe98QVnEPBYO
         5qGxyS77YGgZRUELJEePSm+kVt8qU/7zBIRWW1NRtPEdnyec7EGP6PaN/5tlsWPIneYH
         SmlQzA659jAc1AG8pTs5qj7Ge9MfiyR3XfzrdGdV2C/3hQvDT+FrSYmjLIydU2PDvTZ5
         svBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953229; x=1690545229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fk/OgVSuBVSulryq84Ay+2pCg6rhn1wZZVYD4NzZU2A=;
        b=PkhV1V7azLRMMak1M+UeWAMotqMBzTZXrShd4x0HwZncnPTHjSQE/DF+KQSoKBsr/1
         WyRuKshPow0INBjAD7l3Eq/8ypTyMyGMQ+00X+yyjc1Sd/NEOi+P3LctQgn9qH+qh/Qr
         zls6AjqxPUwnGOuCaDWSDBDiA4T98Ls5SPLlWbQ697LzQhlHzDTzXKx8rO7OkWoOmQzw
         iw2bk/brsziMoxykEi4793KS98+H2gyK8YEGF4UaCsdRMfsC9Ks2I7kgMuBnC2ZccBS8
         G+g5eLr3U2E0736nTAswCMv3SDMf71prVrm1I+IUsrskQAmfnolDCOMzADikUc0W5IJ4
         W2lg==
X-Gm-Message-State: AC+VfDxkTR2cOLuRNKsDzPbQjZgun6J2niYqp5h3J2KLdEYVFAuyvN0w
	enT/CEa5j3KBxbHPgph+oNE=
X-Google-Smtp-Source: ACHHUZ7nqri6c/ZmzA0lWbH9C0bsmH0C5EJwSJNlKoPiT/I1TQ6QwhyFzvLST1YO4AozRbbCT6rhew==
X-Received: by 2002:a05:6870:9444:b0:1ad:4d4:3104 with SMTP id e4-20020a056870944400b001ad04d43104mr20511459oal.38.1687953229132;
        Wed, 28 Jun 2023 04:53:49 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm8000504pji.6.2023.06.28.04.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:53:48 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 09/11] bpf: Support ->fill_link_info for perf_event
Date: Wed, 28 Jun 2023 11:53:27 +0000
Message-Id: <20230628115329.248450-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628115329.248450-1-laoar.shao@gmail.com>
References: <20230628115329.248450-1-laoar.shao@gmail.com>
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
 include/uapi/linux/bpf.h       |  35 ++++++++++
 kernel/bpf/syscall.c           | 117 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  35 ++++++++++
 3 files changed, 187 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 512ba3ba2ed3..7efe51672c15 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1057,6 +1057,16 @@ enum bpf_link_type {
 	MAX_BPF_LINK_TYPE,
 };
 
+enum bpf_perf_event_type {
+	BPF_PERF_EVENT_UNSPEC = 0,
+	BPF_PERF_EVENT_UPROBE = 1,
+	BPF_PERF_EVENT_URETPROBE = 2,
+	BPF_PERF_EVENT_KPROBE = 3,
+	BPF_PERF_EVENT_KRETPROBE = 4,
+	BPF_PERF_EVENT_TRACEPOINT = 5,
+	BPF_PERF_EVENT_EVENT = 6,
+};
+
 /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
  *
  * NONE(default): No further bpf programs allowed in the subtree.
@@ -6444,6 +6454,31 @@ struct bpf_link_info {
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
+				} uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_PERF_EVENT_URETPROBE */
+				struct {
+					__aligned_u64 func_name; /* in/out */
+					__u32 name_len;
+					__u32 offset;/* offset from func_name */
+					__u64 addr;
+				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
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
index 72de91beabbc..05ff0a560f1a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3398,9 +3398,126 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
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
+	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+					&type);
+	if (err)
+		return err;
+	if (type == BPF_FD_TYPE_KRETPROBE)
+		info->perf_event.type = BPF_PERF_EVENT_KRETPROBE;
+	else
+		info->perf_event.type = BPF_PERF_EVENT_KPROBE;
+
+	info->perf_event.kprobe.offset = offset;
+	if (!kallsyms_show_value(current_cred()))
+		addr = 0;
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
+	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+					&type);
+	if (err)
+		return err;
+
+	if (type == BPF_FD_TYPE_URETPROBE)
+		info->perf_event.type = BPF_PERF_EVENT_URETPROBE;
+	else
+		info->perf_event.type = BPF_PERF_EVENT_UPROBE;
+	info->perf_event.uprobe.offset = offset;
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
index 512ba3ba2ed3..7efe51672c15 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1057,6 +1057,16 @@ enum bpf_link_type {
 	MAX_BPF_LINK_TYPE,
 };
 
+enum bpf_perf_event_type {
+	BPF_PERF_EVENT_UNSPEC = 0,
+	BPF_PERF_EVENT_UPROBE = 1,
+	BPF_PERF_EVENT_URETPROBE = 2,
+	BPF_PERF_EVENT_KPROBE = 3,
+	BPF_PERF_EVENT_KRETPROBE = 4,
+	BPF_PERF_EVENT_TRACEPOINT = 5,
+	BPF_PERF_EVENT_EVENT = 6,
+};
+
 /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
  *
  * NONE(default): No further bpf programs allowed in the subtree.
@@ -6444,6 +6454,31 @@ struct bpf_link_info {
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
+				} uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_PERF_EVENT_URETPROBE */
+				struct {
+					__aligned_u64 func_name; /* in/out */
+					__u32 name_len;
+					__u32 offset;/* offset from func_name */
+					__u64 addr;
+				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
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
2.39.3


