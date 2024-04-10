Return-Path: <bpf+bounces-26357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9992A89E8FF
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CA31F261EB
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 04:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3A129CFE;
	Wed, 10 Apr 2024 04:35:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A720E3
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 04:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723751; cv=none; b=u+mlMYo1j2JZXf24sSnOfuCL6MEutMy3SQgMtcv2OigXjur/yCU96xlv0fUUiUf3fZsPlW/GsEILOjXkXYurIJf680rY7iUfE/66cm9xSRojoMHHzLIIDwoFmcTxuvyTrIsPRpR5JwTqf/clGMMDKvC6msHxzrVKL5p8hVsF+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723751; c=relaxed/simple;
	bh=AkpP+2geu9+L6Ma2+toNvMmxZywR0gF+6ZlruFmzTZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaGpXHsjGrwX5Edi5j+QWA3HpmybWuM7q+NdtK00ijNa0VRMgLvmw5NG/celQeTRBlTXNpgp2p3T3YK+d2xrJ6YOttHEgF9RI+IDheCLMkpx0PWUTZMgGzfYEw80AG3RqWIAUBL3nPqS4IIHdT27tJ1c6t5tVg4UFIjqeXRupXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 62EF92D7F27D; Tue,  9 Apr 2024 21:35:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 3/5] bpftool: Add link dump support for BPF_LINK_TYPE_SOCKMAP
Date: Tue,  9 Apr 2024 21:35:37 -0700
Message-ID: <20240410043537.3737928-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410043522.3736912-1-yonghong.song@linux.dev>
References: <20240410043522.3736912-1-yonghong.song@linux.dev>
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


