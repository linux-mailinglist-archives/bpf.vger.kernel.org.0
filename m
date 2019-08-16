Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E381590AFF
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2019 00:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfHPWcT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Aug 2019 18:32:19 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38807 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727854AbfHPWcS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Aug 2019 18:32:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 846A82050;
        Fri, 16 Aug 2019 18:32:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 16 Aug 2019 18:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=C/zyYjiT4fsHO
        Q1Isf9yVG5DdN4diUqRbFGQAlHIG50=; b=QtItbTs7c+hOk+jN883LnOmBmsnaD
        9yGq/Ns6ScYz1xXTMlsDMPehi/CMyBJ6KftA8Icv/CQSk/sZHrpFbmvSYgkcAkJ4
        7h6QbaXPsXPs78/IxFuBti0eaz0ddA9PnCh0umo1mZ9EGnP77lJmiQYk3B82a9Uk
        Jc4fZ1Et3SDf54uR13sHfjPQ+cxWw31QpLcbdLyXdcMMFA4Txbypmn6mTnL7vobs
        360LAq+Nx4oRG0RSKUiKHdyJ8EJv0TJtCdG/rT75KTVDStWI/EESXnA2ApDLt4Wb
        ofSYj67aWnyg1iuZHiOtZZyvLafiTY7blH+Vhrb0da4pLIYkaXjCrDq8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=C/zyYjiT4fsHOQ1Isf9yVG5DdN4diUqRbFGQAlHIG50=; b=VrF2OtFd
        +it9Ogj4lDi49bGcgYXPnXcqm5/rjIs9YhVkNFPHWwu4wW1uluMjSwnvHVd8eKV/
        3ZhSxHcOTOD2nNusmeby3J/xuC1EoRoS5DKgU5XR/7HLSYJes2HakOhW/5/AR5mm
        VO7NMFWO4v43YYiizIr/9WDModkQFWXO8/Mwb1CtB26JmEUK0zvEmePNdKUwymeP
        VQLuaDJ8O2LyQGg2KK31K+haBrG+eRlIooZfjIqRUE7ajwcx/3LuaQmEayFT3bRU
        z6L83ZWxo2D/K0W7pFFHnx+K34WB6KZedcA3mwGSe/BQej1DLEjBpf2sSqwE/Qnm
        EPswz+VEfztfxA==
X-ME-Sender: <xms:8S5XXf1oMCYnB8CrvbnFfbpjb04dpA0je_XNxVpKMQdMq36DCZZ-jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudefgedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:8S5XXdzWsyb357otKPrEOyMVqd7gQlzwDGMEZ0gPN01t4jjSPq6F5g>
    <xmx:8S5XXatpRjsAysTDfewLJz1Rj5yRghRPLAfelRVUKpNFrSJLy-jkmA>
    <xmx:8S5XXXRb31EKONQMGRA2c36vepEIEEifS81xdF6EYEabDCrE93GPRA>
    <xmx:8S5XXZLQEmDUatgVbuBG-01qOcH0JXZLVURl9xrY7w4e38EeIPm4CQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id A5B0F80062;
        Fri, 16 Aug 2019 18:32:15 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 1/4] tracing/probe: Add PERF_EVENT_IOC_QUERY_PROBE ioctl
Date:   Fri, 16 Aug 2019 15:31:46 -0700
Message-Id: <20190816223149.5714-2-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816223149.5714-1-dxu@dxuuu.xyz>
References: <20190816223149.5714-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's useful to know [uk]probe's nmissed and nhit stats. For example with
tracing tools, it's important to know when events may have been lost.
debugfs currently exposes a control file to get this information, but
it is not compatible with probes registered with the perf API.

While bpf programs may be able to manually count nhit, there is no way
to gather nmissed. In other words, it is currently not possible to
retrieve information about FD-based probes.

This patch adds a new ioctl that lets users query nmissed (as well as
nhit for completeness). We currently only add support for [uk]probes
but leave the possibility open for other probes like tracepoint.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/trace_events.h    | 12 ++++++++++++
 include/uapi/linux/perf_event.h | 23 +++++++++++++++++++++++
 kernel/events/core.c            | 20 ++++++++++++++++++++
 kernel/trace/trace_kprobe.c     | 24 ++++++++++++++++++++++++
 kernel/trace/trace_uprobe.c     | 24 ++++++++++++++++++++++++
 5 files changed, 103 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5150436783e8..61558f19696a 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -586,6 +586,12 @@ extern int bpf_get_kprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **symbol,
 			       u64 *probe_offset, u64 *probe_addr,
 			       bool perf_type_tracepoint);
+extern int perf_kprobe_event_query(struct perf_event *event, void __user *info);
+#else
+int perf_kprobe_event_query(struct perf_event *event, void __user *info)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
 extern int  perf_uprobe_init(struct perf_event *event,
@@ -594,6 +600,12 @@ extern void perf_uprobe_destroy(struct perf_event *event);
 extern int bpf_get_uprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **filename,
 			       u64 *probe_offset, bool perf_type_tracepoint);
+extern int perf_uprobe_event_query(struct perf_event *event, void __user *info);
+#else
+int perf_uprobe_event_query(struct perf_event *event, void __user *info)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 extern int  ftrace_profile_set_filter(struct perf_event *event, int event_id,
 				     char *filter_str);
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..8783d29a807a 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -447,6 +447,28 @@ struct perf_event_query_bpf {
 	__u32	ids[0];
 };
 
+/*
+ * Structure used by below PERF_EVENT_IOC_QUERY_PROBE command
+ * to query information about the probe attached to the perf
+ * event. Currently only supports [uk]probes.
+ */
+struct perf_event_query_probe {
+	/*
+	 * Size of structure for forward/backward compatibility
+	 */
+	__u64	size;
+	/*
+	 * Set by the kernel to indicate number of times this probe
+	 * was temporarily disabled
+	 */
+	__u64	nmissed;
+	/*
+	 * Set by the kernel to indicate number of times this probe
+	 * was hit
+	 */
+	__u64	nhit;
+};
+
 /*
  * Ioctls that can be done on a perf event fd:
  */
@@ -462,6 +484,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_QUERY_PROBE		_IOR('$', 12, struct perf_event_query_probe *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0463c1151bae..ed33d50511a3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5060,6 +5060,8 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg);
 static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
+static int perf_probe_event_query(struct perf_event *event,
+				    void __user *info);
 
 static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
 {
@@ -5143,6 +5145,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 		return perf_event_modify_attr(event,  &new_attr);
 	}
+#if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
+	case PERF_EVENT_IOC_QUERY_PROBE:
+		return perf_probe_event_query(event, (void __user *)arg);
+#endif
 	default:
 		return -ENOTTY;
 	}
@@ -8833,6 +8839,20 @@ static inline void perf_tp_register(void)
 #endif
 }
 
+static int perf_probe_event_query(struct perf_event *event,
+				    void __user *info)
+{
+#ifdef CONFIG_KPROBE_EVENTS
+	if (event->attr.type == perf_kprobe.type)
+		return perf_kprobe_event_query(event, (void __user *)info);
+#endif
+#ifdef CONFIG_UPROBE_EVENTS
+	if (event->attr.type == perf_uprobe.type)
+		return perf_uprobe_event_query(event, (void __user *)info);
+#endif
+	return -EINVAL;
+}
+
 static void perf_event_free_filter(struct perf_event *event)
 {
 	ftrace_profile_free_filter(event);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9d483ad9bb6c..89fbe3e97562 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -196,6 +196,30 @@ bool trace_kprobe_error_injectable(struct trace_event_call *call)
 	return within_error_injection_list(trace_kprobe_address(tk));
 }
 
+int perf_kprobe_event_query(struct perf_event *event, void __user *info)
+{
+	struct perf_event_query_probe __user *uquery = info;
+	struct perf_event_query_probe query = {};
+	struct trace_event_call *call = event->tp_event;
+	struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
+	u64 ncopy;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (copy_from_user(&query, uquery,
+			   offsetofend(struct perf_event_query_probe, size)))
+		return -EFAULT;
+
+	ncopy = min_t(u64, query.size, sizeof(query));
+	query.nhit = trace_kprobe_nhit(tk);
+	query.nmissed = tk->rp.kp.nmissed;
+
+	if (copy_to_user(uquery, &query, ncopy))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int register_kprobe_event(struct trace_kprobe *tk);
 static int unregister_kprobe_event(struct trace_kprobe *tk);
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 1ceedb9146b1..ecdf2bdb91a7 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1333,6 +1333,30 @@ static inline void init_trace_event_call(struct trace_uprobe *tu)
 	call->data = tu;
 }
 
+int perf_uprobe_event_query(struct perf_event *event, void __user *info)
+{
+	struct perf_event_query_probe __user *uquery = info;
+	struct perf_event_query_probe query = {};
+	struct trace_event_call *call = event->tp_event;
+	struct trace_uprobe *tu = (struct trace_uprobe *)call->data;
+	u64 ncopy;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (copy_from_user(&query, uquery,
+			   offsetofend(struct perf_event_query_probe, size)))
+		return -EFAULT;
+
+	ncopy = min_t(u64, query.size, sizeof(query));
+	query.nhit = tu->nhit;
+	query.nmissed = 0;
+
+	if (copy_to_user(uquery, &query, ncopy))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int register_uprobe_event(struct trace_uprobe *tu)
 {
 	init_trace_event_call(tu);
-- 
2.20.1

