Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93F31010F6
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 02:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfKSBoX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 20:44:23 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56104 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfKSBoW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 20:44:22 -0500
Received: by mail-pf1-f202.google.com with SMTP id z3so14660543pfk.22
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 17:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+jjji3tSpxwlbDZ3IxnBRsu+dAwMsSkbh2xmNZIHuxI=;
        b=E4wil7IxwWw+wByGTqO1KHoDDxMkcPzaMl+JQsKi39KSa3FHJgIuYvg5dfj7URC4DC
         fZ9PlZYUoXaG/cvQI2iSWJsc94df3ZxbuBP/xZ9+jycXRfDzX5mod15XtQaaLXpmXPML
         vRbJB7Pet6zJ8lzNYIx6yt9Ye3z/Wxr4/xC/Pwt0dBZRrB257mj6eMD9Ggnu4CmwA+AK
         Bxnc2fKCELfOFrbpXvYNmm+oyzssqQFXPzqLZJHXCCvRBx2Ni0rKdQK2b89bP9qcwyZH
         ls1rInHVdry4nOFL0uRGi99Pu9pTm16pmfLMdiUlwF0IW81VqNyTxdwRIRYpfejfMG5L
         boKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+jjji3tSpxwlbDZ3IxnBRsu+dAwMsSkbh2xmNZIHuxI=;
        b=Em6q1FmVtOes46zZ5RGuOGuuuRZgyh5IEGpqNehUzQ/ILLDVSh8ijztvZsanDr4p0O
         QMicL5FIus4CiXEe8diikq955/3IXN0vvDyuCm7ueU6KxZD+O2OL1+9dHViWl0Zh3i0O
         lgYl8VPxsnjQELpTYu4R/VH8WvwrNiCIXnJa6OGbwA1wYnDHwwUWeDQfPaA2b0TZdGvs
         +JX64hqENBIXH3rHymt+38BnzF0s5iewNWp0PzNVf9qqAXpPH2zD00HYl3xN2NWIKOke
         gOokIoK1hVHbLItkpEeZK4HdtPKnYem00zFtIGqj2pIVerwGsEVklgdVrfhvp6Jguwvm
         lemQ==
X-Gm-Message-State: APjAAAWu0fERrsx/+z79e2R/gx/JlWqoI6dpdkQHtpEAa0lf3wk+Me/K
        E5KbTOh5bZ/ry6+N0R1QGxJubog3EWZQ
X-Google-Smtp-Source: APXvYqzaqO5xeEXSVtu9hVPofbPh+gCloCGl7iDrx/zg+fhYwqy9IC0zjfsgFrvc2zr57yqggl9sjX3AYdCL
X-Received: by 2002:a65:424a:: with SMTP id d10mr2644699pgq.122.1574127861405;
 Mon, 18 Nov 2019 17:44:21 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:43:51 -0800
In-Reply-To: <20191119014357.98465-1-brianvv@google.com>
Message-Id: <20191119014357.98465-4-brianvv@google.com>
Mime-Version: 1.0
References: <20191119014357.98465-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH bpf-next 3/9] bpf: add generic support for update and delete
 batch ops
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

This commit adds generic support for update and delete batch ops that
can be used for almost all the bpf maps. These commands share the same
UAPI attr that lookup and lookup_and_delet batch ops used and the
syscall commands are:

  BPF_MAP_UPDATE_BATCH
  BPF_MAP_DELETE_BATCH

The main difference between update/delete and lookup/lookup_and_delete
batch ops is that for update/delete keys/values must be specified for
userspace and because of that, neither in_batch nor out_batch are used.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h      |  10 ++++
 include/uapi/linux/bpf.h |   2 +
 kernel/bpf/syscall.c     | 126 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 767a823dbac74..96a19e1fd2b5b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -46,6 +46,10 @@ struct bpf_map_ops {
 	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
 					   const union bpf_attr *attr,
 					   union bpf_attr __user *uattr);
+	int (*map_update_batch)(struct bpf_map *map, const union bpf_attr *attr,
+				union bpf_attr __user *uattr);
+	int (*map_delete_batch)(struct bpf_map *map, const union bpf_attr *attr,
+				union bpf_attr __user *uattr);
 
 	/* funcs callable from userspace and from eBPF programs */
 	void *(*map_lookup_elem)(struct bpf_map *map, void *key);
@@ -808,6 +812,12 @@ int  generic_map_lookup_batch(struct bpf_map *map,
 int  generic_map_lookup_and_delete_batch(struct bpf_map *map,
 					 const union bpf_attr *attr,
 					 union bpf_attr __user *uattr);
+int  generic_map_update_batch(struct bpf_map *map,
+			      const union bpf_attr *attr,
+			      union bpf_attr __user *uattr);
+int  generic_map_delete_batch(struct bpf_map *map,
+			      const union bpf_attr *attr,
+			      union bpf_attr __user *uattr);
 
 extern int sysctl_unprivileged_bpf_disabled;
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e60b7b7cda61a..0f6ff0c4d79dd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -109,6 +109,8 @@ enum bpf_cmd {
 	BPF_BTF_GET_NEXT_ID,
 	BPF_MAP_LOOKUP_BATCH,
 	BPF_MAP_LOOKUP_AND_DELETE_BATCH,
+	BPF_MAP_UPDATE_BATCH,
+	BPF_MAP_DELETE_BATCH,
 };
 
 enum bpf_map_type {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d0d3d0e0eaca4..06e1bcf40fb8d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1127,6 +1127,120 @@ static int map_get_next_key(union bpf_attr *attr)
 	return err;
 }
 
+int generic_map_delete_batch(struct bpf_map *map,
+			     const union bpf_attr *attr,
+			     union bpf_attr __user *uattr)
+{
+	void __user *keys = u64_to_user_ptr(attr->batch.keys);
+	int ufd = attr->map_fd;
+	u32 cp, max_count;
+	struct fd f;
+	void *key;
+	int err;
+
+	f = fdget(ufd);
+	if (attr->batch.elem_flags & ~BPF_F_LOCK)
+		return -EINVAL;
+
+	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
+	    !map_value_has_spin_lock(map)) {
+		err = -EINVAL;
+		goto err_put;
+	}
+
+	max_count = attr->batch.count;
+	if (!max_count)
+		return 0;
+
+	err = -ENOMEM;
+	for (cp = 0; cp < max_count; cp++) {
+		key = __bpf_copy_key(keys + cp * map->key_size, map->key_size);
+		if (IS_ERR(key)) {
+			err = PTR_ERR(key);
+			break;
+		}
+
+		if (err)
+			break;
+		if (bpf_map_is_dev_bound(map)) {
+			err = bpf_map_offload_delete_elem(map, key);
+			break;
+		}
+
+		preempt_disable();
+		__this_cpu_inc(bpf_prog_active);
+		rcu_read_lock();
+		err = map->ops->map_delete_elem(map, key);
+		rcu_read_unlock();
+		__this_cpu_dec(bpf_prog_active);
+		preempt_enable();
+		maybe_wait_bpf_programs(map);
+		if (err)
+			break;
+	}
+	if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
+		err = -EFAULT;
+err_put:
+	return err;
+}
+int generic_map_update_batch(struct bpf_map *map,
+			     const union bpf_attr *attr,
+			     union bpf_attr __user *uattr)
+{
+	void __user *values = u64_to_user_ptr(attr->batch.values);
+	void __user *keys = u64_to_user_ptr(attr->batch.keys);
+	u32 value_size, cp, max_count;
+	int ufd = attr->map_fd;
+	void *key, *value;
+	struct fd f;
+	int err;
+
+	f = fdget(ufd);
+	if (attr->batch.elem_flags & ~BPF_F_LOCK)
+		return -EINVAL;
+
+	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
+	    !map_value_has_spin_lock(map)) {
+		err = -EINVAL;
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
+	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
+	if (!value)
+		goto err_put;
+
+	for (cp = 0; cp < max_count; cp++) {
+		key = __bpf_copy_key(keys + cp * map->key_size, map->key_size);
+		if (IS_ERR(key)) {
+			err = PTR_ERR(key);
+			break;
+		}
+		err = -EFAULT;
+		if (copy_from_user(value, values + cp * value_size, value_size))
+			break;
+
+		err = bpf_map_update_value(map, f, key, value,
+					   attr->batch.elem_flags);
+
+		if (err)
+			break;
+	}
+
+	if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
+		err = -EFAULT;
+
+	kfree(value);
+err_put:
+	return err;
+}
+
 static int __generic_map_lookup_batch(struct bpf_map *map,
 				      const union bpf_attr *attr,
 				      union bpf_attr __user *uattr,
@@ -3117,8 +3231,12 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 
 	if (cmd == BPF_MAP_LOOKUP_BATCH)
 		BPF_DO_BATCH(map->ops->map_lookup_batch);
-	else
+	else if (cmd == BPF_MAP_LOOKUP_AND_DELETE_BATCH)
 		BPF_DO_BATCH(map->ops->map_lookup_and_delete_batch);
+	else if (cmd == BPF_MAP_UPDATE_BATCH)
+		BPF_DO_BATCH(map->ops->map_update_batch);
+	else
+		BPF_DO_BATCH(map->ops->map_delete_batch);
 
 err_put:
 	fdput(f);
@@ -3229,6 +3347,12 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 		err = bpf_map_do_batch(&attr, uattr,
 				       BPF_MAP_LOOKUP_AND_DELETE_BATCH);
 		break;
+	case BPF_MAP_UPDATE_BATCH:
+		err = bpf_map_do_batch(&attr, uattr, BPF_MAP_UPDATE_BATCH);
+		break;
+	case BPF_MAP_DELETE_BATCH:
+		err = bpf_map_do_batch(&attr, uattr, BPF_MAP_DELETE_BATCH);
+		break;
 	default:
 		err = -EINVAL;
 		break;
-- 
2.24.0.432.g9d3f5f5b63-goog

