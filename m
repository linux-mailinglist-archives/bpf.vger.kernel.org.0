Return-Path: <bpf+bounces-7885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F93F77DDF8
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 11:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C1E281314
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09568FC00;
	Wed, 16 Aug 2023 09:57:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B0FBFA
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 09:57:03 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE6CC1
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZowGW7ZPgsM7QFjIzJsn3nA6OP05iBsQDKTJMtJl0Z8=; b=T19FqtEpF/N0Ckkp0yVkMTJP27
	iWdzdCVIlC55DJA6jB8Awwd/6GHGDTJDm+b8hXrYXDvsaDLQ85kXU0qmFu20p3d/dk9DnFnrF+ZIO
	ksXMPErv04z4W5OeL2DABxoHbGitjvjVa/x2dJqquTqoVjd+kkAdfOVtXJf5YE/gpQ62PXIcWbKY+
	WKDtE+eIg1N7WyI4XphoDXnJ38uY5MgYSf/CA/f0jbI7/Djh2khBxiPLAjY3WeTZ6t2BNE3SLqODp
	B6g9VU/sWIE6EOMYYHZ/5My7S705e6QSGfmXjAlIyXueovGYhilEofb53hG1e/+91Yv7dNK1VOE2G
	q/QqXJsQ==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWDGq-0009a9-Dd; Wed, 16 Aug 2023 11:56:55 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 2/2] bpftool: Implement link show support for xdp
Date: Wed, 16 Aug 2023 11:56:51 +0200
Message-Id: <20230816095651.10014-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230816095651.10014-1-daniel@iogearbox.net>
References: <20230816095651.10014-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27002/Wed Aug 16 09:38:26 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support to dump XDP link information to bpftool. This reuses the
recently added show_link_ifindex_{plain,json}(). The XDP link info only
exposes the ifindex.

Below shows an example link dump output, and a cgroup link is included
for comparison, too:

  # bpftool link
  [...]
  10: cgroup  prog 2466
        cgroup_id 1  attach_type cgroup_inet6_post_bind
  [...]
  16: xdp  prog 2477
        ifindex enp5s0(3)
  [...]

Equivalent json output:

  # bpftool link --json
  [...]
  {
    "id": 10,
    "type": "cgroup",
    "prog_id": 2466,
    "cgroup_id": 1,
    "attach_type": "cgroup_inet6_post_bind"
  },
  [...]
  {
    "id": 16,
    "type": "xdp",
    "prog_id": 2477,
    "devname": "enp5s0",
    "ifindex": 3
  }
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/link.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index a3774594f154..0b214f6ab5c8 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -449,6 +449,9 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 		show_link_ifindex_json(info->tcx.ifindex, json_wtr);
 		show_link_attach_type_json(info->tcx.attach_type, json_wtr);
 		break;
+	case BPF_LINK_TYPE_XDP:
+		show_link_ifindex_json(info->xdp.ifindex, json_wtr);
+		break;
 	case BPF_LINK_TYPE_STRUCT_OPS:
 		jsonw_uint_field(json_wtr, "map_id",
 				 info->struct_ops.map_id);
@@ -782,6 +785,10 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 		show_link_ifindex_plain(info->tcx.ifindex);
 		show_link_attach_type_plain(info->tcx.attach_type);
 		break;
+	case BPF_LINK_TYPE_XDP:
+		printf("\n\t");
+		show_link_ifindex_plain(info->xdp.ifindex);
+		break;
 	case BPF_LINK_TYPE_KPROBE_MULTI:
 		show_kprobe_multi_plain(info);
 		break;
-- 
2.34.1


