Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF290AFC
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2019 00:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfHPWcW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Aug 2019 18:32:22 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:42903 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727898AbfHPWcV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Aug 2019 18:32:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C9A75209B;
        Fri, 16 Aug 2019 18:32:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 16 Aug 2019 18:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=jMcpWT3BOBrXz
        HHXvcq6IicYWXcTtdD131rXZuAKD/k=; b=sBi2zD9kXPOlU5CRSdZQOqZG92xVV
        udytZmUiUas0dHf3S5eUTR7aD5s57b6eTKMVuxt/MuIAhDG9ii0sXYsnMMz/ZdhA
        W0l5YEPIKgtIuHZjEtJe+d34fxltyO11agaxXwomPISjwh5gXFiOq/p2ktcRheOi
        RBgSSnJf6XbpeRxKdB8U0Gz9XabpsO7MduiZY+X7+ynSsYwCcFDDIJRmZxBXvYGO
        zIEgZrF3RmzZT0gB29jBcpg7QLRNEhCcuRM+09IOeYVeGHMy8s/xbA/rCSoX9bFo
        ZTFrjnVf5Gpon9m+NZBP/cg/cEYfjuUXrS5DHKH4GJWwICGeZLeW/2ThA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=jMcpWT3BOBrXzHHXvcq6IicYWXcTtdD131rXZuAKD/k=; b=YON8VEx/
        txy7eXFH0RSC5B7+xW2N7rwgULBKKA/0iCMnuq+rQZ49KcHRoMa6vFwm2gZVVm4i
        0IiDJBwOt8oQa9XUl3cSaPB039qkTrELOlRCABJf8AOZ3EI+fplO/P0VAA09uL0E
        qy8GimGdXXRtAhG2OjMQKJyiydYDEBQiCwvVZ/2YkOcADaf8sXGObsoB6Z9Q1oPv
        tXwNK3jP4jmRjyjtx1RJV09uguCdPc9/7Nk41OuROBwpV3zkWfP8U5y9QRl2BXZo
        dOgKMUzbXJhHwlVOCPTIdnJ5xB6xxlvoJHKE7/w+QBlOOhZdgwT8oREJv072R/PA
        yUSqe5892qAwqw==
X-ME-Sender: <xms:9C5XXUTuzh1EeEIiihmBmlgSq0bAFVhrYUNjENG3WwP_g4kK7LCOkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudefgedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:9C5XXa2gTl_9e2Wyeutdixh1P1_mp3_gxuASicbheTGQudHS0VMNVg>
    <xmx:9C5XXUzu8lDPdop7hlrNmTI1n1snXrPM_Vz7vCOXBZ9zulS0sIJIKA>
    <xmx:9C5XXVHORbKPtfD7kBHGedZQTj7T1d-4_8NJ_fVdIUKidRMQPci1gg>
    <xmx:9C5XXZlOo9xSxxZjVtQAA1MdtPxnTUSZ37Gf63T9F66gQwkxsazCqw>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id E8FD080061;
        Fri, 16 Aug 2019 18:32:18 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 3/4] tracing/probe: Sync perf_event.h to tools
Date:   Fri, 16 Aug 2019 15:31:48 -0700
Message-Id: <20190816223149.5714-4-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816223149.5714-1-dxu@dxuuu.xyz>
References: <20190816223149.5714-1-dxu@dxuuu.xyz>
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
2.20.1

