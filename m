Return-Path: <bpf+bounces-19106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B0E824D36
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 03:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEA71F218D7
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 02:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE91DDDC;
	Fri,  5 Jan 2024 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ObGnf9kL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="9SE88XOa"
X-Original-To: bpf@vger.kernel.org
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4420EE;
	Fri,  5 Jan 2024 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.west.internal (Postfix) with ESMTP id 8FA212B00474;
	Thu,  4 Jan 2024 21:46:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Jan 2024 21:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1704422774; x=
	1704429974; bh=AhBJTveChmuQiAtyMaNSM+RygugifTBNNVPVgl4mifc=; b=O
	bGnf9kLwqiRXEBChfrpj7PwSxFyHI4s+L/hVhLk6RjV/nzcSUpcB/LAS8aep+GyK
	rtm4VxDhuKom8b6Ao9wOY6ZVLpP3KIa2kkuHLFjCwKDNVwr5MNuQjVldLj/Z3GWg
	yW9HoMYHx51AOY6ZOF3uXZpJFH5y8pLW4/w+9t8DKp9b3xD6mZodVIS8oMsW9Bby
	CpEGgQLu9Y+xwuUKPwLcY8AvbHtHrQgCzwH2MP6SOkiPSsQlof90QxGhB6r5TzIz
	T/ugOYv2WgcJMVL18ciEQt8IXf+WyJY9lBfMIn7ba1D+qwr8j82AWW4tq+biS6T3
	AEjqDGNZugDNl2g635nAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704422774; x=
	1704429974; bh=AhBJTveChmuQiAtyMaNSM+RygugifTBNNVPVgl4mifc=; b=9
	SE88XOasO8167iEieiJPmeENdRaUgrRVj6BSqna5koQPuFoAkYPVf15CzH+56zZe
	9BPqzt7PrW0a3epBRtOyqj8MDO/omJwooZlwSpOpht3+Nuk0MQAXE+tBpN7VnR1h
	+a0KsjzOsrcm9CpIMPwaQCcV5SmEQD0t41cNv/I8I/1fePtjDp1TCRaZc1pG6J29
	hh0dGG0rj0k+6jzhATvQ3XHMTw0JD+Ca2G3eqAnb9wXc6DdeigRqfq9jKHrjoE1u
	fGXfW5LZvAb1jg1KrCSxOM85wwGKCRwq3PYfmAnmrAbCn79Zt2tiy2Bg8BLymTJ6
	cZn3w3JyGRWX6iOIWG6Fg==
X-ME-Sender: <xms:dG2XZc8Sd9EpRC0e36X5TLX6mtFr-K2eNk03opGCJ2XAxlKq1e1jhw>
    <xme:dG2XZUsYY0s38kmyOqjc-IMsTunCbdYumkECE9XDV9yqY8AcqgZPQhp4xpZCfZXPo
    gVPk1DCQNd3UPjawA>
X-ME-Received: <xmr:dG2XZSASiYf95tSvNT53SiP_dVnE3EzivD7V4FuSeNDxvdZO7d06YNXfUZNWX1-OiYBiDNnYpKW_afcDNh-U8g0iURWsdl_QsEmChlm4d_K25g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegkedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertder
    tddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeej
    kefgffeghfdttdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:dW2XZcfjCJaMGIgsmduOdc8Go0XmCRSqWsw-86yPcC0evgvBtASXKQ>
    <xmx:dW2XZROKJagc7Ve_YzG2T5Z_yzaZBkjqV7Rwwkkwjo82itBWHYmFcg>
    <xmx:dW2XZWl4c5bfoGreXE5j1xrqCZdvUAvD2urrC4rcBxs71hDpeLezeA>
    <xmx:dm2XZcripSBNJ1s7sLfdaDWJT0WW1ZVkvRDNCfb4p1vqaIyPTrwt439RXAs>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 21:46:09 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: alexandre.torgue@foss.st.com,
	benjamin.tissoires@redhat.com,
	lizefan.x@bytedance.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	dsahern@kernel.org,
	hannes@cmpxchg.org,
	rostedt@goodmis.org,
	mcoquelin.stm32@gmail.com,
	pablo@netfilter.org,
	martin.lau@linux.dev,
	edumazet@google.com,
	daniel@iogearbox.net,
	ebiggers@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	steffen.klassert@secunet.com,
	jikos@kernel.org,
	kuba@kernel.org,
	fw@strlen.de,
	ast@kernel.org,
	song@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	tytso@mit.edu,
	tj@kernel.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	mhiramat@kernel.org,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	memxor@gmail.com
Cc: kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mathieu.desnoyers@efficios.com,
	mykolal@fb.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fsverity@lists.linux.dev,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next v2 3/3] bpf: treewide: Annotate BPF kfuncs in BTF
Date: Thu,  4 Jan 2024 19:45:49 -0700
Message-ID: <a923e3809955bdfd2bc8d6a103c20e01f1636dbc.1704422454.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1704422454.git.dxu@dxuuu.xyz>
References: <cover.1704422454.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit marks kfuncs as such inside the .BTF_ids section. The upshot
of these annotations is that we'll be able to automatically generate
kfunc prototypes for downstream users. The process is as follows:

1. In source, use BTF_KFUNCS_START/END macro pair to mark kfuncs
2. During build, pahole injects into BTF a "bpf_kfunc" BTF_DECL_TAG for
   each function inside BTF_KFUNCS sets
3. At runtime, vmlinux or module BTF is made available in sysfs
4. At runtime, bpftool (or similar) can look at provided BTF and
   generate appropriate prototypes for functions with "bpf_kfunc" tag

To ensure future kfunc are similarly tagged, we now also return error
and WARN() inside kfunc registration.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 drivers/hid/bpf/hid_bpf_dispatch.c               |  8 ++++----
 fs/verity/measure.c                              |  4 ++--
 kernel/bpf/btf.c                                 |  4 ++++
 kernel/bpf/cpumask.c                             |  4 ++--
 kernel/bpf/helpers.c                             |  8 ++++----
 kernel/bpf/map_iter.c                            |  4 ++--
 kernel/cgroup/rstat.c                            |  4 ++--
 kernel/trace/bpf_trace.c                         |  8 ++++----
 net/bpf/test_run.c                               |  8 ++++----
 net/core/filter.c                                | 16 ++++++++--------
 net/core/xdp.c                                   |  4 ++--
 net/ipv4/bpf_tcp_ca.c                            |  4 ++--
 net/ipv4/fou_bpf.c                               |  4 ++--
 net/ipv4/tcp_bbr.c                               |  4 ++--
 net/ipv4/tcp_cubic.c                             |  4 ++--
 net/ipv4/tcp_dctcp.c                             |  4 ++--
 net/netfilter/nf_conntrack_bpf.c                 |  4 ++--
 net/netfilter/nf_nat_bpf.c                       |  4 ++--
 net/xfrm/xfrm_interface_bpf.c                    |  4 ++--
 net/xfrm/xfrm_state_bpf.c                        |  4 ++--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c      |  8 ++++----
 21 files changed, 60 insertions(+), 56 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index d9ef45fcaeab..02c441aaa217 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -172,9 +172,9 @@ hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t rdwr
  * The following set contains all functions we agree BPF programs
  * can use.
  */
-BTF_SET8_START(hid_bpf_kfunc_ids)
+BTF_KFUNCS_START(hid_bpf_kfunc_ids)
 BTF_ID_FLAGS(func, hid_bpf_get_data, KF_RET_NULL)
-BTF_SET8_END(hid_bpf_kfunc_ids)
+BTF_KFUNCS_END(hid_bpf_kfunc_ids)
 
 static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
 	.owner = THIS_MODULE,
@@ -440,12 +440,12 @@ static const struct btf_kfunc_id_set hid_bpf_fmodret_set = {
 };
 
 /* for syscall HID-BPF */
-BTF_SET8_START(hid_bpf_syscall_kfunc_ids)
+BTF_KFUNCS_START(hid_bpf_syscall_kfunc_ids)
 BTF_ID_FLAGS(func, hid_bpf_attach_prog)
 BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
 BTF_ID_FLAGS(func, hid_bpf_hw_request)
-BTF_SET8_END(hid_bpf_syscall_kfunc_ids)
+BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)
 
 static const struct btf_kfunc_id_set hid_bpf_syscall_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index bf7a5f4cccaf..3969d54158d1 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -159,9 +159,9 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr_ker
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(fsverity_set_ids)
+BTF_KFUNCS_START(fsverity_set_ids)
 BTF_ID_FLAGS(func, bpf_get_fsverity_digest, KF_TRUSTED_ARGS)
-BTF_SET8_END(fsverity_set_ids)
+BTF_KFUNCS_END(fsverity_set_ids)
 
 static int bpf_get_fsverity_digest_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 51e8b4bee0c8..8cc718f37a9d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7802,6 +7802,10 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 {
 	enum btf_kfunc_hook hook;
 
+	/* All kfuncs need to be tagged as such in BTF */
+	if (WARN_ON(!(kset->set->flags & BTF_SET8_KFUNCS)))
+		return -EINVAL;
+
 	hook = bpf_prog_type_to_kfunc_hook(prog_type);
 	return __register_btf_kfunc_id_set(hook, kset);
 }
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 2e73533a3811..dad0fb1c8e87 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -424,7 +424,7 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(cpumask_kfunc_btf_ids)
+BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_cpumask_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cpumask_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cpumask_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
@@ -450,7 +450,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
-BTF_SET8_END(cpumask_kfunc_btf_ids)
+BTF_KFUNCS_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index be72824f32b2..277481eef361 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2543,7 +2543,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(generic_btf_ids)
+BTF_KFUNCS_START(generic_btf_ids)
 #ifdef CONFIG_KEXEC_CORE
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
@@ -2572,7 +2572,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
-BTF_SET8_END(generic_btf_ids)
+BTF_KFUNCS_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
 	.owner = THIS_MODULE,
@@ -2588,7 +2588,7 @@ BTF_ID(struct, cgroup)
 BTF_ID(func, bpf_cgroup_release_dtor)
 #endif
 
-BTF_SET8_START(common_btf_ids)
+BTF_KFUNCS_START(common_btf_ids)
 BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
 BTF_ID_FLAGS(func, bpf_rdonly_cast)
 BTF_ID_FLAGS(func, bpf_rcu_read_lock)
@@ -2617,7 +2617,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
-BTF_SET8_END(common_btf_ids)
+BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 6abd7c5df4b3..9575314f40a6 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -213,9 +213,9 @@ __bpf_kfunc s64 bpf_map_sum_elem_count(const struct bpf_map *map)
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(bpf_map_iter_kfunc_ids)
+BTF_KFUNCS_START(bpf_map_iter_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_map_sum_elem_count, KF_TRUSTED_ARGS)
-BTF_SET8_END(bpf_map_iter_kfunc_ids)
+BTF_KFUNCS_END(bpf_map_iter_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_map_iter_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c0adb7254b45..127858046712 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -520,10 +520,10 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 }
 
 /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
-BTF_SET8_START(bpf_rstat_kfunc_ids)
+BTF_KFUNCS_START(bpf_rstat_kfunc_ids)
 BTF_ID_FLAGS(func, cgroup_rstat_updated)
 BTF_ID_FLAGS(func, cgroup_rstat_flush, KF_SLEEPABLE)
-BTF_SET8_END(bpf_rstat_kfunc_ids)
+BTF_KFUNCS_END(bpf_rstat_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_rstat_kfunc_set = {
 	.owner          = THIS_MODULE,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 7ac6c52b25eb..d786738ae5fa 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1412,14 +1412,14 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(key_sig_kfunc_set)
+BTF_KFUNCS_START(key_sig_kfunc_set)
 BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
 BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
 #endif
-BTF_SET8_END(key_sig_kfunc_set)
+BTF_KFUNCS_END(key_sig_kfunc_set)
 
 static const struct btf_kfunc_id_set bpf_key_sig_kfunc_set = {
 	.owner = THIS_MODULE,
@@ -1475,9 +1475,9 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(fs_kfunc_set_ids)
+BTF_KFUNCS_START(fs_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
-BTF_SET8_END(fs_kfunc_set_ids)
+BTF_KFUNCS_END(fs_kfunc_set_ids)
 
 static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfd919374017..5535f9adc658 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -617,21 +617,21 @@ CFI_NOSEAL(bpf_kfunc_call_memb_release_dtor);
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(bpf_test_modify_return_ids)
+BTF_KFUNCS_START(bpf_test_modify_return_ids)
 BTF_ID_FLAGS(func, bpf_modify_return_test)
 BTF_ID_FLAGS(func, bpf_modify_return_test2)
 BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
-BTF_SET8_END(bpf_test_modify_return_ids)
+BTF_KFUNCS_END(bpf_test_modify_return_ids)
 
 static const struct btf_kfunc_id_set bpf_test_modify_return_set = {
 	.owner = THIS_MODULE,
 	.set   = &bpf_test_modify_return_ids,
 };
 
-BTF_SET8_START(test_sk_check_kfunc_ids)
+BTF_KFUNCS_START(test_sk_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_RELEASE)
-BTF_SET8_END(test_sk_check_kfunc_ids)
+BTF_KFUNCS_END(test_sk_check_kfunc_ids)
 
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 			   u32 size, u32 headroom, u32 tailroom)
diff --git a/net/core/filter.c b/net/core/filter.c
index 24061f29c9dd..1f2303b9cce7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11853,17 +11853,17 @@ int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
 	return 0;
 }
 
-BTF_SET8_START(bpf_kfunc_check_set_skb)
+BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
-BTF_SET8_END(bpf_kfunc_check_set_skb)
+BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
-BTF_SET8_START(bpf_kfunc_check_set_xdp)
+BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
-BTF_SET8_END(bpf_kfunc_check_set_xdp)
+BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
 
-BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
+BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
 BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
-BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
+BTF_KFUNCS_END(bpf_kfunc_check_set_sock_addr)
 
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
@@ -11936,9 +11936,9 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(bpf_sk_iter_kfunc_ids)
+BTF_KFUNCS_START(bpf_sk_iter_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
-BTF_SET8_END(bpf_sk_iter_kfunc_ids)
+BTF_KFUNCS_END(bpf_sk_iter_kfunc_ids)
 
 static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 4869c1c2d8f3..034fb80f3fbe 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -771,11 +771,11 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(xdp_metadata_kfunc_ids)
+BTF_KFUNCS_START(xdp_metadata_kfunc_ids)
 #define XDP_METADATA_KFUNC(_, __, name, ___) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
-BTF_SET8_END(xdp_metadata_kfunc_ids)
+BTF_KFUNCS_END(xdp_metadata_kfunc_ids)
 
 static const struct btf_kfunc_id_set xdp_metadata_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index ae8b15e6896f..edecdf8229df 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -195,13 +195,13 @@ bpf_tcp_ca_get_func_proto(enum bpf_func_id func_id,
 	}
 }
 
-BTF_SET8_START(bpf_tcp_ca_check_kfunc_ids)
+BTF_KFUNCS_START(bpf_tcp_ca_check_kfunc_ids)
 BTF_ID_FLAGS(func, tcp_reno_ssthresh)
 BTF_ID_FLAGS(func, tcp_reno_cong_avoid)
 BTF_ID_FLAGS(func, tcp_reno_undo_cwnd)
 BTF_ID_FLAGS(func, tcp_slow_start)
 BTF_ID_FLAGS(func, tcp_cong_avoid_ai)
-BTF_SET8_END(bpf_tcp_ca_check_kfunc_ids)
+BTF_KFUNCS_END(bpf_tcp_ca_check_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_tcp_ca_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/net/ipv4/fou_bpf.c b/net/ipv4/fou_bpf.c
index 4da03bf45c9b..06e5572f296f 100644
--- a/net/ipv4/fou_bpf.c
+++ b/net/ipv4/fou_bpf.c
@@ -100,10 +100,10 @@ __bpf_kfunc int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(fou_kfunc_set)
+BTF_KFUNCS_START(fou_kfunc_set)
 BTF_ID_FLAGS(func, bpf_skb_set_fou_encap)
 BTF_ID_FLAGS(func, bpf_skb_get_fou_encap)
-BTF_SET8_END(fou_kfunc_set)
+BTF_KFUNCS_END(fou_kfunc_set)
 
 static const struct btf_kfunc_id_set fou_bpf_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 22358032dd48..05dc2d05bc7c 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -1155,7 +1155,7 @@ static struct tcp_congestion_ops tcp_bbr_cong_ops __read_mostly = {
 	.set_state	= bbr_set_state,
 };
 
-BTF_SET8_START(tcp_bbr_check_kfunc_ids)
+BTF_KFUNCS_START(tcp_bbr_check_kfunc_ids)
 #ifdef CONFIG_X86
 #ifdef CONFIG_DYNAMIC_FTRACE
 BTF_ID_FLAGS(func, bbr_init)
@@ -1168,7 +1168,7 @@ BTF_ID_FLAGS(func, bbr_min_tso_segs)
 BTF_ID_FLAGS(func, bbr_set_state)
 #endif
 #endif
-BTF_SET8_END(tcp_bbr_check_kfunc_ids)
+BTF_KFUNCS_END(tcp_bbr_check_kfunc_ids)
 
 static const struct btf_kfunc_id_set tcp_bbr_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 0fd78ecb67e7..44869ea089e3 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -485,7 +485,7 @@ static struct tcp_congestion_ops cubictcp __read_mostly = {
 	.name		= "cubic",
 };
 
-BTF_SET8_START(tcp_cubic_check_kfunc_ids)
+BTF_KFUNCS_START(tcp_cubic_check_kfunc_ids)
 #ifdef CONFIG_X86
 #ifdef CONFIG_DYNAMIC_FTRACE
 BTF_ID_FLAGS(func, cubictcp_init)
@@ -496,7 +496,7 @@ BTF_ID_FLAGS(func, cubictcp_cwnd_event)
 BTF_ID_FLAGS(func, cubictcp_acked)
 #endif
 #endif
-BTF_SET8_END(tcp_cubic_check_kfunc_ids)
+BTF_KFUNCS_END(tcp_cubic_check_kfunc_ids)
 
 static const struct btf_kfunc_id_set tcp_cubic_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index bb23bb5b387a..e33fbe4933e4 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -260,7 +260,7 @@ static struct tcp_congestion_ops dctcp_reno __read_mostly = {
 	.name		= "dctcp-reno",
 };
 
-BTF_SET8_START(tcp_dctcp_check_kfunc_ids)
+BTF_KFUNCS_START(tcp_dctcp_check_kfunc_ids)
 #ifdef CONFIG_X86
 #ifdef CONFIG_DYNAMIC_FTRACE
 BTF_ID_FLAGS(func, dctcp_init)
@@ -271,7 +271,7 @@ BTF_ID_FLAGS(func, dctcp_cwnd_undo)
 BTF_ID_FLAGS(func, dctcp_state)
 #endif
 #endif
-BTF_SET8_END(tcp_dctcp_check_kfunc_ids)
+BTF_KFUNCS_END(tcp_dctcp_check_kfunc_ids)
 
 static const struct btf_kfunc_id_set tcp_dctcp_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 475358ec8212..d2492d050fe6 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -467,7 +467,7 @@ __bpf_kfunc int bpf_ct_change_status(struct nf_conn *nfct, u32 status)
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(nf_ct_kfunc_set)
+BTF_KFUNCS_START(nf_ct_kfunc_set)
 BTF_ID_FLAGS(func, bpf_xdp_ct_alloc, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_xdp_ct_lookup, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_skb_ct_alloc, KF_ACQUIRE | KF_RET_NULL)
@@ -478,7 +478,7 @@ BTF_ID_FLAGS(func, bpf_ct_set_timeout, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_ct_change_timeout, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_ct_set_status, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_ct_change_status, KF_TRUSTED_ARGS)
-BTF_SET8_END(nf_ct_kfunc_set)
+BTF_KFUNCS_END(nf_ct_kfunc_set)
 
 static const struct btf_kfunc_id_set nf_conntrack_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
index 6e3b2f58855f..481be15609b1 100644
--- a/net/netfilter/nf_nat_bpf.c
+++ b/net/netfilter/nf_nat_bpf.c
@@ -54,9 +54,9 @@ __bpf_kfunc int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(nf_nat_kfunc_set)
+BTF_KFUNCS_START(nf_nat_kfunc_set)
 BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_TRUSTED_ARGS)
-BTF_SET8_END(nf_nat_kfunc_set)
+BTF_KFUNCS_END(nf_nat_kfunc_set)
 
 static const struct btf_kfunc_id_set nf_bpf_nat_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_interface_bpf.c
index 7d5e920141e9..5ea15037ebd1 100644
--- a/net/xfrm/xfrm_interface_bpf.c
+++ b/net/xfrm/xfrm_interface_bpf.c
@@ -93,10 +93,10 @@ __bpf_kfunc int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx, const struct bp
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(xfrm_ifc_kfunc_set)
+BTF_KFUNCS_START(xfrm_ifc_kfunc_set)
 BTF_ID_FLAGS(func, bpf_skb_get_xfrm_info)
 BTF_ID_FLAGS(func, bpf_skb_set_xfrm_info)
-BTF_SET8_END(xfrm_ifc_kfunc_set)
+BTF_KFUNCS_END(xfrm_ifc_kfunc_set)
 
 static const struct btf_kfunc_id_set xfrm_interface_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
index 9e20d4a377f7..2248eda741f8 100644
--- a/net/xfrm/xfrm_state_bpf.c
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -117,10 +117,10 @@ __bpf_kfunc void bpf_xdp_xfrm_state_release(struct xfrm_state *x)
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(xfrm_state_kfunc_set)
+BTF_KFUNCS_START(xfrm_state_kfunc_set)
 BTF_ID_FLAGS(func, bpf_xdp_get_xfrm_state, KF_RET_NULL | KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_xdp_xfrm_state_release, KF_RELEASE)
-BTF_SET8_END(xfrm_state_kfunc_set)
+BTF_KFUNCS_END(xfrm_state_kfunc_set)
 
 static const struct btf_kfunc_id_set xfrm_state_xdp_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 91907b321f91..9faaefbe4a07 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -341,12 +341,12 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
 	.write = bpf_testmod_test_write,
 };
 
-BTF_SET8_START(bpf_testmod_common_kfunc_ids)
+BTF_KFUNCS_START(bpf_testmod_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
-BTF_SET8_END(bpf_testmod_common_kfunc_ids)
+BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
 	.owner = THIS_MODULE,
@@ -492,7 +492,7 @@ __bpf_kfunc static u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused
 	return arg;
 }
 
-BTF_SET8_START(bpf_testmod_check_kfunc_ids)
+BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
@@ -518,7 +518,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
-BTF_SET8_END(bpf_testmod_check_kfunc_ids)
+BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
 	.owner = THIS_MODULE,
-- 
2.42.1


