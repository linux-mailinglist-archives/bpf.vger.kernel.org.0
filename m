Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58BC111FEE6
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2019 08:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfLPHSE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Dec 2019 02:18:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:44493 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfLPHSE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Dec 2019 02:18:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2019 23:18:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,320,1571727600"; 
   d="scan'208";a="209211239"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 15 Dec 2019 23:18:03 -0800
Received: from [10.251.95.214] (abudanko-mobl.ccr.corp.intel.com [10.251.95.214])
        by linux.intel.com (Postfix) with ESMTP id 6834958044E;
        Sun, 15 Dec 2019 23:17:55 -0800 (PST)
Subject: [PATCH v2 5/7] trace/bpf_trace: open access for CAP_SYS_PERFMON
 privileged process
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        Alexei Starovoitov <ast@kernel.org>,
        james.bottomley@hansenpartnership.com, benh@kernel.crashing.org,
        Casey Schaufler <casey@schaufler-ca.com>, serge@hallyn.com,
        James Morris <jmorris@namei.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, bgregg@netflix.com,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <26101427-c0a3-db9f-39e9-9e5f4ddd009c@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e48f05eb-cca9-8dfa-9701-bcf5a96f035f@linux.intel.com>
Date:   Mon, 16 Dec 2019 10:17:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <26101427-c0a3-db9f-39e9-9e5f4ddd009c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Open access to bpf_trace monitoring for CAP_SYS_PERFMON privileged processes.
For backward compatibility reasons access to bpf_trace monitoring remains open
for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for secure
bpf_trace monitoring is discouraged with respect to CAP_SYS_PERFMON capability.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 44bd08f2443b..0231bb363ef9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1272,7 +1272,7 @@ int perf_event_query_prog_array(struct perf_event *event, void __user *info)
 	u32 *ids, prog_cnt, ids_len;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!(capable(CAP_SYS_PERFMON) || capable(CAP_SYS_ADMIN)))
 		return -EPERM;
 	if (event->attr.type != PERF_TYPE_TRACEPOINT)
 		return -EINVAL;
-- 
2.20.1


