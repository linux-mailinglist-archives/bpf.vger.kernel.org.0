Return-Path: <bpf+bounces-4516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D01174C07D
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44FC280E72
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78D1FBE;
	Sun,  9 Jul 2023 02:56:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE01FAA
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:56:52 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0065AE45;
	Sat,  8 Jul 2023 19:56:51 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6682909acadso1714285b3a.3;
        Sat, 08 Jul 2023 19:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871411; x=1691463411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wjq8mMz0+0hkgkZtxTtq9fCbMCnT3V+/1TWrpmkWjvc=;
        b=I20582MtpE95pdpXnom2/6pI+4VovyYfVprhBqzMPzTYQF7e19gI0uMbWkHR5T0zZW
         HCW3oDJ3aRWUrDsNRlrbrR6RQ7dLrCzXvO6wVL6ZxbiNmdIYNIDFFDytOFNp2kCQCNLc
         1a1wIVUUn17RY23/H7XnoAj+niRV4iNU9gkyEDrDxTg3uItYYWlAX5DdJC8TMcmnHBAf
         kHtrHAvlGdJvdgZPE0W0j0e/U89GGdAWdAtQSEnTX5d30ucZ29jHH+K/503A2LLPIO4k
         BEhqYprT72B4Rwnr1n4kyzNv1O9WWPbKzoheB0BL+lZu4LEv00EeyLkxY8Go8XqMAHwp
         5muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871411; x=1691463411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wjq8mMz0+0hkgkZtxTtq9fCbMCnT3V+/1TWrpmkWjvc=;
        b=RdL3uuiZ3VUXNjI+zSNQbpGlW13YaAYbM1hLi0MJY0nfxfO1DYtRD/RwysskvbSSYK
         XQqE3EttsdDKB5I0HTko3oTxfH329kzxXATac+4F2bzcLqzi+NUhB9BU8a1zhALvWz2a
         y1F8ZLejjAr67EgeNPIKXRlNu3uQyN5ZexZYX7w0JoE/hMBQfIGzkBOPDOLVL3f68rAP
         OKcy07N5UjTxa2EYeRqTL2eztIgCXXp9ddbyGqqCj0Z7dRlscwCaRiGvyzNwbtoimjAa
         BLSMgIJ33cIEOvNiEsJO0rJEHIcVzhscgrIsdbzB+q3QOgGnUEdAPnbxN9W+rnTNji5W
         d96A==
X-Gm-Message-State: ABy/qLaTE34eeIpkWtD9ishfASH9EqqoYJlHezfIbYE/kH1hmiXCWNZb
	5wx6LkPuLqZAIhQzrebq/sVYPcBRaJoCU4mjhvE=
X-Google-Smtp-Source: APBJJlEZng270iBriRiEG6puqYtIB3DY0NbZGJeIPackdML33Y6Y0ZczEdrRBYiz3zj1TRwedohtdQ==
X-Received: by 2002:a05:6a00:856:b0:682:759c:644d with SMTP id q22-20020a056a00085600b00682759c644dmr8991570pfk.27.1688871411167;
        Sat, 08 Jul 2023 19:56:51 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00682ad247e5fsm5043421pfn.179.2023.07.08.19.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:56:50 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 05/10] bpf: Clear the probe_addr for uprobe
Date: Sun,  9 Jul 2023 02:56:25 +0000
Message-Id: <20230709025630.3735-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230709025630.3735-1-laoar.shao@gmail.com>
References: <20230709025630.3735-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

To avoid returning uninitialized or random values when querying the file
descriptor (fd) and accessing probe_addr, it is necessary to clear the
variable prior to its use.

Fixes: 41bdc4b40ed6 ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/trace_events.h | 3 ++-
 kernel/trace/bpf_trace.c     | 2 +-
 kernel/trace/trace_uprobe.c  | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 7c4a0b72334e..36de9ebec440 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -864,7 +864,8 @@ extern int  perf_uprobe_init(struct perf_event *event,
 extern void perf_uprobe_destroy(struct perf_event *event);
 extern int bpf_get_uprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **filename,
-			       u64 *probe_offset, bool perf_type_tracepoint);
+			       u64 *probe_offset, u64 *probe_addr,
+			       bool perf_type_tracepoint);
 #endif
 extern int  ftrace_profile_set_filter(struct perf_event *event, int event_id,
 				     char *filter_str);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index acb3d6dd7a77..31ec0e2853ec 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2384,7 +2384,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 #ifdef CONFIG_UPROBE_EVENTS
 		if (flags & TRACE_EVENT_FL_UPROBE)
 			err = bpf_get_uprobe_info(event, fd_type, buf,
-						  probe_offset,
+						  probe_offset, probe_addr,
 						  event->attr.type == PERF_TYPE_TRACEPOINT);
 #endif
 	}
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 8b92e34ff0c8..fd6c71450ba7 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1415,7 +1415,7 @@ static void uretprobe_perf_func(struct trace_uprobe *tu, unsigned long func,
 
 int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
 			const char **filename, u64 *probe_offset,
-			bool perf_type_tracepoint)
+			u64 *probe_addr, bool perf_type_tracepoint)
 {
 	const char *pevent = trace_event_name(event->tp_event);
 	const char *group = event->tp_event->class->system;
@@ -1432,6 +1432,7 @@ int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
 				    : BPF_FD_TYPE_UPROBE;
 	*filename = tu->filename;
 	*probe_offset = tu->offset;
+	*probe_addr = 0;
 	return 0;
 }
 #endif	/* CONFIG_PERF_EVENTS */
-- 
2.30.1 (Apple Git-130)


