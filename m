Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17025124345
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 10:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLRJbT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 04:31:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:41254 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfLRJbS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Dec 2019 04:31:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 01:31:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,329,1571727600"; 
   d="scan'208";a="218091630"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 18 Dec 2019 01:31:17 -0800
Received: from [10.125.252.219] (abudanko-mobl.ccr.corp.intel.com [10.125.252.219])
        by linux.intel.com (Postfix) with ESMTP id 33127580458;
        Wed, 18 Dec 2019 01:31:09 -0800 (PST)
Subject: [PATCH v4 9/9] drivers/oprofile: open access for CAP_SYS_PERFMON
 privileged process
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Robert Richter <rric@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, oprofile-list@lists.sf.net
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
Organization: Intel Corp.
Message-ID: <70eb48f8-34ae-8aa3-ca64-d433b75ea2ae@linux.intel.com>
Date:   Wed, 18 Dec 2019 12:31:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Open access to monitoring for CAP_SYS_PERFMON privileged processes.
For backward compatibility reasons access to the monitoring remains open
for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for secure
monitoring is discouraged with respect to CAP_SYS_PERFMON capability.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 drivers/oprofile/event_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/oprofile/event_buffer.c b/drivers/oprofile/event_buffer.c
index 12ea4a4ad607..6c9edc8bbc95 100644
--- a/drivers/oprofile/event_buffer.c
+++ b/drivers/oprofile/event_buffer.c
@@ -113,7 +113,7 @@ static int event_buffer_open(struct inode *inode, struct file *file)
 {
 	int err = -EPERM;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!perfmon_capable())
 		return -EPERM;
 
 	if (test_and_set_bit_lock(0, &buffer_opened))
-- 
2.20.1


