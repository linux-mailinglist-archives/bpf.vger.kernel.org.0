Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C36DCEA78
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2019 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfJGRUn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Oct 2019 13:20:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728691AbfJGRUm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Oct 2019 13:20:42 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43E6B970F1
        for <bpf@vger.kernel.org>; Mon,  7 Oct 2019 17:20:41 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id b90so3723874ljf.11
        for <bpf@vger.kernel.org>; Mon, 07 Oct 2019 10:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xRZBxB2lU16qLMfYcnzu6mRveyIlNiA+kH4ptEPYjRU=;
        b=NvURMlRgMJ9H9OjTKLj9zjNoaUpvAUsblSNsj+vHA15F3emWut2DTQU6MaVNORJ2pu
         5kFQBhwzAhRGI2kvBFrzd3f9Bg+uzu/WLVtsjsGq3cX7zasXjTOtOhWqH5A8Gj/zYk8+
         NeqbNKqo3NU72BFb1a0v/opuZSuwQNpg8/Tg0JbG97VGt/8tB7eWsFHak7liAmNr5miR
         VJuJkgUb24KtLEbXCo2Fwmtt3ogLiy2i/RejJHqGu+BRoOE+9bTWM6lSdkQ+02Qs+pUL
         LA7LMqP//xTHeUxQNKhG9f563Nkc5a343DU+e8tVWApaQXZN9IkuToPJ1epCT/DWkj5R
         WDAA==
X-Gm-Message-State: APjAAAUcKvbhcOH1IepHCtPmR5Z1CMreoWiXnYWv/Pc/li4HXgSpaPbf
        xH2soSuiUOlm57AytOgWPiEWMPxlqI/K5VS5kHah8ycwsyGRZykyIODzTXdDi70CIKn7IBlcWys
        dTIHXMgRnTiq/
X-Received: by 2002:a2e:1415:: with SMTP id u21mr18774255ljd.22.1570468839732;
        Mon, 07 Oct 2019 10:20:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwr6g7QS8I0pkHEY7lk/WHcHWs1pXGebMx67Xru1e9ilNXMxSFB2RqoX31M174XLHInZAG8Hw==
X-Received: by 2002:a2e:1415:: with SMTP id u21mr18774245ljd.22.1570468839508;
        Mon, 07 Oct 2019 10:20:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id r75sm2827371lff.7.2019.10.07.10.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 10:20:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4E19B18063D; Mon,  7 Oct 2019 19:20:37 +0200 (CEST)
Subject: [PATCH bpf-next v3 2/5] bpf: Add support for setting chain call
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
Date:   Mon, 07 Oct 2019 19:20:37 +0200
Message-ID: <157046883723.2092443.3902769602513209987.stgit@alrua-x1>
In-Reply-To: <157046883502.2092443.146052429591277809.stgit@alrua-x1>
References: <157046883502.2092443.146052429591277809.stgit@alrua-x1>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

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
index 1ce80a227be3..b03c23963af8 100644
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
index b8a203a05881..be8112e08a88 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2113,6 +2113,79 @@ static int bpf_prog_test_run(const union bpf_attr *attr,
 	return ret;
 }
 
+#define BPF_PROG_CHAIN_LAST_FIELD next_prog_id
+
+static int bpf_prog_chain(int cmd, const union bpf_attr *attr,
+			  union bpf_attr __user *uattr)
+{
+	struct bpf_prog *prog, *next_prog, *old_prog;
+	struct bpf_prog **array;
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
+	/* If the chain_calls bit is not set, that's because the chain call flag
+	 * was not set on program load, and so we can't support chain calls.
+	 */
+	if (!prog->chain_calls)
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
+		old_prog = xchg(array + index, next_prog);
+		if (old_prog)
+			bpf_prog_put(old_prog);
+		ret = 0;
+		break;
+	case BPF_PROG_CHAIN_DEL:
+		old_prog = xchg(array + index, NULL);
+		if (old_prog) {
+			bpf_prog_put(old_prog);
+			ret = 0;
+		} else {
+			ret = -ENOENT;
+		}
+		break;
+	case BPF_PROG_CHAIN_GET:
+		old_prog = READ_ONCE(array[index]);
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
@@ -2885,6 +2958,11 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
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

