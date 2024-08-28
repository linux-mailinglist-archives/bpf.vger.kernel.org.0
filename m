Return-Path: <bpf+bounces-38226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C3F961B59
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 03:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8991C23156
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 01:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694AD2556E;
	Wed, 28 Aug 2024 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="TTG69V07"
X-Original-To: bpf@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9791B28370;
	Wed, 28 Aug 2024 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724807936; cv=none; b=kJXzV6rY1mwsnKsWh1T9uoLKfXQKxFMpAimkaV5A9i7C1LVIAX/GmEqdmi8Tlmyqe9xP85vtdQcofDGdVqTJGlnsdSlyfMiBWMiVPp0GzH7f9lW4tfTlaWXcKYgxgXNLpLA/Bzv+Pt3NdmPRRgT52TTvIhCtipgkNcWTOigARZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724807936; c=relaxed/simple;
	bh=lh2Z2Ca2Vgzgi/5Xe+Y6pxgbSV8+ZEUvCJ733j2dvrU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=cUrSSudTUKo9YXdHF6A4dfk0Llxi4zIFUiQ+BeM9mZ2n3dOu272rmUnufLcaHDDU8BrdJNYoJpYDxrgz4u7hBBKc2rCvu03MIUJN4rLeelEJFATF9qsXFPdgBsfD25bdsS20Xq+HGhdHqsWAEGU2X4EVf7NW6lEMIai5tLNlwVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=TTG69V07; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1724807920;
	bh=VididwxujMY0a/lP1sce0+UlBHd78j55DgF2lpkP5ds=;
	h=From:To:Cc:Subject:Date;
	b=TTG69V07+ldKh9tsRlXVAVN61HrqygDqNlu0N57VNpZd3sVu9CvUKZHxA84iYpITZ
	 NsMf3XplILivq+MQqSbX1PVe/yIKXwqEOXGimwexgpZUiRUNanXXzgowJ/45ovOs8Z
	 Nyplvkb5H2FBGIX2vurxluo1tEbGhZxsTnO0TunY=
Received: from RT-NUC.. ([39.156.73.10])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 4A40CA45; Wed, 28 Aug 2024 09:18:36 +0800
X-QQ-mid: xmsmtpt1724807916t6z31wrob
Message-ID: <tencent_9F90905CD6FBE5B00AF1EBD9681A62990106@qq.com>
X-QQ-XMAILINFO: MzYTHVlhOHw4q/ygwSb9kA8Q/JOBUoyPheKqkwzexnxtDA/1Iuq1AXbaTw89ol
	 /8iKUh3wmh+h/0XPqeorQtR9vCYauMG8/igvtU+AVx9B9DsRyb3+h9/4gYqEFyf+bTDPK4LZvqVe
	 Q7NmFnsSOdAyyxvH5wzVGclSrwj6pHdJ0607uUsqTxzSIJrX3YlpTU+xxlCoYI1pps/xHvBqHds/
	 +m0gVie2jSOuGbOKUYladKUiinQuGEYeLRRs7bcOv+3TBt694Lhzhv8vjDvXVi1qIfJlzAD98emD
	 HRve1FvDpOoNwZ/NSMa3OnvGeizKQTgM9nyAj6P65fbgMfpwJ66tuu+uJuh7o49eZ1mhbtIKtuty
	 ocHOY+fQl3p+v+CwGhySeEA+Kj1NCrlW6VQ7e6ZVwlDL8Lgh0TUH0QATnoY7OpR2CIiC5xuZpT1N
	 x8IOFrQs4WjVlDIb+mhhZ9LnTetf9CwJHr8si36ryxnGF6gwp4mr99OOCbyRRVLgZRj4hWr0YGlX
	 qcxF0Gh2FCXe34pp0uRTgq+WxmwWlVhMeSJYwDdf8PHcqD1QoXUPDmFmRhWMn3KVPHDtWf+x/ttq
	 XW7uCLOyiHy7uMhv2OO4ejjD5j/473Vz2sZNiZt5zZyc4aavryzgt8npwH0fxkicfmV8x6xM+lcG
	 8pIB7JhpSYMY0pXh/pYn4+RF4XozvqFbNUWh0YrsSpZNWBZer0JA8b6izKGxSPtUiJqxveqQ3I76
	 zh+N5n2eizVkWxqYkSTkt+WJS8pBt0XmBwSmtkY+bysiIhWGEvZi7JwDGOzbh1JCzD9AwbG1TaUZ
	 momOmL5ItX0A1ZNR4BCI86LN0IFGKmUzmfbr71vuVNmuyanktc05bMmFmd1g4NuZxjzx0Zn/kuTT
	 Su5eRl7dFzrgbvzzMgucGuswNHvijxTnb2RGqQPPVH0WsWih4GXSO+vYBAVD2mbvF56KrgQLqybR
	 3knLrtV+rnFCBQZwOZ53KPUcbQxQ1xmFYXegrIS4U=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Rong Tao <rtoax@foxmail.com>
To: andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org
Cc: rongtao@cestc.cn,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] samples/bpf: tracex2: Replace kfree_skb from kprobe to tracepoint
Date: Wed, 28 Aug 2024 09:18:34 +0800
X-OQ-MSGID: <20240828011834.503297-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

In commit ba8de796baf4 ("net: introduce sk_skb_reason_drop function")
kfree_skb_reason() becomes an inline function and cannot be traced.
We can use the stable tracepoint kfree_skb to get 'ip'.

Link: https://github.com/torvalds/linux/commit/ba8de796baf4bdc03530774fb284fe3c97875566
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/bpf/tracex2.bpf.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/samples/bpf/tracex2.bpf.c b/samples/bpf/tracex2.bpf.c
index 0a5c75b367be..dc3d91b65a6f 100644
--- a/samples/bpf/tracex2.bpf.c
+++ b/samples/bpf/tracex2.bpf.c
@@ -17,20 +17,15 @@ struct {
 	__uint(max_entries, 1024);
 } my_map SEC(".maps");
 
-/* kprobe is NOT a stable ABI. If kernel internals change this bpf+kprobe
- * example will no longer be meaningful
- */
-SEC("kprobe/kfree_skb_reason")
-int bpf_prog2(struct pt_regs *ctx)
+SEC("tracepoint/skb/kfree_skb")
+int bpf_prog1(struct trace_event_raw_kfree_skb *ctx)
 {
 	long loc = 0;
 	long init_val = 1;
 	long *value;
 
-	/* read ip of kfree_skb_reason caller.
-	 * non-portable version of __builtin_return_address(0)
-	 */
-	BPF_KPROBE_READ_RET_IP(loc, ctx);
+	/* read ip */
+	loc = (long)ctx->location;
 
 	value = bpf_map_lookup_elem(&my_map, &loc);
 	if (value)
-- 
2.46.0


