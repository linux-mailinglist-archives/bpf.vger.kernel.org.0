Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5EEE170E75
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2020 03:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgB0CdL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Feb 2020 21:33:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16842 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728164AbgB0CdK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Feb 2020 21:33:10 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R2VRfu024538
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2020 18:33:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=x0IFhur14U15pRA1fM8+x1TLsYFl94iCgsowgLBTMXc=;
 b=NcH9dS/yPOgFFZ5nPVz5y8LbcZZTJk3iPPeplbdMJ8FvR7kzQQ5pvW8rRaiu27m4fbCK
 sNvBOHFJgw/gFW9BHCs++o4A6rvY2cqmdFSe4sCLEv51BiwNxko0UBWBuEeBXRvxaexj
 ty2Y+a7Z9a5cujoQjSu2771EV3ko/Zmw2SQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2ydckyemd1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2020 18:33:09 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 26 Feb 2020 18:33:06 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 80B4E370087B; Wed, 26 Feb 2020 18:33:05 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <osandov@fb.com>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
Date:   Wed, 26 Feb 2020 18:32:53 -0800
Message-ID: <20200227023253.3445221-1-rdna@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_09:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=1 phishscore=0 lowpriorityscore=0
 mlxlogscore=668 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270016
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

drgn is a debugger that reads kernel memory and uses DWARF to get types
and symbols. See [1], [2] and [3] for more details on drgn.

Since drgn operates on kernel memory it has access to kernel internals
that user space doesn't. It allows to get extended info about various
kernel data structures.

Introduce bpf.py drgn script to list BPF programs and maps and their
properties unavailable to user space via kernel API.

The main use-case bpf.py covers is to show BPF programs attached to
other BPF programs via freplace/fentry/fexit mechanisms introduced
recently. There is no user-space API to get this info and e.g. bpftool
can only show all BPF programs but can't show if program A replaces a
function in program B.

Example:

  % sudo tools/bpf/bpf.py p | grep test_pkt_access
     650: BPF_PROG_TYPE_SCHED_CLS          test_pkt_access
     654: BPF_PROG_TYPE_TRACING            test_main                        linked:[650->25: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access()]
     655: BPF_PROG_TYPE_TRACING            test_subprog1                    linked:[650->29: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access_subprog1()]
     656: BPF_PROG_TYPE_TRACING            test_subprog2                    linked:[650->31: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access_subprog2()]
     657: BPF_PROG_TYPE_TRACING            test_subprog3                    linked:[650->21: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access_subprog3()]
     658: BPF_PROG_TYPE_EXT                new_get_skb_len                  linked:[650->16: BPF_TRAMP_REPLACE test_pkt_access->get_skb_len()]
     659: BPF_PROG_TYPE_EXT                new_get_skb_ifindex              linked:[650->23: BPF_TRAMP_REPLACE test_pkt_access->get_skb_ifindex()]
     660: BPF_PROG_TYPE_EXT                new_get_constant                 linked:[650->19: BPF_TRAMP_REPLACE test_pkt_access->get_constant()]

It can be seen that there is a program test_pkt_access, id 650 and there
are multiple other tracing and ext programs attached to functions in
test_pkt_access.

For example the line:

     658: BPF_PROG_TYPE_EXT                new_get_skb_len                  linked:[650->16: BPF_TRAMP_REPLACE test_pkt_access->get_skb_len()]

means that BPF program new_get_skb_len, id 658, type BPF_PROG_TYPE_EXT
replaces (BPF_TRAMP_REPLACE) function get_skb_len() that has BTF id 16
in BPF program test_pkt_access, prog id 650.

Just very simple output is supported now but it can be extended in the
future if needed.

The script is extendable and currently implements two subcommands:
* prog (alias: p) to list all BPF programs;
* map (alias: m) to list all BPF maps;

Developer can simply tweak the script to print interesting pieces of programs
or maps.

The name bpf.py is not super authentic. I'm open to better options.

The script can be sent to drgn repo where it's easier to maintain its
"drgn-ness", but in kernel tree it should be easier to maintain BPF
functionality itself what can be more important in this case.

The script depends on drgn revision [4] where BPF helpers were added.

More examples of output:

  % sudo tools/bpf/bpf.py p | shuf -n 3
      81: BPF_PROG_TYPE_CGROUP_SOCK_ADDR   tw_ipt_bind
      94: BPF_PROG_TYPE_CGROUP_SOCK_ADDR   tw_ipt_bind
      43: BPF_PROG_TYPE_KPROBE             kprobe__tcp_reno_cong_avoid

  % sudo tools/bpf/bpf.py m | shuf -n 3
     213: BPF_MAP_TYPE_HASH                errors
      30: BPF_MAP_TYPE_ARRAY               sslwall_setting
      41: BPF_MAP_TYPE_LRU_HASH            flow_to_snd

Help:

  % sudo tools/bpf/bpf.py
  usage: bpf.py [-h] {prog,p,map,m} ...

  drgn script to list BPF programs or maps and their properties
  unavailable via kernel API.

  See https://github.com/osandov/drgn/ for more details on drgn.

  optional arguments:
    -h, --help      show this help message and exit

  subcommands:
    {prog,p,map,m}
      prog (p)      list BPF programs
      map (m)       list BPF maps

[1] https://github.com/osandov/drgn/
[2] https://drgn.readthedocs.io/en/latest/index.html
[3] https://lwn.net/Articles/789641/
[4] https://github.com/osandov/drgn/commit/c8ef841768032e36581d45648e42fc2a5489d8f2

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/bpf/bpf.py | 149 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100755 tools/bpf/bpf.py

diff --git a/tools/bpf/bpf.py b/tools/bpf/bpf.py
new file mode 100755
index 000000000000..a00d112c0486
--- /dev/null
+++ b/tools/bpf/bpf.py
@@ -0,0 +1,149 @@
+#!/usr/bin/env drgn
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+#
+# Copyright (c) 2020 Facebook
+
+DESCRIPTION = """
+drgn script to list BPF programs or maps and their properties
+unavailable via kernel API.
+
+See https://github.com/osandov/drgn/ for more details on drgn.
+"""
+
+import argparse
+import sys
+
+from drgn.helpers import enum_type_to_class
+from drgn.helpers.linux import (
+    bpf_map_for_each,
+    bpf_prog_for_each,
+    hlist_for_each_entry,
+)
+
+
+BpfMapType = enum_type_to_class(prog.type("enum bpf_map_type"), "BpfMapType")
+BpfProgType = enum_type_to_class(prog.type("enum bpf_prog_type"), "BpfProgType")
+BpfProgTrampType = enum_type_to_class(
+    prog.type("enum bpf_tramp_prog_type"), "BpfProgTrampType"
+)
+BpfAttachType = enum_type_to_class(
+    prog.type("enum bpf_attach_type"), "BpfAttachType"
+)
+
+
+def get_btf_name(btf, btf_id):
+    type_ = btf.types[btf_id]
+    if type_.name_off < btf.hdr.str_len:
+        return btf.strings[type_.name_off].address_of_().string_().decode()
+    return ""
+
+
+def get_prog_btf_name(bpf_prog):
+    aux = bpf_prog.aux
+    if aux.btf:
+        # func_info[0] points to BPF program function itself.
+        return get_btf_name(aux.btf, aux.func_info[0].type_id)
+    return ""
+
+
+def get_prog_name(bpf_prog):
+    return get_prog_btf_name(bpf_prog) or bpf_prog.aux.name.string_().decode()
+
+
+def attach_type_to_tramp(attach_type):
+    at = BpfAttachType(attach_type)
+
+    if at == BpfAttachType.BPF_TRACE_FENTRY:
+        return BpfProgTrampType.BPF_TRAMP_FENTRY
+
+    if at == BpfAttachType.BPF_TRACE_FEXIT:
+        return BpfProgTrampType.BPF_TRAMP_FEXIT
+
+    return BpfProgTrampType.BPF_TRAMP_REPLACE
+
+
+def get_linked_func(bpf_prog):
+    kind = attach_type_to_tramp(bpf_prog.expected_attach_type)
+
+    linked_prog = bpf_prog.aux.linked_prog
+    linked_btf_id = bpf_prog.aux.attach_btf_id
+
+    linked_prog_id = linked_prog.aux.id.value_()
+    linked_name = "{}->{}()".format(
+        get_prog_name(linked_prog),
+        get_btf_name(linked_prog.aux.btf, linked_btf_id),
+    )
+
+    return "{}->{}: {} {}".format(
+        linked_prog_id, linked_btf_id.value_(), kind.name, linked_name
+    )
+
+
+def get_tramp_progs(bpf_prog):
+    tr = bpf_prog.aux.trampoline
+    if not tr:
+        return
+
+    if tr.extension_prog:
+        yield tr.extension_prog
+    else:
+        for head in tr.progs_hlist:
+            for tramp_aux in hlist_for_each_entry(
+                "struct bpf_prog_aux", head, "tramp_hlist"
+            ):
+                yield tramp_aux.prog
+
+
+def list_bpf_progs(args, prog):
+    for bpf_prog in bpf_prog_for_each(prog):
+        id_ = bpf_prog.aux.id.value_()
+        type_ = BpfProgType(bpf_prog.type).name
+        name = get_prog_name(bpf_prog)
+
+        linked = ", ".join(
+            [get_linked_func(p) for p in get_tramp_progs(bpf_prog)]
+        )
+        if linked:
+            linked = " linked:[{}]".format(linked)
+
+        print("{:>6}: {:32} {:32}{}".format(id_, type_, name, linked))
+
+
+def list_bpf_maps(args, prog):
+    for map_ in bpf_map_for_each(prog):
+        id_ = map_.id.value_()
+        type_ = BpfMapType(map_.map_type).name
+        name_ = map_.name.string_().decode()
+
+        print("{:>6}: {:32} {}".format(id_, type_, name_))
+
+
+def main():
+    parser = argparse.ArgumentParser(
+        description=DESCRIPTION, formatter_class=argparse.RawTextHelpFormatter
+    )
+
+    subparsers = parser.add_subparsers(
+        title="subcommands", dest="subparser_name"
+    )
+
+    prog_parser = subparsers.add_parser(
+        "prog", aliases=["p"], help="list BPF programs"
+    )
+    prog_parser.set_defaults(func=list_bpf_progs)
+
+    map_parser = subparsers.add_parser(
+        "map", aliases=["m"], help="list BPF maps"
+    )
+    map_parser.set_defaults(func=list_bpf_maps)
+
+    args = parser.parse_args()
+    if not args.subparser_name:
+        parser.print_help()
+        sys.exit(2)
+
+    args.func(args, prog)  # prog is global drgn.Program provided by drgn.
+
+
+if __name__ == "__main__":
+    main()
-- 
2.17.1

