Return-Path: <bpf+bounces-45799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120639DB19B
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC570282394
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4402F77F10;
	Thu, 28 Nov 2024 02:56:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3F134BD;
	Thu, 28 Nov 2024 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732762571; cv=none; b=OJqO19LJ75CnRGbA1ubdsEqXidZ/jmYanjZmfe4yjL2EIa59A2QCZyEdKXfZOoYUNHEER2hjJqZF9agjRtd75MCSgbUjsVxSYYuY/XutWa7+QoKTxw9u8OZPRqbU+uU70xjfYLVbIAq0m+NQ2IqkstYqrwPM463QbhxQCvFw5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732762571; c=relaxed/simple;
	bh=kyP5lzeTJCZyGzlj3gXovW2C+XAsywNbQxNOwOPCF24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cTjK8NkxEOwz2/iUpGqZ6dsPByjEWVWPtIVGWqoT1IHJsLU/pvW3Hi7RQcWKYyuQoFAJbRc068FBkQuyYuWx7Z64wfXU6MLR0f9Vhw/wxsYTQ+DE+ESpjSqtprMQ81YoO1L4zMkBrqs4DL/j58Mv34Ihz5n8hOpZJcLrTWgsLqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86747dbbfa3f-d0a8b;
	Thu, 28 Nov 2024 10:55:59 +0800 (CST)
X-RM-TRANSID:2ee86747dbbfa3f-d0a8b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46747dbbe80b-86af0;
	Thu, 28 Nov 2024 10:55:59 +0800 (CST)
X-RM-TRANSID:2ee46747dbbe80b-86af0
From: liujing <liujing@cmss.chinamobile.com>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] tools/bpf: bpftool:Fix the wrong format specifier
Date: Thu, 28 Nov 2024 10:55:51 +0800
Message-Id: <20241128025551.2868-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The output format of unsigned int should be %u, and the output
format of int should be %d, so fix it.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/tools/bpf/bpftool/netlink_dumper.c b/tools/bpf/bpftool/netlink_dumper.c
index 5f65140b003b..97e1e1dbc842 100644
--- a/tools/bpf/bpftool/netlink_dumper.c
+++ b/tools/bpf/bpftool/netlink_dumper.c
@@ -45,7 +45,7 @@ static int do_xdp_dump_one(struct nlattr *attr, unsigned int ifindex,
 	NET_START_OBJECT;
 	if (name)
 		NET_DUMP_STR("devname", "%s", name);
-	NET_DUMP_UINT("ifindex", "(%d)", ifindex);
+	NET_DUMP_UINT("ifindex", "(%u)", ifindex);
 
 	if (mode == XDP_ATTACHED_MULTI) {
 		if (json_output) {
@@ -168,7 +168,7 @@ int do_filter_dump(struct tcmsg *info, struct nlattr **tb, const char *kind,
 		NET_START_OBJECT;
 		if (devname[0] != '\0')
 			NET_DUMP_STR("devname", "%s", devname);
-		NET_DUMP_UINT("ifindex", "(%u)", ifindex);
+		NET_DUMP_UINT("ifindex", "(%d)", ifindex);
 		NET_DUMP_STR("kind", " %s", kind);
 		ret = do_bpf_filter_dump(tb[TCA_OPTIONS]);
 		NET_END_OBJECT_FINAL;
-- 
2.27.0




