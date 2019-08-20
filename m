Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29DEE96BB7
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfHTVtF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Aug 2019 17:49:05 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45801 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730430AbfHTVtF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Aug 2019 17:49:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 10C852D24;
        Tue, 20 Aug 2019 17:49:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 20 Aug 2019 17:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=z4oOh2xhhsCcC
        my3nCpcf0gr83yq5CvcoHQWJ/otDsI=; b=kP5EwCsV6T27tUgWYdhlESnp9q+j5
        kT9++Hy70YvWqWRh6EirRf0AEeVUKO7Vr+GMwG9683xnv5zWXbH7Qrm+aUMp/c+6
        Mkxs0dlnRO0uB+aAHtvWtfh3PsSxwwtxiLlvRWEksKEEWxbGu8WTDOfrh5YqymEU
        5Xw36ToJEe0fUfb/fwalkQleSEpICjofhdl9eMdJcJKy2j1frTgMuC4kxlDvr3Gd
        MZyU5fRoDbu54NbNte7JfZeZf653SG7GuSWsGAPGfOr+Dxdsfv0uM6tcvcwiEy9m
        3Ur7hnsE930rFw1U9WEsODkw81YZndKbvB70PqnImWEU0eUSnjIO3QpwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=z4oOh2xhhsCcCmy3nCpcf0gr83yq5CvcoHQWJ/otDsI=; b=WfM15Iqi
        RTL6PLoBQp1vEzQkU2BOzTG748uaN4yNlgzNDa9c1jN17XnI0lI/fAKGhd0yM2Ai
        DNqxIuQa/gMkhZ0LfmzsKwQMaz7A700ZpHRzNiiN9bEFDlZZ/N0qxK90BSaf/Xqb
        97eYFGWshZVctDWGoWPPR+NKcNEf8tZ7JdWgqzPqtBxTQd8WKqXTkjdC29X0U269
        jYOEJuOfvh3MzFRIljWqwq4ct/uZiR12CNCepDgQIxWaqIceE5aObsBl+aFZO/2i
        NCnlszeGoYRWSqkyX2xsq94zXjngzp3/ehu3u6Jms/qlZmzAcanDawGIVP82oOc5
        WChN8O+Wt+2jkQ==
X-ME-Sender: <xms:0GpcXSmKFFazcrA70L89f21EMD-p4MDuEMSMOPPzw52uJC9Li5MRJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegvddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddvnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgvrhfu
    ihiivgepud
X-ME-Proxy: <xmx:0GpcXRpl_CS7YSI_CPAoyynHboSeMJvWRfKYp4Gw-8-uk0WjSaNw5A>
    <xmx:0GpcXcAAiaz-lagiU5FgIIZ8lVmWmGFFbY06DCt-k6sMLPY0juB1gg>
    <xmx:0GpcXQYqxujDlJsGJmHjQSmW1_P_1XyIXoaUlKh8B2rSXtGsFyeHSQ>
    <xmx:0WpcXZ9vqGSqtcc8ve7BunsbGsSZ8Leno5kHQqcZlaR4ZhJt-GOHVw>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id 08CCB80064;
        Tue, 20 Aug 2019 17:49:02 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 3/4] tracing/probe: Sync perf_event.h to tools
Date:   Tue, 20 Aug 2019 14:48:18 -0700
Message-Id: <20190820214819.16154-4-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820214819.16154-1-dxu@dxuuu.xyz>
References: <20190820214819.16154-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/include/uapi/linux/perf_event.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..8783d29a807a 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
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
-- 
2.21.0

