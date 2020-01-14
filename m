Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 661C413AFCC
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 17:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgANQqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 11:46:40 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:52117 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgANQqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 11:46:40 -0500
Received: by mail-pj1-f74.google.com with SMTP id h2so8422473pji.1
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 08:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/0hoB7QTx34Umi8lqf0IpefwqLyxOozJhDYnRQx15So=;
        b=oUbGFHuzxfbikP+w2H69yHyNg/DNQR5mgxnRGWfLWXn02suHKCUCsZFMMAqlJ/ukA8
         kVH2YbvZp5i1FPm5YL6AbrGuv2ZEi4yXXCHUq1EVyW/2f7ez2DKjGpvMT/dOSi8PjjW1
         KPxIP71suH4lFFsZKqxodO8bJamM9/CR/gzHtsU1t9+W2PTtOHIvgmMC08guw8Iyt8lj
         FQyrkNv6afyio3EO3eDi62J7vr8hZwoAYTV4DoyvjMO0rqTgX15ANVcbJ73mH37BP6nN
         Q/muvEvr1klzCtLsIJzj5PA4yupFPRbpLg2Aso0rkj3UfFuhTQcYO4gDJOQHdaegGbJR
         XuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/0hoB7QTx34Umi8lqf0IpefwqLyxOozJhDYnRQx15So=;
        b=meMNwlswUQqOkAUkS42A2tn53qamfJP4olSanAcHDDudZTFl55soB97A3CmbWMfSWz
         9D6zYjTmBMmDK7SkqXihLpmfXqxPF4auO+bJ4OpfYKxP7JSiPOTklbVDFvsIplSBDAvh
         CDPZFlSn9fWZH0reDJtZQfVGhXR+KA4xtyMp48tAnng8DKTHVVtpgnuf8IGZk12ZSEd0
         RgLAoXiPq3fnVllvAbRLKa/23UWZ/bailRpDBh1FCRNSiQHUj7Ntv2uNBS6rccSqC52/
         KKTy098xGaI4ze0cd94P0T96Livq12+eDdfvLkXSL2NtVnx8vnjlN8txZ5G6ukIV0STp
         WZZg==
X-Gm-Message-State: APjAAAWGkSPdz3z0BpEoMs01yukAs02Eqyhri6245GgPEjn1PT4iAz5Z
        ZJ/8xpejX6jN6FHxN4RCNCm0zMUhP/ST
X-Google-Smtp-Source: APXvYqyh0cBrgfBqhYYig0C/EXSsJKS+YZOJNX/tJwJlhzdAbdUvRexbr3b3xzyUJ10wp7ncxOOIfEt1zsZ8
X-Received: by 2002:a63:cd06:: with SMTP id i6mr28311164pgg.48.1579020399538;
 Tue, 14 Jan 2020 08:46:39 -0800 (PST)
Date:   Tue, 14 Jan 2020 08:46:06 -0800
In-Reply-To: <20200114164614.47029-1-brianvv@google.com>
Message-Id: <20200114164614.47029-3-brianvv@google.com>
Mime-Version: 1.0
References: <20200114164614.47029-1-brianvv@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v4 bpf-next 2/9] bpf: add generic support for lookup batch op
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit introduces generic support for the bpf_map_lookup_batch.
This implementation can be used by almost all the bpf maps since its core
implementation is relying on the existing map_get_next_key and
map_lookup_elem. The bpf syscall subcommand introduced is:

  BPF_MAP_LOOKUP_BATCH

The UAPI attribute is:

  struct { /* struct used by BPF_MAP_*_BATCH commands */
         __aligned_u64   in_batch;       /* start batch,
                                          * NULL to start from beginning
                                          */
         __aligned_u64   out_batch;      /* output: next start batch */
         __aligned_u64   keys;
         __aligned_u64   values;
         __u32           count;          /* input/output:
                                          * input: # of key/value
                                          * elements
                                          * output: # of filled elements
                                          */
         __u32           map_fd;
         __u64           elem_flags;
         __u64           flags;
  } batch;

in_batch/out_batch are opaque values use to communicate between
user/kernel space, in_batch/out_batch must be of key_size length.

To start iterating from the beginning in_batch must be null,
count is the # of key/value elements to retrieve. Note that the 'keys'
buffer must be a buffer of key_size * count size and the 'values' buffer
must be value_size * count, where value_size must be aligned to 8 bytes
by userspace if it's dealing with percpu maps. 'count' will contain the
number of keys/values successfully retrieved. Note that 'count' is an
input/output variable and it can contain a lower value after a call.

If there's no more entries to retrieve, ENOENT will be returned. If error
is ENOENT, count might be > 0 in case it copied some values but there were
no more entries to retrieve.

Note that if the return code is an error and not -EFAULT,
count indicates the number of elements successfully processed.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h      |   5 ++
 include/uapi/linux/bpf.h |  18 +++++
 kernel/bpf/syscall.c     | 154 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 173 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index aed2bc39d72b6..807744ecaa5a1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -44,6 +44,8 @@ struct bpf_map_ops {
 	int (*map_get_next_key)(struct bpf_map *map, void *key, void *next_key);
 	void (*map_release_uref)(struct bpf_map *map);
 	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
+	int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr *attr,
+				union bpf_attr __user *uattr);
 
 	/* funcs callable from userspace and from eBPF programs */
 	void *(*map_lookup_elem)(struct bpf_map *map, void *key);
@@ -982,6 +984,9 @@ void *bpf_map_area_alloc(u64 size, int numa_node);
 void *bpf_map_area_mmapable_alloc(u64 size, int numa_node);
 void bpf_map_area_free(void *base);
 void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
+int  generic_map_lookup_batch(struct bpf_map *map,
+			      const union bpf_attr *attr,
+			      union bpf_attr __user *uattr);
 
 extern int sysctl_unprivileged_bpf_disabled;
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 52966e758fe59..8185f1542daa1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -107,6 +107,7 @@ enum bpf_cmd {
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
 	BPF_BTF_GET_NEXT_ID,
+	BPF_MAP_LOOKUP_BATCH,
 };
 
 enum bpf_map_type {
@@ -420,6 +421,23 @@ union bpf_attr {
 		__u64		flags;
 	};
 
+	struct { /* struct used by BPF_MAP_*_BATCH commands */
+		__aligned_u64	in_batch;	/* start batch,
+						 * NULL to start from beginning
+						 */
+		__aligned_u64	out_batch;	/* output: next start batch */
+		__aligned_u64	keys;
+		__aligned_u64	values;
+		__u32		count;		/* input/output:
+						 * input: # of key/value
+						 * elements
+						 * output: # of filled elements
+						 */
+		__u32		map_fd;
+		__u64		elem_flags;
+		__u64		flags;
+	} batch;
+
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
 		__u32		prog_type;	/* one of enum bpf_prog_type */
 		__u32		insn_cnt;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 08b0b6e40454b..d4acb6eb5ef9e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -219,10 +219,8 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	void *ptr;
 	int err;
 
-	if (bpf_map_is_dev_bound(map)) {
-		err =  bpf_map_offload_lookup_elem(map, key, value);
-		return err;
-	}
+	if (bpf_map_is_dev_bound(map))
+		return bpf_map_offload_lookup_elem(map, key, value);
 
 	preempt_disable();
 	this_cpu_inc(bpf_prog_active);
@@ -1220,6 +1218,103 @@ static int map_get_next_key(union bpf_attr *attr)
 	return err;
 }
 
+#define MAP_LOOKUP_RETRIES 3
+
+int generic_map_lookup_batch(struct bpf_map *map,
+				    const union bpf_attr *attr,
+				    union bpf_attr __user *uattr)
+{
+	void __user *uobatch = u64_to_user_ptr(attr->batch.out_batch);
+	void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
+	void __user *values = u64_to_user_ptr(attr->batch.values);
+	void __user *keys = u64_to_user_ptr(attr->batch.keys);
+	void *buf, *buf_prevkey, *prev_key, *key, *value;
+	int err, retry = MAP_LOOKUP_RETRIES;
+	u32 value_size, cp, max_count;
+	bool first_key = false;
+
+	if (attr->batch.elem_flags & ~BPF_F_LOCK)
+		return -EINVAL;
+
+	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
+	    !map_value_has_spin_lock(map))
+		return -EINVAL;
+
+	value_size = bpf_map_value_size(map);
+
+	max_count = attr->batch.count;
+	if (!max_count)
+		return 0;
+
+	buf_prevkey = kmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
+	if (!buf_prevkey)
+		return -ENOMEM;
+
+	buf = kmalloc(map->key_size + value_size, GFP_USER | __GFP_NOWARN);
+	if (!buf) {
+		kvfree(buf_prevkey);
+		return -ENOMEM;
+	}
+
+	err = -EFAULT;
+	first_key = false;
+	prev_key = NULL;
+	if (ubatch && copy_from_user(buf_prevkey, ubatch, map->key_size))
+		goto free_buf;
+	key = buf;
+	value = key + map->key_size;
+	if (ubatch)
+		prev_key = buf_prevkey;
+
+	for (cp = 0; cp < max_count;) {
+		rcu_read_lock();
+		err = map->ops->map_get_next_key(map, prev_key, key);
+		rcu_read_unlock();
+		if (err)
+			break;
+		err = bpf_map_copy_value(map, key, value,
+					 attr->batch.elem_flags);
+
+		if (err == -ENOENT) {
+			if (retry) {
+				retry--;
+				continue;
+			}
+			err = -EINTR;
+			break;
+		}
+
+		if (err)
+			goto free_buf;
+
+		if (copy_to_user(keys + cp * map->key_size, key,
+				 map->key_size)) {
+			err = -EFAULT;
+			goto free_buf;
+		}
+		if (copy_to_user(values + cp * value_size, value, value_size)) {
+			err = -EFAULT;
+			goto free_buf;
+		}
+
+		if (!prev_key)
+			prev_key = buf_prevkey;
+
+		swap(prev_key, key);
+		retry = MAP_LOOKUP_RETRIES;
+		cp++;
+	}
+
+	if ((copy_to_user(&uattr->batch.count, &cp, sizeof(cp)) ||
+		    (cp && copy_to_user(uobatch, prev_key, map->key_size))))
+		err = -EFAULT;
+
+free_buf:
+	kfree(buf_prevkey);
+	kfree(buf);
+	return err;
+}
+
 #define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD value
 
 static int map_lookup_and_delete_elem(union bpf_attr *attr)
@@ -3076,6 +3171,54 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	return err;
 }
 
+#define BPF_MAP_BATCH_LAST_FIELD batch.flags
+
+#define BPF_DO_BATCH(fn)			\
+	do {					\
+		if (!fn) {			\
+			err = -ENOTSUPP;	\
+			goto err_put;		\
+		}				\
+		err = fn(map, attr, uattr);	\
+	} while (0)
+
+static int bpf_map_do_batch(const union bpf_attr *attr,
+			    union bpf_attr __user *uattr,
+			    int cmd)
+{
+	struct bpf_map *map;
+	int err, ufd;
+	struct fd f;
+
+	if (CHECK_ATTR(BPF_MAP_BATCH))
+		return -EINVAL;
+
+	ufd = attr->batch.map_fd;
+	f = fdget(ufd);
+	map = __bpf_map_get(f);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	if (cmd == BPF_MAP_LOOKUP_BATCH &&
+	    !(map_get_sys_perms(map, f) & FMODE_CAN_READ)) {
+		err = -EPERM;
+		goto err_put;
+	}
+
+	if (cmd != BPF_MAP_LOOKUP_BATCH &&
+	    !(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
+		err = -EPERM;
+		goto err_put;
+	}
+
+	if (cmd == BPF_MAP_LOOKUP_BATCH)
+		BPF_DO_BATCH(map->ops->map_lookup_batch);
+
+err_put:
+	fdput(f);
+	return err;
+}
+
 SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
 {
 	union bpf_attr attr = {};
@@ -3173,6 +3316,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	case BPF_MAP_LOOKUP_AND_DELETE_ELEM:
 		err = map_lookup_and_delete_elem(&attr);
 		break;
+	case BPF_MAP_LOOKUP_BATCH:
+		err = bpf_map_do_batch(&attr, uattr, BPF_MAP_LOOKUP_BATCH);
+		break;
 	default:
 		err = -EINVAL;
 		break;
-- 
2.25.0.rc1.283.g88dfdc4193-goog

