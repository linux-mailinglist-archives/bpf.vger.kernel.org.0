Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05251010E3
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 02:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKSBoS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 20:44:18 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:43711 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfKSBoS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 20:44:18 -0500
Received: by mail-ua1-f74.google.com with SMTP id r23so2335429uam.10
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 17:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7yudR9z6FsUF5vOdWdJ5O3TteIQewSMsjeh0HU6md+0=;
        b=q8aVJRlIm204YPH9/AtJrETkgKlGM1dBOe3HxLloxq6ak0M6tdIX3Z+DhYz60ZR6Oe
         /OGFXwFrITl1lwHDK+vyJnfYriOGmTPnzccVzSFv3ZBgs2G9w3oaPVDhvCEho3pBniCc
         5SDHPzGjZCDuG1RicZ8DMy24/iffLn2GT5VZlK5eGme4GsPrPnFVxHoMUeGQInJVhSF1
         p58W622lopk58SFSojSUUB8F0xaPThR+jh81hyJKjv14LXXy54wgWsnrMbivp0eeZd22
         bT04cRoHvxH5bLeI6NjZcsLcCPQ6SYloOCSEoHDZy818AHAbJ4JD/90r+EiWgf+nqCAm
         zcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7yudR9z6FsUF5vOdWdJ5O3TteIQewSMsjeh0HU6md+0=;
        b=isrYVnIrxksVUG+50RYSfOtwG1H7XYXHy0B94Nbl9t9oRVWLyq97g60L+edYiKNHKJ
         0raTCa8E8BN8MwrrAG9WdbeV1iNeMpxp9ChwoHtXdVL9Zy24cq2ONlJCqXkWDVVBZzay
         0HYIp22NWTcCWj3J9vySys6zaf/NKEmYmQvmCi8skLFjC2rKPc5DGm67/mGkXhtOMht+
         teQFodhvvBC7hFYi9xZJsJAcjkMs6/3I5Yax9YRjWeoBQEPL2tIrDzQgf4BkAPZbnMrE
         9mO2sMws8+FxRxhGZ9wAPBkM+CgSSagU7qY77CvYKGhvirIHq2xLIyPTfNtyUz7VAW+N
         6dGA==
X-Gm-Message-State: APjAAAUulv5tefGi4BzoRSNxr7hKFcr3sovO8yDoSbnSaYUoNCbNF82m
        QnscXIf4eFgCo+1l3ZnXY9P7qaG6KH8y
X-Google-Smtp-Source: APXvYqx67JnqtMDFCS1AVnvbrdFYCVhBi0OQ+5/CqzpORKgLTODWUV0yR2XppH5jp/poq0WHyPMWP4QHXMDs
X-Received: by 2002:a1f:3258:: with SMTP id y85mr8062238vky.7.1574127855281;
 Mon, 18 Nov 2019 17:44:15 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:43:50 -0800
In-Reply-To: <20191119014357.98465-1-brianvv@google.com>
Message-Id: <20191119014357.98465-3-brianvv@google.com>
Mime-Version: 1.0
References: <20191119014357.98465-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH bpf-next 2/9] bpf: add generic support for lookup and
 lookup_and_delete batch ops
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit introduces generic support for the bpf_map_lookup_batch and
bpf_map_lookup_and_delete_batch ops. This implementation can be used by
almost all the bpf maps since its core implementation is relying on the
existing map_get_next_key, map_lookup_elem and map_delete_elem
functions. The bpf syscall subcommands introduced are:

  BPF_MAP_LOOKUP_BATCH
  BPF_MAP_LOOKUP_AND_DELETE_BATCH

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

If there's no more entries to retrieve, ENOENT will be return. If an
error is returned count should be 0, only if error is ENOENT, count might
be > 0 in case it copied some values but there were no more entries to
retrieve.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h      |  11 +++
 include/uapi/linux/bpf.h |  19 +++++
 kernel/bpf/syscall.c     | 176 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b81cde47314e..767a823dbac74 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -41,6 +41,11 @@ struct bpf_map_ops {
 	int (*map_get_next_key)(struct bpf_map *map, void *key, void *next_key);
 	void (*map_release_uref)(struct bpf_map *map);
 	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
+	int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr *attr,
+				union bpf_attr __user *uattr);
+	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
+					   const union bpf_attr *attr,
+					   union bpf_attr __user *uattr);
 
 	/* funcs callable from userspace and from eBPF programs */
 	void *(*map_lookup_elem)(struct bpf_map *map, void *key);
@@ -797,6 +802,12 @@ void bpf_map_charge_move(struct bpf_map_memory *dst,
 void *bpf_map_area_alloc(size_t size, int numa_node);
 void bpf_map_area_free(void *base);
 void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
+int  generic_map_lookup_batch(struct bpf_map *map,
+			      const union bpf_attr *attr,
+			      union bpf_attr __user *uattr);
+int  generic_map_lookup_and_delete_batch(struct bpf_map *map,
+					 const union bpf_attr *attr,
+					 union bpf_attr __user *uattr);
 
 extern int sysctl_unprivileged_bpf_disabled;
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4842a134b202a..e60b7b7cda61a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -107,6 +107,8 @@ enum bpf_cmd {
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
 	BPF_BTF_GET_NEXT_ID,
+	BPF_MAP_LOOKUP_BATCH,
+	BPF_MAP_LOOKUP_AND_DELETE_BATCH,
 };
 
 enum bpf_map_type {
@@ -400,6 +402,23 @@ union bpf_attr {
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
index cc714c9d5b4cc..d0d3d0e0eaca4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1127,6 +1127,124 @@ static int map_get_next_key(union bpf_attr *attr)
 	return err;
 }
 
+static int __generic_map_lookup_batch(struct bpf_map *map,
+				      const union bpf_attr *attr,
+				      union bpf_attr __user *uattr,
+				      bool do_delete)
+{
+	void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
+	void __user *uobatch = u64_to_user_ptr(attr->batch.out_batch);
+	void __user *values = u64_to_user_ptr(attr->batch.values);
+	void __user *keys = u64_to_user_ptr(attr->batch.keys);
+	void *buf, *prev_key, *key, *value;
+	u32 value_size, cp, max_count;
+	bool first_key = false;
+	int err, retry = 3;
+
+	if (attr->batch.elem_flags & ~BPF_F_LOCK)
+		return -EINVAL;
+
+	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
+	    !map_value_has_spin_lock(map)) {
+		err = -EINVAL;
+		goto err_put;
+	}
+
+	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
+	    map->map_type == BPF_MAP_TYPE_STACK) {
+		err = -ENOTSUPP;
+		goto err_put;
+	}
+
+	value_size = bpf_map_value_size(map);
+
+	max_count = attr->batch.count;
+	if (!max_count)
+		return 0;
+
+	err = -ENOMEM;
+	buf = kmalloc(map->key_size + value_size, GFP_USER | __GFP_NOWARN);
+	if (!buf)
+		goto err_put;
+
+	err = -EFAULT;
+	first_key = false;
+	if (ubatch && copy_from_user(buf, ubatch, map->key_size))
+		goto free_buf;
+	key = buf;
+	value = key + map->key_size;
+	if (!ubatch) {
+		prev_key = NULL;
+		first_key = true;
+	}
+
+
+	for (cp = 0; cp < max_count; cp++) {
+		if (cp || first_key) {
+			rcu_read_lock();
+			err = map->ops->map_get_next_key(map, prev_key, key);
+			rcu_read_unlock();
+			if (err)
+				break;
+		}
+		err = bpf_map_copy_value(map, key, value,
+					 attr->batch.elem_flags, do_delete);
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
+		prev_key = key;
+		retry = 3;
+	}
+	if (!err) {
+		rcu_read_lock();
+		err = map->ops->map_get_next_key(map, prev_key, key);
+		rcu_read_unlock();
+	}
+
+	if ((copy_to_user(&uattr->batch.count, &cp, sizeof(cp)) ||
+		    (copy_to_user(uobatch, key, map->key_size))))
+		err = -EFAULT;
+
+free_buf:
+	kfree(buf);
+err_put:
+	return err;
+}
+
+int generic_map_lookup_batch(struct bpf_map *map,
+			     const union bpf_attr *attr,
+			     union bpf_attr __user *uattr)
+{
+	return __generic_map_lookup_batch(map, attr, uattr, false);
+}
+
+int generic_map_lookup_and_delete_batch(struct bpf_map *map,
+					const union bpf_attr *attr,
+					union bpf_attr __user *uattr)
+{
+	return __generic_map_lookup_batch(map, attr, uattr, true);
+}
+
 #define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD value
 
 static int map_lookup_and_delete_elem(union bpf_attr *attr)
@@ -2956,6 +3074,57 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
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
+	if ((cmd == BPF_MAP_LOOKUP_BATCH ||
+	     cmd == BPF_MAP_LOOKUP_AND_DELETE_BATCH) &&
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
+	else
+		BPF_DO_BATCH(map->ops->map_lookup_and_delete_batch);
+
+err_put:
+	fdput(f);
+	return err;
+}
+
 SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
 {
 	union bpf_attr attr = {};
@@ -3053,6 +3222,13 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	case BPF_MAP_LOOKUP_AND_DELETE_ELEM:
 		err = map_lookup_and_delete_elem(&attr);
 		break;
+	case BPF_MAP_LOOKUP_BATCH:
+		err = bpf_map_do_batch(&attr, uattr, BPF_MAP_LOOKUP_BATCH);
+		break;
+	case BPF_MAP_LOOKUP_AND_DELETE_BATCH:
+		err = bpf_map_do_batch(&attr, uattr,
+				       BPF_MAP_LOOKUP_AND_DELETE_BATCH);
+		break;
 	default:
 		err = -EINVAL;
 		break;
-- 
2.24.0.432.g9d3f5f5b63-goog

