Return-Path: <bpf+bounces-26192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E29689C82F
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4134B1C2171E
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA6F140397;
	Mon,  8 Apr 2024 15:24:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FA13FD93
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589894; cv=none; b=M/BzJRsgKaPIEPvdMoilUeRqSPoFzUZtdI34/wBzsNGO028EIWbzQOB4PKKzz6tRlQuMiDK/JaqyQJ7lg8Xh/HbO+jpD0wjraGNcUasG2HgP6WocnWamd084Am0vhfm02mCYyb9ucnei4zLVu++Bsv+eGTzzJbUAC7h6lPO+M6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589894; c=relaxed/simple;
	bh=AkpP+2geu9+L6Ma2+toNvMmxZywR0gF+6ZlruFmzTZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+nxXk5yulb73l72notBq/RtoHtNnHJtMyB2SJH9tsf7wFhrbPkS/PJDH2CvRD2gbEdOA+OyIby1CWIl1QQUVGcfvh9I/jjtqnA94gapsfOPqRxyhVPIPBz55i8qRA4AtW5ltelJQSDA7cGC5W26Oh9BHnzF6f06bnWCaHNp9Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 3B21A2C7E02D; Mon,  8 Apr 2024 08:24:41 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next v6 3/5] bpftool: Add link dump support for BPF_LINK_TYPE_SOCKMAP
Date: Mon,  8 Apr 2024 08:24:41 -0700
Message-ID: <20240408152441.4161501-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408152425.4160829-1-yonghong.song@linux.dev>
References: <20240408152425.4160829-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An example output looks like:
  $ bpftool link
    1776: sk_skb  prog 49730
            map_id 0  attach_type sk_skb_verdict
            pids test_progs(8424)
    1777: sk_skb  prog 49755
            map_id 0  attach_type sk_skb_stream_verdict
            pids test_progs(8424)
    1778: sk_msg  prog 49770
            map_id 8208  attach_type sk_msg_verdict
            pids test_progs(8424)

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/bpf/bpftool/link.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index afde9d0c2ea1..5cd503b763d7 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -526,6 +526,10 @@ static int show_link_close_json(int fd, struct bpf_l=
ink_info *info)
 		show_link_ifindex_json(info->netkit.ifindex, json_wtr);
 		show_link_attach_type_json(info->netkit.attach_type, json_wtr);
 		break;
+	case BPF_LINK_TYPE_SOCKMAP:
+		jsonw_uint_field(json_wtr, "map_id", info->sockmap.map_id);
+		show_link_attach_type_json(info->sockmap.attach_type, json_wtr);
+		break;
 	case BPF_LINK_TYPE_XDP:
 		show_link_ifindex_json(info->xdp.ifindex, json_wtr);
 		break;
@@ -915,6 +919,11 @@ static int show_link_close_plain(int fd, struct bpf_=
link_info *info)
 		show_link_ifindex_plain(info->netkit.ifindex);
 		show_link_attach_type_plain(info->netkit.attach_type);
 		break;
+	case BPF_LINK_TYPE_SOCKMAP:
+		printf("\n\t");
+		printf("map_id %u  ", info->sockmap.map_id);
+		show_link_attach_type_plain(info->sockmap.attach_type);
+		break;
 	case BPF_LINK_TYPE_XDP:
 		printf("\n\t");
 		show_link_ifindex_plain(info->xdp.ifindex);
--=20
2.43.0


