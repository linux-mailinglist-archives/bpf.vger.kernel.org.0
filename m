Return-Path: <bpf+bounces-70599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0322BC626D
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB1818966CF
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523332BEC53;
	Wed,  8 Oct 2025 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VBMyObZ+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4521255E
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944944; cv=none; b=ultTTCa0DW0OqnWlt0aQ1QKiATczRH5h3gfALYsf6xPrS2XZGYb58F52NqXnVpwut+mT19t6wzzGg/nvQPdfVSfbLiu4SunV2JVhHOfxd1kdlwY0W2oNftuZCznARmQ/KuBAswBUAbpaLoL+RqhKeJWJjD5lWk5/mlpFkbxTnAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944944; c=relaxed/simple;
	bh=j0doAshY9iBbWQYmROeq6j0FtTCPcX4vXIJTPMgC2H4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GyxwEe3QSTQ91oaXs2mHJ44djw7xxSBMeWHHGbnpBuqme9mYTvxQJnQ8HwTY9+EMYlY3ZZ0ypPW9ploVk0T/+bKz+w6sN46oJogLqJmY//YdqYt2zQD7UakY0+kduizZKtHcDA1+2kXqjwGKkXeptIZNt+DaSDUZD3lgJNYvcz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VBMyObZ+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HESBx029178;
	Wed, 8 Oct 2025 17:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=a9vYKzP5S49mwlARcH6e0+r2xQcv6
	fBvLLeh6tryTe8=; b=VBMyObZ+AYJIHWL0KEv40LKWh/1jhRniqJ5JLI6wjHOCz
	m/yez0NLxK++4cuKvHYfxuw5ch+bcSweU4xxQv3i2X3z7YW8R/0o3uOJfvTBlg/I
	ZdpM52a9x4CSDI7zke4jKCRuQlduMKUbB4vRR1iGVhP119hqNku0ubkAUcZxnJ73
	958SeOw9kiOo7WlmfgwOs7CYETpwN/g6oeOOv656cK15RldbnjMrZMQu8keMywcB
	XAkvUNTuJpRLofSR8Wn1P3CZqScsWIzBpm8AYHsg53iXfLH1CS03ptOGkaPTdrfq
	K98edXWTkDBEr4PgbOHgjtAk0FtaIvHyDaTtbE+sA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6b819x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDrUs036952;
	Wed, 8 Oct 2025 17:35:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rpp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:15 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFUg031138;
	Wed, 8 Oct 2025 17:35:15 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-1;
	Wed, 08 Oct 2025 17:35:14 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 00/15] support inline tracing with BTF
Date: Wed,  8 Oct 2025 18:34:56 +0100
Message-ID: <20251008173512.731801-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510080123
X-Proofpoint-GUID: jL5iBC97NnVmkb4WaCdb1b17A9ZYtP5h
X-Authority-Analysis: v=2.4 cv=Nb7rFmD4 c=1 sm=1 tr=0 ts=68e6a0d5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=OGjWj8McAAAA:8 a=P4BkrglseI_Px2hglM4A:9 a=gKebqoRLp9LExxC7YDUY:22
 a=UYjydHh6ynBBc6_pBLvz:22 cc=ntf awl=host:13625
X-Proofpoint-ORIG-GUID: jL5iBC97NnVmkb4WaCdb1b17A9ZYtP5h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4j+hjBPVPpwK
 wIB/Q1PS2Ntq5/AoOc8i6KAEzxAHKXvW6PLl0HahR6ZVUnVc10taFQhJdeZW3SbZy+28y8GLnsk
 CczR9IHAKYlbC5egqQOhumQ4SJSlyQFYBAOBd6mps012aWnu8oN+jZO0GaaBnUueobz0PlXvw/n
 gFo6FD08Ts0k5YywtNOQkqSm+W242V/pu83QW0//s/VGpzUC4K0X7tMb1cZ/CGZrwJ7hR7mVVxI
 vHGKEDCrWNo0ZEkPAY9pLInbEiBJQwPU/As2OftoT0tumdPJHSlYBTrD9yrMwseP0GICFELAyZh
 1qT0End1o+EhZBShArb8Pj6bOeMZ6jwyTsGuVGurbZcyilKR3lx7bDVOKg5MfAAg6tJVGZKVUXt
 5cSbMfoRiBgUEYsSJn8SifhmuWbyrDup/WGuO8U3EZRnA1eySG4=

The Linux kernel is heavily inlined. As a result, function-focused
observability means it can be difficult to map from code to system
behaviour when tracing. A large number of functions effectively
"disappear" at compile-time; approximately 100,000 are inlined to
443,000 sites in the gcc-14-built x86_64 kernel I have been testing
with for example. This greatly outnumbers the number of available
functions that were _not_ inlined. This disappearing act has
traditionally been carried out on static functions but with
Link-Time Optimization (LTO) non-static functions also become eligible
for such optimization.

The good news is that kprobe tracing can be done on most instructions,
so if we know where the inline site is and where the inlined function
parameters are to be found at those points we can suport tracing at most
of these sites. However the ability to trace inlined functions today
depends on analysis of DWARF debuginfo that is hundreds of megabytes in
size for vmlinux alone (255 Mb of .debug_info on my kernel for example).

This series is an attempt to work through the realization of a
representation of inline sites in the BPF Type Format (BTF) that is small
enough to be feasible to carry with the kernel/modules, but expressive
enough to allow useful tracing at inline sites. Small enough is always
going to be a somewhat subjective measure, but the aim was to ensure
it is a similar order of magnitude to existing kernel/module BTF.
For my kernel, vmlinux BTF is ~6Mb so the informal aim is to be in this
ballpark with inline information representation.  Specific numbers
are broken out below, but the approach taken here stores info about
the ~443000 vmlinux inline sites and their parameter availability
in 9.2Mb, compressed to 2.8Mb when that data is delivered via a
compressed module.

The series makes location information about inlines available to tracing
tools via addition of .BTF.extra sections to vmlinux and modules which -
like .BTF sections exposed via /sys/kernel/btf - are made available via
/sys/kernel/btf_extra files, one for the kernel (vmlinux) and one each for
each module. These are stored as split BTF, so for example the vmlinux
.BTF.extra can be viewed via

$ bpftool btf dump -B /sys/kernel/btf/vmlinux file /sys/kernel/btf_extra/vmlinux

i.e. it is split BTF relative to vmlinux BTF.

For modules, .BTF.extra is split BTF relative to the module BTF, so it
is multi-split BTF; to view it we specify the base vmlinux, the child
module BTF and finally the grandchild module .BTF.extra.
So for example for the xfs module:

$ bpftool btf dump -B /sys/kernel/btf/vmlinux -B /sys/kernel/btf/xfs file /sys/kernel/btf_extra/xfs

(this requires an enhancement to bpftool in this series to support multi-split BTF)

To generate .BTF.extra data, pahole changes are needed. These will be sent
in a separate RFC series which I will follow up with; it in turn will
require the libbpf changes in this series to actually produce .BTF.extra
data. pahole will have a new "inline" BTF feature, and this can be
optionally directed to a .BTF.extra section if it is specified as
"inline.extra". A single invocation of pahole is requried to generate .BTF
and .BTF.extra sections.  In order to generate inline info the libbpf
changes in this series will have to be applied to pahole; to verify this
is working you should see "inline" in the list of supported BTF
features:

$ pahole --supported_btf_features
encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,decl_tag_kfuncs,reproducible_build,distilled_base,global_var,attributes,inline

To make things simpler an updated pahole is available at [1] which still
requires the changes in patch 2-4 below applied to its lib/bpf/src
submodule directory.

Because the size of the vmlinux binary would grow somewhat with
inclusion of the .BTF.extra section, it can also be delivered via
module (CONFIG_DEBUG_INFO_BTF_EXTRA=m).

So how do we represent inline information? This series proposes a fairly
simple approach, but whatever the final form used, the hope is this
series will help push things forward by tackling some of the problems
with _any_ inline representation (libbpf representation and deduplication,
kernel handling and exposure as new .BTF sections, modular delivery for
kernel inline info, providing libbpf support for tracing sites etc).

This series builds on previous work by Thierry Treyer [2] and
analysis done by Eduard Zingerman, as well as work done with Yonghong Song
at Linux Plumbers [3]. The proposed BTF changes are somewhat different than
Thierry's proposal however. They are intended to provide a simple representation
that while appearing not hugely compact in original form, it is designed
to be easily de-deduplicated by representing information about parameters
at locations in such a way that it can be easily shared across multiple
inline sites.

The info about each inline site is stored in an entry in a BTF kind
 BTF_KIND_LOCSEC.  Each location provides

- a name for the site (inline function name);
- its function prototype (BTF_KIND_FUNC_PROTO) which represents the types
  of the parameters
- its location prototype (BTF_KIND_LOC_PROTO) which represents a list of
  the locations of those parameters (in register, constant values etc)
- a relative offset for the address of the site

The BTF_KIND_LOC_PROTO is simply a list of BTF type ids which are either
0 (no location info for this parameter) or of kind BTF_KIND_LOC_PARAM.
BTF_KIND_LOC_PARAM specifies whether the parameter is stored in a
register, is a constant etc.  In general the nth type in the _LOC_PROTO
will correspond to the nth parameter in the FUNC_PROTO, though some
location parameters require multiple _LOC_PARAM to express them (such as
a 16-byte struct passed by value in two registers).

See patch 1 for more details on how this is handled.

Note however that the representations are designed to be highly shareable
among location sites; as Eduard discovered, many/most will be simply 
register values in line with the calling conventions, so they will share
LOC_PARAMs and LOC_PROTOs in many cases.  This increases the space
efficiency of the representation, since deduplication of LOC_PARAM and
LOC_PROTO reduces overall size.  LOCSEC data cannot be deduplicated since
they are site-specific, so will always be the long pole in any
representation.

As mentioned above, x86_64 vmlinux built with gcc 14 has 443354 inline sites.

Of these 443,354 locations

- 318161 (~71%) have location information for all function parameters
  (where there are 0 or more parameters)
- 76520 (~17%) have incomplete location information; some parameters are
  available. For these the vast majority (67070) have only one missing
  parameter location.
- 48673 (~11%) have no location info for any of their parameters (where
  there are 1 or more parameters)

Some of these gaps result from unhandled location data, specifically
DW_OP_GNU_parameter_ref (of which there are 1296 instances) and some from
complex location expressions, so we could potentially improve location
processing to add more locations if we handled these.

In terms of BTF encoding, we wind up with 12010 LOC_PARAM which are
referenced in various combinations from 37061 LOC_PROTO. We see that
given that there are over 400,000 inline sites, deduplication has
considerably cut down on the overhead of representing this information.

LOCSEC will be 443354*16 bytes, i.e. 6.76 Mb. Between extra FUNC_PROTO,
LOC_PROTO, LOC_PARAM and LOCSECs we wind up adding 9.2Mb to accommodate
443354 inline sites and all their metadata. This works out as
approximately 22 bytes to fully represent each inline site, so we can
see the benefits of deduplication of LOC_PARAM and LOC_PROTOs in this scheme.

When vmlinux BTF inline-related info (FUNC_PROTO, LOC_PARAM, LOC_PROTO
and LOCSECs are delivered via a module (btf_extra.ko.gz), the on-disk
size of that module with compression drops from 9.2Mb to 2.8Mb.

Modules also provide .BTF.extra info in their .BTF.extra sections; we
can see the stats for these as follows:

$ find . -name *.ko|xargs objdump -h |grep ".BTF.extra"|awk '{ sum += strtonum("0x"$3); count++ } END { print "total (kbytes): " sum/1024 " num modules: " count " average(kbytes): " sum/1024/count}'
total (kbytes): 46653.5 num modules: 3044 average(kbytes): 15.3264

So we add 46Mb of .BTF.extra data in total across 3044 modules, averaging
15kbytes per module.

Future work/questions

- the same scheme could be used to represent functions with optimized-out
  parameters (which we leave out of BTF encoding), hence the more general
  "location" term (as opposed to calling them inlines)
- perhaps we should have a separate CONFIG_DEBUG_INFO_BTF_EXTRA_MODULES=y|n
  as we do with CONFIG_DEBUG_INFO_BTF_MODULES?
- .BTF.extra is probably a bad name, given that we have .BTF.ext already...
- not yet implemented is location encoding for out-of-tree modules that
  use distilled base BTF. The reason is we need to have distill and
  BTF relocation working for multi-split BTF. That is doable but not
  implemented in this series.

Patch 1 adds UAPI/kernel support for BTF location info.  Note the
kernel does not do anything with location data; it will later be
made available however.

Patch 2 is libbpf support including deduplication, distill,
relocation and field iteration.  Note that distill/relocation for
multi-split BTF (used for out-of-tree modules) is not yet impelemented.

Patch 3 is needed because deduplication results in changes in
BTF ids and we stash some in pahole when saving BTF location data.
Having access to the mappings makes dealing with this easier.

Patch 4 fixes a bug in parsing of multi-split BTF (missed when adding
support to create multi-split BTF).

Patch 5 adds bpftool dump support for location data.

Patch 6 adds support to bpftool dump to deal with multiple split BTF
so we can dump location data from modules.

Patches 7-10 are selftests covering various aspects of location support.

Patches 11, 12 add kbuild support for adding BTF extra information; to
actually generate it an updated pahole with the associated libbpf
changes in patches 2-4 above is needed.

Patch 13 adds a libbpf function to load BTF extra data.

Patch 14 adds libbpf support to allow users to trace inlines
via SEC("kloc/module:name") sections.  Support is very similar to
USDT with info retrieved from BTF extra sections instead of ELF notes.
kloc tracing will trace all instances of the named inline site,
filling in parameters via the BPF_KPROBE()-like BPF_KLOC() macro.

Patch 15 is a simple test exercising this functionality.

[1] https://github.com/alan-maguire/dwarves/tree/pahole-location-encoding
[2] https://lore.kernel.org/dwarves/20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com/
[3] https://lpc.events/event/18/contributions/1945/

Alan Maguire (15):
  bpf: Extend UAPI to support location information
  libbpf: Add support for BTF kinds LOC_PARAM, LOC_PROTO and LOCSEC
  libbpf: Add option to retrieve map from old->new ids from btf__dedup()
  libbpf: Fix parsing of multi-split BTF
  bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC
  bpftool: Handle multi-split BTF by supporting multiple base BTFs
  selftests/bpf: Test helper support for BTF_KIND_LOC[_PARAM|_PROTO|SEC]
  selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to field iter tests
  selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to dedup split tests
  selftests/bpf: BTF distill tests to ensure LOC[_PARAM|_PROTO] add to
    split BTF
  kbuild: Add support for extra BTF
  kbuild, module, bpf: Support CONFIG_DEBUG_INFO_BTF_EXTRA=m
  libbpf: add API to load extra BTF
  libbpf: add support for BTF location attachment
  selftests/bpf: Add test tracing inline site using SEC("kloc")

 include/asm-generic/vmlinux.lds.h             |   4 +
 include/linux/bpf.h                           |   1 +
 include/linux/btf.h                           |  31 +-
 include/linux/module.h                        |   4 +
 include/uapi/linux/btf.h                      |  85 ++-
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/btf.c                              | 282 +++++++-
 kernel/bpf/btf_extra.c                        |  25 +
 kernel/bpf/sysfs_btf.c                        |  21 +-
 kernel/module/main.c                          |   4 +
 lib/Kconfig.debug                             |  18 +
 scripts/Makefile.btf                          |   9 +
 scripts/Makefile.modfinal                     |   5 +
 scripts/link-vmlinux.sh                       |  19 +-
 tools/bpf/bpftool/btf.c                       |  95 +++
 tools/bpf/bpftool/main.c                      |   3 +-
 tools/include/uapi/linux/btf.h                |  85 ++-
 tools/lib/bpf/Build                           |   2 +-
 tools/lib/bpf/Makefile                        |   2 +-
 tools/lib/bpf/btf.c                           | 384 +++++++++-
 tools/lib/bpf/btf.h                           |  96 ++-
 tools/lib/bpf/btf_dump.c                      |  10 +-
 tools/lib/bpf/btf_iter.c                      |  23 +
 tools/lib/bpf/libbpf.c                        |  76 +-
 tools/lib/bpf/libbpf.h                        |  27 +
 tools/lib/bpf/libbpf.map                      |   7 +
 tools/lib/bpf/libbpf_internal.h               |  11 +-
 tools/lib/bpf/loc.bpf.h                       | 297 ++++++++
 tools/lib/bpf/loc.c                           | 653 ++++++++++++++++++
 tools/testing/selftests/bpf/btf_helpers.c     |  43 +-
 .../bpf/prog_tests/btf_dedup_split.c          |  93 +++
 .../selftests/bpf/prog_tests/btf_distill.c    |  68 ++
 .../selftests/bpf/prog_tests/btf_field_iter.c |  26 +-
 tools/testing/selftests/bpf/prog_tests/kloc.c |  51 ++
 tools/testing/selftests/bpf/progs/kloc.c      |  36 +
 tools/testing/selftests/bpf/test_btf.h        |  15 +
 36 files changed, 2551 insertions(+), 61 deletions(-)
 create mode 100644 kernel/bpf/btf_extra.c
 create mode 100644 tools/lib/bpf/loc.bpf.h
 create mode 100644 tools/lib/bpf/loc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kloc.c
 create mode 100644 tools/testing/selftests/bpf/progs/kloc.c

-- 
2.39.3


