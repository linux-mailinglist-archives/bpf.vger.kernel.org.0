Return-Path: <bpf+bounces-17104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AA2809AEC
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 05:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7856A1C20CFB
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 04:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F7F5234;
	Fri,  8 Dec 2023 04:16:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FB41723
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 20:16:35 -0800 (PST)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 59D532B27BA70; Thu,  7 Dec 2023 20:16:21 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>
Subject: [PATCH bpf-next v5] bpf: Fix a race condition between btf_put() and map_free()
Date: Thu,  7 Dec 2023 20:16:21 -0800
Message-Id: <20231208041621.2968241-1-yonghong.song@linux.dev>
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

To fix the problem, we need to have a reference on btf in order to
safeguard accessing field->graph_root.value_rec in map->ops->map_free().
The function btf_parse_graph_root() is the place to get a btf reference.
The following are rough call stacks reaching bpf_parse_graph_root():

   btf_parse
     ...
       btf_parse_fields
         ...
           btf_parse_graph_root

   map_check_btf
     btf_parse_fields
       ...
         btf_parse_graph_root

Looking at the above call stack, the btf_parse_graph_root() is indirectly
called from btf_parse() or map_check_btf().

We cannot take a reference in btf_parse() case since at that moment,
btf is still in the middle to self-validation and initial reference
(refcount_set(&btf->refcnt, 1)) has not been triggered yet.
But even if refcount_set() is moved earlier, taking reference
will have other issues at btf_put() stage.
  btf_put <=3D=3D to start destruction process unless refcount =3D=3D 0
    ...
    btf_record_free <=3D=3D in which if graph_root, a btf reference will =
be hold
                    <=3D=3D reference is taken during btf_parse()
In order to free the reference taken during btf_parse(), we need to
have refcount 0 in btf_put(), but this is impossible since we need to
free the reference taken during btf_parse() in order to get refcount 0
for btf_put(). So the end result is btf_put() will not be able to
free btf-related memories and we have memory leak here.
Luckily, there is no need to take a btf reference during btf_parse()
since eventually graph_root.value_rec will refer to the rec in btf
struct_meta_tab.

But we do need to take a reference for map_check_btf() case as
the value_rec refers to a record in struct_meta_tab and we want
to make sure btf is not freed until value_rec usage at map_free
is done.

So the fix is to get a btf reference for map_check_btf() case
whenever a graph_root is found. A boolean field 'has_btf_ref' is added to
struct btf_field_graph_root so later the btf reference can be properly
released.

Rerun './test_progs -j' with the above mdelay() hack for a couple
of times and didn't observe the error.
Running Hou's test ([1]) is also successful.

  [1] https://lore.kernel.org/bpf/20231206110625.3188975-1-houtao@huaweic=
loud.com/

Cc: Hou Tao <houtao@huaweicloud.com>
Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h  |  1 +
 include/linux/btf.h  |  2 +-
 kernel/bpf/btf.c     | 27 ++++++++++++++++++---------
 kernel/bpf/syscall.c | 12 +++++++++---
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c1a06263a4f3..cdeb0c95ec74 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -216,6 +216,7 @@ struct btf_field_graph_root {
 	u32 value_btf_id;
 	u32 node_offset;
 	struct btf_record *value_rec;
+	bool has_btf_ref;
 };
=20
 struct btf_field {
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 59d404e22814..f7d4f6594308 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -217,7 +217,7 @@ bool btf_member_is_reg_int(const struct btf *btf, con=
st struct btf_type *s,
 			   const struct btf_member *m,
 			   u32 expected_offset, u32 expected_size);
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct =
btf_type *t,
-				    u32 field_mask, u32 value_size);
+				    u32 field_mask, u32 value_size, bool from_map_check);
 int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record =
*rec);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 63cf4128fc05..f23d6a7b8b93 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3665,7 +3665,8 @@ static int btf_parse_graph_root(const struct btf *b=
tf,
 				struct btf_field *field,
 				struct btf_field_info *info,
 				const char *node_type_name,
-				size_t node_type_align)
+				size_t node_type_align,
+				bool from_map_check)
 {
 	const struct btf_type *t, *n =3D NULL;
 	const struct btf_member *member;
@@ -3696,6 +3697,9 @@ static int btf_parse_graph_root(const struct btf *b=
tf,
 		if (offset % node_type_align)
 			return -EINVAL;
=20
+		if (from_map_check)
+			btf_get((struct btf *)btf);
+		field->graph_root.has_btf_ref =3D from_map_check;
 		field->graph_root.btf =3D (struct btf *)btf;
 		field->graph_root.value_btf_id =3D info->graph_root.value_btf_id;
 		field->graph_root.node_offset =3D offset;
@@ -3706,17 +3710,19 @@ static int btf_parse_graph_root(const struct btf =
*btf,
 }
=20
 static int btf_parse_list_head(const struct btf *btf, struct btf_field *=
field,
-			       struct btf_field_info *info)
+			       struct btf_field_info *info, bool from_map_check)
 {
 	return btf_parse_graph_root(btf, field, info, "bpf_list_node",
-					    __alignof__(struct bpf_list_node));
+				    __alignof__(struct bpf_list_node),
+				    from_map_check);
 }
=20
 static int btf_parse_rb_root(const struct btf *btf, struct btf_field *fi=
eld,
-			     struct btf_field_info *info)
+			     struct btf_field_info *info, bool from_map_check)
 {
 	return btf_parse_graph_root(btf, field, info, "bpf_rb_node",
-					    __alignof__(struct bpf_rb_node));
+				    __alignof__(struct bpf_rb_node),
+				    from_map_check);
 }
=20
 static int btf_field_cmp(const void *_a, const void *_b, const void *pri=
v)
@@ -3732,7 +3738,7 @@ static int btf_field_cmp(const void *_a, const void=
 *_b, const void *priv)
 }
=20
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct =
btf_type *t,
-				    u32 field_mask, u32 value_size)
+				    u32 field_mask, u32 value_size, bool from_map_check)
 {
 	struct btf_field_info info_arr[BTF_FIELDS_MAX];
 	u32 next_off =3D 0, field_type_size;
@@ -3798,12 +3804,14 @@ struct btf_record *btf_parse_fields(const struct =
btf *btf, const struct btf_type
 				goto end;
 			break;
 		case BPF_LIST_HEAD:
-			ret =3D btf_parse_list_head(btf, &rec->fields[i], &info_arr[i]);
+			ret =3D btf_parse_list_head(btf, &rec->fields[i], &info_arr[i],
+						  from_map_check);
 			if (ret < 0)
 				goto end;
 			break;
 		case BPF_RB_ROOT:
-			ret =3D btf_parse_rb_root(btf, &rec->fields[i], &info_arr[i]);
+			ret =3D btf_parse_rb_root(btf, &rec->fields[i], &info_arr[i],
+						from_map_check);
 			if (ret < 0)
 				goto end;
 			break;
@@ -5390,7 +5398,8 @@ btf_parse_struct_metas(struct bpf_verifier_log *log=
, struct btf *btf)
 		type =3D &tab->types[tab->cnt];
 		type->btf_id =3D i;
 		record =3D btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BP=
F_LIST_NODE |
-						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT, t->size);
+						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT, t->size,
+					  false);
 		/* The record cannot be unset, treat it as an error if so */
 		if (IS_ERR_OR_NULL(record)) {
 			ret =3D PTR_ERR_OR_ZERO(record) ?: -EFAULT;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index aff045eed375..bdc81221baf7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -521,8 +521,11 @@ void btf_record_free(struct btf_record *rec)
 			btf_put(rec->fields[i].kptr.btf);
 			break;
 		case BPF_LIST_HEAD:
-		case BPF_LIST_NODE:
 		case BPF_RB_ROOT:
+			if (rec->fields[i].graph_root.has_btf_ref)
+				btf_put(rec->fields[i].graph_root.btf);
+			break;
+		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
@@ -570,8 +573,11 @@ struct btf_record *btf_record_dup(const struct btf_r=
ecord *rec)
 			}
 			break;
 		case BPF_LIST_HEAD:
-		case BPF_LIST_NODE:
 		case BPF_RB_ROOT:
+			if (fields[i].graph_root.has_btf_ref)
+				btf_get(fields[i].graph_root.btf);
+			break;
+		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
@@ -1034,7 +1040,7 @@ static int map_check_btf(struct bpf_map *map, struc=
t bpf_token *token,
 	map->record =3D btf_parse_fields(btf, value_type,
 				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
 				       BPF_RB_ROOT | BPF_REFCOUNT,
-				       map->value_size);
+				       map->value_size, true);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
=20
--=20
2.34.1


