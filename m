Return-Path: <bpf+bounces-77934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B73CECF783E
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 10:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C04CE30409CB
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB70330C36E;
	Tue,  6 Jan 2026 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b="IwvcCzSV"
X-Original-To: bpf@vger.kernel.org
Received: from cvsmtppost02.nmdf.navercorp.com (cvsmtppost02.nmdf.navercorp.com [114.111.35.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5013FEE
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691576; cv=none; b=garHGwJhtjLLn4TWtipYNPU4P+8aDSBW4qdi/idw6oFbR+JRsR4FesGLylyYlK76asHLPrmq2j75MONWektTaITcAnfZe8M0nveOB9Be/70/1vBh6RaSCGtAjDcPWeqXRaVvjt3C1MK1ILR5DorLBXvZvtByexuVWoIC1580Bso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691576; c=relaxed/simple;
	bh=KYkpwmu9D4exjDep8uFp3ZmzOeScxgUISmJMrTeTv1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXAwtuKdCyqnUy6TV26vaEU+PvOF7Nnj8padA11o94ELgkR1XuiRa/QFk7xya15K/BOkw2gFdRyC2E2b2QVt6nDp4/rcYfLQKVG9L+ljiMs0Rx7Ote8xwVZxteUlt7Hip3xsA8HKZKcoFrmBhVXEeavgJQ3vCt1W16Jf2OloV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com; spf=pass smtp.mailfrom=navercorp.com; dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b=IwvcCzSV; arc=none smtp.client-ip=114.111.35.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=navercorp.com
Received: from cvsendbo04.nmdf ([10.112.20.54])
  by cvsmtppost02.nmdf.navercorp.com with ESMTP id +NHA4k73RRiNqo0XUuF-bw
  for <bpf@vger.kernel.org>;
  Tue, 06 Jan 2026 08:55:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=navercorp.com;
	s=s20171120; t=1767689750;
	bh=KYkpwmu9D4exjDep8uFp3ZmzOeScxgUISmJMrTeTv1E=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=IwvcCzSVCY6oOQcusuNLM2RrMBY+0iTMdFz6vurQ+CxInbwPLJdMSd0COuFjItfUd
	 z7FShhFAycyN3dGTGqBBpzHxPjgsl7w7/wXvvVtDUDkrGlz71EOIOd+PH9PRQPT0sC
	 YC5riUDxD8W5rbL41CBzl0iJGSwBZW/CUqrj3hjDf1uT91ulHjb8W4jXKnuhE+GO+8
	 P8top89amzIDlkFJtHkEqDsK0I+LxAd+ZnnJEOQTFqkfv5fCczmyLmRs0NbUCmfWL5
	 XPswNeRFoOKp1ZZSU8Pan1cnnK6ETxl75ZdQxV+N0j02kuXAnQfmaYZ2fhQ+Q09/pe
	 5XhxDNXU4N34w==
X-Session-ID: gcC4629NSVussM3wz1c+gQ
X-Works-Send-Opt: xQbwjAiYjHm2KHwYjHmlUVg=
X-Works-Smtp-Source: gZY9FobrFqJZ+HmmFxKX+6E=
Received: from localhost.localdomain ([10.25.143.76])
  by cvnsmtp02.nmdf.navercorp.com with ESMTP id gcC4629NSVussM3wz1c+gQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256);
  Tue, 06 Jan 2026 08:55:50 -0000
From: gyutae.opensource@navercorp.com
To: Quentin Monnet <qmo@kernel.org>,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Gyutae Bae <gyutae.bae@navercorp.com>,
	Siwan Kim <siwan.kim@navercorp.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Tao Chen <chen.dylane@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH v2] bpftool: Add 'prepend' option for tcx attach to insert at chain start
Date: Tue,  6 Jan 2026 17:55:27 +0900
Message-Id: <20260106085527.4774-1-gyutae.opensource@navercorp.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <43c23468-530b-45f3-af22-f03484e5148c@kernel.org>
References: <43c23468-530b-45f3-af22-f03484e5148c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gyutae Bae <gyutae.bae@navercorp.com>

Add support for the 'prepend' option when attaching tcx_ingress and
tcx_egress programs. This option allows inserting a BPF program at
the beginning of the TCX chain instead of appending it at the end.

The implementation queries the first program ID in the chain and uses
BPF_F_BEFORE flag with the relative_id to insert the new program before
the existing first program. If the chain is empty, the program is simply
attached normally.

This change includes:
- Add get_first_tcx_prog_id() helper to retrieve the first program ID
- Modify do_attach_tcx() to support prepend insertion using BPF_F_BEFORE
- Update documentation to describe the new 'prepend' option
- Add bash completion support for the 'prepend' option on tcx attach types
- Add example usage in the documentation

The 'prepend' option is only valid for tcx_ingress and tcx_egress attach
types. For XDP attach types, the existing 'overwrite' option remains
available.

Example usage:
  # bpftool net attach tcx_ingress name tc_prog dev lo prepend

This feature is useful when the order of program execution in the TCX
chain matters and users need to ensure certain programs run first.

Co-developed-by: Siwan Kim <siwan.kim@navercorp.com>
Signed-off-by: Siwan Kim <siwan.kim@navercorp.com>
Signed-off-by: Gyutae Bae <gyutae.bae@navercorp.com>
---
Hi Quentin.

Apologies for the delay in getting back to you. I had to sort out
some configuration issues with my mail system to ensure proper
delivery.

I really appreciate your detailed review and feedback on the first
version. I have incorporated your suggestions in this v2 patch.

Changes in v2:
- Renamed 'head' to 'prepend' for consistency with 'overwrite' (Quentin)
- Moved relative_id variable to relevant scope inside if block (Quentin)
- Changed condition style from '== 0' to '!' (Quentin)
- Updated documentation to clarify 'overwrite' is XDP-only (Quentin)
- Removed outdated "only XDP-related modes are supported" note (Quentin)
- Removed extra help text from do_help() for consistency (Quentin)
---
 .../bpf/bpftool/Documentation/bpftool-net.rst | 30 +++++++++---
 tools/bpf/bpftool/bash-completion/bpftool     |  9 +++-
 tools/bpf/bpftool/net.c                       | 47 +++++++++++++++++--
 3 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-net.rst b/tools/bpf/bpftool/Documentation/bpftool-net.rst
index a9ed8992800f..22da07087e42 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-net.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-net.rst
@@ -24,7 +24,7 @@ NET COMMANDS
 ============

 | **bpftool** **net** { **show** | **list** } [ **dev** *NAME* ]
-| **bpftool** **net attach** *ATTACH_TYPE* *PROG* **dev** *NAME* [ **overwrite** ]
+| **bpftool** **net attach** *ATTACH_TYPE* *PROG* **dev** *NAME* [ **overwrite** | **prepend** ]
 | **bpftool** **net detach** *ATTACH_TYPE* **dev** *NAME*
 | **bpftool** **net help**
 |
@@ -58,11 +58,9 @@ bpftool net { show | list } [ dev *NAME* ]
     then all bpf programs attached to non clsact qdiscs, and finally all bpf
     programs attached to root and clsact qdisc.

-bpftool net attach *ATTACH_TYPE* *PROG* dev *NAME* [ overwrite ]
+bpftool net attach *ATTACH_TYPE* *PROG* dev *NAME* [ overwrite | prepend ]
     Attach bpf program *PROG* to network interface *NAME* with type specified
-    by *ATTACH_TYPE*. Previously attached bpf program can be replaced by the
-    command used with **overwrite** option. Currently, only XDP-related modes
-    are supported for *ATTACH_TYPE*.
+    by *ATTACH_TYPE*.

     *ATTACH_TYPE* can be of:
     **xdp** - try native XDP and fallback to generic XDP if NIC driver does not support it;
@@ -72,11 +70,18 @@ bpftool net attach *ATTACH_TYPE* *PROG* dev *NAME* [ overwrite ]
     **tcx_ingress** - Ingress TCX. runs on ingress net traffic;
     **tcx_egress** - Egress TCX. runs on egress net traffic;

+    For XDP-related attach types (**xdp**, **xdpgeneric**, **xdpdrv**,
+    **xdpoffload**), the **overwrite** option can be used to replace a
+    previously attached bpf program.
+
+    For **tcx_ingress** and **tcx_egress** attach types, the **prepend** option
+    can be used to attach the program at the beginning of the chain instead of
+    at the end.
+
 bpftool net detach *ATTACH_TYPE* dev *NAME*
     Detach bpf program attached to network interface *NAME* with type specified
     by *ATTACH_TYPE*. To detach bpf program, same *ATTACH_TYPE* previously used
-    for attach must be specified. Currently, only XDP-related modes are
-    supported for *ATTACH_TYPE*.
+    for attach must be specified.

 bpftool net help
     Print short help message.
@@ -191,6 +196,17 @@ EXAMPLES
       tc:
       lo(1) tcx/ingress tc_prog prog_id 29

+|
+| **# bpftool net attach tcx_ingress name tc_prog2 dev lo prepend**
+| **# bpftool net**
+|
+
+::
+
+      tc:
+      lo(1) tcx/ingress tc_prog2 prog_id 30
+      lo(1) tcx/ingress tc_prog prog_id 29
+
 |
 | **# bpftool net attach tcx_ingress name tc_prog dev lo**
 | **# bpftool net detach tcx_ingress dev lo**
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 53bcfeb1a76e..a28f0cc522e4 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -1142,7 +1142,14 @@ _bpftool()
                             return 0
                             ;;
                         8)
-                            _bpftool_once_attr 'overwrite'
+                            case ${words[3]} in
+                                tcx_ingress|tcx_egress)
+                                    _bpftool_once_attr 'prepend'
+                                    ;;
+                                *)
+                                    _bpftool_once_attr 'overwrite'
+                                    ;;
+                            esac
                             return 0
                             ;;
                     esac
diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index cfc6f944f7c3..7935a6ba1491 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -637,6 +637,25 @@ static int net_parse_dev(int *argc, char ***argv)
 	return ifindex;
 }

+static int get_first_tcx_prog_id(int ifindex, enum bpf_attach_type type, __u32 *first_id)
+{
+	int ret;
+
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 prog_ids[1] = {};
+
+	optq.prog_ids = prog_ids;
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	ret = bpf_prog_query_opts(ifindex, type, &optq);
+
+	if (ret == 0 && optq.count > 0) {
+		*first_id = prog_ids[0];
+		return 0;
+	}
+	return -1;
+}
+
 static int do_attach_detach_xdp(int progfd, enum net_attach_type attach_type,
 				int ifindex, bool overwrite)
 {
@@ -666,10 +685,21 @@ static int get_tcx_type(enum net_attach_type attach_type)
 	}
 }

-static int do_attach_tcx(int progfd, enum net_attach_type attach_type, int ifindex)
+static int do_attach_tcx(int progfd, enum net_attach_type attach_type, int ifindex, bool prepend)
 {
 	int type = get_tcx_type(attach_type);

+	if (prepend) {
+		__u32 relative_id;
+
+		if (!get_first_tcx_prog_id(ifindex, type, &relative_id)) {
+			LIBBPF_OPTS(bpf_prog_attach_opts, opts,
+				.flags = BPF_F_BEFORE | BPF_F_ID,
+				.relative_id = relative_id
+			);
+			return bpf_prog_attach_opts(progfd, ifindex, type, &opts);
+		}
+	}
 	return bpf_prog_attach(progfd, ifindex, type, 0);
 }

@@ -685,6 +715,7 @@ static int do_attach(int argc, char **argv)
 	enum net_attach_type attach_type;
 	int progfd, ifindex, err = 0;
 	bool overwrite = false;
+	bool prepend = false;

 	/* parse attach args */
 	if (!REQ_ARGS(5))
@@ -710,8 +741,16 @@ static int do_attach(int argc, char **argv)
 	if (argc) {
 		if (is_prefix(*argv, "overwrite")) {
 			overwrite = true;
+		} else if (is_prefix(*argv, "prepend")) {
+			if (attach_type != NET_ATTACH_TYPE_TCX_INGRESS &&
+			    attach_type != NET_ATTACH_TYPE_TCX_EGRESS) {
+				p_err("'prepend' is only supported for tcx_ingress/tcx_egress");
+				err = -EINVAL;
+				goto cleanup;
+			}
+			prepend = true;
 		} else {
-			p_err("expected 'overwrite', got: '%s'?", *argv);
+			p_err("expected 'overwrite' or 'prepend', got: '%s'?", *argv);
 			err = -EINVAL;
 			goto cleanup;
 		}
@@ -728,7 +767,7 @@ static int do_attach(int argc, char **argv)
 	/* attach tcx prog */
 	case NET_ATTACH_TYPE_TCX_INGRESS:
 	case NET_ATTACH_TYPE_TCX_EGRESS:
-		err = do_attach_tcx(progfd, attach_type, ifindex);
+		err = do_attach_tcx(progfd, attach_type, ifindex, prepend);
 		break;
 	default:
 		break;
@@ -985,7 +1024,7 @@ static int do_help(int argc, char **argv)

 	fprintf(stderr,
 		"Usage: %1$s %2$s { show | list } [dev <devname>]\n"
-		"       %1$s %2$s attach ATTACH_TYPE PROG dev <devname> [ overwrite ]\n"
+		"       %1$s %2$s attach ATTACH_TYPE PROG dev <devname> [ overwrite | prepend ]\n"
 		"       %1$s %2$s detach ATTACH_TYPE dev <devname>\n"
 		"       %1$s %2$s help\n"
 		"\n"
--
2.39.5 (Apple Git-154)


