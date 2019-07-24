Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753B27346A
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2019 18:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbfGXQ7A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jul 2019 12:59:00 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:47259 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbfGXQ6c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jul 2019 12:58:32 -0400
Received: by mail-pg1-f201.google.com with SMTP id l11so7303771pgc.14
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 09:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JhiTFKPdgUPiq/3CLngeqY1pwECv2NMtE4FVnY5brWc=;
        b=X9Uxl1pQtqKu/ZuT+YDSx8UQSm3E8s/yC/XufSX18tbohg9rSekknJLAe9xHgjbbx7
         D2FPWzlMHRyfhSABm7bsrH1CDV39nx5g/pZXfNSJDmv6KOKaV1ytCIuoTdonm84Xifu3
         UmGhHpNPjWrLeSkfYgEksG+xolx7KSzitNaroJzNkljJjObyTRTnJh7FP9h1W6X4cLQD
         6HNOMNCIQbMKTbsGenAS/UIDF2nr6dFP3BQumesprJGlCr7QRL4hHTOH/PLvi9b97IAE
         N22di3vtH1Es+HlUbMQnVhUY+utIpvPyX8xURkbBfAUs6OMTRGWhjEvDR0a2oXqSw+wx
         7hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JhiTFKPdgUPiq/3CLngeqY1pwECv2NMtE4FVnY5brWc=;
        b=KW3n6/9N2k6LiqSHwxr2Z/9hpvmQyAodHPMK+HzbkUS3Mkw3IN61lYeAghJyrm0Z3j
         ZcvRysI8JV9UJ9woa6c/RM6VH8b6dyTC/crlDK5JES46X3tzKw2j6IwjDLrQ0A5nHuXG
         vFIReaSDWVm0cT1rSbyakiqR+5tEQy2DFMQ9K5GuTAMfZaVB4OIcRwQMSfRoQ9VzriGt
         z/XqezdAkm5eiZcls4pUde2ASsmCGhzkgRRS9QdJzffk5eZ0cD1kiGKTCzAB65d1jq2e
         kMjjuSDUsSqvm424w/H69f9VFgDGePyECKcAJoOjo5DIKgvph3Y63o6lQ1odinXBgCkD
         cUWQ==
X-Gm-Message-State: APjAAAVjoXH0Y/IgmTZs8XtJWpdHFZhGwufLkW/NJVrcqzigturBmgXU
        NQwucfvOBsazmSWFP4BgSWCDG5tQ2wfp
X-Google-Smtp-Source: APXvYqw2VsB8QRHHZVMQ1VhvHU/nDMf5a8qvedfp46p5hb+FxJEbYpXEIh3n7OA6WwWDSR2D++aTvC0B3Fhm
X-Received: by 2002:a63:dd16:: with SMTP id t22mr50863450pgg.140.1563987511332;
 Wed, 24 Jul 2019 09:58:31 -0700 (PDT)
Date:   Wed, 24 Jul 2019 09:57:59 -0700
In-Reply-To: <20190724165803.87470-1-brianvv@google.com>
Message-Id: <20190724165803.87470-3-brianvv@google.com>
Mime-Version: 1.0
References: <20190724165803.87470-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH bpf-next 2/6] bpf: add BPF_MAP_DUMP command to dump more than
 one entry per call
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This introduces a new command to retrieve multiple number of entries
from a bpf map, wrapping the existing bpf methods:
map_get_next_key and map_lookup_elem

To start dumping the map from the beginning you must specify NULL as
the prev_key.

The new API returns 0 when it successfully copied all the elements
requested or it copied less because there weren't more elements to
retrieved (i.e err == -ENOENT). In last scenario err will be masked to 0.

On a successful call buf and buf_len will contain correct data and in
case prev_key was provided (not for the first walk, since prev_key is
NULL) it will contain the last_key copied into the prev_key which will
simplify next call.

Only when it can't find a single element it will return -ENOENT meaning
that the map has been entirely walked. When an error is return buf,
buf_len and prev_key shouldn't be read nor used.

Because maps can be called from userspace and kernel code, this function
can have a scenario where the next_key was found but by the time we
try to retrieve the value the element is not there, in this case the
function continues and tries to get a new next_key value, skipping the
deleted key. If at some point the function find itself trap in a loop,
it will return -EINTR.

The function will try to fit as much as possible in the buf provided and
will return -EINVAL if buf_len is smaller than elem_size.

QUEUE and STACK maps are not supported.

Note that map_dump doesn't guarantee that reading the entire table is
consistent since this function is always racing with kernel and user code
but the same behaviour is found when the entire table is walked using
the current interfaces: map_get_next_key + map_lookup_elem.
It is also important to note that with  a locked map, the lock is grabbed
for 1 entry at the time, meaning that the returned buf might or might not
be consistent.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 include/uapi/linux/bpf.h |   9 +++
 kernel/bpf/syscall.c     | 117 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fa1c753dcdbc7..66dab5385170d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -106,6 +106,7 @@ enum bpf_cmd {
 	BPF_TASK_FD_QUERY,
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
+	BPF_MAP_DUMP,
 };
 
 enum bpf_map_type {
@@ -388,6 +389,14 @@ union bpf_attr {
 		__u64		flags;
 	};
 
+	struct { /* struct used by BPF_MAP_DUMP command */
+		__aligned_u64	prev_key;
+		__aligned_u64	buf;
+		__aligned_u64	buf_len; /* input/output: len of buf */
+		__u64		flags;
+		__u32		map_fd;
+	} dump;
+
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
 		__u32		prog_type;	/* one of enum bpf_prog_type */
 		__u32		insn_cnt;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 86cdc2f7bb56e..0c35505aa219f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1097,6 +1097,120 @@ static int map_get_next_key(union bpf_attr *attr)
 	return err;
 }
 
+/* last field in 'union bpf_attr' used by this command */
+#define BPF_MAP_DUMP_LAST_FIELD dump.map_fd
+
+static int map_dump(union bpf_attr *attr)
+{
+	void __user *ukey = u64_to_user_ptr(attr->dump.prev_key);
+	void __user *ubuf = u64_to_user_ptr(attr->dump.buf);
+	u32 __user *ubuf_len = u64_to_user_ptr(attr->dump.buf_len);
+	int ufd = attr->dump.map_fd;
+	struct bpf_map *map;
+	void *buf, *prev_key, *key, *value;
+	u32 value_size, elem_size, buf_len, cp_len;
+	struct fd f;
+	int err;
+	bool first_key = false;
+
+	if (CHECK_ATTR(BPF_MAP_DUMP))
+		return -EINVAL;
+
+	if (attr->dump.flags & ~BPF_F_LOCK)
+		return -EINVAL;
+
+	f = fdget(ufd);
+	map = __bpf_map_get(f);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ)) {
+		err = -EPERM;
+		goto err_put;
+	}
+
+	if ((attr->dump.flags & BPF_F_LOCK) &&
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
+	err = get_user(buf_len, ubuf_len);
+	if (err)
+		goto err_put;
+
+	elem_size = map->key_size + value_size;
+	if (buf_len < elem_size) {
+		err = -EINVAL;
+		goto err_put;
+	}
+
+	if (ukey) {
+		prev_key = __bpf_copy_key(ukey, map->key_size);
+		if (IS_ERR(prev_key)) {
+			err = PTR_ERR(prev_key);
+			goto err_put;
+		}
+	} else {
+		prev_key = NULL;
+		first_key = true;
+	}
+
+	err = -ENOMEM;
+	buf = kmalloc(elem_size, GFP_USER | __GFP_NOWARN);
+	if (!buf)
+		goto err_put;
+
+	key = buf;
+	value = key + map->key_size;
+	for (cp_len = 0; cp_len + elem_size <= buf_len;) {
+		if (signal_pending(current)) {
+			err = -EINTR;
+			break;
+		}
+
+		rcu_read_lock();
+		err = map->ops->map_get_next_key(map, prev_key, key);
+		rcu_read_unlock();
+
+		if (err)
+			break;
+
+		err = bpf_map_copy_value(map, key, value, attr->dump.flags);
+
+		if (err == -ENOENT)
+			continue;
+		if (err)
+			goto free_buf;
+
+		if (copy_to_user(ubuf + cp_len, buf, elem_size)) {
+			err = -EFAULT;
+			goto free_buf;
+		}
+
+		prev_key = key;
+		cp_len += elem_size;
+	}
+
+	if (err == -ENOENT && cp_len)
+		err = 0;
+	if (!err && (copy_to_user(ubuf_len, &cp_len, sizeof(cp_len)) ||
+		    (!first_key && copy_to_user(ukey, key, map->key_size))))
+		err = -EFAULT;
+free_buf:
+	kfree(buf);
+err_put:
+	fdput(f);
+	return err;
+}
+
 #define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD value
 
 static int map_lookup_and_delete_elem(union bpf_attr *attr)
@@ -2910,6 +3024,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	case BPF_MAP_LOOKUP_AND_DELETE_ELEM:
 		err = map_lookup_and_delete_elem(&attr);
 		break;
+	case BPF_MAP_DUMP:
+		err = map_dump(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
-- 
2.22.0.657.g960e92d24f-goog

