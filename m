Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 338ABCC199
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2019 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbfJDRWr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Oct 2019 13:22:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388332AbfJDRWq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Oct 2019 13:22:46 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D69748830A
        for <bpf@vger.kernel.org>; Fri,  4 Oct 2019 17:22:45 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id d7so4448616edp.23
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2019 10:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gP06x0QSFrrNnRRU47vmLqHVN/Zuj7zV86CGBnpn+Bw=;
        b=BpOA1CXbUMrWaA4/+7ejzEPUByAzn11ovuJ/t2KhdjRE6s1o3lpiDfgzDHM6M/H7x/
         T6Xj1p6wus6RhJGvMV8D5bQ1cu8wNIpNJw3rLxBCkVv3jFXQBtUaBb0YOS2YfiwKlzFz
         vrNaiSXmxo9UP+RAuVjtYagxTtub2OG8pt+R4FAiZjVn4RnObafT5ouMQq5EjXwC/KpX
         lX1AE14cRVZALVI2tD7GtKKcZ1Ay9c6oPMJzyvl+zaifyLGF7wvPdvb6CiC/u1U6ksCd
         4R/+/Us6/887nvhtZYABgapAtT3jjZwzOutc3d411TAgoLbCxiUrBR+k9Hsy82TSLBBi
         G9kA==
X-Gm-Message-State: APjAAAUJOaTg8jKim5LUTej4mogWZwUNxan5/xmL/8Nmi+7xRQ/aGs3H
        AMlbEEoUgN9KPj5yfiMJ1bE7KN80ssglqBbkUPYVws8vlBAoU5IiAti23u/+FRWvKOci/UhuYbi
        qLXIxoPVRQhAJ
X-Received: by 2002:a17:906:b283:: with SMTP id q3mr13548864ejz.7.1570209764465;
        Fri, 04 Oct 2019 10:22:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx6zMCuXEY0Mn9xovZAab7UKRgSaTHlFSXpMsNxLFE/dfda7X+VdG3WGlt8dA/52mZcrBPobg==
X-Received: by 2002:a17:906:b283:: with SMTP id q3mr13548837ejz.7.1570209764184;
        Fri, 04 Oct 2019 10:22:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id y14sm665879ejb.20.2019.10.04.10.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 10:22:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A429118063D; Fri,  4 Oct 2019 19:22:42 +0200 (CEST)
Subject: [PATCH bpf-next v2 2/5] bpf: Add support for setting chain call
 sequence for programs
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 04 Oct 2019 19:22:42 +0200
Message-ID: <157020976257.1824887.7683650534515359703.stgit@alrua-x1>
In-Reply-To: <157020976030.1824887.7191033447861395957.stgit@alrua-x1>
References: <157020976030.1824887.7191033447861395957.stgit@alrua-x1>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alan Maguire <alan.maguire@oracle.com>

This adds support for setting and deleting bpf chain call programs through
a couple of new commands in the bpf() syscall. The CHAIN_ADD and CHAIN_DEL
commands take two eBPF program fds and a return code, and install the
'next' program to be chain called after the 'prev' program if that program
returns 'retcode'. A retcode of -1 means "wildcard", so that the program
will be executed regardless of the previous program's return code.


The syscall command names are based on Alexei's prog_chain example[0],
which Alan helpfully rebased on current bpf-next. However, the logic and
program storage is obviously adapted to the execution logic in the previous
commit.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=prog_chain&id=f54f45d00f91e083f6aec2abe35b6f0be52ae85b&context=15

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/uapi/linux/bpf.h |   10 ++++++
 kernel/bpf/syscall.c     |   78 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index febe8934d19a..b5dbc49fa1a3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -107,6 +107,9 @@ enum bpf_cmd {
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
 	BPF_BTF_GET_NEXT_ID,
+	BPF_PROG_CHAIN_ADD,
+	BPF_PROG_CHAIN_DEL,
+	BPF_PROG_CHAIN_GET,
 };
 
 enum bpf_map_type {
@@ -516,6 +519,13 @@ union bpf_attr {
 		__u64		probe_offset;	/* output: probe_offset */
 		__u64		probe_addr;	/* output: probe_addr */
 	} task_fd_query;
+
+	struct { /* anonymous struct used by BPF_PROG_CHAIN_* commands */
+		__u32		prev_prog_fd;
+		__u32		next_prog_fd;
+		__u32		retcode;
+		__u32		next_prog_id;   /* output: prog_id */
+	};
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c2a49df5f921..054b1f7c83f8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2112,6 +2112,79 @@ static int bpf_prog_test_run(const union bpf_attr *attr,
 	return ret;
 }
 
+#define BPF_PROG_CHAIN_LAST_FIELD next_prog_id
+
+static int bpf_prog_chain(int cmd, const union bpf_attr *attr,
+			  union bpf_attr __user *uattr)
+{
+	struct bpf_prog *prog, *next_prog, *old_prog;
+	struct bpf_array *array;
+	int ret = -EOPNOTSUPP;
+	u32 index, prog_id;
+
+	if (CHECK_ATTR(BPF_PROG_CHAIN))
+		return -EINVAL;
+
+	/* Index 0 is wildcard, encoded as ~0 by userspace */
+	if (attr->retcode == ((u32) ~0))
+		index = 0;
+	else
+		index = attr->retcode + 1;
+
+	if (index >= BPF_NUM_CHAIN_SLOTS)
+		return -E2BIG;
+
+	prog = bpf_prog_get(attr->prev_prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	/* If no chain_progs array is set, that's because the chain call flag
+	 * was not set on program load, and so we can't support chain calls.
+	 */
+	if (!prog->aux->chain_progs)
+		goto out;
+
+	array = prog->aux->chain_progs;
+
+	switch (cmd) {
+	case BPF_PROG_CHAIN_ADD:
+		next_prog = bpf_prog_get(attr->next_prog_fd);
+		if (IS_ERR(next_prog)) {
+			ret = PTR_ERR(next_prog);
+			break;
+		}
+		old_prog = xchg(array->ptrs + index, next_prog);
+		if (old_prog)
+			bpf_prog_put(old_prog);
+		ret = 0;
+		break;
+	case BPF_PROG_CHAIN_DEL:
+		old_prog = xchg(array->ptrs + index, NULL);
+		if (old_prog) {
+			bpf_prog_put(old_prog);
+			ret = 0;
+		} else {
+			ret = -ENOENT;
+		}
+		break;
+	case BPF_PROG_CHAIN_GET:
+		old_prog = READ_ONCE(*(array->ptrs + index));
+		if (old_prog) {
+			prog_id = old_prog->aux->id;
+			if (put_user(prog_id, &uattr->next_prog_id))
+				ret = -EFAULT;
+			else
+				ret = 0;
+		} else
+			ret = -ENOENT;
+		break;
+	}
+
+out:
+	bpf_prog_put(prog);
+	return ret;
+}
+
 #define BPF_OBJ_GET_NEXT_ID_LAST_FIELD next_id
 
 static int bpf_obj_get_next_id(const union bpf_attr *attr,
@@ -2884,6 +2957,11 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	case BPF_PROG_TEST_RUN:
 		err = bpf_prog_test_run(&attr, uattr);
 		break;
+	case BPF_PROG_CHAIN_ADD:
+	case BPF_PROG_CHAIN_DEL:
+	case BPF_PROG_CHAIN_GET:
+		err = bpf_prog_chain(cmd, &attr, uattr);
+		break;
 	case BPF_PROG_GET_NEXT_ID:
 		err = bpf_obj_get_next_id(&attr, uattr,
 					  &prog_idr, &prog_idr_lock);

