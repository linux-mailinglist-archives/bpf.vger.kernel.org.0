Return-Path: <bpf+bounces-16706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F1F8049B4
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 07:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5806FB20BF4
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 06:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E51D529;
	Tue,  5 Dec 2023 06:05:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA0C3
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 22:05:04 -0800 (PST)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 4C44A2AFE0A95; Mon,  4 Dec 2023 22:04:50 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 1/2] bpf: Fix a race condition between btf_put() and map_free()
Date: Mon,  4 Dec 2023 22:04:50 -0800
Message-Id: <20231205060450.3577161-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When running `./test_progs -j` in my local vm with latest kernel,
I once hit a kasan error like below:

  [ 1887.184724] BUG: KASAN: slab-use-after-free in bpf_rb_root_free+0x1f=
8/0x2b0
  [ 1887.185599] Read of size 4 at addr ffff888106806910 by task kworker/=
u12:2/2830
  [ 1887.186498]
  [ 1887.186712] CPU: 3 PID: 2830 Comm: kworker/u12:2 Tainted: G         =
  OEL     6.7.0-rc3-00699-g90679706d486-dirty #494
  [ 1887.188034] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
  [ 1887.189618] Workqueue: events_unbound bpf_map_free_deferred
  [ 1887.190341] Call Trace:
  [ 1887.190666]  <TASK>
  [ 1887.190949]  dump_stack_lvl+0xac/0xe0
  [ 1887.191423]  ? nf_tcp_handle_invalid+0x1b0/0x1b0
  [ 1887.192019]  ? panic+0x3c0/0x3c0
  [ 1887.192449]  print_report+0x14f/0x720
  [ 1887.192930]  ? preempt_count_sub+0x1c/0xd0
  [ 1887.193459]  ? __virt_addr_valid+0xac/0x120
  [ 1887.194004]  ? bpf_rb_root_free+0x1f8/0x2b0
  [ 1887.194572]  kasan_report+0xc3/0x100
  [ 1887.195085]  ? bpf_rb_root_free+0x1f8/0x2b0
  [ 1887.195668]  bpf_rb_root_free+0x1f8/0x2b0
  [ 1887.196183]  ? __bpf_obj_drop_impl+0xb0/0xb0
  [ 1887.196736]  ? preempt_count_sub+0x1c/0xd0
  [ 1887.197270]  ? preempt_count_sub+0x1c/0xd0
  [ 1887.197802]  ? _raw_spin_unlock+0x1f/0x40
  [ 1887.198319]  bpf_obj_free_fields+0x1d4/0x260
  [ 1887.198883]  array_map_free+0x1a3/0x260
  [ 1887.199380]  bpf_map_free_deferred+0x7b/0xe0
  [ 1887.199943]  process_scheduled_works+0x3a2/0x6c0
  [ 1887.200549]  worker_thread+0x633/0x890
  [ 1887.201047]  ? __kthread_parkme+0xd7/0xf0
  [ 1887.201574]  ? kthread+0x102/0x1d0
  [ 1887.202020]  kthread+0x1ab/0x1d0
  [ 1887.202447]  ? pr_cont_work+0x270/0x270
  [ 1887.202954]  ? kthread_blkcg+0x50/0x50
  [ 1887.203444]  ret_from_fork+0x34/0x50
  [ 1887.203914]  ? kthread_blkcg+0x50/0x50
  [ 1887.204397]  ret_from_fork_asm+0x11/0x20
  [ 1887.204913]  </TASK>
  [ 1887.204913]  </TASK>
  [ 1887.205209]
  [ 1887.205416] Allocated by task 2197:
  [ 1887.205881]  kasan_set_track+0x3f/0x60
  [ 1887.206366]  __kasan_kmalloc+0x6e/0x80
  [ 1887.206856]  __kmalloc+0xac/0x1a0
  [ 1887.207293]  btf_parse_fields+0xa15/0x1480
  [ 1887.207836]  btf_parse_struct_metas+0x566/0x670
  [ 1887.208387]  btf_new_fd+0x294/0x4d0
  [ 1887.208851]  __sys_bpf+0x4ba/0x600
  [ 1887.209292]  __x64_sys_bpf+0x41/0x50
  [ 1887.209762]  do_syscall_64+0x4c/0xf0
  [ 1887.210222]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
  [ 1887.210868]
  [ 1887.211074] Freed by task 36:
  [ 1887.211460]  kasan_set_track+0x3f/0x60
  [ 1887.211951]  kasan_save_free_info+0x28/0x40
  [ 1887.212485]  ____kasan_slab_free+0x101/0x180
  [ 1887.213027]  __kmem_cache_free+0xe4/0x210
  [ 1887.213514]  btf_free+0x5b/0x130
  [ 1887.213918]  rcu_core+0x638/0xcc0
  [ 1887.214347]  __do_softirq+0x114/0x37e

The error happens at bpf_rb_root_free+0x1f8/0x2b0:

  00000000000034c0 <bpf_rb_root_free>:
  ; {
    34c0: f3 0f 1e fa                   endbr64
    34c4: e8 00 00 00 00                callq   0x34c9 <bpf_rb_root_free+=
0x9>
    34c9: 55                            pushq   %rbp
    34ca: 48 89 e5                      movq    %rsp, %rbp
  ...
  ;       if (rec && rec->refcount_off >=3D 0 &&
    36aa: 4d 85 ed                      testq   %r13, %r13
    36ad: 74 a9                         je      0x3658 <bpf_rb_root_free+=
0x198>
    36af: 49 8d 7d 10                   leaq    0x10(%r13), %rdi
    36b3: e8 00 00 00 00                callq   0x36b8 <bpf_rb_root_free+=
0x1f8>
                                        <=3D=3D=3D=3D kasan function
    36b8: 45 8b 7d 10                   movl    0x10(%r13), %r15d
                                        <=3D=3D=3D=3D use-after-free load
    36bc: 45 85 ff                      testl   %r15d, %r15d
    36bf: 78 8c                         js      0x364d <bpf_rb_root_free+=
0x18d>

So the problem is at rec->refcount_off in the above.

I did some source code analysis and find the reason.
                                  CPU A                        CPU B
  bpf_map_put:
    ...
    btf_put with rcu callback
    ...
    bpf_map_free_deferred
      with system_unbound_wq
    ...                          ...                           ...
    ...                          btf_free_rcu:                 ...
    ...                          ...                           bpf_map_fr=
ee_deferred:
    ...                          ...
    ...         --------->       btf_struct_metas_free()
    ...         | race condition ...
    ...         --------->                                     map->ops->=
map_free()
    ...
    ...                          btf->struct_meta_tab =3D NULL

In the above, map_free() corresponds to array_map_free() and eventually
calling bpf_rb_root_free() which calls:
  ...
  __bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
  ...

Here, 'value_rec' is assigned in btf_check_and_fixup_fields() with follow=
ing code:

  meta =3D btf_find_struct_meta(btf, btf_id);
  if (!meta)
    return -EFAULT;
  rec->fields[i].graph_root.value_rec =3D meta->record;

So basically, 'value_rec' is a pointer to the record in struct_metas_tab.
And it is possible that that particular record has been freed by
btf_struct_metas_free() and hence we have a kasan error here.

Actually it is very hard to reproduce the failure with current bpf/bpf-ne=
xt
code, I only got the above error once. To increase reproducibility, I add=
ed
a delay in bpf_map_free_deferred() to delay map->ops->map_free(), which
significantly increased reproducibility.

  diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
  index 5e43ddd1b83f..aae5b5213e93 100644
  --- a/kernel/bpf/syscall.c
  +++ b/kernel/bpf/syscall.c
  @@ -695,6 +695,7 @@ static void bpf_map_free_deferred(struct work_struc=
t *work)
        struct bpf_map *map =3D container_of(work, struct bpf_map, work);
        struct btf_record *rec =3D map->record;

  +     mdelay(100);
        security_bpf_map_free(map);
        bpf_map_release_memcg(map);
        /* implementation dependent freeing */

To fix the problem, I moved btf_put() after btf_record_free() to ensure
struct_metas available during map_free(). Rerun './test_progs -j' with th=
e
above mdelay() hack for a couple of times and didn't observe the error.

Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/syscall.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ebaccf77d56e..1d40371bed24 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -694,6 +694,7 @@ static void bpf_map_free_deferred(struct work_struct =
*work)
 {
 	struct bpf_map *map =3D container_of(work, struct bpf_map, work);
 	struct btf_record *rec =3D map->record;
+	struct btf *btf =3D map->btf;
=20
 	security_bpf_map_free(map);
 	bpf_map_release_memcg(map);
@@ -709,6 +710,10 @@ static void bpf_map_free_deferred(struct work_struct=
 *work)
 	 * template bpf_map struct used during verification.
 	 */
 	btf_record_free(rec);
+	/* Delay freeing of btf for maps, as map_free callback may need
+	 * struct_meta info which will be freed with btf_put().
+	 */
+	btf_put(btf);
 }
=20
 static void bpf_map_put_uref(struct bpf_map *map)
@@ -749,7 +754,6 @@ void bpf_map_put(struct bpf_map *map)
 	if (atomic64_dec_and_test(&map->refcnt)) {
 		/* bpf_map_free_id() must be called first */
 		bpf_map_free_id(map);
-		btf_put(map->btf);
=20
 		WARN_ON_ONCE(atomic64_read(&map->sleepable_refcnt));
 		if (READ_ONCE(map->free_after_mult_rcu_gp))
--=20
2.34.1


