Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89D926FEAE
	for <lists+bpf@lfdr.de>; Fri, 18 Sep 2020 15:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgIRNgn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Sep 2020 09:36:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47382 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgIRNgm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Sep 2020 09:36:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IDYYtW098550;
        Fri, 18 Sep 2020 13:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=vVO2dqI3Hu2lDSzIOuSUh07ftmDih38AG3cWYXUzy1U=;
 b=MvynwSzWJ8nS7P3YOtthNt9ooTtkgdDWaUxtsa9GqoNbchSUrnDEYgfqAXKw9Kc+1/+t
 Kf0ke/9EDk0flB4qIVTci/NYjRz+X9XBvzDEI6zvAWm7FyVZtla05ogCSZFvkqtskHXk
 SVVzDeqBGlg/Mc905ZORKhdEMVHCSlWOSgntyZWE0fF3Mt2VoBHcXMl3D1yuO+AeHOSv
 LpEhiLtigTgYzo8oqtsALqwc8qZRq2xJ0/FKawDGfiWLBmzVuD7mO+oMrsI77lW6vhnx
 kHBNJAw7nw/TVdFLTubtsjLLr6umwCOE1Nb0XHmVIyQNlt5RIekYiIyz48ikDHkdlWaA jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33j91e0uny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 13:35:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IDYwfv091789;
        Fri, 18 Sep 2020 13:35:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33megbeqd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 13:35:40 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08IDZYrg018285;
        Fri, 18 Sep 2020 13:35:34 GMT
Received: from localhost.uk.oracle.com (/10.175.217.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Sep 2020 13:35:33 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andriin@fb.com, yhs@fb.com
Cc:     linux@rasmusvillemoes.dk, andriy.shevchenko@linux.intel.com,
        pmladek@suse.com, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, shuah@kernel.org,
        rdna@fb.com, scott.branden@broadcom.com, quentin@isovalent.com,
        cneirabustos@gmail.com, jakub@cloudflare.com, mingo@redhat.com,
        rostedt@goodmis.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        acme@kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 0/6] bpf: add helpers to support BTF-based kernel data display
Date:   Fri, 18 Sep 2020 14:34:29 +0100
Message-Id: <1600436075-2961-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180110
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series attempts to provide a simple way for BPF programs (and in
future other consumers) to utilize BPF Type Format (BTF) information
to display kernel data structures in-kernel.  The use case this
functionality is applied to here is to support a snprintf()-like
helper to copy a BTF representation of kernel data to a string,
and a BPF seq file helper to display BTF data for an iterator.

There is already support in kernel/bpf/btf.c for "show" functionality;
the changes here generalize that support from seq-file specific
verifier display to the more generic case and add another specific
use case; rather than seq_printf()ing the show data, it is copied
to a supplied string using a snprintf()-like function.  Other future
consumers of the show functionality could include a bpf_printk_btf()
function which printk()ed the data instead.  Oops messaging in
particular would be an interesting application for such functionality.

The above potential use case hints at a potential reply to
a reasonable objection that such typed display should be
solved by tracing programs, where the in-kernel tracing records
data and the userspace program prints it out.  While this
is certainly the recommended approach for most cases, I
believe having an in-kernel mechanism would be valuable
also.  Critically in BPF programs it greatly simplifies
debugging and tracing of such data to invoking a simple
helper.

One challenge raised in an earlier iteration of this work -
where the BTF printing was implemented as a printk() format
specifier - was that the amount of data printed per
printk() was large, and other format specifiers were far
simpler.  Here we sidestep that concern by printing
components of the BTF representation as we go for the
seq file case, and in the string case the snprintf()-like
operation is intended to be a basis for perf event or
ringbuf output.  The reasons for avoiding bpf_trace_printk
are that

1. bpf_trace_printk() strings are restricted in size and
cannot display anything beyond trivial data structures; and
2. bpf_trace_printk() is for debugging purposes only.

As Alexei suggested, a bpf_trace_puts() helper could solve
this in the future but it still would be limited by the
1000 byte limit for traced strings.

Default output for an sk_buff looks like this (zeroed fields
are omitted):

(struct sk_buff){
 .transport_header = (__u16)65535,
 .mac_header = (__u16)65535,
 .end = (sk_buff_data_t)192,
 .head = (unsigned char *)0x000000007524fd8b,
 .data = (unsigned char *)0x000000007524fd8b,
 .truesize = (unsigned int)768,
 .users = (refcount_t){
  .refs = (atomic_t){
   .counter = (int)1,
  },
 },
}

Flags can modify aspects of output format; see patch 3
for more details.

Changes since v4:

- Changed approach from a BPF trace event-centric design to one
  utilizing a snprintf()-like helper and an iter helper (Alexei,
  patches 3,5)
- Added tests to verify BTF output (patch 4)
- Added support to tests for verifying BTF type_id-based display
  as well as type name via __builtin_btf_type_id (Andrii, patch 4).
- Augmented task iter tests to cover the BTF-based seq helper.
  Because a task_struct's BTF-based representation would overflow
  the PAGE_SIZE limit on iterator data, the "struct fs_struct"
  (task->fs) is displayed for each task instead (Alexei, patch 6).

Changes since v3:

- Moved to RFC since the approach is different (and bpf-next is
  closed)
- Rather than using a printk() format specifier as the means
  of invoking BTF-enabled display, a dedicated BPF helper is
  used.  This solves the issue of printk() having to output
  large amounts of data using a complex mechanism such as
  BTF traversal, but still provides a way for the display of
  such data to be achieved via BPF programs.  Future work could
  include a bpf_printk_btf() function to invoke display via
  printk() where the elements of a data structure are printk()ed
  one at a time.  Thanks to Petr Mladek, Andy Shevchenko and
  Rasmus Villemoes who took time to look at the earlier printk()
  format-specifier-focused version of this and provided feedback
  clarifying the problems with that approach.
- Added trace id to the bpf_trace_printk events as a means of
  separating output from standard bpf_trace_printk() events,
  ensuring it can be easily parsed by the reader.
- Added bpf_trace_btf() helper tests which do simple verification
  of the various display options.

Changes since v2:

- Alexei and Yonghong suggested it would be good to use
  probe_kernel_read() on to-be-shown data to ensure safety
  during operation.  Safe copy via probe_kernel_read() to a
  buffer object in "struct btf_show" is used to support
  this.  A few different approaches were explored
  including dynamic allocation and per-cpu buffers. The
  downside of dynamic allocation is that it would be done
  during BPF program execution for bpf_trace_printk()s using
  %pT format specifiers. The problem with per-cpu buffers
  is we'd have to manage preemption and since the display
  of an object occurs over an extended period and in printk
  context where we'd rather not change preemption status,
  it seemed tricky to manage buffer safety while considering
  preemption.  The approach of utilizing stack buffer space
  via the "struct btf_show" seemed like the simplest approach.
  The stack size of the associated functions which have a
  "struct btf_show" on their stack to support show operation
  (btf_type_snprintf_show() and btf_type_seq_show()) stays
  under 500 bytes. The compromise here is the safe buffer we
  use is small - 256 bytes - and as a result multiple
  probe_kernel_read()s are needed for larger objects. Most
  objects of interest are smaller than this (e.g.
  "struct sk_buff" is 224 bytes), and while task_struct is a
  notable exception at ~8K, performance is not the priority for
  BTF-based display. (Alexei and Yonghong, patch 2).
- safe buffer use is the default behaviour (and is mandatory
  for BPF) but unsafe display - meaning no safe copy is done
  and we operate on the object itself - is supported via a
  'u' option.
- pointers are prefixed with 0x for clarity (Alexei, patch 2)
- added additional comments and explanations around BTF show
  code, especially around determining whether objects such
  zeroed. Also tried to comment safe object scheme used. (Yonghong,
  patch 2)
- added late_initcall() to initialize vmlinux BTF so that it would
  not have to be initialized during printk operation (Alexei,
  patch 5)
- removed CONFIG_BTF_PRINTF config option as it is not needed;
  CONFIG_DEBUG_INFO_BTF can be used to gate test behaviour and
  determining behaviour of type-based printk can be done via
  retrieval of BTF data; if it's not there BTF was unavailable
  or broken (Alexei, patches 4,6)
- fix bpf_trace_printk test to use vmlinux.h and globals via
  skeleton infrastructure, removing need for perf events
  (Andrii, patch 8)

Changes since v1:

- changed format to be more drgn-like, rendering indented type info
  along with type names by default (Alexei)
- zeroed values are omitted (Arnaldo) by default unless the '0'
  modifier is specified (Alexei)
- added an option to print pointer values without obfuscation.
  The reason to do this is the sysctls controlling pointer display
  are likely to be irrelevant in many if not most tracing contexts.
  Some questions on this in the outstanding questions section below...
- reworked printk format specifer so that we no longer rely on format
  %pT<type> but instead use a struct * which contains type information
  (Rasmus). This simplifies the printk parsing, makes use more dynamic
  and also allows specification by BTF id as well as name.
- removed incorrect patch which tried to fix dereferencing of resolved
  BTF info for vmlinux; instead we skip modifiers for the relevant
  case (array element type determination) (Alexei).
- fixed issues with negative snprintf format length (Rasmus)
- added test cases for various data structure formats; base types,
  typedefs, structs, etc.
- tests now iterate through all typedef, enum, struct and unions
  defined for vmlinux BTF and render a version of the target dummy
  value which is either all zeros or all 0xff values; the idea is this
  exercises the "skip if zero" and "print everything" cases.
- added support in BPF for using the %pT format specifier in
  bpf_trace_printk()
- added BPF tests which ensure %pT format specifier use works (Alexei).

Alan Maguire (6):
  bpf: provide function to get vmlinux BTF information
  bpf: move to generic BTF show support, apply it to seq files/strings
  bpf: add bpf_btf_snprintf helper
  selftests/bpf: add bpf_btf_snprintf helper tests
  bpf: add bpf_seq_btf_write helper
  selftests/bpf: add test for bpf_seq_btf_write helper

 include/linux/bpf.h                                |   3 +
 include/linux/btf.h                                |  40 +
 include/uapi/linux/bpf.h                           |  78 ++
 kernel/bpf/btf.c                                   | 978 ++++++++++++++++++---
 kernel/bpf/helpers.c                               |   4 +
 kernel/bpf/verifier.c                              |  18 +-
 kernel/trace/bpf_trace.c                           | 133 +++
 scripts/bpf_helpers_doc.py                         |   2 +
 tools/include/uapi/linux/bpf.h                     |  78 ++
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |  66 ++
 .../selftests/bpf/prog_tests/btf_snprintf.c        |  55 ++
 .../selftests/bpf/progs/bpf_iter_task_btf.c        |  49 ++
 .../selftests/bpf/progs/netif_receive_skb.c        | 260 ++++++
 13 files changed, 1656 insertions(+), 108 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_snprintf.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_task_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/netif_receive_skb.c

-- 
1.8.3.1

