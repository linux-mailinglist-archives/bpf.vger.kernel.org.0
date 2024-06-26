Return-Path: <bpf+bounces-33187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70C69193C3
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 20:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4DE2826DB
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 18:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1053E1922D5;
	Wed, 26 Jun 2024 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IVpwk2qs"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D0714EC59;
	Wed, 26 Jun 2024 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428363; cv=none; b=d2qcZKEVvF9M00NKL6MsI4zEXXAf7LspjgRXvU6L9oVdIZr5R1Cook+GCJGyNewTSZXolj3pusFgoaDMexdld7uHggv4mnKFhw60iKXAyXSy3lCYVfrwbIKsSyPz+oILkMyRLKemfI0yoljyh7mI0KuzNzJgH7lKqSgw2xvaEcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428363; c=relaxed/simple;
	bh=gjc048RnAItR651zyPAIKpF5uOoLVdvActZXFVDndY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cu5Z0lU/EWku+9UyMVPov8m8h2Vpuv8wvIpVQIy2lUmo1IFVixITKy0mUSO4oktVXIp+2mxrldwuVyXg+M35vx+9xqwLM+Yfreub5j5zRBinGZV/34S8KGpO3lrUAFNV7WLCegUJb6OkSmpI7vUd2CkIHP+rrBssCmYUZnCAQGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=IVpwk2qs; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719428353;
	bh=gjc048RnAItR651zyPAIKpF5uOoLVdvActZXFVDndY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IVpwk2qstEbmGTpAX4dsPOYiMy5QxBk6RF2KXZYLSQEcfbToItWhZk05F9/Abalza
	 8JJbyi0L4H9uk7Q5HHGPrAb7kUToSXbaduFyfrhhF5sJ0yYVUOGU+2yn9Qmfqf/Vb+
	 H69OfB+PVC10+vd9vlVzYMSA3pzQFXx58WJxZlRefnyGrCmhx+CGRWNdEJccgoXD9g
	 yGx/nYhmeaf8Oe+OT0HoOTtnfuHAxYA1LdTVpVHFnz3o37cjvB3stl5ZIP4kvR7n+Q
	 5Co1k/h2Ddr7z4EiesPly/W4DlMjfOv82Npl0FnDKXGk5DrpSX3+9/nvj76UUacn1/
	 LMR8nGUvKetCw==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4W8WFs1RNyz17tZ;
	Wed, 26 Jun 2024 14:59:13 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v5 2/8] cleanup.h guard: Rename DEFINE_ prefix to DECLARE_
Date: Wed, 26 Jun 2024 14:59:35 -0400
Message-Id: <20240626185941.68420-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626185941.68420-1-mathieu.desnoyers@efficios.com>
References: <20240626185941.68420-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The convention used in other kernel headers (e.g. wait.h, percpu-defs.h)
is to use "DECLARE_" prefix for macros emitting externs, static inlines
and type definitions.

The "DEFINE_" prefix is used for variable definitions.

In preparation to introduce a "DEFINE_INACTIVE_GUARD()" to actually
define a guard variable, rename all the guard "DEFINE_" prefix to
"DECLARE_".

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 drivers/cxl/core/cdat.c                     |  2 +-
 drivers/cxl/cxl.h                           |  2 +-
 drivers/gpio/gpiolib.h                      |  2 +-
 drivers/platform/x86/intel/pmc/core_ssram.c |  2 +-
 fs/fuse/virtio_fs.c                         |  2 +-
 fs/pstore/inode.c                           |  4 +-
 include/linux/bitmap.h                      |  2 +-
 include/linux/cleanup.h                     | 56 ++++++++++-----------
 include/linux/cpu.h                         |  2 +-
 include/linux/cpumask.h                     |  2 +-
 include/linux/device.h                      |  6 +--
 include/linux/file.h                        |  4 +-
 include/linux/firmware.h                    |  2 +-
 include/linux/gpio/driver.h                 |  4 +-
 include/linux/iio/iio.h                     |  4 +-
 include/linux/irqflags.h                    |  4 +-
 include/linux/mutex.h                       |  6 +--
 include/linux/of.h                          |  2 +-
 include/linux/pci.h                         |  4 +-
 include/linux/percpu.h                      |  2 +-
 include/linux/preempt.h                     |  6 +--
 include/linux/rcupdate.h                    |  2 +-
 include/linux/rwsem.h                       | 10 ++--
 include/linux/sched/task.h                  |  4 +-
 include/linux/slab.h                        |  4 +-
 include/linux/spinlock.h                    | 38 +++++++-------
 include/linux/srcu.h                        |  2 +-
 include/sound/pcm.h                         |  6 +--
 kernel/sched/core.c                         |  4 +-
 kernel/sched/sched.h                        | 16 +++---
 lib/locking-selftest.c                      | 12 ++---
 sound/core/control_led.c                    |  2 +-
 32 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index bb83867d9fec..689143566642 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -385,7 +385,7 @@ static void discard_dsmas(struct xarray *xa)
 	}
 	xa_destroy(xa);
 }
-DEFINE_FREE(dsmas, struct xarray *, if (_T) discard_dsmas(_T))
+DECLARE_FREE(dsmas, struct xarray *, if (_T) discard_dsmas(_T))
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 036d17db68e0..89cadb029d31 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -737,7 +737,7 @@ struct cxl_root *devm_cxl_add_root(struct device *host,
 				   const struct cxl_root_ops *ops);
 struct cxl_root *find_cxl_root(struct cxl_port *port);
 void put_cxl_root(struct cxl_root *cxl_root);
-DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
+DECLARE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
 
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 8e0e211ebf08..17507a64c284 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -199,7 +199,7 @@ struct gpio_chip_guard {
 	int idx;
 };
 
-DEFINE_CLASS(gpio_chip_guard,
+DECLARE_CLASS(gpio_chip_guard,
 	     struct gpio_chip_guard,
 	     srcu_read_unlock(&_T.gdev->srcu, _T.idx),
 	     ({
diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index 1bde86c54eb9..115f16448406 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -29,7 +29,7 @@
 #define LPM_REG_COUNT		28
 #define LPM_MODE_OFFSET		1
 
-DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
+DECLARE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
 
 static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *map)
 {
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index bb3e941b9503..d062bafb294a 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -852,7 +852,7 @@ static void virtio_fs_cleanup_dax(void *data)
 	put_dax(dax_dev);
 }
 
-DEFINE_FREE(cleanup_dax, struct dax_dev *, if (!IS_ERR_OR_NULL(_T)) virtio_fs_cleanup_dax(_T))
+DECLARE_FREE(cleanup_dax, struct dax_dev *, if (!IS_ERR_OR_NULL(_T)) virtio_fs_cleanup_dax(_T))
 
 static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 {
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 56815799ce79..f34da47d26d4 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -35,7 +35,7 @@ static LIST_HEAD(records_list);
 static DEFINE_MUTEX(pstore_sb_lock);
 static struct super_block *pstore_sb;
 
-DEFINE_FREE(pstore_iput, struct inode *, if (_T) iput(_T))
+DECLARE_FREE(pstore_iput, struct inode *, if (_T) iput(_T))
 
 struct pstore_private {
 	struct list_head list;
@@ -63,7 +63,7 @@ static void free_pstore_private(struct pstore_private *private)
 	}
 	kfree(private);
 }
-DEFINE_FREE(pstore_private, struct pstore_private *, free_pstore_private(_T));
+DECLARE_FREE(pstore_private, struct pstore_private *, free_pstore_private(_T));
 
 static void *pstore_ftrace_seq_start(struct seq_file *s, loff_t *pos)
 {
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index aa4096126553..22f0893bb8c6 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -131,7 +131,7 @@ unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int node);
 unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int node);
 void bitmap_free(const unsigned long *bitmap);
 
-DEFINE_FREE(bitmap, unsigned long *, if (_T) bitmap_free(_T))
+DECLARE_FREE(bitmap, unsigned long *, if (_T) bitmap_free(_T))
 
 /* Managed variants of the above. */
 unsigned long *devm_bitmap_alloc(struct device *dev,
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 4cf8ad5d27a3..04f03ad5f25d 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -5,8 +5,8 @@
 #include <linux/compiler.h>
 
 /*
- * DEFINE_FREE(name, type, free):
- *	simple helper macro that defines the required wrapper for a __free()
+ * DECLARE_FREE(name, type, free):
+ *	simple helper macro that declares the required wrapper for a __free()
  *	based cleanup function. @free is an expression using '_T' to access the
  *	variable. @free should typically include a NULL test before calling a
  *	function, see the example below.
@@ -26,7 +26,7 @@
  *
  * Ex.
  *
- * DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
+ * DECLARE_FREE(kfree, void *, if (_T) kfree(_T))
  *
  * void *alloc_obj(...)
  * {
@@ -40,7 +40,7 @@
  *	return_ptr(p);
  * }
  *
- * NOTE: the DEFINE_FREE()'s @free expression includes a NULL test even though
+ * NOTE: the DECLARE_FREE()'s @free expression includes a NULL test even though
  * kfree() is fine to be called with a NULL value. This is on purpose. This way
  * the compiler sees the end of our alloc_obj() function as:
  *
@@ -58,7 +58,7 @@
  * Without the NULL test it turns into a mess and the compiler can't help us.
  */
 
-#define DEFINE_FREE(_name, _type, _free) \
+#define DECLARE_FREE(_name, _type, _free) \
 	static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
 
 #define __free(_name)	__cleanup(__free_##_name)
@@ -79,8 +79,8 @@ const volatile void * __must_check_fn(const volatile void *val)
 
 
 /*
- * DEFINE_CLASS(name, type, exit, init, init_args...):
- *	helper to define the destructor and constructor for a type.
+ * DECLARE_CLASS(name, type, exit, init, init_args...):
+ *	helper to declare the destructor and constructor for a type.
  *	@exit is an expression using '_T' -- similar to FREE above.
  *	@init is an expression in @init_args resulting in @type
  *
@@ -92,7 +92,7 @@ const volatile void * __must_check_fn(const volatile void *val)
  *
  * Ex.
  *
- * DEFINE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
+ * DECLARE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
  *
  *	CLASS(fdget, f)(fd);
  *	if (!f.file)
@@ -101,7 +101,7 @@ const volatile void * __must_check_fn(const volatile void *val)
  *	// use 'f' without concern
  */
 
-#define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)		\
+#define DECLARE_CLASS(_name, _type, _exit, _init, _init_args...)		\
 typedef _type class_##_name##_t;					\
 static inline void class_##_name##_destructor(_type *p)			\
 { _type _T = *p; _exit; }						\
@@ -121,11 +121,11 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 
 
 /*
- * DEFINE_GUARD(name, type, lock, unlock):
- *	trivial wrapper around DEFINE_CLASS() above specifically
+ * DECLARE_GUARD(name, type, lock, unlock):
+ *	trivial wrapper around DECLARE_CLASS() above specifically
  *	for locks.
  *
- * DEFINE_GUARD_COND(name, ext, condlock)
+ * DECLARE_GUARD_COND(name, ext, condlock)
  *	wrapper around EXTEND_CLASS above to add conditional lock
  *	variants to a base class, eg. mutex_trylock() or
  *	mutex_lock_interruptible().
@@ -148,12 +148,12 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *
  */
 
-#define DEFINE_GUARD(_name, _type, _lock, _unlock) \
-	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
+#define DECLARE_GUARD(_name, _type, _lock, _unlock) \
+	DECLARE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
 	{ return *_T; }
 
-#define DEFINE_GUARD_COND(_name, _ext, _condlock) \
+#define DECLARE_GUARD_COND(_name, _ext, _condlock) \
 	EXTEND_CLASS(_name, _ext, \
 		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
 		     class_##_name##_t _T) \
@@ -180,9 +180,9 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  * locks that don't have a native type (eg. RCU, preempt) or those that need a
  * 'fat' pointer (eg. spin_lock_irqsave).
  *
- * DEFINE_LOCK_GUARD_0(name, lock, unlock, ...)
- * DEFINE_LOCK_GUARD_1(name, type, lock, unlock, ...)
- * DEFINE_LOCK_GUARD_1_COND(name, ext, condlock)
+ * DECLARE_LOCK_GUARD_0(name, lock, unlock, ...)
+ * DECLARE_LOCK_GUARD_1(name, type, lock, unlock, ...)
+ * DECLARE_LOCK_GUARD_1_COND(name, ext, condlock)
  *
  * will result in the following type:
  *
@@ -195,7 +195,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  * be a pointer to the above struct.
  */
 
-#define __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, ...)		\
+#define __DECLARE_UNLOCK_GUARD(_name, _type, _unlock, ...)		\
 typedef struct {							\
 	_type *lock;							\
 	__VA_ARGS__;							\
@@ -212,7 +212,7 @@ static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
 }
 
 
-#define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
+#define __DECLARE_LOCK_GUARD_1(_name, _type, _lock)			\
 static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
 {									\
 	class_##_name##_t _t = { .lock = l }, *_T = &_t;		\
@@ -220,7 +220,7 @@ static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
 	return _t;							\
 }
 
-#define __DEFINE_LOCK_GUARD_0(_name, _lock)				\
+#define __DECLARE_LOCK_GUARD_0(_name, _lock)				\
 static inline class_##_name##_t class_##_name##_constructor(void)	\
 {									\
 	class_##_name##_t _t = { .lock = (void*)1 },			\
@@ -229,15 +229,15 @@ static inline class_##_name##_t class_##_name##_constructor(void)	\
 	return _t;							\
 }
 
-#define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
-__DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\
-__DEFINE_LOCK_GUARD_1(_name, _type, _lock)
+#define DECLARE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
+__DECLARE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\
+__DECLARE_LOCK_GUARD_1(_name, _type, _lock)
 
-#define DEFINE_LOCK_GUARD_0(_name, _lock, _unlock, ...)			\
-__DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
-__DEFINE_LOCK_GUARD_0(_name, _lock)
+#define DECLARE_LOCK_GUARD_0(_name, _lock, _unlock, ...)			\
+__DECLARE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
+__DECLARE_LOCK_GUARD_0(_name, _lock)
 
-#define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
+#define DECLARE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
 	EXTEND_CLASS(_name, _ext,					\
 		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
 		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 861c3bfc5f17..17bfa30b06de 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -162,7 +162,7 @@ static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
 static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
 #endif	/* !CONFIG_HOTPLUG_CPU */
 
-DEFINE_LOCK_GUARD_0(cpus_read_lock, cpus_read_lock(), cpus_read_unlock())
+DECLARE_LOCK_GUARD_0(cpus_read_lock, cpus_read_lock(), cpus_read_unlock())
 
 #ifdef CONFIG_PM_SLEEP_SMP
 extern int freeze_secondary_cpus(int primary);
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1c29947db848..45486817a570 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -991,7 +991,7 @@ static inline bool cpumask_available(cpumask_var_t mask)
 }
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
-DEFINE_FREE(free_cpumask_var, struct cpumask *, if (_T) free_cpumask_var(_T));
+DECLARE_FREE(free_cpumask_var, struct cpumask *, if (_T) free_cpumask_var(_T));
 
 /* It's common to want to use cpu_all_mask in struct member initializers,
  * so it has to refer to an address rather than a pointer. */
diff --git a/include/linux/device.h b/include/linux/device.h
index b9f5464f44ed..a9ffe3b07e32 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1005,7 +1005,7 @@ static inline void device_unlock(struct device *dev)
 	mutex_unlock(&dev->mutex);
 }
 
-DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
+DECLARE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
 
 static inline void device_lock_assert(struct device *dev)
 {
@@ -1055,7 +1055,7 @@ void device_initialize(struct device *dev);
 int __must_check device_add(struct device *dev);
 void device_del(struct device *dev);
 
-DEFINE_FREE(device_del, struct device *, if (_T) device_del(_T))
+DECLARE_FREE(device_del, struct device *, if (_T) device_del(_T))
 
 int device_for_each_child(struct device *dev, void *data,
 			  int (*fn)(struct device *dev, void *data));
@@ -1224,7 +1224,7 @@ extern int (*platform_notify_remove)(struct device *dev);
 struct device *get_device(struct device *dev);
 void put_device(struct device *dev);
 
-DEFINE_FREE(put_device, struct device *, if (_T) put_device(_T))
+DECLARE_FREE(put_device, struct device *, if (_T) put_device(_T))
 
 bool kill_device(struct device *dev);
 
diff --git a/include/linux/file.h b/include/linux/file.h
index 169692cb1906..65de75d62175 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -83,7 +83,7 @@ static inline void fdput_pos(struct fd f)
 	fdput(f);
 }
 
-DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
+DECLARE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
 
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
@@ -93,7 +93,7 @@ extern int __get_unused_fd_flags(unsigned flags, unsigned long nofile);
 extern int get_unused_fd_flags(unsigned flags);
 extern void put_unused_fd(unsigned int fd);
 
-DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
+DECLARE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
 	     get_unused_fd_flags(flags), unsigned flags)
 
 extern void fd_install(unsigned int fd, struct file *file);
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index f026f8926d79..f845b8703d86 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -199,6 +199,6 @@ static inline void firmware_upload_unregister(struct fw_upload *fw_upload)
 
 int firmware_request_cache(struct device *device, const char *name);
 
-DEFINE_FREE(firmware, struct firmware *, release_firmware(_T))
+DECLARE_FREE(firmware, struct firmware *, release_firmware(_T))
 
 #endif
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index f8617eaf08ba..088a4d91b136 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -541,7 +541,7 @@ struct _gpiochip_for_each_data {
 	unsigned int *i;
 };
 
-DEFINE_CLASS(_gpiochip_for_each_data,
+DECLARE_CLASS(_gpiochip_for_each_data,
 	     struct _gpiochip_for_each_data,
 	     if (*_T.label) kfree(*_T.label),
 	     ({
@@ -650,7 +650,7 @@ struct gpio_device *gpio_device_find(const void *data,
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
 
-DEFINE_FREE(gpio_device_put, struct gpio_device *,
+DECLARE_FREE(gpio_device_put, struct gpio_device *,
 	    if (!IS_ERR_OR_NULL(_T)) gpio_device_put(_T))
 
 struct device *gpio_device_to_device(struct gpio_device *gdev);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index e370a7bb3300..b56bacdce411 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -644,10 +644,10 @@ void iio_device_release_direct_mode(struct iio_dev *indio_dev);
  * This autocleanup logic is normally used via
  * iio_device_claim_direct_scoped().
  */
-DEFINE_GUARD(iio_claim_direct, struct iio_dev *, iio_device_claim_direct_mode(_T),
+DECLARE_GUARD(iio_claim_direct, struct iio_dev *, iio_device_claim_direct_mode(_T),
 	     iio_device_release_direct_mode(_T))
 
-DEFINE_GUARD_COND(iio_claim_direct, _try, ({
+DECLARE_GUARD_COND(iio_claim_direct, _try, ({
 			struct iio_dev *dev;
 			int d = iio_device_claim_direct_mode(_T);
 
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 3f003d5fde53..b4966d64b788 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -256,8 +256,8 @@ extern void warn_bogus_irq_restore(void);
 
 #define irqs_disabled_flags(flags) raw_irqs_disabled_flags(flags)
 
-DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
-DEFINE_LOCK_GUARD_0(irqsave,
+DECLARE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
+DECLARE_LOCK_GUARD_0(irqsave,
 		    local_irq_save(_T->flags),
 		    local_irq_restore(_T->flags),
 		    unsigned long flags)
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 67edc4ca2bee..c424fa471b69 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -166,8 +166,8 @@ extern void mutex_unlock(struct mutex *lock);
 
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
-DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
-DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
-DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
+DECLARE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
+DECLARE_GUARD_COND(mutex, _try, mutex_trylock(_T))
+DECLARE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
 
 #endif /* __LINUX_MUTEX_H */
diff --git a/include/linux/of.h b/include/linux/of.h
index a0bedd038a05..6cb0a522542b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -135,7 +135,7 @@ static inline struct device_node *of_node_get(struct device_node *node)
 }
 static inline void of_node_put(struct device_node *node) { }
 #endif /* !CONFIG_OF_DYNAMIC */
-DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
+DECLARE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
 
 /* Pointer for first entry in chain of all nodes. */
 extern struct device_node *of_root;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a04f..b19c7f044a1f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1171,7 +1171,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
 struct pci_dev *pci_dev_get(struct pci_dev *dev);
 void pci_dev_put(struct pci_dev *dev);
-DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
+DECLARE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
 void pci_remove_bus(struct pci_bus *b);
 void pci_stop_and_remove_bus_device(struct pci_dev *dev);
 void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
@@ -1882,7 +1882,7 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
 void pci_dev_lock(struct pci_dev *dev);
 int pci_dev_trylock(struct pci_dev *dev);
 void pci_dev_unlock(struct pci_dev *dev);
-DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
+DECLARE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
 
 /*
  * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 8c677f185901..5bc5a0a6816c 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -134,7 +134,7 @@ extern void __percpu *__alloc_percpu(size_t size, size_t align) __alloc_size(1);
 extern void free_percpu(void __percpu *__pdata);
 extern size_t pcpu_alloc_size(void __percpu *__pdata);
 
-DEFINE_FREE(free_percpu, void __percpu *, free_percpu(_T))
+DECLARE_FREE(free_percpu, void __percpu *, free_percpu(_T))
 
 extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7233e9cf1bab..d07631a09467 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -477,8 +477,8 @@ static __always_inline void preempt_enable_nested(void)
 		preempt_enable();
 }
 
-DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
-DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enable_notrace())
-DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
+DECLARE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
+DECLARE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enable_notrace())
+DECLARE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 17d7ed5f3ae6..91fe15bf5513 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1090,6 +1090,6 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
 
-DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
+DECLARE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
 
 #endif /* __LINUX_RCUPDATE_H */
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index c8b543d428b0..1eab827372ee 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -238,12 +238,12 @@ extern void up_read(struct rw_semaphore *sem);
  */
 extern void up_write(struct rw_semaphore *sem);
 
-DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
-DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
-DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T) == 0)
+DECLARE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
+DECLARE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
+DECLARE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T) == 0)
 
-DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
-DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
+DECLARE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
+DECLARE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
 
 /*
  * downgrade write lock to read lock
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index d362aacf9f89..ece0cc084a6a 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -163,7 +163,7 @@ static inline void put_task_struct(struct task_struct *t)
 	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
 }
 
-DEFINE_FREE(put_task, struct task_struct *, if (_T) put_task_struct(_T))
+DECLARE_FREE(put_task, struct task_struct *, if (_T) put_task_struct(_T))
 
 static inline void put_task_struct_many(struct task_struct *t, int nr)
 {
@@ -228,6 +228,6 @@ static inline void task_unlock(struct task_struct *p)
 	spin_unlock(&p->alloc_lock);
 }
 
-DEFINE_GUARD(task_lock, struct task_struct *, task_lock(_T), task_unlock(_T))
+DECLARE_GUARD(task_lock, struct task_struct *, task_lock(_T), task_unlock(_T))
 
 #endif /* _LINUX_SCHED_TASK_H */
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 739b21262507..a242897880ae 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -266,7 +266,7 @@ void kfree(const void *objp);
 void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
 
-DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
+DECLARE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
 
 /**
  * ksize - Report actual allocation size of associated object
@@ -792,7 +792,7 @@ static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t fla
 extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
 		      __realloc_size(3);
 extern void kvfree(const void *addr);
-DEFINE_FREE(kvfree, void *, if (!IS_ERR_OR_NULL(_T)) kvfree(_T))
+DECLARE_FREE(kvfree, void *, if (!IS_ERR_OR_NULL(_T)) kvfree(_T))
 
 extern void kvfree_sensitive(const void *addr, size_t len);
 
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 3fcd20de6ca8..2ef955703e76 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -534,73 +534,73 @@ int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 
 void free_bucket_spinlocks(spinlock_t *locks);
 
-DEFINE_LOCK_GUARD_1(raw_spinlock, raw_spinlock_t,
+DECLARE_LOCK_GUARD_1(raw_spinlock, raw_spinlock_t,
 		    raw_spin_lock(_T->lock),
 		    raw_spin_unlock(_T->lock))
 
-DEFINE_LOCK_GUARD_1_COND(raw_spinlock, _try, raw_spin_trylock(_T->lock))
+DECLARE_LOCK_GUARD_1_COND(raw_spinlock, _try, raw_spin_trylock(_T->lock))
 
-DEFINE_LOCK_GUARD_1(raw_spinlock_nested, raw_spinlock_t,
+DECLARE_LOCK_GUARD_1(raw_spinlock_nested, raw_spinlock_t,
 		    raw_spin_lock_nested(_T->lock, SINGLE_DEPTH_NESTING),
 		    raw_spin_unlock(_T->lock))
 
-DEFINE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
+DECLARE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
 		    raw_spin_lock_irq(_T->lock),
 		    raw_spin_unlock_irq(_T->lock))
 
-DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq(_T->lock))
+DECLARE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq(_T->lock))
 
-DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
+DECLARE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
 		    raw_spin_lock_irqsave(_T->lock, _T->flags),
 		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
 
-DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irqsave, _try,
+DECLARE_LOCK_GUARD_1_COND(raw_spinlock_irqsave, _try,
 			 raw_spin_trylock_irqsave(_T->lock, _T->flags))
 
-DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
+DECLARE_LOCK_GUARD_1(spinlock, spinlock_t,
 		    spin_lock(_T->lock),
 		    spin_unlock(_T->lock))
 
-DEFINE_LOCK_GUARD_1_COND(spinlock, _try, spin_trylock(_T->lock))
+DECLARE_LOCK_GUARD_1_COND(spinlock, _try, spin_trylock(_T->lock))
 
-DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
+DECLARE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
 		    spin_lock_irq(_T->lock),
 		    spin_unlock_irq(_T->lock))
 
-DEFINE_LOCK_GUARD_1_COND(spinlock_irq, _try,
+DECLARE_LOCK_GUARD_1_COND(spinlock_irq, _try,
 			 spin_trylock_irq(_T->lock))
 
-DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
+DECLARE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
 		    spin_lock_irqsave(_T->lock, _T->flags),
 		    spin_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
 
-DEFINE_LOCK_GUARD_1_COND(spinlock_irqsave, _try,
+DECLARE_LOCK_GUARD_1_COND(spinlock_irqsave, _try,
 			 spin_trylock_irqsave(_T->lock, _T->flags))
 
-DEFINE_LOCK_GUARD_1(read_lock, rwlock_t,
+DECLARE_LOCK_GUARD_1(read_lock, rwlock_t,
 		    read_lock(_T->lock),
 		    read_unlock(_T->lock))
 
-DEFINE_LOCK_GUARD_1(read_lock_irq, rwlock_t,
+DECLARE_LOCK_GUARD_1(read_lock_irq, rwlock_t,
 		    read_lock_irq(_T->lock),
 		    read_unlock_irq(_T->lock))
 
-DEFINE_LOCK_GUARD_1(read_lock_irqsave, rwlock_t,
+DECLARE_LOCK_GUARD_1(read_lock_irqsave, rwlock_t,
 		    read_lock_irqsave(_T->lock, _T->flags),
 		    read_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
 
-DEFINE_LOCK_GUARD_1(write_lock, rwlock_t,
+DECLARE_LOCK_GUARD_1(write_lock, rwlock_t,
 		    write_lock(_T->lock),
 		    write_unlock(_T->lock))
 
-DEFINE_LOCK_GUARD_1(write_lock_irq, rwlock_t,
+DECLARE_LOCK_GUARD_1(write_lock_irq, rwlock_t,
 		    write_lock_irq(_T->lock),
 		    write_unlock_irq(_T->lock))
 
-DEFINE_LOCK_GUARD_1(write_lock_irqsave, rwlock_t,
+DECLARE_LOCK_GUARD_1(write_lock_irqsave, rwlock_t,
 		    write_lock_irqsave(_T->lock, _T->flags),
 		    write_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 236610e4a8fa..1d424223a990 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -343,7 +343,7 @@ static inline void smp_mb__after_srcu_read_unlock(void)
 	/* __srcu_read_unlock has smp_mb() internally so nothing to do here. */
 }
 
-DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
+DECLARE_LOCK_GUARD_1(srcu, struct srcu_struct,
 		    _T->idx = srcu_read_lock(_T->lock),
 		    srcu_read_unlock(_T->lock, _T->idx),
 		    int idx)
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 210096f124ee..6d4137d85362 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -660,13 +660,13 @@ void snd_pcm_stream_unlock_irqrestore(struct snd_pcm_substream *substream,
 	} while (0)
 
 /* definitions for guard(); use like guard(pcm_stream_lock) */
-DEFINE_LOCK_GUARD_1(pcm_stream_lock, struct snd_pcm_substream,
+DECLARE_LOCK_GUARD_1(pcm_stream_lock, struct snd_pcm_substream,
 		    snd_pcm_stream_lock(_T->lock),
 		    snd_pcm_stream_unlock(_T->lock))
-DEFINE_LOCK_GUARD_1(pcm_stream_lock_irq, struct snd_pcm_substream,
+DECLARE_LOCK_GUARD_1(pcm_stream_lock_irq, struct snd_pcm_substream,
 		    snd_pcm_stream_lock_irq(_T->lock),
 		    snd_pcm_stream_unlock_irq(_T->lock))
-DEFINE_LOCK_GUARD_1(pcm_stream_lock_irqsave, struct snd_pcm_substream,
+DECLARE_LOCK_GUARD_1(pcm_stream_lock_irqsave, struct snd_pcm_substream,
 		    snd_pcm_stream_lock_irqsave(_T->lock, _T->flags),
 		    snd_pcm_stream_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d211d40a2edc..471768047db7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6439,7 +6439,7 @@ static void queue_core_balance(struct rq *rq)
 	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
 }
 
-DEFINE_LOCK_GUARD_1(core_lock, int,
+DECLARE_LOCK_GUARD_1(core_lock, int,
 		    sched_core_lock(*_T->lock, &_T->flags),
 		    sched_core_unlock(*_T->lock, &_T->flags),
 		    unsigned long flags)
@@ -7591,7 +7591,7 @@ static struct task_struct *find_get_task(pid_t pid)
 	return p;
 }
 
-DEFINE_CLASS(find_get_task, struct task_struct *, if (_T) put_task_struct(_T),
+DECLARE_CLASS(find_get_task, struct task_struct *, if (_T) put_task_struct(_T),
 	     find_get_task(pid), pid_t pid)
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ae50f212775e..6c1ccf49c914 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1673,7 +1673,7 @@ task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
-DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
+DECLARE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
 		    _T->rq = task_rq_lock(_T->lock, &_T->rf),
 		    task_rq_unlock(_T->rq, _T->lock, &_T->rf),
 		    struct rq *rq; struct rq_flags rf)
@@ -1726,17 +1726,17 @@ rq_unlock(struct rq *rq, struct rq_flags *rf)
 	raw_spin_rq_unlock(rq);
 }
 
-DEFINE_LOCK_GUARD_1(rq_lock, struct rq,
+DECLARE_LOCK_GUARD_1(rq_lock, struct rq,
 		    rq_lock(_T->lock, &_T->rf),
 		    rq_unlock(_T->lock, &_T->rf),
 		    struct rq_flags rf)
 
-DEFINE_LOCK_GUARD_1(rq_lock_irq, struct rq,
+DECLARE_LOCK_GUARD_1(rq_lock_irq, struct rq,
 		    rq_lock_irq(_T->lock, &_T->rf),
 		    rq_unlock_irq(_T->lock, &_T->rf),
 		    struct rq_flags rf)
 
-DEFINE_LOCK_GUARD_1(rq_lock_irqsave, struct rq,
+DECLARE_LOCK_GUARD_1(rq_lock_irqsave, struct rq,
 		    rq_lock_irqsave(_T->lock, &_T->rf),
 		    rq_unlock_irqrestore(_T->lock, &_T->rf),
 		    struct rq_flags rf)
@@ -2661,8 +2661,8 @@ static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
 static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2) {}
 #endif
 
-#define DEFINE_LOCK_GUARD_2(name, type, _lock, _unlock, ...)		\
-__DEFINE_UNLOCK_GUARD(name, type, _unlock, type *lock2; __VA_ARGS__) \
+#define DECLARE_LOCK_GUARD_2(name, type, _lock, _unlock, ...)		\
+__DECLARE_UNLOCK_GUARD(name, type, _unlock, type *lock2; __VA_ARGS__) \
 static inline class_##name##_t class_##name##_constructor(type *lock, type *lock2) \
 { class_##name##_t _t = { .lock = lock, .lock2 = lock2 }, *_T = &_t;	\
   _lock; return _t; }
@@ -2802,7 +2802,7 @@ static inline void double_raw_unlock(raw_spinlock_t *l1, raw_spinlock_t *l2)
 	raw_spin_unlock(l2);
 }
 
-DEFINE_LOCK_GUARD_2(double_raw_spinlock, raw_spinlock_t,
+DECLARE_LOCK_GUARD_2(double_raw_spinlock, raw_spinlock_t,
 		    double_raw_lock(_T->lock, _T->lock2),
 		    double_raw_unlock(_T->lock, _T->lock2))
 
@@ -2863,7 +2863,7 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 
 #endif
 
-DEFINE_LOCK_GUARD_2(double_rq_lock, struct rq,
+DECLARE_LOCK_GUARD_2(double_rq_lock, struct rq,
 		    double_rq_lock(_T->lock, _T->lock2),
 		    double_rq_unlock(_T->lock, _T->lock2))
 
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 6f6a5fc85b42..7e72d973d419 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2507,19 +2507,19 @@ static void fs_reclaim_tests(void)
 }
 
 /* Defines guard classes to create contexts */
-DEFINE_LOCK_GUARD_0(HARDIRQ, HARDIRQ_ENTER(), HARDIRQ_EXIT())
-DEFINE_LOCK_GUARD_0(NOTTHREADED_HARDIRQ,
+DECLARE_LOCK_GUARD_0(HARDIRQ, HARDIRQ_ENTER(), HARDIRQ_EXIT())
+DECLARE_LOCK_GUARD_0(NOTTHREADED_HARDIRQ,
 	do {
 		local_irq_disable();
 		__irq_enter();
 		WARN_ON(!in_irq());
 	} while(0), HARDIRQ_EXIT())
-DEFINE_LOCK_GUARD_0(SOFTIRQ, SOFTIRQ_ENTER(), SOFTIRQ_EXIT())
+DECLARE_LOCK_GUARD_0(SOFTIRQ, SOFTIRQ_ENTER(), SOFTIRQ_EXIT())
 
 /* Define RCU guards, should go away when RCU has its own guard definitions */
-DEFINE_LOCK_GUARD_0(RCU, rcu_read_lock(), rcu_read_unlock())
-DEFINE_LOCK_GUARD_0(RCU_BH, rcu_read_lock_bh(), rcu_read_unlock_bh())
-DEFINE_LOCK_GUARD_0(RCU_SCHED, rcu_read_lock_sched(), rcu_read_unlock_sched())
+DECLARE_LOCK_GUARD_0(RCU, rcu_read_lock(), rcu_read_unlock())
+DECLARE_LOCK_GUARD_0(RCU_BH, rcu_read_lock_bh(), rcu_read_unlock_bh())
+DECLARE_LOCK_GUARD_0(RCU_SCHED, rcu_read_lock_sched(), rcu_read_unlock_sched())
 
 
 #define GENERATE_2_CONTEXT_TESTCASE(outer, outer_lock, inner, inner_lock)	\
diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 3d37e9fa7b9c..c1b32255b87d 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -236,7 +236,7 @@ static void snd_ctl_led_notify(struct snd_card *card, unsigned int mask,
 	}
 }
 
-DEFINE_FREE(snd_card_unref, struct snd_card *, if (_T) snd_card_unref(_T))
+DECLARE_FREE(snd_card_unref, struct snd_card *, if (_T) snd_card_unref(_T))
 
 static int snd_ctl_led_set_id(int card_number, struct snd_ctl_elem_id *id,
 			      unsigned int group, bool set)
-- 
2.39.2


