Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1943B166D55
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 04:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgBUDQa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 22:16:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:59596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbgBUDQa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 22:16:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 22257ADA3;
        Fri, 21 Feb 2020 03:16:28 +0000 (UTC)
From:   Michal Rostecki <mrostecki@opensuse.org>
To:     bpf@vger.kernel.org
Cc:     Michal Rostecki <mrostecki@opensuse.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v2 3/5] bpftool: Update documentation of "bpftool feature" command
Date:   Fri, 21 Feb 2020 04:16:58 +0100
Message-Id: <20200221031702.25292-4-mrostecki@opensuse.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221031702.25292-1-mrostecki@opensuse.org>
References: <20200221031702.25292-1-mrostecki@opensuse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update documentation of "bpftool feature" command with information about
new arguments: "full".

Signed-off-by: Michal Rostecki <mrostecki@opensuse.org>
---
 .../bpf/bpftool/Documentation/bpftool-feature.rst | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-feature.rst b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
index 4d08f35034a2..2e8f66ee1e77 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-feature.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
@@ -19,19 +19,24 @@ SYNOPSIS
 FEATURE COMMANDS
 ================
 
-|	**bpftool** **feature probe** [*COMPONENT*] [**macros** [**prefix** *PREFIX*]]
+|	**bpftool** **feature probe** [*COMPONENT*] [**full**] [**macros** [**prefix** *PREFIX*]]
 |	**bpftool** **feature help**
 |
 |	*COMPONENT* := { **kernel** | **dev** *NAME* }
 
 DESCRIPTION
 ===========
-	**bpftool feature probe** [**kernel**] [**macros** [**prefix** *PREFIX*]]
+	**bpftool feature probe** [**kernel**] [**full**] [**macros** [**prefix** *PREFIX*]]
 		  Probe the running kernel and dump a number of eBPF-related
 		  parameters, such as availability of the **bpf()** system call,
 		  JIT status, eBPF program types availability, eBPF helper
 		  functions availability, and more.
 
+		  By default, bpftool does not run probes for
+		  bpf_probe_write_user and bpf_trace_printk helpers which emit
+		  dmesg warnings. To enable them and run all probes, the
+		  **full** keyword should be used.
+
 		  If the **macros** keyword (but not the **-j** option) is
 		  passed, a subset of the output is dumped as a list of
 		  **#define** macros that are ready to be included in a C
@@ -48,12 +53,12 @@ DESCRIPTION
 		  **bpf_trace_printk**\ () or **bpf_probe_write_user**\ ()) may
 		  print warnings to kernel logs.
 
-	**bpftool feature probe dev** *NAME* [**macros** [**prefix** *PREFIX*]]
+	**bpftool feature probe dev** *NAME* [**full**] [**macros** [**prefix** *PREFIX*]]
 		  Probe network device for supported eBPF features and dump
 		  results to the console.
 
-		  The two keywords **macros** and **prefix** have the same
-		  role as when probing the kernel.
+		  The keywords **full**, **macros** and **prefix** have the
+		  same role as when probing the kernel.
 
 	**bpftool feature help**
 		  Print short help message.
-- 
2.25.0

