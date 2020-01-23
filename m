Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 845DB14731B
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 22:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgAWVXt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 16:23:49 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44453 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728765AbgAWVXl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 16:23:41 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9B82A5F91;
        Thu, 23 Jan 2020 16:23:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 Jan 2020 16:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=i2TbaaLRbCuDS
        5CihmwELlkML+zGJC6EN5XnNvRO3WY=; b=BmcQl186+HHoH0Gc6tj0f2bHqulnA
        o13G5rDPgIg8yUEvyinOXBnrnQktIHKXMU9vzaujM6BeWpG/BghQv2bPl+L4VoM2
        eFLg3sFHrdRdFYcmLiIaF8s9RmJjrl0DfmgI/hqnn+AZQWphvPoPnQtVR8a2/Z8O
        Wf899bJkjtH8oeFkv67N9U2CSgYzUE8lQZ2TVs9buT4o9OFYk/17bw4A17ybKBkp
        bJju5rZgr8vLteVBBCjpijU9nBw/G/XA/wHX/MF1XZwsKxaBZXxn3PIRFfpOBMYN
        etLuSXpS3IJ/vrFVXx1kxJtQX7bVFFJpQs8J/0/3US+vOEnN+27ncaAuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=i2TbaaLRbCuDS5CihmwELlkML+zGJC6EN5XnNvRO3WY=; b=NYWc3pN9
        GCDQoQoAiu5AwTwk2oN3HZ/yuhYEOHs3bTUKDQ5TeWAWoiKU1BBBdE0mWL0to4o8
        2c3y6eBNm6D3XYouCYfj/Hh3NeevNSIXI8k++MTAwvhAizZ8mPcWeGwr0RGASW5W
        vuBEoWp/QuGnYRDUn/MYoBSq0QMGf0XTpbYx3CleN1dWqEbiGCrRbuClzfyZtNFD
        eS60/jzZPTI8dSQqeDUXUPcYomUVd5g7rgcyjwn2o3YV/UkaehAffyYp0cT103/z
        PydzRQndcbc+8npMt9iIUA393FX1ghoofKHH6Gt3pQZAxbHISz1DRNMUXAxcnDeg
        HBAOcUKglln/Tg==
X-ME-Sender: <xms:3A4qXmLhrsyAx6N-_869faNiwUxAXs6OFaNhwKMH1zwkkVT1y4L_Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvddvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduleelrddvtddurdeigedrudefheenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihu
    uhhurdighiii
X-ME-Proxy: <xmx:3A4qXib4cKgwBEPTaPhHeSWSrgrgvzGS8tMXrk6YzUNMHUEnah5BkQ>
    <xmx:3A4qXhu5vq9tgHSe4IeW71aDg-irovLu4hvVVvGZHBrSDgS1q4Ccwg>
    <xmx:3A4qXvsbZky1OzTelpkwP1KE1cweoMztidZJu5I6BgQtkBICLSgzsQ>
    <xmx:3A4qXna1eMZAb76yBrVBxi0nZ_4UuZonF57hubU5lIcNvuXduY5yHw>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.135])
        by mail.messagingengine.com (Postfix) with ESMTPA id 301283060AA8;
        Thu, 23 Jan 2020 16:23:39 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v3 bpf-next 2/3] tools/bpf: Sync uapi header bpf.h
Date:   Thu, 23 Jan 2020 13:23:11 -0800
Message-Id: <20200123212312.3963-3-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200123212312.3963-1-dxu@dxuuu.xyz>
References: <20200123212312.3963-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/include/uapi/linux/bpf.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f1d74a2bd234..50c580c8a201 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2892,6 +2892,18 @@ union bpf_attr {
  *		Obtain the 64bit jiffies
  *	Return
  *		The 64 bit jiffies
+ *
+ * int bpf_perf_prog_read_branches(struct bpf_perf_event_data *ctx, void *buf, u32 buf_size)
+ *	Description
+ *		For en eBPF program attached to a perf event, retrieve the
+ *		branch records (struct perf_branch_entry) associated to *ctx*
+ *		and store it in	the buffer pointed by *buf* up to size
+ *		*buf_size* bytes.
+ *
+ *		Any unused parts of *buf* will be filled with zeros.
+ *	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3012,7 +3024,8 @@ union bpf_attr {
 	FN(probe_read_kernel_str),	\
 	FN(tcp_send_ack),		\
 	FN(send_signal_thread),		\
-	FN(jiffies64),
+	FN(jiffies64),			\
+	FN(perf_prog_read_branches),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
-- 
2.21.1

