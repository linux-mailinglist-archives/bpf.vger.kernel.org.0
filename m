Return-Path: <bpf+bounces-26090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A489ABE0
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 18:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A600F282195
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1203C092;
	Sat,  6 Apr 2024 16:04:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8C3BBF3
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419460; cv=none; b=hvXWhXabWcLgtgZEf2OO1q4yYBhT4+wrzllt4zTS+ply6JQjUsSRBdWnGO8EWDgUCpu4NYh+Sknc58jJXtzdrIpC+GHpyYnryxi+Vmy5J8z5/PPcRA0PrON54os/ORYtbnfULnVbaa22u7cfNOW+yEmqix04VCw7TRnMsQlsez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419460; c=relaxed/simple;
	bh=AkpP+2geu9+L6Ma2+toNvMmxZywR0gF+6ZlruFmzTZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhwoBGdK3LPOOEMTw9AEwtXjphzDlgadvoKdtntst1G5G3L0wcQo2rrTHIrgA87rmKkOztON0VZr83cqvKgmCmouyX/gAtrvJ3Bn/EqBJQebjfoX8GWK0/6fV+sdJTdXfrkoEg4IQrDDKe69hBlirUJqUK/hH2ZlHAltfURlnOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 51F752B551C7; Sat,  6 Apr 2024 09:04:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 3/5] bpftool: Add link dump support for BPF_LINK_TYPE_SOCKMAP
Date: Sat,  6 Apr 2024 09:04:14 -0700
Message-ID: <20240406160414.178525-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406160359.176498-1-yonghong.song@linux.dev>
References: <20240406160359.176498-1-yonghong.song@linux.dev>
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


