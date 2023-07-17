Return-Path: <bpf+bounces-5110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7690E7567D7
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C351C2031C
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B268CBA44;
	Mon, 17 Jul 2023 15:24:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44F253DC
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 15:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF3FC433C7;
	Mon, 17 Jul 2023 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689607492;
	bh=jfsyJNrolIUjYdnOxE9K/vaKVHqekN0muXVvxqmYTwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0QIKRYqbqOunmlZej0c6MOtavCWOma/HQor1eBeB5aUhCj9cCes5zRUs0EzehPsd
	 3ZQHFe7jGl3p7a+a3jCxwpZ1wPwGEbCfbGPrbda3oKZ6unysYT6coxbgWNCz8Pu3Ev
	 m7xu4WRWzCaZdRD6Xbu4CqWPgLT5W6Qkx6xKTU23PXgASD0YLan0E/Y0SqyGl4V0a0
	 3K05gn6FEy626Qhjtkjz6vgioW2Q+tqYg5U2rKLVPVFsyL3umvYBDhRx38B5Bfy7q+
	 zbFByA7C0PZRE3oU+dhZM/9Uhuzwak/bmBU0KHEQkGAQhwyN3GFck1UY8t8wRkLlm9
	 7LKpuJFjpofPA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 9/9] Documentation: tracing: Update fprobe event example with BTF field
Date: Tue, 18 Jul 2023 00:24:47 +0900
Message-Id: <168960748753.34107.1941635032108706544.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <168960739768.34107.15145201749042174448.stgit@devnote2>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Update fprobe event example with BTF data structure field specification.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Remove 'retval' and use '$retval'.
---
 Documentation/trace/fprobetrace.rst |   50 ++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index 7297f9478459..e9e764fadf14 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -79,9 +79,9 @@ automatically set by the given name. ::
  f:fprobes/myprobe vfs_read count=count pos=pos
 
 It also chooses the fetch type from BTF information. For example, in the above
-example, the ``count`` is unsigned long, and the ``pos`` is a pointer. Thus, both
-are converted to 64bit unsigned long, but only ``pos`` has "%Lx" print-format as
-below ::
+example, the ``count`` is unsigned long, and the ``pos`` is a pointer. Thus,
+both are converted to 64bit unsigned long, but only ``pos`` has "%Lx"
+print-format as below ::
 
  # cat events/fprobes/myprobe/format
  name: myprobe
@@ -105,9 +105,33 @@ is expanded to all function arguments of the function or the tracepoint. ::
  # cat dynamic_events
  f:fprobes/myprobe vfs_read file=file buf=buf count=count pos=pos
 
-BTF also affects the ``$retval``. If user doesn't set any type, the retval type is
-automatically picked from the BTF. If the function returns ``void``, ``$retval``
-is rejected.
+BTF also affects the ``$retval``. If user doesn't set any type, the retval
+type is automatically picked from the BTF. If the function returns ``void``,
+``$retval`` is rejected.
+
+You can access the data fields of a data structure using allow operator ``->``
+(for pointer type) and dot operator ``.`` (for data structure type.)::
+
+# echo 't sched_switch preempt prev_pid=prev->pid next_pid=next->pid' >> dynamic_events
+
+This data field access is available for the return value via ``$retval``,
+e.g. ``$retval->name``.
+
+For these BTF arguments and fields, ``:string`` and ``:ustring`` change the
+behavior. If these are used for BTF argument or field, it checks whether
+the BTF type of the argument or the data field is ``char *`` or ``char []``,
+or not.  If not, it rejects applying the string types. Also, with the BTF
+support, you don't need a memory dereference operator (``+0(PTR)``) for
+accessing the string pointed by a ``PTR``. It automatically adds the memory
+dereference operator according to the BTF type. e.g. ::
+
+# echo 't sched_switch prev->comm:string' >> dynamic_events
+# echo 'f getname_flags%return $retval->name:string' >> dynamic_events
+
+The ``prev->comm`` is an embedded char array in the data structure, and
+``$retval->name`` is a char pointer in the data structure. But in both
+cases, you can use ``:string`` type to get the string.
+
 
 Usage examples
 --------------
@@ -161,10 +185,10 @@ parameters. This means you can access any field values in the task
 structure pointed by the ``prev`` and ``next`` arguments.
 
 For example, usually ``task_struct::start_time`` is not traced, but with this
-traceprobe event, you can trace it as below.
+traceprobe event, you can trace that field as below.
 ::
 
-  # echo 't sched_switch comm=+1896(next):string start_time=+1728(next):u64' > dynamic_events
+  # echo 't sched_switch comm=next->comm:string next->start_time' > dynamic_events
   # head -n 20 trace | tail
  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
  #              | |         |   |||||     |         |
@@ -176,13 +200,3 @@ traceprobe event, you can trace it as below.
            <idle>-0       [000] d..3.  5606.690317: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="kworker/0:1" usage=1 start_time=137000000
       kworker/0:1-14      [000] d..3.  5606.690339: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="swapper/0" usage=2 start_time=0
            <idle>-0       [000] d..3.  5606.692368: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="kworker/0:1" usage=1 start_time=137000000
-
-Currently, to find the offset of a specific field in the data structure,
-you need to build kernel with debuginfo and run `perf probe` command with
-`-D` option. e.g.
-::
-
- # perf probe -D "__probestub_sched_switch next->comm:string next->start_time"
- p:probe/__probestub_sched_switch __probestub_sched_switch+0 comm=+1896(%cx):string start_time=+1728(%cx):u64
-
-And replace the ``%cx`` with the ``next``.


