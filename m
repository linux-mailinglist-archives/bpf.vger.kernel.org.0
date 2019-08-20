Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFDE95B0B
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 11:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfHTJcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Aug 2019 05:32:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36131 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbfHTJcJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Aug 2019 05:32:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so11654157wrt.3
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2019 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tVc7VN7gTtziOvHeOIXMyOs+0s8pDlRsBn9s0CrWFO8=;
        b=x5fgC20/2BPZMlMDMx/IAGIVkVcHEud5rmvapbIons9qcdDgd04/bM/8u4iMFwYWmf
         xn4A2dO3hSTQxvfnNp4z50NGcbxg+k0PJ367RnwlvGUFWODC7cKMa1T+3rngHAnowilG
         KH9MF3wanwhNKwDh1nrks9dc6HlNpc50cF3NVI8D9u9kIh8yagDpBP7hEc+4aZyZH5Py
         +wYRIaOvg7RRr/LPowgsNNnifI6E4ndTdRf061gJmM7zIv0/mW0tdFFC2kxJQJBQTe9W
         FzbDlF3KloLDv/zRFyCCUzg5GNcKFuBLdGoyZ+91Goyd3IS/pIPSLpoLpJhGiyX4qyWv
         hqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tVc7VN7gTtziOvHeOIXMyOs+0s8pDlRsBn9s0CrWFO8=;
        b=hJGn76apyK55KkbMj7tWC+b4WLx6wmNhjsRkLlIcqct1vihm73GSwgmzvxisASf7Jd
         UnC2vU/rGskK28vAbjpNLwWWLrjdhrBJ/hxjmsW7E/yo8CaXkOKZxmDHoBeOJpfrNRzW
         DoigsUZPswkZfDbd8Y7/09AuTP0cGiOhGdN5zMsnDJ9PXZAG8m4klOBFdX2MNG4xu+g6
         8tFbZXlX5DQscFF4xYgnF9kIsAkaF4ILHobA1mrhGwtpzAJgyNzQ2WmQ1JKygEXhF84/
         K42XWINNSUMO5cB+yXmJ5D/Ti9fyMT8oscI7Gvwp8uf5tEnc+kis+S++lnU9Uq3dNihM
         eHMw==
X-Gm-Message-State: APjAAAXH+7dFJ2NmDJ4v057qzWO5xWz7OmoChjtEvo18ftjWaknMF4YH
        1l7IY1K62MkgamliZgn0CUIJS5O365U=
X-Google-Smtp-Source: APXvYqyEgLmJgKDJTvMxC14PXf2yH46koODDnGABAg/9L0Lc2BBvPvs2wOQMct0hVXviOGlEH+kgLA==
X-Received: by 2002:a5d:4ec6:: with SMTP id s6mr6476613wrv.327.1566293527206;
        Tue, 20 Aug 2019 02:32:07 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id p9sm16128190wru.61.2019.08.20.02.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:32:06 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next v2 1/5] bpf: add new BPF_BTF_GET_NEXT_ID syscall command
Date:   Tue, 20 Aug 2019 10:31:50 +0100
Message-Id: <20190820093154.14042-2-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820093154.14042-1-quentin.monnet@netronome.com>
References: <20190820093154.14042-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new command for the bpf() system call: BPF_BTF_GET_NEXT_ID is used
to cycle through all BTF objects loaded on the system.

The motivation is to be able to inspect (list) all BTF objects presents
on the system.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 include/linux/bpf.h      | 3 +++
 include/uapi/linux/bpf.h | 1 +
 kernel/bpf/btf.c         | 4 ++--
 kernel/bpf/syscall.c     | 4 ++++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 15ae49862b82..5b9d22338606 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -24,6 +24,9 @@ struct seq_file;
 struct btf;
 struct btf_type;
 
+extern struct idr btf_idr;
+extern spinlock_t btf_idr_lock;
+
 /* map is generic key/value storage optionally accesible by eBPF programs */
 struct bpf_map_ops {
 	/* funcs callable from userspace (via syscall) */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0ef594ac3899..8aa6126f0b6e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -106,6 +106,7 @@ enum bpf_cmd {
 	BPF_TASK_FD_QUERY,
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
+	BPF_BTF_GET_NEXT_ID,
 };
 
 enum bpf_map_type {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5fcc7a17eb5a..e716a64b2f7f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -195,8 +195,8 @@
 	     i < btf_type_vlen(struct_type);					\
 	     i++, member++)
 
-static DEFINE_IDR(btf_idr);
-static DEFINE_SPINLOCK(btf_idr_lock);
+DEFINE_IDR(btf_idr);
+DEFINE_SPINLOCK(btf_idr_lock);
 
 struct btf {
 	void *data;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cf8052b016e7..c0f62fd67c6b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2884,6 +2884,10 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 		err = bpf_obj_get_next_id(&attr, uattr,
 					  &map_idr, &map_idr_lock);
 		break;
+	case BPF_BTF_GET_NEXT_ID:
+		err = bpf_obj_get_next_id(&attr, uattr,
+					  &btf_idr, &btf_idr_lock);
+		break;
 	case BPF_PROG_GET_FD_BY_ID:
 		err = bpf_prog_get_fd_by_id(&attr);
 		break;
-- 
2.17.1

