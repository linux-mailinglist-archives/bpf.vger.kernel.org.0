Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7E6149006
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 22:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbgAXVRa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 16:17:30 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:54881 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387406AbgAXVRX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jan 2020 16:17:23 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A1D0164E4;
        Fri, 24 Jan 2020 16:17:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Jan 2020 16:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=PEBd4DWzODej2
        abhMWWNjOymRVCPIBXIrODdzvDwZZE=; b=R2iL/vqQNSOGzl3P/5AAm/eE09NUR
        v+6ry4PtqD6fdFfCXaQRqmA1mxSTnSE/CUW67dEvQQKxKab+5whdhtkFIICGNCUt
        NhQyyRJE5+UYeJSYVU2Zxr3vFqc3EopoqjI1lAOAqg4L/oK+bSzQj0YaHrcC46/c
        1zSANUdSuMXIoUYJiXtRkaF0zE0P9qmu6DDOJHRiC5RF6XNOqjyLxckSO97uFC0S
        Rwx+mm4CMbfZWUQPYed5qksT+cwU1DMvMYLndZoFO8lfAEQSaTJ4V/tvbW+lbDkd
        vz9m0x6ZsDZVepQc+0YJLKI2p4t0nQOVObMpwrw/E2Aq3OqepMk4iwQDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=PEBd4DWzODej2abhMWWNjOymRVCPIBXIrODdzvDwZZE=; b=WrHWdf37
        XL2+tWbzezoYky9x3HdZhZtfPu1Rd2mBBKyAn2K7LfIKEERPJfaEMEr69dPb9xW+
        69CMQUr/6PJCgYuOdMBkxxgsQ4+7ohWWdu99QQry5R7934e1DYmhN9SNye1hntyK
        6eIAxllr2DLfzPcdCuiln8kkaWA+FlNAqMKbkOs2HWzCdCweQMQ3rn6LfyR+kAg2
        zkKS6HcjI49TGE9M7jXJmpmiYPjoSkZBOoEmUSoj+ffCq26BTGWuxptLMwbWdjBu
        jOgpLWyn/CfHhs85e9kw2EKW4p6T0pDcJgWmJdIaIgghNezYn1aSEkgDzGvK+kWx
        z6aGZl4QfzbLAg==
X-ME-Sender: <xms:4l4rXr5lb-7hm-c_Slz-81trYXwC4gKZA2pA3lgDMIkQ9Te5mywzDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvdehgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduleelrddvtddurdeigedrgeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhu
    rdighiii
X-ME-Proxy: <xmx:4l4rXvTvcX16kIqArClPnasWBbFUqXCj5-I-PNBQ9MA5ccgwVJy0XA>
    <xmx:4l4rXucbdA-TYVxvD9mK5bPxxtyZZBlSQ4kTOEo-0PwhMln1w3TNcQ>
    <xmx:4l4rXvQB0bAlkHffrtnfAzTD7Fs1ZxFCdaMHC1P4W8_rMW2H2_eMlQ>
    <xmx:4l4rXp027stjtkZHuE9-SXdDy0B3MWoEYm6izPZFgvqZ1rjv9H-uFg>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (prnvpn05.thefacebook.com [199.201.64.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1338E3062B0D;
        Fri, 24 Jan 2020 16:17:20 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v4 bpf-next 2/3] tools/bpf: Sync uapi header bpf.h
Date:   Fri, 24 Jan 2020 13:17:04 -0800
Message-Id: <20200124211705.24759-3-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124211705.24759-1-dxu@dxuuu.xyz>
References: <20200124211705.24759-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync the header file in a separate commit to help with external sync.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/include/uapi/linux/bpf.h | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f1d74a2bd234..39bfba0091dc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2892,6 +2892,25 @@ union bpf_attr {
  *		Obtain the 64bit jiffies
  *	Return
  *		The 64 bit jiffies
+ *
+ * int bpf_perf_prog_read_branches(struct bpf_perf_event_data *ctx, void *buf, u32 buf_size, u64 flags)
+ *	Description
+ *		For an eBPF program attached to a perf event, retrieve the
+ *		branch records (struct perf_branch_entry) associated to *ctx*
+ *		and store it in	the buffer pointed by *buf* up to size
+ *		*buf_size* bytes.
+ *
+ *		The *flags* can be set to **BPF_F_GET_BR_SIZE** to instead
+ *		return the number of bytes required to store all the branch
+ *		entries. If this flag is set, *buf* may be NULL.
+ *	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
+ *
+ *		**-EINVAL** if arguments invalid or **buf_size** not a multiple
+ *		of sizeof(struct perf_branch_entry).
+ *
+ *		**-ENOENT** if architecture does not support branch records.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3012,7 +3031,8 @@ union bpf_attr {
 	FN(probe_read_kernel_str),	\
 	FN(tcp_send_ack),		\
 	FN(send_signal_thread),		\
-	FN(jiffies64),
+	FN(jiffies64),			\
+	FN(perf_prog_read_branches),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
@@ -3091,6 +3111,9 @@ enum bpf_func_id {
 /* BPF_FUNC_sk_storage_get flags */
 #define BPF_SK_STORAGE_GET_F_CREATE	(1ULL << 0)
 
+/* BPF_FUNC_perf_prog_read_branches flags. */
+#define BPF_F_GET_BR_SIZE		(1ULL << 0)
+
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
 	BPF_ADJ_ROOM_NET,
-- 
2.21.1

