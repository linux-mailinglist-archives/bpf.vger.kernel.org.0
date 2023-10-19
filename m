Return-Path: <bpf+bounces-12743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603997D035F
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 22:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0927B1C20F12
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 20:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57F23DFF2;
	Thu, 19 Oct 2023 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LAyo/ZQ1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE9171BC;
	Thu, 19 Oct 2023 20:50:05 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A18F12F;
	Thu, 19 Oct 2023 13:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kkwRthnr+1YRIetHnvQDwZZrQydquuTkCDLZZb68n9w=; b=LAyo/ZQ1jDkQPQNCOLN2Uufl3i
	HKxQH+SigJtuFZWN78wA1h86lmQvVjmhUSD9S9kK8JCivJIcSctJYBLBJX4MRl40quXRXVOLZlLXA
	7BRiZ2Ppei1LmcR0qbbxaKQaS9Xfq2K51/T4a6rQYm6cTi698QFXv0QdSgU5vcn3uVZZlImY4zvqe
	7qmvE6KjgXpBCoonMSlI4LZdJmbYnQryoHb3tcfM30kMVwe9OdHuxU/697F2D8WwlmOBW9igjHrAG
	2ns6GhoKXSS10vjs3UGDt9c8zYPqam3c0E6aR1ZdXfCn00quiqrG0TKyjBiXq8RcoNimHiYWK7Lg9
	gszvDHIA==;
Received: from 21.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.21] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qtZxp-000Ne6-Fo; Thu, 19 Oct 2023 22:49:53 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	razor@blackwall.org,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	sdf@google.com,
	toke@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 4/7] bpftool: Implement link show support for netkit
Date: Thu, 19 Oct 2023 22:49:16 +0200
Message-Id: <20231019204919.4203-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231019204919.4203-1-daniel@iogearbox.net>
References: <20231019204919.4203-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27066/Thu Oct 19 09:45:47 2023)
X-Spam-Level: *

Add support to dump netkit link information to bpftool in similar way as
we have for XDP. The netkit link info only exposes the ifindex.

Below shows an example link dump output, and a cgroup link is included for
comparison, too:

  # bpftool link
  [...]
  10: cgroup  prog 2466
        cgroup_id 1  attach_type cgroup_inet6_post_bind
  [...]
  8: netkit  prog 35
        ifindex nk1(18)
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
    "type": "netkit",
    "prog_id": 61,
    "devname": "nk1",
    "ifindex": 21
  }
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/link.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 4b1407b05056..79c2d5357570 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -451,6 +451,9 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 		show_link_ifindex_json(info->tcx.ifindex, json_wtr);
 		show_link_attach_type_json(info->tcx.attach_type, json_wtr);
 		break;
+	case BPF_LINK_TYPE_NETKIT:
+		show_link_ifindex_json(info->netkit.ifindex, json_wtr);
+		break;
 	case BPF_LINK_TYPE_XDP:
 		show_link_ifindex_json(info->xdp.ifindex, json_wtr);
 		break;
@@ -791,6 +794,10 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 		show_link_ifindex_plain(info->tcx.ifindex);
 		show_link_attach_type_plain(info->tcx.attach_type);
 		break;
+	case BPF_LINK_TYPE_NETKIT:
+		printf("\n\t");
+		show_link_ifindex_plain(info->netkit.ifindex);
+		break;
 	case BPF_LINK_TYPE_XDP:
 		printf("\n\t");
 		show_link_ifindex_plain(info->xdp.ifindex);
-- 
2.34.1


