Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7B5105338
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 14:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKUNg6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Nov 2019 08:36:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20558 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726909AbfKUNg5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Nov 2019 08:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574343416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=T0YAho8ovkb/PlkbPBwY0LYzrZ0n09K1u00ElUu6OKI=;
        b=XcId0+8Gl2SC1ylQGAu7X8NvKWj1Ab4CIQK1aSpSNc4i4cythVAjFvSaUuro+9uJEkvbCX
        5qoag9YhyX3rVQ8+BfhH8tQMkIauzunGLbwOwXwim+2AmRtHCE3WaZLmLo4YBJs7QhoRBq
        7pbLGEhUwlxlhTjB7sdVCdDcTOaa1rU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-QuwfzRO2PpOaYZb1vgx-Wg-1; Thu, 21 Nov 2019 08:36:54 -0500
Received: by mail-lf1-f69.google.com with SMTP id z16so915855lfb.23
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2019 05:36:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlIC/b1giwSwqqQUPzyiHxh9dWSPbqR4Tu/GbyQJz4M=;
        b=ZdLFkU9X7Skq4SwP1A06i9KZ7JTlfUT0KgQj0pNytv2mpTCmqZEAgPa5tYVs4xyZXr
         YEjgEVOYKkYC6sn6g2JanBf1Yy9ytplCnQaXn5k+aqoe/ETwj1eghNNlPsBfe9djHVSY
         fUUA9EBu5aXec+8+42qjslmBfcQltSZp1QAvfQzxx411L1CE49lCRXPwrgMD+uyqvdGB
         4WDO6RHp0DHKop5R3qms6yW7EoFgFHWWSno8hHTcLjOnvl8Ewb2C5shrqMEweusK6e/o
         TOYtpYMwQnSZsCLHJ2+FmSXEey50HHr7S/t1/4cgLapdcidBuF336PkU8X4PpnqrVSae
         GFJQ==
X-Gm-Message-State: APjAAAUcgmiT+wI55n26nBxXMbDx6p8MfQNcgPtNk2KzGMJ+TvRXd5hP
        VoZKY3wcdlPNX40asB8f92Bq5e5FQMiskM7A0DvFm7UqqskMPYVu7s7q1em6UX6eBaF061xUKJY
        +hac+Ht64U5Au
X-Received: by 2002:a2e:884c:: with SMTP id z12mr7323690ljj.41.1574343413403;
        Thu, 21 Nov 2019 05:36:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6NJ/ZOHh4Avu4g02fkv/c5HzBEVndfm8MiwSBuXyWAVd86IP3MMeCdcWu8YmQCcIHAfq7zg==
X-Received: by 2002:a2e:884c:: with SMTP id z12mr7323661ljj.41.1574343413096;
        Thu, 21 Nov 2019 05:36:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id d19sm1431185lfb.14.2019.11.21.05.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 05:36:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E6D3A1818BA; Thu, 21 Nov 2019 14:36:50 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] xdp: Fix cleanup on map free for devmap_hash map type
Date:   Thu, 21 Nov 2019 14:36:12 +0100
Message-Id: <20191121133612.430414-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-MC-Unique: QuwfzRO2PpOaYZb1vgx-Wg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tetsuo pointed out that it was not only the device unregister hook that was
broken for devmap_hash types, it was also cleanup on map free. So better
fix this as well.

While we're add it, there's no reason to allocate the netdev_map array for
DEVMAP_HASH, so skip that and adjust the cost accordingly.

Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices =
by hashed index")
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 kernel/bpf/devmap.c | 74 ++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 3867864cdc2f..3d3d61b5985b 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -74,7 +74,7 @@ struct bpf_dtab_netdev {
=20
 struct bpf_dtab {
 =09struct bpf_map map;
-=09struct bpf_dtab_netdev **netdev_map;
+=09struct bpf_dtab_netdev **netdev_map; /* DEVMAP type only */
 =09struct list_head __percpu *flush_list;
 =09struct list_head list;
=20
@@ -101,6 +101,12 @@ static struct hlist_head *dev_map_create_hash(unsigned=
 int entries)
 =09return hash;
 }
=20
+static inline struct hlist_head *dev_map_index_hash(struct bpf_dtab *dtab,
+=09=09=09=09=09=09    int idx)
+{
+=09return &dtab->dev_index_head[idx & (dtab->n_buckets - 1)];
+}
+
 static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 {
 =09int err, cpu;
@@ -120,8 +126,7 @@ static int dev_map_init_map(struct bpf_dtab *dtab, unio=
n bpf_attr *attr)
 =09bpf_map_init_from_attr(&dtab->map, attr);
=20
 =09/* make sure page count doesn't overflow */
-=09cost =3D (u64) dtab->map.max_entries * sizeof(struct bpf_dtab_netdev *)=
;
-=09cost +=3D sizeof(struct list_head) * num_possible_cpus();
+=09cost =3D (u64) sizeof(struct list_head) * num_possible_cpus();
=20
 =09if (attr->map_type =3D=3D BPF_MAP_TYPE_DEVMAP_HASH) {
 =09=09dtab->n_buckets =3D roundup_pow_of_two(dtab->map.max_entries);
@@ -129,6 +134,8 @@ static int dev_map_init_map(struct bpf_dtab *dtab, unio=
n bpf_attr *attr)
 =09=09if (!dtab->n_buckets) /* Overflow check */
 =09=09=09return -EINVAL;
 =09=09cost +=3D (u64) sizeof(struct hlist_head) * dtab->n_buckets;
+=09} else {
+=09=09cost +=3D (u64) dtab->map.max_entries * sizeof(struct bpf_dtab_netde=
v *);
 =09}
=20
 =09/* if map size is larger than memlock limit, reject it */
@@ -143,24 +150,22 @@ static int dev_map_init_map(struct bpf_dtab *dtab, un=
ion bpf_attr *attr)
 =09for_each_possible_cpu(cpu)
 =09=09INIT_LIST_HEAD(per_cpu_ptr(dtab->flush_list, cpu));
=20
-=09dtab->netdev_map =3D bpf_map_area_alloc(dtab->map.max_entries *
-=09=09=09=09=09      sizeof(struct bpf_dtab_netdev *),
-=09=09=09=09=09      dtab->map.numa_node);
-=09if (!dtab->netdev_map)
-=09=09goto free_percpu;
-
 =09if (attr->map_type =3D=3D BPF_MAP_TYPE_DEVMAP_HASH) {
 =09=09dtab->dev_index_head =3D dev_map_create_hash(dtab->n_buckets);
 =09=09if (!dtab->dev_index_head)
-=09=09=09goto free_map_area;
+=09=09=09goto free_percpu;
=20
 =09=09spin_lock_init(&dtab->index_lock);
+=09} else {
+=09=09dtab->netdev_map =3D bpf_map_area_alloc(dtab->map.max_entries *
+=09=09=09=09=09=09      sizeof(struct bpf_dtab_netdev *),
+=09=09=09=09=09=09      dtab->map.numa_node);
+=09=09if (!dtab->netdev_map)
+=09=09=09goto free_percpu;
 =09}
=20
 =09return 0;
=20
-free_map_area:
-=09bpf_map_area_free(dtab->netdev_map);
 free_percpu:
 =09free_percpu(dtab->flush_list);
 free_charge:
@@ -228,21 +233,40 @@ static void dev_map_free(struct bpf_map *map)
 =09=09=09cond_resched();
 =09}
=20
-=09for (i =3D 0; i < dtab->map.max_entries; i++) {
-=09=09struct bpf_dtab_netdev *dev;
+=09if (dtab->map.map_type =3D=3D BPF_MAP_TYPE_DEVMAP_HASH) {
+=09=09for (i =3D 0; i < dtab->n_buckets; i++) {
+=09=09=09struct bpf_dtab_netdev *dev;
+=09=09=09struct hlist_head *head;
+=09=09=09struct hlist_node *next;
=20
-=09=09dev =3D dtab->netdev_map[i];
-=09=09if (!dev)
-=09=09=09continue;
+=09=09=09head =3D dev_map_index_hash(dtab, i);
=20
-=09=09free_percpu(dev->bulkq);
-=09=09dev_put(dev->dev);
-=09=09kfree(dev);
+=09=09=09hlist_for_each_entry_safe(dev, next, head, index_hlist) {
+=09=09=09=09hlist_del_rcu(&dev->index_hlist);
+=09=09=09=09free_percpu(dev->bulkq);
+=09=09=09=09dev_put(dev->dev);
+=09=09=09=09kfree(dev);
+=09=09=09}
+=09=09}
+
+=09=09kfree(dtab->dev_index_head);
+=09} else {
+=09=09for (i =3D 0; i < dtab->map.max_entries; i++) {
+=09=09=09struct bpf_dtab_netdev *dev;
+
+=09=09=09dev =3D dtab->netdev_map[i];
+=09=09=09if (!dev)
+=09=09=09=09continue;
+
+=09=09=09free_percpu(dev->bulkq);
+=09=09=09dev_put(dev->dev);
+=09=09=09kfree(dev);
+=09=09}
+
+=09=09bpf_map_area_free(dtab->netdev_map);
 =09}
=20
 =09free_percpu(dtab->flush_list);
-=09bpf_map_area_free(dtab->netdev_map);
-=09kfree(dtab->dev_index_head);
 =09kfree(dtab);
 }
=20
@@ -263,12 +287,6 @@ static int dev_map_get_next_key(struct bpf_map *map, v=
oid *key, void *next_key)
 =09return 0;
 }
=20
-static inline struct hlist_head *dev_map_index_hash(struct bpf_dtab *dtab,
-=09=09=09=09=09=09    int idx)
-{
-=09return &dtab->dev_index_head[idx & (dtab->n_buckets - 1)];
-}
-
 struct bpf_dtab_netdev *__dev_map_hash_lookup_elem(struct bpf_map *map, u3=
2 key)
 {
 =09struct bpf_dtab *dtab =3D container_of(map, struct bpf_dtab, map);
--=20
2.24.0

