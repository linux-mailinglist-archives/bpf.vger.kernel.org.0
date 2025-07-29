Return-Path: <bpf+bounces-64632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFB5B15037
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 17:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9488317BBE7
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 15:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E217A293C47;
	Tue, 29 Jul 2025 15:33:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F44217A2F8;
	Tue, 29 Jul 2025 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803224; cv=none; b=DlSiiZtSjr/AaDYC10zyI6u4GbdwVhchlbRQptXKdx4dqzcpkspkdqNj21IvzyFn+s4TfLRdU6ycasybNq8Suj0z276rKe6G/5AXgT4A/Uw2/1vyv3Efj5zP8YkHPYzz1SiKX4bGUOPoNMr8oDq4zb9eIT9VN6NIKzcUcJwewQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803224; c=relaxed/simple;
	bh=2IcOCGm1LA5lOY7AMsZ3YYDTTpnO0vRH8GvO6hA9Nls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=K9Ginr2bokKQ/48/BosFxjFPzt9x8hsPYHyRMQqAblngHkD/NB9M0bhu5jd64YwP1PKb3FDV6P5G7KI8AfffeNw8dmzbA1UpmCm08n7RYHr/K7ras707eMd/T1YXbXnrHLpTBcIQApnv87Rryk88gdmt+J8O7YcjxEHTpDYQSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id EEE45C0142;
	Tue, 29 Jul 2025 15:33:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 8A38230;
	Tue, 29 Jul 2025 15:33:35 +0000 (UTC)
Date: Tue, 29 Jul 2025 11:33:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, aahringo@redhat.com
Subject: [PATCH] tracing/probes: Allow use of BTF names to dereference
 pointers
Message-ID: <20250729113335.2e4f087d@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8A38230
X-Stat-Signature: f1o7q5n9fpkhzgrd7yw8anuq4xznz3xm
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18pA3cncbtVCHJGw40eqEaPE1HtKcX9AJ4=
X-HE-Tag: 1753803215-75147
X-HE-Meta: U2FsdGVkX1/fu05z8BG7HqWmUFiJrVsGyXz4rkF0zBMOzDL9D44Ld+OCPAUPwo5dO8jC68PI8e8pmtH3O3tqVH2+4zJcoIeeemv/Ha33zGORJEBCukIOpxY6Kvg3C4A4CWO/GjIHyZEwoVsOuxTX//vb1hh8hY6BMPUfFWnBBcBySrm67L7KJXlPFQuNsTbVi3aQO4OFsXnEBtJCAuinuVUJ+4s+xcZKIbhlkp0w5XZaeW3hQdALIledDpS1439SiQNQc6UXEjKecMgkH+xhO80G0ndFs7bYJR86NoPlMjJC60G22CNvlq7sZo6yC3x98ijmM0ksVmF7siB3FVXCzpaxu6CRpODEbYa+MvC/tUU0p/K7US7xAU6oDConLZS4

From: Steven Rostedt <rostedt@goodmis.org>

Add syntax to the FETCHARGS parsing of probes to allow the use of
structure and member names to get the offsets to dereference pointers.

Currently, a dereference must be a number, where the user has to figure
out manually the offset of a member of a structure that they want to
reference. For example, to get the size of a kmem_cache that was passed to
the function kmem_cache_alloc_noprof, one would need to do:

 # cd /sys/kernel/tracing
 # echo 'f:cache kmem_cache_alloc_noprof size=+0x18($arg1):u32' >> dynamic_events

This requires knowing that the offset of size is 0x18, which can be found
with gdb:

  (gdb) p &((struct kmem_cache *)0)->size
  $1 = (unsigned int *) 0x18

If BTF is in the kernel, it can be used to find this with names, where the
user doesn't need to find the actual offset:

 # echo 'f:cache kmem_cache_alloc_noprof size=+kmem_cache.size($arg1):u32' >> dynamic_events

Instead of the "+0x18", it would have "+kmem_cache.size" where the format is:

  +STRUCT.MEMBER[.MEMBER[..]]

The delimiter is '.' and the first item is the structure name. Then the
member of the structure to get the offset of. If that member is an
embedded structure, another '.MEMBER' may be added to get the offset of
its members with respect to the original value.

  "+kmem_cache.size($arg1)" is equivalent to:

  (*(struct kmem_cache *)$arg1).size

Anonymous structures are also handled:

  # echo 'e:xmit net.net_dev_xmit +net_device.name(+sk_buff.dev($skbaddr)):string' >> dynamic_events

Where "+net_device.name(+sk_buff.dev($skbaddr))" is equivalent to:

  (*(struct net_device *)((*(struct sk_buff *)($skbaddr))->dev)->name)

Note that "dev" of struct sk_buff is inside an anonymous structure:

struct sk_buff {
	union {
		struct {
			/* These two members must be first to match sk_buff_head. */
			struct sk_buff		*next;
			struct sk_buff		*prev;

			union {
				struct net_device	*dev;
				[..]
			};
		};
		[..]
	};

This will allow up to three deep of anonymous structures before it will
fail to find a member.

The above produces:

    sshd-session-1080    [000] b..5.  1526.337161: xmit: (net.net_dev_xmit) arg1="enp7s0"

And nested structures can be found by adding more members to the arg:

  # echo 'f:read filemap_readahead.isra.0 file=+0(+dentry.d_name.name(+file.f_path.dentry($arg2))):string' >> dynamic_events

The above is equivalent to:

  *((*(struct dentry *)(*(struct file *)$arg2)->f_path.dentry)->d_name.name)

And produces:

       trace-cmd-1381    [002] ...1.  2082.676268: read: (filemap_readahead.isra.0+0x0/0x150) file="trace.dat"

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/kprobetrace.rst |   3 +
 kernel/trace/trace_btf.c            | 106 ++++++++++++++++++++++++++++
 kernel/trace/trace_btf.h            |  10 +++
 kernel/trace/trace_probe.c          |   7 +-
 4 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 3b6791c17e9b..00273157100c 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -54,6 +54,8 @@ Synopsis of kprobe_events
   $retval	: Fetch return value.(\*2)
   $comm		: Fetch current task comm.
   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
+  +STRUCT.MEMBER[.MEMBER[..]](FETCHARG) : If BTF is supported, Fetch memory
+		  at FETCHARG + the offset of MEMBER inside of STRUCT.(\*5)
   \IMM		: Store an immediate value to the argument.
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
@@ -70,6 +72,7 @@ Synopsis of kprobe_events
         accesses one register.
   (\*3) this is useful for fetching a field of data structures.
   (\*4) "u" means user-space dereference. See :ref:`user_mem_access`.
+  (\*5) +STRUCT.MEMBER(FETCHARG) is equivalent to (*(struct STRUCT *)(FETCHARG)).MEMBER
 
 Function arguments at kretprobe
 -------------------------------
diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index 5bbdbcbbde3c..b69404451410 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -120,3 +120,109 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 	return member;
 }
 
+#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
+
+static int find_member(const char *ptr, struct btf *btf,
+		       const struct btf_type **type, int level)
+{
+	const struct btf_member *member;
+	const struct btf_type *t = *type;
+	int i;
+
+	/* Max of 3 depth of anonymous structures */
+	if (level > 3)
+		return -1;
+
+	for_each_member(i, t, member) {
+		const char *tname = btf_name_by_offset(btf, member->name_off);
+
+		if (strcmp(ptr, tname) == 0) {
+			*type = btf_type_by_id(btf, member->type);
+			return BITS_ROUNDDOWN_BYTES(member->offset);
+		}
+
+		/* Handle anonymous structures */
+		if (strlen(tname))
+			continue;
+
+		*type = btf_type_by_id(btf, member->type);
+		if (btf_type_is_struct(*type)) {
+			int offset = find_member(ptr, btf, type, level + 1);
+
+			if (offset < 0)
+				continue;
+
+			return offset + BITS_ROUNDDOWN_BYTES(member->offset);
+		}
+	}
+
+	return -1;
+}
+
+/**
+ * btf_find_offset - Find an offset of a member for a structure
+ * @arg: A structure name followed by one or more members
+ * @offset_p: A pointer to where to store the offset
+ *
+ * Will parse @arg with the expected format of: struct.member[[.member]..]
+ * It is delimited by '.'. The first item must be a structure type.
+ * The next are its members. If the member is also of a structure type it
+ * another member may follow ".member".
+ *
+ * Note, @arg is modified but will be put back to what it was on return.
+ *
+ * Returns: 0 on success and -EINVAL if no '.' is present
+ *    or -ENXIO if the structure or member is not found.
+ *    Returns -EINVAL if BTF is not defined.
+ *  On success, @offset_p will contain the offset of the member specified
+ *    by @arg.
+ */
+int btf_find_offset(char *arg, long *offset_p)
+{
+	const struct btf_type *t;
+	struct btf *btf;
+	long offset = 0;
+	char *ptr;
+	int ret;
+	s32 id;
+
+	ptr = strchr(arg, '.');
+	if (!ptr)
+		return -EINVAL;
+
+	*ptr = '\0';
+
+	id = bpf_find_btf_id(arg, BTF_KIND_STRUCT, &btf);
+	if (id < 0)
+		goto error;
+
+	/* Get BTF_KIND_FUNC type */
+	t = btf_type_by_id(btf, id);
+
+	/* May allow more than one member, as long as they are structures */
+	do {
+		if (!t || !btf_type_is_struct(t))
+			goto error;
+
+		*ptr++ = '.';
+		arg = ptr;
+		ptr = strchr(ptr, '.');
+		if (ptr)
+			*ptr = '\0';
+
+		ret = find_member(arg, btf, &t, 0);
+		if (ret < 0)
+			goto error;
+
+		offset += ret;
+
+	} while (ptr);
+
+	*offset_p = offset;
+	return 0;
+
+error:
+	if (ptr)
+		*ptr = '.';
+	return -ENXIO;
+}
diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
index 4bc44bc261e6..7b0797a6050b 100644
--- a/kernel/trace/trace_btf.h
+++ b/kernel/trace/trace_btf.h
@@ -9,3 +9,13 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 						const struct btf_type *type,
 						const char *member_name,
 						u32 *anon_offset);
+
+#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
+/* Will modify arg, but will put it back before returning. */
+int btf_find_offset(char *arg, long *offset);
+#else
+static inline int btf_find_offset(char *arg, long *offset)
+{
+	return -EINVAL;
+}
+#endif
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 424751cdf31f..4c13e51ea481 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1137,7 +1137,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 
 	case '+':	/* deref memory */
 	case '-':
-		if (arg[1] == 'u') {
+		if (arg[1] == 'u' && isdigit(arg[2])) {
 			deref = FETCH_OP_UDEREF;
 			arg[1] = arg[0];
 			arg++;
@@ -1150,7 +1150,10 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			return -EINVAL;
 		}
 		*tmp = '\0';
-		ret = kstrtol(arg, 0, &offset);
+		if (arg[0] != '-' && !isdigit(*arg))
+			ret = btf_find_offset(arg, &offset);
+		else
+			ret = kstrtol(arg, 0, &offset);
 		if (ret) {
 			trace_probe_log_err(ctx->offset, BAD_DEREF_OFFS);
 			break;
-- 
2.47.2


