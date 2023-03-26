Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7666C937A
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjCZJXF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjCZJWn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:43 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F63B9775;
        Sun, 26 Mar 2023 02:22:27 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r5so5877097qtp.4;
        Sun, 26 Mar 2023 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciAal/rEXFScF3qvMlCUWJgominifo4LMMWsWoEwMYs=;
        b=Gyf1IL9gVS0wtpFR0kRiBs7uCodqNZyxVG45yqVX+yuoIEpw2QOioq6tmmJ9YLIEgC
         oT52OXhprtvLBdVOOLWXTiwfQjjoX6sgH6ZbTBUPN12KpSDRYfxo2oJ+aplDSw4+E5dd
         4fGI/BWn0Y4SlNEHBWThgoKvxtJAfSs+JzoK4ajxz6jEwRIuff24dUmvRaa0TJUIXbFz
         KfEL9Q5CvF2FxK4IOBdUYAbxfg059gBprx/IpH7/WEknO7zP0FYZMf2M78hE40M9IVzw
         eCk0NQh2AHUTXyuosUbxtm6eAo3nm1zgEeRw9bWmeBVCNS1HufHtHyF1Iiwu2jbeIrzo
         MlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciAal/rEXFScF3qvMlCUWJgominifo4LMMWsWoEwMYs=;
        b=nuioiVUL1dF4q/dev8TJgiO9PHO06YM34REYP45Lps75cPjYTD0htOauYEMdLEpRDh
         v3o/qxSrJBU3w0x+eDa4blr+1DJFa4xEd24XycAVp40juXgBrIx9nq6Rwd88JsSqQrCg
         mTEa1FcN5DMwF74SlWGT1bxVn7+ifo7wJfKiKwYv42+g1pi6pN7N1WLHYlMMmz+AbOGB
         ot6Whf1nu7skPLyXvXQXmmbsw9Dh91GibYXRyg9pVy+/FooK8cbAphsAJUTPKd5wXPEY
         IMAIDNvS4EHEbL6VsXwZ9lcMEiTCzrI2w4bTKULPIJHsZE996vr/gt3fvymHW07aoYcM
         V4+g==
X-Gm-Message-State: AO0yUKVk8yS6mJBaM2dYbGpc4FfkRKFcJD8PCQ9CpeH6tvLNlTepi7nl
        3bXuWAdNxAw6VFc1iP3Sy9g2/3znClrEi0MNX/8=
X-Google-Smtp-Source: AK7set/Tu1m404G1UMWbUZYLpO7ogYjIDGBCA6cAP+5qHVmqVs/C5xcahi1CKlAOun6clKaIJLQLKw==
X-Received: by 2002:a05:622a:1748:b0:3ba:2203:6c92 with SMTP id l8-20020a05622a174800b003ba22036c92mr15755300qtk.10.1679822546087;
        Sun, 26 Mar 2023 02:22:26 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:25 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 10/13] bpf: Alloc and free bpf_link id in bpf namespace
Date:   Sun, 26 Mar 2023 09:22:05 +0000
Message-Id: <20230326092208.13613-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230326092208.13613-1-laoar.shao@gmail.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to bpf map, We only expose the bpf link id under current bpf
namespace to user. The link->id is still the id in the init bpf
namespace.

The result as follows,

Run bpftool in a new bpf namespace,
$ bpftool map show
4: array  name kprobe_b.rodata  flags 0x80
        key 4B  value 37B  max_entries 1  memlock 360B
        btf_id 79  frozen
        pids kprobe(8322)
5: array  name kprobe_b.data  flags 0x400
        key 4B  value 4B  max_entries 1  memlock 8192B
        btf_id 79
        pids kprobe(8322)

$ bpftool prog show
7: kprobe  name kretprobe_run  tag 0de47cc241a2b1b3  gpl
        loaded_at 2023-03-21T13:54:34+0800  uid 0
        xlated 56B  jited 39B  memlock 4096B  map_ids 4
        btf_id 79
        pids kprobe(8322)
9: kprobe  name kprobe_run  tag bf163b23cd3b174d  gpl
        loaded_at 2023-03-21T13:54:34+0800  uid 0
        xlated 48B  jited 35B  memlock 4096B  map_ids 4
        btf_id 79
        pids kprobe(8322)

$ bpftool link show
1: perf_event  prog 9
        bpf_cookie 0
        pids kprobe(8322)
2: perf_event  prog 7
        bpf_cookie 0
        pids kprobe(8322)

At the same time, run bpftool in the init bpf namespace,
$ bpftool map show
8: array  name kprobe_b.rodata  flags 0x80
        key 4B  value 37B  max_entries 1  memlock 360B
        btf_id 79  frozen
        pids kprobe(8322)
9: array  name kprobe_b.data  flags 0x400
        key 4B  value 4B  max_entries 1  memlock 8192B
        btf_id 79
        pids kprobe(8322)

$ bpftool prog show
15: kprobe  name kretprobe_run  tag 0de47cc241a2b1b3  gpl
        loaded_at 2023-03-21T13:54:34+0800  uid 0
        xlated 56B  jited 39B  memlock 4096B  map_ids 8
        btf_id 79
        pids kprobe(8322)
17: kprobe  name kprobe_run  tag bf163b23cd3b174d  gpl
        loaded_at 2023-03-21T13:54:34+0800  uid 0
        xlated 48B  jited 35B  memlock 4096B  map_ids 8
        btf_id 79
        pids kprobe(8322)

$ bpftool link show
2: perf_event  prog 17
        bpf_cookie 0
        pids kprobe(8322)
3: perf_event  prog 15
        bpf_cookie 0
        pids kprobe(8322)

The bpftool running in the init bpf namespace can also show other bpf
links, but the bpftool in the new bpf namespace can only show the links
in its current bpf namespace.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h                       |  2 ++
 kernel/bpf/bpf_namespace.c                |  1 +
 kernel/bpf/syscall.c                      | 55 +++++++++++--------------------
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c |  3 +-
 4 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 16f2a01..efa14ac 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1468,6 +1468,7 @@ struct bpf_link {
 	const struct bpf_link_ops *ops;
 	struct bpf_prog *prog;
 	struct work_struct work;
+	struct bpf_obj_id *obj_id;
 };
 
 struct bpf_link_ops {
@@ -1506,6 +1507,7 @@ struct bpf_link_primer {
 	struct file *file;
 	int fd;
 	u32 id;
+	struct bpf_obj_id *obj_id;
 };
 
 struct bpf_struct_ops_value;
diff --git a/kernel/bpf/bpf_namespace.c b/kernel/bpf/bpf_namespace.c
index 8c70945..c7d62ef 100644
--- a/kernel/bpf/bpf_namespace.c
+++ b/kernel/bpf/bpf_namespace.c
@@ -13,6 +13,7 @@
 #define MAX_BPF_NS_LEVEL 32
 DEFINE_SPINLOCK(map_idr_lock);
 DEFINE_SPINLOCK(prog_idr_lock);
+DEFINE_SPINLOCK(link_idr_lock);
 static struct kmem_cache *bpfns_cachep;
 static struct kmem_cache *obj_id_cache[MAX_PID_NS_LEVEL];
 static struct ns_common *bpfns_get(struct task_struct *task);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4725924..855d5f7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -48,8 +48,6 @@
 #define BPF_OBJ_FLAG_MASK   (BPF_F_RDONLY | BPF_F_WRONLY)
 
 DEFINE_PER_CPU(int, bpf_prog_active);
-static DEFINE_IDR(link_idr);
-DEFINE_SPINLOCK(link_idr_lock);
 
 int sysctl_unprivileged_bpf_disabled __read_mostly =
 	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
@@ -2670,17 +2668,11 @@ void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
 	atomic64_set(&link->refcnt, 1);
 	link->type = type;
 	link->id = 0;
+	link->obj_id = NULL;
 	link->ops = ops;
 	link->prog = prog;
 }
 
-static void bpf_link_free_id(int id)
-{
-	spin_lock_bh(&link_idr_lock);
-	idr_remove(&link_idr, id);
-	spin_unlock_bh(&link_idr_lock);
-}
-
 /* Clean up bpf_link and corresponding anon_inode file and FD. After
  * anon_inode is created, bpf_link can't be just kfree()'d due to deferred
  * anon_inode's release() call. This helper marksbpf_link as
@@ -2692,7 +2684,7 @@ void bpf_link_cleanup(struct bpf_link_primer *primer)
 {
 	primer->link->prog = NULL;
 	if (primer->id) {
-		bpf_link_free_id(primer->id);
+		bpf_free_obj_id(primer->obj_id, LINK_OBJ_ID);
 		primer->id = 0;
 	}
 	fput(primer->file);
@@ -2708,7 +2700,7 @@ void bpf_link_inc(struct bpf_link *link)
 static void bpf_link_free(struct bpf_link *link)
 {
 	if (link->id) {
-		bpf_link_free_id(link->id);
+		bpf_free_obj_id(link->obj_id, LINK_OBJ_ID);
 		link->id = 0;
 	}
 	if (link->prog) {
@@ -2774,7 +2766,7 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 		   "link_type:\t%s\n"
 		   "link_id:\t%u\n",
 		   bpf_link_type_strs[link->type],
-		   link->id);
+		   bpf_obj_id_vnr(link->obj_id));
 	if (prog) {
 		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
 		seq_printf(m,
@@ -2797,19 +2789,6 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 	.write		= bpf_dummy_write,
 };
 
-static int bpf_link_alloc_id(struct bpf_link *link)
-{
-	int id;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock_bh(&link_idr_lock);
-	id = idr_alloc_cyclic(&link_idr, link, 1, INT_MAX, GFP_ATOMIC);
-	spin_unlock_bh(&link_idr_lock);
-	idr_preload_end();
-
-	return id;
-}
-
 /* Prepare bpf_link to be exposed to user-space by allocating anon_inode file,
  * reserving unused FD and allocating ID from link_idr. This is to be paired
  * with bpf_link_settle() to install FD and ID and expose bpf_link to
@@ -2825,23 +2804,23 @@ static int bpf_link_alloc_id(struct bpf_link *link)
  */
 int bpf_link_prime(struct bpf_link *link, struct bpf_link_primer *primer)
 {
+	struct bpf_obj_id *obj_id;
 	struct file *file;
-	int fd, id;
+	int fd;
 
 	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0)
 		return fd;
 
-
-	id = bpf_link_alloc_id(link);
-	if (id < 0) {
+	obj_id = bpf_alloc_obj_id(current->nsproxy->bpf_ns, link, LINK_OBJ_ID);
+	if (IS_ERR(obj_id)) {
 		put_unused_fd(fd);
-		return id;
+		return PTR_ERR(obj_id);
 	}
 
 	file = anon_inode_getfile("bpf_link", &bpf_link_fops, link, O_CLOEXEC);
 	if (IS_ERR(file)) {
-		bpf_link_free_id(id);
+		bpf_free_obj_id(obj_id, LINK_OBJ_ID);
 		put_unused_fd(fd);
 		return PTR_ERR(file);
 	}
@@ -2849,7 +2828,8 @@ int bpf_link_prime(struct bpf_link *link, struct bpf_link_primer *primer)
 	primer->link = link;
 	primer->file = file;
 	primer->fd = fd;
-	primer->id = id;
+	primer->id = bpf_obj_id_nr(obj_id);
+	primer->obj_id = obj_id;
 	return 0;
 }
 
@@ -2858,6 +2838,7 @@ int bpf_link_settle(struct bpf_link_primer *primer)
 	/* make bpf_link fetchable by ID */
 	spin_lock_bh(&link_idr_lock);
 	primer->link->id = primer->id;
+	primer->link->obj_id = primer->obj_id;
 	spin_unlock_bh(&link_idr_lock);
 	/* make bpf_link fetchable by FD */
 	fd_install(primer->fd, primer->file);
@@ -4265,7 +4246,7 @@ static int bpf_link_get_info_by_fd(struct file *file,
 		return -EFAULT;
 
 	info.type = link->type;
-	info.id = link->id;
+	info.id = bpf_obj_id_vnr(link->obj_id);
 	if (link->prog)
 		info.prog_id = bpf_obj_id_vnr(link->prog->aux->obj_id);
 
@@ -4748,6 +4729,7 @@ static struct bpf_link *bpf_link_inc_not_zero(struct bpf_link *link)
 
 struct bpf_link *bpf_link_by_id(u32 id)
 {
+	struct bpf_namespace *ns = current->nsproxy->bpf_ns;
 	struct bpf_link *link;
 
 	if (!id)
@@ -4755,7 +4737,7 @@ struct bpf_link *bpf_link_by_id(u32 id)
 
 	spin_lock_bh(&link_idr_lock);
 	/* before link is "settled", ID is 0, pretend it doesn't exist yet */
-	link = idr_find(&link_idr, id);
+	link = idr_find(&ns->idr[LINK_OBJ_ID], id);
 	if (link) {
 		if (link->id)
 			link = bpf_link_inc_not_zero(link);
@@ -4770,11 +4752,12 @@ struct bpf_link *bpf_link_by_id(u32 id)
 
 struct bpf_link *bpf_link_get_curr_or_next(u32 *id)
 {
+	struct bpf_namespace *ns = current->nsproxy->bpf_ns;
 	struct bpf_link *link;
 
 	spin_lock_bh(&link_idr_lock);
 again:
-	link = idr_get_next(&link_idr, id);
+	link = idr_get_next(&ns->idr[LINK_OBJ_ID], id);
 	if (link) {
 		link = bpf_link_inc_not_zero(link);
 		if (IS_ERR(link)) {
@@ -5086,7 +5069,7 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 		break;
 	case BPF_LINK_GET_NEXT_ID:
 		err = bpf_obj_get_next_id(&attr, uattr.user,
-					  &link_idr, &link_idr_lock);
+					  &ns->idr[LINK_OBJ_ID], &link_idr_lock);
 		break;
 	case BPF_ENABLE_STATS:
 		err = bpf_enable_stats(&attr);
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index 1fd8ceb..e2237ad 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -36,7 +36,8 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
 	case BPF_OBJ_BTF:
 		return BPF_CORE_READ((struct btf *)ent, id);
 	case BPF_OBJ_LINK:
-		return BPF_CORE_READ((struct bpf_link *)ent, id);
+		obj_id = BPF_CORE_READ((struct bpf_link *)ent, obj_id);
+		break;
 	default:
 		return 0;
 	}
-- 
1.8.3.1

