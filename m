Return-Path: <bpf+bounces-13056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08A97D427C
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF291C20AA1
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 22:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D56D23772;
	Mon, 23 Oct 2023 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UhL8tO9z"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BD523762
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:00:46 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88EB10C
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:44 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39NJFO42005200
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Z+faWP6oK7/6QhihBJJT+lJRWWjGuctjgHBeVxZeeuM=;
 b=UhL8tO9z3cWKsyhmDtNX1EWEUgdnw3WvOaDweF2OGCLZXkIxtFHytUi8yFWaV/jC+XCi
 ZfozvORxSWodjb1jMP+a54Ij/c8JWGLMQK6Ie2vFr1e48LHJpG3bSuGJ0TkmhwwXgG57
 OzlVaj0n3a54DFrIgzw2OQrMaxvZ9eUvDHc= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3twrcgv1gm-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:00:43 -0700
Received: from twshared20079.02.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 23 Oct 2023 15:00:43 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id BF5712632D0BA; Mon, 23 Oct 2023 15:00:31 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 0/4] Descend into struct, array types when searching for fields
Date: Mon, 23 Oct 2023 15:00:26 -0700
Message-ID: <20231023220030.2556229-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Zd89nhBr0Z-WS2VhuGKBRVfvLgFVJ5Yk
X-Proofpoint-ORIG-GUID: Zd89nhBr0Z-WS2VhuGKBRVfvLgFVJ5Yk
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02

Consider the following BPF program:

  struct val {
    int d;
    struct some_kptr __kptr *ref_ptr;
  };

  struct array_map {
          __uint(type, BPF_MAP_TYPE_ARRAY);
          __type(key, int);
          __type(value, struct val);
          __uint(max_entries, 10);
  } array_map SEC(".maps");

  __hidden struct val global_array[25];

  void bpf_prog(void *ctx)
  {
    struct val *map_val;
    struct some_kptr *p;
    int idx =3D 0;

    map_val =3D bpf_map_lookup_elem(&array_map, &idx);
    if (!map_val) { /* omitted */ }
    p =3D acquire_some_kptr();
    if (!p) { /* omitted */ }

    bpf_kptr_xchg(&map_val->ref_ptr, p);
    bpf_kptr_xchg(&global_array[20].ref_ptr, p);
  }

One would expect both bpf_kptr_xchg's to be possible, but currently
only the first one works. From BPF program writer's perspective this
is unexpected - the array map is an array with struct val elements, so
is global_array, so why the difference in behavior? The confusion is
not hypothetical - we stumbled onto this confusing situation while
developing scheduling BPF programs for the sched_ext project [0].

The key difference is that libbpf-style global vars like global_array
are implemented as single-elem MAP_TYPE_ARRAYs with the value type
holding the vars. e.g. from the verifier's perspective, our global
vars have a value type like

  struct bss_map_value {
    struct var global_array[25];
  };

Note: In BTF it's actually a DATASEC with VARs instead of a STRUCT
with some members. For brevity's sake, when this series refers to the
toplevel type being searched for fields, 'struct' is shorthand for
{struct, datasec} and similarly 'struct members' for {struct members,
datasec vars}.

When creating a map, the verifier looks for special fields in the
value type. Currently, only the type's direct members are examined.
For example, struct val above has ref_ptr field with a special tag,
while bss_map_value's global_array field is has the uninteresting
BTF_KIND_ARRAY type. The verifier doesn't currently examine the
array's elem type - struct var - to look for special fields. The same
issue occurs when examining struct fields as well, e.g. if struct val
were instead:

  struct val2 {
    int d;
    struct some_kptr __kptr *ref_ptr;
  };

  struct val {
    int x;
    struct val2 v;
  };

then xchg'ing with array_map would look like

  bpf_kptr_xchg(&mapval->v.ref_ptr, p);

and would fail for the same reason: as far as verifier is concerned,
struct val doesn't have a kptr field at that offset.


This series adds logic to descend into aggregate types while searching
for special fields. The meat of said search logic occurs in
btf_find_field and its helpers. btf_find_field returns a list of
struct btf_field_info's with information about each field's properties
and location. If the search finds btf_field_infos while descending
into an aggregate type, they're "flattened" into the btf_field_info
list. "Flattening" here means that these two types will have the same
btf_field_info list:

  struct x {
    int a;
    struct some_kptr __kptr *inner[100];
  };

  struct y {
    int a;
    struct some_kptr __kptr *inner_1;
    struct some_kptr __kptr *inner_2;
    /* inner 3-99 snipped */
    struct some_kptr __kptr *inner_100;
  };

Namely, struct x's btf_find_field search will produce btf_field_info
list as if it were struct y. There's no indication of hierarchy or
nestedness in struct x's btf_field_info list, just (offset, type)
pairs as if struct x directly contained 100 kptrs.

Multi-dimensional arrays are supported as well e.g.

  struct z {
    int a;
    struct some_kptr __kptr *inner[10][10];
  }

will have the same btf_field_infos as struct y above.


This flattening approach allows us to find fields in nested aggregate
types without recreating the BTF type graph, which is something we
want to avoid. If we instead modified btf_find_field to return a
hierarchical representation of field info, we'd also have to add
functionality similar to btf_struct_walk to the query path for
btf_records. The goal of btf_record is to answer questions about
special fields more efficiently than walking BTF type graph, so
keeping things simple and flat is preferable.

Some field types expect to be in the same struct as another field,
which doesn't play well with a flattened btf_field_info list. Consider
this example:

  struct root_and_lock {
    struct bpf_rb_root r;
    struct bpf_spin_lock l;
  };

  __hidden struct root_and_lock global_array[10];

global_array's btf_field_infos and btf_record will indicate that it
has 10 bpf_spin_lock fields, which will cause btf_parse_fields to fail
and no btf_record to be associated with global_array. In the future we
can modify struct btf_field_info to explicitly tie a specific
bpf_spin_lock field to a bpf_rb_root.

For fields without such expectations, though, this series' approach
works. Our current usecase for this is to find nested kptrs only, so
nested struct digging is only enabled to look for kptr fields in this
series. We can also consider enabling digging for bpf_{rb,list}_node
fields.

  [0]: https://lore.kernel.org/bpf/20230711011412.100319-1-tj@kernel.org/

Dave Marchevsky (4):
  bpf: Fix btf_get_field_type to fail for multiple bpf_refcount fields
  bpf: Refactor btf_find_field with btf_field_info_search
  btf: Descend into structs and arrays during special field search
  selftests/bpf: Add tests exercising aggregate type BTF field search

 include/linux/bpf.h                           |   4 +-
 kernel/bpf/btf.c                              | 483 +++++++++++++-----
 .../selftests/bpf/prog_tests/array_kptr.c     |  12 +
 .../testing/selftests/bpf/progs/array_kptr.c  | 179 +++++++
 4 files changed, 550 insertions(+), 128 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/array_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/array_kptr.c

--=20
2.34.1

