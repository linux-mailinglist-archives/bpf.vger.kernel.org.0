Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FAB83DE9
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 01:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfHFXlv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Aug 2019 19:41:51 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:42041 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbfHFXlv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Aug 2019 19:41:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2761F4F1;
        Tue,  6 Aug 2019 19:41:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 06 Aug 2019 19:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=3PD8LjjY4z1Q5sBLd4V1CUpB4A
        f39pLqL65N/4yzIv0=; b=koEHB+YYA29ZIS13fcaIwp6EaZAqUREoukUUUzo4WE
        o1mTjMJmYx6Oeb2Ph6Y+hrM+9go9SGEu00rQmS6MXX8i+s/A1mfCeMMBOWL4kefY
        dum2zho+6PJBAwswLuRKm4Cj5DgVw2DARfgSvxjwRLY3MjuquOSFJBxjNZruRJ8m
        aR6UPbAB0Fmhu8hgz3t7+p4KwMaD20703uAkM0IGMtVHY6MRKZz8QaiOY6ziSx24
        7FtDBMMbIwOjuOQgKEgOz9j1OAoaCT/StOQLgeg1AfYZugQu9YiEIK6Wm2J144Zv
        PvrwFltNXD+3hkZi8whoGfhL6nHgplGsaZXnibGJiHuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3PD8LjjY4z1Q5sBLd
        4V1CUpB4Af39pLqL65N/4yzIv0=; b=yB1Bp61BFQPnxUuxwxLSniDNkyHgIAYDp
        EOzsyaW6t40tyKifvQJInDqUJQq/pEcBrBcHs4F6pmmVlVLmVEvp4rJqb/cRnC/5
        6ysf4bLd7Ag8hWWKPf9oBsUf0lAoNToNe2KwlroPEtyR/JGAEAfzkHr2tKwOFTOV
        2+kYTYSyi2INmi5W2rL2lNmO1z2hG/1iL20kLRiJAor4BsDWp5Te6ULT8otwQPC7
        TTmrlZOVbCBi5oYaGUdK/K30ANp1EbO6b80Fqt3M1OZh3+L/0dCkExOtGeki0w8y
        7sulsasBx/lhCevo4bmXyhqlLcJAl8O30iM6xzjIhatAI5vAI/E3A==
X-ME-Sender: <xms:PRBKXZaukM2PsuSTsON3wAjeTwmzAJRgtdfWhHwHmodSbqc00UJe8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduuddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgvrhfu
    ihiivgeptd
X-ME-Proxy: <xmx:PRBKXdXXSR0U2w-Rq-7hnXYWOxzI4-dlZcgNLE6ew-r1D3fSt0eQ-A>
    <xmx:PRBKXXlhn_Nuzk_RQfpuMWHLnPE2zX1qeGodu-hCIw8W-V_SFuJu8g>
    <xmx:PRBKXQDFOd4h_Ij71PX-H9DGivlOT7LjrcMI3ObJGqQs5ioAaItHTQ>
    <xmx:PRBKXXnYZ2SZq6Rq3zm2BvbfxSNCnpllLM-LpVfrv8SZ5std_Y0UfQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4F0038005A;
        Tue,  6 Aug 2019 19:41:48 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] tracing/kprobe: Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
Date:   Tue,  6 Aug 2019 16:41:31 -0700
Message-Id: <20190806234131.5655-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's useful to know kprobe's nmissed and nhit stats. For example with
tracing tools, it's important to know when events may have been lost.
There is currently no way to get that information from the perf API.
This patch adds a new ioctl that lets users query this information.
---
 include/linux/trace_events.h    |  6 ++++++
 include/uapi/linux/perf_event.h | 23 +++++++++++++++++++++++
 kernel/events/core.c            | 11 +++++++++++
 kernel/trace/trace_kprobe.c     | 25 +++++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5150436783e8..28faf115e0b8 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -586,6 +586,12 @@ extern int bpf_get_kprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **symbol,
 			       u64 *probe_offset, u64 *probe_addr,
 			       bool perf_type_tracepoint);
+extern int perf_event_query_kprobe(struct perf_event *event, void __user *info);
+#else
+int perf_event_query_kprobe(struct perf_event *event, void __user *info)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
 extern int  perf_uprobe_init(struct perf_event *event,
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..4a5e18606baf 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -447,6 +447,28 @@ struct perf_event_query_bpf {
 	__u32	ids[0];
 };
 
+/*
+ * Structure used by below PERF_EVENT_IOC_QUERY_KPROE command
+ * to query information about the kprobe attached to the perf
+ * event.
+ */
+struct perf_event_query_kprobe {
+       /*
+        * Size of structure for forward/backward compatibility
+        */
+       __u32   size;
+       /*
+        * Set by the kernel to indicate number of times this kprobe
+        * was temporarily disabled
+        */
+       __u64   nmissed;
+       /*
+        * Set by the kernel to indicate number of times this kprobe
+        * was hit
+        */
+       __u64   nhit;
+};
+
 /*
  * Ioctls that can be done on a perf event fd:
  */
@@ -462,6 +484,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_QUERY_KPROBE		_IOWR('$', 12, struct perf_event_query_kprobe *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 026a14541a38..d61c3ac5da4f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5061,6 +5061,10 @@ static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
 
+#ifdef CONFIG_KPROBE_EVENTS
+static struct pmu perf_kprobe;
+#endif /* CONFIG_KPROBE_EVENTS */
+
 static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
 {
 	void (*func)(struct perf_event *);
@@ -5143,6 +5147,13 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 		return perf_event_modify_attr(event,  &new_attr);
 	}
+#ifdef CONFIG_KPROBE_EVENTS
+        case PERF_EVENT_IOC_QUERY_KPROBE:
+		if (event->attr.type != perf_kprobe.type)
+			return -EINVAL;
+
+                return perf_event_query_kprobe(event, (void __user *)arg);
+#endif /* CONFIG_KPROBE_EVENTS */
 	default:
 		return -ENOTTY;
 	}
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9d483ad9bb6c..5449182f3056 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -196,6 +196,31 @@ bool trace_kprobe_error_injectable(struct trace_event_call *call)
 	return within_error_injection_list(trace_kprobe_address(tk));
 }
 
+int perf_event_query_kprobe(struct perf_event *event, void __user *info)
+{
+	struct perf_event_query_kprobe __user *uquery = info;
+	struct perf_event_query_kprobe query = {};
+	struct trace_event_call *call = event->tp_event;
+	struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
+	u64 nmissed, nhit;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (copy_from_user(&query, uquery, sizeof(query)))
+		return -EFAULT;
+	if (query.size != sizeof(query))
+		return -EINVAL;
+
+	nhit = trace_kprobe_nhit(tk);
+	nmissed = tk->rp.kp.nmissed;
+
+	if (copy_to_user(&uquery->nmissed, &nmissed, sizeof(nmissed)) ||
+	    copy_to_user(&uquery->nhit, &nhit, sizeof(nhit)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int register_kprobe_event(struct trace_kprobe *tk);
 static int unregister_kprobe_event(struct trace_kprobe *tk);
 
-- 
2.20.1

