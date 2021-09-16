Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BCC40E135
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 18:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbhIPQ20 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 12:28:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46528 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241904AbhIPQ0Z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 12:26:25 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GFguOj013873
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2cu7M1XN333AkrNxBZ+o94KMysrS0P569VxSX016dYs=;
 b=MmSzQSdYuaRZErA8QQfKCZ53aYn18ZMDL8gL52P/NhIrjfjtNqMwVirmE67jRFNTL9mm
 MucMu6kpamO+SU8TJUBSLs5UAoyPOol6159hKnVHnqvh7LCGeQmoJ/vY89C/CL8RoeHw
 51zu/nFJvjeWwCIngsKYyrHW0Kui7SYlLSA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b47j40x4p-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:04 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 09:25:03 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 24B69BE68AA8; Thu, 16 Sep 2021 09:25:02 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mel Gorman <mgorman@techsingularity.net>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 0/6] Scheduler BPF
Date:   Thu, 16 Sep 2021 09:24:45 -0700
Message-ID: <20210916162451.709260-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915213550.3696532-1-guro@fb.com>
References: <20210915213550.3696532-1-guro@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: vpH0i9WiJUK0nruaU4LW9Caxrzw4MqRE
X-Proofpoint-GUID: vpH0i9WiJUK0nruaU4LW9Caxrzw4MqRE
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_04,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 mlxlogscore=824 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is a long history of distro people, system administrators, and
application owners tuning the CFS settings in /proc/sys, which are now
in debugfs. Looking at what these settings actually did, it ended up
boiling down to changing the likelihood of task preemption, or
disabling it by setting the wakeup_granularity_ns to more than half of
the latency_ns. The other settings didn't really do much for
performance.

In other words, some our workloads benefit by having long running tasks
preempted by tasks handling short running requests, and some workloads
that run only short term requests which benefit from never being preempted.

This leads to a few observations and ideas:
- Different workloads want different policies. Being able to configure
  the policy per workload could be useful.
- A workload that benefits from not being preempted itself could still
  benefit from preempting (low priority) background system tasks.
- It would be useful to quickly (and safely) experiment with different
  policies in production, without having to shut down applications or reboot
  systems, to determine what the policies for different workloads should be.
- Only a few workloads are large and sensitive enough to merit their own
  policy tweaks. CFS by itself should be good enough for everything else,
  and we probably do not want policy tweaks to be a replacement for anything
  CFS does.

This leads to BPF hooks, which have been successfully used in various
kernel subsystems to provide a way for external code to (safely)
change a few kernel decisions. BPF tooling makes this pretty easy to do,
and the people deploying BPF scripts are already quite used to updating them
for new kernel versions.

This patchset aims to start a discussion about potential applications of BPF
to the scheduler. It also aims to land some very basic BPF infrastructure
necessary to add new BPF hooks to the scheduler, a minimal set of useful
helpers, corresponding libbpf changes, etc.

Our very first experiments with using BPF in CFS look very promising. We're
at a very early stage, however already have seen a nice latency and ~1% RPS
wins for our (Facebook's) main web workload.

As I know, Google is working on a more radical approach [2]: they aim to mo=
ve
the scheduling code into userspace. It seems that their core motivation is
somewhat similar: to make the scheduler changes easier to develop, validate
and deploy. Even though their approach is different, they also use BPF for
speeding up some hot paths. I think the suggested infrastructure can serve
their purpose too.

An example of an userspace part, which loads some simple hooks is available
here [3]. It's very simple, provided only to simplify playing with the prov=
ided
kernel patches.


[1] c722f35b513f ("sched/fair: Bring back select_idle_smt(), but differentl=
y")
[2] Google's ghOSt: https://linuxplumbersconf.org/event/11/contributions/95=
4/
[3] https://github.com/rgushchin/atc


Roman Gushchin (6):
  bpf: sched: basic infrastructure for scheduler bpf
  bpf: sched: add convenient helpers to identify sched entities
  bpf: sched: introduce bpf_sched_enable()
  sched: cfs: add bpf hooks to control wakeup and tick preemption
  libbpf: add support for scheduler bpf programs
  bpftool: recognize scheduler programs

 include/linux/bpf_sched.h       |  53 ++++++++++++
 include/linux/bpf_types.h       |   3 +
 include/linux/sched_hook_defs.h |   4 +
 include/uapi/linux/bpf.h        |  25 ++++++
 kernel/bpf/btf.c                |   1 +
 kernel/bpf/syscall.c            |  21 ++++-
 kernel/bpf/trampoline.c         |   1 +
 kernel/bpf/verifier.c           |   9 ++-
 kernel/sched/Makefile           |   1 +
 kernel/sched/bpf_sched.c        | 138 ++++++++++++++++++++++++++++++++
 kernel/sched/fair.c             |  27 +++++++
 scripts/bpf_doc.py              |   2 +
 tools/bpf/bpftool/common.c      |   1 +
 tools/bpf/bpftool/prog.c        |   1 +
 tools/include/uapi/linux/bpf.h  |  25 ++++++
 tools/lib/bpf/libbpf.c          |  27 ++++++-
 tools/lib/bpf/libbpf.h          |   4 +
 tools/lib/bpf/libbpf.map        |   3 +
 18 files changed, 341 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/bpf_sched.h
 create mode 100644 include/linux/sched_hook_defs.h
 create mode 100644 kernel/sched/bpf_sched.c

--=20
2.31.1

