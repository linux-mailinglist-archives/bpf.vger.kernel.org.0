Return-Path: <bpf+bounces-12745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC9C7D0363
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 22:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC0E1F2168E
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7790B3E01D;
	Thu, 19 Oct 2023 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="moH4qZmO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CED1335C0;
	Thu, 19 Oct 2023 20:50:06 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21BC130;
	Thu, 19 Oct 2023 13:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=r8DQBABsOBhsGSBwZikKuBHX/OlpKW3dzEamGE0YQTc=; b=moH4qZmOsSr3vQ09rTo8v8V7WA
	NiyV68N9VIR2B643mLG5p5pX040z5+V6HrU361e1Wl8Rxz8ayTGI9+kuhp1zB3P2sGzyILBvErp/r
	4k/LQPr1uQi4hEpIlaR+MJWwk0qNwOzf7Gi5bLj5Qag8bg5ab7TC3izkVyxDX4xxh6VHcrNj10h8l
	eihKbVCikH6b4byu3ePqyZbAF/0NuZhHod5XsCrErrwrIv4pV7VtVVbw0fg7BKhZ5W41RScPq9+wR
	2UMPi9WlXIiijSIJFoMaBds5/WdordX9d66ukJ4pmVvkHyGVOwzSmbhIwO/tKHc71q+d7W42kjWh6
	Yh5V7omA==;
Received: from 21.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.21] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qtZxq-000NeE-6w; Thu, 19 Oct 2023 22:49:54 +0200
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
Subject: [PATCH bpf-next v2 5/7] bpftool: Extend net dump with netkit progs
Date: Thu, 19 Oct 2023 22:49:17 +0200
Message-Id: <20231019204919.4203-6-daniel@iogearbox.net>
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

Add support to dump BPF programs on netkit via bpftool. This includes both
the BPF link and attach ops programs. Dumped information contain the attach
location, function entry name, program ID and link ID when applicable.

Example with tc BPF link:

  # ./bpftool net
  xdp:

  tc:
  nk1(22) netkit/peer tc1 prog_id 43 link_id 12

  [...]

Example with json dump:

  # ./bpftool net --json | jq
  [
    {
      "xdp": [],
      "tc": [
        {
          "devname": "nk1",
          "ifindex": 18,
          "kind": "netkit/primary",
          "name": "tc1",
          "prog_id": 29,
          "prog_flags": [],
          "link_id": 8,
          "link_flags": []
        }
      ],
      "flow_dissector": [],
      "netfilter": []
    }
  ]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Documentation/bpftool-net.rst | 8 ++++----
 tools/bpf/bpftool/net.c                         | 7 ++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-net.rst b/tools/bpf/bpftool/Documentation/bpftool-net.rst
index 5e2abd3de5ab..dd3f9469765b 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-net.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-net.rst
@@ -37,7 +37,7 @@ DESCRIPTION
 	**bpftool net { show | list }** [ **dev** *NAME* ]
 		  List bpf program attachments in the kernel networking subsystem.
 
-		  Currently, device driver xdp attachments, tcx and old-style tc
+		  Currently, device driver xdp attachments, tcx, netkit and old-style tc
 		  classifier/action attachments, flow_dissector as well as netfilter
 		  attachments are implemented, i.e., for
 		  program types **BPF_PROG_TYPE_XDP**, **BPF_PROG_TYPE_SCHED_CLS**,
@@ -52,11 +52,11 @@ DESCRIPTION
 		  bpf programs, users should consult other tools, e.g., iproute2.
 
 		  The current output will start with all xdp program attachments, followed by
-		  all tcx, then tc class/qdisc bpf program attachments, then flow_dissector
-		  and finally netfilter programs. Both xdp programs and tcx/tc programs are
+		  all tcx, netkit, then tc class/qdisc bpf program attachments, then flow_dissector
+		  and finally netfilter programs. Both xdp programs and tcx/netkit/tc programs are
 		  ordered based on ifindex number. If multiple bpf programs attached
 		  to the same networking device through **tc**, the order will be first
-		  all bpf programs attached to tcx, then tc classes, then all bpf programs
+		  all bpf programs attached to tcx, netkit, then tc classes, then all bpf programs
 		  attached to non clsact qdiscs, and finally all bpf programs attached
 		  to root and clsact qdisc.
 
diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 66a8ce8ae012..968714b4c3d4 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -79,6 +79,8 @@ static const char * const attach_type_strings[] = {
 static const char * const attach_loc_strings[] = {
 	[BPF_TCX_INGRESS]		= "tcx/ingress",
 	[BPF_TCX_EGRESS]		= "tcx/egress",
+	[BPF_NETKIT_PRIMARY]		= "netkit/primary",
+	[BPF_NETKIT_PEER]		= "netkit/peer",
 };
 
 const size_t net_attach_type_size = ARRAY_SIZE(attach_type_strings);
@@ -506,6 +508,9 @@ static void show_dev_tc_bpf(struct ip_devname_ifindex *dev)
 {
 	__show_dev_tc_bpf(dev, BPF_TCX_INGRESS);
 	__show_dev_tc_bpf(dev, BPF_TCX_EGRESS);
+
+	__show_dev_tc_bpf(dev, BPF_NETKIT_PRIMARY);
+	__show_dev_tc_bpf(dev, BPF_NETKIT_PEER);
 }
 
 static int show_dev_tc_bpf_classic(int sock, unsigned int nl_pid,
@@ -926,7 +931,7 @@ static int do_help(int argc, char **argv)
 		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload }\n"
 		"       " HELP_SPEC_OPTIONS " }\n"
 		"\n"
-		"Note: Only xdp, tcx, tc, flow_dissector and netfilter attachments\n"
+		"Note: Only xdp, tcx, tc, netkit, flow_dissector and netfilter attachments\n"
 		"      are currently supported.\n"
 		"      For progs attached to cgroups, use \"bpftool cgroup\"\n"
 		"      to dump program attachments. For program types\n"
-- 
2.34.1


