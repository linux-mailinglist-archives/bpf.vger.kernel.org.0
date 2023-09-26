Return-Path: <bpf+bounces-10848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5537E7AE562
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 07:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8F7AC2822FF
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 05:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEEF5681;
	Tue, 26 Sep 2023 05:59:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73534C69;
	Tue, 26 Sep 2023 05:59:41 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8AFD6;
	Mon, 25 Sep 2023 22:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=osrCLj7JttB/smSPl6evBBfjjxG3IBKgfHWgGfL/n/o=; b=WSEqr+LDiPxnMGAkBcueXwqn9G
	7tut87Nn3TarNvjZdhIBiH2jJ5CEAfykFiS4CgyQ0xmoK5Bu+RXl0372xvVxD/KjAfGaOyqe2fpt0
	JBCTP+LS/8C/UAD6krI7A+j+kZfstu8Uu6CiKEP/dI4MI9I4tjg0Ec5txNZp27kjlUO5u9HKFfDs9
	HYOI8Be+WvD1i+EzH0CB33VmCJICYxEc+mABFIBYsYRdSSQ+1ieYVtZ4IK3qTh0HnkdSIRsTXr5o3
	CAGIl/HmuVzpC4ADQbQZuw30zn6H2NrQ/RrPzbzRuROs7l5335gN47mwWETEapX6UBjHFVG83KcLk
	n9VSeVMw==;
Received: from mob-194-230-148-205.cgn.sunrise.net ([194.230.148.205] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ql16g-0006nz-3J; Tue, 26 Sep 2023 07:59:38 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	martin.lau@kernel.org,
	razor@blackwall.org,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 5/8] bpftool: Implement link show support for meta
Date: Tue, 26 Sep 2023 07:59:10 +0200
Message-Id: <20230926055913.9859-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230926055913.9859-1-daniel@iogearbox.net>
References: <20230926055913.9859-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27042/Mon Sep 25 09:37:53 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support to dump meta link information to bpftool in similar way
as we have for XDP. The meta link info only exposes the ifindex.

Below shows an example link dump output, and a cgroup link is included
for comparison, too:

  # bpftool link
  [...]
  10: cgroup  prog 2466
        cgroup_id 1  attach_type cgroup_inet6_post_bind
  [...]
  8: meta  prog 35
        ifindex meta1(18)
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
    "id": 12,
    "type": "meta",
    "prog_id": 61,
    "devname": "meta1",
    "ifindex": 21
  }
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/bpf/bpftool/link.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 2e5c231e08ac..57fd3f1a7330 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -449,6 +449,9 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 		show_link_ifindex_json(info->tcx.ifindex, json_wtr);
 		show_link_attach_type_json(info->tcx.attach_type, json_wtr);
 		break;
+	case BPF_LINK_TYPE_META:
+		show_link_ifindex_json(info->meta.ifindex, json_wtr);
+		break;
 	case BPF_LINK_TYPE_XDP:
 		show_link_ifindex_json(info->xdp.ifindex, json_wtr);
 		break;
@@ -785,6 +788,10 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 		show_link_ifindex_plain(info->tcx.ifindex);
 		show_link_attach_type_plain(info->tcx.attach_type);
 		break;
+	case BPF_LINK_TYPE_META:
+		printf("\n\t");
+		show_link_ifindex_plain(info->meta.ifindex);
+		break;
 	case BPF_LINK_TYPE_XDP:
 		printf("\n\t");
 		show_link_ifindex_plain(info->xdp.ifindex);
-- 
2.34.1


