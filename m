Return-Path: <bpf+bounces-38570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9DF9666C3
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F8D283AE7
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873451BA29A;
	Fri, 30 Aug 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lvbk0Yyz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAC61BA265;
	Fri, 30 Aug 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035147; cv=none; b=AwUF0mm1gmoi4MYr3ML6oG/ot+mSs/j8ZYSs2qP8SxvoXzEuSKAoPRDHc1UlQ35wCel/UpSB/0hQeaWeNXGsQBCDVy6VJ/+D0LKIsoCZBRhlDihGYf3FoNlkvtsZBNgIjImTT/20UryRQWGEogr+dEyydFoQzDxioHrmjLq5Ygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035147; c=relaxed/simple;
	bh=K6sCx4+usVNH07IrYSUEk9l81+65yfH1aelgJ1+bzjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDZZSk4Pxa8wqO4H5fwb1SSPt45iZYyXTFIVzsXlg0z6AJkQMUeX+vO6HLpFacZWfF1TnOzzmr1JAYdjmXPeaJ9FyR9Cw0IsoBYUcpWDf4VxU8+VcM3WBdMJoR4HIEcDkgO5qIzidls94JfnqGx+fuc6Prl35WQ0lonDwwJUKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lvbk0Yyz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725035146; x=1756571146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K6sCx4+usVNH07IrYSUEk9l81+65yfH1aelgJ1+bzjc=;
  b=Lvbk0Yyzflsfue/RIbcAwnBp3VAPYBtUiVRmd5fAKdWzvr7gbhl8TmqD
   0lVj3+HdTUltyyTCbZIh7hefZnZcvYpkBvPxZaY489zurlMPBDX2/cmni
   xp1w3XskK8y5Mn1nrIZSeSutSflcQLniS4Y5z9Bfs1XnsaKCbEX+FzuSs
   oII0zzJaxxyoBfAG83r4r7fmgg0pet3jwESNI3h5AgcdcDCWGTtevdn08
   8kRJ5s60KC6Y/QZU4EPTMFKLFy0NOI62cLLVye51UfhPurqGgW3PNd7V6
   6UetfdNZOgvawl/3npRqkLASqpnUPPXJxTU/m9UHFkYQYvwUi8MNZA6bl
   A==;
X-CSE-ConnectionGUID: 54409XAlRs2L5VnPLAl31Q==
X-CSE-MsgGUID: I9wmsyu1TpqJhdIBNQAqzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="49068891"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="49068891"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:25:46 -0700
X-CSE-ConnectionGUID: e9oAoBBmTCSlvQprHrdzog==
X-CSE-MsgGUID: hJd6l5JVQHinTUNGW0r9YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63996442"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 30 Aug 2024 09:25:41 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/9] kthread: allow vararg kthread_{create,run}_on_cpu()
Date: Fri, 30 Aug 2024 18:25:01 +0200
Message-ID: <20240830162508.1009458-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, kthread_{create,run}_on_cpu() doesn't support varargs like
kthread_create{,_on_node}() do, which makes them less convenient to
use.
Convert them to take varargs as the last argument. The only difference
is that they always append the CPU ID at the end and require the format
string to have an excess '%u' at the end due to that. That's still true;
meanwhile, the compiler will correctly point out to that if missing.
One more nice side effect is that you can now use the underscored
__kthread_create_on_cpu() if you want to override that rule and not
have CPU ID at the end of the name.
The current callers are not anyhow affected.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/kthread.h | 51 ++++++++++++++++++++++++++---------------
 kernel/kthread.c        | 22 ++++++++++--------
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index b11f53c1ba2e..27a94e691948 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -27,11 +27,21 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
 #define kthread_create(threadfn, data, namefmt, arg...) \
 	kthread_create_on_node(threadfn, data, NUMA_NO_NODE, namefmt, ##arg)
 
-
-struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
-					  void *data,
-					  unsigned int cpu,
-					  const char *namefmt);
+__printf(4, 5)
+struct task_struct *__kthread_create_on_cpu(int (*threadfn)(void *data),
+					    void *data, unsigned int cpu,
+					    const char *namefmt, ...);
+
+#define kthread_create_on_cpu(threadfn, data, cpu, namefmt, ...)	   \
+	_kthread_create_on_cpu(threadfn, data, cpu, __UNIQUE_ID(cpu_),	   \
+			       namefmt, ##__VA_ARGS__)
+
+#define _kthread_create_on_cpu(threadfn, data, cpu, uc, namefmt, ...) ({   \
+	u32 uc = (cpu);							   \
+									   \
+	__kthread_create_on_cpu(threadfn, data, uc, namefmt,		   \
+				##__VA_ARGS__, uc);			   \
+})
 
 void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk);
 bool set_kthread_struct(struct task_struct *p);
@@ -62,25 +72,28 @@ bool kthread_is_per_cpu(struct task_struct *k);
  * @threadfn: the function to run until signal_pending(current).
  * @data: data ptr for @threadfn.
  * @cpu: The cpu on which the thread should be bound,
- * @namefmt: printf-style name for the thread. Format is restricted
- *	     to "name.*%u". Code fills in cpu number.
+ * @namefmt: printf-style name for the thread. Must have an excess '%u'
+ *	     at the end as kthread_create_on_cpu() fills in CPU number.
  *
  * Description: Convenient wrapper for kthread_create_on_cpu()
  * followed by wake_up_process().  Returns the kthread or
  * ERR_PTR(-ENOMEM).
  */
-static inline struct task_struct *
-kthread_run_on_cpu(int (*threadfn)(void *data), void *data,
-			unsigned int cpu, const char *namefmt)
-{
-	struct task_struct *p;
-
-	p = kthread_create_on_cpu(threadfn, data, cpu, namefmt);
-	if (!IS_ERR(p))
-		wake_up_process(p);
-
-	return p;
-}
+#define kthread_run_on_cpu(threadfn, data, cpu, namefmt, ...)		   \
+	_kthread_run_on_cpu(threadfn, data, cpu, __UNIQUE_ID(task_),	   \
+			    namefmt, ##__VA_ARGS__)
+
+#define _kthread_run_on_cpu(threadfn, data, cpu, ut, namefmt, ...)	   \
+({									   \
+	struct task_struct *ut;						   \
+									   \
+	ut = kthread_create_on_cpu(threadfn, data, cpu, namefmt,	   \
+				   ##__VA_ARGS__);			   \
+	if (!IS_ERR(ut))						   \
+		wake_up_process(ut);					   \
+									   \
+	ut;								   \
+})
 
 void free_kthread_struct(struct task_struct *k);
 void kthread_bind(struct task_struct *k, unsigned int cpu);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index f7be976ff88a..e9da0115fb2b 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -559,23 +559,27 @@ void kthread_bind(struct task_struct *p, unsigned int cpu)
 EXPORT_SYMBOL(kthread_bind);
 
 /**
- * kthread_create_on_cpu - Create a cpu bound kthread
+ * __kthread_create_on_cpu - Create a cpu bound kthread
  * @threadfn: the function to run until signal_pending(current).
  * @data: data ptr for @threadfn.
  * @cpu: The cpu on which the thread should be bound,
- * @namefmt: printf-style name for the thread. Format is restricted
- *	     to "name.*%u". Code fills in cpu number.
+ * @namefmt: printf-style name for the thread. Must have an excess '%u'
+ *	     at the end as kthread_create_on_cpu() fills in CPU number.
  *
  * Description: This helper function creates and names a kernel thread
  */
-struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
-					  void *data, unsigned int cpu,
-					  const char *namefmt)
+struct task_struct *__kthread_create_on_cpu(int (*threadfn)(void *data),
+					    void *data, unsigned int cpu,
+					    const char *namefmt, ...)
 {
 	struct task_struct *p;
+	va_list args;
+
+	va_start(args, namefmt);
+	p = __kthread_create_on_node(threadfn, data, cpu_to_node(cpu), namefmt,
+				     args);
+	va_end(args);
 
-	p = kthread_create_on_node(threadfn, data, cpu_to_node(cpu), namefmt,
-				   cpu);
 	if (IS_ERR(p))
 		return p;
 	kthread_bind(p, cpu);
@@ -583,7 +587,7 @@ struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
 	to_kthread(p)->cpu = cpu;
 	return p;
 }
-EXPORT_SYMBOL(kthread_create_on_cpu);
+EXPORT_SYMBOL(__kthread_create_on_cpu);
 
 void kthread_set_per_cpu(struct task_struct *k, int cpu)
 {
-- 
2.46.0


