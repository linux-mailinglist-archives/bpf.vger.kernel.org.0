Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0343C14A6EA
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 16:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgA0PHU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 10:07:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:25102 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbgA0PHU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 10:07:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 07:02:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,370,1574150400"; 
   d="scan'208";a="305900030"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2020 07:02:54 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iw5ug-000Cov-16; Mon, 27 Jan 2020 23:02:54 +0800
Date:   Mon, 27 Jan 2020 23:02:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, Brendan Gregg <brendan.d.gregg@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>, mhiramat@kernel.org,
        Ingo Molnar <mingo@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [RFC PATCH] tracing/kprobe: trace_kprobe_disabled_finished can be
 static
Message-ID: <20200127150243.bllddfobxryxagwd@f53c9c00458a>
References: <157918590192.29301.6909688694265698678.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157918590192.29301.6909688694265698678.stgit@devnote2>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Fixes: 3c794bf25a2b ("tracing/kprobe: Use call_rcu to defer freeing event_file_link")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 trace_kprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 1a5882bb77471..fba738aa458af 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -328,7 +328,7 @@ static inline int __enable_trace_kprobe(struct trace_kprobe *tk)
 	return ret;
 }
 
-atomic_t trace_kprobe_disabled_finished;
+static atomic_t trace_kprobe_disabled_finished;
 
 static void trace_kprobe_disabled_handlers_finish(void)
 {
