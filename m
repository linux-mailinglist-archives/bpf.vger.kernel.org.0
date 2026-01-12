Return-Path: <bpf+bounces-78509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B22FD1080F
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 04:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1210A3031CEC
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 03:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1F0262FFC;
	Mon, 12 Jan 2026 03:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b="wajf3ORW"
X-Original-To: bpf@vger.kernel.org
Received: from cvsmtppost03.nmdf.navercorp.com (cvsmtppost03.nmdf.navercorp.com [114.111.35.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817261BC2A
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 03:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768189541; cv=none; b=Zj7z1NBnO1yFipyR9gmJCkIbN8ukzFNlI2XmXON425gQ3J/BIwphzzEeRr1dgFEBWJo+klZ0388cfezfT2PfDw9TmaAJfk3apn9PM/OH3NX6fPjzs3q3R7xu5nquJDxMkHn9so7jnnnFC3KvAK6fr6hrMbLvAzKrSNH2Lo4xnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768189541; c=relaxed/simple;
	bh=sCeFqIwAWGDeyUlCQkBn25TfdGNVyKMhBiuKuXgbbIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HhqyVl6YEd4Y7U8CV/lgKBofiFYt8+u4yFAOenrt7cqi2SoTcD1axGZwfOXkqPcxfn9ouwln0UgIfBuQ3VdkPa9wtPtLxLBrch4pn96GfdnzcAZhuTCrRk7/t/3pkOmc/TjSj1hLxtgPjOj2GYBkWGMcIojDqfCuWJpMjvAwAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com; spf=pass smtp.mailfrom=navercorp.com; dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b=wajf3ORW; arc=none smtp.client-ip=114.111.35.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=navercorp.com
Received: from cvsendbo02.nmdf ([10.112.18.65])
  by cvsmtppost03.nmdf.navercorp.com with ESMTP id Jrh4kByFTsOVFBZ-nnV9kg
  for <bpf@vger.kernel.org>;
  Mon, 12 Jan 2026 03:45:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=navercorp.com;
	s=s20171120; t=1768189532;
	bh=sCeFqIwAWGDeyUlCQkBn25TfdGNVyKMhBiuKuXgbbIk=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=wajf3ORWqULwraXrrVgFPeCnUq+BhryT2fJJXqk5uehkehARDB5jS/hgMiaWgqkT1
	 jdlZUv+5IFYOxZaO4DBkk1A80eLiuZWQNryKJ3HTx3yTAQHdw3LsXvAyq4FOgJTwGs
	 mKeRCz0MN4h9oXG7T4KqystslL2XQypYHbJuwPCZJkXrJ20vqLaouO4EDU+rMNWg+Q
	 8w7GrFUXKqoh25W/R4Bg+YyDEYQqrkBKJSgQjD5vXQTH+gFO2R6XoZzrizcaxMOv/c
	 WXMwEou1E1SIOnABlvY+njoUmIda/bL+6W/x5QosfwpXD4v7PWsu1iHBiJaMgOHClv
	 AOuQ+1IT/Bxxg==
X-Session-ID: 6sGnAhroRnOzy6PsAElM+g
X-Works-Send-Opt: xQbwjAiYjHm2KHwYjHmlUVg=
X-Works-Smtp-Source: YZb9Kx2rFqJZ+HmZKquX+6E=
Received: from localhost.localdomain ([10.25.152.220])
  by mvnsmtp02.nmdf.navercorp.com with ESMTP id 6sGnAhroRnOzy6PsAElM+g
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256);
  Mon, 12 Jan 2026 03:45:32 -0000
From: gyutae.opensource@navercorp.com
To: Quentin Monnet <qmo@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH v4] bpftool: Add 'prepend' option for tcx attach to insert at chain start
Date: Mon, 12 Jan 2026 12:45:16 +0900
Message-Id: <20260112034516.22723-1-gyutae.opensource@navercorp.com>
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

The implementation uses BPF_F_BEFORE flag which automatically inserts
the program at the beginning of the chain when no relative reference
is specified.

This change includes:
- Modify do_attach_tcx() to support prepend insertion using BPF_F_BEFORE
- Update documentation to describe the new 'prepend' option
- Add bash completion support for the 'prepend' option on tcx attach types
- Add example usage in the documentation
- Add validation to reject 'overwrite' for non-XDP attach types

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
Reviewed-by: Quentin Monnet <qmo@kernel.org>
---
Hi Quentin.

Thank you for the review! I have added the validation for 'overwrite'
option as you suggested.

I used a whitelist approach (rejecting non-XDP types) rather than
a blacklist approach (rejecting TCX types) to be consistent with the
'prepend' validation style and to ensure that any future attach types
will also be rejected by default unless explicitly allowed.

Thanks,
Gyutae.

Changes in v4:
- Add validation to reject 'overwrite' for non-XDP attach types (Quentin)

Changes in v3:
- Simplified implementation by using BPF_F_BEFORE alone (Daniel)
- Removed get_first_tcx_prog_id() helper function (Daniel)

Changes in v2:
- Renamed 'head' to 'prepend' for consistency with 'overwrite' (Quentin)
- Moved relative_id variable to relevant scope inside if block (Quentin)
- Changed condition style from '== 0' to '!' (Quentin)
- Updated documentation to clarify 'overwrite' is XDP-only (Quentin)
- Removed outdated "only XDP-related modes are supported" note (Quentin)
- Removed extra help text from do_help() for consistency (Quentin)

 .../bpf/bpftool/Documentation/bpftool-net.rst | 30 +++++++++++++-----
 tools/bpf/bpftool/bash-completion/bpftool     |  9 +++++-
 tools/bpf/bpftool/net.c                       | 31 ++++++++++++++++---
 3 files changed, 58 insertions(+), 12 deletions(-)

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
index cfc6f944f7c3..f25d66c8395e 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -666,10 +666,16 @@ static int get_tcx_type(enum net_attach_type attach_type)
 	}
 }
 
-static int do_attach_tcx(int progfd, enum net_attach_type attach_type, int ifindex)
+static int do_attach_tcx(int progfd, enum net_attach_type attach_type, int ifindex, bool prepend)
 {
 	int type = get_tcx_type(attach_type);
 
+	if (prepend) {
+		LIBBPF_OPTS(bpf_prog_attach_opts, opts,
+			.flags = BPF_F_BEFORE
+		);
+		return bpf_prog_attach_opts(progfd, ifindex, type, &opts);
+	}
 	return bpf_prog_attach(progfd, ifindex, type, 0);
 }
 
@@ -685,6 +691,7 @@ static int do_attach(int argc, char **argv)
 	enum net_attach_type attach_type;
 	int progfd, ifindex, err = 0;
 	bool overwrite = false;
+	bool prepend = false;
 
 	/* parse attach args */
 	if (!REQ_ARGS(5))
@@ -709,9 +716,25 @@ static int do_attach(int argc, char **argv)
 
 	if (argc) {
 		if (is_prefix(*argv, "overwrite")) {
+			if (attach_type != NET_ATTACH_TYPE_XDP &&
+			    attach_type != NET_ATTACH_TYPE_XDP_GENERIC &&
+			    attach_type != NET_ATTACH_TYPE_XDP_DRIVER &&
+			    attach_type != NET_ATTACH_TYPE_XDP_OFFLOAD) {
+				p_err("'overwrite' is only supported for xdp types");
+				err = -EINVAL;
+				goto cleanup;
+			}
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
@@ -728,7 +751,7 @@ static int do_attach(int argc, char **argv)
 	/* attach tcx prog */
 	case NET_ATTACH_TYPE_TCX_INGRESS:
 	case NET_ATTACH_TYPE_TCX_EGRESS:
-		err = do_attach_tcx(progfd, attach_type, ifindex);
+		err = do_attach_tcx(progfd, attach_type, ifindex, prepend);
 		break;
 	default:
 		break;
@@ -985,7 +1008,7 @@ static int do_help(int argc, char **argv)
 
 	fprintf(stderr,
 		"Usage: %1$s %2$s { show | list } [dev <devname>]\n"
-		"       %1$s %2$s attach ATTACH_TYPE PROG dev <devname> [ overwrite ]\n"
+		"       %1$s %2$s attach ATTACH_TYPE PROG dev <devname> [ overwrite | prepend ]\n"
 		"       %1$s %2$s detach ATTACH_TYPE dev <devname>\n"
 		"       %1$s %2$s help\n"
 		"\n"
-- 
2.39.5 (Apple Git-154)


