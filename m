Return-Path: <bpf+bounces-13168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869047D5D79
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74991C20D49
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 21:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF57C4736B;
	Tue, 24 Oct 2023 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QmrbJtNb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CCD3FB3E;
	Tue, 24 Oct 2023 21:49:22 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2E41B3;
	Tue, 24 Oct 2023 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sYJ7b36Yr9Bfh7zrDw5SMwC10mjSg/J/pt8eqO+oMYs=; b=QmrbJtNbFAU93Sn4SAob2MHuYJ
	zfO/JwxK3Ne9IhMASl+h99pra2HvSFPf4mhKTtHvnp4cxesW4GaOljQF/3p5UbmrWJ8sLahY4mDOQ
	7zQ4VGMgAEEq+Y+/CcX9LlNq6gMbX49h5Zernx3U9qHOoqqrTNMvJJeLnnsBWJmnXeH0NJj6z5ldK
	6oJ/FNBxxHNaKv4H88EnQbWTGLPIU96SKs3aBtTMj+WTzH/GWaTblnRmbpNzkemPWaePGrERNrNit
	tXWAsT2O6JUa5LMmyeVkHRp+NpYn9iYXVtvsdEReHb1m4LHI0s2seH+bjwIgCyLq6eaEu82bPDM0G
	KxOFUb0g==;
Received: from 40.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.40] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvPGz-0001lG-T4; Tue, 24 Oct 2023 23:49:13 +0200
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
	kuba@kernel.org,
	andrew@lunn.ch,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v4 4/7] bpftool: Implement link show support for netkit
Date: Tue, 24 Oct 2023 23:49:01 +0200
Message-Id: <20231024214904.29825-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231024214904.29825-1-daniel@iogearbox.net>
References: <20231024214904.29825-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27071/Tue Oct 24 09:43:50 2023)
X-Spam-Level: *

Add support to dump netkit link information to bpftool in similar way as
we have for XDP. The netkit link info only exposes the ifindex and the
attach_type.

Below shows an example link dump output, and a cgroup link is included for
comparison, too:

  # bpftool link
  [...]
  10: cgroup  prog 2466
        cgroup_id 1  attach_type cgroup_inet6_post_bind
  [...]
  8: netkit  prog 35
        ifindex nk1(18)  attach_type netkit_primary
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
    "ifindex": 21,
    "attach_type": "netkit_primary"
  }
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/link.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 4b1407b05056..a1528cde81ab 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -451,6 +451,10 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 		show_link_ifindex_json(info->tcx.ifindex, json_wtr);
 		show_link_attach_type_json(info->tcx.attach_type, json_wtr);
 		break;
+	case BPF_LINK_TYPE_NETKIT:
+		show_link_ifindex_json(info->netkit.ifindex, json_wtr);
+		show_link_attach_type_json(info->netkit.attach_type, json_wtr);
+		break;
 	case BPF_LINK_TYPE_XDP:
 		show_link_ifindex_json(info->xdp.ifindex, json_wtr);
 		break;
@@ -791,6 +795,11 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 		show_link_ifindex_plain(info->tcx.ifindex);
 		show_link_attach_type_plain(info->tcx.attach_type);
 		break;
+	case BPF_LINK_TYPE_NETKIT:
+		printf("\n\t");
+		show_link_ifindex_plain(info->netkit.ifindex);
+		show_link_attach_type_plain(info->netkit.attach_type);
+		break;
 	case BPF_LINK_TYPE_XDP:
 		printf("\n\t");
 		show_link_ifindex_plain(info->xdp.ifindex);
-- 
2.34.1


