Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC0A145D0C
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 21:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAVUX2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 15:23:28 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38577 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbgAVUX1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jan 2020 15:23:27 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4DC2A4504;
        Wed, 22 Jan 2020 15:23:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 22 Jan 2020 15:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=0lc3ggXWtNHW3
        XBXf+vL7fkfrAUrcoDfJDlx3i3Rwns=; b=0O6Ruah91lPy8YuirZBjhjkNnfa6s
        RSiAe0/UibO97cXFo8gKD1B/xYPPYCvstFdf29UdQUOcAoKywJ4UeblUrB+QPz2o
        Zt4c0UTI4PyGNPlnR1XeRSOMfrnOCDChTWWAjhyqq9p9OrrfiZyJWWCk2M4GrROI
        JUzSBJf2xqZyqi4mC+ndXaGU/3f04spF5e80AtOyvUgRU4xr/sPlQLC3qr5mA3yB
        bklYZZlBrcLOX1ChWTxhoyDs2a7RKN3HeEhTFR+Qe3XuMuGwtLNT3subXQzQb2pU
        6WtwTt5t9qr934HGRg7RiGqwdmZQUkoUHQkzJ897ZJ6Ih96Td6zgoNhxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=0lc3ggXWtNHW3XBXf+vL7fkfrAUrcoDfJDlx3i3Rwns=; b=T42WWgXW
        tSejbulwyquvE1x1OygjbzusjTzgFvYTWPDxY3vhVqXMR89vwHkW6a+xa2H8xJC3
        D+53HD+ge2t5mD1uu5rRoCDiZdje/vZwkfbxn9XpPyMEwNXrg2IjgLkEHW1um0cf
        z94UGUu3KiwM7iV1G1kOF1x6KEqb3qtHAgeLpc4yktt28ojHrC1iSoz6her/tcti
        iyn0LrvSqRgTjBF5zNDkHqFe5QAiDdFPHctA86R906IlREL/xRDbLls+rhWCwHfa
        XwPPpI7u4DKwxqCGEulJg7mbNylMIPyBgmCBPG56ZuopEaSVEgaoOkQURNhavF7v
        8eetuQd6rD9IGA==
X-ME-Sender: <xms:P68oXirCeYo5Ps1IeWLN30Jj_1-J5jLASOFAeJJjQlr4RrR3isdEBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvddtgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddvnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhu
    uhdrgiihii
X-ME-Proxy: <xmx:P68oXvF4chcYpDx7xcvktpNIr_c3DWg9nqB1idKyJ757YcF7Pb-CHA>
    <xmx:P68oXuWL_k9G4zLbB6xUeG-iRQj9QNi9rfYEvw_ffBs6NmwOZiNJ2Q>
    <xmx:P68oXlcDaADPJSfMtpio2g-dLiU86FQrBU7EgsvNxAdcjGMpyCDfPQ>
    <xmx:P68oXjJQHF1PXxMhpg4JD0DXfBAyrh__3O4N_IenHOqYFIU7oiaJLg>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2ED28328005D;
        Wed, 22 Jan 2020 15:23:24 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v2 bpf-next 2/3] tools/bpf: Sync uapi header bpf.h
Date:   Wed, 22 Jan 2020 12:22:19 -0800
Message-Id: <20200122202220.21335-3-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200122202220.21335-1-dxu@dxuuu.xyz>
References: <20200122202220.21335-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/include/uapi/linux/bpf.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 033d90a2282d..7350c5be6158 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2885,6 +2885,16 @@ union bpf_attr {
  *		**-EPERM** if no permission to send the *sig*.
  *
  *		**-EAGAIN** if bpf program can try again.
+ *
+ * int bpf_perf_prog_read_branches(struct bpf_perf_event_data *ctx, void *buf, u32 buf_size)
+ * 	Description
+ * 		For en eBPF program attached to a perf event, retrieve the
+ * 		branch records (struct perf_branch_entry) associated to *ctx*
+ * 		and store it in	the buffer pointed by *buf* up to size
+ * 		*buf_size* bytes.
+ * 	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3004,7 +3014,8 @@ union bpf_attr {
 	FN(probe_read_user_str),	\
 	FN(probe_read_kernel_str),	\
 	FN(tcp_send_ack),		\
-	FN(send_signal_thread),
+	FN(send_signal_thread),		\
+	FN(perf_prog_read_branches),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
-- 
2.21.1

