Return-Path: <bpf+bounces-10850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7E77AE567
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 08:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id B2A34B20A25
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 06:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3B16FD1;
	Tue, 26 Sep 2023 05:59:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0C538A;
	Tue, 26 Sep 2023 05:59:43 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA2FDE;
	Mon, 25 Sep 2023 22:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=IAQVHrJSV2pQ6tSouhOU3630C5s0Y3+kCjTTeyrf9HY=; b=R/5iGB07mvvLxOH/ubIbrk4dTg
	rKCGeUXKiQQ6cPwD8puqAvPxtXwroeLzsyk1jvquglqaNCT45wJ36FmyMMSR1+Wh2MPavgugO5Wey
	ZRtOFsUUxwR5m7wuRaF0hdRPBq1wGZmIX3wkwbVp/kFUcNAtRMptg3vUDt352IOGnOpaTyRULdLgX
	Lotd96Q/dj7ya6delM9gmoshARlkT9pDhwmJdTiJwe6h6uFTyJ9HBvzYtZLLrytncf4FX09nzt0dm
	aOxznyKtqxCthXeyr10LULIGGq9iyDvL/JVqms5sGdJpsxAz488VavHrjIhpEfUozv1HM5c6Qw81z
	80n62X2g==;
Received: from mob-194-230-148-205.cgn.sunrise.net ([194.230.148.205] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ql16h-0006oA-DF; Tue, 26 Sep 2023 07:59:39 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	martin.lau@kernel.org,
	razor@blackwall.org,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 6/8] bpftool: Extend net dump with meta progs
Date: Tue, 26 Sep 2023 07:59:11 +0200
Message-Id: <20230926055913.9859-7-daniel@iogearbox.net>
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

Add support to dump BPF programs on meta via bpftool. This includes both
the BPF link and attach ops programs. Dumped information contain the attach
location, function entry name, program ID and link ID when applicable.

Example with tc BPF link:

  # ./bpftool net
  xdp:

  tc:
  meta1(22) meta/peer tc1 prog_id 43 link_id 12

  [...]

Example with json dump:

  # ./bpftool net --json | jq
  [
    {
      "xdp": [],
      "tc": [
        {
          "devname": "meta1",
          "ifindex": 18,
          "kind": "meta/primary",
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
---
 tools/bpf/bpftool/Documentation/bpftool-net.rst | 8 ++++----
 tools/bpf/bpftool/net.c                         | 7 ++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-net.rst b/tools/bpf/bpftool/Documentation/bpftool-net.rst
index 5e2abd3de5ab..268770c3eb9c 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-net.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-net.rst
@@ -37,7 +37,7 @@ DESCRIPTION
 	**bpftool net { show | list }** [ **dev** *NAME* ]
 		  List bpf program attachments in the kernel networking subsystem.
 
-		  Currently, device driver xdp attachments, tcx and old-style tc
+		  Currently, device driver xdp attachments, tcx, meta and old-style tc
 		  classifier/action attachments, flow_dissector as well as netfilter
 		  attachments are implemented, i.e., for
 		  program types **BPF_PROG_TYPE_XDP**, **BPF_PROG_TYPE_SCHED_CLS**,
@@ -52,11 +52,11 @@ DESCRIPTION
 		  bpf programs, users should consult other tools, e.g., iproute2.
 
 		  The current output will start with all xdp program attachments, followed by
-		  all tcx, then tc class/qdisc bpf program attachments, then flow_dissector
-		  and finally netfilter programs. Both xdp programs and tcx/tc programs are
+		  all tcx, meta, then tc class/qdisc bpf program attachments, then flow_dissector
+		  and finally netfilter programs. Both xdp programs and tcx/meta/tc programs are
 		  ordered based on ifindex number. If multiple bpf programs attached
 		  to the same networking device through **tc**, the order will be first
-		  all bpf programs attached to tcx, then tc classes, then all bpf programs
+		  all bpf programs attached to tcx, meta, then tc classes, then all bpf programs
 		  attached to non clsact qdiscs, and finally all bpf programs attached
 		  to root and clsact qdisc.
 
diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 66a8ce8ae012..1c60fb18b7fd 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -79,6 +79,8 @@ static const char * const attach_type_strings[] = {
 static const char * const attach_loc_strings[] = {
 	[BPF_TCX_INGRESS]		= "tcx/ingress",
 	[BPF_TCX_EGRESS]		= "tcx/egress",
+	[BPF_META_PRIMARY]		= "meta/primary",
+	[BPF_META_PEER]			= "meta/peer",
 };
 
 const size_t net_attach_type_size = ARRAY_SIZE(attach_type_strings);
@@ -506,6 +508,9 @@ static void show_dev_tc_bpf(struct ip_devname_ifindex *dev)
 {
 	__show_dev_tc_bpf(dev, BPF_TCX_INGRESS);
 	__show_dev_tc_bpf(dev, BPF_TCX_EGRESS);
+
+	__show_dev_tc_bpf(dev, BPF_META_PRIMARY);
+	__show_dev_tc_bpf(dev, BPF_META_PEER);
 }
 
 static int show_dev_tc_bpf_classic(int sock, unsigned int nl_pid,
@@ -926,7 +931,7 @@ static int do_help(int argc, char **argv)
 		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload }\n"
 		"       " HELP_SPEC_OPTIONS " }\n"
 		"\n"
-		"Note: Only xdp, tcx, tc, flow_dissector and netfilter attachments\n"
+		"Note: Only xdp, tcx, meta, tc, flow_dissector and netfilter attachments\n"
 		"      are currently supported.\n"
 		"      For progs attached to cgroups, use \"bpftool cgroup\"\n"
 		"      to dump program attachments. For program types\n"
-- 
2.34.1


